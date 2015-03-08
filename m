From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH v2] f2fs: fix max orphan inodes calculation
Date: Mon, 09 Mar 2015 08:37:07 +0900
Message-ID: <20150308233707.GA4450@lcm-devel.org>
References: <1425029893-24702-1-git-send-email-wanpeng.li@linux.intel.com>
 <20150303014022.GD6541@lcm-devel.org>
 <012301d057bf$029602e0$07c208a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <012301d057bf$029602e0$07c208a0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


--> 8 --

>From ce2462523dd5940b59f770c09a50d4babff5fcdb Mon Sep 17 00:00:00 2001
From: Changman Lee <cm224.lee@samsung.com>
Date: Mon, 9 Mar 2015 08:07:04 +0900
Subject: [PATCH] f2fs: cleanup statement about max orphan inodes calc

Through each macro, we can read the meaning easily.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 53bc328..384bfc4 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1104,13 +1104,6 @@ void init_ino_entry_info(struct f2fs_sb_info *sbi)
 		im->ino_num = 0;
 	}
 
-	/*
-	 * considering 512 blocks in a segment 8+cp_payload blocks are
-	 * needed for cp and log segment summaries. Remaining blocks are
-	 * used to keep orphan entries with the limitation one reserved
-	 * segment for cp pack we can have max 1020*(504-cp_payload)
-	 * orphan entries
-	 */
 	sbi->max_orphans = (sbi->blocks_per_seg - F2FS_CP_PACKS -
 			NR_CURSEG_TYPE - __cp_payload(sbi)) *
 				F2FS_ORPHANS_PER_BLOCK;
-- 
1.9.1

