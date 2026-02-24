Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FDEE9B263
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6eqLDtHpAIFLMp/E1ztJ45lqWjXPkZ5gOPCCg5mhqG8=; b=PlMIrwY7lgtfjd/Jp0qB936I7s
	6W8feCSgWjlKEKo+s7OwIJfTgkdN/W1hNt7c13+KCSDXSzUJYrIizc3APKlWcnkE02FCdVXkj2tjD
	gwyzm7W2vun+Ng4h6Ml50FsAgO6QBnFbzYtH8VIPJlS5l1Hl+xecQ7D2+/aQeFdv5lF4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vussm-00079r-Tu;
	Tue, 24 Feb 2026 13:55:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dsterba@suse.cz>) id 1vussl-00079j-IV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 13:55:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=; b=H2/Z1UCCH9i8HWgx+awt+L2Zrc
 qcpJoKshVL5p/Ll8yoB6Z/qevDT4sm6kH4q4XDx74w/3vvQV6nCE/y76Fk+flnUFuRCXTAuI08V2d
 Zo7WtS7KaZgbcfeZQFUOQyoSSG7opGOEZtYVpxE9VYWtwb0TrpTlHvWwSHjh3JkEt1bM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=; b=hu16JL2hpl055awIxi0Dn0nRwE
 WIhdxqa20nK4yGGodcPK+0JalYOkorz3COQc8z+UiSexQflEXjv68UHenxSY+JYebuQvzNv+0gtQQ
 hh+Md92FfnlSVnfqIHxo90GFsPRPfzuwUOc6euF46BH/SLnIAjQS2JbH9mrbX3uFn6GQ=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vussj-0007e8-N4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 13:55:23 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 013293F251;
 Tue, 24 Feb 2026 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771941309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=;
 b=MT1kUN+gGMsCoUB7Gjf+X+6FRCA4P14szw92f6JxsRV9UMCUBkcWJ/9jC42VOyxmQsQ3Ps
 iQZMh7ZKItwreVqdT0dkT/MVXaUQUyAzinPYWwXqVuomUEFjzWu09pIxdXe6uVgKTQ9nuj
 huY1D4lmsDtGpbQaHXgiCDySZqFGOhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771941309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=;
 b=6EFemYbm6sEj3mrcQ6sGZxLXHy3au4fcdkZjOBJZG/c8rQEr1EOhkmXX1kXnTMf41r2YMZ
 ZGAmaWkNO5ITBFBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MT1kUN+g;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6EFemYbm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771941309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=;
 b=MT1kUN+gGMsCoUB7Gjf+X+6FRCA4P14szw92f6JxsRV9UMCUBkcWJ/9jC42VOyxmQsQ3Ps
 iQZMh7ZKItwreVqdT0dkT/MVXaUQUyAzinPYWwXqVuomUEFjzWu09pIxdXe6uVgKTQ9nuj
 huY1D4lmsDtGpbQaHXgiCDySZqFGOhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771941309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=;
 b=6EFemYbm6sEj3mrcQ6sGZxLXHy3au4fcdkZjOBJZG/c8rQEr1EOhkmXX1kXnTMf41r2YMZ
 ZGAmaWkNO5ITBFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB6473EA68;
 Tue, 24 Feb 2026 13:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6HV7MbytnWkuJwAAD6G6ig
 (envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 13:55:08 +0000
Date: Tue, 24 Feb 2026 14:55:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260224135507.GT26902@twin.jikos.cz>
References: <20260221204525.30426-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260221204525.30426-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HAS_REPLYTO(0.30)[dsterba@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 013293F251
X-Headers-End: 1vussj-0007e8-N4
Subject: Re: [f2fs-dev] [PATCH] fsverity: add dependency on 64K or smaller
 pages
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
Reply-To: dsterba@suse.cz
Cc: fsverity@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Feb 21, 2026 at 12:45:25PM -0800, Eric Biggers wrote:
> Currently, all filesystems that support fsverity (ext4, f2fs, and btrfs)
> cache the Merkle tree in the pagecache at a 64K aligned offset after the
> end of the file data.  This offset needs to be a multiple of the page
> size, which is guaranteed only when the page size is 64K or smaller.
> 
> 64K was chosen to be the "largest reasonable page size".  But it isn't
> the largest *possible* page size: the hexagon and powerpc ports of Linux
> support 256K pages, though that configuration is rarely used.
> 
> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.
> 
> Fixes: 671e67b47e9f ("fs-verity: add Kconfig and the helper functions for hashing")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Closes: https://lore.kernel.org/r/20260119063349.GA643@lst.de
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/verity/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/verity/Kconfig b/fs/verity/Kconfig
> index 76d1c5971b82..b20882963ffb 100644
> --- a/fs/verity/Kconfig
> +++ b/fs/verity/Kconfig
> @@ -1,9 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  config FS_VERITY
>  	bool "FS Verity (read-only file-based authenticity protection)"
> +	# Filesystems cache the Merkle tree at a 64K aligned offset in the
> +	# pagecache.  That approach assumes the page size is at most 64K.
> +	depends on PAGE_SHIFT <= 16

Makes sense to me, we have "depends on PAGE_SIZE_LESS_THAN_256KB" since
somebody tried to use btrfs on the 256K system.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
