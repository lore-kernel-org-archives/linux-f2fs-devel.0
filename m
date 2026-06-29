Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934E1C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVkv8iRPqsLuYvcolzoznU7jMc8u2Rqz8iDmF0UROc4=; b=f5mFBuVKinheP6ujMycBFdkH/c
	rfcnxQIuYHCoP4KgKLB0cqZF66LxXWeqqD3TKH+NfhUTyul4ut5NjpIgjGYAIDbkMKb/sB32ei0SQ
	2/VNctIFGffVYW6j9x/sypJBzif/PlsO9iX5fHo3SKuaGailOy0qnVRinuhcNoNedzns=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1we7pJ-0008EX-GH;
	Mon, 29 Jun 2026 08:58:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1we7pI-0008EL-Fk
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 08:58:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=75eCaF7DdWHwN8Yy+9PPiahvMMfwHETFR7MEHAeWwvc=; b=UZ/6+jX50ciu1C2Bfr8z+T20ip
 wxtQ6RDffKcULMQ2jr3FMjeA66EkhJEBrGv3i03900jIUFUqMeM/AprkuYm2w+VjLzoHwE9WG+MLi
 IxGWjrAvpt1A/yoq+Iz2GH9U7/HLfSVHqrvmn292MW/NsFwV1Z2qkBgaf7OtmeabFO5s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=75eCaF7DdWHwN8Yy+9PPiahvMMfwHETFR7MEHAeWwvc=; b=AuBpBjHGtYpogxCB7IRHFiiwZP
 wUnErw9gB/67mZ2JcymeMtm7Tdhvwfuw/Np8RxtBoH/kId1qexGrkKjf4/9nAu0z2CXXyq8fmOTGN
 F1AlSa3CkEU0RL2NP+0cKhXjxg6lCcNo3dVH8V5Uhsiye6j/4dT5VZGbM92bE60XbRXo=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we7pG-0006la-ST for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 08:58:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C86A975987;
 Mon, 29 Jun 2026 08:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782723520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75eCaF7DdWHwN8Yy+9PPiahvMMfwHETFR7MEHAeWwvc=;
 b=vOlVzJbne3sQZCfpWThXJxsghUldA6Iz0T+tLvaxx2OGdnSmsZlqZWwjMOYTc1N2UQn8r4
 Wt53PEudnxXZkekAaEiY9aLqWmaY5BnxUM+gU2IvbXY7+1PIzROUsAc+CMZ5uQ+oYavOfk
 i0pM96JjxK8hXGAEyOkdQQ7dZKBTA8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782723520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75eCaF7DdWHwN8Yy+9PPiahvMMfwHETFR7MEHAeWwvc=;
 b=8y01M4RU+eIs11JID7XntBk2hsVX+zRTiTpEfy5QH+k5XKGfVeV/Z3SWxcE9B/gRfC7Uxn
 gZriM7ccPPOpXfAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vOlVzJbn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8y01M4RU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782723520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75eCaF7DdWHwN8Yy+9PPiahvMMfwHETFR7MEHAeWwvc=;
 b=vOlVzJbne3sQZCfpWThXJxsghUldA6Iz0T+tLvaxx2OGdnSmsZlqZWwjMOYTc1N2UQn8r4
 Wt53PEudnxXZkekAaEiY9aLqWmaY5BnxUM+gU2IvbXY7+1PIzROUsAc+CMZ5uQ+oYavOfk
 i0pM96JjxK8hXGAEyOkdQQ7dZKBTA8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782723520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75eCaF7DdWHwN8Yy+9PPiahvMMfwHETFR7MEHAeWwvc=;
 b=8y01M4RU+eIs11JID7XntBk2hsVX+zRTiTpEfy5QH+k5XKGfVeV/Z3SWxcE9B/gRfC7Uxn
 gZriM7ccPPOpXfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDB79779A8;
 Mon, 29 Jun 2026 08:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P2JMLsAzQmoVPQAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 29 Jun 2026 08:58:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 54BAFA10B5; Mon, 29 Jun 2026 10:58:40 +0200 (CEST)
Date: Mon, 29 Jun 2026 10:58:40 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <kuag63fjw2cvzqc2gahefcxnlp3jwqtapr6gwkgvhse6aez6hr@spvbvpprpwgb>
References: <ajwtQRawMxcQkyo8@casper.infradead.org>
 <ca56ceb7-b0a7-41f2-9b26-085e81456794@amlogic.com>
 <324cc5b6-ebfd-4696-b2f4-33710b771249@kernel.org>
 <akHsfps-sQ1INJfS@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <akHsfps-sQ1INJfS@casper.infradead.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C86A975987
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Headers-End: 1we7pG-0006la-ST
Subject: Re: [f2fs-dev] Use of FGP_NOFS in f2fs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon 29-06-26 04:54:38, Matthew Wilcox wrote:
> [Adding Jan Kara; retaining whole message for context]

Thanks!

> On Mon, Jun 29, 2026 at 09:39:25AM +0800, Chao Yu wrote:
> > On 6/26/26 17:30, Jiucheng Xu wrote:
> > > On 6/25/2026 3:17 AM, Matthew Wilcox wrote:
> > > > [ EXTERNAL EMAIL ]
> > > > I am trying to remove FGP_NOFS from the kernel and the last remaini=
ng
> > > > user was added by you last year in commit 2308de27c03d.=A0 I'm tryi=
ng to
> > > > understand why.=A0 Did you see an actual problem if you do not use =
it,
> > > > or was it theoretical?=A0 The commit message says "to avoid potenti=
al
> > > > deadlock issues", but it's not clear to me whether you know they are
> > > > there, or only think they are there.
> > > > =

> > > > I'd really like to understand what the issues are as the normal iss=
ues
> > > > which make calling into the filesystem (holding another folio locke=
d,
> > > > holding a mutex relied upon by reclaim) don't seem to be present.
> > > > So if there is something, I'm not sure what it is.
> > > Hi Matthew,
> > > =

> > > The FGP_NOFS flag was suggested by Chao and not adding it might lead =
to deadlock issues.
> > > =

> > > @Chao could you explain this for Matthew?
> > =

> > Hi Matthew, Jiucheng,
> > =

> > IIRC, for normal path from write -> write_begin, it seems fine since th=
ere is
> > no f2fs-specified mutex or other folio lock in the path, but I was worr=
ied about
> > quota path when I suggested to keep GFP_NOFS flag, as the lock race con=
dition
> > is quite complicated there: f2fs internal lock vs quota system lock vs =
folio lock...
> > =

> > I searched the commits and found this:
> > =

> > Commit 02117b8ae9c0 ("f2fs: Set GF_NOFS in read_cache_page_gfp while do=
ing
> > f2fs_quota_read")
> > =

> > In this case, f2fs_quota_read() was calling read_mapping_page(), which =
allowed
> > GFP_FS allocations. This triggered the following deadlock:
> > =

> >     Thread 1 (User Open/Write)
> >     - do_sys_open
> >      - vfs_open
> >       - dquot_file_open
> >        - dquot_initialize
> >         - dqget
> >          - dquot_acquire
> >           : locks &dqopt->dqio_mutex (VFS Quota Mutex)
> >           - qtree_read_dquot
> >            - f2fs_quota_read
> >             - read_mapping_page (GFP_KERNEL / allows GFP_FS)
> >              - __alloc_pages_nodemask
> >               - try_to_free_pages (Direct Reclaim)
> >                - prune_icache_sb
> >                 - evict
> >                  - f2fs_evict_inode
> >                   - dquot_drop
> >                    - dqput
> >                     - dquot_commit
> >                      : tries to lock &dqopt->dqio_mutex again
> >                      =3D=3D> DEADLOCK (waiting for itself)
> > =

> > It may trigger deadlock in f2fs_quota_write() as the same way in f2fs_q=
uota_read()
> > path? let me know if I'm missing anything.
> > =

> > Are memalloc_nofs_save() and memalloc_nofs_restore() recommended for su=
ch case?
> > any suggestions?
> =

> In general, yes, memalloc_nofs_save() after locking dqio_mutex sounds like
> the right idea to me.  I'd want to familiarise myself more thoroughly
> with the code before making a firm recommendation, and it's probably
> quicker to just ask Jan ;-)

So the above stacktrace shouldn't be possible since you've added
memalloc_nofs_save() / restore() pairs into quota code in:

537e11cdc7a6 ("quota: Prevent memory allocation recursion while holding dq_=
lock")

Chao, are you sure the GFP_NOFS mask isn't just a relic from the past?

								Honza
-- =

Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
