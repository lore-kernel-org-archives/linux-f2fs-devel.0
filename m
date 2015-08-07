From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/4] f2fs: handle error of f2fs_iget correctly
Date: Fri, 07 Aug 2015 18:41:02 +0800
Message-ID: <018001d0d0fd$a8f47240$fadd56c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In recover_orphan_inode, if f2fs_iget failed, we change to report the
error number to its caller instead of bug_on.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 25 ++++++++++++++++++-------
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/super.c      |  4 +++-
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c311176..e2def90 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -468,22 +468,28 @@ void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	__remove_ino_entry(sbi, ino, ORPHAN_INO);
 }
 
-static void recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
+static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	struct inode *inode = f2fs_iget(sbi->sb, ino);
-	f2fs_bug_on(sbi, IS_ERR(inode));
+	struct inode *inode;
+
+	inode = f2fs_iget(sbi->sb, ino);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
 	clear_nlink(inode);
 
 	/* truncate all the data during iput */
 	iput(inode);
+	return 0;
 }
 
-void recover_orphan_inodes(struct f2fs_sb_info *sbi)
+int recover_orphan_inodes(struct f2fs_sb_info *sbi)
 {
 	block_t start_blk, orphan_blocks, i, j;
+	int err;
 
 	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
-		return;
+		return 0;
 
 	set_sbi_flag(sbi, SBI_POR_DOING);
 
@@ -499,14 +505,19 @@ void recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		orphan_blk = (struct f2fs_orphan_block *)page_address(page);
 		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
-			recover_orphan_inode(sbi, ino);
+			err = recover_orphan_inode(sbi, ino);
+			if (err) {
+				f2fs_put_page(page, 1);
+				clear_sbi_flag(sbi, SBI_POR_DOING);
+				return err;
+			}
 		}
 		f2fs_put_page(page, 1);
 	}
 	/* clear Orphan Flag */
 	clear_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG);
 	clear_sbi_flag(sbi, SBI_POR_DOING);
-	return;
+	return 0;
 }
 
 static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 311960c..4a6f69b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1750,7 +1750,7 @@ int acquire_orphan_inode(struct f2fs_sb_info *);
 void release_orphan_inode(struct f2fs_sb_info *);
 void add_orphan_inode(struct f2fs_sb_info *, nid_t);
 void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
-void recover_orphan_inodes(struct f2fs_sb_info *);
+int recover_orphan_inodes(struct f2fs_sb_info *);
 int get_valid_checkpoint(struct f2fs_sb_info *);
 void update_dirty_page(struct inode *, struct page *);
 void add_dirty_dir_inode(struct inode *);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 12eb69d..e5efb53 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1246,7 +1246,9 @@ try_onemore:
 	f2fs_join_shrinker(sbi);
 
 	/* if there are nt orphan nodes free them */
-	recover_orphan_inodes(sbi);
+	err = recover_orphan_inodes(sbi);
+	if (err)
+		goto free_node_inode;
 
 	/* read root inode and dentry */
 	root = f2fs_iget(sb, F2FS_ROOT_INO(sbi));
-- 
2.4.2
