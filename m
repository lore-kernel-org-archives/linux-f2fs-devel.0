From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH RFC] f2fs: add PRE2 to mark segments free to one
 checkpoint but obsolete to the other
Date: Fri, 19 Jan 2018 23:47:47 +0800
Message-ID: <ec3fd2c3-b5b9-fd2e-8eef-97090d853a68@huawei.com>
References: <20180119232903.40922-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20180119232903.40922-1-guoweichao@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, heyunlei@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net


A critical case is using the free segments as data segments which
are previously node segments to the old checkpoint. With fault injecting
of the newer CP pack, fsck can find errors when checking the sanity of nid.

On 2018/1/20 7:29, Weichao Guo wrote:
> Currently, we set prefree segments as free ones after writing
> a checkpoint, then believe the segments could be used safely.
> However, if a sudden power-off coming and the newer checkpoint
> corrupted due to hardware issues at the same time, we will try
> to use the old checkpoint and may face an inconsistent file
> system status.
> 
> How about add an PRE2 status for prefree segments, and make
> sure the segments could be used safely to both checkpoints?
> Or any better solutions? Or this is not a problem?
> 
> Look forward to your comments!
> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fs/f2fs/gc.c      | 11 +++++++++--
>  fs/f2fs/segment.c | 21 ++++++++++++++++++---
>  fs/f2fs/segment.h |  6 ++++++
>  3 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 33e7969..153e3ea 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1030,7 +1030,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  		 * threshold, we can make them free by checkpoint. Then, we
>  		 * secure free segments which doesn't need fggc any more.
>  		 */
> -		if (prefree_segments(sbi)) {
> +		if (prefree_segments(sbi) || prefree2_segments(sbi)) {
> +			ret = write_checkpoint(sbi, &cpc);
> +			if (ret)
> +				goto stop;
> +		}
> +		if (has_not_enough_free_secs(sbi, 0, 0) && prefree2_segments(sbi)) {
>  			ret = write_checkpoint(sbi, &cpc);
>  			if (ret)
>  				goto stop;
> @@ -1063,8 +1068,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  			goto gc_more;
>  		}
>  
> -		if (gc_type == FG_GC)
> +		if (gc_type == FG_GC) {
> +			ret = write_checkpoint(sbi, &cpc);
>  			ret = write_checkpoint(sbi, &cpc);
> +		}
>  	}
>  stop:
>  	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 2e8e054d..9dec445 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1606,7 +1606,7 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
>  	unsigned int segno;
>  
>  	mutex_lock(&dirty_i->seglist_lock);
> -	for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
> +	for_each_set_bit(segno, dirty_i->dirty_segmap[PRE2], MAIN_SEGS(sbi))
>  		__set_test_and_free(sbi, segno);
>  	mutex_unlock(&dirty_i->seglist_lock);
>  }
> @@ -1617,13 +1617,17 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	struct list_head *head = &dcc->entry_list;
>  	struct discard_entry *entry, *this;
>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> -	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
> +	unsigned long *prefree_map;
>  	unsigned int start = 0, end = -1;
>  	unsigned int secno, start_segno;
>  	bool force = (cpc->reason & CP_DISCARD);
> +	int phase = 0;
> +	enum dirty_type dirty_type = PRE2;
>  
>  	mutex_lock(&dirty_i->seglist_lock);
>  
> +next_step:
> +	prefree_map = dirty_i->dirty_segmap[dirty_type];
>  	while (1) {
>  		int i;
>  		start = find_next_bit(prefree_map, MAIN_SEGS(sbi), end + 1);
> @@ -1635,7 +1639,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		for (i = start; i < end; i++)
>  			clear_bit(i, prefree_map);
>  
> -		dirty_i->nr_dirty[PRE] -= end - start;
> +		dirty_i->nr_dirty[dirty_type] -= end - start;
>  
>  		if (!test_opt(sbi, DISCARD))
>  			continue;
> @@ -1663,6 +1667,16 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		else
>  			end = start - 1;
>  	}
> +	if (phase == 0) {
> +		/* status change: PRE -> PRE2 */
> +		for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
> +			if (!test_and_set_bit(segno, prefree_map))
> +				dirty_i->nr_dirty[PRE2]++;
> +
> +		phase = 1;
> +		dirty_type = PRE;
> +		goto next_step;
> +	}
>  	mutex_unlock(&dirty_i->seglist_lock);
>  
>  	/* send small discards */
> @@ -2245,6 +2259,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
>  
>  	mutex_lock(&dirty_i->seglist_lock);
>  	__remove_dirty_segment(sbi, new_segno, PRE);
> +	__remove_dirty_segment(sbi, new_segno, PRE2);
>  	__remove_dirty_segment(sbi, new_segno, DIRTY);
>  	mutex_unlock(&dirty_i->seglist_lock);
>  
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 71a2aaa..f702726 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -263,6 +263,7 @@ enum dirty_type {
>  	DIRTY_COLD_NODE,	/* dirty segments assigned as cold node logs */
>  	DIRTY,			/* to count # of dirty segments */
>  	PRE,			/* to count # of entirely obsolete segments */
> +	PRE2,			/* to count # of the segments free to one checkpoint but obsolete to the other checkpoint */
>  	NR_DIRTY_TYPE
>  };
>  
> @@ -477,6 +478,11 @@ static inline unsigned int prefree_segments(struct f2fs_sb_info *sbi)
>  	return DIRTY_I(sbi)->nr_dirty[PRE];
>  }
>  
> +static inline unsigned int prefree2_segments(struct f2fs_sb_info *sbi)
> +{
> +	return DIRTY_I(sbi)->nr_dirty[PRE2];
> +}
> +
>  static inline unsigned int dirty_segments(struct f2fs_sb_info *sbi)
>  {
>  	return DIRTY_I(sbi)->nr_dirty[DIRTY_HOT_DATA] +
> 
