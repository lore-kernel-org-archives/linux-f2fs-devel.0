Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE15C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VaURJEP4WuqheimOtG/i0ApHjb4wZPFbwbZP5oBzrGk=; b=A2hdA5PWLIPuUB17b75d5fDxUe
	KX4HZeNKJ/zYi3zIE3tcr6+22FQp3l6MQ0nhnhv68vSGnRKGGGdoHHOVkkyOpqGuQaA0aQzG9wjhR
	wLtLLtRiSO8HPvzjaht+fOTZAsB/pE3IEwLGv7/Q3kJEIKnQtdM3P9HDo3nTdo2HZH7c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyUXJ-0001xd-UL;
	Mon, 24 Aug 2026 13:16:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyUXI-0001xO-JD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:16:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1vsItVp0tw2GDL/+yV4wrNDhHe2rpHPOp+JTz5Vhrhs=; b=eE2m1cEcoUbvXH8Krs8WsoBGqj
 MMu1dw77Xz3tKRj3Sgjdod6TX0IUctBNHfOM+4lXuhgWyeBSIQDCjCotcz4g7UWrJGJR8eP8XSegt
 fkF+k+zYqZIyCXU6ayRSNzht9p34WkzcVWzrbXwvCUvTOhsuJN1LicOAiifPclI1g/vk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1vsItVp0tw2GDL/+yV4wrNDhHe2rpHPOp+JTz5Vhrhs=; b=fbC21wf/uJak1McaudP7wfPIE0
 5QN9jCoAwbU9VEtSA4dCL/SEGFqO8JrbCB+S/FQI6kuHaEWTrqG8ZgM+CATQLhTOTqSkkovoxdO1C
 +pL7wYgFD+L3FqXTvYSFucBYsHFAw5jJ6rAwqC1FkotdCmHtwV58VtIXJ5e+AkihUDck=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyUXI-0002Zp-I6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:16:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3974140A0D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 13:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5851F000E9;
 Mon, 24 Aug 2026 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787577379;
 bh=1vsItVp0tw2GDL/+yV4wrNDhHe2rpHPOp+JTz5Vhrhs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=GFBn5ZyQr+WxmFYiGcIwGH8bPPpvFARLWRRqK2wqYWXRnC+KeWYecbK632QkuJlvF
 DGBwZhIQBxkG2eGFJzZaZ8jbhOdO11rQF2P1A7Zz6xOHamDscPk668/A/6c1/rTWTu
 hO4cwY96HS3QeQZ8tuBp1q5+WpOI9FiHB8f3Uu4pinPJkkfeLOw8WfqNEKb3cpYH7W
 8OCEpStYeIVNPoAioBr2nHpkCYIrCR/rqiNuVav7uqwW3Ww8NuYntY+t+jMESXWNym
 K+XIEg1/rENfAa+KuA4tHDcdAnKUAr0827O69JaarjiFPtlw4wyQO5lurkeq4TiUva
 r7zN2Bu+J1NZQ==
Message-ID: <6fdbed2f-a28b-4609-bcbc-d29e0364a13c@kernel.org>
Date: Mon, 24 Aug 2026 21:16:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com>
Content-Language: en-US
In-Reply-To: <aohtWfHNbUwxoQg2@google.com>
X-Headers-End: 1wyUXI-0002Zp-I6
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't leave the hashed inode while
 it's unlinked
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

generic/233 may fail on this patch?

On 8/21/26 23:23, Jaegeuk Kim via Linux-f2fs-devel wrote:
> f2fs_symlink()
> 1. f2fs_new_inode
> 2. f2fs_add_link
> 3. write_being|end to fill the symlink path
> 4. flush dirty pages and or checkpoint
> 
> Step 4 is nice to succeed, which doesn't become a reason to roll back
> the created symlink. OTOH, if we get an error till step 3, don't leave
> its dentry and its inode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
>   Change log from v1:
>    - fix bugs
> 
>   fs/f2fs/f2fs.h  |   3 +-
>   fs/f2fs/inode.c |   6 ++-
>   fs/f2fs/namei.c | 101 +++++++++++++++++++++++++-----------------------
>   3 files changed, 60 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index a1f5f375045a..b0a9c14de595 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3878,7 +3878,8 @@ void f2fs_update_inode_page(struct inode *inode);
>   int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
>   void f2fs_remove_donate_inode(struct inode *inode);
>   void f2fs_evict_inode(struct inode *inode);
> -void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc);
> +void f2fs_handle_failed_inode(struct inode *inode,
> +		struct f2fs_lock_context *lc, bool add_orphan);
>   int f2fs_init_evict_inode_work(void);
>   void f2fs_destroy_evict_inode_work(void);
>   
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index bac1e360d966..96cc0e777567 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -1107,7 +1107,8 @@ void f2fs_evict_inode(struct inode *inode)
>   }
>   
>   /* caller should call f2fs_lock_op() */
> -void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc)
> +void f2fs_handle_failed_inode(struct inode *inode,
> +		struct f2fs_lock_context *lc, bool orphan_free)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct node_info ni;
> @@ -1129,6 +1130,9 @@ void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc)
>   	/* don't make bad inode, since it becomes a regular file. */
>   	unlock_new_inode(inode);
>   
> +	if (!orphan_free)
> +		goto out;
> +
>   	/*
>   	 * Note: we should add inode to orphan list before f2fs_unlock_op()
>   	 * so we can prevent losing this orphan when encoutering checkpoint
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 37897f4321c0..4971872edc5f 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -411,7 +411,7 @@ static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
>   	f2fs_balance_fs(sbi, true);
>   	return 0;
>   out:
> -	f2fs_handle_failed_inode(inode, &lc);
> +	f2fs_handle_failed_inode(inode, &lc, true);
>   	return err;
>   }
>   
> @@ -566,38 +566,31 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>   	return ERR_PTR(err);
>   }
>   
> -static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> +static int __do_unlink(struct inode *dir, struct inode *inode,
> +			const struct qstr *name)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
> -	struct inode *inode = d_inode(dentry);
>   	struct f2fs_dir_entry *de;
>   	struct f2fs_lock_context lc;
>   	struct folio *folio;
>   	int err;
>   
> -	trace_f2fs_unlink_enter(dir, dentry);
> -
>   	if (IS_DEVICE_ALIASING(inode))
>   		return -EPERM;
>   
> -	if (unlikely(f2fs_cp_error(sbi))) {
> -		err = -EIO;
> -		goto out;
> -	}
> +	if (unlikely(f2fs_cp_error(sbi)))
> +		return -EIO;
>   
>   	err = f2fs_dquot_initialize(dir);
>   	if (err)
> -		goto out;
> +		return err;
>   	err = f2fs_dquot_initialize(inode);
>   	if (err)
> -		goto out;
> +		return err;
>   
> -	de = f2fs_find_entry(dir, &dentry->d_name, &folio);
> -	if (!de) {
> -		if (IS_ERR(folio))
> -			err = PTR_ERR(folio);
> -		goto out;
> -	}
> +	de = f2fs_find_entry(dir, name, &folio);
> +	if (!de)
> +		return IS_ERR(folio) ? PTR_ERR(folio) : 0;
>   
>   	if (unlikely(inode->i_nlink == 0)) {
>   		f2fs_warn(sbi, "%s: inode (ino=%llx) has zero i_nlink",
> @@ -615,11 +608,28 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>   	err = f2fs_acquire_orphan_inode(sbi);
>   	if (err) {
>   		f2fs_unlock_op(sbi, &lc);
> -		f2fs_folio_put(folio, false);
> -		goto out;
> +		goto err_out;
>   	}
>   	f2fs_delete_entry(de, folio, dir, inode);
>   	f2fs_unlock_op(sbi, &lc);
> +	return 0;
> +
> +corrupted:
> +	err = -EFSCORRUPTED;
> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> +err_out:
> +	f2fs_folio_put(folio, false);
> +	return err;
> +}
> +
> +static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	int err;
> +
> +	trace_f2fs_unlink_enter(dir, dentry);
> +	err = __do_unlink(dir, d_inode(dentry), &dentry->d_name);
> +	if (err)
> +		goto out;
>   
>   	/* VFS negative dentries are incompatible with Encoding and
>   	 * Case-insensitiveness. Eventually we'll want avoid
> @@ -630,19 +640,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>   	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
>   		d_invalidate(dentry);
>   
> -	if (IS_DIRSYNC(dir)) {
> -		err = f2fs_sync_fs(sbi->sb, 1);
> -		if (err)
> -			goto out;
> -	}
> -
> -	goto out;
> -corrupted:
> -	err = -EFSCORRUPTED;
> -	set_sbi_flag(sbi, SBI_NEED_FSCK);
> -	f2fs_folio_put(folio, false);
> +	if (IS_DIRSYNC(dir))
> +		err = f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
>   out:
> -	trace_f2fs_unlink_exit(inode, err);
> +	trace_f2fs_unlink_exit(d_inode(dentry), err);
>   	return err;
>   }
>   
> @@ -669,7 +670,8 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   	struct inode *inode;
>   	size_t len = strlen(symname);
>   	struct fscrypt_str disk_link;
> -	int err;
> +	bool orphan_free = true;
> +	int err, ret;
>   
>   	if (unlikely(f2fs_cp_error(sbi)))
>   		return -EIO;
> @@ -703,13 +705,16 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   	f2fs_unlock_op(sbi, &lc);
>   	f2fs_alloc_nid_done(sbi, inode->i_ino);
>   
> +	/* Write the symlink path to the new inode. */
>   	err = fscrypt_encrypt_symlink(inode, symname, len, &disk_link);
>   	if (err)
> -		goto err_out;
> +		goto unlink_out_f2fs_handle_failed_inode;
>   
>   	err = page_symlink(inode, disk_link.name, disk_link.len);
> +	if (err)
> +		goto unlink_out_f2fs_handle_failed_inode;
>   
> -err_out:
> +give_up:
>   	d_instantiate_new(dentry, inode);
>   
>   	/*
> @@ -721,22 +726,22 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   	 * If the symlink path is stored into inline_data, there is no
>   	 * performance regression.
>   	 */
> -	if (!err) {
> -		err = filemap_write_and_wait_range(inode->i_mapping, 0,
> -						   disk_link.len - 1);
> -
> -		if (!err && IS_DIRSYNC(dir))
> -			err = f2fs_sync_fs(sbi->sb, 1);
> -	}
> -
> -	if (err)
> -		f2fs_unlink(dir, dentry);
> +	ret = filemap_write_and_wait_range(inode->i_mapping, 0,
> +					   disk_link.len - 1);
> +	if (!ret && IS_DIRSYNC(dir))
> +		err = f2fs_sync_fs(sbi->sb, 1);
>   
>   	f2fs_balance_fs(sbi, true);
>   	goto out_free_encrypted_link;
>   
> +unlink_out_f2fs_handle_failed_inode:
> +	err = __do_unlink(dir, inode, &dentry->d_name);
> +	if (err)
> +		goto give_up;
> +	orphan_free = false;
> +	f2fs_lock_op(sbi, &lc);
>   out_f2fs_handle_failed_inode:
> -	f2fs_handle_failed_inode(inode, &lc);
> +	f2fs_handle_failed_inode(inode, &lc, orphan_free);
>   out_free_encrypted_link:
>   	if (disk_link.name != (unsigned char *)symname)
>   		kfree(disk_link.name);
> @@ -789,7 +794,7 @@ static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>   
>   out_fail:
>   	clear_inode_flag(inode, FI_INC_LINK);
> -	f2fs_handle_failed_inode(inode, &lc);
> +	f2fs_handle_failed_inode(inode, &lc, true);
>   	return ERR_PTR(err);
>   }
>   
> @@ -845,7 +850,7 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>   	f2fs_balance_fs(sbi, true);
>   	return 0;
>   out:
> -	f2fs_handle_failed_inode(inode, &lc);
> +	f2fs_handle_failed_inode(inode, &lc, true);
>   	return err;
>   }
>   
> @@ -916,7 +921,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>   release_out:
>   	f2fs_release_orphan_inode(sbi);
>   out:
> -	f2fs_handle_failed_inode(inode, &lc);
> +	f2fs_handle_failed_inode(inode, &lc, true);
>   	return err;
>   }
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
