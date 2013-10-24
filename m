From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: remove redundant set_page_dirty from
 write_compacted_summaries
Date: Thu, 24 Oct 2013 15:08:28 +0800
Message-ID: <000201ced087$f5433d70$dfc9b850$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?utf-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, set_page_dirty is called every time after writting one summary info into compacted summary page,
To avoid redundant set_page_dirty, we only call set_page_dirty before release page.

Signed-off-by: Yu Chao <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3b20359..bdd53d0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1128,8 +1128,6 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 						SUM_JOURNAL_SIZE);
 	written_size += SUM_JOURNAL_SIZE;
 
-	set_page_dirty(page);
-
 	/* Step 3: write summary entries */
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
 		unsigned short blkoff;
@@ -1148,18 +1146,20 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 			summary = (struct f2fs_summary *)(kaddr + written_size);
 			*summary = seg_i->sum_blk->entries[j];
 			written_size += SUMMARY_SIZE;
-			set_page_dirty(page);
 
 			if (written_size + SUMMARY_SIZE <= PAGE_CACHE_SIZE -
 							SUM_FOOTER_SIZE)
 				continue;
 
+			set_page_dirty(page);
 			f2fs_put_page(page, 1);
 			page = NULL;
 		}
 	}
-	if (page)
+	if (page) {
+		set_page_dirty(page);
 		f2fs_put_page(page, 1);
+	}
 }
 
 static void write_normal_summaries(struct f2fs_sb_info *sbi,
-- 
1.7.9.5
