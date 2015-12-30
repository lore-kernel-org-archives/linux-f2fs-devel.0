From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: introduce F2FS_MAX_BLOCKS
Date: Tue, 29 Dec 2015 17:14:11 -0800
Message-ID: <20151230011411.GH13809@jaegeuk.local>
References: <00cf01d1421e$24391d70$6cab5850$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aE5LI-0002Vu-3S
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 01:14:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aE5LG-0005Ti-Uu for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 01:14:20 +0000
Content-Disposition: inline
In-Reply-To: <00cf01d1421e$24391d70$6cab5850$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Tue, Dec 29, 2015 at 05:48:04PM +0800, Chao Yu wrote:
> Introduce a macro named F2FS_MAX_BLOCKS to indicate maximum block index
> in f2fs, it could be used to avoid unneeded calculation in runtime.

It's not so different from previous one.

How about adding something like:

static loff_t max_file_size(unsigned bits)
{
}

...

sbi->max_file_blocks = max_file_size(0);
sb->max_file_size =
	sbi->max_file_blocks << le32_to_cpu(raw_super->log_blocksize);

...

Thanks,

> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/data.c          |  2 +-
>  fs/f2fs/f2fs.h          |  1 -
>  fs/f2fs/super.c         | 19 ++-----------------
>  include/linux/f2fs_fs.h |  5 +++++
>  4 files changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7175d33..a366a4c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -762,7 +762,7 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
>  			struct buffer_head *bh_result, int create)
>  {
>  	/* Block number less than F2FS MAX BLOCKS */
> -	if (unlikely(iblock > max_file_size(0)))
> +	if (unlikely(iblock > F2FS_MAX_BLOCKS))
>  		return -EFBIG;
>  
>  	return __get_data_block(inode, iblock, bh_result, create,
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9ba6a09..95c6f38 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1731,7 +1731,6 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
>   * super.c
>   */
>  int f2fs_commit_super(struct f2fs_sb_info *, bool);
> -loff_t max_file_size(unsigned bits);
>  int f2fs_sync_fs(struct super_block *, int);
>  extern __printf(3, 4)
>  void f2fs_msg(struct super_block *, const char *, const char *, ...);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f474355..5f7e632 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -909,24 +909,9 @@ static const struct export_operations f2fs_export_ops = {
>  	.get_parent = f2fs_get_parent,
>  };
>  
> -loff_t max_file_size(unsigned bits)
> +static loff_t max_file_size(unsigned bits)
>  {
> -	loff_t result = (DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS);
> -	loff_t leaf_count = ADDRS_PER_BLOCK;
> -
> -	/* two direct node blocks */
> -	result += (leaf_count * 2);
> -
> -	/* two indirect node blocks */
> -	leaf_count *= NIDS_PER_BLOCK;
> -	result += (leaf_count * 2);
> -
> -	/* one double indirect node block */
> -	leaf_count *= NIDS_PER_BLOCK;
> -	result += leaf_count;
> -
> -	result <<= bits;
> -	return result;
> +	return ((loff_t)F2FS_MAX_BLOCKS << bits);
>  }
>  
>  static inline bool sanity_check_area_boundary(struct super_block *sb,
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index e59c3be..814c471 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -189,6 +189,11 @@ struct f2fs_extent {
>  #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
>  #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
>  
> +#define F2FS_MAX_BLOCKS		((DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS) + \
> +				ADDRS_PER_BLOCK * 2 + ADDRS_PER_BLOCK * \
> +				NIDS_PER_BLOCK * 2 + ADDRS_PER_BLOCK * \
> +				NIDS_PER_BLOCK * NIDS_PER_BLOCK)
> +
>  #define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
>  						F2FS_INLINE_XATTR_ADDRS - 1))
>  
> -- 
> 2.6.3
> 

------------------------------------------------------------------------------
