From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid ENOSPC fault in the recovery process
Date: Thu, 19 May 2016 12:00:53 -0700
Message-ID: <1463684453-77093-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch avoids impossible error injection, ENOSPC, during recovery process.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index f89b70e..3d7216d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -470,6 +470,10 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			if (src == NULL_ADDR) {
 				err = reserve_new_block(&dn);
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+				while (err)
+					err = reserve_new_block(&dn);
+#endif
 				/* We should not get -ENOSPC */
 				f2fs_bug_on(sbi, err);
 			}
-- 
2.6.3

