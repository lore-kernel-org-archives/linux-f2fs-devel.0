Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ED7C4452B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PF1zOj0kfG/4j4BizboDEALr5hJbJfmJZ9+QzC0CzYg=; b=Pm2fzYKjgD1OPRBRd+dxP/q4Vm
	PTXc3/7XlJlHzfqiAOfc3G842eBrITBxfs++jY4glfEd3SV8FL3l/jvRD/V4KEQBfq0xRRb8CMBk8
	v7m/bYqrStivdBf52INRZvpWfwHJA9/RHO6LMzyn7HP4e1mwHOA2JplQWHMNlqAnnXBQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlllt-000277-Q1;
	Mon, 20 Jul 2026 11:02:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dsterba@suse.cz>) id 1wlllr-00026o-Gl
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 11:02:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2QNvKujcEHJaP+CioAP0IMjfRWn5fi/vRa+eOghQmfk=; b=Cd1qrpYwDVGrCJ4XJjN2i7Wy9H
 qbLF50mNDcI9FRpjt+O6L8d0EkztF44s0lNO8eHeXpRdurfsBmFxHuoUaYLBr44Po+mkszqa3INJO
 J+1cRWZomHuc5HQoe/GG1wBXhBbfS08vvlBxFqQTxbQZKzFUVFkCOL1Sz/Z6kG2yNasA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2QNvKujcEHJaP+CioAP0IMjfRWn5fi/vRa+eOghQmfk=; b=XihKeZrMMB1T4suf3adjuAsflF
 4tmpFzXR27oYQhbYba5WkzM1+kM+LeElaQ68RyyE7s0FwXqhqrFgKzDbGB3yDsiiTccYMEulk508C
 jJGi+Ruz1y1Ydk1j9V2YitLLhsBjXy8XT3VnzbVCKT8f95SbUAwG/zJOOPqqiUa7uz8k=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlllo-0004sB-1u for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 11:02:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED28E79EF6;
 Mon, 20 Jul 2026 11:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784545356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QNvKujcEHJaP+CioAP0IMjfRWn5fi/vRa+eOghQmfk=;
 b=a7qlSHkBZSGAhww/XKsyTjzhnNPL0dmZCt8geb7JXcTWaL5DH/AqIjPqYqU5jBQ7DeaqHK
 G1eQWwkRJGSiGvC7KixQvhkSddx5aMjJNylVBQ+4nKep0HsCVhnI1Y63RIFNBSKBg25vH0
 GI8tq6Jc9UDoKqPSHfKh0x6vuErS77I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784545356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QNvKujcEHJaP+CioAP0IMjfRWn5fi/vRa+eOghQmfk=;
 b=mdiCEdABkidr3CU4n+sx7C9aiItHMfZE5xcZL3RtuffiZ18qVqO6peBEh9OvC8m9L9hqkK
 swnHQ0VVjVv0pbDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784545354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QNvKujcEHJaP+CioAP0IMjfRWn5fi/vRa+eOghQmfk=;
 b=SYPCh4W/VpU+ZdjNU8cHR9FCfFVxGssnHP6eZ6Nm2GhncK6aa2rElmHy4jvkF9FVL23nPG
 VjWFQhy9NBNCFUdxqqA3zwkdcEiqmsDxmW6uSuh5pzMZ5NQFk69GZ1aaRDuYAKOZltndJn
 cEs6Ysr53PB8XwQPeC2EBUSS5NIO9Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784545354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QNvKujcEHJaP+CioAP0IMjfRWn5fi/vRa+eOghQmfk=;
 b=Vd6mEVVOi+NEoFqqHHCJJVlts/tYAiD1noX9A0RGcec9sCUr8nFy12rKuBNkRLiZcGG0Ey
 QWh5zWS1hl+3wNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAC10779AA;
 Mon, 20 Jul 2026 11:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HrzGMEoAXmqhAQAAD6G6ig
 (envelope-from <dsterba@suse.cz>); Mon, 20 Jul 2026 11:02:34 +0000
Date: Mon, 20 Jul 2026 13:02:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260720110233.GD10684@twin.jikos.cz>
References: <20260710085256.3464201-1-aalbersh@kernel.org>
 <20260710085256.3464201-4-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710085256.3464201-4-aalbersh@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HAS_REPLYTO(0.30)[dsterba@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.977]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Headers-End: 1wlllo-0004sB-1u
Subject: Re: [f2fs-dev] [PATCH v11 03/20] fsverity: pass digest size and
 hash of the all-zeroes block to ->write
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 10, 2026 at 10:52:31AM +0200, Andrey Albershteyn wrote:
> Let filesystem iterate over hashes in the block and check if these are
> hashes of zeroed data blocks. XFS will use this to decide if it want to
> store tree block full of these hashes.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Acked-by: Eric Biggers <ebiggers@kernel.org>
> ---

For the API update in

>  fs/btrfs/verity.c        | 6 +++++-

Acked-by: David Sterba <dsterba@suse.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
