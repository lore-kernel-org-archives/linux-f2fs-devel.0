From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 3/4] f2fs: fix race between online resize path and allocate new data block path
Date: Tue,  9 Apr 2019 16:06:17 +0530
Message-ID: <1554806178-32728-3-git-send-email-stummala@codeaurora.org>
References: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Sahitya Tummala <stummala@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

There can be a potential race between allocate_segment_for_resize() and
allocate_data_block(), resulting into two issues -

1. The allocate_data_block() can get a data block from a segment which
is currently being resized. This results in data being updated in an
outdated or already resized segment.

2. It also results into these warnings from get_new_segment():
f2fs_bug_on(sbi, secno >= NEW_MAIN_SECS(sbi));

Fix these by using curseg_mutex lock in the resize context to prevent
race with allocate_data_block() path.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1c3cc30..e7c411f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2643,12 +2643,14 @@ void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type)
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int old_segno = curseg->segno;
 
+	mutex_lock(&curseg->curseg_mutex);
 	if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))
 		change_curseg(sbi, type);
 	else
 		new_curseg(sbi, type, true);
 
 	stat_inc_seg_type(sbi, curseg);
+	mutex_unlock(&curseg->curseg_mutex);
 
 	if (get_valid_blocks(sbi, old_segno, false) == 0)
 		__set_test_and_free(sbi, old_segno);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
