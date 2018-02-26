From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: issue discard aggressively in the gc_urgent mode
Date: Mon, 26 Feb 2018 09:47:30 -0800
Message-ID: <20180226174731.26679-4-jaegeuk@kernel.org>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226174731.26679-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch avoids to skip discard commands when user sets gc_urgent mode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5e5e2936a26a..bda2ad048ea0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1727,7 +1727,7 @@ void init_discard_policy(struct discard_policy *dpolicy,
 	} else if (discard_type == DPOLICY_FORCE) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
-		dpolicy->io_aware = true;
+		dpolicy->io_aware = false;
 	} else if (discard_type == DPOLICY_FSTRIM) {
 		dpolicy->io_aware = false;
 	} else if (discard_type == DPOLICY_UMOUNT) {
-- 
2.15.0.531.g2ccb3012c9-goog
