Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C46B606A334
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aAchaJK9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Th36F+aX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Pkk/QIxI;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRp9sI7J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eqbo/di2uDxJ1EruNPpEYPrer4rdIUF2NpW6XTCnUJk=; b=aAchaJK98YY/Mqh1FXbqvh9Nfg
	TllFbCUaKAGXq3FMJwK3dPPSg8ASpAo/U9DdEzQt56SkePCtPFNE1TXj2i4GNjTqLvAY9qslLZOlD
	v4eFRgjpzKG//XtCfsNgcP38Y9T1LeBf7K6jJH/Ws790ziTvQwh8O7dmcHkPgZQ8YuCI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT2xp-000000001dc-3btG;
	Mon, 16 Nov 2026 20:06:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xT2xI-000000001cv-3H0n
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l10KwZnyY8coN9NQid+WKk5YmcYQIwYBCQlgLcj1qYI=; b=Th36F+aXg3u0uJ3+U/+C4BsJcF
 axH+rLHEUM0fkZbwBr9llx0UwgiBz9XdADqHsPv98imhqjdB8wSu9iimcqzfq+d/OlUrtWak6DunO
 /nhtDXptZm9zvcTihi1x+/zpwnmuBRFYCl/3TO/b3qlFyci915DCZKYO4i7T6PVd2BEI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l10KwZnyY8coN9NQid+WKk5YmcYQIwYBCQlgLcj1qYI=; b=Pkk/QIxIPLI5MHTPZpMvioD9OC
 CcwaASCi2Hgh+oCHUueAN0lpetil/pKcEp6QmAbUupq4w02sKPcokGQ8NO82FrZvhzqQa6eZklYpb
 NUE7EYfLA/lh0dOrUTwghLF0FV6EVGwJwiUMw+kBzozY1S0MYhiXpH6VfuDfKJx2hxOg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT2xI-000000008OY-1JqJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:05:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3DC362661;
 Mon, 16 Nov 2026 20:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B0E1F000C5;
 Mon, 16 Nov 2026 20:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794859526;
 bh=l10KwZnyY8coN9NQid+WKk5YmcYQIwYBCQlgLcj1qYI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nRp9sI7JCZx3gq9LvgUoM2Lfg03vzU4e3rIkXftRbvJXSIgnWKmf6raxsWNDsD/NS
 RH2gupg0X8Ypq4c9MbQaYyLfIJzxdHf7o64ZBCERTX2yWofJPDXcHQIvck3z3sHFK+
 ZLibemkSlskMRXiiR/lUsVj0pQy/R6Ll5A49L8sfg+Qa1k64Knzi+vS1+e8nqIX0tB
 5ZEflWAcs8Ko2P/NypGbo+qtba0FEMtIUuW/1uZxA19PtvFlkZmH6EJ28DB8gBLOiY
 EveC18Is3ngrgkYJ1z5PEgnsZ/FlYYusVypTqdMnFxoygEJCwFPTV/GafMoI2Wu3yb
 pOIyWHYucQEng==
Date: Mon, 16 Nov 2026 20:05:24 +0000
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20261116200524.GD229817@google.com>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
 <20261113065332.929085-2-sarthakkukreti@google.com>
 <878q2swoxp.fsf@cartola>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878q2swoxp.fsf@cartola>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xT2xI-000000008OY-1JqJ
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 02:34:26PM -0500, Gabriel Krisman Bertazi wrote:
> Hi Sarthak,
> 
> Ugh. I agree this is a problem, but I'm also trying to understand first
> the real impact beyond filesystem complaints during lookup, if any:
> 
>   1. Looking up ".\u202e" folds to "." and matches the on-disk "." entry
>      (de->inode == dir->i_ino) in generic_ci_match(), triggering
>      EXT4_ERROR_INODE ("linked to parent dir") in ext4_lookup().
>   2. Looking up "..\u202e" folds to ".." and matches the on-disk ".."
>      entry, returning -ELOOP via d_splice_alias() (or triggering
>      EXT4_ERROR_INODE on the root directory).
> 
> These two look like a "do stupid things, get stupid prizes" with no
> further repercussions beyond the error message.  Sure, we can fix them
> to throw EINVAL, but are there bigger repercussions I'm missing?

For one: if the filesystem is mounted with errors=remount-ro or
errors=panic, then EXT4_ERROR_INODE is more than a log message.

> But the way I'd suggest be handled is by rejecting the ignorable code
> points lookup (all, but variant selectors for the reasons above), early
> in the lookup path for case-insensitive directories so they never even
> get to the filesystem.  Wdyt?

If variation selectors are still allowed (e.g., "..\ufe00", that
wouldn't actually fix this bug though, right?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
