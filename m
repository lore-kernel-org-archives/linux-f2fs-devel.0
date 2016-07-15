From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: disable extent_cache for fcollapse/finsert inodes
Date: Thu, 14 Jul 2016 17:46:26 -0700
Message-ID: <20160715004629.43143-2-jaegeuk@kernel.org>
References: <20160715004629.43143-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160715004629.43143-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This reduces the elapsed time to do xfstests/generic/017.

Before: 458 s
After:  390 s

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 13 +++++++++++++
 fs/f2fs/f2fs.h         |  1 +
 fs/f2fs/file.c         |  5 +++++
 3 files changed, 19 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 5b4b6d4..2b06d4f 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -631,6 +631,19 @@ unsigned int f2fs_destroy_extent_node(struct inode *inode)
 	return node_cnt;
 }
 
+void f2fs_drop_extent_tree(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+
+	set_inode_flag(inode, FI_NO_EXTENT);
+
+	write_lock(&et->lock);
+	__free_extent_tree(sbi, et);
+	__drop_largest_extent(inode, 0, UINT_MAX);
+	write_unlock(&et->lock);
+}
+
 void f2fs_destroy_extent_tree(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1190c04..2b8bf50 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2317,6 +2317,7 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *);
  */
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
 bool f2fs_init_extent_tree(struct inode *, struct f2fs_extent *);
+void f2fs_drop_extent_tree(struct inode *);
 unsigned int f2fs_destroy_extent_node(struct inode *);
 void f2fs_destroy_extent_tree(struct inode *);
 bool f2fs_lookup_extent_cache(struct inode *, pgoff_t, struct extent_info *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0d4f1dd..dd399b3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1083,6 +1083,9 @@ static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
 
 	f2fs_balance_fs(sbi, true);
 	f2fs_lock_op(sbi);
+
+	f2fs_drop_extent_tree(inode);
+
 	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
 	f2fs_unlock_op(sbi);
 	return ret;
@@ -1317,6 +1320,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		idx -= nr;
 
 		f2fs_lock_op(sbi);
+		f2fs_drop_extent_tree(inode);
+
 		ret = __exchange_data_block(inode, inode, idx,
 					idx + delta, nr, false);
 		f2fs_unlock_op(sbi);
-- 
2.8.3
