From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid needless inode updates
Date: Fri,  1 Sep 2017 17:05:16 -0700
Message-ID: <20170902000516.21080-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If i_size wan't change at all, we don't need to write inode during fsync.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4b993961d81d..0d76b572484a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2267,11 +2267,11 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
 		return ret;
 	}
-	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER) ||
-			file_keep_isize(inode) ||
-			i_size_read(inode) & PAGE_MASK)
-		return false;
-	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
+	if (F2FS_I(inode)->last_disk_size == i_size_read(inode))
+		return true;
+
+	return is_inode_flag_set(inode, FI_AUTO_RECOVER) &&
+		!file_keep_isize(inode) && !(i_size_read(inode) & PAGE_MASK);
 }
 
 static inline int f2fs_readonly(struct super_block *sb)
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
