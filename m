Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3B606B349
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WCY7KCms;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XOjyUsAv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WgAgQqSc;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2HTk8rO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ORN0UZzcKVHTZUWtlBwyeIaHE40vtnTE4fQWz24Gx60=; b=WCY7KCmsq7KosewRPNZqOdVdRY
	V2/rdPuz89Av5GO6PFp+mUYhtYkDJ3xaAdUZc7fhd8advZCSdedowd4ZhkyfQCWG6IT8ZlrR/cAnX
	bRWlAG+oRTj34HcoNLnMBZEc4p9dfDP2ERIchpMfE8neFczo0qd7DSQjm+SRuU5BOP6s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRGPV-000000003UG-0dwT;
	Wed, 11 Nov 2026 22:03:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <xiang@kernel.org>) id 1xRGPT-000000003U9-2UZz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 22:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/29Fh1u2FOm5/5k1pmwlztbcmx561O6eu158ApMSsyU=; b=XOjyUsAvH+OhlC9ZmoCd6U+Rk2
 tffqetB7dBecgCKhkLzrfLIlRwJHJ5EgBEs46KYsYRt4/7PWW9l74A9TzO18Y93FcZep5yiTIZG39
 vRBUcKA7PVUd+3FzU8bcNrQlXxfgJYNc9HEGQ3VIOu05aMbdPbgFCr8G2oh1WsQBvqq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/29Fh1u2FOm5/5k1pmwlztbcmx561O6eu158ApMSsyU=; b=WgAgQqScPVz9mg4iLYawTBlHj0
 rLxb7IDkI5Vc+9R5iTCFD7/MmDj3DRiiU8cCqQ5ggc7qWLF3gmSlmrEFZgTSS1KbQnpCazY7fURkC
 ckeF3Q6ZQCLgwagwIUcAmvpGMtHTfSqHmHK5YqICsLUCpXzGAZMYg/9r8+4dqrojJtqk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRGPQ-000000004d5-39eq
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 22:03:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2040261D2C;
 Wed, 11 Nov 2026 22:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E751F00A05;
 Wed, 11 Nov 2026 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794434586;
 bh=/29Fh1u2FOm5/5k1pmwlztbcmx561O6eu158ApMSsyU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=H2HTk8rOLZgWw9Lm2uB8it44XJGQ1VP252zKM3Vsl27YeQT3fQC/oPf+9dR1GGuPe
 fTrdVHJg83sazuCLRwsK7FMBmZ65BjYmx/5l1Fr9V4zrWbVX2E4c/EGrAZHOJ23iP5
 K6oVJy3Ue6XdepxFi87RWoq3TdzVK9qDLL8BM8XMCz9n7H3pjJ8s2COHz+NjnFIDwg
 2eGJ+4dbOKk2dBpxqBDuRpXAU1slNtJxbA2Dkar3W/730CiqV+uxXwdTMmafxIRXoH
 hanK6KHxVmWrohkzaChiP47GtgTq+nQUar+jL+4xWJclsB1e8afff/e4uoWiQs4JB9
 jrQrJYXOzTbWA==
Date: Wed, 11 Nov 2026 23:02:51 +0100
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <avTmC_1I59FKA1FN@MacBookPro.fritz.box>
Mail-Followup-To: Michal Wilczynski <m.wilczynski@samsung.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-block@vger.kernel.org, Yann Collet <yann.collet.73@gmail.com>,
 Nick Terrell <terrelln@meta.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 David Laight <david.laight.linux@gmail.com>,
 Sungguk <sungguk.na@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-erofs@lists.ozlabs.org,
 linux-f2fs-devel@lists.sourceforge.net,
 linux-crypto@vger.kernel.org
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144309eucas1p2a9bfcc1cf81779d473fb073e7d9139b7@eucas1p2.samsung.com>
 <20261106-lz4-vendor-upstream-v2-12-ee04c3f0d7dc@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261106-lz4-vendor-upstream-v2-12-ee04c3f0d7dc@samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRGPQ-000000004d5-39eq
Subject: Re: [f2fs-dev] [PATCH v2 12/15] lib/lz4: widen
 LZ4_DECOMPRESS_INPLACE_MARGIN for the fast decode loop
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Gao Xiang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Sungguk <sungguk.na@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Minchan Kim <minchan@kernel.org>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Eric Biggers <ebiggers@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Yann Collet <yann.collet.73@gmail.com>,
 Gao Xiang <xiang@kernel.org>,
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
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org,
 David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michal,

On Fri, Nov 06, 2026 at 03:42:52PM +0100, Michal Wilczynski wrote:
> erofs decompresses a pcluster in place when the slack after the output
> is at least LZ4_DECOMPRESS_INPLACE_MARGIN(compressed size), upstream's
> (compressedSize >> 8) + 32.
> 
> That holds for the fork, which overshoots its output by at most 8
> bytes. Upstream's LZ4_FAST_DEC_LOOP, which the next patch brings in for
> x86 and arm64, copies in 32-byte steps and can overwrite input it has
> not read yet: of 172410 valid streams laid out as erofs does at exactly
> that margin, 3660 fail to decode, none with the fork. The worst needs
> (compressedSize >> 8) + 33. Images mkfs.erofs built did not hit this,
> but nothing in the format rules it out.
> 
> Use (compressedSize >> 8) + (compressedSize >> 15) + 36, which takes a
> 4K pcluster's margin from 48 to 52 bytes. Upstream's lz4.h defines the
> macro too, so undefine it first.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

First, I really think kernel LZ4 should be updated for many years, so
thanks for this!

But my personal thought is that could you just fold this patch into
the next one ("lib/lz4: switch the decompressor to the vendored sources")?
Because this one should be part of the fast loop update.

Although the current patch order is also fine, but my potential concern
is that people don't know the details maybe pick the random ones for
backporting, which is what I'd like to avoid so I hope this patch could
be just part of it, otherwise the inplace decompression could be broken.

Thanks,
Gao Xiang


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
