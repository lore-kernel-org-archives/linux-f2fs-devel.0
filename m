Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24A606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=COk5A0ar;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E7RCC+N9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XpxOeooI;
	dkim=neutral header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NpgJ2bFK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=g4TY7Ryc/DnRq5fTKIa716vSXEHS5YZqJMB0Fw1TASw=; b=COk5A0arIJ9CzeaYpixAr4lcY2
	QCgKVL0KgiHZED2ITdYhbSJg9vlyToJarSCDhIFLLA1P1WmRkw5lspGo2ykZKBFsA7Yq4AMsVCO5s
	gV1xup0kp+HNgMWKcMQB0riYrLh2IjbHHBTQGawzN5BzhIuaMOpLW1oMpMXJvpcKkKzk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQexc-000000000AW-1Eqn;
	Tue, 10 Nov 2026 06:04:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <senozhatsky@chromium.org>) id 1xQexb-000000000AI-0jUM
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 06:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=; b=E7RCC+N91M7obSpvrt5gQDhFye
 EZZ3R5uYbMPWjVKNhOqRD1nKh5pYYFumcTT7Mbc5mLhKDkAXa6S0H0xmVaot64H8rJ62h8vcrzrT9
 2BfDf5oWGwh8A7t8go2PabSbIe4h8BA0tAJLcxKxQL2QOKa3thpGGUy5S5rsoVubadsU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=; b=XpxOeooI133kxDVSqORgHi4I5W
 9wmA8ba3cFuXG5DIeeOzsBx5I7WFlgmrthTVQlR7glR3e/cR3MhTnyrABuzSxPgjSugAOtbSBvYWE
 kRnNZJ0wuqrBL3cyC0sUguuY9GCSNxlzZdr6U2HdD3IBc8c3vGKsSqbdIj7gls02LQcg=;
Received: from mail-qt1-f172.google.com ([209.85.160.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQexa-000000003HL-25zc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 06:03:59 +0000
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-5495d549924so17268751cf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 22:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794290632; x=1794895432;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=;
 b=NpgJ2bFKmAq/AEnOWuoaj9Hpdz5Q/q5q/qSI9J+icO/tNkCLTm6CEKHz8rBROCgBLX
 /mBzll59EBEdb/nToJvbzY5aGCNaPOS2VRnFkH5uWLiTNN88D7OxEbAswP9//5j8jpBe
 4lGWNutAq725oTQV5Gu7OBKqUixOy71uaFU5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794290632; x=1794895432;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=;
 b=GauxoYLZ833naU8vnp1pxYhzLfQtptbDm/bEaXLw8y+xpb/ajX0oLJhb0yHKSdCyuO
 tlQv9KXtqn89nSuerBxBBL+WuOuAB7e2mTyM3hCy/omD3mLyafULE22SJjl/+QRIy1W9
 0/Q4wSHFGELhWUrIHKv+5rg0WS4ONGbG4dl01kpKhZx2hnzXdyAF03P21JO7Y+1AyJK/
 U7jAfUZOf+x1MR/1rqdIds6+77GC35EiqSJsaCZuQJsNdBCjgDQxpmQiomPCgKE+RUkx
 mfhr+0Tl4wgJuB7FSt1Bvl/hL7LUgniDujKxnUgtqlEO8OdyhSkIBxrUzsRhhTKSQ81K
 KupQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHC2Fh1+SugynXJBr4JOxpG69ZbTUnTncPdU4Ez1Mo/znAtgt6p5O7O1cRRFJUpYFHxFdZYIMGre1LzzC/nmIm8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8nlfQ+geCI4nKa7QXVy8c+rtjPyOHXha57Tpy3DxSwM4SP6kyP
 U1EU78G3khUtxnpdpnSvAiXz9WHVYxNG24EtRgIPqNGB/kjMT2P2AUq7nwrBLt9KOjn7sDx2s3B
 ZpVs=
X-Gm-Gg: AYBFou00hpssExfL7BCd8KaWSGJRL5ckH1FDbnL0zNO20Rm3AOyVM1RynO37kAn76iC
 e83QKkfRHB5ilhalonw+qrSBC2+AyESOhDk2mSnfGU065EAcJyL2wgcUaF+ejbimBx1MMtKEssn
 knPnhDqm+okihr298CcGaeXsKBP233IiRlE3VXCMwgXuS+g8HMtjG3jacr+uqBbeJERfNk69X8L
 spneoUQuglhQV6mAmFTdwqx/ev5ZPjcJUP3goAlHHmu8Mwsuf8Xn90xk31g8stqssk4WuEHaAYD
 ZFadQyDbP+3RaHVIQBWHGvABxLh1pukfGdys2DlbbCxNp4HobIGOzj5/2k9IBvLkSSC32yjypVy
 7I75UENA1tzTwUzp1fkL7sGEKD2qWs1P+1tAINbZ8cria8GDyGDk8Hv6QPAqGKqw83vgu7qyyAe
 C8xrHw9h+HYnOln7Q5o6IHs8jDNKIpFCq/2kmNJIMQ0VTDH8p1kfPJIV5mB1XbyFfPjgrO/k5KL
 h2cpjOIpGWkNSiV9skZX7hZrt2e7Uk0eqtYgKEA3ugOFgemUdMrkOrdJfPb9vtEdOtH52jcPmQT
 eHh3pcjYJjNFBtlJWksPTuES0hIYnG3mbPk113hSTTKnCs66P8RL5MZCWRratMrLjKw0xQ==
X-Received: by 2002:a17:90b:380f:b0:3ac:9599:a689 with SMTP id
 98e67ed59e1d1-3b166d02addmr1882552a91.34.1794289194303; 
 Mon, 09 Nov 2026 21:39:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b168ff86e7sm1041404a91.2.2026.11.09.21.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 21:39:53 -0800 (PST)
Date: Tue, 10 Nov 2026 14:39:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <avKtyCOOmK3AH0xy@google.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144310eucas1p1d60fe5c2e0170c49f38a3142bb1d8f94@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-13-ee04c3f0d7dc@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261106-lz4-vendor-upstream-v2-13-ee04c3f0d7dc@samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQexa-000000003HL-25zc
Subject: Re: [f2fs-dev] [PATCH v2 13/15] lib/lz4: switch the decompressor to
 the vendored sources
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On (26/11/06 15:42), Michal Wilczynski wrote:
[..]
> diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
> index 50265e3ce256490994cb6dae32a45da376e408e0..b9b8a5f678c155442fa3fd2c1984e45182e6fc38 100644
> --- a/drivers/block/zram/backend_lz4.c
> +++ b/drivers/block/zram/backend_lz4.c
> @@ -84,7 +84,7 @@ static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>  		if (!zctx->mem)
>  			goto error;
>  	} else {
> -		zctx->dstrm = kzalloc_obj(*zctx->dstrm);
> +		zctx->dstrm = kzalloc(LZ4_MEM_DECOMPRESS, GFP_KERNEL);
>  		if (!zctx->dstrm)
>  			goto error;
>  
> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
> index e7ee3740219852f079d1e0866da6b213a3f3a583..1e09c93016264259c149e2913b2819571b56fab6 100644
> --- a/drivers/block/zram/backend_lz4hc.c
> +++ b/drivers/block/zram/backend_lz4hc.c
> @@ -65,7 +65,7 @@ static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>  		if (!zctx->mem)
>  			goto error;
>  	} else {
> -		zctx->dstrm = kzalloc_obj(*zctx->dstrm);
> +		zctx->dstrm = kzalloc(LZ4_MEM_DECOMPRESS, GFP_KERNEL);
>  		if (!zctx->dstrm)
>  			goto error;

Ditto, outdated zram code.

My ask would be to not squash zram changes with lz4 changes, when (iff)
possible.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
