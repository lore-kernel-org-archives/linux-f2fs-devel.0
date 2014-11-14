From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Subject: Re: [PATCH v2] f2fs: implement -o dirsync
Date: Fri, 14 Nov 2014 10:49:44 +0100
Message-ID: <5465D038.5000109@mitrol.it>
References: <1415600662-23337-1-git-send-email-jaegeuk@kernel.org>	<20141110074712.GD14659@lcm>
	<20141110144924.GA25172@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Paolo.Minazzi@mitrol.it>) id 1XpDVs-0005wI-QN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 09:49:56 +0000
Received: from mitrol.it ([82.188.252.170] helo=mail.mitrol.it)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XpDVp-0002xc-Et for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 09:49:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.mitrol.it (Postfix) with ESMTP id 335E286BDD
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 14 Nov 2014 10:49:45 +0100 (CET)
Received: from mail.mitrol.it ([127.0.0.1])
	by localhost (mail.mitrol.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KK17pnNA2n-e
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 14 Nov 2014 10:49:45 +0100 (CET)
Received: from [127.0.0.1] (mypc193.mitrol2000.it [10.0.0.43])
	by mail.mitrol.it (Postfix) with ESMTPA id F1ADA86BC9
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 14 Nov 2014 10:49:44 +0100 (CET)
In-Reply-To: <20141110144924.GA25172@jaegeuk-mac02.hsd1.ca.comcast.net>
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

I tried the patches (fastboot and dirsync) with user mode linux (3.0.101).
It seems works.

Only 2 points :
1) The -o fastboot seems necessary to avoid the recovery at mount.
     I agree.

2)  If I use
         mount -o sync ...
     IS_DIRSYNC(...) is always true! It seems that I do not need -o 
dirsync (-o sync seems enough).
     Do you agree ?

So, finally, it seems to me that if I use
     mount -o sync,fastboot
I mount in synced mode, that is good gor power cut-off.

Now I will investigate stressing my ARM system with power cut-off.
Thanks,
Paolo


Il 10/11/2014 15:49, Jaegeuk Kim ha scritto:
> Change log from v1:
>   o call sync after mark_inode_dirty
>
> If a mount option has dirsync, we should call checkpoint for all the directory
> operations.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/namei.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 6312dd2..2bee559 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -138,6 +138,9 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>   	stat_inc_inline_inode(inode);
>   	d_instantiate(dentry, inode);
>   	unlock_new_inode(inode);
> +
> +	if (IS_DIRSYNC(dir))
> +		f2fs_sync_fs(sbi->sb, 1);
>   	return 0;
>   out:
>   	handle_failed_inode(inode);
> @@ -164,6 +167,9 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
>   	f2fs_unlock_op(sbi);
>   
>   	d_instantiate(dentry, inode);
> +
> +	if (IS_DIRSYNC(dir))
> +		f2fs_sync_fs(sbi->sb, 1);
>   	return 0;
>   out:
>   	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
> @@ -235,6 +241,9 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>   
>   	/* In order to evict this inode, we set it dirty */
>   	mark_inode_dirty(inode);
> +
> +	if (IS_DIRSYNC(dir))
> +		f2fs_sync_fs(sbi->sb, 1);
>   fail:
>   	trace_f2fs_unlink_exit(inode, err);
>   	return err;
> @@ -268,6 +277,9 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
>   
>   	d_instantiate(dentry, inode);
>   	unlock_new_inode(inode);
> +
> +	if (IS_DIRSYNC(dir))
> +		f2fs_sync_fs(sbi->sb, 1);
>   	return err;
>   out:
>   	handle_failed_inode(inode);
> @@ -304,6 +316,8 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>   	d_instantiate(dentry, inode);
>   	unlock_new_inode(inode);
>   
> +	if (IS_DIRSYNC(dir))
> +		f2fs_sync_fs(sbi->sb, 1);
>   	return 0;
>   
>   out_fail:
> @@ -346,8 +360,12 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
>   	f2fs_unlock_op(sbi);
>   
>   	alloc_nid_done(sbi, inode->i_ino);
> +
>   	d_instantiate(dentry, inode);
>   	unlock_new_inode(inode);
> +
> +	if (IS_DIRSYNC(dir))
> +		f2fs_sync_fs(sbi->sb, 1);
>   	return 0;
>   out:
>   	handle_failed_inode(inode);
> @@ -461,6 +479,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	}
>   
>   	f2fs_unlock_op(sbi);
> +
> +	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
> +		f2fs_sync_fs(sbi->sb, 1);
>   	return 0;
>   
>   put_out_dir:
> @@ -600,6 +621,9 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	update_inode_page(new_dir);
>   
>   	f2fs_unlock_op(sbi);
> +
> +	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
> +		f2fs_sync_fs(sbi->sb, 1);
>   	return 0;
>   out_undo:
>   	/* Still we may fail to recover name info of f2fs_inode here */


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
