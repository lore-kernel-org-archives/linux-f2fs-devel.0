From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] fsck.f2fs: readahead node blocks to speed up
Date: Thu, 22 Jan 2015 16:48:52 -0800
Message-ID: <1421974132-18330-3-git-send-email-jaegeuk@kernel.org>
References: <1421974132-18330-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YESQu-0006Zl-A5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jan 2015 00:49:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YESQt-0000xp-5T for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jan 2015 00:49:08 +0000
In-Reply-To: <1421974132-18330-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds readahead system call to speed up node block reads.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 34 +++++++++++++++++++++++++++++++++-
 include/f2fs_fs.h |  1 +
 lib/libf2fs_io.c  | 14 ++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index a5f9adc..9d6fc42 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -451,6 +451,19 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		goto check;
 	}
 
+	/* readahead node blocks */
+	for (idx = 0; idx < 5; idx++) {
+		u32 nid = le32_to_cpu(node_blk->i.i_nid[idx]);
+
+		if (nid != 0) {
+			struct node_info ni;
+
+			get_node_info(sbi, nid, &ni);
+			if (IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
+				dev_reada_block(ni.blk_addr);
+		}
+	}
+
 	/* check data blocks in inode */
 	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i); idx++) {
 		if (le32_to_cpu(node_blk->i.i_addr[idx]) != 0) {
@@ -651,12 +664,31 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 	int dentries = 0;
 	u32 blk_cnt;
 	u8 *name;
-	u32 hash_code;
+	u32 hash_code, ino;
 	u16 name_len;;
 	int ret = 0;
 	int fixed = 0;
 	int i;
 
+	/* readahead inode blocks */
+	for (i = 0; i < max;) {
+		if (test_bit(i, bitmap) == 0) {
+			i++;
+			continue;
+		}
+		ino = le32_to_cpu(dentry[i].ino);
+
+		if (IS_VALID_NID(sbi, ino)) {
+			struct node_info ni;
+
+			get_node_info(sbi, ino, &ni);
+			if (IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
+				dev_reada_block(ni.blk_addr);
+		}
+		name_len = le16_to_cpu(dentry[i].name_len);
+		i += (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
+	}
+
 	for (i = 0; i < max;) {
 		if (test_bit(i, bitmap) == 0) {
 			i++;
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 4dc2426..8a9221c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -780,6 +780,7 @@ extern int dev_fill(void *, __u64, size_t);
 
 extern int dev_read_block(void *, __u64);
 extern int dev_read_blocks(void *, __u64, __u32 );
+extern int dev_reada_block(__u64);
 
 extern int dev_read_version(void *, __u64, size_t);
 extern void get_kernel_version(__u8 *);
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 6ed45fd..afa345f 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -46,6 +46,15 @@ int dev_read(void *buf, __u64 offset, size_t len)
 	return 0;
 }
 
+int dev_readahead(__u64 offset, size_t len)
+{
+#ifdef POSIX_FADV_WILLNEED
+	return posix_fadvise(config.fd, offset, len, POSIX_FADV_WILLNEED);
+#else
+	return 0;
+#endif
+}
+
 int dev_write(void *buf, __u64 offset, size_t len)
 {
 	if (lseek64(config.fd, (off64_t)offset, SEEK_SET) < 0)
@@ -91,6 +100,11 @@ int dev_read_blocks(void *buf, __u64 addr, __u32 nr_blks)
 	return dev_read(buf, addr * F2FS_BLKSIZE, nr_blks * F2FS_BLKSIZE);
 }
 
+int dev_reada_block(__u64 blk_addr)
+{
+	return dev_readahead(blk_addr * F2FS_BLKSIZE, F2FS_BLKSIZE);
+}
+
 void f2fs_finalize_device(struct f2fs_configuration *c)
 {
 	/*
-- 
2.1.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
