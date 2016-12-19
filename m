From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: fix a missing discard prefree
 segments
Date: Mon, 19 Dec 2016 15:24:58 -0800
Message-ID: <20161219232458.GA2901@jaegeuk.local>
References: <20161216120719.3565-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cJ7Ir-0004rO-HE
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Dec 2016 23:25:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cJ7Ip-0002JG-Ix
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Dec 2016 23:25:09 +0000
Content-Disposition: inline
In-Reply-To: <20161216120719.3565-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: heyunlei@huwei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

On 12/16, Yunlei He wrote:
> If userspace issue a fstrim with a range not involve prefree segments,
> it will reuse these segments without discard. This patch fix it.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d7d5727..5b4468f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -899,6 +899,9 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	unsigned int secno, start_segno;
>  	bool force = (cpc->reason == CP_DISCARD);
>  
> +	if (!test_opt(sbi, DISCARD))
> +		return;

We need to clear the prefree bits, even if discard option was not set.

> +
>  	blk_start_plug(&plug);
>  
>  	mutex_lock(&dirty_i->seglist_lock);
> @@ -910,15 +913,15 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  			break;
>  		end = find_next_zero_bit(prefree_map, MAIN_SEGS(sbi),
>  								start + 1);
> +		if (force && start * sbi->blocks_per_seg >= cpc->trim_start &&
> +					end * sbi->blocks_per_seg <= cpc->trim_end)
> +			continue;

ditto.

>  
>  		for (i = start; i < end; i++)
>  			clear_bit(i, prefree_map);
>  
>  		dirty_i->nr_dirty[PRE] -= end - start;
>  
> -		if (force || !test_opt(sbi, DISCARD))
> -			continue;

Why not just adding that condition here?

Thanks,

> -
>  		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
>  			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
>  				(end - start) << sbi->log_blocks_per_seg);
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most 
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/intel
