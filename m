From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: return wrong error number on f2fs_quota_write
Date: Mon, 31 Jul 2017 14:02:15 -0700
Message-ID: <20170731210215.3667-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This must return size, not error number.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a14143c947e3..fc757c8861b7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1122,7 +1122,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 	}
 
 	if (len == towrite)
-		return err;
+		return 0;
 	inode->i_version++;
 	inode->i_mtime = inode->i_ctime = current_time(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
-- 
2.13.0.rc1.294.g07d810a77f-goog
