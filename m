From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH] f2fs: fix to issue small discard in real-time mode discard
Date: Tue, 03 Mar 2015 08:58:09 +0900
Message-ID: <20150302235809.GA6541@lcm-devel.org>
References: <019801d05338$52aae5b0$f800b110$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <019801d05338$52aae5b0$f800b110$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Feb 28, 2015 at 05:23:30PM +0800, Chao Yu wrote:
> Now in f2fs, we share functions and structures for batch mode and real-time mode
> discard. For real-time mode discard, in shared function add_discard_addrs, we
> will use uninitialized trim_minlen in struct cp_control to compare with length
> of contiguous free blocks to decide whether skipping discard fragmented freespace
> or not, this makes us ignore small discard sometimes. Fix it.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index daee4ab..fcc1cc2 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -549,7 +549,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
>  
> -		if (end - start < cpc->trim_minlen)
> +		if (force && end - start < cpc->trim_minlen)
>  			continue;

Reviewed-by : Changman Lee <cm224.lee@samsung.com>

>  
>  		__add_discard_entry(sbi, cpc, start, end);
> -- 
> 2.3.1
> 
