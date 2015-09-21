From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: introduce __try_update_largest_extent
Date: Mon, 21 Sep 2015 11:40:02 -0700
Message-ID: <20150921184002.GA20551@jaegeuk-mac02.mot.com>
References: <00cb01d0f1ef$8886fc90$9994f5b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00cb01d0f1ef$8886fc90$9994f5b0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Fri, Sep 18, 2015 at 04:53:07PM +0800, Chao Yu wrote:
> This patch adds a new helper __try_update_largest_extent for cleanup.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/extent_cache.c | 14 +++++---------
>  fs/f2fs/f2fs.h         |  7 +++++++
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index c9d1cfd..31d5b48 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -351,8 +351,7 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
>  	}
>  
>  	if (en) {
> -		if (en->ei.len > et->largest.len)
> -			et->largest = en->ei;
> +		__try_update_largest_extent(&et->largest, &en->ei);
>  		et->cached_en = en;
>  	}
>  	return en;
> @@ -389,8 +388,7 @@ do_insert:
>  	if (!en)
>  		return NULL;
>  
> -	if (en->ei.len > et->largest.len)
> -		et->largest = en->ei;
> +	__try_update_largest_extent(&et->largest, &en->ei);
>  	et->cached_en = en;
>  	return en;
>  }
> @@ -476,12 +474,10 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
>  				: NULL;
>  		}
>  
> -		if (parts) {
> -			if (en->ei.len > et->largest.len)
> -				et->largest = en->ei;
> -		} else {
> +		if (parts)
> +			__try_update_largest_extent(&et->largest, &en->ei);
> +		else
>  			__detach_extent_node(sbi, et, en);
> -		}
>  
>  		/*
>  		 * if original extent is split into zero or two parts, extent
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dbceb35..3342619 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -498,6 +498,13 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
>  	return __is_extent_mergeable(cur, front);
>  }
>  
> +static inline void __try_update_largest_extent(struct extent_info *largest,
> +						struct extent_info *cur)

How about __try_update_largest_extent(et, en) ?

> +{
> +	if (cur->len > largest->len)
> +		*largest = *cur;
> +}
> +
>  struct f2fs_nm_info {
>  	block_t nat_blkaddr;		/* base disk address of NAT */
>  	nid_t max_nid;			/* maximum possible node ids */
> -- 
> 2.5.2
