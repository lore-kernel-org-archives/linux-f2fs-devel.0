From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/8] f2fs: clear nlink if fail to add_link
Date: Tue, 11 Oct 2016 15:19:03 -0700
Message-ID: <20161011221903.GA92615@jaegeuk>
References: <20161011145706.5028-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bu5OE-0000f4-8p
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 22:19:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bu5OC-0002xl-9V
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 22:19:14 +0000
Content-Disposition: inline
In-Reply-To: <20161011145706.5028-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Tue, Oct 11, 2016 at 10:56:59PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> We don't need to keep incomplete created inode in cache, so if we fail to
> add link into directory during new inode creation, it's better to set
> nlink of inode to zero, then we can evict inode immediately. Otherwise
> release of nid belong to inode will be delayed until inode cache is being
> shrunk, it may cause a seemingly endless loop while allocating free nids
> in time of testing generic/269 case of fstest suit.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index d736989..34ae03c 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -384,6 +384,8 @@ retry:
>  		f2fs_lock_op(sbi);
>  		err = remove_inode_page(inode);
>  		f2fs_unlock_op(sbi);
> +		if (err == -ENOENT)
> +			err = 0;
>  	}
>  
>  	/* give more chances, if ENOMEM case */
> @@ -424,6 +426,12 @@ void handle_failed_inode(struct inode *inode)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct node_info ni;
>  
> +	/*
> +	 * clear nlink of inode in order to release resource of inode
> +	 * immediately.
> +	 */
> +	clear_nlink(inode);

We must call update_inode_page() here to avoid kernel panic.
Otherwise, this inode is kept in the gdirty list, resulting in kernel panic
when flushg dirty inodes, since it was already evicted.

I fixed this and started a round of tests.

Thanks,

> +
>  	/* don't make bad inode, since it becomes a regular file. */
>  	unlock_new_inode(inode);
>  
> -- 
> 2.10.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
