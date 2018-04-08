From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: remove nested usage of plug list
Date: Sun, 8 Apr 2018 11:43:23 +0800
Message-ID: <07fad76c-1026-8e61-41c3-3a9b419a44b6@huawei.com>
References: <1523156386-25729-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f51FB-0006Zi-Dw
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 03:43:53 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f51F8-002NT0-LC
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 03:43:53 +0000
In-Reply-To: <1523156386-25729-1-git-send-email-heyunlei@huawei.com>
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

On 2018/4/8 10:59, Yunlei He wrote:
> -f2fs_file_write_iter
>   -blk_start_plug
>     -__generic_file_write_iter
> 	...
> 	  -do_blockdev_direct_IO
> 	    -blk_start_plug
> 		...
> 	    -blk_finish_plug
> 	...
>   -blk_finish_plug
> 
> which may conduct performance decrease in our platform

Have sent this before, let me integrate your description into mine and add
signed-off, anyway, well cleanup job! ;)

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/file.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6b94f19..977c800 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2894,7 +2894,6 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
> -	struct blk_plug plug;
>  	ssize_t ret;
>  
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
> @@ -2939,9 +2938,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  				return err;
>  			}
>  		}
> -		blk_start_plug(&plug);
>  		ret = __generic_file_write_iter(iocb, from);
> -		blk_finish_plug(&plug);
>  		clear_inode_flag(inode, FI_NO_PREALLOC);
>  
>  		/* if we couldn't write data, we should deallocate blocks. */
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
