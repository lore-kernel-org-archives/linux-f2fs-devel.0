From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 4/4] f2fs: fix potential race between online resize path and gc path
Date: Tue,  9 Apr 2019 16:06:18 +0530
Message-ID: <1554806178-32728-4-git-send-email-stummala@codeaurora.org>
References: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Sahitya Tummala <stummala@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

NEW_MAIN_SECS() can be updated by f2fs_resize_from_end() path,
while get_victim_by_default() is running. Hence, protect all
references to NEW_MAIN_SECS() with seglist_lock mutex.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2077be9..d636721 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -311,10 +311,11 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	struct sit_info *sm = SIT_I(sbi);
 	struct victim_sel_policy p;
 	unsigned int secno, last_victim;
-	unsigned int last_segment = NEW_MAIN_SECS(sbi) * sbi->segs_per_sec;
+	unsigned int last_segment;
 	unsigned int nsearched = 0;
 
 	mutex_lock(&dirty_i->seglist_lock);
+	last_segment = NEW_MAIN_SECS(sbi) * sbi->segs_per_sec;
 
 	p.alloc_mode = alloc_mode;
 	select_policy(sbi, gc_type, type, &p);
@@ -1400,6 +1401,7 @@ int f2fs_resize_from_end(struct f2fs_sb_info *sbi, size_t resize_len)
 
 	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
 	NEW_MAIN_SECS(sbi) = MAIN_SECS(sbi) - secs;
+
 	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
 		if (SIT_I(sbi)->last_victim[gc_mode] >=
 					NEW_MAIN_SECS(sbi) * sbi->segs_per_sec)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
