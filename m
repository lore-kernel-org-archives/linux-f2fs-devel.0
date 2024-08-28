Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF129C5B54A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:37:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sjKju-0006DO-23;
	Wed, 28 Aug 2024 15:37:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sjKjs-0006DI-HQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Aug 2024 15:37:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0f9U6nBX2L6hdyh782eLPsVD+/nmW02M+HPf6HiB1Gs=; b=LFKSwSJuJhlO4hp5kmjZvhnpxK
 LPtCT88HrzLLtvLQ7KG/mjLVd/0TjxY8P3/h1mkqycnm99O8bGKHRKGopRgKIof9UcF+xPLVAq3RC
 EZIbPoyWQotj7bVAXAKKLIi/hZpDeWdB823V1hXADGV+Q9sxFunibIQlZdMSR05KuosE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0f9U6nBX2L6hdyh782eLPsVD+/nmW02M+HPf6HiB1Gs=; b=ZwDzRHWmql8vkPiU1clVf3ZfZT
 3pyvRNzzVng5yezZSTyj018ujNnMVCK82HjbthIVxYoIEJPeJ4+0UHc0xtEgHNGLsZTMQAQ1MvGgV
 E3AB5Pfi/7sRWEvO/l2H0UkDxFkzlXxJK75JjFmNOdJy9pmUy6LIgtjw4OzFONzts4ZY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sjKjq-0001Fl-S8 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Aug 2024 15:37:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 19001CE1896
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Aug 2024 15:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A20C51EE5;
 Wed, 28 Aug 2024 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724858860;
 bh=golWfvhGGRNH0zGtd5RPOTm6f8BFtB3I2tmehBi4BmY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qjdofq8Yf4iRQblN+EzaiIT/YPNbh1xmY0tCxIg4kqxa2MJG5kz+UKiiVnPavj/1H
 mhU4CWau6HfG2A8QCugQROGyCIrmGGAd+aCoQ8c24szWh82J1JJEqFphfmPCtJLJin
 oySdiiN0olNiKTWmDFkx0h9k9LSd/FR8FHD66D7LvbPk7lvf+bvzffqLkaQcYXRFv6
 /i0wAKfnJGlzHKul19ORm5adrSHSAwAqkJwZrVrxyLWnxfsC88ocz7yBb7edU0eUJz
 WO5RfEnSemdQbmTxhJEg6nsH4aMUyJ5WG8E4KvKzWag8Ze9/4fpW+GPFy1rF/Uifzk
 Ff2Nvm55fomsw==
Date: Wed, 28 Aug 2024 15:27:39 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <Zs9B6-ocRysmPOKD@google.com>
References: <20240814134815.801303-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240814134815.801303-1-chao@kernel.org>
X-Headers-End: 1sjKjq-0001Fl-S8
Subject: Re: [f2fs-dev] [PATCH v2 2/4] f2fs: atomic: fix to not allow GC to
 pollute atomic_file
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/14, Chao Yu wrote:
> SQLite App			GC Thread	Shrinker
> - f2fs_ioc_start_atomic_write
> 
> - f2fs_ioc_commit_atomic_write
>  - f2fs_commit_atomic_write
>   - filemap_write_and_wait_range
>   : write atomic_file's data to cow_inode
> 						echo 3 > drop_caches
> 				- f2fs_gc
> 				 - gc_data_segment
> 				  - move_data_page
> 				   - set_page_dirty
> 				   : it may load data of previous
> 				     transaction into pagecache.
>   - f2fs_down_write(&fi->i_gc_rwsem[WRITE])
>   - __f2fs_commit_atomic_write
>   - f2fs_up_write(&fi->i_gc_rwsem[WRITE])
> 
> During committing atomic_file, GC may be triggered to migrate
> atomic_file's block, so it may contain data of previous transaction
> in page cache, we should drop atomic_file's cache once it was
> migrated by GC.
> 
> And also, we should writeback atomic_file and cow_file's data
> w/ i_gc_rwsem lock held, in order to avoid block address change
> during __f2fs_commit_atomic_write().
> 
> Meahwhile, this patch adds f2fs_wait_on_block_writeback_range()
> to wait completion of block migration.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix error path handling.
>  fs/f2fs/segment.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 3aee71c9f3c6..a43054ab0cf1 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -236,6 +236,9 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
>  		return err;
>  	}
>  
> +	if (__is_valid_data_blkaddr(dn.data_blkaddr))
> +		f2fs_wait_on_block_writeback_range(inode, dn.data_blkaddr, 1);
> +
>  	if (recover) {
>  		/* dn.data_blkaddr is always valid */
>  		if (!__is_valid_data_blkaddr(new_addr)) {
> @@ -339,6 +342,9 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
>  				goto out;
>  			}
>  
> +			f2fs_wait_on_block_writeback_range(cow_inode,
> +								blkaddr, 1);
> +
>  			new = f2fs_kmem_cache_alloc(revoke_entry_slab, GFP_NOFS,
>  							true, NULL);
>  
> @@ -379,16 +385,29 @@ int f2fs_commit_atomic_write(struct inode *inode)
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  	int err;
>  
> +	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
> +
>  	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>  	if (err)
> -		return err;
> +		goto out;
>  
> -	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
> -	f2fs_lock_op(sbi);
> +	/* writeback GCing page of cow_inode */
> +	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
> +							0, LLONG_MAX);
> +	if (err)
> +		goto out;
>  
> -	err = __f2fs_commit_atomic_write(inode);
> +	filemap_invalidate_lock(inode->i_mapping);
> +
> +	/* don't allow clean page loaded by GC to pollute atomic_file */
> +	truncate_pagecache(inode, 0);

Performance impact?

>  
> +	f2fs_lock_op(sbi);
> +	err = __f2fs_commit_atomic_write(inode);
>  	f2fs_unlock_op(sbi);
> +
> +	filemap_invalidate_unlock(inode->i_mapping);
> +out:
>  	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>  
>  	return err;
> -- 
> 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
