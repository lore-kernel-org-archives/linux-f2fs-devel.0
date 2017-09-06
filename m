From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: introduce f2fs_encrypted_file for
 clean-up
Date: Wed, 6 Sep 2017 11:10:42 +0800
Message-ID: <a546c89e-163f-190d-8fe9-00352d4559f1@huawei.com>
References: <20170906001550.53917-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170906001550.53917-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/9/6 8:15, Jaegeuk Kim wrote:
> This patch replaces (f2fs_encrypted_inode() && S_ISREG()) with
> f2fs_encrypted_file(), which gives no functional change.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/data.c   | 10 +++++-----
>  fs/f2fs/f2fs.h   |  5 +++++
>  fs/f2fs/file.c   |  2 +-
>  fs/f2fs/gc.c     |  5 ++---
>  fs/f2fs/inline.c |  2 +-
>  5 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 67da4f6eeaa0..e6c683e7a10e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -581,7 +581,7 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index,
>  		.encrypted_page = NULL,
>  	};
>  
> -	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> +	if (f2fs_encrypted_file(inode))
>  		return read_mapping_page(mapping, index, NULL);
>  
>  	page = f2fs_grab_cache_page(mapping, index, for_write);
> @@ -786,7 +786,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
>  
>  static inline bool __force_buffered_io(struct inode *inode, int rw)
>  {
> -	return ((f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) ||
> +	return (f2fs_encrypted_file(inode) ||
>  			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
>  			F2FS_I_SB(inode)->s_ndevs);
>  }
> @@ -1157,7 +1157,7 @@ static struct bio *f2fs_grab_bio(struct inode *inode, block_t blkaddr,
>  	struct fscrypt_ctx *ctx = NULL;
>  	struct bio *bio;
>  
> -	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
> +	if (f2fs_encrypted_file(inode)) {
>  		ctx = fscrypt_get_ctx(inode, GFP_NOFS);
>  		if (IS_ERR(ctx))
>  			return ERR_CAST(ctx);
> @@ -1345,7 +1345,7 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
>  	struct inode *inode = fio->page->mapping->host;
>  	gfp_t gfp_flags = GFP_NOFS;
>  
> -	if (!f2fs_encrypted_inode(inode) || !S_ISREG(inode->i_mode))
> +	if (!f2fs_encrypted_file(inode))
>  		return 0;
>  
>  	/* wait for GCed encrypted page writeback */
> @@ -1974,7 +1974,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>  	f2fs_wait_on_page_writeback(page, DATA, false);
>  
>  	/* wait for GCed encrypted page writeback */
> -	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> +	if (f2fs_encrypted_file(inode))
>  		f2fs_wait_on_encrypted_page_writeback(sbi, blkaddr);
>  
>  	if (len == PAGE_SIZE || PageUptodate(page))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4b993961d81d..417c28f01fd5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2939,6 +2939,11 @@ static inline bool f2fs_encrypted_inode(struct inode *inode)
>  	return file_is_encrypt(inode);
>  }
>  
> +static inline bool f2fs_encrypted_file(struct inode *inode)
> +{
> +	return f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode);
> +}
> +
>  static inline void f2fs_set_encrypted_inode(struct inode *inode)
>  {
>  #ifdef CONFIG_F2FS_FS_ENCRYPTION
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 63e394907808..f8cedaba7ce4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -106,7 +106,7 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	f2fs_wait_on_page_writeback(page, DATA, false);
>  
>  	/* wait for GCed encrypted page writeback */
> -	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> +	if (f2fs_encrypted_file(inode))
>  		f2fs_wait_on_encrypted_page_writeback(sbi, dn.data_blkaddr);
>  
>  out_sem:
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index b226760afba8..6a12f33d0cdd 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -831,8 +831,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  				continue;
>  
>  			/* if encrypted inode, let's go phase 3 */
> -			if (f2fs_encrypted_inode(inode) &&
> -						S_ISREG(inode->i_mode)) {
> +			if (f2fs_encrypted_file(inode)) {
>  				add_gc_inode(gc_list, inode);
>  				continue;
>  			}
> @@ -873,7 +872,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  
>  			start_bidx = start_bidx_of_node(nofs, inode)
>  								+ ofs_in_node;
> -			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> +			if (f2fs_encrypted_file(inode))
>  				move_encrypted_block(inode, start_bidx, segno, off);
>  			else
>  				move_data_page(inode, start_bidx, gc_type, segno, off);
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index e63ab0d1f614..c133a4fdecf6 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -25,7 +25,7 @@ bool f2fs_may_inline_data(struct inode *inode)
>  	if (i_size_read(inode) > MAX_INLINE_DATA(inode))
>  		return false;
>  
> -	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> +	if (f2fs_encrypted_file(inode))
>  		return false;
>  
>  	return true;
> 
