From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix missing clear FI_NO_PREALLOC in
 some error case
Date: Mon, 23 Apr 2018 16:38:03 +0800
Message-ID: <efa38c26-3700-44d6-8032-157b1498c00f@huawei.com>
References: <1524454564-3299-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fAWzW-0005DJ-Ed
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 08:38:30 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fAWzT-008Ou5-VL
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 08:38:30 +0000
In-Reply-To: <1524454564-3299-1-git-send-email-heyunlei@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/4/23 11:36, Yunlei He wrote:
> This patch clean f2fs_file_write_iter to avoid missing clear
> FI_NO_PREALLOC in some error case.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/file.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 16dad2b..c7dff0b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2894,12 +2894,13 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
> +	int o_direct = iocb->ki_flags & IOCB_DIRECT;
>  	ssize_t ret;
>  
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>  		return -EIO;
>  
> -	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
> +	if ((iocb->ki_flags & IOCB_NOWAIT) && !o_direct)
>  		return -EINVAL;
>  
>  	if (!inode_trylock(inode)) {
> @@ -2910,44 +2911,40 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	ret = generic_write_checks(iocb, from);
>  	if (ret > 0) {
> -		bool preallocated = false;
>  		size_t target_size = 0;
> -		int err;
>  
> -		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
> -			set_inode_flag(inode, FI_NO_PREALLOC);
> -
> -		if ((iocb->ki_flags & IOCB_NOWAIT) &&
> -			(iocb->ki_flags & IOCB_DIRECT)) {
> +		if ((iocb->ki_flags & IOCB_NOWAIT) && o_direct) {
>  				if (!f2fs_overwrite_io(inode, iocb->ki_pos,
>  						iov_iter_count(from)) ||
>  					f2fs_has_inline_data(inode) ||
>  					f2fs_force_buffered_io(inode, WRITE)) {

Just add clear_inode_flag(inode, FI_NO_PREALLOC) here is OK?

Thanks,

> -						inode_unlock(inode);
> -						return -EAGAIN;
> +						ret = -EAGAIN;
> +						goto out;
>  				}
>  
>  		} else {
> -			preallocated = true;
> +			if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
> +				set_inode_flag(inode, FI_NO_PREALLOC);
> +
>  			target_size = iocb->ki_pos + iov_iter_count(from);
>  
> -			err = f2fs_preallocate_blocks(iocb, from);
> -			if (err) {
> -				clear_inode_flag(inode, FI_NO_PREALLOC);
> -				inode_unlock(inode);
> -				return err;
> -			}
> +			ret = f2fs_preallocate_blocks(iocb, from);
> +			if (ret)
> +				goto out;
>  		}
>  		ret = __generic_file_write_iter(iocb, from);
> -		clear_inode_flag(inode, FI_NO_PREALLOC);
>  
>  		/* if we couldn't write data, we should deallocate blocks. */
> -		if (preallocated && i_size_read(inode) < target_size)
> +		if (!is_inode_flag_set(inode, FI_NO_PREALLOC) &&
> +					i_size_read(inode) < target_size)
>  			f2fs_truncate(inode);
>  
>  		if (ret > 0)
>  			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
>  	}
> +
> +out:
> +	clear_inode_flag(inode, FI_NO_PREALLOC);
>  	inode_unlock(inode);
>  
>  	if (ret > 0)
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
