From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH v2 2/2] f2fs: do not set LOST_PINO for
 renamed dir
Date: Sat, 1 Jul 2017 08:10:39 -0700
Message-ID: <20170701151039.GD901@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170626024136.211772-1-shengyong1@huawei.com>
	<20170626024136.211772-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dRK2r-0006LF-Of
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Jul 2017 15:10:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dRK2n-0008SA-B7
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Jul 2017 15:10:49 +0000
Content-Disposition: inline
In-Reply-To: <20170626024136.211772-2-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On 06/26, Sheng Yong wrote:
> After renaming a directory, fsck could detect unmatched pino. The scenario
> can be reproduced as the following:
> 
> 	$ mkdir /bar/subbar /foo
> 	$ rename /bar/subbar /foo
> 
> Then fsck will report:
> [ASSERT] (__chk_dots_dentries:1182)  --> Bad inode number[0x3] for '..', parent parent ino is [0x4]

Does fsck report this? If LOST_PINO is found, it must skip parent ino?

> 
> Rename sets LOST_PINO for old_inode. However, the flag cannot be cleared,
> since dir is written back with CP. So, let's get rid of LOST_PINO for a
> renamed dir and fix the pino directly at the end of rename.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fs/f2fs/namei.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
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
> -- 
> 2.11.0
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
