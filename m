From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/7] f2fs: readahead cp payload pages when mount
Date: Fri, 11 Sep 2015 14:40:01 +0800
Message-ID: <00f401d0ec5c$cd807a80$68816f80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Readahead continuous payload pages in checkpoint area for better
performance.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c5a38e3..7c1b297 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -676,6 +676,9 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	if (cur_page == cp2)
 		cp_blk_no += 1 << le32_to_cpu(fsb->log_blocks_per_seg);
 
+	if (cp_blks > 2)
+		ra_meta_pages(sbi, cp_blk_no + 1, cp_blks - 1, META_CP);
+
 	for (i = 1; i < cp_blks; i++) {
 		void *sit_bitmap_ptr;
 		unsigned char *ckpt = (unsigned char *)sbi->ckpt;
-- 
2.4.2
