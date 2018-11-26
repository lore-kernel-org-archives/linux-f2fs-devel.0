From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v3 1/2] f2fs: fix to allow node segment for GC by ioctl path
Date: Mon, 26 Nov 2018 13:31:41 +0530
Message-ID: <1543219302-12219-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Allow node type segments also to be GC'd via f2fs ioctl
F2FS_IOC_GARBAGE_COLLECT_RANGE.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v3:
seperate the trace print change from this patch

 fs/f2fs/gc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a07241f..d720551 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -323,8 +323,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	p.min_cost = get_max_cost(sbi, &p);
 
 	if (*result != NULL_SEGNO) {
-		if (IS_DATASEG(get_seg_entry(sbi, *result)->type) &&
-			get_valid_blocks(sbi, *result, false) &&
+		if (get_valid_blocks(sbi, *result, false) &&
 			!sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
 			p.min_segno = *result;
 		goto out;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
