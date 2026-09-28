Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733E1C9833E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FCjTKA5xti3fV80varkKPdsJlxHmIFYJk4DpiMkidWw=; b=FICzbcsEIsShU81QXLvhPqSrIb
	kG2HUK6lahZH2D4ykvZ0XV/z7yTpoHB6p6FAWeK6NKyx/4zf41bYdYdn+2lioHschKwiU6jzIp2Lc
	K3i3i6KI0T33UZfZ68BeD4kUMSQD1s3qqnyLFBVFQ0J7gPaUYdDQkNfy7JJq5+vwx7iU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xB3Ch-0000IO-RI;
	Mon, 28 Sep 2026 04:43:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <senozhatsky@chromium.org>) id 1xB3Cg-0000II-LN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 04:43:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j3LIx4OT6RdJGRg4qDatJ4q0rZ8i4sT2AGqSbaU6cDI=; b=RMdpuvtnqurvZedMeui9FjyhrX
 bou64FP/QUe+HGvGta1OI+s8BR7tJwtQ2f3jDwyR3p5xx9xo19K6nm0DkZCgUavRlcJRX2DaxKTzS
 fEgzkFst3Z3xYONGAulino7oMXfm0k8O/eCe2/rvkQ7xIotPhoEnJp4XmWXXk4rU+J30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j3LIx4OT6RdJGRg4qDatJ4q0rZ8i4sT2AGqSbaU6cDI=; b=hgeSg/JcPhWvFnk7Yoc7fCkCyG
 oDkQvSsy34FPmO3maSMVyGZg9KRR43B9OU5P/SoSBJqwf8sCnsFONQM2vVu7nhhN+jIb8O++ilOBP
 iSFmwN98+TVYpfMjhr46STihZpLUDgZz7+6fuyFMb8O3BM8O0vPWnnYtNNf7zcN0v3W0=;
Received: from mail-oo2-f37.google.com ([74.125.231.165])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB3Cd-0005k5-OB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 04:43:00 +0000
Received: by mail-oo2-f37.google.com with SMTP id
 46e09a7af769-80032c08611so2146001a34.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 21:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790570574; x=1791175374;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j3LIx4OT6RdJGRg4qDatJ4q0rZ8i4sT2AGqSbaU6cDI=;
 b=Czm5Pl/6D696+7ZyS6jcQaXy4fUt46S78M1hQ2Y822RfZ1bIDLG2EMDT1oFA1/+sRg
 m9kLEM74AsQmtgzwYMwGI2ucduec4Z2TN3AyIFIhyMXIhmJLMlh0BDGmgpaZkm+ZD2ZG
 0Y7xQSm/FLRhpXsOO2PUU3VEuUTDYzM9wFGUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790570574; x=1791175374;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j3LIx4OT6RdJGRg4qDatJ4q0rZ8i4sT2AGqSbaU6cDI=;
 b=aGgsGG5hvsUHDNn8ddnvWMA3PJ3YAeP9kyfvezSOxzdbw1MT7u/ShxrmcvVUx6h2Sb
 ed/Y76XYvZqBd+nq95f12JyMt2A07hoyyR5kxFZAZw2op5T3Udcwa6Hg/XR4skwcragq
 jLvnE8+rp+PFim5Pr8fz5uzrGNAnvvOxOVov2zJ6FNM0V2csNGeI6dEZFHIGl3WnmdK5
 498x1qvqVzPmHbcuyr503OQhDKv/y2ewJYNOK8U/7CsXdkJ9LXrIkZUzhunFZT+6bh4s
 JmkMlxdIiLcjEH0wR08/Tl/6rH3FmfHLsHbMaH2AV1f0U3e50ESqU+GUBICk1JtusWas
 lR8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxKdnXwo71V3xDE2TwN2M+vhRdUlLUHXh97BiS9Vz4tKU2Kapk72gWqkDxYHU4xWZed3gFI2KH8XloyF0ztzDb@lists.sourceforge.net
X-Gm-Message-State: AFuF++nACY/aI/O/GbEju7t0Sj+b043y6nmy2mUMy3ByzaFfMb+jffHl
 1pyTWWywMtOg6XPA4R5+Su3KdKmxHxfhW3x21AwY9x4/ixGApHXKnywhkJWiy+au9WatUds0R3q
 tFmM=
X-Gm-Gg: AYBFou1SlUlqcy9Jf400sdSwrSvKmB1hyGqklNXCKeGnGAwqOK6ftXoQQ29F+oVymKs
 FsKlYnKpL0OW7j8t2CjBfDRMSt+rlXTp9NpOTwqpKxkCfPjJB/THUDKrfZOkAYKOu2K7B+y4ZtE
 QNka25KAhLfZzBvhmxliam5wDSZ1VAvkwyWFHvF/oxEtw7wbFSnCluskC8LXPYljKZ/9D9HWWi+
 GdILR3yIOOnCYufzhCb+8r0fNgrRHhjLay2slz8IwA6x5R7P1E7c+3QguNGsvJFM8h6arcVtass
 W100pd67m/mjawFIMsD2ojKTIZc1Wqo0qk6/gONEPp++zLahAijh7JXJ9wCvwKzbRtMrRJ76jFe
 E5jr5Q/dfJM21bpjWGwwwgUPakozzIb6KYaFa/WwebX/p8yJZgSCBiXxxMygMEx/PljFA3Ed04R
 HGV5pzMvByia6FJW58rNxSa3bBftdYChFLuccg5Bu8jyo6xkKf7GJ1sqQDN0uyJx2ttMOpWuhYt
 NSYauhXkE+hrlgaFyIky0NtVUcDOPd9wJUh+N0=
X-Received: by 2002:a17:902:d98d:b0:2dd:c100:7cc3 with SMTP id
 d9443c01a7336-2df7dd72aa3mr103163935ad.63.1790569024011; 
 Sun, 27 Sep 2026 21:17:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df913e23ecsm35034075ad.18.2026.09.27.21.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 21:17:03 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:16:54 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <arnpj53cgDErAQEz@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113504eucas1p25e50de59c02681fc1385220be8acd184@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-7-1c7ffbe21c4b@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-7-1c7ffbe21c4b@samsung.com>
X-Headers-End: 1xB3Cd-0005k5-OB
Subject: Re: [f2fs-dev] [PATCH RFC 7/9] lib/lz4: switch the decompressor to
 the vendored sources
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
> -static FORCE_INLINE int LZ4_decompress_generic(
[..]
> -			/* Necessarily EOF when !partialDecoding.
> -			 * When partialDecoding, it is EOF if we've either
> -			 * filled the output buffer or
> -			 * can't proceed with reading an offset for following match.
> -			 */
> -			if (!partialDecoding || (cpy == oend) || (ip >= (iend - 2)))
> -				break;

Worth noting, these lines are downstream commit eafc0a02391b
(lz4: fix LZ4_decompress_safe_partial read out of bound).

Is this intended or are we "loosing" some of the downstream fixes?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
