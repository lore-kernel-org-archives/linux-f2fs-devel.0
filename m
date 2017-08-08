From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: introduce gc_urgent mode for background GC
Date: Tue, 8 Aug 2017 11:15:30 +0800
Message-ID: <65cc0869-654b-b074-2e53-e650bff0737e@huawei.com>
References: <20170808014222.31097-1-jaegeuk@kernel.org>
 <20170808014222.31097-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170808014222.31097-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/8/8 9:42, Jaegeuk Kim wrote:
> This patch adds a sysfs entry to control urgent mode for background GC.
> If this is set, background GC thread conducts GC with gc_urgent_sleep_time
> all the time.

Good idea.

If we want to add more gc policy, current approach is not friendly to be
extended, and sysfs nodes are also become more and more, it's not friendly to
user. So I'd like to suggest adding /sys/fs/f2fs/<disk>/gc_policy only, and
exposing original policy as normal_mode, and then introduce urgent_mode and
reuse gc_min_sleep_time as gc_urgent_sleep_time in this patch.

e.g.

enum gc_policy {
	GC_NORMAL,
	GC_URGENT,
};

If we want to turn on urgent_mode, we could:
echo 1 > /sys/fs/f2fs/<disk>/gc_policy
echo 1000 > /sys/fs/f2fs/<disk>/gc_min_sleep_time

How do you think?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 12 ++++++++++++
>  fs/f2fs/gc.c                            | 17 +++++++++++++++--
>  fs/f2fs/gc.h                            |  4 ++++
>  fs/f2fs/sysfs.c                         |  9 +++++++++
>  4 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index c579ce5e0ef5..11b7f4ebea7c 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -139,3 +139,15 @@ Date:		June 2017
>  Contact:	"Chao Yu" <yuchao0@huawei.com>
>  Description:
>  		 Controls current reserved blocks in system.
> +
> +What:		/sys/fs/f2fs/<disk>/gc_urgent
> +Date:		August 2017
> +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> +Description:
> +		 Do background GC agressively
> +
> +What:		/sys/fs/f2fs/<disk>/gc_urgent_sleep_time
> +Date:		August 2017
> +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> +Description:
> +		 Controls sleep time of GC urgent mode
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 620dca443b29..8da7c14a9d29 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -35,9 +35,14 @@ static int gc_thread_func(void *data)
>  	set_freezable();
>  	do {
>  		wait_event_interruptible_timeout(*wq,
> -				kthread_should_stop() || freezing(current),
> +				kthread_should_stop() || freezing(current) ||
> +				gc_th->gc_wake,
>  				msecs_to_jiffies(wait_ms));
>  
> +		/* give it a try one time */
> +		if (gc_th->gc_wake)
> +			gc_th->gc_wake = 0;
> +
>  		if (try_to_freeze())
>  			continue;
>  		if (kthread_should_stop())
> @@ -74,6 +79,11 @@ static int gc_thread_func(void *data)
>  		if (!mutex_trylock(&sbi->gc_mutex))
>  			goto next;
>  
> +		if (gc_th->gc_urgent) {
> +			wait_ms = gc_th->urgent_sleep_time;
> +			goto do_gc;
> +		}
> +
>  		if (!is_idle(sbi)) {
>  			increase_sleep_time(gc_th, &wait_ms);
>  			mutex_unlock(&sbi->gc_mutex);
> @@ -84,7 +94,7 @@ static int gc_thread_func(void *data)
>  			decrease_sleep_time(gc_th, &wait_ms);
>  		else
>  			increase_sleep_time(gc_th, &wait_ms);
> -
> +do_gc:
>  		stat_inc_bggc_count(sbi);
>  
>  		/* if return value is not zero, no victim was selected */
> @@ -115,11 +125,14 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
>  		goto out;
>  	}
>  
> +	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
>  	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
>  	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
>  	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
>  
>  	gc_th->gc_idle = 0;
> +	gc_th->gc_urgent = 0;
> +	gc_th->gc_wake= 0;
>  
>  	sbi->gc_thread = gc_th;
>  	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index a993967dcdb9..57a9000ce3af 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -13,6 +13,7 @@
>  						 * whether IO subsystem is idle
>  						 * or not
>  						 */
> +#define DEF_GC_THREAD_URGENT_SLEEP_TIME	500	/* 500 ms */
>  #define DEF_GC_THREAD_MIN_SLEEP_TIME	30000	/* milliseconds */
>  #define DEF_GC_THREAD_MAX_SLEEP_TIME	60000
>  #define DEF_GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
> @@ -27,12 +28,15 @@ struct f2fs_gc_kthread {
>  	wait_queue_head_t gc_wait_queue_head;
>  
>  	/* for gc sleep time */
> +	unsigned int urgent_sleep_time;
>  	unsigned int min_sleep_time;
>  	unsigned int max_sleep_time;
>  	unsigned int no_gc_sleep_time;
>  
>  	/* for changing gc mode */
>  	unsigned int gc_idle;
> +	unsigned int gc_urgent;
> +	unsigned int gc_wake;
>  };
>  
>  struct gc_inode_list {
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 4e5a95e9e666..b769a3d776de 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -161,6 +161,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>  
>  	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
>  		f2fs_reset_iostat(sbi);
> +	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && sbi->gc_thread) {
> +		sbi->gc_thread->gc_wake = 1;
> +		wake_up_interruptible_all(&sbi->gc_thread->gc_wait_queue_head);
> +	}
>  
>  	return count;
>  }
> @@ -240,10 +244,13 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
>  	.id	= _id,						\
>  }
>  
> +F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent_sleep_time,
> +							urgent_sleep_time);
>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
> +F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent, gc_urgent);
>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
> @@ -281,10 +288,12 @@ F2FS_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);
>  
>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>  static struct attribute *f2fs_attrs[] = {
> +	ATTR_LIST(gc_urgent_sleep_time),
>  	ATTR_LIST(gc_min_sleep_time),
>  	ATTR_LIST(gc_max_sleep_time),
>  	ATTR_LIST(gc_no_gc_sleep_time),
>  	ATTR_LIST(gc_idle),
> +	ATTR_LIST(gc_urgent),
>  	ATTR_LIST(reclaim_segments),
>  	ATTR_LIST(max_small_discards),
>  	ATTR_LIST(discard_granularity),
> 
