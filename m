From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: fix memory leak of quota files extent tree and
 it's nodes
Date: Thu, 22 Nov 2018 20:16:15 +0800
Message-ID: <47e3b4e7-c1a6-f130-5765-d212ac9de367@huawei.com>
References: <1542884360-19470-1-git-send-email-stummala@codeaurora.org>
 <1542884360-19470-2-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542884360-19470-2-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/11/22 18:59, Sahitya Tummala wrote:
> When there is a failure in f2fs_fill_super() after the quota is
> enabled, then f2fs_quota_off_umount() is called in the error handling.
> Then sbi is freed up and f2fs_fill_super() retries again.
> But f2fs_quota_off_umount() doesn't guarantee that quota file's extent
> tree/nodes are removed/freed. It will just add to sbi->zombie_list,
> if those files are referenced. In the next retry, quota is enabled
> again with the new extent tree and nodes, causing memory leak for the
> previously allocated memory.
> 
> Fix this by cleaning up the sbi->zombie_list before freeing sbi and
> before the next retry.

I guess we can fix this issue with the same way as the comment I add in
your previous patch, how do you think?

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/extent_cache.c | 21 +++++++++++++++++++++
>  fs/f2fs/f2fs.h         |  1 +
>  fs/f2fs/super.c        |  5 +++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 763ba83..c2bcd88 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -629,6 +629,27 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
>  		f2fs_mark_inode_dirty_sync(inode, true);
>  }
>  
> +void f2fs_cleanup_zombie_list(struct f2fs_sb_info *sbi)
> +{
> +	struct extent_tree *et, *next;
> +
> +	mutex_lock(&sbi->extent_tree_lock);
> +	list_for_each_entry_safe(et, next, &sbi->zombie_list, list) {
> +		if (atomic_read(&et->node_cnt)) {
> +			write_lock(&et->lock);
> +			__free_extent_tree(sbi, et);
> +			write_unlock(&et->lock);
> +		}
> +		f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> +		list_del_init(&et->list);
> +		radix_tree_delete(&sbi->extent_tree_root, et->ino);
> +		kmem_cache_free(extent_tree_slab, et);
> +		atomic_dec(&sbi->total_ext_tree);
> +		atomic_dec(&sbi->total_zombie_tree);
> +	}
> +	mutex_unlock(&sbi->extent_tree_lock);
> +}
> +
>  unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
>  {
>  	struct extent_tree *et, *next;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index db8a919..6807815 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3419,6 +3419,7 @@ void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
>  void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi);
>  int __init f2fs_create_extent_cache(void);
>  void f2fs_destroy_extent_cache(void);
> +void f2fs_cleanup_zombie_list(struct f2fs_sb_info *sbi);
>  
>  /*
>   * sysfs.c
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f41ac43..521fe3f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3023,6 +3023,11 @@ void f2fs_cleanup_extent_cache(struct f2fs_sb_info *sbi)
>  
>  	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list)
>  		f2fs_destroy_extent_tree(inode, true);
> +
> +	f2fs_cleanup_zombie_list(sbi);
> +
> +	f2fs_bug_on(sbi, !list_empty(&sbi->zombie_list));
> +	f2fs_bug_on(sbi, !list_empty(&sbi->extent_list));
>  }
>  
>  static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> 
