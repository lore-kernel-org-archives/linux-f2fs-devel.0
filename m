Return-Path: <SRS0=tUrj=AA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12E3C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:56:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1339207DD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="X/zQPAbw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CELjYsVQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNyadC1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1339207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jmA1C-0001nO-4Y; Fri, 19 Jun 2020 05:56:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jmA1A-0001nH-V8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jun 2020 05:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dWJ/3V9s1aCVD1BvrF5aqQB6USuOWH2WNeOCYc8kUd4=; b=X/zQPAbwOHaXsmVNjiXjSlkAmN
 cu65+yJ86j8sGRp40fo4LjlNxIWAjU2wMkkGMh+rQTe7CgMHBOWTQ3tAz3Mp7Tfqs+YVsBdJeo93s
 SnXRFTHSEoNaa0oe8groe1GVFrwg8oBZKShGYFMucc2TlvJ1YiA9v8AXp7EatZLjkmpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dWJ/3V9s1aCVD1BvrF5aqQB6USuOWH2WNeOCYc8kUd4=; b=CELjYsVQ9K30EU9wyJElHF1Dm2
 yp3GdnR9o+2W26QMCvt/m3dmM9Zg6KM+TX4Yh/tZ+8GkO3MczcdaXaTjwy3+4ZX/UlZT9qnwwKSWp
 csX8tmI1TYGBspHW10DmSCREs5A/cBuK4x4vJtuV4BW6B4EZ3PKx916sMBWkI4pdkGsA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jmA18-009buW-Sh
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jun 2020 05:56:48 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6B7A9207DD;
 Fri, 19 Jun 2020 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592546201;
 bh=9lQMKLDkxfUoyF2wJGr/cl+gMGQit45i/+nfTpmUwJI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uNyadC1mwnLWhHwUt+8csXiE/lsUF5oJSfigS3rFy6B8uhc0tavJ6DOO3AGawjuBU
 I1CBJH9egCmg6ovDJCCmT7oUGDf82nuO3V4v/8WQQUv2wjHwRTVS16Ec8IPwBnDjmd
 VsJ9t+YjDSZGhTNqSaHdPxLUf2bhFTe4Vgj+KTLA=
Date: Thu, 18 Jun 2020 22:56:40 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200619055640.GD227771@google.com>
References: <20200618063625.110273-1-yuchao0@huawei.com>
 <20200618063625.110273-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618063625.110273-3-yuchao0@huawei.com>
X-Headers-End: 1jmA18-009buW-Sh
Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: shrink node_write lock coverage
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/18, Chao Yu wrote:
> - to avoid race between checkpoint and quota file writeback, it
> just needs to hold read lock of node_write in writeback path.
> - node_write lock has covered all LFS data write paths, it's not
> necessary, we only need to hold node_write lock at write path of
> quota file.

I've added this:

This refactors commit ca7f76e68074 ("f2fs: fix wrong discard space").

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 18 +++++++++++++++---
>  fs/f2fs/data.c     | 12 ++++++++++++
>  fs/f2fs/segment.c  | 11 -----------
>  3 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 36b51795b0c3..3ff6c0305ec6 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1096,8 +1096,16 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	loff_t psize;
>  	int i, err;
>  
> -	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
> +	if (IS_NOQUOTA(inode)) {
> +		/*
> +		 * We need to wait for node_write to avoid block allocation during
> +		 * checkpoint. This can only happen to quota writes which can cause
> +		 * the below discard race condition.
> +		 */
> +		down_read(&sbi->node_write);
> +	} else if (!f2fs_trylock_op(sbi)) {
>  		return -EAGAIN;
> +	}
>  
>  	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
>  
> @@ -1203,7 +1211,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
>  
>  	f2fs_put_dnode(&dn);
> -	if (!IS_NOQUOTA(inode))
> +	if (IS_NOQUOTA(inode))
> +		up_read(&sbi->node_write);
> +	else
>  		f2fs_unlock_op(sbi);
>  
>  	spin_lock(&fi->i_size_lock);
> @@ -1230,7 +1240,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  out_put_dnode:
>  	f2fs_put_dnode(&dn);
>  out_unlock_op:
> -	if (!IS_NOQUOTA(inode))
> +	if (IS_NOQUOTA(inode))
> +		up_read(&sbi->node_write);
> +	else
>  		f2fs_unlock_op(sbi);
>  	return -EAGAIN;
>  }
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c78ce08f6400..cbdf062d3562 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2719,8 +2719,20 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>  
>  	/* Dentry/quota blocks are controlled by checkpoint */
>  	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
> +		/*
> +		 * We need to wait for node_write to avoid block allocation during
> +		 * checkpoint. This can only happen to quota writes which can cause
> +		 * the below discard race condition.
> +		 */
> +		if (IS_NOQUOTA(inode))
> +			down_read(&sbi->node_write);
> +
>  		fio.need_lock = LOCK_DONE;
>  		err = f2fs_do_write_data_page(&fio);
> +
> +		if (IS_NOQUOTA(inode))
> +			up_read(&sbi->node_write);
> +
>  		goto done;
>  	}
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 5b2a6f865a6d..cb861ed98ee3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3107,14 +3107,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  		type = CURSEG_COLD_DATA;
>  	}
>  
> -	/*
> -	 * We need to wait for node_write to avoid block allocation during
> -	 * checkpoint. This can only happen to quota writes which can cause
> -	 * the below discard race condition.
> -	 */
> -	if (IS_DATASEG(type))
> -		down_write(&sbi->node_write);
> -
>  	down_read(&SM_I(sbi)->curseg_lock);
>  
>  	mutex_lock(&curseg->curseg_mutex);
> @@ -3180,9 +3172,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  
>  	up_read(&SM_I(sbi)->curseg_lock);
>  
> -	if (IS_DATASEG(type))
> -		up_write(&sbi->node_write);
> -
>  	if (put_pin_sem)
>  		up_read(&sbi->pin_sem);
>  }
> -- 
> 2.18.0.rc1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
