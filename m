From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: let __get_victim successfully get a segno in
 corner case
Date: Sat, 15 Jul 2017 18:09:34 -0700
Message-ID: <20170716010934.GC51202@jaegeuk-macbookpro.roam.corp.google.com>
References: <1500033432-57620-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500033432-57620-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

On 07/14, Yunlong Song wrote:
> Suppose that the valid blocks of each section are all over sbi->fggc_threshold,

How about adding a kernel message first to detect your *supposed* sceanrio?
If that happens, it'll be a sort of bug which we haven't assumed.

Thanks,

> and even has_not_enough_free_secs is true, f2fs_gc cannot do its job since the
> no_fggc_candidate always returns true. As a result, the reserved segments can be
> used up, and finally there is no free segment at all, and get_new_segment cannot
> get a free segment, filesystem will trap into a wrong status.
> 
> To fix this, we record the segno which has a rough minimum cost and return it to
> __get_victim to continue f2fs_gc's job.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/gc.c      | 19 ++++++++++++++-----
>  fs/f2fs/segment.h | 17 ++++++++++++++---
>  2 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index fa3d2e2..965e783 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -178,6 +178,8 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>  		p->offset = 0;
>  	else
>  		p->offset = SIT_I(sbi)->last_victim[p->gc_mode];
> +
> +	p->min_cost_r = UINT_MAX;
>  }
>  
>  static unsigned int get_max_cost(struct f2fs_sb_info *sbi,
> @@ -194,7 +196,7 @@ static unsigned int get_max_cost(struct f2fs_sb_info *sbi,
>  		return 0;
>  }
>  
> -static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
> +static unsigned int check_bg_victims(struct f2fs_sb_info *sbi, struct victim_sel_policy *p)
>  {
>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>  	unsigned int secno;
> @@ -208,11 +210,12 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
>  		if (sec_usage_check(sbi, secno))
>  			continue;
>  
> -		if (no_fggc_candidate(sbi, secno))
> +		p->cur_segno_r = GET_SEG_FROM_SEC(sbi, secno);
> +		if (no_fggc_candidate(sbi, secno, p))
>  			continue;
>  
>  		clear_bit(secno, dirty_i->victim_secmap);
> -		return GET_SEG_FROM_SEC(sbi, secno);
> +		return p->cur_segno_r;
>  	}
>  	return NULL_SEGNO;
>  }
> @@ -332,7 +335,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  
>  	last_victim = sm->last_victim[p.gc_mode];
>  	if (p.alloc_mode == LFS && gc_type == FG_GC) {
> -		p.min_segno = check_bg_victims(sbi);
> +		p.min_segno = check_bg_victims(sbi, &p);
>  		if (p.min_segno != NULL_SEGNO)
>  			goto got_it;
>  	}
> @@ -369,8 +372,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  			goto next;
>  		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
>  			goto next;
> +		p.cur_segno_r = segno;
>  		if (gc_type == FG_GC && p.alloc_mode == LFS &&
> -					no_fggc_candidate(sbi, secno))
> +					no_fggc_candidate(sbi, secno, &p))
>  			goto next;
>  
>  		cost = get_gc_cost(sbi, segno, &p);
> @@ -403,6 +407,11 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
>  				sbi->cur_victim_sec,
>  				prefree_segments(sbi), free_segments(sbi));
> +	} else if (has_not_enough_free_secs(sbi, 0, 0)) {
> +		p.min_segno = p.min_segno_r;
> +		if (p.alloc_mode == LFS && gc_type == FG_GC)
> +			clear_bit(GET_SEC_FROM_SEG(sbi, p.min_segno), dirty_i->victim_secmap);
> +		goto got_it;
>  	}
>  out:
>  	mutex_unlock(&dirty_i->seglist_lock);
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 6b871b4..7d2d0f3 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -169,6 +169,9 @@ struct victim_sel_policy {
>  	unsigned int ofs_unit;		/* bitmap search unit */
>  	unsigned int min_cost;		/* minimum cost */
>  	unsigned int min_segno;		/* segment # having min. cost */
> +	unsigned int min_cost_r;		/* rough minimum cost */
> +	unsigned int min_segno_r;		/* segment # having rough min. cost */
> +	unsigned int cur_segno_r;		/* segment # rough process is handling */
>  };
>  
>  struct seg_entry {
> @@ -743,11 +746,19 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
>  }
>  
>  static inline bool no_fggc_candidate(struct f2fs_sb_info *sbi,
> -						unsigned int secno)
> +						unsigned int secno, struct victim_sel_policy *p)
>  {
> -	if (get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno), true) >=
> -						sbi->fggc_threshold)
> +	unsigned int cur_cost;
> +
> +	cur_cost = get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno), true);
> +	if (cur_cost >= sbi->fggc_threshold) {
> +		if (p->min_cost_r > cur_cost) {
> +			p->min_cost_r = cur_cost;
> +			p->min_segno_r = p->cur_segno_r;
> +		}
>  		return true;
> +	}
> +
>  	return false;
>  }
>  
> -- 
> 1.8.5.2
