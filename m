From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: set segment_count in super block
 correctly
Date: Mon, 1 Feb 2016 16:30:43 -0800
Message-ID: <20160202003043.GB86978@jaegeuk.gateway>
References: <001101d15cd2$569ad410$03d07c30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aQOrs-0003gi-0J
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 02 Feb 2016 00:30:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aQOrr-00059p-6p for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 02 Feb 2016 00:30:51 +0000
Content-Disposition: inline
In-Reply-To: <001101d15cd2$569ad410$03d07c30$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Fan Li <fanofcode.li@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Fan,

On Mon, Feb 01, 2016 at 05:23:33PM +0800, Fan Li wrote:
> Now f2fs will check statistics recorded in super block in sanity_check_area_boundary()
> during mount,if number of segments per section is greater than 1, and disk space 
> isn't aligned with section, mount will fail due to following condition:
> 
> main_blkaddr + (segment_count_main << log_blocks_per_seg) !=
> 		segment0_blkaddr + (segment_count << log_blocks_per_seg)
> 
> this is because when the length of main area isn't aligned with section, mkfs didn't 
> add the number of excess segments to segment_count_main, but add it to 
> segment_count. 
> Here align segment_count with section size to prevent such problem.
> 
> Signed-off-by: Fan Li <fanofcode.li@samsung.com>
> ---
>  mkfs/f2fs_format.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 66d7342..aab2491 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -174,7 +174,8 @@ static int f2fs_prepare_super_block(void)
>  	}
>  
>  	set_sb(segment_count, (config.total_sectors * config.sector_size -
> -				zone_align_start_offset) / segment_size_bytes);
> +				zone_align_start_offset) / segment_size_bytes/
> +				config.segs_per_sec*config.segs_per_sec);

Please follow the coding style.

Thanks,

>  
>  	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
>  	sb->cp_blkaddr = sb->segment0_blkaddr;
> -- 
> 1.7.9.5

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
