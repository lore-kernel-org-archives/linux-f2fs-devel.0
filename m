Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24100C9833E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WcVYKyQAy5uH+RS9C+muA76HUjCsrPN9+41782nG+kk=; b=hPrEpWFYRjmOGb27VmIfeyCspv
	bjyQIDon66lVl9CdmOsYNi8nDZIGgpeRaXMgDelcW6QylCjPnOprM47q7scPdCqCVfmgx1CTFdFJb
	UXiXGlJfBnCnkIpUhagYeWQE6aSN0RBtPs5R1J7VJlnIsIkwubTiIidWJBViNAu7HaOE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xB3ln-0006Y3-1T;
	Mon, 28 Sep 2026 05:19:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <senozhatsky@chromium.org>) id 1xB3ll-0006Xx-Jm
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 05:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aE4CNeMPjoyGqhac0qEjC0MrhT1ea2sjSdxYtuXCv0E=; b=QZrRo6SrMVlpN5wmxwklfs7T3j
 PUsd8mSktOt2sf1jbKBjnnV74YqO5WwReVV28MD84SYsX7pFhrjuZC8Z26bj1bcHRXCdDTNj4m6q5
 kMS++uZJWT+JA7cYUNttp7lgy9faDFPKeWM/p2xkT6Zz2/ow5FqPEIEh2UfFFNpRSd6E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aE4CNeMPjoyGqhac0qEjC0MrhT1ea2sjSdxYtuXCv0E=; b=FDTqMZogWjGGp9qDDBEO63dvvs
 dNf6izXeDPm1vJ9fo+kiDdrhdDg6z4V4+eenz5VpiNDJD2TmbAp4JjWz7LIT/lbV/dfhEPOhKidyg
 lKOEyp7TZuzOGMsf9OcUpA4QnG5IuOna+AG/mvgSzxlHVcXybIUz/1q/dqcYW09hduvA=;
Received: from mail-pz2-f40.google.com ([74.125.228.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB3ll-0007Dl-5j for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 05:19:17 +0000
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc750a1482fso1387940a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 22:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790572751; x=1791177551;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aE4CNeMPjoyGqhac0qEjC0MrhT1ea2sjSdxYtuXCv0E=;
 b=a3R2fYPlkF/Haj9qIshzsmEGnxtWE2cnW4hdn4mVxfDhx4919+JC96ezE9ePQF3/QL
 PJDk0vwyJPh0Ga95qj563HJGp9b/AGpKVwiAZIAbnAXpNw+/anoXazbwouP2KVHCtI6o
 qJK3yuqzyIuFsU8XZtv4UpxCfpEScZncR//kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790572751; x=1791177551;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aE4CNeMPjoyGqhac0qEjC0MrhT1ea2sjSdxYtuXCv0E=;
 b=dQXjZXAWHwICquPcPIkKdgn5vR/ur1bFszmi+J0424IXnYJR3OlNAqwJEnLeEmcpF7
 9TkHU+JiM/WOUxvjOkfSc6mnk2EO7pLcXYDLf/9Yrtj6RnqTSmhIWLB/y5kSyd9xqtst
 WUHS9E41GPOhfblS2VgZdpp7Rrv9bWGPdL6WZXdKf6M8hc9hl82bqgQ9zgHeGkgjbPgj
 b+eV4iCUw0Lr5lEeWNwhHYZoEZ9DZoYRj30/YxOeNrDFJDOsA6GEn2P4vywbqQ8Hb7XZ
 d6ujLTwm73pTwU52EWdYRX12FNXpWXU6Q5OlhPi8cHQSOrEY05qfRdus+VoDwp1PVLbS
 cxIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeThh67RaHRb2Y9wPwPOafHl8q1T8xD5KXmrny76meOrH4VA8g3wAL1mI5qHTQ2l8oRecoIc4Tx9u8Notv5/yk@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKZn0t85BIluYcBlZqO4R+bJ97ecq3QyUMsslK8zF4Ts6ncs6G/
 OG9QZciAM2Nw/WQG9guzaMDv3xymZPr4fgM9zFdF8Zb1o2CLTSd+/bMPPFd0LpsSpw==
X-Gm-Gg: AYBFou0mD+7vPi/QWOjICsdFjzW10GexXnMpFNZzvH1i4qX3cVDw701OZgqgkV+QSHc
 6Cs1GuT0c8yd5p6YRqCnnx4y55kSVFGRozxyKV7U3nE8U6AfLDG3s7Fg9Hews3HGpRKrNw03QZ7
 fEPBGGOQjGevwD9C64wFoVD8Tqv8LKbjHRRzwlUomNRU/l7eGeL5JFygH8vBhxHhXNhQciaII8W
 42iqXw0RIuc0wwgOAc2q4V6fMlHR5R8BSfxOC89imr7tyWXtqwxzdiSMav9xNWERy2txy6MIVta
 /Z9KabzCmbCCmbYzGhYj53laZVpUf99MRPn0qGSxXA30153r2mciYUZWT3ZENMk+sjDhCYy4mQJ
 v7HMcZg5l3/u9DYo8/VEHtZ2MUsjO98waA/xHnLHHk2W8lhZpF0nMh4jgppZRWbRrBBRr8XsyHo
 MrQhKCh93f3msHwCnewTrKrzzEBQK33sem29l1aIYuPCopgduyHWJ0zAp17vjyzXEgTrMF80vnI
 hVUyYiGa2qh6AypSF6kOUzmpKad26MnvuskOCo=
X-Received: by 2002:a17:90a:597:b0:3a0:a055:1759 with SMTP id
 98e67ed59e1d1-3a0bb60e55amr5032133a91.40.1790572751469; 
 Sun, 27 Sep 2026 22:19:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b94936ddsm18408378a91.7.2026.09.27.22.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:19:10 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:19:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <arn3TC7BgjTXWmdG@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
X-Headers-End: 1xB3ll-0007Dl-5j
Subject: Re: [f2fs-dev] [PATCH RFC 1/9] lib/lz4: import upstream LZ4 sources
 verbatim
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
> +int LZ4_compress_fast_extState(void* state, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
> +{
> +    LZ4_stream_t_internal* const ctx = & LZ4_initStream(state, sizeof(LZ4_stream_t)) -> internal_donotuse;
> +    assert(ctx != NULL);

Probably in some other places as well:

LZ4_initStream() can return NULL, but the code immediately derefs
the pointer.  The assert() check seems to be misplaced, unless I'm
missing something.

I suppose those need to be decoupled.  First LZ4_initStream() call and
NULL check, then stream->internal_donotuse.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
