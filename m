Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56BCC9830E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2026 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nBr+TI2qaM82OnqVnJbFCjDNXL1Id+P6pQJZLip+rX8=; b=V1lbi8fuje02uRlkf6QLhuDx5T
	/klUFWhtqrD5tsrALof3WcespPTrOGDPF3n9wT8m0rkWD1SwTO0wGBMWxnAQPgANFbZ/aEogHouMz
	WOIHTJpDBCeVPau2yapB4dq0yR33U2wTUO7vtIseD9jcg2ls7+5Rz3OSKMEvbno6Moek=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xAE5V-0007k6-Sr;
	Fri, 25 Sep 2026 22:08:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1xAE58-0007jT-3c
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 22:07:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k8g2DRYbUFc/WlQ2pAkletlhQtrwe1F0NZCL2F3+zUE=; b=NlFmIlub9J1py1D09Ej8LtcqYB
 /iDchGTggIkrrEEwWo7RReFH6v68wCervu2aDOWXSgZi22HSGMCpAd3o/BgsR763BxyA0ogyDCkId
 q+SGWclRzMqRq3qLyPQwVTdvRtx12kugX+ecXik5SDAlbaGGpj1SwS1gCVYlI6vI/2ZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k8g2DRYbUFc/WlQ2pAkletlhQtrwe1F0NZCL2F3+zUE=; b=lbDhTcqC58AoPLgbamL9w5qNCn
 qy0LQvA3qeJpjrybXqUF3B8F2GouxhLciW2yQQSIe61ArMmBCJHcyPHOQaoT9h+LECLwDUbEhHUi9
 i6OWyILn+6uNBX6/FO6SDVNujzQytg5Ft5sFHHE/q6L3BMOVurIBz7DQykhJOjHhzr74=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xAE54-000164-6t for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 22:07:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 871CB60136;
 Fri, 25 Sep 2026 22:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F871F000FF;
 Fri, 25 Sep 2026 22:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790374060;
 bh=k8g2DRYbUFc/WlQ2pAkletlhQtrwe1F0NZCL2F3+zUE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Blm+98gnNSmmT+B1FkGka5xELWe0Sas5kxh6t5tiDl8w5RPy2GIR156rg32qYAB8h
 0WC2HIz9I9oTU8BMJGRhVpVPYDGzzRjyfJveq8tYuLsmMYq8PIg/rRdFm5JUc5XTUv
 91GhFUgvrNiWWbRRvN59hi3Fpb3qet+Bo+uXdpaPUiXnSpzo4uJ6julwsKMhb0hI0F
 fCnTm7iQaDrz5G7/S+Ybr+QBIQ138M/AuG4leepfCPOBvTzVcKAe7YoDWwTXpZPdWD
 sWKIAoZzsyb+GWb/CE2bNAPLaHe7PFEY5aiF2ExoAzy1jo3Uh5k6xUgU2dktwiDBax
 IMsJ0+SwguBcQ==
Date: Fri, 25 Sep 2026 15:07:37 -0700
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <20260925220737.GB1903@quark>
References: <CGME20260925113450eucas1p2fcf838f00f35e1bce0ca04a694cd0cd2@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
X-Headers-End: 1xAE54-000164-6t
Subject: Re: [f2fs-dev] [PATCH RFC 0/9] lib/lz4: stop forking upstream LZ4,
 vendor it instead
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Sungguk <sungguk.na@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Minchan Kim <minchan@kernel.org>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Yann Collet <yann.collet.73@gmail.com>, Gao Xiang <xiang@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, llvm@lists.linux.dev,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-crypto@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@meta.com>, Borislav Petkov <bp@alien8.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@kernel.org>, Justin Stitt <justinstitt@google.com>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 25, 2026 at 01:27:30PM +0200, Michal Wilczynski wrote:
> The in-kernel LZ4 is a fork. The decompressor was last synced with
> upstream v1.8.3 in 2018 and the compressor with v1.7.3 in 2017, both by
> hand. Upstream has made 488 commits against lib/ since, and the gap is
> maintained one cherry-pick at a time.
> 
> That has left real bugs in place for example the forked
> LZ4_decompress_fast() has no bounds checks, so corrupted input runs off
> the output buffer in both directions. 
> 
> This series vendors the upstream sources unmodified and adapts them at
> build time, so a re-sync becomes a directory copy:

At a high level, this looks good to me, and it's similar to what was
done with zstd.  I don't see any obvious issues with the integration.

There are disadvantages to directly integrating external projects like
this, vs. writing a small implementation from scratch for the kernel.
But the existing LZ4 code in the kernel isn't that, but rather a fork
from upstream anyway, and it's clearly not being maintained properly.

The upstream LZ4 codebase also already avoids many of the typical
incompatibilities with Linux kernel code that are often seen in
userspace projects (such as assuming FPU/SIMD/vector instructions can be
used at any time, or that the stack size is infinite, or that the C
standard library is available, or that it's reasonable to have hundreds
of files or 100MB of test data, etc.).

And writing properly optimized compression/decompression code is quite
difficult.  So yes, syncing with the latest LZ4 upstream seems like the
right choice for the kernel.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
