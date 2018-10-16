From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: remove request_list check in is_idle()
Date: Tue, 16 Oct 2018 12:23:14 -0700
Message-ID: <20181016192314.GB29774@jaegeuk-macbookpro.roam.corp.google.com>
References: <d89936bb-398e-08c1-573f-b1bd54f3ca35@kernel.dk>
 <003df7ce-626c-e32b-909b-909b87e0c8f3@kernel.org>
 <5bbe6ae7-704e-dcaa-f798-959d8a1a00b3@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gCUw6-0004Id-Ny
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 19:23:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCUw5-002sab-2Y
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 19:23:22 +0000
Content-Disposition: inline
In-Reply-To: <5bbe6ae7-704e-dcaa-f798-959d8a1a00b3@kernel.dk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-f2fs-devel@lists.sourceforge.net

Thanks Jens,

On top of the patch killing the dead code, I wrote another one to detect
the idle time by the internal account logic like below. IMHO, it'd be
better to decouple f2fs with other layers, if possible.

Thanks,

>From 85daf5190671b3d98ef779bdea77b4a046658708 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 16 Oct 2018 10:20:53 -0700
Subject: [PATCH] f2fs: account read IOs and use IO counts for is_idle

This patch adds issued read IO counts which is under block layer.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c  | 24 ++++++++++++++++++++++--
 fs/f2fs/debug.c |  7 ++++++-
 fs/f2fs/f2fs.h  | 22 ++++++++++++++++------
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8952f2d610a6..5fdc8d751f19 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -52,6 +52,23 @@ static bool __is_cp_guaranteed(struct page *page)
 	return false;
 }
 
+static enum count_type __read_io_type(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+
+	if (mapping) {
+		struct inode *inode = mapping->host;
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+		if (inode->i_ino == F2FS_META_INO(sbi))
+			return F2FS_RD_META;
+
+		if (inode->i_ino == F2FS_NODE_INO(sbi))
+			return F2FS_RD_NODE;
+	}
+	return F2FS_RD_DATA;
+}
+
 /* postprocessing steps for read bios */
 enum bio_post_read_step {
 	STEP_INITIAL = 0,
@@ -82,6 +99,7 @@ static void __read_end_io(struct bio *bio)
 		} else {
 			SetPageUptodate(page);
 		}
+		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
 		unlock_page(page);
 	}
 	if (bio->bi_private)
@@ -464,8 +482,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 
 	__submit_bio(fio->sbi, bio, fio->type);
 
-	if (!is_read_io(fio->op))
-		inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
+	inc_page_count(fio->sbi, is_read_io(fio->op) ?
+			__read_io_type(page): WB_DATA_TYPE(fio->page));
 	return 0;
 }
 
@@ -595,6 +613,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	}
 	ClearPageError(page);
 	__submit_bio(F2FS_I_SB(inode), bio, DATA);
+	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 	return 0;
 }
 
@@ -1593,6 +1612,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
 			goto submit_and_realloc;
 
+		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 		ClearPageError(page);
 		last_block_in_bio = block_nr;
 		goto next_page;
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 026e10f30889..139b4d5c83d5 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -55,6 +55,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->max_vw_cnt = atomic_read(&sbi->max_vw_cnt);
 	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
 	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
+	si->nr_rd_data = get_pages(sbi, F2FS_RD_DATA);
+	si->nr_rd_node = get_pages(sbi, F2FS_RD_NODE);
+	si->nr_rd_meta = get_pages(sbi, F2FS_RD_META);
 	if (SM_I(sbi) && SM_I(sbi)->fcc_info) {
 		si->nr_flushed =
 			atomic_read(&SM_I(sbi)->fcc_info->issued_flush);
@@ -371,7 +374,9 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
 				si->ext_tree, si->zombie_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
-		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: (%4d %4d %4d), "
+		seq_printf(s, "  - IO_R (Data: %4d, Node: %4d, Meta: %4d\n",
+			   si->nr_rd_data, si->nr_rd_node, si->nr_rd_meta);
+		seq_printf(s, "  - IO_W (CP: %4d, Data: %4d, Flush: (%4d %4d %4d), "
 			"Discard: (%4d %4d)) cmd: %4d undiscard:%4u\n",
 			   si->nr_wb_cp_data, si->nr_wb_data,
 			   si->nr_flushing, si->nr_flushed,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 156e6cd2c812..5c80eca194b5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -950,6 +950,9 @@ enum count_type {
 	F2FS_DIRTY_IMETA,
 	F2FS_WB_CP_DATA,
 	F2FS_WB_DATA,
+	F2FS_RD_DATA,
+	F2FS_RD_NODE,
+	F2FS_RD_META,
 	NR_COUNT_TYPE,
 };
 
@@ -1392,11 +1395,6 @@ static inline unsigned int f2fs_time_to_wait(struct f2fs_sb_info *sbi,
 	return wait_ms;
 }
 
-static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
-{
-	return f2fs_time_over(sbi, type);
-}
-
 /*
  * Inline functions
  */
@@ -1787,7 +1785,9 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 	atomic_inc(&sbi->nr_pages[count_type]);
 
 	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES ||
-		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA)
+		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA ||
+		count_type == F2FS_RD_DATA || count_type == F2FS_RD_NODE ||
+		count_type == F2FS_RD_META)
 		return;
 
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
@@ -2124,6 +2124,15 @@ static inline struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi,
 	return bio_alloc(GFP_KERNEL, npages);
 }
 
+static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
+{
+	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
+		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
+		get_pages(sbi, F2FS_WB_CP_DATA))
+		return false;
+	return f2fs_time_over(sbi, type);
+}
+
 static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
 				unsigned long index, void *item)
 {
@@ -3116,6 +3125,7 @@ struct f2fs_stat_info {
 	int free_nids, avail_nids, alloc_nids;
 	int total_count, utilization;
 	int bg_gc, nr_wb_cp_data, nr_wb_data;
+	int nr_rd_data, nr_rd_node, nr_rd_meta;
 	unsigned int io_skip_bggc, other_skip_bggc;
 	int nr_flushing, nr_flushed, flush_list_empty;
 	int nr_discarding, nr_discarded;
-- 
2.19.0.605.g01d371f741-goog


On 10/16, Jens Axboe wrote:
> On 10/16/18 10:06 AM, Chao Yu wrote:
> > Hi Jens,
> > 
> > On 2018-10-16 22:34, Jens Axboe wrote:
> >> This doesn't work on stacked devices, and it doesn't work on
> >> blk-mq devices. The request_list is only used on legacy, which
> >> we don't have much of anymore, and soon won't have any of.
> >>
> >> Kill the check.
> > 
> > In order to avoid conflicting with user IO, GC and Discard thread try to be
> > aware of IO status of device by is_idle(), if previous implementation doesn't
> > work, do we have any other existing method to get such status? Or do you have
> > any suggestion on this?
> 
> This particular patch just kills code that won't yield any useful
> information on stacked devices or blk-mq. As those are the only
> ones that will exist shortly, it's dead.
> 
> For blk-mq, you could do a busy tag iteration. Something like this.
> That should be done separately though, in essence the existing code
> is dead/useless.
> 
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 4254e74c1446..823f04209e8c 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -403,6 +403,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>  	}
>  	blk_queue_exit(q);
>  }
> +EXPORT_SYMBOL_GPL(blk_mq_queue_tag_busy_iter);
>  
>  static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
>  		    bool round_robin, int node)
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 61deab0b5a5a..5af7ff94b400 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -33,8 +33,6 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>  					struct blk_mq_tags **tags,
>  					unsigned int depth, bool can_grow);
>  extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
> -void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
> -		void *priv);
>  
>  static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
>  						 struct blk_mq_hw_ctx *hctx)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 58778992eca4..c3a2a7fe3f88 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1347,18 +1347,6 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
>  	sbi->last_time[type] = jiffies;
>  }
>  
> -static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
> -{
> -	unsigned long interval = sbi->interval_time[type] * HZ;
> -
> -	return time_after(jiffies, sbi->last_time[type] + interval);
> -}
> -
> -static inline bool is_idle(struct f2fs_sb_info *sbi)
> -{
> -	return f2fs_time_over(sbi, REQ_TIME);
> -}
> -
>  /*
>   * Inline functions
>   */
> @@ -2948,6 +2936,7 @@ void f2fs_destroy_segment_manager_caches(void);
>  int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
>  enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>  			enum page_type type, enum temp_type temp);
> +bool f2fs_is_idle(struct f2fs_sb_info *sbi);
>  
>  /*
>   * checkpoint.c
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5c8d00422237..fb4152527cf1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -83,7 +83,7 @@ static int gc_thread_func(void *data)
>  		if (!mutex_trylock(&sbi->gc_mutex))
>  			goto next;
>  
> -		if (!is_idle(sbi)) {
> +		if (!f2fs_is_idle(sbi)) {
>  			increase_sleep_time(gc_th, &wait_ms);
>  			mutex_unlock(&sbi->gc_mutex);
>  			goto next;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 30779aaa9dba..a02c5ecfb2e4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -11,7 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/f2fs_fs.h>
>  #include <linux/bio.h>
> -#include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/prefetch.h>
>  #include <linux/kthread.h>
>  #include <linux/swap.h>
> @@ -33,6 +33,37 @@ static struct kmem_cache *discard_cmd_slab;
>  static struct kmem_cache *sit_entry_set_slab;
>  static struct kmem_cache *inmem_entry_slab;
>  
> +static bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
> +{
> +	unsigned long interval = sbi->interval_time[type] * HZ;
> +
> +	return time_after(jiffies, sbi->last_time[type] + interval);
> +}
> +
> +static void is_idle_fn(struct blk_mq_hw_ctx *hctx, struct request *req,
> +		       void *data, bool reserved)
> +{
> +	unsigned int *cnt = data;
> +
> +	(*cnt)++;
> +}
> +
> +bool f2fs_is_idle(struct f2fs_sb_info *sbi)
> +{
> +	struct block_device *bdev = sbi->sb->s_bdev;
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q->mq_ops) {
> +		unsigned int cnt = 0;
> +
> +		blk_mq_queue_tag_busy_iter(q, is_idle_fn, &cnt);
> +		if (cnt)
> +			return false;
> +	}
> +
> +	return f2fs_time_over(sbi, REQ_TIME);
> +}
> +
>  static unsigned long __reverse_ulong(unsigned char *str)
>  {
>  	unsigned long tmp = 0;
> @@ -511,7 +542,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  	else
>  		f2fs_build_free_nids(sbi, false, false);
>  
> -	if (!is_idle(sbi) &&
> +	if (!f2fs_is_idle(sbi) &&
>  		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
>  		return;
>  
> @@ -1311,7 +1342,7 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>  		if (dc->state != D_PREP)
>  			goto next;
>  
> -		if (dpolicy->io_aware && !is_idle(sbi)) {
> +		if (dpolicy->io_aware && !f2fs_is_idle(sbi)) {
>  			io_interrupted = true;
>  			break;
>  		}
> @@ -1371,7 +1402,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  			f2fs_bug_on(sbi, dc->state != D_PREP);
>  
>  			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
> -								!is_idle(sbi)) {
> +								!f2fs_is_idle(sbi)) {
>  				io_interrupted = true;
>  				break;
>  			}
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 2286dc12c6bc..095b086fb20e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -281,6 +281,8 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
>  void blk_mq_run_hw_queues(struct request_queue *q, bool async);
>  void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>  		busy_tag_iter_fn *fn, void *priv);
> +void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
> +		void *priv);
>  void blk_mq_freeze_queue(struct request_queue *q);
>  void blk_mq_unfreeze_queue(struct request_queue *q);
>  void blk_freeze_queue_start(struct request_queue *q);
> 
> -- 
> Jens Axboe
