From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/6] f2fs: wrap discard policy
Date: Wed, 27 Sep 2017 17:57:39 +0800
Message-ID: <fa228fd3-99df-b0e3-8b2a-083af0d2c931@huawei.com>
References: <20170919153016.4116-1-chao@kernel.org>
 <20170919153016.4116-2-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919153016.4116-2-chao@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

Any comments on other patches in this patchset?

Thanks,

On 2017/9/19 23:30, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> This patch wraps scattered optional parameters into discard policy as
> below, later, with it we expect that we can adjust these parameters with
> proper strategy in different scenario.
> 
> struct discard_policy {
> 	unsigned int min_interval;	/* used for candidates exist */
> 	unsigned int max_interval;	/* used for candidates not exist */
> 	unsigned int max_requests;	/* # of discards issued per round */
> 	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
> 	bool io_aware;			/* issue discard in idle time */
> 	bool sync;			/* submit discard with REQ_SYNC flag */
> };
> 
> This patch doesn't change any logic of codes.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h    | 12 +++++++++++-
>  fs/f2fs/segment.c | 38 +++++++++++++++++++++++++++++---------
>  2 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index cb13c7df6971..b119104e75bd 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -149,7 +149,7 @@ enum {
>  #define BATCHED_TRIM_BLOCKS(sbi)	\
>  		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
>  #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
> -#define DISCARD_ISSUE_RATE		8
> +#define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
>  #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
>  #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
>  #define DEF_CP_INTERVAL			60	/* 60 secs */
> @@ -243,6 +243,15 @@ struct discard_cmd {
>  	int error;			/* bio error */
>  };
>  
> +struct discard_policy {
> +	unsigned int min_interval;	/* used for candidates exist */
> +	unsigned int max_interval;	/* used for candidates not exist */
> +	unsigned int max_requests;	/* # of discards issued per round */
> +	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
> +	bool io_aware;			/* issue discard in idle time */
> +	bool sync;			/* submit discard with REQ_SYNC flag */
> +};
> +
>  struct discard_cmd_control {
>  	struct task_struct *f2fs_issue_discard;	/* discard thread */
>  	struct list_head entry_list;		/* 4KB discard entry list */
> @@ -261,6 +270,7 @@ struct discard_cmd_control {
>  	atomic_t issing_discard;		/* # of issing discard */
>  	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
>  	struct rb_root root;			/* root of discard rb-tree */
> +	struct discard_policy dpolicy;		/* current discard policy */
>  };
>  
>  /* for the list of fsync inodes, used only during recovery */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 088936c61905..b3787ba1108f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -851,6 +851,7 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  	struct list_head *wait_list = fstrim ? &(dcc->fstrim_list) :
>  							&(dcc->wait_list);
>  	struct bio *bio = NULL;
> +	int flag = dcc->dpolicy.sync ? REQ_SYNC : 0;
>  
>  	if (dc->state != D_PREP)
>  		return;
> @@ -869,7 +870,7 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		if (bio) {
>  			bio->bi_private = dc;
>  			bio->bi_end_io = f2fs_submit_discard_endio;
> -			bio->bi_opf |= REQ_SYNC;
> +			bio->bi_opf |= flag;
>  			submit_bio(bio);
>  			list_move_tail(&dc->list, wait_list);
>  			__check_sit_bitmap(sbi, dc->start, dc->start + dc->len);
> @@ -1064,6 +1065,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
>  	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
>  	struct rb_node **insert_p = NULL, *insert_parent = NULL;
>  	struct discard_cmd *dc;
> +	struct discard_policy *dpolicy = &dcc->dpolicy;
>  	struct blk_plug plug;
>  	int issued;
>  
> @@ -1096,7 +1098,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
>  
>  		__submit_discard_cmd(sbi, dc, true);
>  
> -		if (++issued >= DISCARD_ISSUE_RATE) {
> +		if (++issued >= dpolicy->max_requests) {
>  			start = dc->lstart + dc->len;
>  
>  			blk_finish_plug(&plug);
> @@ -1124,6 +1126,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
>  	struct list_head *pend_list;
>  	struct discard_cmd *dc, *tmp;
>  	struct blk_plug plug;
> +	struct discard_policy *dpolicy = &dcc->dpolicy;
>  	int iter = 0, issued = 0;
>  	int i;
>  	bool io_interrupted = false;
> @@ -1151,14 +1154,16 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
>  				continue;
>  			}
>  
> -			if (is_idle(sbi)) {
> -				__submit_discard_cmd(sbi, dc, false);
> -				issued++;
> -			} else {
> +			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
> +								!is_idle(sbi)) {
>  				io_interrupted = true;
> +				goto skip;
>  			}
>  
> -			if (++iter >= DISCARD_ISSUE_RATE)
> +			__submit_discard_cmd(sbi, dc, false);
> +			issued++;
> +skip:
> +			if (++iter >= dpolicy->max_requests)
>  				goto out;
>  		}
>  		if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
> @@ -1307,6 +1312,7 @@ static int issue_discard_thread(void *data)
>  	struct f2fs_sb_info *sbi = data;
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	wait_queue_head_t *q = &dcc->discard_wait_queue;
> +	struct discard_policy *dpolicy = &dcc->dpolicy;
>  	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
>  	int issued;
>  
> @@ -1333,9 +1339,9 @@ static int issue_discard_thread(void *data)
>  		issued = __issue_discard_cmd(sbi, true);
>  		if (issued) {
>  			__wait_all_discard_cmd(sbi, true);
> -			wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
> +			wait_ms = dpolicy->min_interval;
>  		} else {
> -			wait_ms = DEF_MAX_DISCARD_ISSUE_TIME;
> +			wait_ms = dpolicy->max_interval;
>  		}
>  
>  		sb_end_intwrite(sbi->sb);
> @@ -1620,6 +1626,18 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	wake_up_discard_thread(sbi, false);
>  }
>  
> +static void inline init_discard_policy(struct discard_cmd_control *dcc)
> +{
> +	struct discard_policy *dpolicy = &dcc->dpolicy;
> +
> +	dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> +	dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
> +	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
> +	dpolicy->io_aware_gran = MAX_PLIST_NUM;
> +	dpolicy->io_aware = true;
> +	dpolicy->sync = true;
> +}
> +
>  static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  {
>  	dev_t dev = sbi->sb->s_bdev->bd_dev;
> @@ -1653,6 +1671,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	dcc->undiscard_blks = 0;
>  	dcc->root = RB_ROOT;
>  
> +	init_discard_policy(dcc);
> +
>  	init_waitqueue_head(&dcc->discard_wait_queue);
>  	SM_I(sbi)->dcc_info = dcc;
>  init_thread:
> 
