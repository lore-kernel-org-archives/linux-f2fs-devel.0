From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 10/11] f2fs: avoid checkpoint when error
	was	occurred
Date: Tue, 29 Jul 2014 19:41:35 +0800
Message-ID: <008301cfab22$27e34fc0$77a9ef40$@samsung.com>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
	<1406328445-63707-10-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XC5nc-0005xN-D2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 11:42:32 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XC5nZ-0000Bh-3H
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 11:42:30 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9H004281UL6W60@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 20:42:21 +0900 (KST)
In-reply-to: <1406328445-63707-10-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, July 26, 2014 6:47 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 10/11] f2fs: avoid checkpoint when error was occurred
> 
> No need to do checkpoint, whenever any errors were detected.
> 

The code here is modified once at below commit for avoid unneeded cp.
You can see the reason through the description of the commit.

Commit 691c6fd2a2d6 ("remove unneeded write checkpoint in recover_fsync_data")

"Previously, recover_fsync_data still to write checkpoint when there is
nothing to recover with normal umount image.
It may reduce mount performance and flash memory lifetime, so let's remove
it."

Why we should revert the commit?

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/recovery.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index a112368..90d7e80 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -436,7 +436,6 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
>  {
>  	struct list_head inode_list;
>  	int err;
> -	bool need_writecp = false;
> 
>  	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
>  			sizeof(struct fsync_inode_entry));
> @@ -454,8 +453,6 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
>  	if (list_empty(&inode_list))
>  		goto out;
> 
> -	need_writecp = true;
> -
>  	/* step #2: recover data */
>  	err = recover_data(sbi, &inode_list, CURSEG_WARM_NODE);
>  	f2fs_bug_on(!list_empty(&inode_list));
> @@ -463,7 +460,7 @@ out:
>  	destroy_fsync_dnodes(&inode_list);
>  	kmem_cache_destroy(fsync_entry_slab);
>  	sbi->por_doing = false;
> -	if (!err && need_writecp)
> +	if (!err)
>  		write_checkpoint(sbi, false);
>  	return err;
>  }
> --
> 1.8.5.2 (Apple Git-48)
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
