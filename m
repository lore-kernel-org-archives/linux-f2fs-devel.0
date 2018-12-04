From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH V2 5/7] ext4: use IS_VERITY() to check
 inode's fsverity status
Date: Tue, 4 Dec 2018 15:55:10 -0800
Message-ID: <20181204235509.GF70682@gmail.com>
References: <20181204095650.12562-1-chandan@linux.vnet.ibm.com>
 <20181204095650.12562-6-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gUKX9-0004Sb-VR
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Dec 2018 23:55:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gUKX8-001YR5-4C
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Dec 2018 23:55:19 +0000
Content-Disposition: inline
In-Reply-To: <20181204095650.12562-6-chandan@linux.vnet.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, jhogan@kernel.org, heiko.carstens@de.ibm.com, linux-mtd@lists.infradead.org, deanbo422@gmail.com, linux-s390@vger.kernel.org, corbet@lwn.net, richard@nod.at, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, green.hu@gmail.com, jaegeuk@kernel.org, tytso@mit.edu, dedekind1@gmail.com, adrian.hunter@intel.com, ralf@linux-mips.org, linux-f2fs-devel@lists.sourceforge.net, paul.burton@mips.com, schwidefsky@de.ibm.com, adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk

On Tue, Dec 04, 2018 at 03:26:48PM +0530, Chandan Rajendra wrote:
> This commit now uses IS_VERITY() macro to check if fsverity is
> enabled on an inode.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> ---
>  fs/ext4/ext4.h     |  9 ---------
>  fs/ext4/file.c     |  2 +-
>  fs/ext4/inode.c    | 10 ++++++----
>  fs/ext4/readpage.c |  2 +-
>  fs/ext4/super.c    |  1 +
>  5 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index db21df885186..64bf9fb7ef18 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2296,15 +2296,6 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
>  					      struct ext4_group_desc *gdp);
>  ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
>  
> -static inline bool ext4_verity_inode(struct inode *inode)
> -{
> -#ifdef CONFIG_EXT4_FS_VERITY
> -	return ext4_test_inode_flag(inode, EXT4_INODE_VERITY);
> -#else
> -	return false;
> -#endif
> -}
> -
>  #ifdef CONFIG_FS_ENCRYPTION
>  static inline int ext4_fname_setup_filename(struct inode *dir,
>  			const struct qstr *iname,
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index cb4b69ef01a2..30fbd663354f 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -444,7 +444,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
>  	if (ret)
>  		return ret;
>  
> -	if (ext4_verity_inode(inode)) {
> +	if (IS_VERITY(inode)) {
>  		ret = fsverity_file_open(inode, filp);
>  		if (ret)
>  			return ret;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 09d8857b0e3c..79d14d8bbbf4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3884,7 +3884,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  		return 0;
>  #endif
>  
> -	if (ext4_verity_inode(inode))
> +	if (IS_VERITY(inode))
>  		return 0;
>  
>  	/*
> @@ -4726,7 +4726,7 @@ static bool ext4_should_use_dax(struct inode *inode)
>  		return false;
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_ENCRYPT))
>  		return false;
> -	if (ext4_verity_inode(inode))
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
>  		return false;
>  	return true;
>  }
> @@ -4750,9 +4750,11 @@ void ext4_set_inode_flags(struct inode *inode)
>  		new_fl |= S_DAX;
>  	if (flags & EXT4_ENCRYPT_FL)
>  		new_fl |= S_ENCRYPTED;
> +	if (flags & EXT4_VERITY_FL)
> +		new_fl |= S_VERITY;
>  	inode_set_flags(inode, new_fl,
>  			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|S_DAX|
> -			S_ENCRYPTED);
> +			S_ENCRYPTED|S_VERITY);
>  }
>  
>  static blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
> @@ -5510,7 +5512,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
>  	if (error)
>  		return error;
>  
> -	if (ext4_verity_inode(inode)) {
> +	if (IS_VERITY(inode)) {
>  		error = fsverity_prepare_setattr(dentry, attr);
>  		if (error)
>  			return error;
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 7252f0a60cdb..2c037df629dd 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -206,7 +206,7 @@ static void mpage_end_io(struct bio *bio)
>  static inline loff_t ext4_readpage_limit(struct inode *inode)
>  {
>  #ifdef CONFIG_EXT4_FS_VERITY
> -	if (ext4_verity_inode(inode)) {
> +	if (IS_VERITY(inode)) {
>  		if (inode->i_verity_info)
>  			/* limit to end of metadata region */
>  			return fsverity_full_i_size(inode);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16fb483a6f4a..35ed3c48f8d2 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1344,6 +1344,7 @@ static int ext4_set_verity(struct inode *inode, loff_t data_i_size)
>  	err = ext4_reserve_inode_write(handle, inode, &iloc);
>  	if (err == 0) {
>  		ext4_set_inode_flag(inode, EXT4_INODE_VERITY);
> +		ext4_set_inode_flags(inode);
>  		EXT4_I(inode)->i_disksize = data_i_size;
>  		err = ext4_mark_iloc_dirty(handle, inode, &iloc);
>  	}
> -- 
> 2.19.1
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

Note: we should also move the IS_VERITY() check into fsverity_file_open() and
fsverity_prepare_setattr(), to be like fscrypt_file_open() and
fscrypt_prepare_setattr().  But starting with just this is fine.

- Eric
