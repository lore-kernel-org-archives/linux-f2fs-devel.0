From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: cover large section in sanity check
 of	super
Date: Tue, 22 Mar 2016 11:39:14 +0800
Message-ID: <013f01d183ec$854a61e0$8fdf25a0$@samsung.com>
References: <1458586565-8827-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <1458586565-8827-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: stable-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: "'stable 4 . 5+'" <stable@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, March 22, 2016 2:56 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim; stable 4 . 5+
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: cover large section in sanity check of super
> 
> This patch fixes the bug which does not cover a large section case when checking
> the sanity of superblock.
> 
> Reported-by: Matthias Prager <linux@matthiasprager.de>
> Reported-by: David Gnedt <david.gnedt@davizone.at>
> Cc: stable 4.5+ <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 15bb81f..fc9147f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1000,6 +1000,7 @@ static inline bool sanity_check_area_boundary(struct super_block *sb,
>  	u32 segment_count_main = le32_to_cpu(raw_super->segment_count_main);
>  	u32 segment_count = le32_to_cpu(raw_super->segment_count);
>  	u32 log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
> +	u32 segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
> 
>  	if (segment0_blkaddr != cp_blkaddr) {
>  		f2fs_msg(sb, KERN_INFO,
> @@ -1044,12 +1045,26 @@ static inline bool sanity_check_area_boundary(struct super_block *sb,
>  		return true;
>  	}
> 
> -	if (main_blkaddr + (segment_count_main << log_blocks_per_seg) !=
> +	if (segs_per_sec == 1 &&
> +		main_blkaddr + (segment_count_main << log_blocks_per_seg) !=
>  		segment0_blkaddr + (segment_count << log_blocks_per_seg)) {
>  		f2fs_msg(sb, KERN_INFO,
>  			"Wrong MAIN_AREA boundary, start(%u) end(%u) blocks(%u)",
>  			main_blkaddr,
> -			segment0_blkaddr + (segment_count << log_blocks_per_seg),
> +			segment0_blkaddr +
> +			(segment_count << log_blocks_per_seg),
> +			segment_count_main << log_blocks_per_seg);
> +		return true;
> +	}
> +
> +	if (segs_per_sec > 1 &&

if ((segs_per_sec > 1 || secs_per_zone > 1)) && ?

Thanks,

> +		main_blkaddr + (segment_count_main << log_blocks_per_seg) >
> +		segment0_blkaddr + (segment_count << log_blocks_per_seg)) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Wrong MAIN_AREA boundary in large section, start(%u) end(%u) blocks(%u)",
> +			main_blkaddr,
> +			segment0_blkaddr +
> +			(segment_count << log_blocks_per_seg),
>  			segment_count_main << log_blocks_per_seg);
>  		return true;
>  	}
> --
> 2.6.3
> 
> 
> ------------------------------------------------------------------------------
> Transform Data into Opportunity.
> Accelerate data analysis in your applications with
> Intel Data Analytics Acceleration Library.
> Click to learn more.
> http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
