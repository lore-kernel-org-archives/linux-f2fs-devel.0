Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214BDC9832E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QmPyUwL2zz5HUvttDkcb/DCMUW2mVxg+zOJgZbZvVSo=; b=LwakigCusm9KIp2uzsLAYuRbO0
	b0owJaNk/n8xnNwgoxALpK4DxIgDzyfk5AHog7e7BvTHItflMQbJvamXUqvCBeIgmUhbmVEan/PaG
	St7vCE5VMr+ahYQot18xQQFE8rhNgZmV2AT6DRufFQnRsyNuoDcQz4jMxIWForECpmj8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xADdo-0008Ve-Px;
	Fri, 25 Sep 2026 21:39:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1xADdn-0008VV-HD
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:39:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qGAVtFU1ZWDmCtLaT+G7B5o5ljsTh3nqCzq4ca6rlME=; b=LDwtoV/yEC9nccmsAKnUZWD+Up
 OpMa2/GbjjO3vgj793j3IAiN38QmNX5yNgVGaYxxbYjc7UfR/dV9Lsuqqyw/fuOcuUva5B4YIAqWf
 9/Q83CozgFPqPtCo+TK2Y+2trnBLzGnivOqpSTHB1mWlx3NlWvyQg8SXkAjmRPP8jqz0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qGAVtFU1ZWDmCtLaT+G7B5o5ljsTh3nqCzq4ca6rlME=; b=SiFHsj5ipR/PJXLXcZJYPmf9tW
 RuSWDNbDQh+rm4YiG0dP3fxuakpxFGQT63H5eYIafUPuu+GbldA7gUHglYpXq/53wqyAzJF3cQNrt
 tKkzErDWXAcWSaMP3JwW8bqx7JQLwaE8rQhxG4HQwB7s+5GlofpGBKi8msFbnRbrIRxo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xADdm-0000Vw-Rg for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:39:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE20960136;
 Fri, 25 Sep 2026 21:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CA41F000FF;
 Fri, 25 Sep 2026 21:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790372368;
 bh=qGAVtFU1ZWDmCtLaT+G7B5o5ljsTh3nqCzq4ca6rlME=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Uq3jK6lzFPBk2mUB+21kzIEJ3e7xo6lES0MeUECU8KDNeBmretRa77Q3OlwhtoQmE
 JG8Dx0lTEjtjm2k8juBgSTzHaF2rroNVk1zww7OONmnk0v+x0FA56wC0MjZCrNSV/e
 H2pVr0Zo24UJv/vG9L8beZRRHMlmE7YAN/RF7/BIf3sCxDQZGCKJr+E+v3UjzyyNbI
 MirHao5U2KikMGzvv4h38MAzkcRcWP7PU8EZ2aiQo71N4cAbsRUfMEcbTXCJ/xYXPz
 HyiCZr2awcrNsxXI7Kdq8YVAeSXWzjieQzGLgVnG89GGjnkOohpJbH4QMHQxQzDjRf
 Ccal7IQ4ASL7g==
Date: Fri, 25 Sep 2026 14:39:26 -0700
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <20260925213926.GA1903@quark>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113507eucas1p2ddb94f2077b679426aa86dd1d492eaf3@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-9-1c7ffbe21c4b@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-9-1c7ffbe21c4b@samsung.com>
X-Headers-End: 1xADdm-0000Vw-Rg
Subject: Re: [f2fs-dev] [PATCH RFC 9/9] MAINTAINERS: add an entry for the
 LZ4 compression library
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

On Fri, Sep 25, 2026 at 01:27:39PM +0200, Michal Wilczynski wrote:
> lib/lz4/ has never had one: get_maintainer.pl returns only the LKML
> fallback for every file in it, including include/linux/lz4.h, which eight
> subsystems build against.
> 
> This matters more now than it did. With the previous patches lib/lz4 is
> vendored upstream sources, and someone has to bump them to new upstream
> releases and decide what the kernel-side glue may do. I am willing to do
> that, so add myself as its maintainer.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc3cae2e378b34aeb705cef654c720ca9f2ba223..989e1b5fab21432dd7042d1e60c4bbad85beb925 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15606,6 +15606,12 @@ S:	Supported
>  F:	drivers/net/pcs/pcs-lynx.c
>  F:	include/linux/pcs-lynx.h
>  
> +LZ4 COMPRESSION LIBRARY
> +M:	Michal Wilczynski <m.wilczynski@samsung.com>
> +S:	Maintained
> +F:	include/linux/lz4.h
> +F:	lib/lz4/
> +

Should this entry cover lib/decompress_unlz4.c and
include/linux/decompress/unlz4.h as well?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
