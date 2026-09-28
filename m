Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B228C98328
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2HFNlgWF/T2Tzegwdp3iarKufrwS84Z0pVvY+xvYsBU=; b=RtVZOEO8xllRXYVcNrtN1+tZ3Y
	p5jdv2wt4g3bt8Un/JuJRGo6tOWn7ceOcsVSpTueRFPbfKtECH8thhSfV1F5GztAF6nM57s5SBiYq
	QNwtwsrp5FlwWb/cTPgZvyckDfjsmJGJfbbjbE6/+kdlf+MoBdbEaRi16f5yMnyVR8pw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xB4E4-0005wT-1O;
	Mon, 28 Sep 2026 05:48:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <senozhatsky@chromium.org>) id 1xB4E2-0005wM-Jw
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 05:48:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kWV/wHWLQfhp6L6mSocYwp2pbMQ9zmUarPxSrrFDYg8=; b=eXUdS61MBIra6xDv68bAda45F4
 9HO5725X2qMkJjs8NPaOg4Pg9ytACAcOLiOLYUpeipaGQq01yYVlr66RSHr08KXBcu2SCuW18xRV4
 N9qJGVMzvDDUKJbSd/4mruXOIc4p1wSWbs+SCOxF/CJt0pIdioy+CPfjm6B2t8dAw6QA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kWV/wHWLQfhp6L6mSocYwp2pbMQ9zmUarPxSrrFDYg8=; b=KGzVvTuFDPFeT95QC4Gfssdq1z
 MNDdc8FkGDA3aPiYetZVf2lFvJDiJQ/IRkrHYMz5rqdpGBCIBYx562huLUpMMfYNUP229sD8RcX3H
 6wDZLVDsGAtP0mkWAIUl9P5heNEaMbbWO+EvZbd1uFNJ89GpCxrk13NZU72wSSY6mugk=;
Received: from mail-pj2-f41.google.com ([74.125.227.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB4E3-000810-04 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 05:48:31 +0000
Received: by mail-pj2-f41.google.com with SMTP id
 98e67ed59e1d1-3a0bcdf41a3so1309323a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 22:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790574505; x=1791179305;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kWV/wHWLQfhp6L6mSocYwp2pbMQ9zmUarPxSrrFDYg8=;
 b=mhhR47DvWsrxAYVubZn6b5CjoSBJr+cA85Pfz+zEQERgk7tKxwHUT7/qy5ivw8497x
 hBTHkYbHGVFEDwkq5QtRVwIRb1CXwbiH/4s3NT46FwX+KLpGQo2W1M7h2D3VdxsawVRs
 dTd6aemk3V72ZznhT5AJFnzhik+IsZ8o61hN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790574505; x=1791179305;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kWV/wHWLQfhp6L6mSocYwp2pbMQ9zmUarPxSrrFDYg8=;
 b=tYA5vqSxlBah7JTAbZAMfx0l+r0a4+xawnQa1LHIaT46nulmOq4hsNiUtTR16ncpV6
 gNmQSI3Qz7mb8ExeJFbzQlWfOSnEkvZVvbpoEoHOYrv28gc5uoFrJHTBZrTXeSwnURde
 520ufWcnEHrWM1JQpsF6heZfWjdSCtfMeB7vdZWVywlFSoyyEokEN+R/IgtPBCjhAu73
 XHDNJzzLqKdrt1pdZ7sBrSsEIC8ywjYMgbaxdbCijpQRlZjfX+x0flROv5a1GftIrwUp
 MzB20y/VMe2kkuaBmkNgEYcF6YcBsVNuhqlNKHyEhvk4/tNwMTEaGORAFod/KVwzTDDk
 uFIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJATwwUx2/Pqyii1R7tlLDWJQb/Ey46q5l41mUc0Knip8MOJ/kKliHvVFlaOO+nF/3uNu4Xi+y7rVf0LegvzId@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLsXguu0Ivgnk3I2g/HuEGGldrKQeKobJqLlD6HM8UlEkn/ChBu
 PaF+a2eQlmTSkLVX8LF/1jLhkv8ojyUU1RFIuL5S3x73N9duTt30DIlYXzAqMLfsbQ==
X-Gm-Gg: AYBFou0pjHtFF5cIjRDJT9Dwo6eV59GkbZc5vcPaPRZvbqL2ruLUlPTyh91dtmFna6u
 CfQ0e44FujJtiP9x8o2m3bNcT/pmF/JRHPVQvXoP2i8txa9ICp0vLfBUFIIxjaSzvT+aYtGBs62
 J5q91lUr5tyqu1VeawHsZojQDnTwCjw0VYO5ejjsJGVqQM5iwLWyuVAU+zD/0YmgTwSeL654Ivs
 Sdc4++h3BUPgjcJso5uBHLgvwBb9eMd2MDmMo7NIJy8WpWV3WEyGCQq5vnB1ybM2bs4M8Bm6yZL
 Q+enqua0lW4RRvcHM11mKZwQZUjuGfA6qj+L42w9/M1Ez9xjZG3xQu2qqNuKldsT8Fi6cBgmrct
 MQfh7+7PS3DXPHDXgYmutLRzPzpG8lszucMEU73Vh+g03lOpCRo2eaiD/Ft5NGx6KIxRxV87E6I
 qzNp7yb+uoxocmq7Zg4o2R7GubcuKDOIwpArMlyXDwkGpIlKj8/8yOhk/+bOv27gJU71Kt1zOBc
 xG77/MmzczcNFILTWzwqL+d+67L21nG1pIZYyT5RYokD4OVng==
X-Received: by 2002:a17:90b:3888:b0:3a0:cc33:2287 with SMTP id
 98e67ed59e1d1-3a0cc3324ccmr6256726a91.6.1790574505299; 
 Sun, 27 Sep 2026 22:48:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0bec30aaasm17853889a91.15.2026.09.27.22.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:48:24 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:48:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <arn9tK5MxxxfH7OW@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>
X-Headers-End: 1xB4E3-000810-04
Subject: Re: [f2fs-dev] [PATCH RFC 3/9] lib/lz4: add the build environment
 for the vendored sources
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

On (26/09/25 13:27), Michal Wilczynski wrote:
[..]
> +
> +/* LZ4_decompress_fast() and LZ4_resetStream() are still kernel API. */
> +#define LZ4_DISABLE_DEPRECATE_WARNINGS 1

Is this upstream code?  As far as I understand it, LZ4_decompress_fast*()
deprecated upstream and are strongly discouraged.  Do we want to suppress
deprecation warnings?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
