From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: use atomic variable for
	total_extent_tree
Date: Tue, 29 Dec 2015 19:11:21 +0800
Message-ID: <56826A59.3020105@huawei.com>
References: <1450755521-20015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aDsC5-0001Yb-LM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 11:11:57 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aDsBx-0006Js-Gt
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 11:11:57 +0000
In-Reply-To: <1450755521-20015-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2015/12/22 11:38, Jaegeuk Kim wrote:
> It would be better to use atomic variable for total_extent_tree.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/debug.c        | 5 +++--
>   fs/f2fs/extent_cache.c | 8 ++++----
>   fs/f2fs/f2fs.h         | 2 +-
>   fs/f2fs/node.c         | 3 ++-
>   fs/f2fs/shrinker.c     | 3 ++-
>   5 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index bb307e6..ed5dfcc 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -38,7 +38,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>   	si->hit_rbtree = atomic64_read(&sbi->read_hit_rbtree);
>   	si->hit_total = si->hit_largest + si->hit_cached + si->hit_rbtree;
>   	si->total_ext = atomic64_read(&sbi->total_hit_ext);
> -	si->ext_tree = sbi->total_ext_tree;
> +	si->ext_tree = atomic_read(&sbi->total_ext_tree);
>   	si->ext_node = atomic_read(&sbi->total_ext_node);
>   	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
>   	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
> @@ -193,7 +193,8 @@ get_cache:
>   	si->cache_mem += si->inmem_pages * sizeof(struct inmem_pages);
>   	for (i = 0; i <= UPDATE_INO; i++)
>   		si->cache_mem += sbi->im[i].ino_num * sizeof(struct ino_entry);
> -	si->cache_mem += sbi->total_ext_tree * sizeof(struct extent_tree);
> +	si->cache_mem += atomic_read(&sbi->total_ext_tree) *
> +						sizeof(struct extent_tree);
>   	si->cache_mem += atomic_read(&sbi->total_ext_node) *
>   						sizeof(struct extent_node);
>
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index e86e9f1e..0e97d6af 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -70,7 +70,7 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
>   		rwlock_init(&et->lock);
>   		atomic_set(&et->refcount, 0);
>   		et->count = 0;
> -		sbi->total_ext_tree++;
> +		atomic_inc(&sbi->total_ext_tree);
>   	}
>   	atomic_inc(&et->refcount);
>   	up_write(&sbi->extent_tree_lock);
> @@ -570,7 +570,7 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
>
>   				radix_tree_delete(root, et->ino);
>   				kmem_cache_free(extent_tree_slab, et);
> -				sbi->total_ext_tree--;
> +				atomic_dec(&sbi->total_ext_tree);
>   				tree_cnt++;
>
>   				if (node_cnt + tree_cnt >= nr_shrink)
> @@ -663,7 +663,7 @@ void f2fs_destroy_extent_tree(struct inode *inode)
>   	f2fs_bug_on(sbi, atomic_read(&et->refcount) || et->count);
>   	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
>   	kmem_cache_free(extent_tree_slab, et);
> -	sbi->total_ext_tree--;
> +	atomic_dec(&sbi->total_ext_tree);
>   	up_write(&sbi->extent_tree_lock);
>
>   	F2FS_I(inode)->extent_tree = NULL;
> @@ -715,7 +715,7 @@ void init_extent_cache_info(struct f2fs_sb_info *sbi)
>   	init_rwsem(&sbi->extent_tree_lock);
>   	INIT_LIST_HEAD(&sbi->extent_list);
>   	spin_lock_init(&sbi->extent_lock);
> -	sbi->total_ext_tree = 0;
> +	atomic_set(&sbi->total_ext_tree, 0);
Hi,
	here we'd better to init total_zombie_tree:
	atomic_set(&sbi->total_zombie_tree, 0);
Thanks,
>   	atomic_set(&sbi->total_ext_node, 0);
>   }
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 19beabe..a7f6191 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -762,7 +762,7 @@ struct f2fs_sb_info {
>   	struct rw_semaphore extent_tree_lock;	/* locking extent radix tree */
>   	struct list_head extent_list;		/* lru list for shrinker */
>   	spinlock_t extent_lock;			/* locking extent lru list */
> -	int total_ext_tree;			/* extent tree count */
> +	atomic_t total_ext_tree;		/* extent tree count */
>   	atomic_t total_ext_node;		/* extent info count */
>
>   	/* basic filesystem units */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index d842b19..6cc8ac7 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -65,7 +65,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
>   				sizeof(struct ino_entry)) >> PAGE_CACHE_SHIFT;
>   		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
>   	} else if (type == EXTENT_CACHE) {
> -		mem_size = (sbi->total_ext_tree * sizeof(struct extent_tree) +
> +		mem_size = (atomic_read(&sbi->total_ext_tree) *
> +				sizeof(struct extent_tree) +
>   				atomic_read(&sbi->total_ext_node) *
>   				sizeof(struct extent_node)) >> PAGE_CACHE_SHIFT;
>   		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index da0d8e0..a11e099 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -32,7 +32,8 @@ static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
>
>   static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
>   {
> -	return sbi->total_ext_tree + atomic_read(&sbi->total_ext_node);
> +	return atomic_read(&sbi->total_ext_tree) +
> +				atomic_read(&sbi->total_ext_node);
>   }
>
>   unsigned long f2fs_shrink_count(struct shrinker *shrink,
>


------------------------------------------------------------------------------
