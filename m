From: Jan Kara <jack@suse.cz>
Subject: Re: [RFC][PATCH v4 07/09] f2fs: use common file type
 conversion
Date: Thu, 22 Nov 2018 12:45:20 +0100
Message-ID: <20181122114520.GJ9840@quack2.suse.cz>
References: <20181121190658.GA7731@pathfinder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack@suse.cz>) id 1gPniA-0002lc-EO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Nov 2018 12:03:58 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gPnhy-00HDjM-UI
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Nov 2018 12:03:58 +0000
Content-Disposition: inline
In-Reply-To: <20181121190658.GA7731@pathfinder>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Phillip Potter <phil@philpotter.co.uk>
Cc: amir73il@gmail.com, linux-f2fs-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org

On Wed 21-11-18 19:06:58, Phillip Potter wrote:
> Deduplicate the f2fs file type conversion implementation - file systems
> that use the same file types as defined by POSIX do not need to define
> their own versions and can use the common helper functions decared in
> fs_types.h and implemented in fs_types.c
> 
> Acked-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  fs/f2fs/dir.c           | 41 ++++++++++++++++-------------------------
>  fs/f2fs/inline.c        |  2 +-
>  include/linux/f2fs_fs.h |  8 +++++---
>  3 files changed, 22 insertions(+), 29 deletions(-)

The patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index bacc667950b6..113820f16c6d 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -36,37 +36,28 @@ static unsigned int bucket_blocks(unsigned int level)
>  		return 4;
>  }
>  
> -static unsigned char f2fs_filetype_table[F2FS_FT_MAX] = {
> -	[F2FS_FT_UNKNOWN]	= DT_UNKNOWN,
> -	[F2FS_FT_REG_FILE]	= DT_REG,
> -	[F2FS_FT_DIR]		= DT_DIR,
> -	[F2FS_FT_CHRDEV]	= DT_CHR,
> -	[F2FS_FT_BLKDEV]	= DT_BLK,
> -	[F2FS_FT_FIFO]		= DT_FIFO,
> -	[F2FS_FT_SOCK]		= DT_SOCK,
> -	[F2FS_FT_SYMLINK]	= DT_LNK,
> -};
> -
> -static unsigned char f2fs_type_by_mode[S_IFMT >> S_SHIFT] = {
> -	[S_IFREG >> S_SHIFT]	= F2FS_FT_REG_FILE,
> -	[S_IFDIR >> S_SHIFT]	= F2FS_FT_DIR,
> -	[S_IFCHR >> S_SHIFT]	= F2FS_FT_CHRDEV,
> -	[S_IFBLK >> S_SHIFT]	= F2FS_FT_BLKDEV,
> -	[S_IFIFO >> S_SHIFT]	= F2FS_FT_FIFO,
> -	[S_IFSOCK >> S_SHIFT]	= F2FS_FT_SOCK,
> -	[S_IFLNK >> S_SHIFT]	= F2FS_FT_SYMLINK,
> -};
> -
>  static void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
>  {
> -	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
> +	/*
> +	 * compile-time asserts that generic FT_x types still match
> +	 * F2FS_FT_x types
> +	 */
> +	BUILD_BUG_ON(F2FS_FT_UNKNOWN != FT_UNKNOWN);
> +	BUILD_BUG_ON(F2FS_FT_REG_FILE != FT_REG_FILE);
> +	BUILD_BUG_ON(F2FS_FT_DIR != FT_DIR);
> +	BUILD_BUG_ON(F2FS_FT_CHRDEV != FT_CHRDEV);
> +	BUILD_BUG_ON(F2FS_FT_BLKDEV != FT_BLKDEV);
> +	BUILD_BUG_ON(F2FS_FT_FIFO != FT_FIFO);
> +	BUILD_BUG_ON(F2FS_FT_SOCK != FT_SOCK);
> +	BUILD_BUG_ON(F2FS_FT_SYMLINK != FT_SYMLINK);
> +	BUILD_BUG_ON(F2FS_FT_MAX != FT_MAX);
> +
> +	de->file_type = fs_umode_to_ftype(mode);
>  }
>  
>  unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de)
>  {
> -	if (de->file_type < F2FS_FT_MAX)
> -		return f2fs_filetype_table[de->file_type];
> -	return DT_UNKNOWN;
> +	return fs_ftype_to_dtype(de->file_type);
>  }
>  
>  static unsigned long dir_block_index(unsigned int level,
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 7b0cff7e6051..34205d2e1cc2 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -458,7 +458,7 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
>  		new_name.len = le16_to_cpu(de->name_len);
>  
>  		ino = le32_to_cpu(de->ino);
> -		fake_mode = f2fs_get_de_type(de) << S_SHIFT;
> +		fake_mode = f2fs_get_de_type(de) << S_DT_SHIFT;
>  
>  		err = f2fs_add_regular_entry(dir, &new_name, NULL, NULL,
>  							ino, fake_mode);
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index d7711048ef93..4b8a2ae348d8 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -524,7 +524,11 @@ struct f2fs_dentry_block {
>  	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
>  } __packed;
>  
> -/* file types used in inode_info->flags */
> +/*
> + * file types used in inode_info->flags
> + *
> + * Values must match common file type values in fs_types.h.
> + */
>  enum {
>  	F2FS_FT_UNKNOWN,
>  	F2FS_FT_REG_FILE,
> @@ -537,8 +541,6 @@ enum {
>  	F2FS_FT_MAX
>  };
>  
> -#define S_SHIFT 12
> -
>  #define	F2FS_DEF_PROJID		0	/* default project ID */
>  
>  #endif  /* _LINUX_F2FS_FS_H */
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
