From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: [f2fs-dev] [PATCH RFC v4] f2fs: flush cp pack except cp pack 2 page
 at first
Date: Wed, 31 Jan 2018 06:39:32 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCE500E@dggemi505-mbx.china.huawei.com>
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
an extreme scenario that cp pack 1 page and cp pack 2 page are updated
and latest, but payload or current summaries are still partially
outdated. (see reliable write in the UFS specification)

This patch submits the whole cp pack except cp pack 2 page at first,
and then writes the cp pack 2 page with an extra independent
bio with pre-io barrier.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
Change log from v3:
  - further review comments are applied from Jaegeuk and Chao
  - Tested on this patch (without multiple-device): mount, boot Android with f2fs userdata and make fragment
  - If any problem with this patch or I miss something, please kindly share your comments, thanks :)
Change log from v2:
  - Apply the review comments from Chao
Change log from v1:
  - Apply the review comments from Chao
  - time data from "finish block_ops" to " finish checkpoint" (tested on ARM64 with TOSHIBA 128GB UFS):
     Before patch: 0.002273  0.001973  0.002789  0.005159  0.002050
     After patch: 0.002502  0.001624  0.002487  0.003049  0.002696
 fs/f2fs/checkpoint.c | 67 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 14d2fed..916dc72 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1158,6 +1158,39 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	spin_unlock_irqrestore(&sbi->cp_lock, flags);
 }
 
+static void commit_checkpoint(struct f2fs_sb_info *sbi,
+	void *src, block_t blk_addr)
+{
+	struct writeback_control wbc = {
+		.for_reclaim = 0,
+	};
+
+	/*
+	 * pagevec_lookup_tag and lock_page again will take
+	 * some extra time. Therefore, update_meta_pages and
+	 * sync_meta_pages are combined in this function.
+	 */
+	struct page *page = grab_meta_page(sbi, blk_addr);
+	int err;
+
+	memcpy(page_address(page), src, PAGE_SIZE);
+	set_page_dirty(page);
+
+	f2fs_wait_on_page_writeback(page, META, true);
+	f2fs_bug_on(sbi, PageWriteback(page));
+	if (unlikely(!clear_page_dirty_for_io(page)))
+		f2fs_bug_on(sbi, 1);
+
+	/* writeout cp pack 2 page */
+	err = __f2fs_write_meta_page(page, &wbc, FS_CP_META_IO);
+	f2fs_bug_on(sbi, err);
+
+	f2fs_put_page(page, 0);
+
+	/* submit checkpoint (with barrier if NOBARRIER is not set) */
+	f2fs_submit_merged_write(sbi, META_FLUSH);
+}
+
 static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -1260,16 +1293,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		}
 	}
 
-	/* need to wait for end_io results */
-	wait_on_all_pages_writeback(sbi);
-	if (unlikely(f2fs_cp_error(sbi)))
-		return -EIO;
-
-	/* flush all device cache */
-	err = f2fs_flush_device_cache(sbi);
-	if (err)
-		return err;
-
 	/* write out checkpoint buffer at block 0 */
 	update_meta_page(sbi, ckpt, start_blk++);
 
@@ -1297,15 +1320,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		start_blk += NR_CURSEG_NODE_TYPE;
 	}
 
-	/* writeout checkpoint block */
-	update_meta_page(sbi, ckpt, start_blk);
-
-	/* wait for previous submitted node/meta pages writeback */
-	wait_on_all_pages_writeback(sbi);
-
-	if (unlikely(f2fs_cp_error(sbi)))
-		return -EIO;
-
 	filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LLONG_MAX);
 	filemap_fdatawait_range(META_MAPPING(sbi), 0, LLONG_MAX);
 
@@ -1313,12 +1327,23 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
 
-	/* Here, we only have one bio having CP pack */
-	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
+	/* Here, we have one bio having CP pack except cp pack 2 page */
+	sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+
+	/* flush all device cache */
+	err = f2fs_flush_device_cache(sbi);
+	if (err)
+		return err;
 
 	/* wait for previous submitted meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
 
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
+
+	/* barrier and flush checkpoint cp pack 2 page if it can */
+	commit_checkpoint(sbi, ckpt, start_blk);
+
 	release_ino_entry(sbi, false);
 
 	if (unlikely(f2fs_cp_error(sbi)))
-- 
2.1.4
