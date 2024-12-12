Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD844E7717F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Dec 2024 21:37:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tLqsX-0004G8-B8;
	Thu, 12 Dec 2024 21:37:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1tLqsV-0004G2-VM
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Dec 2024 21:37:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9hKZ9SY7EGr04EhqIPL6Drfty1RVOYgzWDHsZqBj3uw=; b=FmMpozI/5u8oUy2P1fcBJCr93e
 q4vbZA9hWLMUeje/+1oV67C0y/9qjCm/XhryKhMIAGamKS3FnNr1TkiLghWXOBKBdnzNaCfJuZ6ar
 k4BcoHxO59Xn3cLiyjbn+frZz/X5zn61845ZD9kP5v+tkAczZ7iKoLfnqTg/oQRqAAGI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9hKZ9SY7EGr04EhqIPL6Drfty1RVOYgzWDHsZqBj3uw=; b=gJcGmgfuxafkiGhW/DewKyzecy
 fALcXKr4fYbXAyHQCK4HcAgdjfejwoXyASEBOqbOTjRuhkwnzp3jFXZZoxSKIBEGj77RdqZIkDhvi
 U51tet9qTBXBRlmYztAjMqmwDy21pBtZR2AXYndYrS1k6UFBZY9dJmTZjyiAWO/BNoFQ=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tLqsV-0001Mn-7W for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Dec 2024 21:37:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4670AA42AAE;
 Thu, 12 Dec 2024 21:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE1CC4CECE;
 Thu, 12 Dec 2024 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734039456;
 bh=hF4mJhnVVXZXfZmgDwcher6bwGaSHVExWyvvXFEjp2w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=olHk7jG7/rj4jRsPenllCQhTf5QGq/o+IXUWAK82q6pCJzN6i0SdtI7XXvHvfiYLW
 o7Yb2dtL1CH8VNEjEG8A5mpzTFx8yH0hEIFW7L1nUsgKKc9ugXfj5gaT9OXUqTDi58
 6N9jkLSNkjhUTqlAcmvg1HLxdVRSD5WcssiicIJ2Nxmvr9M6pJD1wQCUfPhz2WNC+t
 2xdjNIS1+MX5kC7hdRX17/1bm7hIdvOxPxxX9hHKaS50L38XE0/FImLbSAiegVPTIq
 VSrgB1QqyjlJeR5aTe0UIkwwE/K4CIPz765ubY7ooteF3fveq0wORNZ7ubo5V6o5Xr
 rY71XaqihMshQ==
Date: Thu, 12 Dec 2024 13:37:34 -0800
To: linux-kernel@vger.kernel.org
Message-ID: <20241212213734.GB39696@sol.localdomain>
References: <20241202010844.144356-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241202010844.144356-1-ebiggers@kernel.org>
X-Headers-End: 1tLqsV-0001Mn-7W
Subject: Re: [f2fs-dev] [PATCH v4 00/19] Wire up CRC32 library functions to
 arch-optimized code
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-ext4@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Dec 01, 2024 at 05:08:25PM -0800, Eric Biggers wrote:
> This patchset applies to v6.13-rc1 and is also available in git via:
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc32-lib-v4
> 
> CRC32 is a family of common non-cryptographic integrity check algorithms
> that are fairly fast with a portable C implementation and become far
> faster still with the CRC32 or carryless multiplication instructions
> that most CPUs have.  9 architectures already have optimized code for at
> least some CRC32 variants; however, except for arm64 this optimized code
> was only accessible through the crypto API, not the library functions.
> 
> This patchset fixes that so that the CRC32 library functions use the
> optimized code.  This allows users to just use the library instead of
> the crypto API.  This is much simpler and also improves performance due
> to eliminating the crypto API overhead including an indirect call.  Some
> examples of updating users are included at the end of the patchset.

FYI, this patchset is now in linux-next via the crc-next branch in my repo.
Additional reviews and acks would always be appreciated, of course.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
