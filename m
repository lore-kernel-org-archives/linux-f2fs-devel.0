From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH] f2fs: reposition unlock_new_inode to prevent
 accessing invalid inode
Date: Thu, 28 Aug 2014 10:47:36 +0900
Message-ID: <20140828014736.GA6808@lcm>
References: <009101cfc119$8e7a5a00$ab6f0e00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1XMopn-0000l4-7p
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Aug 2014 01:49:07 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XMopk-0003ar-V3
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Aug 2014 01:49:07 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0NAZ00JQ7UDLN4B0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Aug 2014 10:48:57 +0900 (KST)
Content-disposition: inline
In-reply-to: <009101cfc119$8e7a5a00$ab6f0e00$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

I agree it's correct unlock_new_inode should be located after make_bad_inode.

About this scenario,
I think we should check some condition if this could be occured;
A inode allocated newly could be victim by gc thread.
Then, f2fs_iget called by Thread A have to fail because we handled it as
bad_inode in Thread B. However, f2fs_iget could still get inode.
How about check it using is_bad_inode() in f2fs_iget.

Thanks,

On Tue, Aug 26, 2014 at 06:35:29PM +0800, Chao Yu wrote:
> As the race condition on the inode cache, following scenario can appear:
> [Thread a]				[Thread b]
> 					->f2fs_mkdir
> 					  ->f2fs_add_link
> 					    ->__f2fs_add_link
> 					      ->init_inode_metadata failed here
> ->gc_thread_func
>   ->f2fs_gc
>     ->do_garbage_collect
>       ->gc_data_segment
>         ->f2fs_iget
>           ->iget_locked
>             ->wait_on_inode
> 					  ->unlock_new_inode
>         ->move_data_page
> 					  ->make_bad_inode
> 					  ->iput
> 
> When we fail in create/symlink/mkdir/mknod/tmpfile, the new allocated inode
> should be set as bad to avoid being accessed by other thread. But in above
> scenario, it allows f2fs to access the invalid inode before this inode was set
> as bad.
> This patch fix the potential problem, and this issue was found by code review.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/namei.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 6b53ce9..845f1be 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -134,8 +134,8 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>  	return 0;
>  out:
>  	clear_nlink(inode);
> -	unlock_new_inode(inode);
>  	make_bad_inode(inode);
> +	unlock_new_inode(inode);
>  	iput(inode);
>  	alloc_nid_failed(sbi, ino);
>  	return err;
> @@ -267,8 +267,8 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
>  	return err;
>  out:
>  	clear_nlink(inode);
> -	unlock_new_inode(inode);
>  	make_bad_inode(inode);
> +	unlock_new_inode(inode);
>  	iput(inode);
>  	alloc_nid_failed(sbi, inode->i_ino);
>  	return err;
> @@ -308,8 +308,8 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>  out_fail:
>  	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
>  	clear_nlink(inode);
> -	unlock_new_inode(inode);
>  	make_bad_inode(inode);
> +	unlock_new_inode(inode);
>  	iput(inode);
>  	alloc_nid_failed(sbi, inode->i_ino);
>  	return err;
> @@ -354,8 +354,8 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
>  	return 0;
>  out:
>  	clear_nlink(inode);
> -	unlock_new_inode(inode);
>  	make_bad_inode(inode);
> +	unlock_new_inode(inode);
>  	iput(inode);
>  	alloc_nid_failed(sbi, inode->i_ino);
>  	return err;
> @@ -688,8 +688,8 @@ release_out:
>  out:
>  	f2fs_unlock_op(sbi);
>  	clear_nlink(inode);
> -	unlock_new_inode(inode);
>  	make_bad_inode(inode);
> +	unlock_new_inode(inode);
>  	iput(inode);
>  	alloc_nid_failed(sbi, inode->i_ino);
>  	return err;
> -- 
> 2.0.0.421.g786a89d
> 
> 
> 
> ------------------------------------------------------------------------------
> Slashdot TV.  
> Video for Nerds.  Stuff that matters.
> http://tv.slashdot.org/
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
