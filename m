From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 1/3] f2fs: avoid opened loop codes in __add_ino_entry
Date: Thu, 9 Nov 2017 09:51:29 -0800
Message-ID: <20171109175129.GA55844@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171107054142.6242-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171107054142.6242-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, mhocko@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On 11/07, Chao Yu wrote:
> We will keep __add_ino_entry success all the time, for ENOMEM failure
> case, we have already handled it by using  __GFP_NOFAIL flag, so we
> don't have to use additional opened loop codes here, remove them.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> As Michal Hocko suggested, with __GFP_NOFAIL, MM will do all it can for
> memory allocation including access memory reserves, so it's better to
> use it rather than opened loop code, update this patch for it.
>  fs/f2fs/checkpoint.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 98777c1ae70c..80b90146cff2 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -405,20 +405,21 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
>  {
>  	struct inode_management *im = &sbi->im[type];
>  	struct ino_entry *e, *tmp;
> +	bool preloaded;
> +	int err;
>  
>  	tmp = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
> -retry:
> -	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
> +
> +	preloaded = !radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
> +	f2fs_bug_on(sbi, !preloaded);

I don't think we need this by adding new useless variable.

>  
>  	spin_lock(&im->ino_lock);
>  	e = radix_tree_lookup(&im->ino_root, ino);
>  	if (!e) {
>  		e = tmp;
> -		if (radix_tree_insert(&im->ino_root, ino, e)) {

How about just adding this?

		if (unlikely(radix_tree_insert(&im->ino_root, ino, e)))
			f2fs_bug_on(sbi, 1);

> -			spin_unlock(&im->ino_lock);
> -			radix_tree_preload_end();
> -			goto retry;
> -		}
> +		err = radix_tree_insert(&im->ino_root, ino, e);
> +		f2fs_bug_on(sbi, err);
> +
>  		memset(e, 0, sizeof(struct ino_entry));
>  		e->ino = ino;
>  
> @@ -431,7 +432,9 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
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
> 2.15.0.55.gc2ece9dc4de6
