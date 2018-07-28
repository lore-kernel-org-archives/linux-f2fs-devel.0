From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: fix to reset i_gc_failures offline
Date: Sat, 28 Jul 2018 18:41:35 +0800
Message-ID: <20180728104135.13055-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch synchronize f2fs_inode structure from kernel side, in
addition, it adds to check .i_gc_failures and do resetting in fsck.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dir.c         |  5 ++++-
 fsck/fsck.c        | 16 ++++++++++++++++
 include/f2fs_fs.h  |  8 +++++++-
 mkfs/f2fs_format.c |  2 +-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 567a4e9c9b83..98a0b7a89601 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -445,7 +445,10 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 	node_blk->i.i_ctime_nsec = 0;
 	node_blk->i.i_mtime_nsec = 0;
 	node_blk->i.i_generation = 0;
-	node_blk->i.i_current_depth = cpu_to_le32(1);
+	if (de->file_type == F2FS_FT_DIR)
+		node_blk->i.i_current_depth = cpu_to_le32(1);
+	else
+		node_blk->i.i_current_depth = cpu_to_le32(0);
 	node_blk->i.i_xattr_nid = 0;
 	node_blk->i.i_flags = 0;
 	node_blk->i.i_inline = F2FS_INLINE_XATTR;
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 20a569228516..d550403e3e10 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -662,6 +662,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	unsigned char *en;
 	u32 namelen;
 	unsigned int idx = 0;
+	unsigned short i_gc_failures;
 	int need_fix = 0;
 	int ret;
 
@@ -939,6 +940,21 @@ skip_blkcnt_fix:
 		}
 	}
 
+	i_gc_failures = le16_to_cpu(node_blk->i.i_gc_failures);
+	if (ftype == F2FS_FT_REG_FILE && i_gc_failures) {
+
+		DBG(1, "Regular Inode: 0x%x [%s] depth: %d\n\n",
+				le32_to_cpu(node_blk->footer.ino), en,
+				i_gc_failures);
+
+		if (c.fix_on) {
+			node_blk->i.i_gc_failures = cpu_to_le16(0);
+			need_fix = 1;
+			FIX_MSG("Regular: 0x%x reset i_gc_failures from 0x%x to 0x00",
+					nid, i_gc_failures);
+		}
+	}
+
 	free(en);
 
 	if (ftype == F2FS_FT_SYMLINK && i_blocks && i_size == 0) {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index fe1e31ba1a46..53fa002c5520 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -788,7 +788,13 @@ struct f2fs_inode {
 	__le32 i_ctime_nsec;		/* change time in nano scale */
 	__le32 i_mtime_nsec;		/* modification time in nano scale */
 	__le32 i_generation;		/* file version (for NFS) */
-	__le32 i_current_depth;		/* only for directory depth */
+	union {
+		__le32 i_current_depth;	/* only for directory depth */
+		__le16 i_gc_failures;	/*
+					 * # of gc failures on pinned file.
+					 * only for regular files.
+					 */
+	};
 	__le32 i_xattr_nid;		/* nid to save xattr */
 	__le32 i_flags;			/* file attributes */
 	__le32 i_pino;			/* parent inode number */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index f2880eb06460..01a73e858d73 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1251,7 +1251,7 @@ static int f2fs_write_qf_inode(int qtype)
 	raw_node->i.i_generation = 0;
 	raw_node->i.i_xattr_nid = 0;
 	raw_node->i.i_flags = FS_IMMUTABLE_FL;
-	raw_node->i.i_current_depth = cpu_to_le32(1);
+	raw_node->i.i_current_depth = cpu_to_le32(0);
 	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
-- 
2.18.0.rc1
