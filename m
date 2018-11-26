From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix to allow node segment for GC by ioctl path
Date: Mon, 26 Nov 2018 15:25:40 +0800
Message-ID: <37f1d52c-66c2-6e74-45a3-c590bf0c4150@huawei.com>
References: <1543208334-309-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543208334-309-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/11/26 12:58, Sahitya Tummala wrote:
> Allow node type segments also to be GC'd via f2fs ioctl
> F2FS_IOC_GARBAGE_COLLECT_RANGE.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
> v2:
> update commit message
> 
>  fs/f2fs/gc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a07241f..e4689c6 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -323,8 +323,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  	p.min_cost = get_max_cost(sbi, &p);
>  
>  	if (*result != NULL_SEGNO) {
> -		if (IS_DATASEG(get_seg_entry(sbi, *result)->type) &&
> -			get_valid_blocks(sbi, *result, false) &&
> +		if (get_valid_blocks(sbi, *result, false) &&

I'm okay with above commit message and change, but how about separating
below change into another patch?

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  			!sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
>  			p.min_segno = *result;
>  		goto out;
> @@ -404,11 +403,12 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  		}
>  		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
>  
> +	}
> +out:
> +	if (p.min_segno != NULL_SEGNO)
>  		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
>  				sbi->cur_victim_sec,
>  				prefree_segments(sbi), free_segments(sbi));
> -	}
> -out:
>  	mutex_unlock(&dirty_i->seglist_lock);
>  
>  	return (p.min_segno == NULL_SEGNO) ? 0 : 1;
> 
