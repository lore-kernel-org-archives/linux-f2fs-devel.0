From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/8] f2fs: rename {add,remove,release}_dirty_inode to
 {add,remove,release}_ino_entry
Date: Tue, 15 Dec 2015 13:29:47 +0800
Message-ID: <00f001d136f9$b478fe80$1d6afb80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

remove_dirty_dir_inode will be renamed to remove_dirty_inode as a generic
function in following patch for removing directory/regular/symlink inode
in global dirty list.

Here rename ino management related functions for readability, also in
order to avoid name conflict.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 8 ++++----
 fs/f2fs/f2fs.h       | 6 +++---
 fs/f2fs/file.c       | 4 ++--
 fs/f2fs/inode.c      | 4 ++--
 fs/f2fs/super.c      | 2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f661d80..b839f5f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -410,13 +410,13 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 	spin_unlock(&im->ino_lock);
 }
 
-void add_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
+void add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
 	/* add new dirty ino entry into list */
 	__add_ino_entry(sbi, ino, type);
 }
 
-void remove_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
+void remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
 	/* remove dirty ino entry from list */
 	__remove_ino_entry(sbi, ino, type);
@@ -434,7 +434,7 @@ bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
 	return e ? true : false;
 }
 
-void release_dirty_inode(struct f2fs_sb_info *sbi)
+void release_ino_entry(struct f2fs_sb_info *sbi)
 {
 	struct ino_entry *e, *tmp;
 	int i;
@@ -1081,7 +1081,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		invalidate_mapping_pages(META_MAPPING(sbi), discard_blk,
 								discard_blk);
 
-	release_dirty_inode(sbi);
+	release_ino_entry(sbi);
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d1587b..4be54e6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1820,9 +1820,9 @@ bool is_valid_blkaddr(struct f2fs_sb_info *, block_t, int);
 int ra_meta_pages(struct f2fs_sb_info *, block_t, int, int, bool);
 void ra_meta_pages_cond(struct f2fs_sb_info *, pgoff_t);
 long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);
-void add_dirty_inode(struct f2fs_sb_info *, nid_t, int type);
-void remove_dirty_inode(struct f2fs_sb_info *, nid_t, int type);
-void release_dirty_inode(struct f2fs_sb_info *);
+void add_ino_entry(struct f2fs_sb_info *, nid_t, int type);
+void remove_ino_entry(struct f2fs_sb_info *, nid_t, int type);
+void release_ino_entry(struct f2fs_sb_info *);
 bool exist_written_data(struct f2fs_sb_info *, nid_t, int);
 int acquire_orphan_inode(struct f2fs_sb_info *);
 void release_orphan_inode(struct f2fs_sb_info *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9949d0f..c6d909e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -275,10 +275,10 @@ sync_nodes:
 		goto out;
 
 	/* once recovery info is written, don't need to tack this */
-	remove_dirty_inode(sbi, ino, APPEND_INO);
+	remove_ino_entry(sbi, ino, APPEND_INO);
 	clear_inode_flag(fi, FI_APPEND_WRITE);
 flush_out:
-	remove_dirty_inode(sbi, ino, UPDATE_INO);
+	remove_ino_entry(sbi, ino, UPDATE_INO);
 	clear_inode_flag(fi, FI_UPDATE_WRITE);
 	ret = f2fs_issue_flush(sbi);
 out:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 97e20de..3d2fe59 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -357,9 +357,9 @@ no_delete:
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
 	if (is_inode_flag_set(fi, FI_APPEND_WRITE))
-		add_dirty_inode(sbi, inode->i_ino, APPEND_INO);
+		add_ino_entry(sbi, inode->i_ino, APPEND_INO);
 	if (is_inode_flag_set(fi, FI_UPDATE_WRITE))
-		add_dirty_inode(sbi, inode->i_ino, UPDATE_INO);
+		add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 	if (is_inode_flag_set(fi, FI_FREE_NID)) {
 		if (err && err != -ENOENT)
 			alloc_nid_done(sbi, inode->i_ino);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2b1a324..f7e9384 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -553,7 +553,7 @@ static void f2fs_put_super(struct super_block *sb)
 	 * normally superblock is clean, so we need to release this.
 	 * In addition, EIO will skip do checkpoint, we need this as well.
 	 */
-	release_dirty_inode(sbi);
+	release_ino_entry(sbi);
 	release_discard_addrs(sbi);
 
 	f2fs_leave_shrinker(sbi);
-- 
2.6.3
