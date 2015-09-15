From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: no need to lock for update_inode_page all the time
Date: Tue, 15 Sep 2015 09:55:46 -0700
Message-ID: <1442336146-82492-2-git-send-email-jaegeuk@kernel.org>
References: <1442336146-82492-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442336146-82492-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As comment says, we don't need to call f2fs_lock_op in write_inode to prevent
from producing dirty node pages all the time.
That happens only when there is not enough free sections and we can avoid that
by calling balance_fs in prior to that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 35aae65..0fc4d02 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -296,16 +296,12 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		return 0;
 
 	/*
-	 * We need to lock here to prevent from producing dirty node pages
+	 * We need to balance fs here to prevent from producing dirty node pages
 	 * during the urgent cleaning time when runing out of free sections.
 	 */
-	f2fs_lock_op(sbi);
-	update_inode_page(inode);
-	f2fs_unlock_op(sbi);
-
-	if (wbc)
-		f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi);
 
+	update_inode_page(inode);
 	return 0;
 }
 
-- 
2.1.1
