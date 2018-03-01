From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4/5] f2fs: issue discard aggressively in the gc_urgent
 mode
Date: Wed, 28 Feb 2018 18:37:20 -0800
Message-ID: <20180301023720.GA18665@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
 <20180226174731.26679-4-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180226174731.26679-4-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
- relax more to issue discard commands

This patch avoids to skip discard commands when user sets gc_urgent mode.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5e5e2936a26a..1e3dd3de4ecc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1411,12 +1411,11 @@ static int issue_discard_thread(void *data)
 		if (kthread_should_stop())
 			return 0;
 
-		if (dcc->discard_wake) {
+		if (dcc->discard_wake)
 			dcc->discard_wake = 0;
-			if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
-				init_discard_policy(&dpolicy,
-							DPOLICY_FORCE, 1);
-		}
+
+		if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
+			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
 
 		sb_start_intwrite(sbi->sb);
 
@@ -1727,7 +1726,7 @@ void init_discard_policy(struct discard_policy *dpolicy,
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
