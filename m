From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/7] f2fs: enhance multithread dio write performance
Date: Tue, 15 Sep 2015 14:20:44 -0700
Message-ID: <20150915212044.GA84514@jaegeuk-mac02.mot.com>
References: <000001d0ec5d$0bbd1880$23374980$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000001d0ec5d$0bbd1880$23374980$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Fri, Sep 11, 2015 at 02:41:53PM +0800, Chao Yu wrote:
> When dio writes perform concurrently, our performace will be low because of
> Thread A's allocation of multi continuous blocks will be break by Thread B,
> there are two cases as below:
>  - In Thread B, we may change current segment to a new segment for LFS
>    allocation if we dio write in the beginning of the file.
>  - In Thread B, we may allocate blocks in the middle of Thread A's
>    allocation, which make blocks which allocated in Thread A being
>    discontinuous.
> 
> This patch adds writepages mutex lock to make block allocation in dio write
> atomic to avoid above issues.
> 
> Test environment:
> ubuntu os with linux kernel 4.2+, intel i7-3770, 16g memory,
> 32g kingston sd card.
> 
> fio --name seqw --ioengine=sync --invalidate=1 --rw=write --directory=/mnt/f2fs --filesize=256m --size=16m --bs=2m --direct=1
> --numjobs=10
> 
> before:
>   WRITE: io=163840KB, aggrb=3145KB/s, minb=314KB/s, maxb=411KB/s, mint=39836msec, maxt=52083msec
> 
> patched:
>   WRITE: io=163840KB, aggrb=10033KB/s, minb=1003KB/s, maxb=1124KB/s, mint=14565msec, maxt=16329msec
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/data.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a737ca5..a0a5849 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1536,7 +1536,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  	struct file *file = iocb->ki_filp;
>  	struct address_space *mapping = file->f_mapping;
>  	struct inode *inode = mapping->host;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	size_t count = iov_iter_count(iter);
> +	int rw = iov_iter_rw(iter);
>  	int err;
>  
>  	/* we don't need to use inline_data strictly */
> @@ -1555,12 +1557,17 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
>  
> -	if (iov_iter_rw(iter) == WRITE)
> +	if (rw == WRITE) {
> +		mutex_lock(&sbi->writepages);

Why do we have to share sbi->writepages?

>  		__allocate_data_blocks(inode, offset, count);

If the problem lies on the misaligned blocks, how about calling mutex_unlock
here?

Thanks,

> +	}
>  
>  	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
> -	if (err < 0 && iov_iter_rw(iter) == WRITE)
> -		f2fs_write_failed(mapping, offset + count);
> +	if (rw == WRITE) {
> +		mutex_unlock(&sbi->writepages);
> +		if (err)
> +			f2fs_write_failed(mapping, offset + count);
> +	}
>  
>  	trace_f2fs_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), err);
>  
> -- 
> 2.4.2
