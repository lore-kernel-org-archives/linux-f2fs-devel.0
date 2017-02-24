From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: skip checkpoint if having a dirty
 segment but no prefree at BG_GC -> FG_GC
Date: Fri, 24 Feb 2017 10:49:59 -0800
Message-ID: <20170224184959.GD39009@jaegeuk.local>
References: <20170224204357.220337-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1chKwT-0006vY-So
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 18:50:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1chKwR-0003Qt-QC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 18:50:09 +0000
Content-Disposition: inline
In-Reply-To: <20170224204357.220337-1-guoweichao@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Weichao Guo <guoweichao@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Weichao,

On 02/25, Weichao Guo wrote:
> When turning to FG_GC from BG_GC, we need to write checkpoint in 2 cases:
> * a) BG_GC have made some progress, e.g.: some prefree segments.
> * b) There is no victim and no prefree segment.

You missed
  * c) has_not_enough_free_secs() introduced by
      6e17bfbc75a5cb ("f2fs: fix to overcome inline_data floods")

And, Yunlong pointed that we can't find a case to avoid write_checkpoint()
mostly due to c) condition.

Thanks,

> 
> For case a), previously, we also check if there is a dirty segment for
> infering blocks moving in last BG_GC. But dirty segments do not always
> indicate that, BG_GC may just start and do not move any blocks at all.
> Futhermore, skipping checkpoint if there are some dirty segments but no
> prefree segments is OK.


> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fs/f2fs/gc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6c996e3..30d206a 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -958,7 +958,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
>  		 * enough free sections, we should flush dent/node blocks and do
>  		 * garbage collections.
>  		 */
> -		ret = write_checkpoint(sbi, &cpc);
> +		if (prefree_segments(sbi))
> +			ret = write_checkpoint(sbi, &cpc);
> +		else if (!__get_victim(sbi, &segno, gc_type) {
> +			segno = NULL_SEGNO;
> +			ret = write_checkpoint(sbi, &cpc);
> +		}
>  		if (ret)
>  			goto stop;
>  	} else if (gc_type == BG_GC && !background) {
> -- 
> 2.10.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
