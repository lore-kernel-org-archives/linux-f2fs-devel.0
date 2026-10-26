Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1815606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bZtGUqN0;
	dkim=temperror header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i4fu3Pmo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G2Y4rgl/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iAXN/Nag;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JNbRYef1;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iAXN/Nag;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JNbRYef1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:References:In-Reply-To:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Xvk4VjZvg92qplAwLEQxSsuYZVCrcn6BhHTT1KQWLzE=; b=bZtGUqN02dhucgRtX01GVG4FTn
	2QbBLyubyOB0WW10ipUEDrdwHD47OafHOEqWG8qlfKX2bzc5Qm+i4WYQ/Cz4gPfBNqmf1om12a7WU
	vqrpVm6LlN/4pjp6WZ7KjvNzdnMyUjm9pg6hsOUKHq6jr8jf5+N7KaYiRFFov9DCoCx0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLMkz-000000000kf-2RZ5;
	Mon, 26 Oct 2026 15:37:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <krisman@suse.de>) id 1xLMky-000000000kZ-10Q4
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cF2LelxJ3MDx6ecMIAXwpCiisZ4MqO9Mbe0g8HDsS6s=; b=i
 4fu3PmosQA8TmehvQrhVmgyW8tVDR7IBNuYW2pW+xwZfF5ak8v3htqLqsKFiLYLUBWXtmDDbhc6gr
 3Tll2EShGppcHrBgeU81sc/YsRpbt/zZh9uV6oKCvKDArtLOvd1KrDByFo/E8pKb7TkIPAWHVN1ls
 IbiTKG7R4MgQ/mkA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cF2LelxJ3MDx6ecMIAXwpCiisZ4MqO9Mbe0g8HDsS6s=; b=G2Y4rgl/NkVNwjXZ4+DEBevr4o
 0u1/jPCTmY4XPIbF8H95wRKifSKvFPCBOqxlp9lJB1+ZWj6V+28QCZAf7TusHzznTJh3BCAC+ei06
 EcTHNc4PkLezxWYn2CLmaP15GrCLLoTTRZkM+ADye0zXXTdmcWVtqw23N4NZl3kbnrcQ=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLMkw-0000000043X-2EzY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:37:04 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB4C422006;
 Mon, 26 Oct 2026 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793029015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cF2LelxJ3MDx6ecMIAXwpCiisZ4MqO9Mbe0g8HDsS6s=;
 b=iAXN/Nag4cQ5zMf3PtgdB40d+rYxX9JJN392R9AezuxUIItNEQ/LY77WUmZXGiI+Kau6jF
 EUjwcW/0CsKEYhNOhVu/Klm1vydI+Krvw9KcB/8R3CZnxZjAewQxYpXaduCDyngii1qj+O
 93ayObOHgbUgLno/tEFsOXWtAD5Y1dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793029015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cF2LelxJ3MDx6ecMIAXwpCiisZ4MqO9Mbe0g8HDsS6s=;
 b=JNbRYef1E6RPpmJFcMsn/WUm7pdSpJLIiRoVJ+/h1NgtY/IBx57KvXgX79gIHfUFPKx1ml
 xZApWHb5f0C9gTCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793029015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cF2LelxJ3MDx6ecMIAXwpCiisZ4MqO9Mbe0g8HDsS6s=;
 b=iAXN/Nag4cQ5zMf3PtgdB40d+rYxX9JJN392R9AezuxUIItNEQ/LY77WUmZXGiI+Kau6jF
 EUjwcW/0CsKEYhNOhVu/Klm1vydI+Krvw9KcB/8R3CZnxZjAewQxYpXaduCDyngii1qj+O
 93ayObOHgbUgLno/tEFsOXWtAD5Y1dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793029015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cF2LelxJ3MDx6ecMIAXwpCiisZ4MqO9Mbe0g8HDsS6s=;
 b=JNbRYef1E6RPpmJFcMsn/WUm7pdSpJLIiRoVJ+/h1NgtY/IBx57KvXgX79gIHfUFPKx1ml
 xZApWHb5f0C9gTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56F0C13408;
 Mon, 26 Oct 2026 15:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E23TBZdz32pSfwAAD6G6ig
 (envelope-from <krisman@suse.de>); Mon, 26 Oct 2026 15:36:55 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20261023-work-dcache-casefold-v1-0-1b0bd5c73a69@kernel.org>
Organization: SUSE
References: <20261023-work-dcache-casefold-v1-0-1b0bd5c73a69@kernel.org>
Date: Mon, 26 Oct 2026 11:36:53 -0400
Message-ID: <87y0bkqxre.fsf@mailhost.krisman.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; HAS_ORG_HEADER(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLMkw-0000000043X-2EzY
Subject: Re: [f2fs-dev] [PATCH 0/2] dcache: don't leave negative dentries in
 casefolded directories
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: "Christian Brauner \(Amutable\)" <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Christian Brauner <brauner@kernel.org> writes:

> ext4, f2fs and tmpfs keep negative dentries out of casefolded
> directories. A negative dentry remembers one spelling of the name and
> the next create() through it would write that spelling to disk.
>
> So their ->lookup() doesn't cache a miss and their ->unlink() and
> ->rmdir() call d_invalidate() on the dentry so that d_delete() doesn't
> turn it into a negative dentry.
>
> But d_invalidate() is the wrong primitive for that. It's for a name that
> went stale. It walks the subtree, prunes it and detaches every mount it
> finds, under namespace_sem, and here that runs from inside the
> filesystem's own directory operation. ext4_rmdir() does it with the
> journal handle still open and ext4_unlink() does it even when the
> unlink failed. All anyone wanted is the unhash.
>
> So d_delete() now unhashes the dentry when the parent is casefolded,
> next to the dentry-negative sysctl that does the same for every
> directory. ext4, f2fs and tmpfs drop their d_invalidate() calls.
>
> xfs's ascii-ci doesn't set S_CASEFOLD and can't so it d_drop()s instead.
> I did consider setting S_CASEFOLD on ascii-ci directories and didn't.
> overlayfs warns when a layer's casefold flag disagrees with the
> superblock having an encoding, and xfs has none.
>
> Nothing changes for userspace. A miss still isn't cached and a removed
> name still leaves no negative dentry behind. Verified with the same
> create, unlink, create, readdir and stat sequence in a plain and in a
> casefolded directory on tmpfs and on ext4, before and after.

I think the change looks fine and it passed fstests.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

Of course, the better approach would be to enable negative dentries
but the last attempt went sideways, though not for any good reason.

thanks!

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
