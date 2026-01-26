Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A708DCF65E9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YFFCZul7/vR3M6NQT3CvbNHEzziHYJqNUxhnpU/HjU=; b=PM9PFH+X6fjmOsMqDEdeUD/Kef
	/hY9p22REgowww78ZhfQhC0MIdBhIhsucmFOmokZXq5SGDSXmsVZtDUPNzfVKoGlarhnXyYiAz6eg
	TIrGZxsh8uapf1z9sMo9jfVYXLTUmjosy6TzKVD1Kpr1QS9wVXn2aXanDnv0yVMu2/RI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkLfQ-0000vd-E2;
	Mon, 26 Jan 2026 12:26:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1vkLfP-0000vS-Jo
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 12:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=; b=MhFyb3cCz8cNgNc2+d5MZ3ewZt
 rSQdAkXGVRagGOC2mF4VIFeDpj4Kj5DM9BjSwFSE4NRSN/XcoGykb2NBOi1qtiWk4zh8VvD4YxLjb
 bi1nTuy7qauyhiAkZ8nJyJg5xM/7aMU05QXkNl/xBsYLVL+bZBgx/qgC84ocjKyvTsCc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=; b=PSPKPyjkiuGFI3VnJclu8ZDjpG
 PQrUp+X5tjTr/kH4BWTiCF5Ul0F0cWnyVOHaeEnCMC5GsjLsEqXKv2sCQwbQ+jFpLsz2fST1RYu0y
 yvZpIFwQXOyhivIVKb/9DlC8eCiet26+IsQjBd0Oe6s7bPzLpH9+YtS365feRW8DMwxA=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vkLfP-0002bL-Mq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 12:26:04 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3EFE55BD1B;
 Mon, 26 Jan 2026 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769430352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=;
 b=DV6bF7eqdQr2AN0P1dcCs6x0cm8pWr4LSFosTEpOhfiuvkhCtsBrB40ysodlBnkmFoGcv6
 0RTw3uV3Qp4wlszR5+qp9cHCZGuxPpcKZLET1Zx6QmhvisQ82a5IqV7qDlQAIMGKwUETmf
 4d/SJRh543uV7kOnTmGZpBb+K/NheRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769430352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=;
 b=xQu1Vaj2hOyr+jI7u+4QgtHTf4F9pC9MtwBJ4E6l1wEJ8fFIB0IxNG37PdCg4yes2oU76C
 9wiHu+43jgJJXuCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769430352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=;
 b=DV6bF7eqdQr2AN0P1dcCs6x0cm8pWr4LSFosTEpOhfiuvkhCtsBrB40ysodlBnkmFoGcv6
 0RTw3uV3Qp4wlszR5+qp9cHCZGuxPpcKZLET1Zx6QmhvisQ82a5IqV7qDlQAIMGKwUETmf
 4d/SJRh543uV7kOnTmGZpBb+K/NheRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769430352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=;
 b=xQu1Vaj2hOyr+jI7u+4QgtHTf4F9pC9MtwBJ4E6l1wEJ8fFIB0IxNG37PdCg4yes2oU76C
 9wiHu+43jgJJXuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2688C139F0;
 Mon, 26 Jan 2026 12:25:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yQdgCVBdd2kiEQAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 26 Jan 2026 12:25:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id D95E1A0A4F; Mon, 26 Jan 2026 13:25:47 +0100 (CET)
Date: Mon, 26 Jan 2026 13:25:47 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <dmqdpe5kyb43kniwsbogdhw6oiktponzcy3nx3zkvuhoxrlkdk@fyzrntl6aihe>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-13-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-13-hch@lst.de>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Headers-End: 1vkLfP-0002bL-Mq
Subject: Re: [f2fs-dev] [PATCH 12/16] fs: consolidate fsverity_info lookup
 in buffer.c
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon 26-01-26 05:50:58, Christoph Hellwig wrote:
> Look up the fsverity_info once in end_buffer_async_read_io, and then
> pass it along to the I/O completion workqueue in
> struct postprocess_bh_ctx.
> 
> This amortizes the lookup better once it becomes less efficient.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 3982253b6805..f4b3297ef1b1 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -302,6 +302,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  struct postprocess_bh_ctx {
>  	struct work_struct work;
>  	struct buffer_head *bh;
> +	struct fsverity_info *vi;
>  };
>  
>  static void verify_bh(struct work_struct *work)
> @@ -309,25 +310,14 @@ static void verify_bh(struct work_struct *work)
>  	struct postprocess_bh_ctx *ctx =
>  		container_of(work, struct postprocess_bh_ctx, work);
>  	struct buffer_head *bh = ctx->bh;
> -	struct inode *inode = bh->b_folio->mapping->host;
>  	bool valid;
>  
> -	valid = fsverity_verify_blocks(*fsverity_info_addr(inode), bh->b_folio,
> -				       bh->b_size, bh_offset(bh));
> +	valid = fsverity_verify_blocks(ctx->vi, bh->b_folio, bh->b_size,
> +				       bh_offset(bh));
>  	end_buffer_async_read(bh, valid);
>  	kfree(ctx);
>  }
>  
> -static bool need_fsverity(struct buffer_head *bh)
> -{
> -	struct folio *folio = bh->b_folio;
> -	struct inode *inode = folio->mapping->host;
> -
> -	return fsverity_active(inode) &&
> -		/* needed by ext4 */
> -		folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> -}
> -
>  static void decrypt_bh(struct work_struct *work)
>  {
>  	struct postprocess_bh_ctx *ctx =
> @@ -337,7 +327,7 @@ static void decrypt_bh(struct work_struct *work)
>  
>  	err = fscrypt_decrypt_pagecache_blocks(bh->b_folio, bh->b_size,
>  					       bh_offset(bh));
> -	if (err == 0 && need_fsverity(bh)) {
> +	if (err == 0 && ctx->vi) {
>  		/*
>  		 * We use different work queues for decryption and for verity
>  		 * because verity may require reading metadata pages that need
> @@ -359,15 +349,20 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
>  {
>  	struct inode *inode = bh->b_folio->mapping->host;
>  	bool decrypt = fscrypt_inode_uses_fs_layer_crypto(inode);
> -	bool verify = need_fsverity(bh);
> +	struct fsverity_info *vi = NULL;
> +
> +	/* needed by ext4 */
> +	if (bh->b_folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> +		vi = fsverity_get_info(inode);
>  
>  	/* Decrypt (with fscrypt) and/or verify (with fsverity) if needed. */
> -	if (uptodate && (decrypt || verify)) {
> +	if (uptodate && (decrypt || vi)) {
>  		struct postprocess_bh_ctx *ctx =
>  			kmalloc(sizeof(*ctx), GFP_ATOMIC);
>  
>  		if (ctx) {
>  			ctx->bh = bh;
> +			ctx->vi = vi;
>  			if (decrypt) {
>  				INIT_WORK(&ctx->work, decrypt_bh);
>  				fscrypt_enqueue_decrypt_work(&ctx->work);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
