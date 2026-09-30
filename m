Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A99CA5FB5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NTM9wD1F/ep1xsu0s6fE1yr5EeJNBW92yuiyNR1T5Xw=; b=R4qrcCxjoNrek3HVEoSAASsVLy
	aLnWQrYhL65ovANwEpQ1pgFgqkn4oi4d5qk3Gd63233nidlUaUHWT4euhrSuBipQDIAARXbCvrxpB
	lsaxdzOFX9V5buMJxo2dSLkDiaSB8F/CMoz11p+gRlSPoW1FLK8tNtaMjRXuTybdQXyE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBnUH-0005er-KY;
	Wed, 30 Sep 2026 06:08:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <senozhatsky@chromium.org>) id 1xBnUG-0005ej-Mg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 06:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CgFmFj2igJGpmbRflOSd7wans++uMlq7r70gUY54Vy0=; b=bwtWF1XSGqPnSrMkz8jGaac8KL
 UxD8mAirXMUCtGhc3huFZ2PpfnNHBbZ56cHccJrn73VLlmYDij3HMbAS8GphxVaNEoxyJIszl5s7p
 tkRndtEFDZfrY+ccW2rRZYablqIXI39ewMk4B4uoB7mHkThJfOl2jXLL4qqxdw1ZnOrI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CgFmFj2igJGpmbRflOSd7wans++uMlq7r70gUY54Vy0=; b=HEv4FM6yPSpxiqyDXVxhhtj+2q
 iBGTiYIXMl7ckjomeuTIhTsXrOCq87lAeMkVodIQzUf5D4Wh/FTOOC3jZ9WjuxLHW/QBYoNIbaVGw
 FyM6N1OxZc3QeEyrpKrCweS39BV0MMUznVJhxS09hyP8R5XBzygoM93Yq5YFkTj47OVo=;
Received: from mail-pz2-f43.google.com ([74.125.228.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBnUC-0002kb-Ri for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 06:08:14 +0000
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-8631d0023daso2509159b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 23:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790748487; x=1791353287;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CgFmFj2igJGpmbRflOSd7wans++uMlq7r70gUY54Vy0=;
 b=XCrx+2/bDfojkILtzAgwXp1BmI8So4gkSNKNxgkLXWdtFF+y9qhVKhxjMkaMTqZVNg
 LqwYbfoJLqLxJJL8gLTUSNpyMW305mw7/2YCKTNPPJLxyIy0CudFBgBN9GLOV8DHLrXz
 xCpXTGMaeQstHwakwUlWH02MD29l7eDE8psuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790748487; x=1791353287;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CgFmFj2igJGpmbRflOSd7wans++uMlq7r70gUY54Vy0=;
 b=AIY/uZPcRFn9raqxd2KU+6adHhHos+hdBIP2ZSJDp41p3wkkugqBT0J0HlZC6vIKic
 TjDRKm6lD+WgBlc0UmOTI+csgUMwxWoZslrmEzqwRecg3y52SXxbLZTeXMsE4SPmX3l+
 hOulJSckIL9xhREoyL0fWGiq29/TQREGObd5X/ImI8Udeu8LoBgxJo4RnkKckd2iGnKQ
 d0BCVowARW6cGOG/BI4QPM5nH+DdA5lyVVfb1otQKk4bgU1KrI8oC/qtKbvxZfGztrn5
 BPj+zk1FEbjCuDXhdDZsVCrEASMkX7p0amG6x3qBc9ohVDo1/WtoRP/aQNv5mWs7Nt7O
 gqgg==
X-Forwarded-Encrypted: i=1;
 AKwUvByM5jNBGS9c/Q/aNGjcKQZcjHBZ38ak4VUwIhgK4DMEUxkzn3I2nvZQw2p+PdYA78lEZ3KXPVMMyfJnHCeQ4Zrz@lists.sourceforge.net
X-Gm-Message-State: AFuF++mdVe43BTfMrLpL2N16RaVcXRAoc/48xT5mVyc68Rl8dRn8pE09
 p5rCGoFT9/WoEKnwpFQybHz63pwdY1IPALxhOlKBgjBZncPjiWhgKFmwAIy06LbykA==
X-Gm-Gg: AYBFou0Tdib/eL4VbNhqVyPsdYOzDQICVGZL57ZRqBTz8GF+e9ivwXsNPQ91AZY5GeT
 dyyfX37fD1KwL7jZc89ORKBv7JHgCaSxGxILbzJFu5MaRTxB9fK739lEJHYsA4MpY9YITXaqLfd
 7PbOld5iExT7Bk81gs2asIeEI/mhp1L3hIiwZAcXALNDoF1cyhkVIB4/qdE4e6/tNxK6Ba2fbgV
 4sBR8jBS65RlE3XxVxKLsKAcPGwHwOpOTA5T5XRSgiI4byI5/rsTbLG5JBYmzkknb0wtX+Fo9ko
 WrOUvP7NuDlEYSLC0Qku3KGVepHO1YaQXk0o0G4i08BzcK9OKso9mSmZwbAM7nK0hUMuk58oOms
 bMbCiu+5SliUQg4hCS49+/HhAg5PRFiFHNgYk6Cnz0VRVhFxu0f0DmXhJGCd6J30ulHfjMUOVOS
 IhCYdxMviG4xo2qFX1T58JgvrGOzN2V87KjMnl65+e+t5iVjLGzGxrz+DWWfjSHeMH4htyS/+U7
 vxWUGygI6ODi93kuDpj8KHLMD0RFLob+Ubf3ZS16kT1fxwNQQ==
X-Received: by 2002:a05:6a21:492:b0:3de:3bd5:604c with SMTP id
 adf61e73a8af0-3de9e87f358mr387844637.41.1790748487167; 
 Tue, 29 Sep 2026 23:08:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:31b3:f8c3:893a:d0bb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88725d68389sm247895b3a.39.2026.09.29.23.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:08:06 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:07:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <aryehUJml8fTy0o-@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
X-Headers-End: 1xBnUC-0002kb-Ri
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

> +void LZ4_resetStream_fast(LZ4_stream_t* ctx) {
> +    LZ4_prepareTable(&(ctx->internal_donotuse), 0, byU32);
> +}

[..]

> +void LZ4_attach_dictionary(LZ4_stream_t* workingStream, const LZ4_stream_t* dictionaryStream)
> +{
> +    const LZ4_stream_t_internal* dictCtx = (dictionaryStream == NULL) ? NULL :
> +        &(dictionaryStream->internal_donotuse);
> +
> +    DEBUGLOG(4, "LZ4_attach_dictionary (%p, %p, size %u)",
> +             workingStream, dictionaryStream,
> +             dictCtx != NULL ? dictCtx->dictSize : 0);
> +
> +    if (dictCtx != NULL) {
> +        /* If the current offset is zero, we will never look in the
> +         * external dictionary context, since there is no value a table
> +         * entry can take that indicate a miss. In that case, we need
> +         * to bump the offset to something non-zero.
> +         */
> +        if (workingStream->internal_donotuse.currentOffset == 0) {
> +            workingStream->internal_donotuse.currentOffset = 64 KB;
> +        }
> +
> +        /* Don't actually attach an empty dictionary.
> +         */
> +        if (dictCtx->dictSize == 0) {
> +            dictCtx = NULL;
> +        }
> +    }
> +    workingStream->internal_donotuse.dictCtx = dictCtx;
> +}

Just a side note,
there is a bunch of new helpful API added in this release.  Currently,
we do some memcpy hacks to avoid re-init of lz4 C/D-dict in zram, but
once this series lands I'll be happy to send some trivial EXPORT_SYMBOL
patches so that zram (and other lz4 users) can use standard lz4 dict
API instead of hacks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
