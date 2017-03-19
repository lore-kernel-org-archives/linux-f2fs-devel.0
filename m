From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: protect free nid operation with cp_rwsem
Date: Sun, 19 Mar 2017 18:44:26 -0400
Message-ID: <20170319224426.GA45667@jaegeuk.local>
References: <20170317104623.90116-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317104623.90116-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On 03/17, Chao Yu wrote:
> - f2fs_balance_fs_bg
>  - build_free_nids
>   - __build_free_nids
>    - scan_nat_page
>     - add_free_nid
> 					- f2fs_create
> 					 - f2fs_new_inode
> 					  - alloc_nid
>    - remove_free_nid
> 
> This patch uses cp_rwsem to protect free nid allocation/initialization
> to avoid reusing allocated nid in above scenario.

It looks like description doesn't match to your change below?

Thanks,

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c   | 2 ++
>  fs/f2fs/segment.c | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 2520fa72b23f..f941410f994a 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -423,7 +423,9 @@ void f2fs_evict_inode(struct inode *inode)
>  			add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
>  	}
>  	if (is_inode_flag_set(inode, FI_FREE_NID)) {
> +		f2fs_lock_op(sbi);
>  		alloc_nid_failed(sbi, inode->i_ino);
> +		f2fs_unlock_op(sbi);
>  		clear_inode_flag(inode, FI_FREE_NID);
>  	}
>  	f2fs_bug_on(sbi, err &&
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 0bf024f62330..f85e1f443c99 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -426,8 +426,11 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  
>  	if (!available_free_memory(sbi, FREE_NIDS))
>  		try_to_free_nids(sbi, MAX_FREE_NIDS);
> -	else
> +	else {
> +		f2fs_lock_op(sbi);
>  		build_free_nids(sbi, false, false);
> +		f2fs_unlock_op(sbi);
> +	}
>  
>  	if (!is_idle(sbi))
>  		return;
> -- 
> 2.8.2.295.g3f1c1d0
