From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/12] f2fs: introduce f2fs_i_blocks_write with mark_inode_dirty_sync
Date: Tue, 24 May 2016 17:03:29 -0700
Message-ID: <1464134619-37015-3-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces f2fs_i_blocks_write() to call mark_inode_dirty_sync() when
changing inode->i_blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c |  1 -
 fs/f2fs/f2fs.h | 17 +++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0dd42b6..6a4c60c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -344,7 +344,6 @@ int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 	if (set_page_dirty(dn->node_page))
 		dn->node_changed = true;
 
-	mark_inode_dirty(dn->inode);
 	sync_inode_page(dn);
 	return 0;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6a5f38b..d07ae09 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1119,6 +1119,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
+static inline void f2fs_i_blocks_write(struct inode *, blkcnt_t, bool);
 static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
 {
@@ -1141,7 +1142,7 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 		}
 	}
 	/* *count can be recalculated */
-	inode->i_blocks += *count;
+	f2fs_i_blocks_write(inode, *count, true);
 	sbi->total_valid_block_count =
 		sbi->total_valid_block_count + (block_t)(*count);
 	spin_unlock(&sbi->stat_lock);
@@ -1157,7 +1158,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->stat_lock);
 	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
 	f2fs_bug_on(sbi, inode->i_blocks < count);
-	inode->i_blocks -= count;
+	f2fs_i_blocks_write(inode, count, false);
 	sbi->total_valid_block_count -= (block_t)count;
 	spin_unlock(&sbi->stat_lock);
 }
@@ -1294,7 +1295,7 @@ static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
 	}
 
 	if (inode)
-		inode->i_blocks++;
+		f2fs_i_blocks_write(inode, 1, true);
 
 	sbi->total_valid_node_count++;
 	sbi->total_valid_block_count++;
@@ -1313,7 +1314,7 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, !sbi->total_valid_node_count);
 	f2fs_bug_on(sbi, !inode->i_blocks);
 
-	inode->i_blocks--;
+	f2fs_i_blocks_write(inode, 1, false);
 	sbi->total_valid_node_count--;
 	sbi->total_valid_block_count--;
 
@@ -1556,6 +1557,14 @@ static inline void set_acl_inode(struct inode *inode, umode_t mode)
 	set_inode_flag(inode, FI_ACL_MODE);
 }
 
+static inline void f2fs_i_blocks_write(struct inode *inode,
+					blkcnt_t diff, bool add)
+{
+	inode->i_blocks = add ? inode->i_blocks + diff :
+				inode->i_blocks - diff;
+	mark_inode_dirty_sync(inode);
+}
+
 static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 {
 	i_size_write(inode, i_size);
-- 
2.6.3
