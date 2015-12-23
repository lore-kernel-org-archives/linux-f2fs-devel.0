From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/4] f2fs: avoid unnecessary f2fs_gc for dir
	operations
Date: Wed, 23 Dec 2015 11:26:25 +0800
Message-ID: <010101d13d31$cdc1d860$69458920$@samsung.com>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
 <1450832388-29118-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1450832388-29118-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, December 23, 2015 9:00 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/4] f2fs: avoid unnecessary f2fs_gc for dir operations
> 
> The f2fs_balance_fs doesn't need to cover f2fs_new_inode or f2fs_find_entry
> works.

So this avoids some unneeded overhead in f2fs_balance_fs for scenario where
f2fs_new_inode and f2fs_find_entry will fail for most of the time?

Shouldn't cover f2fs_find_entry in rename or rename2 case?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 2c32110..8d2616f 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -128,8 +128,6 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t
> mode,
>  	nid_t ino = 0;
>  	int err;
> 
> -	f2fs_balance_fs(sbi);
> -
>  	inode = f2fs_new_inode(dir, mode);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
> @@ -142,6 +140,8 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t
> mode,
>  	inode->i_mapping->a_ops = &f2fs_dblock_aops;
>  	ino = inode->i_ino;
> 
> +	f2fs_balance_fs(sbi);
> +
>  	f2fs_lock_op(sbi);
>  	err = f2fs_add_link(dentry, inode);
>  	if (err)
> @@ -288,12 +288,13 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>  	int err = -ENOENT;
> 
>  	trace_f2fs_unlink_enter(dir, dentry);
> -	f2fs_balance_fs(sbi);
> 
>  	de = f2fs_find_entry(dir, &dentry->d_name, &page);
>  	if (!de)
>  		goto fail;
> 
> +	f2fs_balance_fs(sbi);
> +
>  	f2fs_lock_op(sbi);
>  	err = acquire_orphan_inode(sbi);
>  	if (err) {
> @@ -341,8 +342,6 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
>  	if (len > dir->i_sb->s_blocksize)
>  		return -ENAMETOOLONG;
> 
> -	f2fs_balance_fs(sbi);
> -
>  	inode = f2fs_new_inode(dir, S_IFLNK | S_IRWXUGO);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
> @@ -353,6 +352,8 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
>  		inode->i_op = &f2fs_symlink_inode_operations;
>  	inode->i_mapping->a_ops = &f2fs_dblock_aops;
> 
> +	f2fs_balance_fs(sbi);
> +
>  	f2fs_lock_op(sbi);
>  	err = f2fs_add_link(dentry, inode);
>  	if (err)
> @@ -433,8 +434,6 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t
> mode)
>  	struct inode *inode;
>  	int err;
> 
> -	f2fs_balance_fs(sbi);
> -
>  	inode = f2fs_new_inode(dir, S_IFDIR | mode);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
> @@ -444,6 +443,8 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t
> mode)
>  	inode->i_mapping->a_ops = &f2fs_dblock_aops;
>  	mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
> 
> +	f2fs_balance_fs(sbi);
> +
>  	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
>  	f2fs_lock_op(sbi);
>  	err = f2fs_add_link(dentry, inode);
> --
> 2.5.4 (Apple Git-61)
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
