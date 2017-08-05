From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix the size value in __check_sit_bitmap
Date: Sat, 5 Aug 2017 13:40:28 +0800
Message-ID: <0f1a4338-9aa7-5427-6ca2-2102027cf3c4@kernel.org>
References: <1501837635-128934-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1501837635-128934-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/4 17:07, Yunlong Song wrote:
> The current size value is not correct and will miss bitmap check.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/segment.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f336f8c..45fb534 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -787,11 +787,14 @@ void __check_sit_bitmap(struct f2fs_sb_info *sbi,
>  		sentry = get_seg_entry(sbi, segno);
>  		offset = GET_BLKOFF_FROM_SEG0(sbi, blk);
>  
> -		size = min((unsigned long)(end - blk), max_blocks);
> +		if (end < START_BLOCK(sbi, segno + 1))
> +			size = GET_BLKOFF_FROM_SEG0(sbi, end);
> +		else
> +			size = max_blocks;
>  		map = (unsigned long *)(sentry->cur_valid_map);
>  		offset = __find_rev_next_bit(map, size, offset);
>  		f2fs_bug_on(sbi, offset != size);
> -		blk += size;
> +		blk = START_BLOCK(sbi, segno + 1);
>  	}
>  #endif
>  }
> 
