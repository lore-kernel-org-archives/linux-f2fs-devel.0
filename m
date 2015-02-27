From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH] f2fs: don't need to collect dirty sit entries and flush journal when there's no dirty sit entries
Date: Fri, 27 Feb 2015 16:49:37 +0800
Message-ID: <1425026977-20893-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/segment.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index daee4ab..e7b83b6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1730,6 +1730,9 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	mutex_lock(&curseg->curseg_mutex);
 	mutex_lock(&sit_i->sentry_lock);
 
+	if (!sit_i->dirty_sentries)
+		goto out;
+
 	/*
 	 * add and account sit entries of dirty bitmap in sit entry
 	 * set temporarily
@@ -1744,9 +1747,6 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (!__has_cursum_space(sum, sit_i->dirty_sentries, SIT_JOURNAL))
 		remove_sits_in_journal(sbi);
 
-	if (!sit_i->dirty_sentries)
-		goto out;
-
 	/*
 	 * there are two steps to flush sit entries:
 	 * #1, flush sit entries to journal in current cold data summary block.
-- 
1.9.1
