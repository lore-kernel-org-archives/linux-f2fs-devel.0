From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix count of seg_freed to make sec_freed correct
Date: Mon, 15 Oct 2018 20:35:07 +0800
Message-ID: <2d4c379a-77c2-4408-2f23-36753afb95bd@huawei.com>
References: <1539168739-79848-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539168739-79848-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/10/10 18:52, Yunlong Song wrote:
> When sbi->segs_per_sec > 1, and if some segno has 0 valid blocks before
> gc starts, do_garbage_collect will skip counting seg_freed++, and this
> will cause seg_freed < sbi->segs_per_sec and finally skip sec_freed++.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a07241f..dc63cd5 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1160,10 +1160,10 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  
>  		stat_inc_seg_count(sbi, type, gc_type);
>  
> +next:
>  		if (gc_type == FG_GC &&
>  				get_valid_blocks(sbi, segno, false) == 0)
>  			seg_freed++;
> -next:

How about:

if (get_valid_blocks(sbi, segno, false) == 0)
	goto freed;

if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi))
	goto next;


freed:
	if (gc_type == FG_GC &&
			get_valid_blocks(sbi, segno, false) == 0)
		seg_freed++;
next:

>  		f2fs_put_page(sum_page, 0);
>  	}
>  
> 
