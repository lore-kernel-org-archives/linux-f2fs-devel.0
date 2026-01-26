Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B1CF65EB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YInF+1ahqmiVlnwrWjVy/d/dn+CqzdnQTVB/yBvXUjk=; b=HkzUV6h4P5xYYdFSS+DQEmQnP2
	FlMNqmj2DQTJJ5opoQkOd2jAIA5kl2fXVjyUImw+6KESsFyvy5VYjI29pxjyWT3pJ6M26U0SupzGU
	Tl/56KtHrLVmwk+9r+WE2Lsg06RiotVGbXCI+pZddV1awPHKirMHhczAx2m25tAef2s0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkLhP-0000Xc-VI;
	Mon, 26 Jan 2026 12:28:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1vkLhO-0000XU-QQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 12:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nmiHd+5RUBK6BHC4KTf3cjFvTsHEqXoxu6buhScg8xc=; b=juZ9tH9InA5FsRlvIPD91Y5gm1
 y+ehB6/793NUMe2+zn6baWSRKdAu9q9XYFUfsrsNuY7MZqdwIfnxfPy6rwvRcOke36OQVgt2lfdGw
 TwUiSj1GiM/y9JygM+MqRw2GCn2tOyc5b49GA6hsenOc3KMUugZCGulSX7NJYc0uHb2U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nmiHd+5RUBK6BHC4KTf3cjFvTsHEqXoxu6buhScg8xc=; b=Mxl4cwypVk/BlOMtgrC6yYJe97
 uqCM3DfrqD22v1NsjF394Nldh1P68zlrMJLJGFUI5CMWoqS/wYB4cRk+SbbXWRa6THlkhGI8otb8M
 8FTJi172culVDEKEY3hc4gmHZ3l3EUfxLwwfqy8hBc8e0H9vxzdff8OqYQzBnDIvClkI=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vkLhO-0002hV-5Q for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 12:28:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BCDCA5BCD8;
 Mon, 26 Jan 2026 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769430474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmiHd+5RUBK6BHC4KTf3cjFvTsHEqXoxu6buhScg8xc=;
 b=i5G3Hzbt22ByqMm2UldLc/SFNkK0O0odDVZevDLIPdpU5RmVDd4uAcFy+PPSW3PVkdZ2L+
 opGNMhT4cz1g2WlYNsVyh9Rpb+r3gIkRi6e5DsnSN8vgh54snCBsS39GaslbpIRDggfQjT
 etl3IIFQD6v/ey7ibS1vfLlTtSX2eVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769430474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmiHd+5RUBK6BHC4KTf3cjFvTsHEqXoxu6buhScg8xc=;
 b=YwzjLdLh3SCQ4Qef4Dv4wOdMMZSF/1P4p3mgxilGKo1rN8/xzN0nTLPKmVI3NVsX4wSU1N
 25YeIYiB5lB57eBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i5G3Hzbt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YwzjLdLh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769430474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmiHd+5RUBK6BHC4KTf3cjFvTsHEqXoxu6buhScg8xc=;
 b=i5G3Hzbt22ByqMm2UldLc/SFNkK0O0odDVZevDLIPdpU5RmVDd4uAcFy+PPSW3PVkdZ2L+
 opGNMhT4cz1g2WlYNsVyh9Rpb+r3gIkRi6e5DsnSN8vgh54snCBsS39GaslbpIRDggfQjT
 etl3IIFQD6v/ey7ibS1vfLlTtSX2eVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769430474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmiHd+5RUBK6BHC4KTf3cjFvTsHEqXoxu6buhScg8xc=;
 b=YwzjLdLh3SCQ4Qef4Dv4wOdMMZSF/1P4p3mgxilGKo1rN8/xzN0nTLPKmVI3NVsX4wSU1N
 25YeIYiB5lB57eBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1460139F0;
 Mon, 26 Jan 2026 12:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gPxbJ8pdd2kmEwAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 26 Jan 2026 12:27:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 555A1A0A4F; Mon, 26 Jan 2026 13:27:54 +0100 (CET)
Date: Mon, 26 Jan 2026 13:27:54 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <nfaojijyqteu4756ji3irwodtuxhk3fvgqzbbam2h37xnvj6qk@a67fhgid5ysu>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-14-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-14-hch@lst.de>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[17];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email,lst.de:email];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BCDCA5BCD8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Headers-End: 1vkLhO-0002hV-5Q
Subject: Re: [f2fs-dev] [PATCH 13/16] ext4: consolidate fsverity_info lookup
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
 Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon 26-01-26 05:50:59, Christoph Hellwig wrote:
> Look up the fsverity_info once in ext4_mpage_readpages, and then use it
> for the readahead, local verification of holes and pass it along to the
> I/O completion workqueue in struct bio_post_read_ctx.
> 
> This amortizes the lookup better once it becomes less efficient.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/readpage.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index bf65562da9c2..17920f14e2c2 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -61,6 +61,7 @@ enum bio_post_read_step {
>  
>  struct bio_post_read_ctx {
>  	struct bio *bio;
> +	struct fsverity_info *vi;
>  	struct work_struct work;
>  	unsigned int cur_step;
>  	unsigned int enabled_steps;
> @@ -96,7 +97,7 @@ static void verity_work(struct work_struct *work)
>  	struct bio_post_read_ctx *ctx =
>  		container_of(work, struct bio_post_read_ctx, work);
>  	struct bio *bio = ctx->bio;
> -	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
> +	struct fsverity_info *vi = ctx->vi;
>  
>  	/*
>  	 * fsverity_verify_bio() may call readahead() again, and although verity
> @@ -109,7 +110,7 @@ static void verity_work(struct work_struct *work)
>  	mempool_free(ctx, bio_post_read_ctx_pool);
>  	bio->bi_private = NULL;
>  
> -	fsverity_verify_bio(*fsverity_info_addr(inode), bio);
> +	fsverity_verify_bio(vi, bio);
>  
>  	__read_end_io(bio);
>  }
> @@ -173,22 +174,16 @@ static void mpage_end_io(struct bio *bio)
>  	__read_end_io(bio);
>  }
>  
> -static inline bool ext4_need_verity(const struct inode *inode, pgoff_t idx)
> -{
> -	return fsverity_active(inode) &&
> -	       idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> -}
> -
>  static void ext4_set_bio_post_read_ctx(struct bio *bio,
>  				       const struct inode *inode,
> -				       pgoff_t first_idx)
> +				       struct fsverity_info *vi)
>  {
>  	unsigned int post_read_steps = 0;
>  
>  	if (fscrypt_inode_uses_fs_layer_crypto(inode))
>  		post_read_steps |= 1 << STEP_DECRYPT;
>  
> -	if (ext4_need_verity(inode, first_idx))
> +	if (vi)
>  		post_read_steps |= 1 << STEP_VERITY;
>  
>  	if (post_read_steps) {
> @@ -197,6 +192,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
>  			mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
>  
>  		ctx->bio = bio;
> +		ctx->vi = vi;
>  		ctx->enabled_steps = post_read_steps;
>  		bio->bi_private = ctx;
>  	}
> @@ -224,6 +220,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  	sector_t first_block;
>  	unsigned page_block;
>  	struct block_device *bdev = inode->i_sb->s_bdev;
> +	struct fsverity_info *vi = NULL;
>  	int length;
>  	unsigned relative_block = 0;
>  	struct ext4_map_blocks map;
> @@ -245,9 +242,11 @@ int ext4_mpage_readpages(struct inode *inode,
>  			folio = readahead_folio(rac);
>  
>  		if (first_folio) {
> -			if (ext4_need_verity(inode, folio->index))
> -				fsverity_readahead(*fsverity_info_addr(inode),
> -						folio, nr_pages);
> +			if (folio->index <
> +			    DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> +				vi = fsverity_get_info(inode);
> +			if (vi)
> +				fsverity_readahead(vi, folio, nr_pages);
>  			first_folio = false;
>  		}
>  
> @@ -338,10 +337,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  			folio_zero_segment(folio, first_hole << blkbits,
>  					  folio_size(folio));
>  			if (first_hole == 0) {
> -				if (ext4_need_verity(inode, folio->index) &&
> -				    !fsverity_verify_folio(
> -						*fsverity_info_addr(inode),
> -						folio))
> +				if (vi && !fsverity_verify_folio(vi, folio))
>  					goto set_error_page;
>  				folio_end_read(folio, true);
>  				continue;
> @@ -369,7 +365,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  					REQ_OP_READ, GFP_KERNEL);
>  			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
>  						  GFP_KERNEL);
> -			ext4_set_bio_post_read_ctx(bio, inode, folio->index);
> +			ext4_set_bio_post_read_ctx(bio, inode, vi);
>  			bio->bi_iter.bi_sector = first_block << (blkbits - 9);
>  			bio->bi_end_io = mpage_end_io;
>  			if (rac)
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
