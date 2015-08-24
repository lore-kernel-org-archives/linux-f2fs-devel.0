From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix to release inode correctly
Date: Mon, 24 Aug 2015 09:54:23 -0700
Message-ID: <20150824165423.GC2837@jaegeuk-mac02.mot-mobility.com>
References: <001b01d0de51$0b369c70$21a3d550$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <001b01d0de51$0b369c70$21a3d550$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Aug 24, 2015 at 05:40:45PM +0800, Chao Yu wrote:
> In following call stack, if unfortunately we lose all chances to truncate
> inode page in remove_inode_page, eventually we will add the nid allocated
> previously into free nid cache, this nid is with NID_NEW status and with
> NEW_ADDR in its blkaddr pointer:
> 
>  - f2fs_create
>   - f2fs_add_link
>    - __f2fs_add_link
>     - init_inode_metadata
>      - new_inode_page
>       - new_node_page
>        - set_node_addr(, NEW_ADDR)
>      - f2fs_init_acl   failed
>      - remove_inode_page  failed
>   - handle_failed_inode
>    - remove_inode_page  failed
>    - iput
>     - f2fs_evict_inode
>      - remove_inode_page  failed
>      - alloc_nid_failed   cache a nid with valid blkaddr: NEW_ADDR
> 
> This may not only cause resource leak of previous inode, but also may cause
> incorrect use of the previous blkaddr which is located in NO.nid node entry
> when this nid is reused by others.
> 
> This patch tries to add this inode to orphan list if we fail to truncate
> inode, so that we can obtain a second chance to release it in orphan
> recovery flow.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/f2fs.h  |  2 +-
>  fs/f2fs/inode.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
>  fs/f2fs/node.c  | 14 +++++++++-----
>  3 files changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 806439f..69827ee 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1687,7 +1687,7 @@ int get_dnode_of_data(struct dnode_of_data *, pgoff_t, int);
>  int truncate_inode_blocks(struct inode *, pgoff_t);
>  int truncate_xattr_node(struct inode *, struct page *);
>  int wait_on_node_pages_writeback(struct f2fs_sb_info *, nid_t);
> -void remove_inode_page(struct inode *);
> +int remove_inode_page(struct inode *);
>  struct page *new_inode_page(struct inode *);
>  struct page *new_node_page(struct dnode_of_data *, unsigned int, struct page *);
>  void ra_node_page(struct f2fs_sb_info *, nid_t);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index d1b03d0..35aae65 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -317,6 +317,7 @@ void f2fs_evict_inode(struct inode *inode)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  	nid_t xnid = fi->i_xattr_nid;
> +	int err = 0;
>  
>  	/* some remained atomic pages should discarded */
>  	if (f2fs_is_atomic_file(inode))
> @@ -342,11 +343,13 @@ void f2fs_evict_inode(struct inode *inode)
>  	i_size_write(inode, 0);
>  
>  	if (F2FS_HAS_BLOCKS(inode))
> -		f2fs_truncate(inode, true);
> +		err = f2fs_truncate(inode, true);
>  
> -	f2fs_lock_op(sbi);
> -	remove_inode_page(inode);
> -	f2fs_unlock_op(sbi);
> +	if (!err) {
> +		f2fs_lock_op(sbi);
> +		err = remove_inode_page(inode);
> +		f2fs_unlock_op(sbi);
> +	}
>  
>  	sb_end_intwrite(inode->i_sb);
>  no_delete:
> @@ -362,9 +365,26 @@ no_delete:
>  	if (is_inode_flag_set(fi, FI_UPDATE_WRITE))
>  		add_dirty_inode(sbi, inode->i_ino, UPDATE_INO);
>  	if (is_inode_flag_set(fi, FI_FREE_NID)) {
> -		alloc_nid_failed(sbi, inode->i_ino);
> +		if (err && err != -ENOENT)
> +			alloc_nid_done(sbi, inode->i_ino);
> +		else
> +			alloc_nid_failed(sbi, inode->i_ino);
>  		clear_inode_flag(fi, FI_FREE_NID);
>  	}
> +
> +	if (err && err != -ENOENT) {
> +		if (!exist_written_data(sbi, inode->i_ino, ORPHAN_INO)) {
> +			/*
> +			 * get here because we failed to release resource
> +			 * of inode previously, reminder our user to run fsck
> +			 * for fixing.
> +			 */
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_msg(sbi->sb, KERN_WARNING,
> +				"inode (ino:%lu) resource leak, run fsck "
> +				"to fix this issue!", inode->i_ino);
> +		}
> +	}
>  out_clear:
>  #ifdef CONFIG_F2FS_FS_ENCRYPTION
>  	if (fi->i_crypt_info)
> @@ -377,6 +397,7 @@ out_clear:
>  void handle_failed_inode(struct inode *inode)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	int err = 0;
>  
>  	clear_nlink(inode);
>  	make_bad_inode(inode);
> @@ -384,9 +405,27 @@ void handle_failed_inode(struct inode *inode)
>  
>  	i_size_write(inode, 0);
>  	if (F2FS_HAS_BLOCKS(inode))
> -		f2fs_truncate(inode, false);
> +		err = f2fs_truncate(inode, false);
> +
> +	if (!err)
> +		err = remove_inode_page(inode);
>  
> -	remove_inode_page(inode);
> +	/*
> +	 * if we skip truncate_node in remove_inode_page bacause we failed
> +	 * before, it's better to find another way to release resource of
> +	 * this inode (e.g. valid block count, node block or nid). Here we
> +	 * choose to add this inode to orphan list, so that we can call iput
> +	 * for releasing in orphan recovery flow.
> +	 *
> +	 * Note: we should add inode to orphan list before f2fs_unlock_op()
> +	 * so we can prevent losing this orphan when encoutering checkpoint
> +	 * and following suddenly power-off.
> +	 */
> +	if (err && err != -ENOENT) {
> +		err = acquire_orphan_inode(sbi);
> +		if (!err)
> +			add_orphan_inode(sbi, inode->i_ino);

		Need this too?

		if (err)
			set_sbi_flag(sbi, SBI_NEED_FSCK);

Thanks,

> +	}
>  
>  	set_inode_flag(F2FS_I(inode), FI_FREE_NID);
>  	f2fs_unlock_op(sbi);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 0867325..27d1a74 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -902,17 +902,20 @@ int truncate_xattr_node(struct inode *inode, struct page *page)
>   * Caller should grab and release a rwsem by calling f2fs_lock_op() and
>   * f2fs_unlock_op().
>   */
> -void remove_inode_page(struct inode *inode)
> +int remove_inode_page(struct inode *inode)
>  {
>  	struct dnode_of_data dn;
> +	int err;
>  
>  	set_new_dnode(&dn, inode, NULL, NULL, inode->i_ino);
> -	if (get_dnode_of_data(&dn, 0, LOOKUP_NODE))
> -		return;
> +	err = get_dnode_of_data(&dn, 0, LOOKUP_NODE);
> +	if (err)
> +		return err;
>  
> -	if (truncate_xattr_node(inode, dn.inode_page)) {
> +	err = truncate_xattr_node(inode, dn.inode_page);
> +	if (err) {
>  		f2fs_put_dnode(&dn);
> -		return;
> +		return err;
>  	}
>  
>  	/* remove potential inline_data blocks */
> @@ -926,6 +929,7 @@ void remove_inode_page(struct inode *inode)
>  
>  	/* will put inode & node pages */
>  	truncate_node(&dn);
> +	return 0;
>  }
>  
>  struct page *new_inode_page(struct inode *inode)
> -- 
> 2.4.2
