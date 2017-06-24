From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH] f2fs: do not set LOST_PINO for
 created/renamed dir
Date: Sat, 24 Jun 2017 23:12:16 +0800
Message-ID: <6c8726e9-add3-fca8-902c-4624c6180d30@kernel.org>
References: <20170622064726.35016-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dOmkD-00055G-Ef
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Jun 2017 15:13:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dOmkC-0007yC-Bi
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Jun 2017 15:13:05 +0000
In-Reply-To: <20170622064726.35016-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Sheng Yong,

On 2017/6/22 14:47, Sheng Yong wrote:
> Since directories will be written back with checkpoint and fsync a
> directory will always write CP, there is no need to set LOST_PINO

Could you make another patch to fix unneeded flag setting in directory?

Thanks,

> after creating or renaming a directory. During rename, fix dir's
> p_ino directly. Otherwise, fsck will find out that the pino does
> not match. The scenario can be reproduced as the following:
> 
> 	$ mkdir /bar/subbar /foo
> 	$ rename /bar/subbar /foo
> 
> Then fsck will report:
> [ASSERT] (__chk_dots_dentries:1182)  --> Bad inode number[0x3] for '..', parent parent ino is [0x4]>
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fs/f2fs/dir.c   | 3 ++-
>  fs/f2fs/namei.c | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 94756f55a97e..37f9c7f55605 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -415,7 +415,8 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
>  	 * We lost i_pino from now on.
>  	 */
>  	if (is_inode_flag_set(inode, FI_INC_LINK)) {
> -		file_lost_pino(inode);
> +		if (!S_ISDIR(inode->i_mode))
> +			file_lost_pino(inode);
>  		/*
>  		 * If link the tmpfile to alias through linkat path,
>  		 * we should remove this inode from orphan list.
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index c31b40e5f9cf..b75dc2f4ad57 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -772,7 +772,10 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	}
>  
>  	down_write(&F2FS_I(old_inode)->i_sem);
> -	file_lost_pino(old_inode);
> +	if (!old_dir_entry || whiteout)
> +		file_lost_pino(old_inode);
> +	else
> +		F2FS_I(old_inode)->i_pino = new_dir->i_ino;
>  	up_write(&F2FS_I(old_inode)->i_sem);
>  
>  	old_inode->i_ctime = current_time(old_inode);
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
