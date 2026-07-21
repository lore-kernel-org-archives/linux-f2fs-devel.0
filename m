Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE00C44524
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 02:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yDS7OXYPDUDnM9e4+Vrm8IZwagMUqPwN7EvHSTsFhfo=; b=Wpw/RF8k5XRv+WSe+sf7jr1/T6
	EiS9U+wry+rnGq3jhs+yaJ20uFz0Lj5hJMxL7QZxhFHGoYgzUWZ0kkyi8zHlzfwsUzz7hIDMvD3RS
	Qvb5UHF97DJAPF58r3Tore7C+eWDdu+RG7wtEQStwuHPASUbF2VTbo5Mk/aMlMuy7ucU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wm0ge-0000As-2k;
	Tue, 21 Jul 2026 02:58:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dsterba@suse.cz>) id 1wm0gc-0000Ak-15
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 02:58:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7JD/okLtrTfrWA/8kEFlGhqpktN40fdQr75rS3L+eAA=; b=cbtIHpZiJli5N+2sS679iB4JtG
 HTLuCk1S4efUZ41HBYdwf1yffUKBkeUoo8u7rulZVk4mtmtCnbNhTYgt6E57lMfARIiYdL2rOEWkp
 2Bs+lkVEpdIUYIXfX7ShkF9oG3ip82nxllVz+sjdN+ldogfkfrOUXrSb5BRX3EUlGVL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7JD/okLtrTfrWA/8kEFlGhqpktN40fdQr75rS3L+eAA=; b=efpUP9q0v2KUljbYLxHbHZtsFe
 Ly6fIgaNyFxl4gPw0RRaIKPLhuY3v94MbFQ+wAt+uUXZoFwmbuR0uJg8nWfvjaIspwMsicOu2PU/i
 z71PGS6Jttug31515TX3wtAmM1lvJeNeZmCuCuZgEm5IE7T63IMCyhBmV+psO9cg8b0Y=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm0gb-0008RE-2V for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 02:58:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 282887A33E;
 Tue, 21 Jul 2026 02:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784602693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JD/okLtrTfrWA/8kEFlGhqpktN40fdQr75rS3L+eAA=;
 b=vayez1f4tSWBX7T5Y0ws7I/LftAeF55dKiJq2yCl12/k+qcbcKGf0ntNQ4H3xS1Oa5Smxw
 BiPwzLop3YAUAgKAirWN9+pqW1GV12HmBR1d6WOWUy0jfbKO7IahBMXfnt9tbEMm8r8TUE
 +BDwxzaCIsfGo4V4Z9MpnAgHB5X3MYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784602693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JD/okLtrTfrWA/8kEFlGhqpktN40fdQr75rS3L+eAA=;
 b=1GOgq7DmNyCGizojBidkjn+uWADLnzAVOuf+syzirWXAbLn0q8yBXzMrO+3Tk+bSlSDXlz
 qtWhihvUXjTeJyAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vayez1f4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1GOgq7Dm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784602693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JD/okLtrTfrWA/8kEFlGhqpktN40fdQr75rS3L+eAA=;
 b=vayez1f4tSWBX7T5Y0ws7I/LftAeF55dKiJq2yCl12/k+qcbcKGf0ntNQ4H3xS1Oa5Smxw
 BiPwzLop3YAUAgKAirWN9+pqW1GV12HmBR1d6WOWUy0jfbKO7IahBMXfnt9tbEMm8r8TUE
 +BDwxzaCIsfGo4V4Z9MpnAgHB5X3MYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784602693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JD/okLtrTfrWA/8kEFlGhqpktN40fdQr75rS3L+eAA=;
 b=1GOgq7DmNyCGizojBidkjn+uWADLnzAVOuf+syzirWXAbLn0q8yBXzMrO+3Tk+bSlSDXlz
 qtWhihvUXjTeJyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1381D779AA;
 Tue, 21 Jul 2026 02:58:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wN4mBEXgXmpIHgAAD6G6ig
 (envelope-from <dsterba@suse.cz>); Tue, 21 Jul 2026 02:58:13 +0000
Date: Tue, 21 Jul 2026 04:58:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260721025811.GF10684@twin.jikos.cz>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
 <20260720090410.3487990-4-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260720090410.3487990-4-aalbersh@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 282887A33E
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HAS_REPLYTO(0.30)[dsterba@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; REPLYTO_ADDR_EQ_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Headers-End: 1wm0gb-0008RE-2V
Subject: Re: [f2fs-dev] [PATCH v12 03/21] fsverity: pass digest size and
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

On Mon, Jul 20, 2026 at 11:03:31AM +0200, Andrey Albershteyn wrote:
> Let filesystem iterate over hashes in the block and check if these are
> hashes of zeroed data blocks. XFS will use this to decide if it want to
> store tree block full of these hashes.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Acked-by: Eric Biggers <ebiggers@kernel.org>
> ---

>  fs/btrfs/verity.c        | 6 +++++-

Acked-by: David Sterba <dsterba@suse.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
