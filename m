From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: invalidate inode and data pages if
 inode is no longer used
Date: Thu, 25 Aug 2016 19:59:45 +0800
Message-ID: <79f3d1c0-63b6-c0ba-3e50-e75598083cb2@huawei.com>
References: <20160825023419.82566-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bctKI-0003CO-0w
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 12:00:06 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bctKD-00044o-V7
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 12:00:06 +0000
In-Reply-To: <20160825023419.82566-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2016/8/25 10:34, Jaegeuk Kim wrote:
> When a file is closed, let's deactivate inode page to mitigate further memory
> pressure. We can do data pages as well in the corner case of f2fs_drop_inode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c  | 4 ++++
>  fs/f2fs/super.c | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e460211..5f9a6dc 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1465,6 +1465,10 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
>  		filemap_fdatawrite(inode->i_mapping);
>  		clear_inode_flag(inode, FI_DROP_CACHE);
>  	}
> +
> +	/* deactivate written inode page */
> +	invalidate_mapping_pages(NODE_MAPPING(F2FS_I_SB(inode)),
> +					inode->i_ino, inode->i_ino);

Seems if the file was opened by two processes, one process closes this file,
another one will loss page cache of inode. I'm not sure whether this predication
is friendly to user.

>  	return 0;
>  }
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7f863a6..f84696d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -618,6 +618,7 @@ static int f2fs_drop_inode(struct inode *inode)
>  			sb_end_intwrite(inode->i_sb);
>  
>  			fscrypt_put_encryption_info(inode, NULL);
> +			invalidate_mapping_pages(inode->i_mapping, 0, -1);

Hmm, shouldn't we truncate page cache before f2fs_truncate() like we do in
f2fs_evict?

Thanks,

>  			spin_lock(&inode->i_lock);
>  			atomic_dec(&inode->i_count);
>  		}
> 


------------------------------------------------------------------------------
