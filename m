Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0653FCDB471
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vbbUtXkUvP6MobUuJn04TGl7kSMKxRJ/Hd7sYXNA/4o=; b=AU8F2j5Zb0swk6zWFQb/zm+UV3
	oPH0XY7vX44F8PD1fNxOWwta0oBQadE2dts94+NvzPstU0cOgKRTmwbSd5nxvGC/wti5M0FYHXpDn
	WGj4AS3Uesy85x9O++YDaPFvy7T+X/Cm4rd+IKEUkEttQVdxIoQ7CrACslVaiEyfEztY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcLyd-0000Ub-4f;
	Wed, 24 Jun 2026 11:41:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1wcLya-0000UU-GQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 11:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1FWZgxDjSUCom9Re05WOOJuJNeJjEZN52wMGosALaUs=; b=ZlTYPolchWWjXJpryfsZ/DpCd9
 7LRKb8vJVHCY9P7+530u9aYDrEXS+HY3iFSljq9Az4c6wPad9g4zz+RsR64hopqGMsqQ8UZ1oo1P6
 ppctHYEVOLsQq+3Lo2seOlRiFbRWsIwItxdahOoBveNY0s8FneXBBUjbJUdqMwRoxOeE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1FWZgxDjSUCom9Re05WOOJuJNeJjEZN52wMGosALaUs=; b=inyod8uccavAMYd1uklYhIPEn2
 XnjV38Jyio7kRs6wxVli+yXrayG3GCBv8LDlGczKlNfUeEQof9R58WLzTabh4eCvTuI+SZEHUK9LM
 qMSdUutR/4xewDEVVzfQ1adopmuybs96+cVrD+tlnDgq86ucur4JJyDhzR28/yUN8vGE=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcLyZ-0000c9-Qx for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 11:41:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 684BF71314;
 Wed, 24 Jun 2026 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782301257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1FWZgxDjSUCom9Re05WOOJuJNeJjEZN52wMGosALaUs=;
 b=hF6NfODFPkCXvzr0SSHA/NliEy6UInLzHmobMqkJkWJfYWzdB1aaFCcQ3SiNrr4QQigZ61
 IOck3SKBclnNectWeI+wu8MiofOCvj0ZXWfpy+xmlOOYlUfZExVRabhPdzvAJwfpomETeR
 45DUjs7WXol1xxnSafaemMVirLgl+FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782301257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1FWZgxDjSUCom9Re05WOOJuJNeJjEZN52wMGosALaUs=;
 b=GY8PcayCGoSTcAmLpIduGlP87R01qakK2tGhInNlAk5tsyVp1pmYg7EgUSRtXuSA9+T442
 xJqVt0prij7hymBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782301257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1FWZgxDjSUCom9Re05WOOJuJNeJjEZN52wMGosALaUs=;
 b=hF6NfODFPkCXvzr0SSHA/NliEy6UInLzHmobMqkJkWJfYWzdB1aaFCcQ3SiNrr4QQigZ61
 IOck3SKBclnNectWeI+wu8MiofOCvj0ZXWfpy+xmlOOYlUfZExVRabhPdzvAJwfpomETeR
 45DUjs7WXol1xxnSafaemMVirLgl+FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782301257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1FWZgxDjSUCom9Re05WOOJuJNeJjEZN52wMGosALaUs=;
 b=GY8PcayCGoSTcAmLpIduGlP87R01qakK2tGhInNlAk5tsyVp1pmYg7EgUSRtXuSA9+T442
 xJqVt0prij7hymBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C833779A8;
 Wed, 24 Jun 2026 11:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PNKTFknCO2p9HgAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 24 Jun 2026 11:40:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id EADF4A093E; Wed, 24 Jun 2026 13:40:56 +0200 (CEST)
Date: Wed, 24 Jun 2026 13:40:56 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <hu7h6ga2ndrsedjvjbemdevjzrhvtz7jx2hbc2rtmkskufckmi@yf3a6t4hhike>
References: <20260624050334.124606-1-ebiggers@kernel.org>
 <20260624050334.124606-11-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260624050334.124606-11-ebiggers@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[16]; TAGGED_RCPT(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,lst.de,mit.edu,dilger.ca,linux.alibaba.com,suse.cz,linux.ibm.com,gmail.com,huawei.com,kernel.org];
 RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Headers-End: 1wcLyZ-0000c9-Qx
Subject: Re: [f2fs-dev] [PATCH 10/16] fs/buffer: Remove fs-layer decryption
 code
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue 23-06-26 22:03:28, Eric Biggers wrote:
> Now that fscrypt's file contents en/decryption is always implemented
> using blk-crypto when the filesystem is block-based, the fs-layer
> decryption code in fs/buffer.c is unused code.  Remove it.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Fine by me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 45 ++++++++-------------------------------------
>  1 file changed, 8 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 9af5f061a1f8..21dd9596a941 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -334,82 +334,53 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  
>  still_busy:
>  	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  }
>  
> -struct postprocess_bh_ctx {
> +struct verify_bh_ctx {
>  	struct work_struct work;
>  	struct buffer_head *bh;
>  	struct fsverity_info *vi;
>  };
>  
>  static void verify_bh(struct work_struct *work)
>  {
> -	struct postprocess_bh_ctx *ctx =
> -		container_of(work, struct postprocess_bh_ctx, work);
> +	struct verify_bh_ctx *ctx =
> +		container_of(work, struct verify_bh_ctx, work);
>  	struct buffer_head *bh = ctx->bh;
>  	bool valid;
>  
>  	valid = fsverity_verify_blocks(ctx->vi, bh->b_folio, bh->b_size,
>  				       bh_offset(bh));
>  	end_buffer_async_read(bh, valid);
>  	kfree(ctx);
>  }
>  
> -static void decrypt_bh(struct work_struct *work)
> -{
> -	struct postprocess_bh_ctx *ctx =
> -		container_of(work, struct postprocess_bh_ctx, work);
> -	struct buffer_head *bh = ctx->bh;
> -	int err;
> -
> -	err = fscrypt_decrypt_pagecache_blocks(bh->b_folio, bh->b_size,
> -					       bh_offset(bh));
> -	if (err == 0 && ctx->vi) {
> -		/*
> -		 * We use different work queues for decryption and for verity
> -		 * because verity may require reading metadata pages that need
> -		 * decryption, and we shouldn't recurse to the same workqueue.
> -		 */
> -		INIT_WORK(&ctx->work, verify_bh);
> -		fsverity_enqueue_verify_work(&ctx->work);
> -		return;
> -	}
> -	end_buffer_async_read(bh, err == 0);
> -	kfree(ctx);
> -}
> -
>  /*
>   * I/O completion handler for block_read_full_folio() - folios
>   * which come unlocked at the end of I/O.
>   */
>  static void bh_end_async_read(struct bio *bio)
>  {
>  	struct buffer_head *bh;
>  	bool uptodate = bio_endio_bh(bio, &bh);
>  	struct inode *inode = bh->b_folio->mapping->host;
> -	bool decrypt = fscrypt_inode_uses_fs_layer_crypto(inode);
>  	struct fsverity_info *vi = NULL;
>  
>  	/* needed by ext4 */
>  	if (bh->b_folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
>  		vi = fsverity_get_info(inode);
>  
> -	/* Decrypt (with fscrypt) and/or verify (with fsverity) if needed. */
> -	if (uptodate && (decrypt || vi)) {
> -		struct postprocess_bh_ctx *ctx = kmalloc_obj(*ctx, GFP_ATOMIC);
> +	/* Verify (with fsverity) if needed. */
> +	if (vi && uptodate) {
> +		struct verify_bh_ctx *ctx = kmalloc_obj(*ctx, GFP_ATOMIC);
>  
>  		if (ctx) {
>  			ctx->bh = bh;
>  			ctx->vi = vi;
> -			if (decrypt) {
> -				INIT_WORK(&ctx->work, decrypt_bh);
> -				fscrypt_enqueue_decrypt_work(&ctx->work);
> -			} else {
> -				INIT_WORK(&ctx->work, verify_bh);
> -				fsverity_enqueue_verify_work(&ctx->work);
> -			}
> +			INIT_WORK(&ctx->work, verify_bh);
> +			fsverity_enqueue_verify_work(&ctx->work);
>  			return;
>  		}
>  		uptodate = false;
>  	}
>  	end_buffer_async_read(bh, uptodate);
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
