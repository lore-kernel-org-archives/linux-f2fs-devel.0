From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: recover date requested by fdatasync
Date: Fri, 05 Jul 2013 14:22:52 +0900
Message-ID: <1373001772-7013-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

In order to support SQLite that uses fdatasync instead of fsync, we should
guarantee the data requested by fdatasync can be recovered after sudden-power-
off.

So, let's remove the fdatasync condition in f2fs_sync_file.
Otherwise, we can restore the data after sudden-power-off due to nonexistence
of any fsync mark'ed node blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d2d2b7d..157a635 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -147,9 +147,10 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	mutex_lock(&inode->i_mutex);
 
-	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
-		goto out;
-
+	/*
+	 * Both of fdatasync() and fsync() are able to be recovered from
+	 * sudden-power-off.
+	 */
 	if (!S_ISREG(inode->i_mode) || inode->i_nlink != 1)
 		need_cp = true;
 	else if (file_wrong_pino(inode))
-- 
1.8.3.1.437.g0dbd812
