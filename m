From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid f2fs_bug_on during recovery
Date: Wed, 11 May 2016 10:01:09 -0700
Message-ID: <1462986069-19630-2-git-send-email-jaegeuk@kernel.org>
References: <1462986069-19630-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1462986069-19630-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We don't need to use f2fs_bug_on() to treat with any error case when allocating
a block during recovery.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 2b25329..6303b2a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -460,8 +460,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			truncate_data_blocks_range(&dn, 1);
-			err = reserve_new_block(&dn);
-			f2fs_bug_on(sbi, err);
+			reserve_new_block(&dn);
 			continue;
 		}
 
-- 
2.6.3

