From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs-tools: get rid of unneeded fields in
 on-disk inode
Date: Sun, 28 Apr 2019 17:17:37 +0800
Message-ID: <20190428091737.66286-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hKfwl-000281-66
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 09:18:07 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hKfwi-00FvAN-Qu
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 09:18:07 +0000
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
v2:
- fix wrong size returned from calc_extra_isize().
 fsck/dir.c         |  3 +--
 fsck/fsck.c        |  6 +++---
 fsck/segment.c     |  2 +-
 include/f2fs_fs.h  |  6 ++++--
 lib/libf2fs.c      | 16 ++++++++++++++++
 mkfs/f2fs_format.c |  9 +++------
 6 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 98a0b7a..d20c18c 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -459,8 +459,7 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		node_blk->i.i_inline |= F2FS_EXTRA_ATTR;
-		node_blk->i.i_extra_isize =
-				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		node_blk->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
 	}
 
 	node_blk->footer.ino = cpu_to_le32(de->ino);
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6fe1238..9f988c9 100644
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
index 4ce623f..98c836e 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -320,7 +320,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 			node_blk->i.i_inline |= F2FS_EXTRA_ATTR;
 			node_blk->i.i_extra_isize =
-				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+					cpu_to_le16(calc_extra_isize());
 		}
 		n = read(fd, buffer, BLOCK_SZ);
 		ASSERT((unsigned long)n == de->size);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index a77798c..2e8871c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -753,9 +753,10 @@ struct f2fs_extent {
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 #endif
 
+#define F2FS_EXTRA_ISIZE_OFFSET				\
+	offsetof(struct f2fs_inode, i_extra_isize)
 #define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
-	(offsetof(struct f2fs_inode, i_extra_end) -	\
-	offsetof(struct f2fs_inode, i_extra_isize))	\
+	(offsetof(struct f2fs_inode, i_extra_end) - F2FS_EXTRA_ISIZE_OFFSET)
 
 #define	F2FS_DEF_PROJID		0	/* default project ID */
 
@@ -1159,6 +1160,7 @@ extern int f2fs_devs_are_umounted(void);
 extern int f2fs_dev_is_writable(void);
 extern int f2fs_dev_is_umounted(char *);
 extern int f2fs_get_device_info(void);
+extern unsigned int calc_extra_isize(void);
 extern int get_device_info(int);
 extern int f2fs_init_sparse_file(void);
 extern int f2fs_finalize_device(void);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index fd8bd5f..2608f4d 100644
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
+	return size - F2FS_EXTRA_ISIZE_OFFSET;
+}
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index ed27700..bf4c6fe 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1114,8 +1114,7 @@ static int f2fs_write_root_inode(void)
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
-		raw_node->i.i_extra_isize =
-				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		raw_node->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
 	}
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
@@ -1271,8 +1270,7 @@ static int f2fs_write_qf_inode(int qtype)
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
-		raw_node->i.i_extra_isize =
-				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		raw_node->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
 	}
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
@@ -1474,8 +1472,7 @@ static int f2fs_write_lpf_inode(void)
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
-		raw_node->i.i_extra_isize =
-			cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		raw_node->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
 	}
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
-- 
2.18.0.rc1
