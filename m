From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/18] f2fs: avoid value overflow in showing current status
Date: Fri,  8 May 2015 21:20:36 -0700
Message-ID: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes overflow when do cat /sys/kernel/debug/f2fs/status.
If a section is relatively large, dist value can be overflowed.

Reported-by: Yossi Goldfill <ygoldfill@radianmemory.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index f50acbc..efbc83f 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -94,7 +94,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 static void update_sit_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
-	unsigned int blks_per_sec, hblks_per_sec, total_vblocks, bimodal, dist;
+	unsigned long long blks_per_sec, hblks_per_sec, total_vblocks;
+	unsigned long long bimodal, dist;
 	unsigned int segno, vblocks;
 	int ndirty = 0;
 
-- 
2.1.1
