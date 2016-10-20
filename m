From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: make clean inodes when flushing inode page
Date: Wed, 19 Oct 2016 19:26:28 -0700
Message-ID: <20161020022628.40059-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch tries to make more clean inodes when flushing dirty inodes in
checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/inode.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 157b7fd..8315b9d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -921,7 +921,7 @@ int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 		inode = igrab(&fi->vfs_inode);
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
 		if (inode) {
-			update_inode_page(inode);
+			sync_inode_metadata(inode, 0);
 			iput(inode);
 		}
 	};
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index bfa512d..7b5e402 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -339,7 +339,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 * We need to balance fs here to prevent from producing dirty node pages
 	 * during the urgent cleaning time when runing out of free sections.
 	 */
-	if (update_inode_page(inode))
+	if (update_inode_page(inode) && wbc && wbc->nr_to_write)
 		f2fs_balance_fs(sbi, true);
 	return 0;
 }
-- 
2.8.3
