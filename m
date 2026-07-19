Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E5DC44512
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Jul 2026 08:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WcMIm0hMICUImSdHsKGyyXhSJ/F0NJ6dqkAz/S/dz8U=; b=hWSeMmLH2/vBIA+l6JEuz9/zdV
	tzhxpM4rlexMBDnO7Ko3eKO/PRTNvQ6lGwfF05qDW6no2szdQXwJA9uTBqLotr8q7RTHT80JYhKWy
	DAwSS+4hZtE0Svut0Ifd+92wKZ31NrfO7G25HUzuIGgBbwe+SV/jzO57Nnm7LHu7neU0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlNHv-0005Is-Ew;
	Sun, 19 Jul 2026 08:54:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wlNHu-0005Il-9w
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 08:54:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sl7YdX0GzVEdEhMSfbeJFjaxuq7nduJKG0GxhZmzhTs=; b=kDKzRS0cLsgmReLi/tcUb33p2y
 FX2D97I10AiDo5IM9xq/1dNS1/iV+NJtuI11e0sM7GHmcHSiaJ9MyAlClQRouxAhHYvHlzeFAeAXv
 8qCVsCono3Y+YA0PIBJvEa0WYaKTxnt/LQeijPV+EszKBN06JTCOFn38LNM4ICvWOliw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sl7YdX0GzVEdEhMSfbeJFjaxuq7nduJKG0GxhZmzhTs=; b=jA53ojg8OWV0D9TaiYq6v1jESx
 Fe1h5Pd4bklxaVwG+1Jvca6g+29W7wNWhIlK+pc7NuL59vYInF5P8yyJpfC/3MfQHN6wn5MRiWJyL
 kC3olfAQZlya0moUVRVebrls5qOH3jPHSJx41Ae5AieS2pfa9AVokWWs4UJZ912v5DEs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlNHt-0004Sn-8D for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 08:54:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD14142E3F;
 Sun, 19 Jul 2026 08:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6B11F000E9;
 Sun, 19 Jul 2026 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784451251;
 bh=sl7YdX0GzVEdEhMSfbeJFjaxuq7nduJKG0GxhZmzhTs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Ea5hP0qr0r8CFBm9KJ6dEUZDGXmlONHVgbHNe2AdPENFBjzrv+JcgM0xRd721yI9D
 AoXTm8UPdIrcEYs1ex2tJx51DC8766ZZhiNSEedImVs1eiEr+GSQLk25d/x7FFTbIo
 rmsTBxY4MbXJAxcr+ZaJWxjnsaNaB76YdCp4VrY1yttF1bIUWac20H2y9TekLRqeRP
 xzO1zBlX6M7c5SoCf3tPJb8dFkw5QUa/M7LSnd6Fk4GGKL2JQJrSwAKlU2ZZHkzQsM
 85RNm+eHHjrorFGRZ3/SjNmGUQhKff1kUaQ7qEZcxA0ogj76m/Ur4vLuLWzrYsNrdB
 2Y6A8+Kue2N2Q==
Message-ID: <e21faaf9-f8a3-491f-93dd-748a8bb5dfb3@kernel.org>
Date: Sun, 19 Jul 2026 16:54:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260713160556.3988119-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260713160556.3988119-1-daeho43@gmail.com>
X-Headers-End: 1wlNHt-0004Sn-8D
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: support dynamic reserve/release for
 device aliasing
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/14/26 00:05, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> This patch adds a dynamic management feature to the existing device
> aliasing functionality. It allows users to dynamically reserve or
> release specific devices from the filesystem's free pool at runtime
> through new ioctls.
> 
> To support this, three new ioctls are introduced:
> - F2FS_IOC_RESERVE_DEV_ALIAS: This reclaims the space occupied by a
>    device aliasing file. It first performs a capacity check, resets GC
>    victim information for the target range, marks the segments as in-use
>    to prevent new allocations, and then triggers GC to migrate existing
>    valid data out of the range. Finally, it reserves these blocks in the
>    SIT to effectively exclude the device from the usable capacity.
> 
> - F2FS_IOC_RELEASE_DEV_ALIAS: This releases the reserved space of a
>    previously reserved device aliasing file. It truncates the blocks
>    associated with the file, which makes them available for general
>    filesystem allocation again.
> 
> - F2FS_IOC_GET_DEV_ALIAS_STATUS: This retrieves the current aliasing
>    status of a device aliasing file, returning whether the file is
>    released (inactive alias) or reserved (active alias, with blocks
>    fully allocated on the device).
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v4: renamed interfaces.
>      fixed race conditions between checkpoint=disable mount and ioctls.
>      refactored segment reservation part.
>      modified lock usage.
> v3: add CAP_SYS_ADMIN and checkpoint=disabled check.
>      remove a f2fs specific flag exposed with getflags.
> v2: prevent operations during checkpoint=disabled.
> ---
>   Documentation/filesystems/f2fs.rst |  35 ++++
>   fs/f2fs/f2fs.h                     |   9 +-
>   fs/f2fs/file.c                     | 289 ++++++++++++++++++++++++++++-
>   fs/f2fs/gc.c                       |  30 +--
>   fs/f2fs/namei.c                    |  14 ++
>   fs/f2fs/segment.c                  | 180 +++++++++++++-----
>   fs/f2fs/segment.h                  |  26 +++
>   fs/f2fs/super.c                    |  34 ++++
>   include/uapi/linux/f2fs.h          |   7 +
>   9 files changed, 562 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 8c4a14ae444f..1a5fd4afe609 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -1045,6 +1045,41 @@ So, the key idea is, user can do any file operations on /dev/vdc, and
>   reclaim the space after the use, while the space is counted as /data.
>   That doesn't require modifying partition size and filesystem format.
>   
> +Dynamic Device Aliasing Management
> +----------------------------------
> +
> +In addition to static device aliasing by deleting the aliasing file, F2FS
> +supports dynamic management of device aliasing. This mechanism allows the system
> +to dynamically transition partition ownership between F2FS userdata and external
> +entities (e.g., zRAM, raw partition) based on system requirements without
> +deleting the master aliasing file or requiring unmount/remount.
> +
> +The master aliasing file is created during the initial format of the file system
> +and remains as a persistent control entity (ioctl gateway) in the root directory.
> +
> +- Partition Reservation (In-service to Aliased)
> +  When a specific partition needs to be dedicated to external services (e.g., zRAM),
> +  a user can reserve the device alias range via ioctl. The kernel resets GC victim
> +  information for the target range, marks segments as in-use to prevent new
> +  allocations, and triggers forced GC to migrate existing valid data out of the
> +  range. Finally, it reserves these blocks in the SIT to effectively exclude the
> +  device from the usable capacity.
> +
> +- Partition Release (Aliased to In-service)
> +  When external usage concludes, the space is reclaimed not by deleting the file,
> +  but through the release ioctl. The kernel truncates blocks associated with
> +  the file, releasing them back to general filesystem allocation.
> +
> +.. code-block::
> +
> +   # f2fs_io dev_alias release /mnt/f2fs/vdc.file
> +   # df -h
> +   /dev/vdb                            64G  753M   64G   2% /mnt/f2fs
> +
> +   # f2fs_io dev_alias reserve /mnt/f2fs/vdc.file
> +   # df -h
> +   /dev/vdb                            64G   33G   32G  52% /mnt/f2fs
> +
>   Per-file Read-Only Large Folio Support
>   --------------------------------------
>   
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f1774d4e18d2..0f9b8b66cef9 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1404,6 +1404,8 @@ struct f2fs_dev_info {
>   	unsigned int total_segments;
>   	block_t start_blk;
>   	block_t end_blk;
> +	bool has_alias;
> +	bool is_reserving;
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	unsigned int nr_blkz;		/* Total number of zones */
>   	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
> @@ -4009,7 +4011,10 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
>   int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
>   void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
>   void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
> -						unsigned int len);
> +				unsigned int len);
> +void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
> +				unsigned int len);
> +
>   bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
>   int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
>   void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> @@ -4231,6 +4236,8 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
>   int f2fs_gc_range(struct f2fs_sb_info *sbi,
>   		unsigned int start_seg, unsigned int end_seg,
>   		bool dry_run, unsigned int dry_run_sections);
> +void f2fs_reset_gc_victim_resource(struct f2fs_sb_info *sbi,
> +		unsigned int start, unsigned int end);
>   int f2fs_resize_fs(struct file *filp, __u64 block_count);
>   int __init f2fs_create_garbage_collection_cache(void);
>   void f2fs_destroy_garbage_collection_cache(void);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4b52c56d71f0..9077c091c2d6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -813,13 +813,19 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
>   
>   	if (IS_DEVICE_ALIASING(inode)) {
>   		struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
> -		struct extent_info ei = et->largest;
> +		struct extent_info ei;
> +
> +		read_lock(&et->lock);
> +		ei = et->largest;
> +		read_unlock(&et->lock);
>   
>   		f2fs_invalidate_blocks(sbi, ei.blk, ei.len);
>   
>   		dec_valid_block_count(sbi, inode, ei.len);
>   		f2fs_update_time(sbi, REQ_TIME);
>   
> +		f2fs_drop_extent_tree(inode);
> +
>   		f2fs_folio_put(ifolio, true);
>   		goto out;
>   	}
> @@ -1100,8 +1106,9 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	if ((attr->ia_valid & ATTR_SIZE)) {
>   		if (mapping_large_folio_support(inode->i_mapping))
>   			return -EOPNOTSUPP;
> -		if (!f2fs_is_compress_backend_ready(inode) ||
> -				IS_DEVICE_ALIASING(inode))
> +		if (IS_DEVICE_ALIASING(inode))
> +			return -EPERM;
> +		if (!f2fs_is_compress_backend_ready(inode))
>   			return -EOPNOTSUPP;
>   		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
>   			!IS_ALIGNED(attr->ia_size,
> @@ -2130,6 +2137,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>   	if (IS_NOQUOTA(inode))
>   		return -EPERM;
>   
> +	if (IS_DEVICE_ALIASING(inode))
> +		return -EPERM;
> +
>   	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
>   		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
>   			return -EOPNOTSUPP;
> @@ -2678,6 +2688,17 @@ static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
>   	return fscrypt_ioctl_get_policy(filp, (void __user *)arg);
>   }
>   
> +static int f2fs_ioc_get_dev_alias_status(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +
> +	if (!IS_DEVICE_ALIASING(inode))
> +		return -EINVAL;
> +
> +	return put_user(F2FS_HAS_BLOCKS(inode) ? F2FS_DEV_ALIAS_STATUS_RESERVED :
> +				F2FS_DEV_ALIAS_STATUS_RELEASED, (u32 __user *)arg);
> +}
> +
>   static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
>   {
>   	struct inode *inode = file_inode(filp);
> @@ -3616,6 +3637,259 @@ static int f2fs_ioc_get_dev_alias_file(struct file *filp, unsigned long arg)
>   			(u32 __user *)arg);
>   }
>   
> +static int f2fs_ioc_reserve_dev_alias(struct file *filp)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
> +	struct extent_info ei;
> +	struct cp_control cpc = { CP_SYNC, 0, 0, 0 };
> +	struct f2fs_lock_context lc, glc;
> +	blkcnt_t count;
> +	unsigned int start, end, segno;
> +	int type, i, err;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> +		return -EINVAL;
> +
> +	err = mnt_want_write_file(filp);
> +	if (err)
> +		return err;
> +
> +	inode_lock(inode);
> +
> +	if (!IS_DEVICE_ALIASING(inode)) {
> +		err = -EINVAL;
> +		goto out_inode_unlock;
> +	}
> +
> +	if (F2FS_HAS_BLOCKS(inode)) {
> +		err = 0;
> +		goto out_inode_unlock;
> +	}
> +
> +	for (i = 1; i < sbi->s_ndevs; i++) {
> +		char *name = strrchr(FDEV(i).path, '/');
> +
> +		name = name ? name + 1 : FDEV(i).path;
> +		if (!strcmp(name, filp->f_path.dentry->d_name.name)) {
> +			ei.blk = FDEV(i).start_blk;
> +			ei.len = FDEV(i).total_segments << sbi->log_blocks_per_seg;
> +			ei.fofs = 0;
> +			break;
> +		}
> +	}
> +
> +	if (i == sbi->s_ndevs) {
> +		f2fs_warn(sbi, "device alias file (%s, ino=%llu) has no matching device",
> +			  filp->f_path.dentry->d_name.name, inode->i_ino);
> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> +		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
> +		err = -EFSCORRUPTED;
> +		goto out_inode_unlock;
> +	}
> +
> +	f2fs_down_write_trace(&sbi->gc_lock, &glc);
> +	f2fs_lock_op(sbi, &lc);
> +
> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> +		err = -EINVAL;
> +	} else {
> +		count = ei.len;
> +		err = inc_valid_block_count(sbi, inode, &count, false);
> +	}
> +	if (err) {
> +		f2fs_unlock_op(sbi, &lc);
> +		f2fs_up_write_trace(&sbi->gc_lock, &glc);
> +		goto out_inode_unlock;
> +	}
> +
> +	spin_lock(&FREE_I(sbi)->segmap_lock);
> +	FDEV(f2fs_target_device_index(sbi, ei.blk)).is_reserving = true;
> +	spin_unlock(&FREE_I(sbi)->segmap_lock);
> +
> +	start = GET_SEGNO(sbi, ei.blk);
> +	end = GET_SEGNO(sbi, ei.blk + ei.len - 1);
> +
> +	/* Reset the victim information to prevent GC from targeting the range */
> +	f2fs_reset_gc_victim_resource(sbi, start, end);
> +
> +	/* Move out cursegs from the target range */
> +	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
> +		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
> +		if (err) {
> +			f2fs_unlock_op(sbi, &lc);
> +			goto out_gc_unlock;
> +		}
> +	}
> +
> +	f2fs_unlock_op(sbi, &lc);
> +	f2fs_up_write_trace(&sbi->gc_lock, &glc);
> +
> +	/* Write checkpoint synchronously to flush all pending writes and free space */
> +	err = f2fs_write_checkpoint(sbi, &cpc);
> +	if (err) {
> +		f2fs_down_write_trace(&sbi->gc_lock, &glc);
> +		goto out_gc_unlock;
> +	}
> +
> +	/* Re-acquire gc_lock and cp_rwsem read lock for the entire range GC */
> +	f2fs_down_write_trace(&sbi->gc_lock, &glc);
> +	f2fs_lock_op(sbi, &lc);
> +
> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> +		err = -EINVAL;
> +		f2fs_unlock_op(sbi, &lc);
> +		goto out_gc_unlock;
> +	}
> +
> +	/* do GC to move out valid blocks in the range all at once! */
> +	err = f2fs_gc_range(sbi, start, end, false, 0);
> +	if (err) {
> +		f2fs_unlock_op(sbi, &lc);
> +		goto out_gc_unlock;
> +	}
> +
> +	if (et) {
> +		write_lock(&et->lock);
> +		et->largest = ei;
> +		write_unlock(&et->lock);
> +	}
> +	clear_inode_flag(inode, FI_NO_EXTENT);
> +
> +	f2fs_reserve_device_alias(sbi, ei.blk, ei.len);
> +
> +	i_size_write(inode, (loff_t)ei.len << PAGE_SHIFT);
> +	f2fs_update_inode_page(inode);
> +
> +	spin_lock(&FREE_I(sbi)->segmap_lock);
> +	FDEV(f2fs_target_device_index(sbi, ei.blk)).is_reserving = false;
> +	spin_unlock(&FREE_I(sbi)->segmap_lock);
> +
> +	f2fs_unlock_op(sbi, &lc);
> +	f2fs_up_write_trace(&sbi->gc_lock, &glc);
> +
> +	inode_unlock(inode);
> +	mnt_drop_write_file(filp);
> +
> +	err = f2fs_write_checkpoint(sbi, &cpc);
> +	return err;
> +
> +out_gc_unlock:
> +	spin_lock(&FREE_I(sbi)->segmap_lock);
> +	FDEV(f2fs_target_device_index(sbi, ei.blk)).is_reserving = false;
> +	spin_unlock(&FREE_I(sbi)->segmap_lock);
> +	f2fs_up_write_trace(&sbi->gc_lock, &glc);

Seems, once we have reserved blocks above, and then unlock cp_rwsem and
gc_lock, a following CP and sudden power-cut recovery will make device alias
file corrupted?

Maybe we can reserve blocks for device alias file w/ in-memory variable, something
like reserve_root?

> +
> +	/*
> +	 * Put successfully GC'ed segments back into PRE list so checkpoint
> +	 * commits and frees them!
> +	 */

I didn't get it, why do we need to set empty segment as prefree one? You mean
f2fs_reserve_device_alias() has removed all prefreed segments? seems after
f2fs_reserve_device_alias() there is no error path.

> +	f2fs_lock_op(sbi, &lc);
> +	for (segno = start; segno <= end; segno++) {
> +		if (get_valid_blocks(sbi, segno, false) == 0) {
> +			mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> +			if (!test_and_set_bit(segno, DIRTY_I(sbi)->dirty_segmap[PRE]))
> +				DIRTY_I(sbi)->nr_dirty[PRE]++;
> +			mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> +		}
> +	}
> +	count = ei.len;
> +	dec_valid_block_count(sbi, inode, count);
> +	f2fs_unlock_op(sbi, &lc);
> +
> +	inode_unlock(inode);
> +	mnt_drop_write_file(filp);
> +
> +	f2fs_write_checkpoint(sbi, &cpc);
> +	return err;
> +
> +out_inode_unlock:
> +	inode_unlock(inode);
> +	mnt_drop_write_file(filp);
> +	return err;
> +}
> +
> +static int f2fs_ioc_release_dev_alias(struct file *filp)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
> +	struct extent_info ei = {0, };
> +	struct cp_control cpc = { CP_SYNC, 0, 0, 0 };
> +	struct f2fs_lock_context lc, glc;
> +	int err;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> +		return -EINVAL;
> +
> +	err = mnt_want_write_file(filp);
> +	if (err)
> +		return err;
> +
> +	inode_lock(inode);
> +
> +	if (!IS_DEVICE_ALIASING(inode)) {
> +		err = -EINVAL;
> +		goto out_inode_unlock;
> +	}
> +
> +	if (!F2FS_HAS_BLOCKS(inode)) {
> +		err = 0;
> +		goto out_inode_unlock;
> +	}
> +
> +	err = filemap_write_and_wait(inode->i_mapping);
> +	if (err)
> +		goto out_inode_unlock;
> +
> +	read_lock(&et->lock);
> +	ei = et->largest;
> +	read_unlock(&et->lock);
> +
> +	f2fs_down_write_trace(&sbi->gc_lock, &glc);
> +	f2fs_lock_op(sbi, &lc);
> +
> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> +		err = -EINVAL;
> +		f2fs_unlock_op(sbi, &lc);
> +		f2fs_up_write_trace(&sbi->gc_lock, &glc);
> +		goto out_inode_unlock;
> +	}
> +
> +	truncate_setsize(inode, 0);
> +
> +	err = f2fs_truncate_blocks(inode, 0, false);
> +	if (err) {
> +		i_size_write(inode, (loff_t)ei.len << PAGE_SHIFT);

If f2fs_truncate_blocks() partially truncated blocks of device alias file,
it will be corrupted, since a pinned file may has partial valid blocks in
section?

Can fsck detect such status of device alias for repair?

Thanks,

> +		f2fs_unlock_op(sbi, &lc);
> +		f2fs_up_write_trace(&sbi->gc_lock, &glc);
> +		goto out_inode_unlock;
> +	}
> +
> +	f2fs_update_inode_page(inode);
> +
> +	f2fs_unlock_op(sbi, &lc);
> +	f2fs_up_write_trace(&sbi->gc_lock, &glc);
> +
> +	inode_unlock(inode);
> +	mnt_drop_write_file(filp);
> +
> +	err = f2fs_write_checkpoint(sbi, &cpc);
> +	return err;
> +
> +out_inode_unlock:
> +	inode_unlock(inode);
> +	mnt_drop_write_file(filp);
> +	return err;
> +}
> +
>   static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
>   {
>   	struct inode *inode = file_inode(filp);
> @@ -4742,8 +5016,14 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   		return f2fs_ioc_compress_file(filp);
>   	case F2FS_IOC_GET_DEV_ALIAS_FILE:
>   		return f2fs_ioc_get_dev_alias_file(filp, arg);
> +	case F2FS_IOC_GET_DEV_ALIAS_STATUS:
> +		return f2fs_ioc_get_dev_alias_status(filp, arg);
>   	case F2FS_IOC_IO_PRIO:
>   		return f2fs_ioc_io_prio(filp, arg);
> +	case F2FS_IOC_RESERVE_DEV_ALIAS:
> +		return f2fs_ioc_reserve_dev_alias(filp);
> +	case F2FS_IOC_RELEASE_DEV_ALIAS:
> +		return f2fs_ioc_release_dev_alias(filp);
>   	default:
>   		return -ENOTTY;
>   	}
> @@ -5530,7 +5810,10 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   	case F2FS_IOC_DECOMPRESS_FILE:
>   	case F2FS_IOC_COMPRESS_FILE:
>   	case F2FS_IOC_GET_DEV_ALIAS_FILE:
> +	case F2FS_IOC_GET_DEV_ALIAS_STATUS:
>   	case F2FS_IOC_IO_PRIO:
> +	case F2FS_IOC_RESERVE_DEV_ALIAS:
> +	case F2FS_IOC_RELEASE_DEV_ALIAS:
>   		break;
>   	default:
>   		return -ENOIOCTLCMD;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index ffaa7ba76a1b..93bcb35a5b5d 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2197,29 +2197,37 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>   	return 0;
>   }
>   
> +void f2fs_reset_gc_victim_resource(struct f2fs_sb_info *sbi,
> +			unsigned int start, unsigned int end)
> +{
> +	int i;
> +
> +	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> +	for (i = 0; i < MAX_GC_POLICY; i++)
> +		if (SIT_I(sbi)->last_victim[i] >= start &&
> +			SIT_I(sbi)->last_victim[i] <= end)
> +			SIT_I(sbi)->last_victim[i] = 0;
> +
> +	for (i = BG_GC; i <= FG_GC; i++)
> +		if (sbi->next_victim_seg[i] >= start &&
> +			sbi->next_victim_seg[i] <= end)
> +			sbi->next_victim_seg[i] = NULL_SEGNO;
> +	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> +}
> +
>   static int free_segment_range(struct f2fs_sb_info *sbi,
>   				unsigned int secs, bool dry_run)
>   {
>   	unsigned int next_inuse, start, end;
>   	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
> -	int gc_mode, gc_type;
>   	int err = 0;
>   	int type;
>   
> -	/* Force block allocation for GC */
>   	MAIN_SECS(sbi) -= secs;
>   	start = MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
>   	end = MAIN_SEGS(sbi) - 1;
>   
> -	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> -	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
> -		if (SIT_I(sbi)->last_victim[gc_mode] >= start)
> -			SIT_I(sbi)->last_victim[gc_mode] = 0;
> -
> -	for (gc_type = BG_GC; gc_type <= FG_GC; gc_type++)
> -		if (sbi->next_victim_seg[gc_type] >= start)
> -			sbi->next_victim_seg[gc_type] = NULL_SEGNO;
> -	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> +	f2fs_reset_gc_victim_resource(sbi, start, end);
>   
>   	/* Move out cursegs from the target range */
>   	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index cac03b8e91a1..8c3b57987f6c 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -425,6 +425,9 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
>   	if (!f2fs_is_checkpoint_ready(sbi))
>   		return -ENOSPC;
>   
> +	if (IS_DEVICE_ALIASING(inode))
> +		return -EPERM;
> +
>   	err = fscrypt_prepare_link(old_dentry, dir, dentry);
>   	if (err)
>   		return err;
> @@ -568,6 +571,9 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>   
>   	trace_f2fs_unlink_enter(dir, dentry);
>   
> +	if (IS_DEVICE_ALIASING(inode))
> +		return -EPERM;
> +
>   	if (unlikely(f2fs_cp_error(sbi))) {
>   		err = -EIO;
>   		goto out;
> @@ -946,6 +952,9 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>   	bool old_is_dir = S_ISDIR(old_inode->i_mode);
>   	int err;
>   
> +	if (IS_DEVICE_ALIASING(old_inode))
> +		return -EPERM;
> +
>   	if (unlikely(f2fs_cp_error(sbi)))
>   		return -EIO;
>   	if (!f2fs_is_checkpoint_ready(sbi))
> @@ -1016,6 +1025,8 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>   	}
>   
>   	if (new_inode) {
> +		if (IS_DEVICE_ALIASING(new_inode))
> +			return -EPERM;
>   
>   		err = -ENOTEMPTY;
>   		if (old_is_dir && !f2fs_empty_dir(new_inode))
> @@ -1143,6 +1154,9 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	int old_nlink = 0, new_nlink = 0;
>   	int err;
>   
> +	if (IS_DEVICE_ALIASING(old_inode) || IS_DEVICE_ALIASING(new_inode))
> +		return -EPERM;
> +
>   	if (unlikely(f2fs_cp_error(sbi)))
>   		return -EIO;
>   	if (!f2fs_is_checkpoint_ready(sbi))
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d71ddb3ee918..1a986f1884f2 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2502,35 +2502,42 @@ static int update_sit_entry_for_alloc(struct f2fs_sb_info *sbi, struct seg_entry
>   				unsigned int segno, block_t blkaddr, unsigned int offset, int del)
>   {
>   	bool exist;
> +	int del_count = del;
> +	int i;
>   
> -	exist = f2fs_test_and_set_bit(offset, se->cur_valid_map);
> -	if (unlikely(exist)) {
> -		f2fs_err(sbi, "Bitmap was wrongly set, blk:%u", blkaddr);
> -		f2fs_bug_on(sbi, 1);
> -		se->valid_blocks--;
> -		del = 0;
> -	}
> +	f2fs_bug_on(sbi, GET_SEGNO(sbi, blkaddr) != GET_SEGNO(sbi, blkaddr + del_count - 1));
>   
> -	if (f2fs_block_unit_discard(sbi) &&
> -			!f2fs_test_and_set_bit(offset, se->discard_map))
> -		sbi->discard_blks--;
> +	for (i = 0; i < del_count; i++) {
> +		exist = f2fs_test_and_set_bit(offset + i, se->cur_valid_map);
> +		if (unlikely(exist)) {
> +			f2fs_err(sbi, "Bitmap was wrongly set, blk:%u", blkaddr + i);
> +			f2fs_bug_on(sbi, 1);
> +			se->valid_blocks--;
> +			del -= 1;
> +			continue;
> +		}
>   
> -	/*
> -	 * SSR should never reuse block which is checkpointed
> -	 * or newly invalidated.
> -	 */
> -	if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
> -		if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map)) {
> -			se->ckpt_valid_blocks++;
> -			if (__is_large_section(sbi))
> -				get_sec_entry(sbi, segno)->ckpt_valid_blocks++;
> +		if (f2fs_block_unit_discard(sbi) &&
> +				!f2fs_test_and_set_bit(offset + i, se->discard_map))
> +			sbi->discard_blks--;
> +
> +		/*
> +		 * SSR should never reuse block which is checkpointed
> +		 * or newly invalidated.
> +		 */
> +		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
> +			if (!f2fs_test_and_set_bit(offset + i, se->ckpt_valid_map)) {
> +				se->ckpt_valid_blocks++;
> +				if (__is_large_section(sbi))
> +					get_sec_entry(sbi, segno)->ckpt_valid_blocks++;
> +			}
>   		}
> -	}
>   
> -	if (!f2fs_test_bit(offset, se->ckpt_valid_map)) {
> -		se->ckpt_valid_blocks += del;
> -		if (__is_large_section(sbi))
> -			get_sec_entry(sbi, segno)->ckpt_valid_blocks += del;
> +		if (!f2fs_test_bit(offset + i, se->ckpt_valid_map)) {
> +			se->ckpt_valid_blocks += 1;
> +			if (__is_large_section(sbi))
> +				get_sec_entry(sbi, segno)->ckpt_valid_blocks += 1;
> +		}
>   	}
>   
>   	if (__is_large_section(sbi))
> @@ -2585,9 +2592,14 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
>   	unsigned int segno = GET_SEGNO(sbi, addr);
>   	struct sit_info *sit_i = SIT_I(sbi);
>   	block_t addr_start = addr, addr_end = addr + len - 1;
> -	unsigned int seg_num = GET_SEGNO(sbi, addr_end) - segno + 1;
> +	unsigned int seg_num;
>   	unsigned int i = 1, max_blocks = sbi->blocks_per_seg, cnt;
>   
> +	if (len == 0)
> +		return;
> +
> +	seg_num = GET_SEGNO(sbi, addr_end) - segno + 1;
> +
>   	f2fs_bug_on(sbi, addr == NULL_ADDR);
>   	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
>   		return;
> @@ -2620,6 +2632,52 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
>   	up_write(&sit_i->sentry_lock);
>   }
>   
> +void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
> +				unsigned int len)
> +{
> +	unsigned int segno = GET_SEGNO(sbi, addr);
> +	struct sit_info *sit_i = SIT_I(sbi);
> +	block_t addr_start = addr, addr_end = addr + len - 1;
> +	unsigned int seg_num;
> +	unsigned int i = 1, max_blocks = sbi->blocks_per_seg, cnt;
> +
> +	if (len == 0)
> +		return;
> +
> +	seg_num = GET_SEGNO(sbi, addr_end) - segno + 1;
> +
> +	down_write(&sit_i->sentry_lock);
> +
> +	if (seg_num == 1)
> +		cnt = len;
> +	else
> +		cnt = max_blocks - GET_BLKOFF_FROM_SEG0(sbi, addr);
> +
> +	do {
> +		update_segment_mtime(sbi, addr_start, 0);
> +		update_sit_entry(sbi, addr_start, cnt);
> +		__set_test_and_inuse(sbi, segno);
> +
> +		/* Remove the segment from PRE (prefree) to prevent checkpoint from freeing it! */
> +		mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> +		if (test_and_clear_bit(segno, DIRTY_I(sbi)->dirty_segmap[PRE]))
> +			DIRTY_I(sbi)->nr_dirty[PRE]--;
> +		mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> +
> +		/* add it into dirty seglist */
> +		locate_dirty_segment(sbi, segno);
> +
> +		/* update @addr_start and @cnt and @segno */
> +		addr_start = START_BLOCK(sbi, ++segno);
> +		if (++i == seg_num)
> +			cnt = GET_BLKOFF_FROM_SEG0(sbi, addr_end) + 1;
> +		else
> +			cnt = max_blocks;
> +	} while (i <= seg_num);
> +
> +	up_write(&sit_i->sentry_lock);
> +}
> +
>   bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
>   {
>   	struct sit_info *sit_i = SIT_I(sbi);
> @@ -2758,8 +2816,13 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
>   	unsigned int segno = curseg->segno + 1;
>   	struct free_segmap_info *free_i = FREE_I(sbi);
>   
> -	if (segno < MAIN_SEGS(sbi) && segno % SEGS_PER_SEC(sbi))
> +	if (segno < MAIN_SEGS(sbi) && segno % SEGS_PER_SEC(sbi)) {
> +		int devi = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
> +
> +		if (f2fs_dev_is_reserving(sbi, devi))
> +			return 0;
>   		return !test_bit(segno, free_i->free_segmap);
> +	}
>   	return 0;
>   }
>   
> @@ -2778,6 +2841,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>   	unsigned int alloc_policy = sbi->allocate_section_policy;
>   	unsigned int alloc_hint = sbi->allocate_section_hint;
>   	bool init = true;
> +	bool looped = false;
>   	int i;
>   	int ret = 0;
>   
> @@ -2791,8 +2855,13 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>   	if (!new_sec && ((*newseg + 1) % SEGS_PER_SEC(sbi))) {
>   		segno = find_next_zero_bit(free_i->free_segmap,
>   			GET_SEG_FROM_SEC(sbi, hint + 1), *newseg + 1);
> -		if (segno < GET_SEG_FROM_SEC(sbi, hint + 1))
> +		if (segno < GET_SEG_FROM_SEC(sbi, hint + 1)) {
> +			int devi = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
> +
> +			if (f2fs_dev_is_alloc_blocked(sbi, devi, pinning))
> +				goto find_other_zone;
>   			goto got_it;
> +		}
>   	}
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
> @@ -2828,33 +2897,50 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>   find_other_zone:
>   	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
>   
> -#ifdef CONFIG_BLK_DEV_ZONED
> -	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
> -		/* Write only to sequential zones */
> -		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_ONLY_SEQ) {
> -			hint = GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno);
> -			secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
> -		} else
> -			secno = find_first_zero_bit(free_i->free_secmap,
> -								MAIN_SECS(sbi));
> -		if (secno >= MAIN_SECS(sbi)) {
> -			ret = -ENOSPC;
> -			f2fs_bug_on(sbi, 1);
> -			goto out_unlock;
> -		}
> -	}
> -#endif
> -
>   	if (secno >= MAIN_SECS(sbi)) {
> -		secno = find_first_zero_bit(free_i->free_secmap,
> -							MAIN_SECS(sbi));
> -		if (secno >= MAIN_SECS(sbi)) {
> +		if (looped) {
>   			ret = -ENOSPC;
>   			f2fs_bug_on(sbi, !pinning);
>   			goto out_unlock;
>   		}
> +#ifdef CONFIG_BLK_DEV_ZONED
> +		/* Write only to sequential zones */
> +		if (f2fs_sb_has_blkzoned(sbi) &&
> +			sbi->blkzone_alloc_policy == BLKZONE_ALLOC_ONLY_SEQ)
> +			hint = GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno);
> +		else
> +#endif
> +			hint = 0;
> +		looped = true;
> +		goto find_other_zone;
>   	}
> +
>   	segno = GET_SEG_FROM_SEC(sbi, secno);
> +
> +	if (f2fs_sb_has_device_alias(sbi) && f2fs_is_multi_device(sbi)) {
> +		int devi = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
> +
> +		if (f2fs_dev_is_alloc_blocked(sbi, devi, pinning)) {
> +			unsigned int end_segno;
> +
> +			while (devi < sbi->s_ndevs &&
> +				f2fs_dev_is_alloc_blocked(sbi, devi, pinning)) {
> +				block_t next_blk;
> +
> +				end_segno = GET_SEGNO(sbi, FDEV(devi).end_blk);
> +				hint = GET_SEC_FROM_SEG(sbi, end_segno) + 1;
> +
> +				if (hint >= MAIN_SECS(sbi) || ++devi >= sbi->s_ndevs)
> +					break;
> +
> +				next_blk = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, hint));
> +				if (next_blk < FDEV(devi).start_blk ||
> +					next_blk > FDEV(devi).end_blk)
> +					break;
> +			}
> +			goto find_other_zone;
> +		}
> +	}
>   	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
>   
>   	/* give up on finding another zone */
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index b0c06b3580b4..259e4a29b494 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -954,10 +954,36 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
>   				- (base + 1) + type;
>   }
>   
> +static inline bool f2fs_dev_is_reserving(struct f2fs_sb_info *sbi, int devi)
> +{
> +	if (!f2fs_sb_has_device_alias(sbi) || !f2fs_is_multi_device(sbi))
> +		return false;
> +	return FDEV(devi).is_reserving;
> +}
> +
> +static inline bool f2fs_dev_is_alloc_blocked(struct f2fs_sb_info *sbi,
> +					int devi, bool pinning)
> +{
> +	if (!f2fs_sb_has_device_alias(sbi) || !f2fs_is_multi_device(sbi))
> +		return false;
> +	return (pinning && FDEV(devi).has_alias) || FDEV(devi).is_reserving;
> +}
> +
>   static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
>   {
>   	if (is_cursec(sbi, secno) || (sbi->cur_victim_sec == secno))
>   		return true;
> +	if (f2fs_sb_has_device_alias(sbi) && f2fs_is_multi_device(sbi)) {
> +		int i;
> +		block_t start_blk = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
> +
> +		for (i = 0; i < sbi->s_ndevs; i++) {
> +			if (f2fs_dev_is_reserving(sbi, i) &&
> +				start_blk >= FDEV(i).start_blk &&
> +				start_blk <= FDEV(i).end_blk)
> +				return true;
> +		}
> +	}
>   	return false;
>   }
>   
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index c448d992ff2a..8359eed903be 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5001,6 +5001,38 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>   	sbi->readdir_ra = true;
>   }
>   
> +static void f2fs_restore_device_alias(struct f2fs_sb_info *sbi)
> +{
> +	struct inode *root = d_inode(sbi->sb->s_root);
> +	struct f2fs_dir_entry *de;
> +	struct folio *folio;
> +	int i;
> +
> +	if (!f2fs_sb_has_device_alias(sbi))
> +		return;
> +
> +	for (i = 1; i < sbi->s_ndevs; i++) {
> +		char *name = strrchr(FDEV(i).path, '/');
> +		struct qstr qstr;
> +
> +		name = name ? name + 1 : FDEV(i).path;
> +		qstr.name = name;
> +		qstr.len = strlen(name);
> +
> +		de = f2fs_find_entry(root, &qstr, &folio);
> +		if (de) {
> +			struct inode *inode = f2fs_iget(sbi->sb, le32_to_cpu(de->ino));
> +
> +			if (!IS_ERR(inode)) {
> +				if (IS_DEVICE_ALIASING(inode))
> +					FDEV(i).has_alias = true;
> +				iput(inode);
> +			}
> +			f2fs_folio_put(folio, 0);
> +		}
> +	}
> +}
> +
>   static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   {
>   	struct f2fs_fs_context *ctx = fc->fs_private;
> @@ -5436,6 +5468,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   	f2fs_update_time(sbi, REQ_TIME);
>   	clear_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
>   
> +	f2fs_restore_device_alias(sbi);
> +
>   	sbi->umount_lock_holder = NULL;
>   	return 0;
>   
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index 795e26258355..4409ada2fecb 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -45,6 +45,9 @@
>   #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
>   #define F2FS_IOC_GET_DEV_ALIAS_FILE	_IOR(F2FS_IOCTL_MAGIC, 26, __u32)
>   #define F2FS_IOC_IO_PRIO		_IOW(F2FS_IOCTL_MAGIC, 27, __u32)
> +#define F2FS_IOC_RESERVE_DEV_ALIAS	_IO(F2FS_IOCTL_MAGIC, 28)
> +#define F2FS_IOC_RELEASE_DEV_ALIAS	_IO(F2FS_IOCTL_MAGIC, 29)
> +#define F2FS_IOC_GET_DEV_ALIAS_STATUS	_IOR(F2FS_IOCTL_MAGIC, 30, __u32)
>   
>   /*
>    * should be same as XFS_IOC_GOINGDOWN.
> @@ -70,6 +73,10 @@ enum {
>   	F2FS_IOPRIO_MAX,
>   };
>   
> +/* for F2FS_IOC_GET_DEV_ALIAS_STATUS */
> +#define F2FS_DEV_ALIAS_STATUS_RELEASED	0
> +#define F2FS_DEV_ALIAS_STATUS_RESERVED	1
> +
>   struct f2fs_gc_range {
>   	__u32 sync;
>   	__u64 start;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
