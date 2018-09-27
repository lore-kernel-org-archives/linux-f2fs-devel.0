From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: refactor ->page_mkwrite() flow
Date: Wed, 26 Sep 2018 22:05:09 -0700
Message-ID: <20180927050509.GA72357@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180926144552.3302-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926144552.3302-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This makes xfstests/083 stuck. So, I'll drop it for a while.

On 09/26, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Thread A				Thread B
> - f2fs_vm_page_mkwrite
> 					- f2fs_setattr
> 					 - down_write(i_mmap_sem)
> 					 - truncate_setsize
> 					 - f2fs_truncate
> 					 - up_write(i_mmap_sem)
>  - f2fs_reserve_block
>  reserve NEW_ADDR
>  - skip dirty page due to truncation
> 
> 1. we don't need to rserve new block address for a truncated page.
> 2. dn.data_blkaddr is used out of node page lock coverage.
> 
> Refactor ->page_mkwrite() flow to fix above issues:
> - use __do_map_lock() to avoid racing checkpoint()
> - lock data page in prior to dnode page
> - cover f2fs_reserve_block with i_mmap_sem lock
> - access dn.data_blkaddr under dnode lock
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/file.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6f02c8daff76..fcb4788b48aa 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -47,7 +47,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	struct page *page = vmf->page;
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	struct dnode_of_data dn;
> +	struct dnode_of_data dn = { .node_changed = false };
>  	int err;
>  
>  	if (unlikely(f2fs_cp_error(sbi))) {
> @@ -59,19 +59,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>  
> -	/* block allocation */
> -	f2fs_lock_op(sbi);
> -	set_new_dnode(&dn, inode, NULL, NULL, 0);
> -	err = f2fs_reserve_block(&dn, page->index);
> -	if (err) {
> -		f2fs_unlock_op(sbi);
> -		goto out;
> -	}
> -	f2fs_put_dnode(&dn);
> -	f2fs_unlock_op(sbi);
> -
> -	f2fs_balance_fs(sbi, dn.node_changed);
> -
>  	file_update_time(vmf->vma->vm_file);
>  	down_read(&F2FS_I(inode)->i_mmap_sem);
>  	lock_page(page);
> @@ -108,12 +95,24 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	/* fill the page */
>  	f2fs_wait_on_page_writeback(page, DATA, false);
>  
> +	/* block allocation */
> +	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
> +	set_new_dnode(&dn, inode, NULL, NULL, 0);
> +	err = f2fs_reserve_block(&dn, page->index);
> +	if (err)
> +		goto out_unlock;
> +
>  	/* wait for GCed page writeback via META_MAPPING */
>  	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>  
> +	f2fs_put_dnode(&dn);
> +out_unlock:
> +	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
>  out_sem:
>  	up_read(&F2FS_I(inode)->i_mmap_sem);
> -out:
> +
> +	f2fs_balance_fs(sbi, dn.node_changed);
> +
>  	sb_end_pagefault(inode->i_sb);
>  	f2fs_update_time(sbi, REQ_TIME);
>  err:
> -- 
> 2.18.0
