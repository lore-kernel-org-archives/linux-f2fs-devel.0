From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev][PATCH RFC] f2fs: refactor get_new_segment
Date: Tue, 19 Dec 2017 14:56:48 -0800
Message-ID: <20171219225648.GD23445@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171216083252.5860-1-hsiangkao@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171216083252.5860-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Gao Xiang <hsiangkao@aol.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

On 12/16, Gao Xiang wrote:
> get_new_segment is too unclear to understand how it works.
> This patch refactor it in a straight-forward way and
> I think it is equal to the original one.

Thank you for the work, however, unless we found any bug, I don't think we have
to just refactor the long-lived existing codes.

Thanks,

> 
> This patch also fixes two issues in the original get_new_segment:
> 1) left_start could be overflowed when hint == 0 at first:
> 	...
> 		} else {
> 			go_left = 1;
> *			left_start = hint - 1;
> 		}
> 	...
> *	while (test_bit(left_start, free_i->free_secmap)) {
> 2) It will do find_next_zero_bit again when go_left == true and ALLOC_LEFT:
> 	...
> find_other_zone:
> *	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
> 	if (secno >= MAIN_SECS(sbi)) {
> 		if (dir == ALLOC_RIGHT) {
> 			...
> 		} else {
> 			go_left = 1;
> 			...
> 		}
> 	}
> 	if (go_left == 0)
> 		goto skip_left;
> 	...
> 	if (i < NR_CURSEG_TYPE) {
> 		/* zone is in user, try another */
> *		if (go_left)
> *			hint = zoneno * sbi->secs_per_zone - 1;
> 		...
> 		init = false;
> 		goto find_other_zone;
> 	}
> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  fs/f2fs/segment.c | 137 ++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 81 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c117e09..eea9d3f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2047,82 +2047,107 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  			unsigned int *newseg, bool new_sec, int dir)
>  {
>  	struct free_segmap_info *free_i = FREE_I(sbi);
> -	unsigned int segno, secno, zoneno;
> +	unsigned int segno = *newseg, zoneno;
> +	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
>  	unsigned int total_zones = MAIN_SECS(sbi) / sbi->secs_per_zone;
> -	unsigned int hint = GET_SEC_FROM_SEG(sbi, *newseg);
> -	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
> -	unsigned int left_start = hint;
> -	bool init = true;
> -	int go_left = 0;
> +	unsigned int old_zoneno = GET_ZONE_FROM_SEC(sbi, secno);
> +	bool may_again = true, actually_go_left = false;
>  	int i;
>  
>  	spin_lock(&free_i->segmap_lock);
>  
> -	if (!new_sec && ((*newseg + 1) % sbi->segs_per_sec)) {
> +	/* first, attempt to find a segment in the current section */
> +	if (!new_sec && ((segno + 1) % sbi->segs_per_sec)) {
> +		unsigned end_segno = GET_SEG_FROM_SEC(sbi, secno + 1);
> +
>  		segno = find_next_zero_bit(free_i->free_segmap,
> -			GET_SEG_FROM_SEC(sbi, hint + 1), *newseg + 1);
> -		if (segno < GET_SEG_FROM_SEC(sbi, hint + 1))
> -			goto got_it;
> +			end_segno, segno + 1);
> +
> +		if (segno < end_segno)
> +			goto out;
>  	}
> -find_other_zone:
> -	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
> -	if (secno >= MAIN_SECS(sbi)) {
> -		if (dir == ALLOC_RIGHT) {
> -			secno = find_next_zero_bit(free_i->free_secmap,
> -							MAIN_SECS(sbi), 0);
> -			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
> -		} else {
> -			go_left = 1;
> -			left_start = hint - 1;
> +
> +try_another_section:
> +	if (likely(!actually_go_left)) {
> +		/*
> +		 * since ALLOC_LEFT takes much effort,
> +		 * prefer to ALLOC_RIGHT first
> +		 */
> +		unsigned int new_secno = find_next_zero_bit(
> +			free_i->free_secmap, MAIN_SECS(sbi), secno);
> +
> +		if (new_secno < MAIN_SECS(sbi)) {
> +			secno = new_secno;
> +			goto check_another_zone;
>  		}
>  	}
> -	if (go_left == 0)
> -		goto skip_left;
>  
> -	while (test_bit(left_start, free_i->free_secmap)) {
> -		if (left_start > 0) {
> -			left_start--;
> -			continue;
> -		}
> -		left_start = find_next_zero_bit(free_i->free_secmap,
> -							MAIN_SECS(sbi), 0);
> -		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
> -		break;
> +	if (dir == ALLOC_LEFT) {
> +		/* ALLOC_LEFT, no free sections on the right side */
> +		actually_go_left = true;
> +
> +		while(secno)
> +			if (!test_bit(--secno, free_i->free_secmap))
> +				goto check_another_zone;
>  	}
> -	secno = left_start;
> -skip_left:
> -	segno = GET_SEG_FROM_SEC(sbi, secno);
> -	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
>  
> +	/*
> +	 * when ALLOC_RIGHT and secno >= end_endno
> +	 *   or  ALLOC_LEFT and secno == 0, we need do the last attempt
> +	 * since the function should be returned with success
> +	 */
> +	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), 0);
> +	f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
> +
> +check_another_zone:
>  	/* give up on finding another zone */
> -	if (!init)
> -		goto got_it;
> -	if (sbi->secs_per_zone == 1)
> +	if (!may_again || sbi->secs_per_zone == 1)
>  		goto got_it;
> +
> +	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
>  	if (zoneno == old_zoneno)
>  		goto got_it;
> -	if (dir == ALLOC_LEFT) {
> -		if (!go_left && zoneno + 1 >= total_zones)
> -			goto got_it;
> -		if (go_left && zoneno == 0)
> +
> +	/*
> +	 * since the following case will be likely to frequently happen,
> +	 * leave it here rather than put together in the following loop
> +	 */
> +	if (dir == ALLOC_LEFT)
> +		/*
> +		 * I'm really confused why not select
> +		 * zoneno * sbi->secs_per_zone - 1 in this case.
> +		 * Okay, leave it as the origin
> +		 */
> +		if (!actually_go_left && zoneno + 1 >= total_zones)
>  			goto got_it;
> -	}
> +
>  	for (i = 0; i < NR_CURSEG_TYPE; i++)
> -		if (CURSEG_I(sbi, i)->zone == zoneno)
> -			break;
> +		/* the zone is in use, try another */
> +		if (CURSEG_I(sbi, i)->zone == zoneno) {
> +			/* try the neighbor (left or right) zone */
> +			if (actually_go_left) {
> +				/*
> +				 * since ALLOC_LEFT and no way to get free on
> +				 * the right side, it's safe to try the left
> +				 * zone and won't find the same section again.
> +				 */
> +				if (zoneno == 0)
> +					break;
> +				secno = zoneno * sbi->secs_per_zone - 1;
> +			} else if (zoneno + 1 >= total_zones) {
> +				/* no way dir == ALLOC_LEFT at this time */
> +				secno = 0;
> +			} else
> +				secno = (zoneno + 1) * sbi->secs_per_zone;
> +
> +			/* try another zone once at most */
> +			may_again = false;
> +			goto try_another_section;
> +		}
>  
> -	if (i < NR_CURSEG_TYPE) {
> -		/* zone is in user, try another */
> -		if (go_left)
> -			hint = zoneno * sbi->secs_per_zone - 1;
> -		else if (zoneno + 1 >= total_zones)
> -			hint = 0;
> -		else
> -			hint = (zoneno + 1) * sbi->secs_per_zone;
> -		init = false;
> -		goto find_other_zone;
> -	}
>  got_it:
> +	segno = GET_SEG_FROM_SEC(sbi, secno);
> +out:
>  	/* set it as dirty segment in free segmap */
>  	f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
>  	__set_inuse(sbi, segno);
> -- 
> 2.7.4
