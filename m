From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: reorganize __f2fs_add_link
Date: Thu, 23 Jul 2015 11:15:22 -0700
Message-ID: <20150723181522.GB23629@jaegeuk-mac02.mot.com>
References: <00f201d0c468$550aabf0$ff2003d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00f201d0c468$550aabf0$ff2003d0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Wed, Jul 22, 2015 at 06:21:52PM +0800, Chao Yu wrote:
> Firstly, spliting init_inode_metadata into two parts as below since they
> are relatively independent.
> 1) init_inode_metadata: init datas belong to newly created inode;
> 2) update_inode_metadata: update inode info for linking inode to new
> dentry.
> 
> Secondly, move init_inode_metadata to the front of __f2fs_add_link,
> So the flow of __f2fs_add_link will be reorganized as:
> 1) init inode meta data for new creatation;
> 2) lookup dentry page and insert new directory entry in the page;
> 3) update meta data of inode and parent.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/dir.c    | 129 ++++++++++++++++++++++++++++++++-----------------------
>  fs/f2fs/f2fs.h   |   4 +-
>  fs/f2fs/inline.c |   2 +-
>  3 files changed, 78 insertions(+), 57 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index a34ebd8..0ad9a1c 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -381,43 +381,68 @@ static int make_empty_dir(struct inode *inode,
>  	return 0;
>  }
>  
> -struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
> +int init_inode_metadata(struct inode *inode, struct inode *dir,
>  			const struct qstr *name, struct page *dpage)
>  {
>  	struct page *page;
>  	int err;
>  
> -	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
> -		page = new_inode_page(inode);
> -		if (IS_ERR(page))
> -			return page;
> +	if (!is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE))
> +		return 0;
>  
> -		if (S_ISDIR(inode->i_mode)) {
> -			err = make_empty_dir(inode, dir, page);
> -			if (err)
> -				goto error;
> -		}
> +	page = new_inode_page(inode);
> +	if (IS_ERR(page))
> +		return PTR_ERR(page);
>  
> -		err = f2fs_init_acl(inode, dir, page, dpage);
> +	if (S_ISDIR(inode->i_mode)) {
> +		err = make_empty_dir(inode, dir, page);
>  		if (err)
> -			goto put_error;
> +			goto error;
> +	}
>  
> -		err = f2fs_init_security(inode, dir, name, page);
> +	err = f2fs_init_acl(inode, dir, page, dpage);
> +	if (err)
> +		goto put_error;
> +
> +	err = f2fs_init_security(inode, dir, name, page);
> +	if (err)
> +		goto put_error;
> +
> +	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode)) {
> +		err = f2fs_inherit_context(dir, inode, page);
>  		if (err)
>  			goto put_error;
> +	}
>  
> -		if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode)) {
> -			err = f2fs_inherit_context(dir, inode, page);
> -			if (err)
> -				goto put_error;
> -		}
> -	} else {
> -		page = get_node_page(F2FS_I_SB(dir), inode->i_ino);
> -		if (IS_ERR(page))
> -			return page;
> +	if (f2fs_encrypted_inode(dir))
> +		file_set_enc_name(inode);
> +
> +	update_inode(inode, page);
> +	f2fs_put_page(page, 1);

We should not put the inode page here.
Since checkpoint can be called and flush all the node pages with valid
NAT entres. Once power-off happens after then, we can see unreachable NAT
entries.

Thanks,
