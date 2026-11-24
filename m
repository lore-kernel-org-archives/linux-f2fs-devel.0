Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50699606A332
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=R7kuId86;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=koppJGoi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=euiBZ9eq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ABSW4SHs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eZhk8UbS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aqZ1v6OZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qv1aY4/M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:References:In-Reply-To:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ENT8PsZlluwJL1g6aT+iy7ViVCUiEWiwIQ+Un5JtM9c=; b=R7kuId863PRaNxXkWWUCSTdBTn
	XtBeekitV9Zh/xNB7qYU8xmW8TC/45i+MVhAN/JpnZKn4241nYtz2XKodBtxI7N9cBf7wnesKNuCd
	phCuEn+l2dzAz0gLnDSyD8L4MdJIWy7B5zzw84c7QRb3Z6H8cBzYTYylZOBeMXikLhTA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVwZA-000000002oo-0DIz;
	Tue, 24 Nov 2026 19:52:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <krisman@suse.de>) id 1xVwZ8-000000002oi-3QlX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yS7O3rY1oGDr4IdzWC9LN89ek2gLw2iYbqf8+mjmRCg=; b=k
 oppJGoit9PDtRajFV8kQYVAHIV5PtJaf7E0FF9pPq5GbtTEGV8t1tOab++BdVrMBnL0+m94oRm/NR
 WXMT0qzcp/F++jAJxQAcoDhC1omBtoVHZEXUwc5h3cZ47EvPNYNt9fDnoNsgSdT8XESHrusqy3aDS
 rdAVVhr11iwueVyo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yS7O3rY1oGDr4IdzWC9LN89ek2gLw2iYbqf8+mjmRCg=; b=euiBZ9eqQS/oskCTU7JruniiCp
 hSWErcFMt3tdRnVVlHv1xx2LQ+Gj0baDp5m2PPsQmqn/xGQlR9PCwIZVjaLmipgWtim6sQXthI+0l
 rtRx9rhQZQBYhtMgyZb9poY5JRSCnxvoq68He5uNyEHCyQEmdWpTaekq1hGIbu7HVFPM=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVwZ6-000000003fr-0HRs
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:52:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 669D01F74A;
 Tue, 24 Nov 2026 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795549945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yS7O3rY1oGDr4IdzWC9LN89ek2gLw2iYbqf8+mjmRCg=;
 b=ABSW4SHs1GfyhLVQ5cmQVHhbhYepMI1Px5Cu45+4wvB/xYKaHt/daGvGmP+LK/Q29aUD3d
 cpDaM7OzoXTzZIqdamxfZ/w+7qnK+0fXgOL9827YuAI0c7AsU3jPXmcPlwrsrH4IROvLBq
 PST3uD4/wREGzB7p1WjsuGckN3Ehce8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795549945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yS7O3rY1oGDr4IdzWC9LN89ek2gLw2iYbqf8+mjmRCg=;
 b=eZhk8UbSU4nTa1ZVZOsfnPOLNd5gGACp1YNIWXPCyoNYdMRNwReGeS2p/rk+ZdOuojfYJT
 EGf6rEudpU1kp2AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aqZ1v6OZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="qv1aY4/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795549944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yS7O3rY1oGDr4IdzWC9LN89ek2gLw2iYbqf8+mjmRCg=;
 b=aqZ1v6OZZhD0L6t/OtkrvtdoUw+6bndbfupVFnsWrhQxlaJIYGmc0h/9wshnOsWoEEY20j
 Q3gurqN9ZGyW+mwh6g8TXyGnDltsqn5vJ6kIiTLOzsfAO3j9BTn3H+Yx9AYZR8GO6u8gbo
 UrW24EouDg4SAOqvg23eoRAMsXGT8kA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795549944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yS7O3rY1oGDr4IdzWC9LN89ek2gLw2iYbqf8+mjmRCg=;
 b=qv1aY4/MYDiSFNBtI2kb9tahjtzyX0nEc93C13sUw/l8vQ2ivFVv06bCgYiMvSemkFFAAx
 dly2ZcRh11Lm+cDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE0DA1339F;
 Tue, 24 Nov 2026 19:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oniJIffqBWsLeQAAD6G6ig
 (envelope-from <krisman@suse.de>); Tue, 24 Nov 2026 19:52:23 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Sarthak Kukreti via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
In-Reply-To: <20261119214944.1480596-4-sarthakkukreti@google.com>
Organization: SUSE
References: <20261119214944.1480596-1-sarthakkukreti@google.com>
 <20261119214944.1480596-4-sarthakkukreti@google.com>
Date: Tue, 24 Nov 2026 14:52:18 -0500
Message-ID: <87ik1mc8i5.fsf@cartola>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-13.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[13]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; HAS_ORG_HEADER(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 669D01F74A
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVwZ6-000000003fr-0HRs
Subject: Re: [f2fs-dev] [PATCH v2 3/3] f2fs: reject casefolded names that
 fold to ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sarthak Kukreti via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> writes:

> From: Dmitry Torokhov <dtor@google.com>
>
> Filenames consisting only of ignorable Unicode characters fold to empty
> strings, and names with leading dots and ignorable characters can fold
> to "." or "..". Allowing such names in casefolded directories can corrupt
> directory structure or cause confusion with special entries.
>
> Reject any non-dot names that fold to empty, ".", or ".." during
> casefolded name setup, while still allowing invalid UTF-8 sequences to
> be handled as opaque byte sequences when strict mode is not enabled.
>
> Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
> Signed-off-by: Dmitry Torokhov <dtor@google.com>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>

I don't have any comments on this one.  Fell free to add:

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>


-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
