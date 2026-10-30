Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CE606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BoK9+/HR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Em+FsfRe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FIS4RP6s;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDJo+bM3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Cyodq1PtJlhHDEWj5YX3Fdu+cqgCDRgwfzRsNLkjQc0=; b=BoK9+/HRL9puel
	z4ZpUehAKWs3eaJ/Y2bWiypiYzYN97dgNnyf+WhQx1JZVnrAdsDHoeqdrT/oH/zXFUSLiRWaJMC3D
	2XurxihZkvqJa1l/Oh8Dm7L5+WfvKYrUpTyPfMAFgwQXN8+5AQNQKGJERDIIFGrpwrkSL2lqMtKzO
	Sbc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMmBo-000000002ul-3YTF;
	Fri, 30 Oct 2026 12:58:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMmBZ-000000002uU-0BhL
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 12:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PmnqftHJnun8Cz4B15SsJX0+Edfef/U4Sq7UOqC3dwQ=; b=Em+FsfReoRSao00IbL3TZNAnry
 qxpYdQ1TS5oH7J3bOaB0eQzTOrd01eIFjeh6Kef/OAmSW97tPcn0W61ZW1uoTuwITmXn7Yn/1m91U
 PZiWyrQDoyXi5+f9NzgnUWNQQAUy4HzBUG4IT1E5Lqqi0iX7KoSrz/w1uPC59+ammEPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PmnqftHJnun8Cz4B15SsJX0+Edfef/U4Sq7UOqC3dwQ=; b=FIS4RP6sNH/rtSUCFC/76Moyt8
 MUmdxJ3EOllLrZ8xqBPMLDsj8737QfM3dRqc6Cf0ol/PxqKsoWT0DcZ6cI/1eR+G6fyRbR948FNzd
 8t9+tyvM8Y8Lu0DahsS9mm1mEU2wdrSQSbesEeeDm3fRzYIzqzOmerAEA/t4mJagH7UM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMmBX-000000001M7-25xg
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 12:58:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2882443E59;
 Fri, 30 Oct 2026 12:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158F41F00A02;
 Fri, 30 Oct 2026 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793365094;
 bh=PmnqftHJnun8Cz4B15SsJX0+Edfef/U4Sq7UOqC3dwQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=BDJo+bM3jTsLk5K9r5T9WGXEpulE91QnNSc9EdQuG59Me5HCBKc2kGNAaEvCnrFz1
 KBvuxV7rmZ93MA2X1SokFu9HBu2q+V7lFNL5SOeEgw3nvYYcmeXu/o6LI5YlC5sTSt
 /+Li8kGxYgxJz9Y04bZYHz4Osy5Jd+/zlXXkeRWpGyQ5/mCSSIIijz7Gu/v8wGTvrK
 qY7b11e7kda6S1CUKK3NY8o/rWXPO6rWhCgjY4/WXiyNveO3Lb76gaKzt63P8bDONN
 F6pfypJpgjCcmP7hVLLUvFZCIp3sxacvvps/pcfwpnervsLf8lMUgAAcSpSC9EarUP
 4Gdn49RHE30Fg==
Message-ID: <6fd5d995-776b-4e25-9ea4-e3cc018efda0@kernel.org>
Date: Fri, 30 Oct 2026 20:58:11 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261022165526.1539629-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261022165526.1539629-1-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMmBX-000000001M7-25xg
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: reserve space to be shrunk during
 resize_fs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daeho, sorry for the delay.

On 10/23/26 00:55, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> f2fs_resize_fs() drops gc_lock and the cp lock between the free space
> check and freeze_super(). In that window, others can allocate the free
> space, so the second check after freeze_super() fails with -ENOSPC.
> This is easy to hit on a busy filesystem, e.g. at OTA install time.
> 
> Reserve the space to be shrunk via resize_reserved_blocks once the
> first check passes, and deduct it in __get_available_block_count() like
> alias_reserved_blocks. Release it on success or on error.
> 
> With the reservation, the second check should not fail anymore, so:
> - allow root reserved blocks, which root may use in the meantime,
> - recheck DISABLE_CHECKPOINT, which remount may set in the meantime,
>    since freeze_super() fails only when the fs is still dirty,
> - keep the check only as a WARN_ON_ONCE() safety net.
> 
> Also exclude the alias/resize reservations when updating
> current_reserved_blocks via sysfs, otherwise it can underflow
> __get_available_block_count().
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> Changes in v2:
> - Exclude alias/resize reservations from current_reserved_blocks.
> - Allow root reserved blocks in the second check, with WARN_ON_ONCE().
> - Recheck DISABLE_CHECKPOINT after freeze_super().
> ---
>   fs/f2fs/f2fs.h  | 18 +++++++++++++----
>   fs/f2fs/gc.c    | 54 ++++++++++++++++++++++++++++++++++++++-----------
>   fs/f2fs/super.c |  1 +
>   fs/f2fs/sysfs.c | 12 ++++++++++-
>   4 files changed, 68 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 089a62c054e..6b9e1d0e71c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1897,6 +1897,7 @@ struct f2fs_sb_info {
>   	block_t reserved_blocks;		/* configurable reserved blocks */
>   	block_t current_reserved_blocks;	/* current reserved blocks */
>   	block_t alias_reserved_blocks;		/* reserved blocks for device alias */
> +	block_t resize_reserved_blocks;		/* reserved blocks for resize_fs */
>   
>   	/* Additional tracking for no checkpoint mode */
>   	block_t unusable_block_count;		/* # of blocks saved by last cp */
> @@ -2666,16 +2667,18 @@ static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
>   	return false;
>   }
>   
> -static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
> -						struct inode *inode, bool cap)
> +static inline unsigned int __get_available_block_count(
> +					struct f2fs_sb_info *sbi,
> +					bool allow_root)
>   {
>   	block_t avail_user_block_count;
>   
>   	avail_user_block_count = sbi->user_block_count -
>   					sbi->current_reserved_blocks -
> -					sbi->alias_reserved_blocks;
> +					sbi->alias_reserved_blocks -
> +					sbi->resize_reserved_blocks;

Can you please take a look at comments from sashiko? it seems valid:

https://sashiko.dev/#/patchset/20261022165526.1539629-1-daeho43%40gmail.com

__get_available_block_count() can underflow here: avail in __sbi_store() doesn't
exclude root_reserved_blocks, so once valid_user_blocks() < root_reserved_blocks,
current_reserved_blocks can overlap with root reserved space, and the unguarded
"avail_user_block_count -= root_reserved_blocks" wraps block_t.

e.g.
user_block_count = 1000, root_reserved_blocks = 100, valid = 30,
reserved_blocks = current_reserved_blocks = alias_reserved_blocks = 0

Thread A			Thread B (root)
- f2fs_resize_fs(shrunk_blocks = 500)
  - 500 + 30 <= avail(false) = 900, ok
  - resize_reserved_blocks = 500
  - drop gc_lock/cp lock
				- echo 500 > /sys/fs/f2fs/<dev>/reserved_blocks
				 - 500 <= 1000 - 100, ok
				 - avail = 1000 - 500 = 500
				 - current_reserved_blocks =
				   min(500, 500 - 30) = 470

Now for a non-root user:
__get_available_block_count(sbi, false)
   = 1000 - 470 - 0 - 500 = 30, then 30 - 100 => 0xFFFFFFBA

Thanks,

>   
> -	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
> +	if (test_opt(sbi, RESERVE_ROOT) && !allow_root)
>   		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
>   
>   	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> @@ -2688,6 +2691,13 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
>   	return avail_user_block_count;
>   }
>   
> +static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
> +						struct inode *inode, bool cap)
> +{
> +	return __get_available_block_count(sbi,
> +				__allow_reserved_root(sbi, inode, cap));
> +}
> +
>   static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
>   static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>   				 struct inode *inode, blkcnt_t *count,
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 926e6976bc2..955224f4166 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2374,6 +2374,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
>   	struct f2fs_lock_context glc;
>   	struct f2fs_lock_context clc;
>   	unsigned int secs;
> +	bool reserved = false;
>   	int err = 0;
>   	__u32 rem;
>   
> @@ -2425,10 +2426,17 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
>   	f2fs_lock_op(sbi, &lc);
>   
>   	spin_lock(&sbi->stat_lock);
> -	if (shrunk_blocks + valid_user_blocks(sbi) +
> -		sbi->current_reserved_blocks + sbi->unusable_block_count +
> -		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
> +	if (shrunk_blocks + valid_user_blocks(sbi) >
> +			__get_available_block_count(sbi, false)) {
>   		err = -ENOSPC;
> +	} else {
> +		/*
> +		 * Reserve the space to be shrunk so that no one, including
> +		 * root, can allocate it until the shrink is done.
> +		 */
> +		sbi->resize_reserved_blocks += shrunk_blocks;
> +		reserved = true;
> +	}
>   	spin_unlock(&sbi->stat_lock);
>   
>   	if (err)
> @@ -2442,29 +2450,45 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
>   out_drop_write:
>   	mnt_drop_write_file(filp);
>   	if (err)
> -		return err;
> +		goto out_release;
>   
>   	err = freeze_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
>   	if (err)
> -		return err;
> +		goto out_release;
>   
>   	if (f2fs_readonly(sbi->sb)) {
>   		err = thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
> -		if (err)
> -			return err;
> -		return -EROFS;
> +		if (!err)
> +			err = -EROFS;
> +		goto out_release;
> +	}
> +
> +	/* checkpoint can be disabled by remount before freeze_super() */
> +	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
> +		f2fs_err(sbi, "Checkpoint should be enabled.");
> +		err = thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
> +		if (!err)
> +			err = -EINVAL;
> +		goto out_release;
>   	}
>   
>   	f2fs_down_write_trace(&sbi->gc_lock, &glc);
>   	f2fs_down_write_trace(&sbi->cp_global_sem, &clc);
>   
>   	spin_lock(&sbi->stat_lock);
> -	if (shrunk_blocks + valid_user_blocks(sbi) +
> -		sbi->current_reserved_blocks + sbi->unusable_block_count +
> -		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
> +	/*
> +	 * shrunk_blocks is already accounted in resize_reserved_blocks, so
> +	 * this should not fail. Allow root reserved blocks here since root
> +	 * may have used them after the first check, regardless of resize.
> +	 */
> +	if (WARN_ON_ONCE(valid_user_blocks(sbi) >
> +			__get_available_block_count(sbi, true))) {
>   		err = -ENOSPC;
> -	else
> +	} else {
>   		sbi->user_block_count -= shrunk_blocks;
> +		sbi->resize_reserved_blocks -= shrunk_blocks;
> +		reserved = false;
> +	}
>   	spin_unlock(&sbi->stat_lock);
>   	if (err)
>   		goto out_err;
> @@ -2510,5 +2534,11 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
>   	f2fs_up_write_trace(&sbi->cp_global_sem, &clc);
>   	f2fs_up_write_trace(&sbi->gc_lock, &glc);
>   	thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
> +out_release:
> +	if (reserved) {
> +		spin_lock(&sbi->stat_lock);
> +		sbi->resize_reserved_blocks -= shrunk_blocks;
> +		spin_unlock(&sbi->stat_lock);
> +	}
>   	return err;
>   }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d683240040f..28e49e8d71e 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5345,6 +5345,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   	sbi->reserved_blocks = 0;
>   	sbi->current_reserved_blocks = 0;
>   	sbi->alias_reserved_blocks = 0;
> +	sbi->resize_reserved_blocks = 0;
>   	limit_reserve_root(sbi);
>   	adjust_unusable_cap_perc(sbi);
>   
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 9749da70089..ce70d81eba3 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -594,6 +594,8 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   	}
>   #endif
>   	if (a->struct_type == RESERVED_BLOCKS) {
> +		block_t avail, valid;
> +
>   		spin_lock(&sbi->stat_lock);
>   		if (t > (unsigned long)(sbi->user_block_count -
>   				F2FS_OPTION(sbi).root_reserved_blocks)) {
> @@ -601,8 +603,16 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   			return -EINVAL;
>   		}
>   		*ui = t;
> +		/*
> +		 * Exclude the space reserved for device aliasing and resize_fs,
> +		 * otherwise the reserved blocks can overlap with them and
> +		 * __get_available_block_count() can underflow.
> +		 */
> +		avail = sbi->user_block_count - sbi->alias_reserved_blocks -
> +					sbi->resize_reserved_blocks;
> +		valid = valid_user_blocks(sbi);
>   		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
> -				sbi->user_block_count - valid_user_blocks(sbi));
> +				avail > valid ? avail - valid : 0);
>   		spin_unlock(&sbi->stat_lock);
>   		return count;
>   	}



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
