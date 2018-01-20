From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: correct removexattr behavior for null
 valued extended attribute
Date: Sat, 20 Jan 2018 14:04:14 -0800
Message-ID: <20180120220414.GA28167@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180120074633.3277-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ed1FN-0001SY-GG
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:04:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ed1FM-0003aQ-NH
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:04:21 +0000
Content-Disposition: inline
In-Reply-To: <20180120074633.3277-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Thanks,

On 01/20, Chao Yu wrote:
> From: Daeho Jeong <daeho.jeong@samsung.com>
> 
> __vfs_removexattr() transfers "NULL" value to the setxattr handler of
> the f2fs filesystem in order to remove the extended attribute. But,
> __f2fs_setxattr() just ignores the removal request when the value of
> the extended attribute is already NULL. We have to remove the extended
> attribute itself even if the value of that is already NULL.
> 
> We can reporduce this bug with the below:
> 
> 1. touch file
> 2. setfattr -n "user.foo" file
> 3. setfattr -x "user.foo" file
> 4. getfattr -d file
> > user.foo
> 
> Signed-off-by: Daeho Jeong <daeho.jeong@samsung.com>
> Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
> Tested-by: Hobin Woo <hobin.woo@samsung.com>
> Tested-by: Chao Yu <yuchao0@huawei.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 600162f4ddbf..ae2dfa709f5d 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -600,7 +600,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>  			goto exit;
>  		}
>  
> -		if (f2fs_xattr_value_same(here, value, size))
> +		if (value && f2fs_xattr_value_same(here, value, size))
>  			goto exit;
>  	} else if ((flags & XATTR_REPLACE)) {
>  		error = -ENODATA;
> -- 
> 2.14.1.145.gb3622a4ee

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
