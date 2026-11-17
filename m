Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC6606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GjagpTAT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j/n5lyfO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VmEsNc8t;
	dkim=neutral header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=cxPrl4Mm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=1E74SPAFTgIiVeAAuqWc4S3c0J+qnmGKbVMVMCG9oXw=; b=GjagpTATCwUP9KL2e2GVh8kLYV
	JWZjok1Rpug9DjALgWzRfkXMvMB7SgzZWYo65JQeDkWvlLgUAhna7wYJBkRGEnSXKrknUM6maXUkG
	m5LzIaSB1s221Zlv3DLuICHcDDQdyjBRQQBwZZbYYme0d0WDBTq6CV0vzeNdWv4MoWGI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTKaG-000000007lz-0M0M;
	Tue, 17 Nov 2026 14:54:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tytso@mit.edu>) id 1xTKaF-000000007lr-1we8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JZ67Ln6ziaBPsKaIzdqErWNCSGgvnSYlqc/yhQf9HX0=; b=j/n5lyfObgHT5kP5IGL5p+9PYG
 0VkEviWaGzr8rnOMPfAsIRpuMl21+nUGmx5XPVJIxTzcn9P4ZiEpTzaoJSzsPao4gTEkPgxJM71fW
 U1BoAQ3zZCi3Bxaf+UWh1PXrd48XTopkRVAeYJvFuL6KS2SB8y8dPY942Jah1LsK/HSM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JZ67Ln6ziaBPsKaIzdqErWNCSGgvnSYlqc/yhQf9HX0=; b=VmEsNc8trCEA+uwvQk6OK13y7R
 cYP0tAbj8uZxfpMN3zLS/qem/hk37CCALZZYpXJT1GfpV/Dsn2y0SWXqN2KsQnjNWKx7X6PIZULCM
 sQo/fq+hDRIzFOeOIM6tXf6fsV3Qh98h9IAlPYXr5kSjWQzVl85gnj5tlp73m+m1PGug=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTKaE-000000004V8-3Ar8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:54:55 +0000
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net
 [73.9.28.129]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AHEsWAV025356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 09:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1794927277; bh=JZ67Ln6ziaBPsKaIzdqErWNCSGgvnSYlqc/yhQf9HX0=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=cxPrl4Mm1T30CBSddcZy5wnEp6gC/wd8ru0R7LA87M2l8dJaIPqQsiEnyxIe2ZUCU
 eygzAr76BDUzp/18d24nDpDp54kiP9TiW4gx5pRs2JjFcjPA2j8s0FhAxU1sBKC/Ns
 2wYcU39Se3OKsn0M4KHgbKq8MaZ9WrdqgSJ8RVv/BGGfvXOLpNvakevm0PinCI5Lqq
 160eXk9lwAXj4dwMpeqCKzXwGRdgDLChvNGzx5Zs/A3xWNx0h5c43cHAOednZoLbE4
 mItAna7bt2OFZ55xE4AomDkNmIffUWVZKGnCZE56UOJ0rloMcwNFABBHIPxd8yFtoN
 95wDlCS2Zo9hQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
 id A03EE27D8EC8; Tue, 17 Nov 2026 09:54:32 -0500 (EST)
Date: Tue, 17 Nov 2026 09:54:32 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: David Laight <david.laight.linux@gmail.com>
Message-ID: <avxe5v6r1C7ZG7E2@mit.edu>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
 <20261113065332.929085-2-sarthakkukreti@google.com>
 <878q2swoxp.fsf@cartola> <avu0X5E298dHRBHY@mit.edu>
 <20261117084727.0cfa196a@pumpkin>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261117084727.0cfa196a@pumpkin>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTKaE-000000004V8-3Ar8
Subject: Re: [f2fs-dev] [PATCH 1/3] libfs: reject casefolded names that fold
 to ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
 Christian Brauner <brauner@kernel.org>, Eric Biggers <ebiggers@google.com>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 08:47:27AM -0500, David Laight wrote:
> > Sigh... I really think these characters are *evil*.  I wonder if we
> > should simply drop those code points unconditionally when they are fed
> > to the kernel --- not only folding to themselves, but *not* preserving
> > them when a misguided application tries to create a file with one of
> > these misbegotten Unicode charactesr.
> 
> Doesn't that assume that filenames are UTF8 rather than just sequences
> of bytes with everything except '\0' and '/' being valid.
> Casefolding is itself so evil/impossible it shouldn't have been allowed.

We would only do this if casefolding is enabled.  For better or for
worse, it's better than what it replaced which was this terrible
wrapfs hack that was a trivial to trigger deadlocks using fsstress ---
which was even more evil.

The other way we can deal with this is that if case folding is
enabled, we change the VFS to call the case-folding for incoming
filename *before* it does its special case checking for '.' and '..'
if casefolding is enabled.

					- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
