From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: don't bother with inode->i_version
Date: Wed, 1 Nov 2017 10:14:11 +0800
Message-ID: <1836bd00-d64e-feb5-4033-8ffd5934f47f@huawei.com>
References: <20171030151156.6418-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e9iY0-0000Ly-Oz
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Nov 2017 02:14:28 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e9iXy-0003gQ-Si
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Nov 2017 02:14:28 +0000
In-Reply-To: <20171030151156.6418-1-jlayton@kernel.org>
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
To: Jeff Layton <jlayton@kernel.org>, jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/30 23:11, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> f2fs does not set the SB_I_VERSION flag, so the i_version will never
> be incremented on write. It was recently changed to increment the
> i_version on a quota write, which isn't necessary here.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/super.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 933c3d529e65..b3359158e7be 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -618,7 +618,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>  	init_once((void *) fi);
>  
>  	/* Initialize f2fs-specific inode info */
> -	fi->vfs_inode.i_version = 1;
>  	atomic_set(&fi->dirty_pages, 0);
>  	fi->i_current_depth = 1;
>  	fi->i_advise = 0;
> @@ -1386,7 +1385,6 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
>  
>  	if (len == towrite)
>  		return 0;
> -	inode->i_version++;
>  	inode->i_mtime = inode->i_ctime = current_time(inode);
>  	f2fs_mark_inode_dirty_sync(inode, false);
>  	return len - towrite;
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
