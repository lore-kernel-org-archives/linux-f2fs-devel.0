From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: fix the fault of checking
 F2FS_LINK_MAX for rename inode
Date: Mon, 6 Mar 2017 18:54:43 +0800
Message-ID: <6b0fad9a-93ca-3a3a-1990-e55a82668ede@huawei.com>
References: <02f41895-ea36-df3c-1295-46fa960b20bd@gmail.com>
	<5aa9764c-4885-0054-9e6b-53e9b0f41691@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ckqIB-0003g5-1Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 10:55:03 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ckqI8-000456-Tt
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 10:55:03 +0000
In-Reply-To: <5aa9764c-4885-0054-9e6b-53e9b0f41691@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/4 21:48, Kinglong Mee wrote:
> The parent directory's nlink will change, not the inode.
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 0eda022..3231a0a 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -908,8 +908,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		old_nlink = old_dir_entry ? -1 : 1;
>  		new_nlink = -old_nlink;
>  		err = -EMLINK;
> -		if ((old_nlink > 0 && old_inode->i_nlink >= F2FS_LINK_MAX) ||
> -			(new_nlink > 0 && new_inode->i_nlink >= F2FS_LINK_MAX))
> +		if ((old_nlink > 0 && old_dir->i_nlink >= F2FS_LINK_MAX) ||
> +			(new_nlink > 0 && new_dir->i_nlink >= F2FS_LINK_MAX))
>  			goto out_new_dir;
>  	}
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
