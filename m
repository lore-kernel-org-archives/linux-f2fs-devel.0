Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F1606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ixmh/f3E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bHWwmKl5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AOmPXIAg;
	dkim=neutral header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WFOj+JS+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=3l1vzRGggImu0EpYqEaKP6AZVtgU5IUAbmlzpFDNbY0=; b=Ixmh/f3EiYyH5mgf7hvtAbYvDG
	JBxy+ezo98h6u2mfbuqbRdAxf6vROWumSY78McAZU6bBnxV5cKhZvpELnHOQEqk25aMmcWV8psJGZ
	o1GoFrUtfHxwWSqpN5rc+OMYoiUUYH0OgaChp+KNqIZJoMhEDfS0ybX68/OZM0GOM/rY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQetW-000000000LM-3VzN;
	Tue, 10 Nov 2026 05:59:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <senozhatsky@chromium.org>) id 1xQetM-000000000L7-11sy
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 05:59:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=upBQHvhIXS9jA4rn/T2U6OyiZNi8Uwc76Ij6dQGz7TA=; b=bHWwmKl5Tkn1y6mkar8hWf2bVf
 lf16Xj6rbsgh42Fhv/y8FEIUUOqQtBn3gfa2Jzf/S/yoOFgKfj6WcvonmMZDYVf6LJPVMQ3ThRr/g
 BIYbVASJVUm8IedIp6iwrYN+12l78XS2KsaF7Q9GBeIBHEUBv1TFep4qff9HAdTcStr0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=upBQHvhIXS9jA4rn/T2U6OyiZNi8Uwc76Ij6dQGz7TA=; b=AOmPXIAg4gjVoEuQVOlk3+lGhn
 pmgfOgBC9+y/1uuwfdrLlSFvACiL9ka660UT60ZxvomqgmlNtmurT7XjLUNnn8amHgocgGyyTmO+Q
 YrNPUAKx7EmSHKC11+OMHUXwmnpAEK5q7CT0YXhpoqd+yrmOqXocx2Yc6BaJ+0nHEQOA=;
Received: from mail-qt1-f182.google.com ([209.85.160.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQetL-0000000035F-3LXV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 05:59:36 +0000
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-54f873cbe2aso16781721cf.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 21:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794290370; x=1794895170;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=upBQHvhIXS9jA4rn/T2U6OyiZNi8Uwc76Ij6dQGz7TA=;
 b=WFOj+JS+risv/Yu1v1yV+c6tXdlUQ8tmx+z8mHYVkCkyKJFCor6njVKEjjLqSjuq0K
 euk3FGVOHussgaVFBbQvCwTKIVEJuLPb9U1CK/e20Ar1Laqro9r2ZqHSD+iPfkyIFRV8
 hhFv0wRalUKo1dD5Uxv1r/z1BQnyqgKjYoTuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794290370; x=1794895170;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=upBQHvhIXS9jA4rn/T2U6OyiZNi8Uwc76Ij6dQGz7TA=;
 b=xZP7XYelL3xEkvp9N6dGEN/QgrpqKLhRs4tLc9ZGvwkpUk+m6CZkE4iksQlQ+B6iKz
 gRcJBhf4TbmzoUfZPQCYCSap5fWm003ugwNokYBlRkwaOPgxWV57GSIwvg10C6jjKGdx
 8bjn+ZrPz2N2tfd1eZg5G/BCZXy7v7dJMzEQISyT5f3KPXkdsSDZHz4Gy0mx3OO0FTSa
 vpZMmjYoLbf1NrnjtO6GnEcXyA9lLAk8qOtoN6AlMTP9+2owc/OoNxFRi9JlpMEjOlIa
 FdSjakabD230VydV7476HIVtwQ9aK32XGZTB8FsKI+YfVKXOdnpvG3QLeN++EtSKlgcO
 v64Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEA3jQRjj57dtdDV7Jcskkjmo8W14xYKAJC0LWbd8ZqaHT6WY4bCEKTuLEu17FlOdmy7MNnYhJT5ZgVpR38fGg2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9dw+PqeEwR4pVS2dnktIgM9BAEPqQugfnEuQ+nLqdHX8W5a8f7
 ZO+jmQROT5tbY/hDhzueM2KElrNg/yfBJhtuyPCHoFKGzdU2ItXC8jOqiSanzdP1xPHr+AvoM+z
 Yaak=
X-Gm-Gg: AYBFou1kJ1dOZjzh0Fd9y57dW4/u8Bjq6Z7cFQtf682zjdhJ2tedmzm87u9AmnT+719
 Nm5L0yzCMJvVKo2EjUTq1+Hz9INBB66lHwmgHmGqWk+jGJnDeJ8G6JwOeTU1e8lwJkCH3KK49l0
 dQIG1RqkYrR1xamTQk7zDLZF676/KJrzxFQh/mPwkAkG9880aUBVs7C9T9QSwUH6PrhNYeCIFQ+
 0lnWkPDEgTbFujtwZd2YIwOwogZ13Klw6BobrSbQ6c6FVSAKddZFXmHUyNd9J7Z35nnz17CExcx
 2G31jm5dW7Poc2UlQdCk0H6dF24dneQNawjryOTBq7IVZujbfNXmZlIBaeeYAJHrnNRgSGD+ud0
 spRyFbxyFxvx19V3HRG7xpcNCB1GvzoQJRC6h04P7zZYcm9+2Pv9/K37gXVwWz6gtKNb6rYGaAN
 FnuMGrvnDCHA5pxUQmKmFngOx/8ik7FF1gAq9e2sUxRNdW/7tLrh3xnuDwQDukwKqjxtaT2Hph3
 /E6qwEp87zhhO+uAZlKK4Krx0X6urp5tyUkSfcJTZCoTIpjjuNaZWU1/b3eyi2XNtzCeUkTqC9T
 GpIluPT8+ssGYfIx5tqO6eFZMGLjv2g4Ft7hOaRs5UOs8BI/JVjk8nQ60e0ee63QK8G7gg==
X-Received: by 2002:a05:6a00:1492:b0:89f:5c84:46ec with SMTP id
 d2e1a72fcca58-8ba89661da0mr1558178b3a.40.1794289019108; 
 Mon, 09 Nov 2026 21:36:59 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab8dccc7sm405355b3a.52.2026.11.09.21.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 21:36:58 -0800 (PST)
Date: Tue, 10 Nov 2026 14:36:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <avKs4_S7r6EiUVgC@google.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144305eucas1p17b3b27d403dc7d13b85cdd9a4bea83b9@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-10-ee04c3f0d7dc@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261106-lz4-vendor-upstream-v2-10-ee04c3f0d7dc@samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQetL-0000000035F-3LXV
Subject: Re: [f2fs-dev] [PATCH v2 10/15] lib/lz4: switch the compressor to
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
> index 1e4ad31d39a63f45b3bddd3d8a467d8d7d095beb..50265e3ce256490994cb6dae32a45da376e408e0 100644
> --- a/drivers/block/zram/backend_lz4.c
> +++ b/drivers/block/zram/backend_lz4.c
> @@ -42,7 +42,7 @@ static int lz4_setup_params(struct zcomp_params *params)
>  	if (!params->dict || !params->dict_sz)
>  		return 0;
>  
> -	dict_stream = kzalloc_obj(*dict_stream);
> +	dict_stream = kzalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);
>  	if (!dict_stream)
>  		return -ENOMEM;
>  
> @@ -88,7 +88,7 @@ static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>  		if (!zctx->dstrm)
>  			goto error;
>  
> -		zctx->cstrm = kzalloc_obj(*zctx->cstrm);
> +		zctx->cstrm = kzalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);
>  		if (!zctx->cstrm)
>  			goto error;
>  	}
> @@ -112,7 +112,7 @@ static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
>  					zctx->mem);
>  	} else {
>  		/* Cstrm needs to be reset */
> -		memcpy(zctx->cstrm, params->drv_data, sizeof(*zctx->cstrm));
> +		memcpy(zctx->cstrm, params->drv_data, LZ4_MEM_COMPRESS);
>  		ret = LZ4_compress_fast_continue(zctx->cstrm, req->src,
>  						 req->dst, req->src_len,
>  						 req->dst_len, params->level);

The zram code here is outdated, it has been reworked quite a bit
(patches are in linux-next and Andrew's trees).


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
