From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: get rid of unneeded fields in
 on-disk inode
Date: Wed, 24 Apr 2019 17:45:57 +0800
Message-ID: <20190424094557.117906-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hJETp-00024l-Ls
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 09:46:17 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJETn-00AfEk-F6
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 09:46:17 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

As Jaegeuk reminded:

Once user updates f2fs-tools which support new fields in inode layout,
but do keep the kernel which can not support those fields, it will cause
old f2fs fail to mount new image due to root_inode's i_extra_isize value
sanity check.

So if f2fs-tools doesn't enable feature which will use new fields of
inode, we don't need to expand i_extra_isize to include them, let's just
let i_extra_isize point to the end of last valid extra field's position.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dir.c         |  3 +--
 fsck/fsck.c        |  6 +++---
 fsck/segment.c     |  2 +-
 include/f2fs_fs.h  |  1 +
 lib/libf2fs.c      | 16 ++++++++++++++++
 mkfs/f2fs_format.c |  9 +++------
 6 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index f1665c4..592d9db 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -461,8 +461,7 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		node_blk->i.i_inline |= F2FS_EXTRA_ATTR;
-		node_blk->i.i_extra_isize =
-				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		node_blk->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
 	}
 
 	node_blk->footer.ino = cpu_to_le32(de->ino);
diff --git a/fsck/fsck.c b/fsck/fsck.c
index a1791d4..baec041 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -733,12 +733,12 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			if (node_blk->i.i_extra_isize >
 				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE)) {
 				FIX_MSG("ino[0x%x] recover i_extra_isize "
-					"from %u to %lu",
+					"from %u to %u",
 					nid,
 					le16_to_cpu(node_blk->i.i_extra_isize),
-					F2FS_TOTAL_EXTRA_ATTR_SIZE);
+					calc_extra_isize());
 				node_blk->i.i_extra_isize =
-					cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+					cpu_to_le16(calc_extra_isize());
 				need_fix = 1;
 			}
 		} else {
diff --git a/fsck/segment.c b/fsck/segment.c
index ba57a82..d1c569f 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -342,7 +342,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 			node_blk->i.i_inline |= F2FS_EXTRA_ATTR;
 			node_blk->i.i_extra_isize =
-				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+					cpu_to_le16(calc_extra_isize());
 		}
 		n = read(fd, buffer, BLOCK_SZ);
 		ASSERT((unsigned long)n == de->size);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 6def302..b766f7c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1158,6 +1158,7 @@ extern int f2fs_devs_are_umounted(void);
 extern int f2fs_dev_is_writable(void);
 extern int f2fs_dev_is_umounted(char *);
 extern int f2fs_get_device_info(void);
+extern unsigned int calc_extra_isize(void);
 extern int get_device_info(int);
 extern int f2fs_init_sparse_file(void);
 extern int f2fs_finalize_device(void);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index fd8bd5f..9a6a779 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -1191,3 +1191,19 @@ int f2fs_get_device_info(void)
 					(c.sector_size >> 9)) >> 11);
 	return 0;
 }
+
+unsigned int calc_extra_isize(void)
+{
+	unsigned int size = offsetof(struct f2fs_inode, i_projid);
+
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR))
+		size = offsetof(struct f2fs_inode, i_projid);
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA));
+		size = offsetof(struct f2fs_inode, i_inode_checksum);
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM));
+		size = offsetof(struct f2fs_inode, i_crtime);
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME));
+		size = offsetof(struct f2fs_inode, i_extra_end);
+
+	return size;
+}
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 2bf46ae..a0fb68f 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1132,8 +1132,7 @@ static int f2fs_write_root_inode(void)
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
-		raw_node->i.i_extra_isize =
-				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		raw_node->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
 	}
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
@@ -1289,8 +1288,7 @@ static int f2fs_write_qf_inode(int qtype)
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
-		raw_node->i.i_extra_isize =
-				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		raw_node->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
 	}
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
@@ -1492,8 +1490,7 @@ static int f2fs_write_lpf_inode(void)
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
-		raw_node->i.i_extra_isize =
-			cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		raw_node->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
 	}
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
-- 
2.18.0.rc1
