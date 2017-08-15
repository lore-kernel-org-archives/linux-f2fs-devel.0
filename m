From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: free_user_blocks should use reserved_segments
 instead
Date: Mon, 14 Aug 2017 20:32:58 -0700
Message-ID: <20170815033258.GD91145@jaegeuk-macbookpro.roam.corp.google.com>
References: <1502702552-78497-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502702552-78497-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/14, Yunlong Song wrote:
> The part (overprovision_segments - reserved_segments) can still be used for LFS,
> so free_use_blocks should use reserved_segments instead, rather than use
> overprovision_segments.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/gc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 9325191..6258305 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -49,10 +49,10 @@ struct gc_inode_list {
>   */
>  static inline block_t free_user_blocks(struct f2fs_sb_info *sbi)

NAK. This gives user-visible block count.

>  {
> -	if (free_segments(sbi) < overprovision_segments(sbi))
> +	if (free_segments(sbi) < reserved_segments(sbi))
>  		return 0;
>  	else
> -		return (free_segments(sbi) - overprovision_segments(sbi))
> +		return (free_segments(sbi) - reserved_segments(sbi))
>  			<< sbi->log_blocks_per_seg;
>  }
>  
> -- 
> 1.8.5.2
