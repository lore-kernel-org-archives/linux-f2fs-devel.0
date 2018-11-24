From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to allow node segment for GC by ioctl path
Date: Sat, 24 Nov 2018 18:23:55 +0800
Message-ID: <f94e8b8c-0c20-0668-16ad-4978b0600d36@huawei.com>
References: <1542949942-30275-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542949942-30275-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/11/23 13:12, Sahitya Tummala wrote:
> Allow node type segments also to be GC'd via f2fs ioctls
> F2FS_IOC_GARBAGE_COLLECT and F2FS_IOC_GARBAGE_COLLECT_RANGE.

IIRC, only F2FS_IOC_GARBAGE_COLLECT_RANGE pass a valid segment number via
@result parameter in get_victim_by_default(), so in commit message, it
needs to remove F2FS_IOC_GARBAGE_COLLECT, right?

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
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
