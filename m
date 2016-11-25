From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix redundant block allocation
Date: Sat, 26 Nov 2016 00:05:33 +0800
Message-ID: <3253f1bd-e39f-821b-2b4e-5a64deced726@kernel.org>
References: <20161112013043.8058-1-jaegeuk@kernel.org>
	<20161112013043.8058-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1cAJ0r-0005Rf-8n
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 16:06:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cAJ0q-0001a6-Dc
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 16:06:09 +0000
In-Reply-To: <20161112013043.8058-2-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/11/12 9:30, Jaegeuk Kim wrote:
> In direct_IO path of f2fs_file_write_iter(),
> 1. f2fs_preallocate_blocks(F2FS_GET_BLOCK_PRE_DIO)
>    -> allocate LBA X
> 2. f2fs_direct_IO()
>    -> return 0;
> 
> Then,
> f2fs_write_data_page() will allocate another LBA X+1.
> 
> This makes EIO triggered by HM-SMR.

Good catch, :) how do you find this problem?

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/data.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2938311..59203a3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -658,6 +658,13 @@ static int __allocate_data_block(struct dnode_of_data *dn)
>  	return 0;
>  }
>  
> +static inline bool __force_buffered_io(struct inode *inode, int rw)
> +{
> +	return ((f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) ||
> +			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
> +			F2FS_I_SB(inode)->s_ndevs);
> +}
> +
>  int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
> @@ -677,7 +684,10 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  		err = f2fs_convert_inline_inode(inode);
>  		if (err)
>  			return err;
> -		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
> +		return f2fs_map_blocks(inode, &map, 1,
> +			__force_buffered_io(inode, WRITE) ?
> +				F2FS_GET_BLOCK_PRE_AIO :
> +				F2FS_GET_BLOCK_PRE_DIO);
>  	}
>  	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA) {
>  		err = f2fs_convert_inline_inode(inode);
> @@ -1769,11 +1779,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	if (err)
>  		return err;
>  
> -	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> -		return 0;
> -	if (rw == WRITE && test_opt(F2FS_I_SB(inode), LFS))
> -		return 0;
> -	if (F2FS_I_SB(inode)->s_ndevs)
> +	if (__force_buffered_io(inode, rw))
>  		return 0;
>  
>  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
> 

------------------------------------------------------------------------------
