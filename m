Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6614E7316D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIOBqDQZ1Hr6i4sCjqv8PrY2GlnW5pWl8ELcyzTADgo=; b=H8L+2ZGQRFFaGAd1PUhvi37wkS
	jGFjduRvYBhp+lJtI/o3h9X1xByDtIIZbbrnyDsXEJbT8IMhWIfKufw7tTBtiEDK5nyzIY7CPh67S
	9/F8QKAZUOxbs9oTc6FT8D0NaqWGL2Gm+VLUftGEU3LQIiv5oCe/liRI9d8lI9pAbf3E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vmu6S-0006Ep-Dj;
	Mon, 02 Feb 2026 13:36:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1vmu6Q-0006EZ-PQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Feb 2026 13:36:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=; b=NW6CtJu6Fn8syj/r3XOLQs82wS
 GUgJNQKcltGe9tLAqp2ZFHFXfLwVCyZNcfRECDbRZT8nL3qb5IPmhpBIGSvX3TBY4lJObGFi2PYQA
 Vbue9b6vjobo5gA8OwfKNvGdqcKzmykUa2JsA+xbes9FebLLbtZMVzINviimWWcw3fCQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=; b=BxLmCAf7ss6NMyqJmzZ8g7eQYM
 uk0q9HiugqczmhuilY1/E4IP348EzihfaNWWXzXpkK8hzXfqlWALg4dPRu01jq9dD3Q9+NiExIf0o
 hhQEyV4NyugX32W6aqXhhp2U2GMj9tC4ybBwGT1HvJO6+X4XZuDB0TyILYHLlKkwPN5Q=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vmu6Q-0002xy-Nx for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Feb 2026 13:36:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C5615BCFE;
 Mon,  2 Feb 2026 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770039379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=;
 b=mgHGkwsDwZhO6atbUu6nt1bxZsy/zGmgKDzMxj6pnmrn1QE7S8zYdKvcLfxlwGVHlrOr19
 QM2Cs1QkCD1XUMhhxl7qoEz+J+sUbALu/XZFbIWdkLi0Lqq8BAySCuYawgXpfg6Wi9sc7U
 H2F4vZyqWToBYlmR1QsMbBJCVR+S0QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770039379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=;
 b=6IazOQPVfhBn+IRmJxPuIPDbd+tMWB+KbFPhjToHvwzsv25CizNrBF+Ii0h/iFfV8Nf3kJ
 SpU5TOugMtYZdJCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mgHGkwsD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6IazOQPV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770039379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=;
 b=mgHGkwsDwZhO6atbUu6nt1bxZsy/zGmgKDzMxj6pnmrn1QE7S8zYdKvcLfxlwGVHlrOr19
 QM2Cs1QkCD1XUMhhxl7qoEz+J+sUbALu/XZFbIWdkLi0Lqq8BAySCuYawgXpfg6Wi9sc7U
 H2F4vZyqWToBYlmR1QsMbBJCVR+S0QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770039379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=;
 b=6IazOQPVfhBn+IRmJxPuIPDbd+tMWB+KbFPhjToHvwzsv25CizNrBF+Ii0h/iFfV8Nf3kJ
 SpU5TOugMtYZdJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27BFF3EA62;
 Mon,  2 Feb 2026 13:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xdCyCVOogGmOJQAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 02 Feb 2026 13:36:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id CE784A08F8; Mon,  2 Feb 2026 14:36:18 +0100 (CET)
Date: Mon, 2 Feb 2026 14:36:18 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <vu3c3isevxhsayshrgv4yj2xfkeugbtx4jaryrdxehz57vq6ho@mkrueh7j55fe>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202060754.270269-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260202060754.270269-3-hch@lst.de>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email];
 RCVD_COUNT_THREE(0.00)[3]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_LAST(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3C5615BCFE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Headers-End: 1vmu6Q-0002xy-Nx
Subject: Re: [f2fs-dev] [PATCH 02/11] readahead: push invalidate_lock out of
 page_cache_ra_unbounded
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

On Mon 02-02-26 07:06:31, Christoph Hellwig wrote:
> Require the invalidate_lock to be held over calls to
> page_cache_ra_unbounded instead of acquiring it in this function.
> 
> This prepares for calling page_cache_ra_unbounded from ->readahead for
> fsverity read-ahead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index da029fed4e5a..c9b9fcdd0cae 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4418,7 +4418,9 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>  	pgoff_t redirty_idx = page_idx;
>  	int page_len = 0, ret = 0;
>  
> +	filemap_invalidate_lock_shared(mapping);
>  	page_cache_ra_unbounded(&ractl, len, 0);
> +	filemap_invalidate_unlock_shared(mapping);
>  
>  	do {
>  		folio = read_cache_folio(mapping, page_idx, NULL, NULL);
> diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> index 1a88decace53..8e0d6fde802f 100644
> --- a/fs/verity/pagecache.c
> +++ b/fs/verity/pagecache.c
> @@ -26,10 +26,13 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
>  	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>  
> -		if (!IS_ERR(folio))
> +		if (!IS_ERR(folio)) {
>  			folio_put(folio);
> -		else if (num_ra_pages > 1)
> +		} else if (num_ra_pages > 1) {
> +			filemap_invalidate_lock_shared(inode->i_mapping);
>  			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> +			filemap_invalidate_unlock_shared(inode->i_mapping);
> +		}
>  		folio = read_mapping_folio(inode->i_mapping, index, NULL);
>  	}
>  	if (IS_ERR(folio))
> diff --git a/mm/readahead.c b/mm/readahead.c
> index b415c9969176..25f81124beb6 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -204,7 +204,8 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
>   * not the function you want to call.  Use page_cache_async_readahead()
>   * or page_cache_sync_readahead() instead.
>   *
> - * Context: File is referenced by caller.  Mutexes may be held by caller.
> + * Context: File is referenced by caller, and ractl->mapping->invalidate_lock
> + * must be held by the caller in shared mode.  Mutexes may be held by caller.
>   * May sleep, but will not reenter filesystem to reclaim memory.
>   */
>  void page_cache_ra_unbounded(struct readahead_control *ractl,
> @@ -228,9 +229,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 */
>  	unsigned int nofs = memalloc_nofs_save();
>  
> +	lockdep_assert_held_read(&mapping->invalidate_lock);
> +
>  	trace_page_cache_ra_unbounded(mapping->host, index, nr_to_read,
>  				      lookahead_size);
> -	filemap_invalidate_lock_shared(mapping);
>  	index = mapping_align_index(mapping, index);
>  
>  	/*
> @@ -300,7 +302,6 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 * will then handle the error.
>  	 */
>  	read_pages(ractl);
> -	filemap_invalidate_unlock_shared(mapping);
>  	memalloc_nofs_restore(nofs);
>  }
>  EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
> @@ -314,9 +315,9 @@ EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
>  static void do_page_cache_ra(struct readahead_control *ractl,
>  		unsigned long nr_to_read, unsigned long lookahead_size)
>  {
> -	struct inode *inode = ractl->mapping->host;
> +	struct address_space *mapping = ractl->mapping;
>  	unsigned long index = readahead_index(ractl);
> -	loff_t isize = i_size_read(inode);
> +	loff_t isize = i_size_read(mapping->host);
>  	pgoff_t end_index;	/* The last page we want to read */
>  
>  	if (isize == 0)
> @@ -329,7 +330,9 @@ static void do_page_cache_ra(struct readahead_control *ractl,
>  	if (nr_to_read > end_index - index)
>  		nr_to_read = end_index - index + 1;
>  
> +	filemap_invalidate_lock_shared(mapping);
>  	page_cache_ra_unbounded(ractl, nr_to_read, lookahead_size);
> +	filemap_invalidate_unlock_shared(mapping);
>  }
>  
>  /*
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
