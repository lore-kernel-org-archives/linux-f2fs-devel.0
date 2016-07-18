From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: support copy_file_range
Date: Mon, 18 Jul 2016 10:19:31 -0700
Message-ID: <20160718171931.GA59235@jaegeuk>
References: <20160717062427.56718-1-jaegeuk@kernel.org>
	<20160717062427.56718-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bPCCj-0002My-K4
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Jul 2016 17:19:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bPCCi-0007BW-Gn
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Jul 2016 17:19:41 +0000
Content-Disposition: inline
In-Reply-To: <20160717062427.56718-2-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

Please ignore copy/clone_file_range patches, which are wrong implementation.
Sorry for the noise.

Thanks,

On Sat, Jul 16, 2016 at 11:24:26PM -0700, Jaegeuk Kim wrote:
> This patch implements copy_file_range in f2fs.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 3573b07..c2b7e35 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2215,6 +2215,103 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	return ret;
>  }
>  
> +static int f2fs_clone_files(struct file *file_in, loff_t pos_in,
> +				struct file *file_out, loff_t pos_out,
> +				size_t len)
> +{
> +	struct inode *src = file_inode(file_in);
> +	struct inode *dst = file_inode(file_out);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(src);
> +	size_t olen = len, dst_max_i_size = 0;
> +	size_t dst_osize;
> +	int ret;
> +
> +	if (file_in->f_path.mnt != file_out->f_path.mnt ||
> +				src->i_sb != dst->i_sb)
> +		return -EXDEV;
> +
> +	if (unlikely(f2fs_readonly(src->i_sb)))
> +		return -EROFS;
> +
> +	if (S_ISDIR(src->i_mode) || S_ISDIR(dst->i_mode))
> +		return -EISDIR;
> +
> +	inode_lock(src);
> +	if (src != dst)
> +		inode_lock(dst);
> +
> +	ret = -EINVAL;
> +	if (pos_in + len > src->i_size || pos_in + len < pos_in)
> +		goto out_unlock;
> +	if (len == 0)
> +		olen = len = src->i_size - pos_in;
> +	if (pos_in + len == src->i_size)
> +		len = ALIGN(src->i_size, F2FS_BLKSIZE) - pos_in;
> +	if (len == 0) {
> +		ret = 0;
> +		goto out_unlock;
> +	}
> +
> +	dst_osize = dst->i_size;
> +	if (pos_out + olen > dst->i_size)
> +		dst_max_i_size = pos_out + olen;
> +
> +	/* verify the end result is block aligned */
> +	if (!IS_ALIGNED(pos_in, F2FS_BLKSIZE) ||
> +			!IS_ALIGNED(pos_in + len, F2FS_BLKSIZE) ||
> +			!IS_ALIGNED(pos_out, F2FS_BLKSIZE))
> +		goto out_unlock;
> +
> +	ret = f2fs_convert_inline_inode(src);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = f2fs_convert_inline_inode(dst);
> +	if (ret)
> +		goto out_unlock;
> +
> +	/* write out all dirty pages from offset */
> +	ret = filemap_write_and_wait_range(src->i_mapping,
> +					pos_in, pos_in + len);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = filemap_write_and_wait_range(dst->i_mapping,
> +					pos_out, pos_out + len);
> +	if (ret)
> +		goto out_unlock;
> +
> +	f2fs_balance_fs(sbi, true);
> +	f2fs_lock_op(sbi);
> +	ret = __exchange_data_block(src, dst, pos_in,
> +				pos_out, len >> F2FS_BLKSIZE_BITS, false);
> +
> +	if (!ret) {
> +		if (dst_max_i_size)
> +			f2fs_i_size_write(dst, dst_max_i_size);
> +		else if (dst_osize != dst->i_size)
> +			f2fs_i_size_write(dst, dst_osize);
> +	}
> +	f2fs_unlock_op(sbi);
> +out_unlock:
> +	if (src != dst)
> +		inode_unlock(dst);
> +	inode_unlock(src);
> +	return ret;
> +}
> +
> +ssize_t f2fs_copy_file_range(struct file *file_in, loff_t pos_in,
> +		struct file *file_out, loff_t pos_out,
> +		size_t len, unsigned int flags)
> +{
> +	ssize_t ret;
> +
> +	ret = f2fs_clone_files(file_in, pos_in, file_out, pos_out, len);
> +	if (!ret)
> +		ret = len;
> +	return ret;
> +}
> +
>  #ifdef CONFIG_COMPAT
>  long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> @@ -2261,6 +2358,7 @@ const struct file_operations f2fs_file_operations = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl	= f2fs_compat_ioctl,
>  #endif
> +	.copy_file_range = f2fs_copy_file_range,
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  };
> -- 
> 2.8.3

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
