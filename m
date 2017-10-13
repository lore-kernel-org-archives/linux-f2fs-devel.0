From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add bug_on when f2fs_gc even fails to
 get one victim
Date: Fri, 13 Oct 2017 19:09:51 +0800
Message-ID: <7a3f0052-86e0-4e46-c89b-048d6137b820@kernel.org>
References: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/11 21:51, Yunlong Song wrote:
> This can help us to debug on some corner case.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/gc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 197ebf4..960503e 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -986,6 +986,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  		.ilist = LIST_HEAD_INIT(gc_list.ilist),
>  		.iroot = RADIX_TREE_INIT(GFP_NOFS),
>  	};
> +	bool need_gc = false;

How about changing variable name to need_fggc for better readability?

Thanks,

>  
>  	trace_f2fs_gc_begin(sbi->sb, sync, background,
>  				get_pages(sbi, F2FS_DIRTY_NODES),
> @@ -1018,8 +1019,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  			if (ret)
>  				goto stop;
>  		}
> -		if (has_not_enough_free_secs(sbi, 0, 0))
> +		if (has_not_enough_free_secs(sbi, 0, 0)) {
>  			gc_type = FG_GC;
> +			need_gc = true;
> +		}
>  	}
>  
>  	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
> @@ -1028,6 +1031,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  		goto stop;
>  	}
>  	if (!__get_victim(sbi, &segno, gc_type)) {
> +		f2fs_bug_on(sbi, !total_freed && need_gc);
>  		ret = -ENODATA;
>  		goto stop;
>  	}
> 
