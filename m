From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix writing incorrect orphan blocks
Date: Tue, 08 Oct 2013 10:28:00 +0900
Message-ID: <1381195680-30955-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, there was a erroneous scenario like below.
thread 1:                       thread 2:
 f2fs_unlink
  - acquire_orphan_inode
    : sbi->n_orphans++           write_checkpoint
                                 - block_operations
                                  : f2fs_lock_all
                                 - do_checkpoint
                                  : write orphan blocks with sbi->n_orphans
                                 - unblock_operations
  - f2fs_lock_op
  - release_orphan_inode
  - f2fs_unlock_op

During the checkpoint by thread 2, f2fs stores a wrong orphan block according
to the wrong sbi->n_orphans.
To avoid this, simply we should make cover acquire_orphan_inode too with
f2fs_lock_op.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 29f73fd..575adac 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -228,14 +228,14 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (!de)
 		goto fail;
 
+	f2fs_lock_op(sbi);
 	err = acquire_orphan_inode(sbi);
 	if (err) {
+		f2fs_unlock_op(sbi);
 		kunmap(page);
 		f2fs_put_page(page, 0);
 		goto fail;
 	}
-
-	f2fs_lock_op(sbi);
 	f2fs_delete_entry(de, page, inode);
 	f2fs_unlock_op(sbi);
 
-- 
1.8.4.474.g128a96c

