From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: avoid multiple node page writes due
 to	inline_data
Date: Mon, 25 Jan 2016 17:42:40 +0800
Message-ID: <000d01d15754$dca6e6d0$95f4b470$@samsung.com>
References: <1453580148-61861-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1453580148-61861-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Sunday, January 24, 2016 4:16 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: avoid multiple node page writes due to inline_data
> 
> The sceanrio is:
> 1. create fully node blocks
> 2. flush node blocks
> 3. write inline_data for all the node blocks again
> 4. flush node blocks redundantly
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8d0d9ec..011456e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1622,14 +1622,22 @@ static int f2fs_write_end(struct file *file,
> 
>  	trace_f2fs_write_end(inode, pos, len, copied);
> 
> -	set_page_dirty(page);
> -
>  	if (pos + copied > i_size_read(inode)) {
>  		i_size_write(inode, pos + copied);
>  		mark_inode_dirty(inode);
> -		update_inode_page(inode);
>  	}
> 
> +	if (f2fs_has_inline_data(inode) &&
> +			is_inode_flag_set(F2FS_I(inode), FI_DATA_EXIST)) {
> +		int err = f2fs_write_inline_data(inode, page);

Oh, I'm sure this can fix that issue, but IMO:
a) this implementation has side-effect, it triggers inline data copying
between data page and node page whenever user write inline datas, so if
user updates inline data frequently, write-through approach would cause
memory copy overhead.
b) inline storm should be a rare case, as we didn't get any report about
problem for long time until Dave's, and write_end is a hot path, I think
it's better to be cautious to change our inline data cache policy for
fixing a rare issue in hot path.

What about delaying the merge operation? like:
1) as I proposed before, merging inline page into inode page when
detecting free_sections <= (node_secs + 2 * dent_secs + inline_secs).
2) merge inline page into inode page before writeback inode page in
sync_node_pages.

Thanks,

> +		if (err)
> +			set_page_dirty(page);
> +	} else {
> +		set_page_dirty(page);
> +	}
> +
> +	f2fs_write_inode(inode, NULL);
> +
>  	f2fs_put_page(page, 1);
>  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
>  	return copied;
> --
> 2.6.3
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

