From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: relax permission for atomic/volatile
 ioctls
Date: Fri, 7 Jul 2017 08:04:32 +0800
Message-ID: <8346aeca-c28b-e5b9-5973-b5648b015c88@kernel.org>
References: <20170706022326.52594-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dTGmE-0004oR-Lg
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 00:05:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dTGmD-0005r6-Un
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 00:05:42 +0000
In-Reply-To: <20170706022326.52594-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/7/6 10:23, Jaegeuk Kim wrote:
> This patch allows atomic/volatile ioctls for sqlite under sdcardfs.

Out of curiosity, we will lose some capable when passing through sdcardfs?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>> ---
>  fs/f2fs/file.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f5d6357e8360..dd8f5d2caa48 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1587,9 +1587,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  	struct inode *inode = file_inode(filp);
>  	int ret;
>  
> -	if (!inode_owner_or_capable(inode))
> -		return -EACCES;
> -
>  	if (!S_ISREG(inode->i_mode))
>  		return -EINVAL;
>  
> @@ -1636,9 +1633,6 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>  	struct inode *inode = file_inode(filp);
>  	int ret;
>  
> -	if (!inode_owner_or_capable(inode))
> -		return -EACCES;
> -
>  	ret = mnt_want_write_file(filp);
>  	if (ret)
>  		return ret;
> @@ -1672,9 +1666,6 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
>  	struct inode *inode = file_inode(filp);
>  	int ret;
>  
> -	if (!inode_owner_or_capable(inode))
> -		return -EACCES;
> -
>  	if (!S_ISREG(inode->i_mode))
>  		return -EINVAL;
>  
> @@ -1707,9 +1698,6 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
>  	struct inode *inode = file_inode(filp);
>  	int ret;
>  
> -	if (!inode_owner_or_capable(inode))
> -		return -EACCES;
> -
>  	ret = mnt_want_write_file(filp);
>  	if (ret)
>  		return ret;
> @@ -1736,9 +1724,6 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
>  	struct inode *inode = file_inode(filp);
>  	int ret;
>  
> -	if (!inode_owner_or_capable(inode))
> -		return -EACCES;
> -
>  	ret = mnt_want_write_file(filp);
>  	if (ret)
>  		return ret;
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
