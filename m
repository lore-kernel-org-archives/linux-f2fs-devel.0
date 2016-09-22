From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: should put_page for summary page
Date: Wed, 21 Sep 2016 20:54:56 -0700
Message-ID: <20160922035458.5002-2-jaegeuk@kernel.org>
References: <20160922035458.5002-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160922035458.5002-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should call put_page for preloaded summary pages in do_garbage_collect.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 400bc6d..a9a3c9f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -848,7 +848,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	for (segno = start_segno; segno < end_segno; segno++) {
 
 		if (get_valid_blocks(sbi, segno, 1) == 0)
-			continue;
+			goto next;
 
 		/* find segment summary of victim */
 		sum_page = find_get_page(META_MAPPING(sbi),
@@ -874,7 +874,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 								gc_type);
 
 		stat_inc_seg_count(sbi, type, gc_type);
-
+next:
 		f2fs_put_page(sum_page, 0);
 	}
 
-- 
2.8.3
