From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH RESEND 2/2] f2fs: disable preemption when waiting on all
 pages writeback
Date: Wed, 27 Apr 2016 11:09:15 -0700
Message-ID: <20160427180801.GA33099@jaegeuk.gateway>
References: <5720C19C.3000503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5720C19C.3000503@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Wed, Apr 27, 2016 at 09:41:48PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> The following condition can happen in a preemptible kernel, it may cause
> checkpointer hunging.
> 
> CPU0:					CPU1:
>  - write_checkpoint
>   - do_checkpoint
>    - wait_on_all_pages_writeback
> 					 - f2fs_write_end_io
> 					  - wake_up
> 					this is last writebacked page, but
> 					no sleeper in sbi->cp_wait wait
> 					queue, wake_up is not been called.
>     - prepare_to_wait(TASK_UNINTERRUPTIBLE)
>     Here, current task can been preempted,
>     but there will be no waker since last
>     write_end_io has bypassed wake_up. So
>     current task will sleep forever.
>     - io_schedule_timeout

Well, io_schedule_timeout should work for this?

Thanks,

> Now we use spinlock to create a critical section to guarantee preemption
> was disabled during racing in between wait_on_all_pages_writeback and
> f2fs_write_end_io, so that above condition can be avoided.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 14 +++++++++-----
>  fs/f2fs/data.c       |  9 +++++++--
>  fs/f2fs/f2fs.h       |  3 ++-
>  fs/f2fs/super.c      |  1 +
>  4 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index bf040b5..817cda7 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -914,15 +914,19 @@ static void wait_on_all_pages_writeback(struct
> f2fs_sb_info *sbi)
>  {
>  	DEFINE_WAIT(wait);
> 
> -	for (;;) {
> +	spin_lock(&sbi->cp_wb_lock);
> +
> +	while (get_pages(sbi, F2FS_WRITEBACK)) {
>  		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
> 
> -		if (!get_pages(sbi, F2FS_WRITEBACK))
> -			break;
> +		spin_unlock(&sbi->cp_wb_lock);
> +		io_schedule();
> +		spin_lock(&sbi->cp_wb_lock);
> 
> -		io_schedule_timeout(5*HZ);
> +		finish_wait(&sbi->cp_wait, &wait);
>  	}
> -	finish_wait(&sbi->cp_wait, &wait);
> +
> +	spin_unlock(&sbi->cp_wb_lock);
>  }
> 
>  static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 38ce5d6..8faeada 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -59,6 +59,7 @@ static void f2fs_write_end_io(struct bio *bio)
>  {
>  	struct f2fs_sb_info *sbi = bio->bi_private;
>  	struct bio_vec *bvec;
> +	unsigned long flags;
>  	int i;
> 
>  	bio_for_each_segment_all(bvec, bio, i) {
> @@ -74,8 +75,12 @@ static void f2fs_write_end_io(struct bio *bio)
>  		dec_page_count(sbi, F2FS_WRITEBACK);
>  	}
> 
> -	if (!get_pages(sbi, F2FS_WRITEBACK) && wq_has_sleeper(&sbi->cp_wait))
> -		wake_up(&sbi->cp_wait);
> +	if (!get_pages(sbi, F2FS_WRITEBACK)) {
> +		spin_lock_irqsave(&sbi->cp_wb_lock, flags);
> +		if (wq_has_sleeper(&sbi->cp_wait))
> +			wake_up(&sbi->cp_wait);
> +		spin_unlock_irqrestore(&sbi->cp_wb_lock, flags);
> +	}
> 
>  	bio_put(bio);
>  }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0786a45..cf646b3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -725,7 +725,8 @@ struct f2fs_sb_info {
>  	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
>  	struct rw_semaphore node_write;		/* locking node writes */
>  	struct mutex writepages;		/* mutex for writepages() */
> -	wait_queue_head_t cp_wait;
> +	wait_queue_head_t cp_wait;		/* for wait pages writeback */
> +	spinlock_t cp_wb_lock;			/* for protect cp_wait */
>  	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
>  	long interval_time[MAX_TIME];		/* to store thresholds */
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 19a85cf..8b25ac1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1436,6 +1436,7 @@ try_onemore:
> 
>  	init_rwsem(&sbi->cp_rwsem);
>  	init_waitqueue_head(&sbi->cp_wait);
> +	spin_lock_init(&sbi->cp_wb_lock);
>  	init_sb_info(sbi);
> 
>  	/* get an inode for meta space */
> -- 
> 2.7.2
