Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730AFC9832F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qlPp/Yu2q73a9v3OB18PO/FZwGOrLgGo3C+v0ilBbLM=; b=kHUr8j1ZUwzortYd4xe9c4MYnw
	aI9hQ/38r+UIHRgaEN6i5VirFIbnZnYWs1BY0QbQHN6NnlK74wBmHNercUA5xb+Fa0CuOxukAFbGb
	VHPQbL6LDN8deKJadQ2hl0eK1BkDEEgLFjGFzD9qCDC/Wboa8W6lmDnbOHSMo8Bw2ceY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xB2jI-0007Jy-E6;
	Mon, 28 Sep 2026 04:12:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <senozhatsky@chromium.org>) id 1xB2jG-0007Jr-EX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 04:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bXDScwdKbt28kFhjEDV73RhbSo3l7UPBxj8GidcV6Ck=; b=HTGdJ5QGFH8G4x//XMERIFkd4w
 yPEt7aBwCadw4lhdP9MIY3VHCU+7swsqB4/6a6PqmWXYzjV+9XIhdD9nsttBjb6J2GZPMXxeVrTmO
 wsd+FT9Ygn4mhG9QRoROZx07ZExpgSZ3ZnxmZZdeEuKKi3zws4hwCFxgDd6ayjJrTLEQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bXDScwdKbt28kFhjEDV73RhbSo3l7UPBxj8GidcV6Ck=; b=c3BmL6mB7S8DwNJFLSjQpOBSEZ
 wHSmq00qoNPq4gAwGAKIKJw6xe2WgTvmimfd70TzDccPGq/yk50eJGOTwL6KzMmew/N63gwCeLuoA
 pab8M4jS+Ldsfp5JyM4mNYZzCsiqQBjxLpdt6ISN7fLg61+/KodqYQarUw8X9+Myoto8=;
Received: from mail-pz2-f42.google.com ([74.125.228.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB2jG-0004wG-IU for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 04:12:39 +0000
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc797656e69so571558a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 21:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790568753; x=1791173553;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bXDScwdKbt28kFhjEDV73RhbSo3l7UPBxj8GidcV6Ck=;
 b=mPiiGNx0XcYHQbAjkxq/XKKYbvI2thlOuAaBRa3g9mL9UmvnDX0gE6b0uBZKHtggsb
 QSoNnf7gXeFY0+A3+dh+jzOJf5pjD7TGbOXw3D9km4nslk+g2xcUmZNK+bGfjDcmFZCC
 f2Y5XXhYj5XYZUffi9HYJMUEyAnKHzHYOTSqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790568753; x=1791173553;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bXDScwdKbt28kFhjEDV73RhbSo3l7UPBxj8GidcV6Ck=;
 b=VRRUyxW+YTz6SKIOUhU5c+L8c9EiVLx2XHbLeP7L4Jjx902uU00qZIdTArU9wEI7S1
 w8PiOvzuVx2MiIbHuK9hge6KIHY+0G8gulXqf9EzW98IF4E9IKRw3+Wb/7T/8UmcvQ5j
 QBL0OVTc+R3YEztqIS2z2sG75qxE/aUUEWD1oPewfah5SdZDQluNDIqm3a1lMo1h5ZYZ
 BnGj7xlEPFL4CjyP0wcBRZJbBJQ4wSmfLnm6szg4QsTXHYAuAIhAop6xwbcyMdjI0d8E
 VXNY21/F3T+b8In2oaXPpG12LNdFt4Zz+OkjEaXt2rLdoGqJ9SU9T8/cotdji0OP2KSa
 mZNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCd86ggefZUWTIHixXAtT+34gqmmpfpzq2F9pX5Cma6PAt3f5NqTvr0IzuNjz4yw0ihADA3rN7kqZ/fswMXGlV@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIt/6dkPoPmxAxbRGRvp1BypBH5YYxz8T81CKDCL4Ekwqab12QE
 uodz5HL+neIkWooJrrZbZLVH4wglNmXSsUmWCrzN4ZICthJF7XHfARxBsgCnmmJRyQ==
X-Gm-Gg: AYBFou0pim9ey8lUrwbD5wJHPf/wB8OEoZODwox01+uGESYm2i3N4go+1sVncjXDAop
 gFfYWofl25uvo1CjE5sEekD4T47r+JvsrvgVacElwJq2YgXbPB4oZCKD7onq6nZPcHFRlvcyjY7
 VXLpkxW959729Rla2wGnSU4/DAQyBxbILJUShLVgWuEuBNSNaaidwWruMHDzigV7kHDR/RXXOJ0
 GJ8njKCNXHnVU6ozLWj4BFVUfmHx1QYkVVhNktohuIuW+ysFUnzT1qwJ1WespqLS+tXlapCFPwm
 h3l0x20QkD9LmRvGGia6gyOU5qLm/7PKYxDHVqczEgHFodqeulXArrj7yOau6xlMGbnBCskD36e
 gm9JNE0LP5erqMJhrA4B+5O+f6+eK77ukVpRgv+blnMHmfC3xJwayFjIsNqWKaZvIlPhBfEUPWY
 IfxupJ9lyJyc3/RzqHHnga4aQNeY/YA6gdDAkfArvRoyiIjZ0rSpGB1RkgzZjksVcjMZFhmieXO
 DgxPeHblt+ScQfNu2A3pJ7HfOgvh53rt9Jb3Qk=
X-Received: by 2002:a17:90b:1c82:b0:3a0:7d97:37c1 with SMTP id
 98e67ed59e1d1-3a098aaba1dmr10891588a91.59.1790568752817; 
 Sun, 27 Sep 2026 21:12:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0bec30aaasm17381254a91.15.2026.09.27.21.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 21:12:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:12:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <arnosKlQYVIdmTR7@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
X-Headers-End: 1xB2jG-0004wG-IU
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
> +#ifndef LZ4_FAST_DEC_LOOP
> +#  if defined __i386__ || defined _M_IX86 || defined __x86_64__ || defined _M_X64
> +#    define LZ4_FAST_DEC_LOOP 1
> +#  elif defined(__aarch64__) && defined(__APPLE__)
> +#    define LZ4_FAST_DEC_LOOP 1
> +#  elif defined(__aarch64__) && !defined(__clang__)
> +     /* On non-Apple aarch64, we disable this optimization for clang because
> +      * on certain mobile chipsets, performance is reduced with clang. For
> +      * more information refer to https://github.com/lz4/lz4/pull/707 */
> +#    define LZ4_FAST_DEC_LOOP 1
> +#  else
> +#    define LZ4_FAST_DEC_LOOP 0
> +#  endif
> +#endif

I just checked https://github.com/lz4/lz4/pull/707 and it seems that
LZ4_FAST_DEC_LOOP is enabled on aarch64 now, but we still disable it.
Am I missing something?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
