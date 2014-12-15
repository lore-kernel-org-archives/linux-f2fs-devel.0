From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/7] f2fs: remove checking dirty_exceed
Date: Sun, 14 Dec 2014 23:27:32 -0800
Message-ID: <1418628458-82740-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We don't need to force to write dirty_exceeded for f2fs_balance_fs_bg.
This flag was only meaningful to write bypassing conditions.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f83326c..d6f073e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -57,8 +57,6 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 	} else if (type == INO_ENTRIES) {
 		int i;
 
-		if (sbi->sb->s_bdi->dirty_exceeded)
-			return false;
 		for (i = 0; i <= UPDATE_INO; i++)
 			mem_size += (sbi->im[i].ino_num *
 				sizeof(struct ino_entry)) >> PAGE_CACHE_SHIFT;
-- 
2.1.1
