From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fsck.f2fs: avoid fix ssa in some case
Date: Fri, 29 Jan 2016 09:12:07 -0800
Message-ID: <20160129171207.GA77478@jaegeuk.gateway>
References: <1453969096-11522-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aPCan-0002cS-Ti
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 Jan 2016 17:12:17 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aPCal-0007s6-Sr for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 Jan 2016 17:12:17 +0000
Content-Disposition: inline
In-Reply-To: <1453969096-11522-1-git-send-email-heyunlei@huawei.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

On Thu, Jan 28, 2016 at 04:18:16PM +0800, Yunlei He wrote:
> In some case, we need confirm node or data blkaddr is ok at first,
> and then fix the conflict in ssa block. If the node blkaddr happen to
> locate in data type segment caused by something error, may be we 'd
> better ignore it, and it's same with data blkaddr.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fsck/fsck.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index e7dd02f..fd82bef 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -129,6 +129,7 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
>  {
>  	struct f2fs_summary_block *sum_blk;
>  	struct f2fs_summary *sum_entry;
> +	struct seg_entry * se;
>  	u32 segno, offset;
>  	int need_fix = 0, ret = 0;
>  	int type;
> @@ -145,9 +146,16 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -		FIX_MSG("Summary footer indicates a node segment: 0x%x", segno);
> -		sum_blk->footer.entry_type = SUM_TYPE_NODE;
> +
>  		need_fix = 1;
> +		se = get_seg_entry(sbi, segno);
> +		if(se->type >= 3 && se->type <= 5) {

IS_NODESEG(se->type) ?

> +			FIX_MSG("Summary footer indicates a node segment: 0x%x", segno);
> +			sum_blk->footer.entry_type = SUM_TYPE_NODE;
> +		} else {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  	}
>  
>  	sum_entry = &(sum_blk->entries[offset]);
> @@ -235,6 +243,7 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
>  {
>  	struct f2fs_summary_block *sum_blk;
>  	struct f2fs_summary *sum_entry;
> +	struct seg_entry * se;
>  	u32 segno, offset;
>  	int need_fix = 0, ret = 0;
>  	int type;
> @@ -251,9 +260,16 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -		FIX_MSG("Summary footer indicates a data segment: 0x%x", segno);
> -		sum_blk->footer.entry_type = SUM_TYPE_DATA;
> +
>  		need_fix = 1;
> +		se = get_seg_entry(sbi, segno);
> +		if (se->type >=0 && se->type <= 2) {

IS_DATASEG(se->type) ?

> +			FIX_MSG("Summary footer indicates a data segment: 0x%x", segno);
> +			sum_blk->footer.entry_type = SUM_TYPE_DATA;
> +		} else {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  	}
>  
>  	sum_entry = &(sum_blk->entries[offset]);
> @@ -352,11 +368,6 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
>  		return -EINVAL;
>  	}
>  
> -	if (is_valid_ssa_node_blk(sbi, nid, ni->blk_addr)) {
> -		ASSERT_MSG("summary node block is not valid. [0x%x]", nid);
> -		return -EINVAL;
> -	}
> -
>  	ret = dev_read_block(node_blk, ni->blk_addr);
>  	ASSERT(ret >= 0);
>  
> @@ -427,6 +438,11 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
>  		ASSERT_MSG("orphan or xattr nid is duplicated [0x%x]\n",
>  				nid);
>  
> +	if (is_valid_ssa_node_blk(sbi, nid, ni->blk_addr)) {
> +		ASSERT_MSG("summary node block is not valid. [0x%x]", nid);
> +		return -EINVAL;
> +	}
> +
>  	if (f2fs_test_sit_bitmap(sbi, ni->blk_addr) == 0)
>  		ASSERT_MSG("SIT bitmap is 0x0. blk_addr[0x%x]",
>  				ni->blk_addr);
> -- 
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
