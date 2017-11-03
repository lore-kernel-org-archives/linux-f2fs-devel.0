From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: fix out-of-free problem caused by atomic write
Date: Thu, 2 Nov 2017 20:46:18 -0700
Message-ID: <20171103034618.GD11335@jaegeuk-macbookpro.roam.corp.google.com>
References: <1509027715-80477-1-git-send-email-yunlong.song@huawei.com>
 <1509368658-60355-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509368658-60355-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/30, Yunlong Song wrote:
> f2fs_balance_fs only actives once in the commit_inmem_pages, but there
> are more than one page to commit, so all the other pages will miss the
> check. This will lead to out-of-free problem when commit a very large
> file. However, we cannot do f2fs_balance_fs for each inmem page, since
> this will break atomicity. As a result, we should collect prefree
> segments if needed and stop atomic commit when there are not enough
> available blocks to write atomic pages.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 13a96b8..04ce48f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -610,6 +610,7 @@ struct f2fs_inode_info {
>  	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
>  	struct task_struct *inmem_task;	/* store inmemory task */
>  	struct mutex inmem_lock;	/* lock for inmemory pages */
> +	unsigned long inmem_blocks;	/* inmemory blocks */
>  	struct extent_tree *extent_tree;	/* cached extent_tree entry */
>  	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
>  	struct rw_semaphore i_mmap_sem;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 46dfbca..813c110 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -210,6 +210,7 @@ void register_inmem_page(struct inode *inode, struct page *page)
>  		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>  	inc_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
> +	fi->inmem_blocks++;
>  	mutex_unlock(&fi->inmem_lock);
>  
>  	trace_f2fs_register_inmem_page(page, INMEM);
> @@ -221,6 +222,7 @@ static int __revoke_inmem_pages(struct inode *inode,
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct inmem_pages *cur, *tmp;
>  	int err = 0;
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
>  
>  	list_for_each_entry_safe(cur, tmp, head, list) {
>  		struct page *page = cur->page;
> @@ -263,6 +265,7 @@ static int __revoke_inmem_pages(struct inode *inode,
>  		list_del(&cur->list);
>  		kmem_cache_free(inmem_entry_slab, cur);
>  		dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
> +		fi->inmem_blocks--;
>  	}
>  	return err;
>  }
> @@ -302,6 +305,10 @@ void drop_inmem_pages(struct inode *inode)
>  	if (!list_empty(&fi->inmem_ilist))
>  		list_del_init(&fi->inmem_ilist);
>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> +	if (fi->inmem_blocks) {
> +		f2fs_bug_on(sbi, 1);
> +		fi->inmem_blocks = 0;
> +	}
>  	mutex_unlock(&fi->inmem_lock);
>  
>  	clear_inode_flag(inode, FI_ATOMIC_FILE);
> @@ -326,6 +333,7 @@ void drop_inmem_page(struct inode *inode, struct page *page)
>  
>  	f2fs_bug_on(sbi, !cur || cur->page != page);
>  	list_del(&cur->list);
> +	fi->inmem_blocks--;
>  	mutex_unlock(&fi->inmem_lock);
>  
>  	dec_page_count(sbi, F2FS_INMEM_PAGES);
> @@ -410,11 +418,26 @@ int commit_inmem_pages(struct inode *inode)
>  
>  	INIT_LIST_HEAD(&revoke_list);
>  	f2fs_balance_fs(sbi, true);
> +	if (prefree_segments(sbi)
> +		&& has_not_enough_free_secs(sbi, 0,
> +		fi->inmem_blocks / BLKS_PER_SEC(sbi))) {
> +		struct cp_control cpc;
> +
> +		cpc.reason = __get_cp_reason(sbi);
> +		err = write_checkpoint(sbi, &cpc);
> +		if (err)
> +			goto drop;
> +	}
>  	f2fs_lock_op(sbi);
>  
>  	set_inode_flag(inode, FI_ATOMIC_COMMIT);
>  
>  	mutex_lock(&fi->inmem_lock);
> +	if ((sbi->user_block_count - valid_user_blocks(sbi)) <

What does this mean? We already allocated blocks successfully?

> +		fi->inmem_blocks) {
> +		err = -ENOSPC;
> +		goto drop;
> +	}
>  	err = __commit_inmem_pages(inode, &revoke_list);
>  	if (err) {
>  		int ret;
> @@ -429,7 +452,7 @@ int commit_inmem_pages(struct inode *inode)
>  		ret = __revoke_inmem_pages(inode, &revoke_list, false, true);
>  		if (ret)
>  			err = ret;
> -
> +drop:
>  		/* drop all uncommitted pages */
>  		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
>  	}
> @@ -437,6 +460,10 @@ int commit_inmem_pages(struct inode *inode)
>  	if (!list_empty(&fi->inmem_ilist))
>  		list_del_init(&fi->inmem_ilist);
>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> +	if (fi->inmem_blocks) {
> +		f2fs_bug_on(sbi, 1);
> +		fi->inmem_blocks = 0;
> +	}
>  	mutex_unlock(&fi->inmem_lock);
>  
>  	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
> -- 
> 1.8.5.2
