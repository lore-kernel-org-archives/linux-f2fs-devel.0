From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: remove request_list check in is_idle()
Date: Wed, 17 Oct 2018 09:08:39 +0800
Message-ID: <0d3ed432-ab6a-0e86-8fcf-400eb2e8ad33@huawei.com>
References: <d89936bb-398e-08c1-573f-b1bd54f3ca35@kernel.dk>
 <003df7ce-626c-e32b-909b-909b87e0c8f3@kernel.org>
 <5bbe6ae7-704e-dcaa-f798-959d8a1a00b3@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gCaKS-0003RN-TN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 01:08:52 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCaKQ-0032zr-Cz
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 01:08:52 +0000
In-Reply-To: <5bbe6ae7-704e-dcaa-f798-959d8a1a00b3@kernel.dk>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jens Axboe <axboe@kernel.dk>, Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2018/10/17 0:20, Jens Axboe wrote:
> On 10/16/18 10:06 AM, Chao Yu wrote:
>> Hi Jens,
>>
>> On 2018-10-16 22:34, Jens Axboe wrote:
>>> This doesn't work on stacked devices, and it doesn't work on
>>> blk-mq devices. The request_list is only used on legacy, which
>>> we don't have much of anymore, and soon won't have any of.
>>>
>>> Kill the check.
>>
>> In order to avoid conflicting with user IO, GC and Discard thread try to be
>> aware of IO status of device by is_idle(), if previous implementation doesn't
>> work, do we have any other existing method to get such status? Or do you have
>> any suggestion on this?
> 
> This particular patch just kills code that won't yield any useful
> information on stacked devices or blk-mq. As those are the only
> ones that will exist shortly, it's dead.

Yes, anyway, I'm okay with that change, please add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> 
> For blk-mq, you could do a busy tag iteration. Something like this.
> That should be done separately though, in essence the existing code
> is dead/useless.

Thanks for given code below, let's discuss this on Jaegeuk's patch. :)

Thanks,

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
