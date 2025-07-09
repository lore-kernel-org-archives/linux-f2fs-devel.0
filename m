Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66C4C83F0A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Jul 2025 19:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UIgcrXRJ7iyQF7TP+uHNEKeKmgJ/rLvK8PfzJGevFlw=; b=iFM47XUBA52XWreIAQbAO9Rp/o
	sDF0G2Puf0UiR6j8933KMip1EGFuOQh0qsLumNr4Jrr605fLYq97ryZ/wcd0wvEFZmeyZeksoTFMn
	d9x3JqPf5vHjbZIWjK9DQ3cpRIP1PezntgJZOzN1MLa8J2xZkBjinv/QAyGtv5AsPkhI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uZaSD-00061H-6d;
	Wed, 09 Jul 2025 19:27:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1uZaSC-00061B-Jm
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Jul 2025 19:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iAKyw9SiS7tAPeT8yFNEhG/mFr69U9y6Ca86gIdVh3w=; b=Ee+G8wg9NNqMZU0C3dJILofjiJ
 b2k5iUMnzPjKRO1vOoaftA59Pxc9OhqSY67pX2ki0olvQmFbeztt8L/2JnrchTa/lAi5gYJAeeoPi
 9ri6Ew1Ityu20/k4jwG2xR5NUa3GSo7UKQg/SGyC0dk+s0oPFmunSt8OKKRCv46yqJXI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iAKyw9SiS7tAPeT8yFNEhG/mFr69U9y6Ca86gIdVh3w=; b=W/ZXcUrkNupH7p0xZHbH65ByN2
 2TlMOhWQzjVO4Rbdf1fSkeryZCOUjW96IaGYIEClFTx4vpbv7IsXNadnMVRat/gUGXdONR8OTvGDz
 eHfR2sYgLw208TXzvzJunUMRJ/VztFsl/m7kyiHpWm+JvKJwDJ9gckClUyRNAJyYq8S8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uZaSC-0005Mu-5E for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Jul 2025 19:27:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C4AB04362E;
 Wed,  9 Jul 2025 19:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61672C4CEEF;
 Wed,  9 Jul 2025 19:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752089254;
 bh=Zm+FZCamXFOfYZVRCK0BZ5RTFEHBxsMTaWL62PvvIec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tPpKm1tdvE3ARsw+TSv1uypiy1hysiratTvCWm6vUTCuPzCxYQG6Fxd+hiYAaZxTf
 10aHeuPAJyFJrwqjOLVTOh+uXYVA9Xka5uOBboT312UEjfa45Lop/Qwh4VNxv2B/6g
 i2nmJnQkX3guMBfi/dvMWsPpiQ5ac8ORB3lf4OcGGOq5VrY5LwkXdoKOCI1ejRerNK
 7q1dhRLxF4MvQmBBB/rBRDvcWjMagYnHI5DewDrgLechb1Axm60uYJ0KEM1BN5pY1Y
 nlhcbGe+TuqG/3l1hQN5ZLl3/fTnwJImeh7zL9ru3SGV6tVAxddg94N7Qd88KxndEs
 GgfY895mRO6iQ==
Date: Wed, 9 Jul 2025 12:26:50 -0700
To: fsverity@lists.linux.dev
Message-ID: <20250709192650.GB28537@sol>
References: <20250630172224.46909-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250630172224.46909-1-ebiggers@kernel.org>
X-Headers-End: 1uZaSC-0005Mu-5E
Subject: Re: [f2fs-dev] [PATCH 0/2] Convert fs/verity/ to use SHA-2 library
 API
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 30, 2025 at 10:22:22AM -0700, Eric Biggers wrote:
> This series, including all its prerequisites, is also available at:
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git fsverity-libcrypto-v1
> 
> This series makes fs/verity/ use the SHA-2 library API instead of the
> old-school crypto API.  This is simpler and more efficient.
> 
> This depends on my SHA-2 library improvements for 6.17 (many patches),
> so this patchset might need to wait until 6.18.  But I'm also thinking
> about just basing the fsverity tree on libcrypto-next for 6.17.
> 
> Eric Biggers (2):
>   lib/crypto: hash_info: Move hash_info.c into lib/crypto/
>   fsverity: Switch from crypto_shash to SHA-2 library

FYI, I've applied this series to
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next
so that it gets linux-next coverage.

As mentioned, it depends on the SHA-256 and SHA-512 improvements in
lib/crypto/.  But Linus has also expressed a preference to not put too
much in one pull request.

My current plan is to do 3 pull requests:

    1. "Crypto library updates" - most patches, mainly SHA-256 and
       SHA-512 library improvements

    2. "Crypto library tests" - based on (1) but adds:
        lib/crypto: tests: Add hash-test-template.h and gen-hash-testvecs.py
        lib/crypto: tests: Add KUnit tests for SHA-224 and SHA-256
        lib/crypto: tests: Add KUnit tests for SHA-384 and SHA-512
        lib/crypto: tests: Add KUnit tests for Poly1305

    3. "Crypto library conversions" - based on (1) but adds:
        apparmor: use SHA-256 library API instead of crypto_shash API
        fsverity: Explicitly include <linux/export.h>
        fsverity: Switch from crypto_shash to SHA-2 library

I'll put all of these in libcrypto-next for linux-next coverage, but (3)
will have a slightly different base commit in the final version.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
