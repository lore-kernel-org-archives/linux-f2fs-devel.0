From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v3 2/2] f2fs: adjust trace print in f2fs_get_victim() to cover all paths
Date: Mon, 26 Nov 2018 13:31:42 +0530
Message-ID: <1543219302-12219-2-git-send-email-stummala@codeaurora.org>
References: <1543219302-12219-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543219302-12219-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Adjust the trace print in f2fs_get_victim() to cover GC done by
F2FS_IOC_GARBAGE_COLLECT_RANGE.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d720551..e4689c6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -403,11 +403,12 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		}
 		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
 
+	}
+out:
+	if (p.min_segno != NULL_SEGNO)
 		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
 				sbi->cur_victim_sec,
 				prefree_segments(sbi), free_segments(sbi));
-	}
-out:
 	mutex_unlock(&dirty_i->seglist_lock);
 
 	return (p.min_segno == NULL_SEGNO) ? 0 : 1;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
