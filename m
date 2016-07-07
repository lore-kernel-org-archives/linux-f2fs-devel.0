From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: fix to return correct trimmed
 block number in FITRIM interface
Date: Thu, 7 Jul 2016 12:29:02 +0800
Message-ID: <f72ddb05-7d92-e2aa-94c3-6757dfb28152@kernel.org>
References: <20160630084248.57469-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bL0w7-0003zp-HE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 Jul 2016 04:29:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bL0w6-0003Ct-QU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 Jul 2016 04:29:15 +0000
In-Reply-To: <20160630084248.57469-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi all,

I think this patch should be wrong, since during fstrim, we should not issue
discard for prefree segment redundantly.

So, Jaegeuk, could you please drop this patch in your branch?

Sorry for the noise.

Thanks,

On 2016/6/30 16:42, Chao Yu wrote:
> During tiggering fstrim, in case of issuing discard for prefree segments,
> we miss acclumulating trimmed block number which will be return to user.
> Fix it.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6d16ecf..5dc14d6 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -732,15 +732,20 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
>  			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
>  				(end - start) << sbi->log_blocks_per_seg);
> +			cpc->trimmed +=
> +				(end - start) << sbi->log_blocks_per_seg;
>  			continue;
>  		}
>  next:
>  		secno = GET_SECNO(sbi, start);
>  		start_segno = secno * sbi->segs_per_sec;
>  		if (!IS_CURSEC(sbi, secno) &&
> -			!get_valid_blocks(sbi, start, sbi->segs_per_sec))
> +			!get_valid_blocks(sbi, start, sbi->segs_per_sec)) {
>  			f2fs_issue_discard(sbi, START_BLOCK(sbi, start_segno),
>  				sbi->segs_per_sec << sbi->log_blocks_per_seg);
> +			cpc->trimmed +=
> +				sbi->segs_per_sec << sbi->log_blocks_per_seg;
> +		}
>  
>  		start = start_segno + sbi->segs_per_sec;
>  		if (start < end)
> 

------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
