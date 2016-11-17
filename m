From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: fix wrong AUTO_RECOVER condition
Date: Thu, 17 Nov 2016 15:29:58 -0800
Message-ID: <20161117232958.10931-2-jaegeuk@kernel.org>
References: <20161117232958.10931-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161117232958.10931-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If i_size is not aligned to the f2fs's block size, we should not skip inode
update during fsync.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7b986c..68f4887 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1741,7 +1741,8 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
 		return ret;
 	}
-	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER))
+	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER) ||
+			i_size_read(inode) & PAGE_MASK)
 		return false;
 	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
 }
-- 
2.8.3
