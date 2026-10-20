Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A655606A319
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CcbRtMFM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d3fMoOtG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G8eCM1Yf;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARGRHQ2l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sMZDERLph0LMKYKFNAj4PWAe1TSefBNIBRQNCs6KsdM=; b=CcbRtMFMfB9XCtRBiuN3M/2Z9I
	ejF4smMpsS3T5RgTXekmih+exHPTGw9MF2CpZSYVfaIjSjFa24h3miss5WGtmz343ZzvUJ27CcIUJ
	jJdcJ+1XXo/7kAh9vc+2MEvmHLAN2WnWg20PPdWLtal4HWd5G1S7Sr3gN7rLUZOJH9qA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJ5s2-0001F0-82;
	Tue, 20 Oct 2026 09:10:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xJ5s1-0001Eu-J0
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:10:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aIW2X+vy1c+YTARdLviTCxMpyD8xFftZ0KtcxvAN6To=; b=d3fMoOtGUBEIa9Rtc3uh99Tul/
 kwF0202t+iFf6jkGpkq1CyapqChti5HgPG8TAb1sco/YTe/vze3tIHuBYMUXNNTaRS97LBySCoBnl
 wnJC2c7WInuMOtPxj74rohtr46Y9Z0gKZW0DEBol56vQFcPoiYN3cf/qEf9h7NEvdkDI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aIW2X+vy1c+YTARdLviTCxMpyD8xFftZ0KtcxvAN6To=; b=G8eCM1YfkEpb7AxnNtQzQ9v3RO
 wYERWmSwZ4AGoQGYZLnQDHEC+UQs02VQrlLRcZAwvrEu0BGV0PQ3ldf7aWf+F/uLUBLPqjvaQh76q
 Tt8Xp/UaSwjrhSvhmptvkJy8JkGL3xCCowkm42tzScCFvfPuPciMKSMyhFRYWtKodS+Y=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJ5s0-0007Bq-53 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:10:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CEA474382B;
 Tue, 20 Oct 2026 09:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C937F1F000C4;
 Tue, 20 Oct 2026 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792487450;
 bh=aIW2X+vy1c+YTARdLviTCxMpyD8xFftZ0KtcxvAN6To=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ARGRHQ2lQETLypEo9cPkvgO7nfVXbP4p+NKX8OzlDkcG+YQJfdUf4nJ/c4x7a4B8o
 1+RUe6nOe3hzoC3PtCdi9jtiwADeF7hIxqeulErUOw7YZQTUSKswAVXzIkQgCAEttr
 7IrdaOmpx2FrxecKchDj9evdIxY7XVvgJA6iSzR4tvuFyOI7FqGZ+VN/UOlifE23Eq
 IjP5IMz648DDhxkYYB8kuphT+osshpbrjjgCFu/ZC33/Q+JyTwGNSYECZ+0Rj+k2d0
 1KdrSTz5j2n6+iSA6GezmO4YBrlaOEaOC7ooN/V5CoxtDnuA2yinLw0k+NyTPIfMZB
 U4GaIZgMKiu/A==
Message-ID: <145faed4-947f-4f09-96af-c0bea87dd1db@kernel.org>
Date: Tue, 20 Oct 2026 17:10:48 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261014030646.662661-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261014030646.662661-1-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJ5s0-0007Bq-53
Subject: Re: [f2fs-dev] [PATCH] f2fs: reserve space to be shrunk during
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 11:06, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> f2fs_resize_fs() checks whether there is enough free space for the
> shrink, runs a dry-run GC to migrate blocks out of the target range,
> and then drops gc_lock and the cp lock before freeze_super(). During
> that window, other processes, including root ones that are allowed to
> use root reserved blocks, can still allocate the free space, so the
> second check after freeze_super() fails with -ENOSPC even though the
> first check passed. This is easy to hit when the shrink is triggered
> on a live, busy filesystem, e.g. by an updater at OTA install time.
> 
> Fix this by reserving the space to be shrunk once the first check
> passes. Add resize_reserved_blocks and deduct it in
> __get_available_block_count() for all callers, like
> alias_reserved_blocks, so that no one can allocate the reserved space
> until the shrink is done. The reservation is released together with
> the user_block_count update on success, or on any error.
> 
> Also factor out __get_available_block_count() and use it in
> f2fs_resize_fs() to share the available block calculation, which takes
> alias_reserved_blocks into account as well.
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/f2fs.h  | 18 ++++++++++++++----
>  fs/f2fs/gc.c    | 41 +++++++++++++++++++++++++++++------------
>  fs/f2fs/super.c |  1 +
>  3 files changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 089a62c054e..6b9e1d0e71c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1897,6 +1897,7 @@ struct f2fs_sb_info {
>  	block_t reserved_blocks;		/* configurable reserved blocks */
>  	block_t current_reserved_blocks;	/* current reserved blocks */
>  	block_t alias_reserved_blocks;		/* reserved blocks for device alias */
> +	block_t resize_reserved_blocks;		/* reserved blocks for resize_fs */
>  
>  	/* Additional tracking for no checkpoint mode */
>  	block_t unusable_block_count;		/* # of blocks saved by last cp */
> @@ -2666,16 +2667,18 @@ static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
>  	return false;
>  }
>  
> -static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
> -						struct inode *inode, bool cap)
> +static inline unsigned int __get_available_block_count(
> +					struct f2fs_sb_info *sbi,
> +					bool allow_root)
>  {
>  	block_t avail_user_block_count;
>  
>  	avail_user_block_count = sbi->user_block_count -
>  					sbi->current_reserved_blocks -
> -					sbi->alias_reserved_blocks;
> +					sbi->alias_reserved_blocks -
> +					sbi->resize_reserved_blocks;
>  
> -	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
> +	if (test_opt(sbi, RESERVE_ROOT) && !allow_root)
>  		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> @@ -2688,6 +2691,13 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
>  	return avail_user_block_count;
>  }
>  
> +static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
> +						struct inode *inode, bool cap)
> +{
> +	return __get_available_block_count(sbi,
> +				__allow_reserved_root(sbi, inode, cap));
> +}

Do we need to use this to cover current_reserved_blocks update? because
reserved_blocks sysfs bypasses the reservation.

	if (a->struct_type == RESERVED_BLOCKS) {
		spin_lock(&sbi->stat_lock);
		if (t > (unsigned long)(sbi->user_block_count -
				F2FS_OPTION(sbi).root_reserved_blocks)) {
			spin_unlock(&sbi->stat_lock);
			return -EINVAL;
		}
		*ui = t;
		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
				sbi->user_block_count - valid_user_blocks(sbi));
		spin_unlock(&sbi->stat_lock);
		return count;
	}

> +
>  static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
>  static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  				 struct inode *inode, blkcnt_t *count,
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 926e6976bc2..5bfdaeae794 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2374,6 +2374,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
>  	struct f2fs_lock_context glc;
>  	struct f2fs_lock_context clc;
>  	unsigned int secs;
> +	bool reserved = false;
>  	int err = 0;
>  	__u32 rem;
>  
> @@ -2425,10 +2426,17 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
>  	f2fs_lock_op(sbi, &lc);
>  
>  	spin_lock(&sbi->stat_lock);
> -	if (shrunk_blocks + valid_user_blocks(sbi) +
> -		sbi->current_reserved_blocks + sbi->unusable_block_count +
> -		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
> +	if (shrunk_blocks + valid_user_blocks(sbi) >
> +			__get_available_block_count(sbi, false)) {
>  		err = -ENOSPC;
> +	} else {
> +		/*
> +		 * Reserve the space to be shrunk so that no one, including
> +		 * root, can allocate it until the shrink is done.
> +		 */
> +		sbi->resize_reserved_blocks += shrunk_blocks;
> +		reserved = true;
> +	}
>  	spin_unlock(&sbi->stat_lock);
>  
>  	if (err)
> @@ -2442,29 +2450,32 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
>  out_drop_write:
>  	mnt_drop_write_file(filp);
>  	if (err)
> -		return err;
> +		goto out_release;
>  
>  	err = freeze_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
>  	if (err)
> -		return err;
> +		goto out_release;
>  
>  	if (f2fs_readonly(sbi->sb)) {
>  		err = thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
> -		if (err)
> -			return err;
> -		return -EROFS;
> +		if (!err)
> +			err = -EROFS;
> +		goto out_release;
>  	}
>  
>  	f2fs_down_write_trace(&sbi->gc_lock, &glc);
>  	f2fs_down_write_trace(&sbi->cp_global_sem, &clc);
>  
>  	spin_lock(&sbi->stat_lock);
> -	if (shrunk_blocks + valid_user_blocks(sbi) +
> -		sbi->current_reserved_blocks + sbi->unusable_block_count +
> -		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
> +	/* shrunk_blocks is already accounted in resize_reserved_blocks */
> +	if (valid_user_blocks(sbi) >
> +			__get_available_block_count(sbi, false)) {
>  		err = -ENOSPC;

Since we already have reserved blocks in resize_reserved_blocks, we should
not expect there will be ENOSPC case here, right?

Thanks,

> -	else
> +	} else {
>  		sbi->user_block_count -= shrunk_blocks;
> +		sbi->resize_reserved_blocks -= shrunk_blocks;
> +		reserved = false;
> +	}
>  	spin_unlock(&sbi->stat_lock);
>  	if (err)
>  		goto out_err;
> @@ -2510,5 +2521,11 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)>  	f2fs_up_write_trace(&sbi->cp_global_sem, &clc);
>  	f2fs_up_write_trace(&sbi->gc_lock, &glc);
>  	thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
> +out_release:
> +	if (reserved) {
> +		spin_lock(&sbi->stat_lock);
> +		sbi->resize_reserved_blocks -= shrunk_blocks;
> +		spin_unlock(&sbi->stat_lock);
> +	}
>  	return err;
>  }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d683240040f..28e49e8d71e 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5345,6 +5345,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sbi->reserved_blocks = 0;
>  	sbi->current_reserved_blocks = 0;
>  	sbi->alias_reserved_blocks = 0;
> +	sbi->resize_reserved_blocks = 0;
>  	limit_reserve_root(sbi);
>  	adjust_unusable_cap_perc(sbi);
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
