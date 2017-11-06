From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: avoid using __GFP_NOFAIL
Date: Mon, 6 Nov 2017 15:08:53 +0100
Message-ID: <20171106140853.f3nqwfg75tco67y6@dhcp22.suse.cz>
References: <20171105135330.15070-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171105135330.15070-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sun 05-11-17 21:53:28, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> We will keep __add_ino_entry success all the time, for ENOMEM failure
> case, we have already handled it with an opened loop code, so we don't
> have to use redundant __GFP_NOFAIL in radix_tree_preload, remove it.

Why do you think an open coded allocation retry loop is better than
having the MM do all it can when the nofail is requested explicitly?
E.g. giving it an access to memory reserves to allow forward progress.

> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 98777c1ae70c..43ee9d97fd8f 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -405,10 +405,11 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
>  {
>  	struct inode_management *im = &sbi->im[type];
>  	struct ino_entry *e, *tmp;
> +	bool preloaded;
>  
>  	tmp = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
>  retry:
> -	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
> +	preloaded = !radix_tree_preload(GFP_NOFS);
>  
>  	spin_lock(&im->ino_lock);
>  	e = radix_tree_lookup(&im->ino_root, ino);
> @@ -416,7 +417,8 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
>  		e = tmp;
>  		if (radix_tree_insert(&im->ino_root, ino, e)) {
>  			spin_unlock(&im->ino_lock);
> -			radix_tree_preload_end();
> +			if (preloaded)
> +				radix_tree_preload_end();
>  			goto retry;
>  		}
>  		memset(e, 0, sizeof(struct ino_entry));
> @@ -431,7 +433,9 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
>  		f2fs_set_bit(devidx, (char *)&e->dirty_device);
>  
>  	spin_unlock(&im->ino_lock);
> -	radix_tree_preload_end();
> +
> +	if (preloaded)
> +		radix_tree_preload_end();
>  
>  	if (e != tmp)
>  		kmem_cache_free(ino_entry_slab, tmp);
> -- 
> 2.14.1.145.gb3622a4ee

-- 
Michal Hocko
SUSE Labs
