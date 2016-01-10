From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: should unset atomic flag after successful commit
Date: Sat,  9 Jan 2016 17:10:01 -0800
Message-ID: <1452388201-26706-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If there is an error during commit, we should keep the flag in order to
abort it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index dfaed51..db0b2cb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1374,10 +1374,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		return ret;
 
 	if (f2fs_is_atomic_file(inode)) {
-		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 		ret = commit_inmem_pages(inode, false);
 		if (ret)
 			goto err_out;
+		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 	}
 
 	ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
-- 
2.6.3
