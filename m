Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C44C79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Y908LHRM2krECfzc5CK3kdMXWgsfeVhERAmyCeEYBE=; b=STXQ2Duc1/WIMYF6cHsDJbCfjt
	wUX7JfOLFwiF28kZsMeHJ2UeO+WSfzAnNJ6z/d3F/PoQntwv5ZblBWkzAYrzZsusY748DF4pqMq6i
	CvgvwxFhR/6iPh4340luBAzkrdW34YgtElPBlpo267jxnCoKM4Wa6xBsep6PQezsDwRY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4Ghs-0003GA-8Y;
	Wed, 09 Sep 2026 11:43:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4Gho-0003G1-KC
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L5im36+TwSUdsIaIoTknqNBw9/Rj9pDS+TlAizK6I1o=; b=dw8DPkD0183p6529d451eXRbSL
 wBpat+jDnGHYaRsIFyK9oV/WKKQitgUJx2rESKGKVVMs95fQ6iqSY9c3nIsGPhAGXXJncHpv7ydQf
 G/uXV8p7bqNM92pGHZuVhsDNTAgHVrOOHvH3M6RBNzVsbEqJW1R8dbFtfDSk05eHtrpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L5im36+TwSUdsIaIoTknqNBw9/Rj9pDS+TlAizK6I1o=; b=Dv7LHE1tFFhhq1iYZYJi3jCiFN
 L2N+5aWsinJJHK2N9pXSUDYs5CCBfXy/Wm0fdfoHmUQEbVJxcvtKWFYWpMk5IEsFBWMNCqcyuCDMZ
 M6o1OgH7flUkkt/iqy0t6kIFmqj0vLsW3zatVPOMNHw1oYbuh2DUv4vGAJtryqx3GZLw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4Gho-0007hG-1b for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:43:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C9BB43768;
 Wed,  9 Sep 2026 11:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D821F00A3A;
 Wed,  9 Sep 2026 11:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788954182;
 bh=L5im36+TwSUdsIaIoTknqNBw9/Rj9pDS+TlAizK6I1o=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ZHi9THzfg/aU++nHuZqH0xcWmTNlL3TolboXS1+esc52ASBXy6B/wX6+QdB6ok36q
 Ek/LsVFXf5rcgE1GfmfDDRU5a4mWzmMugdCOVd6W1n/fIytsQqqx3rvBnI251i/gg/
 NLPwsfDcjFnNZW1pY49PU3ZA8hK9dLTYkSI9LSgNL4ocMK6i/d/FV7nWOnti0tO0em
 aQC6SfEjJlVtW4srdYo7g8PHN/ltSDmTZ75sMnkqJ2O3HCx7RWiwfY7HQQBy+M8ZhX
 gYKdTXI2wwv5H5c4q0aQex2WKNCcE7JlXU5joVcL/Xujn4thEx4riB5aLqIETzg0i3
 TJKskANxxt8Lg==
Message-ID: <f8098f66-9439-4408-99ee-46538becacc3@kernel.org>
Date: Wed, 9 Sep 2026 19:42:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jianan Huang <jnhuang95@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
References: <20260908034809.616919-1-jnhuang95@gmail.com>
Content-Language: en-US
In-Reply-To: <20260908034809.616919-1-jnhuang95@gmail.com>
X-Headers-End: 1x4Gho-0007hG-1b
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix quota flush failure during
 filesystem freeze
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/8/26 11:48, Jianan Huang wrote:
> Quota flush retries can be exhausted during filesystem freeze.
> 
> freeze_super() and the quota checkpoint may race as below.
> 
> freeze_super()                       f2fs_ckpt
> - down_write(&sb->s_umount)
> - sb->s_writers.frozen = SB_FREEZE_PAGEFAULT
> - sync_filesystem()
>  - f2fs_sync_fs()
>   - f2fs_issue_checkpoint()
>    - queue CP_SYNC -----------------> - block_operations()
>                                       - down_read_trylock(s_umount)
>                                         : fails; freeze holds write lock
>                                       - quota flush retries exhausted
>                                       - set CP_QUOTA_NEED_FSCK_FLAG
> 
> During the PAGEFAULT sync pass, freeze_super() holds s_umount for
> write, but umount_lock_holder is not set until f2fs_freeze().  Thus
> quota writeback tries to acquire s_umount again and can exhaust retries.
> 
> With checkpoint merge enabled, f2fs_issue_checkpoint() may dispatch
> CP_SYNC to f2fs_ckpt.  That thread also cannot acquire the freeze lock.
> 
> Split the F2FS-internal sync implementation from the super-operation
> callback.  For the VFS PAGEFAULT freeze sync, record current as holder
> around the internal sync.  This lets quota writeback use the existing
> lock and makes CP_SYNC run directly in the freeze caller.
> 
> Convert F2FS-internal callers to the internal helper so they cannot be
> mistaken for the freeze owner while the filesystem is frozen.
> 
> Fixes: eb85c2410d6f ("f2fs: quota: fix to avoid warning in dquot_writeback_dquots()")
> Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
> ---
>  fs/f2fs/f2fs.h    |  2 +-
>  fs/f2fs/file.c    |  8 ++++----
>  fs/f2fs/namei.c   | 16 ++++++++--------
>  fs/f2fs/segment.c |  4 ++--
>  fs/f2fs/super.c   | 25 ++++++++++++++++++++++---
>  5 files changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9940a6cecf1a..169792a08a82 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3977,7 +3977,7 @@ void f2fs_quota_off_umount(struct super_block *sb);
>  void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
>  void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
>  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
> -int f2fs_sync_fs(struct super_block *sb, int sync);
> +int __f2fs_sync_fs(struct super_block *sb, int sync);
>  int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
>  
>  /*
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index edc352569e87..83546a053656 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -408,7 +408,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  
>  	if (cp_reason) {
>  		/* all the dirty node pages should be flushed for POR */
> -		ret = f2fs_sync_fs(inode->i_sb, 1);
> +		ret = __f2fs_sync_fs(inode->i_sb, 1);
>  
>  		/*
>  		 * We've secured consistency through sync_fs. Following pino
> @@ -2548,7 +2548,7 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
>  		break;
>  	case F2FS_GOING_DOWN_METASYNC:
>  		/* do checkpoint only */
> -		ret = f2fs_sync_fs(sb, 1);
> +		ret = __f2fs_sync_fs(sb, 1);
>  		if (ret) {
>  			if (ret == -EIO)
>  				ret = 0;
> @@ -2568,7 +2568,7 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
>  		set_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
>  		set_sbi_flag(sbi, SBI_IS_DIRTY);
>  		/* do checkpoint only */
> -		ret = f2fs_sync_fs(sb, 1);
> +		ret = __f2fs_sync_fs(sb, 1);
>  		if (ret == -EIO)
>  			ret = 0;
>  		goto out;
> @@ -2988,7 +2988,7 @@ static int f2fs_ioc_write_checkpoint(struct file *filp)
>  	if (ret)
>  		return ret;
>  
> -	ret = f2fs_sync_fs(sbi->sb, 1);
> +	ret = __f2fs_sync_fs(sbi->sb, 1);
>  
>  	mnt_drop_write_file(filp);
>  	return ret;
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index ff86ee07290d..5f6f5db9e849 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -403,7 +403,7 @@ static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	d_instantiate_new(dentry, inode);
>  
>  	if (IS_DIRSYNC(dir)) {
> -		err = f2fs_sync_fs(sbi->sb, 1);
> +		err = __f2fs_sync_fs(sbi->sb, 1);
>  		if (err)
>  			return err;
>  	}
> @@ -459,7 +459,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
>  	d_instantiate(dentry, inode);
>  
>  	if (IS_DIRSYNC(dir)) {
> -		err = f2fs_sync_fs(sbi->sb, 1);
> +		err = __f2fs_sync_fs(sbi->sb, 1);
>  		if (err)
>  			return err;
>  	}
> @@ -641,7 +641,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>  		d_invalidate(dentry);
>  
>  	if (IS_DIRSYNC(dir))
> -		err = f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
> +		err = __f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
>  out:
>  	trace_f2fs_unlink_exit(d_inode(dentry), err);
>  	return err;
> @@ -729,7 +729,7 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0,
>  					   disk_link.len - 1);
>  	if (!ret && IS_DIRSYNC(dir))
> -		err = f2fs_sync_fs(sbi->sb, 1);
> +		err = __f2fs_sync_fs(sbi->sb, 1);
>  
>  	f2fs_balance_fs(sbi, true);
>  out:
> @@ -787,7 +787,7 @@ static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	d_instantiate_new(dentry, inode);
>  
>  	if (IS_DIRSYNC(dir)) {
> -		err = f2fs_sync_fs(sbi->sb, 1);
> +		err = __f2fs_sync_fs(sbi->sb, 1);
>  		if (err)
>  			return ERR_PTR(err);
>  	}
> @@ -845,7 +845,7 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	d_instantiate_new(dentry, inode);
>  
>  	if (IS_DIRSYNC(dir)) {
> -		err = f2fs_sync_fs(sbi->sb, 1);
> +		err = __f2fs_sync_fs(sbi->sb, 1);
>  		if (err)
>  			return err;
>  	}
> @@ -1148,7 +1148,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	f2fs_unlock_op(sbi, &lc);
>  
>  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
> -		err = f2fs_sync_fs(sbi->sb, 1);
> +		err = __f2fs_sync_fs(sbi->sb, 1);
>  		if (err)
>  			return err;
>  	}
> @@ -1318,7 +1318,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	f2fs_unlock_op(sbi, &lc);
>  
>  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
> -		err = f2fs_sync_fs(sbi->sb, 1);
> +		err = __f2fs_sync_fs(sbi->sb, 1);
>  		if (err)
>  			return err;
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 63b712d3d599..9a09f2525b70 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -550,7 +550,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
>  		mutex_unlock(&sbi->flush_lock);
>  	}
>  	stat_inc_cp_call_count(sbi, BACKGROUND);
> -	f2fs_sync_fs(sbi->sb, 1);
> +	__f2fs_sync_fs(sbi->sb, 1);
>  }
>  
>  static int __submit_flush_wait(struct f2fs_sb_info *sbi,
> @@ -3478,7 +3478,7 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
>  				true, ZONED_PIN_SEC_REQUIRED_COUNT, true);
>  		if (err)
>  			return err;
> -		err = f2fs_sync_fs(sbi->sb, 1);
> +		err = __f2fs_sync_fs(sbi->sb, 1);
>  		if (!err) {
>  			gc_required = false;
>  			goto retry;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1314b6ccced9..a82065146849 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2131,7 +2131,7 @@ static void f2fs_put_super(struct super_block *sb)
>  	}
>  }
>  
> -int f2fs_sync_fs(struct super_block *sb, int sync)
> +int __f2fs_sync_fs(struct super_block *sb, int sync)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	int err = 0;
> @@ -2154,6 +2154,25 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
>  	return err;
>  }
>  
> +static int f2fs_sync_fs(struct super_block *sb, int sync)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	bool freeze_sync = sync &&
> +			sb->s_writers.frozen == SB_FREEZE_PAGEFAULT;

How about this to make sure freeze_sync will only be true in freeze_super()?

bool freeze_sync = sync && rwsem_is_locked(&sb->s_umount) &&
			sb->s_writers.frozen == SB_FREEZE_PAGEFAULT;

And it's not needed to rename f2fs_sync_fs() to __f2fs_sync_fs()?

Thanks,

> +	int err;
> +
> +	/* freeze_super() holds s_umount for write during this sync pass. */
> +	if (freeze_sync)
> +		sbi->umount_lock_holder = current;
> +
> +	err = __f2fs_sync_fs(sb, sync);
> +
> +	if (freeze_sync)
> +		sbi->umount_lock_holder = NULL;
> +
> +	return err;
> +}
> +
>  static int f2fs_freeze(struct super_block *sb)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> @@ -2807,7 +2826,7 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
>  	set_sbi_flag(sbi, SBI_IS_DIRTY);
>  	f2fs_up_write_trace(&sbi->gc_lock, &lc);
>  
> -	ret = f2fs_sync_fs(sbi->sb, 1);
> +	ret = __f2fs_sync_fs(sbi->sb, 1);
>  	if (ret)
>  		f2fs_err(sbi, "%s sync_fs failed, ret: %d", __func__, ret);
>  
> @@ -2993,7 +3012,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
>  
>  		set_sbi_flag(sbi, SBI_IS_DIRTY);
>  		set_sbi_flag(sbi, SBI_IS_CLOSE);
> -		err = f2fs_sync_fs(sb, 1);
> +		err = __f2fs_sync_fs(sb, 1);
>  		if (err)
>  			goto restore_gc;
>  		clear_sbi_flag(sbi, SBI_IS_CLOSE);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
