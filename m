From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: [f2fs-dev] [PATCH RFC v2] f2fs: flush cp pack except cp page2 at
 first
Date: Thu, 25 Jan 2018 07:05:11 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCD2DE9@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Language: zh-CN
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>, hutj <hutj@huawei.com>, "Duwei (Device OS)" <weidu.du@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we attempt to flush the whole cp pack in a single bio,
however, when suddenly powering off at this time, we could get into
an extreme scenario that cp page1 and cp page2 are updated and
latest, but payload or current summaries are still partially outdated.
(see reliable write in the UFS specification)

This patch submits the whole cp pack except cp page2 at first,
and then writes the cp page2 with an extra independent
bio with pre-io barrier.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
Change log from v1:
  - Apply the review comments from Chao
  - time data from "finish block_ops" to " finish checkpoint" (tested on ARM64 with TOSHIBA 128GB UFS):
     Before patch: 0.002273  0.001973  0.002789  0.005159  0.002050
     After patch: 0.002502  0.001624  0.002487  0.003049  0.002696
 fs/f2fs/checkpoint.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 14d2fed..70deb09 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -300,6 +300,36 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 	return 0;
 }
 
+static void commit_checkpoint_with_barrier(struct f2fs_sb_info *sbi,
+	void *src, block_t blk_addr)
+{
+	struct writeback_control wbc = {
+		.for_reclaim = 0,
+	};
+	struct page *page = grab_meta_page(sbi, blk_addr);
+	int err;
+
+	memcpy(page_address(page), src, PAGE_SIZE);
+	set_page_dirty(page);
+
+	f2fs_wait_on_page_writeback(page, META, true);
+	BUG_ON(PageWriteback(page));
+	if (unlikely(!clear_page_dirty_for_io(page)))
+		BUG();
+
+	/* writeout cp page2 */
+	err = __f2fs_write_meta_page(page, &wbc, FS_CP_META_IO);
+	if (err) {
+		f2fs_put_page(page, 1);
+		f2fs_stop_checkpoint(sbi, false);
+		return;
+	}
+	f2fs_put_page(page, 0);
+
+	/* submit checkpoint with barrier */
+	f2fs_submit_merged_write(sbi, META_FLUSH);
+}
+
 long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				long nr_to_write, enum iostat_type io_type)
 {
@@ -1297,9 +1327,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		start_blk += NR_CURSEG_NODE_TYPE;
 	}
 
-	/* writeout checkpoint block */
-	update_meta_page(sbi, ckpt, start_blk);
-
 	/* wait for previous submitted node/meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
 
@@ -1313,12 +1340,16 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
 
-	/* Here, we only have one bio having CP pack */
-	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
+	/* Here, we have one bio having CP pack except cp page2 */
+	sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 
 	/* wait for previous submitted meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
 
+	/* barrier and flush checkpoint cp page2 */
+	commit_checkpoint_with_barrier(sbi, ckpt, start_blk);
+	wait_on_all_pages_writeback(sbi);
+
 	release_ino_entry(sbi, false);
 
 	if (unlikely(f2fs_cp_error(sbi)))
-- 
2.1.4
