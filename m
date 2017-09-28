From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: order free nid allocator
Date: Thu, 28 Sep 2017 22:28:25 +0800
Message-ID: <43c822c2-f0b2-21d0-361e-de76cdd9c38e@kernel.org>
References: <20170926112217.53664-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170926112217.53664-1-yuchao0@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi all,

It may trigger hungtask in ENOSPC case with fsstress, please ignore this patch
before an update.

Thanks,

On 2017/9/26 19:22, Chao Yu wrote:
> Previously, there is no restrict order among free nid allocators, if
> there are no free nids being cached in memory, previous allocator will
> try to load them by scanning NAT pages, but after that, these newly
> loaded free nids could be grabbed by later allocators, result in long
> delay of previous allocator during nid allocation.
> 
> This patch tries to refactor alloc_nid flow to serialize allocators.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h |  3 ++-
>  fs/f2fs/node.c | 63 ++++++++++++++++++++++++++++++++++++++++++++--------------
>  2 files changed, 50 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8fdae8ec0377..96366a141f68 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -721,7 +721,8 @@ struct f2fs_nm_info {
>  	struct list_head nid_list[MAX_NID_LIST];/* lists for free nids */
>  	unsigned int nid_cnt[MAX_NID_LIST];	/* the number of free node id */
>  	spinlock_t nid_list_lock;	/* protect nid lists ops */
> -	struct mutex build_lock;	/* lock for build free nids */
> +	struct semaphore build_lock;	/* lock for build free nids */
> +	atomic_t allocator;		/* # of free nid allocators */
>  	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
>  	unsigned char *nat_block_bitmap;
>  	unsigned short *free_nid_count;	/* free nid count of NAT block */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index bfeaa0124670..e1bd6ff383df 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2041,9 +2041,9 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>  
>  void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>  {
> -	mutex_lock(&NM_I(sbi)->build_lock);
> +	down(&NM_I(sbi)->build_lock);
>  	__build_free_nids(sbi, sync, mount);
> -	mutex_unlock(&NM_I(sbi)->build_lock);
> +	up(&NM_I(sbi)->build_lock);
>  }
>  
>  /*
> @@ -2055,22 +2055,30 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct free_nid *i = NULL;
> +	bool alloc_failed = false, lock_build = false, ret = false;
> +
> +	spin_lock(&nm_i->nid_list_lock);
>  retry:
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  	if (time_to_inject(sbi, FAULT_ALLOC_NID)) {
>  		f2fs_show_injection_info(FAULT_ALLOC_NID);
> -		return false;
> +		goto out;
>  	}
>  #endif
> -	spin_lock(&nm_i->nid_list_lock);
>  
> -	if (unlikely(nm_i->available_nids == 0)) {
> -		spin_unlock(&nm_i->nid_list_lock);
> -		return false;
> -	}
> +	if (unlikely(nm_i->available_nids == 0))
> +		goto out;
>  
>  	/* We should not use stale free nids created by build_free_nids */
> -	if (nm_i->nid_cnt[FREE_NID_LIST] && !on_build_free_nids(nm_i)) {
> +	if (nm_i->nid_cnt[FREE_NID_LIST] > atomic_read(&nm_i->allocator)) {
> +
> +		if (!lock_build) {
> +			if (!down_trylock(&nm_i->build_lock))
> +				lock_build = true;
> +			else
> +				goto build;
> +		}
> +
>  		f2fs_bug_on(sbi, list_empty(&nm_i->nid_list[FREE_NID_LIST]));
>  		i = list_first_entry(&nm_i->nid_list[FREE_NID_LIST],
>  					struct free_nid, list);
> @@ -2083,14 +2091,38 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>  
>  		update_free_nid_bitmap(sbi, *nid, false, false);
>  
> -		spin_unlock(&nm_i->nid_list_lock);
> -		return true;
> +		ret = true;
> +		goto out;
> +	}
> +build:
> +	if (!alloc_failed) {
> +		alloc_failed = true;
> +		atomic_inc(&nm_i->allocator);
>  	}
>  	spin_unlock(&nm_i->nid_list_lock);
>  
> +	if (lock_build) {
> +		lock_build = false;
> +		up(&nm_i->build_lock);
> +	}
> +
>  	/* Let's scan nat pages and its caches to get free nids */
> -	build_free_nids(sbi, true, false);
> +	down(&nm_i->build_lock);
> +	lock_build = true;
> +
> +	if (nm_i->nid_cnt[FREE_NID_LIST] < atomic_read(&nm_i->allocator))
> +		__build_free_nids(sbi, true, false);
> +
> +	spin_lock(&nm_i->nid_list_lock);
>  	goto retry;
> +
> +out:
> +	if (alloc_failed)
> +		atomic_dec(&nm_i->allocator);
> +	spin_unlock(&nm_i->nid_list_lock);
> +	if (lock_build)
> +		up(&nm_i->build_lock);
> +	return ret;
>  }
>  
>  /*
> @@ -2154,7 +2186,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
>  	if (nm_i->nid_cnt[FREE_NID_LIST] <= MAX_FREE_NIDS)
>  		return 0;
>  
> -	if (!mutex_trylock(&nm_i->build_lock))
> +	if (!down_trylock(&nm_i->build_lock))
>  		return 0;
>  
>  	spin_lock(&nm_i->nid_list_lock);
> @@ -2169,7 +2201,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
>  		nr_shrink--;
>  	}
>  	spin_unlock(&nm_i->nid_list_lock);
> -	mutex_unlock(&nm_i->build_lock);
> +	up(&nm_i->build_lock);
>  
>  	return nr - nr_shrink;
>  }
> @@ -2656,7 +2688,8 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>  	INIT_RADIX_TREE(&nm_i->nat_set_root, GFP_NOIO);
>  	INIT_LIST_HEAD(&nm_i->nat_entries);
>  
> -	mutex_init(&nm_i->build_lock);
> +	sema_init(&nm_i->build_lock, 1);
> +	atomic_set(&nm_i->allocator, 0);
>  	spin_lock_init(&nm_i->nid_list_lock);
>  	init_rwsem(&nm_i->nat_tree_lock);
>  
> 
