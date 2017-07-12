From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: remove extra inode_unlock() in error
 path
Date: Wed, 12 Jul 2017 11:00:50 +0800
Message-ID: <3bae535f-8a82-5f50-954e-78d0f4ee4852@kernel.org>
References: <20170711163033.3700-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dV7tl-00009Z-8m
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Jul 2017 03:01:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dV7tk-0005UH-0g
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Jul 2017 03:01:09 +0000
In-Reply-To: <20170711163033.3700-1-lhenriques@suse.com>
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
To: Luis Henriques <lhenriques@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/7/12 0:30, Luis Henriques wrote:
> This commit removes an extra inode_unlock() that is being done in function
> f2fs_ioc_setflags error path.  While there, get rid of a useless 'out'
> label as well.
> 
> Fixes: 0abd675e97e6 ("f2fs: support plain user/group quota")
> Signed-off-by: Luis Henriques <lhenriques@suse.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/file.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a0e6d2c65a9e..2706130c261b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1538,7 +1538,6 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
>  
>  	/* Is it quota file? Do not allow user to mess with it */
>  	if (IS_NOQUOTA(inode)) {
> -		inode_unlock(inode);
>  		ret = -EPERM;
>  		goto unlock_out;
>  	}
> @@ -1549,9 +1548,8 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
>  
>  	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
>  		if (!capable(CAP_LINUX_IMMUTABLE)) {
> -			inode_unlock(inode);
>  			ret = -EPERM;
> -			goto out;
> +			goto unlock_out;
>  		}
>  	}
>  
> @@ -1564,7 +1562,6 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
>  	f2fs_mark_inode_dirty_sync(inode, false);
>  unlock_out:
>  	inode_unlock(inode);
> -out:
>  	mnt_drop_write_file(filp);
>  	return ret;
>  }
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
