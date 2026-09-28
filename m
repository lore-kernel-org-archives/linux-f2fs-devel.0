Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACE4CA5FA1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KIXQ6u7v3fI2NKdHLwI4rQX2zt0oAh29k3T7193rnz8=; b=A1H+Z1JhrL7ajAhFp1+Dpt92yU
	clQCwhKb1VG1ZMEtqVaVoD9egASp8a4a5RMTkUMmzi7AbSiqdW4vmozahQwVzgMWwfpcRLOA0HAYa
	05d4OouqCEqcW6CF3cPSSH2j2r1bHKGMy8RbmsrSGLb9+ArTCy0osDVyd96Y9dtzYqG4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xB3P1-00069l-05;
	Mon, 28 Sep 2026 04:55:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <senozhatsky@chromium.org>) id 1xB3Ok-00069W-6Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 04:55:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FrMP4Ii/YMUEItMnNYi/9VayHYXB02wrW1zol6BNPjU=; b=Z+43wdkJ4w89hylHdWexn4xnXc
 4/yd4UOqakmO/00vLGYJIWRMQAEo0UhHdFjYK/ab7IIpj4Kn9L57BLUTKse5sXJ4XJ3cIDYl+jcVv
 WI6Ot+BwkzucyIiaNVFTDiyXJEF6Mfu1Memx7huOztltR8NOMCCJj6hFSdHTYTywd1DY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FrMP4Ii/YMUEItMnNYi/9VayHYXB02wrW1zol6BNPjU=; b=jXCnbS//+9vDZYRQSWdZUB01/J
 ctJyopz24BP15mwP8TPrGtJXLikp3cep9LASA5+iPOzX1V91jgknKJRg0tS40dSoTBdfeAy1ZkkgF
 oOKmfxmkX/QDpbgcrMm1s24mFMunr8GsP32wHPXC3VCKCttoDcBuyrEiJZr0jrSyL9qw=;
Received: from mail-oo2-f37.google.com ([74.125.231.165])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB3Oj-0001KO-I0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 04:55:30 +0000
Received: by mail-oo2-f37.google.com with SMTP id
 46e09a7af769-7f4f0d1779dso2152649a34.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 21:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790571324; x=1791176124;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FrMP4Ii/YMUEItMnNYi/9VayHYXB02wrW1zol6BNPjU=;
 b=DAe3HboE/tmTtpYwJBZFRetdh3UE0r9XaQ+PS9kcU9IV83KLKiuZnQFR9qYVZ7cmoa
 LPuHBNt+O1NIFu/hg5XynioBNSeKZraKVLlPGoZxo1R+knIs8jFnNxdGwpzK2gSIXCPZ
 SYgBSZAXpm8PGtkj7yUwOH7Kklo4qDyHcuT74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790571324; x=1791176124;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FrMP4Ii/YMUEItMnNYi/9VayHYXB02wrW1zol6BNPjU=;
 b=EFi2BtLjdnpVA90Cp7NZf6c6pmBQY+HAjJn5N0wQvg1v95B9DfVdEVSHF4TJATWPgy
 StX9Ibu1thTuiu4IPyLEbTLgsavyWfl4f8XpzW24uoMs808fU0UYS+jZgyEqObZcMG1i
 LIp3i3rbgmAOuKofKCD6X4UUDXD13Tvn6eRmkHQEu7SF7MC0K4hRa42/Gr5BvbhonycJ
 8JTnGxVhuLDbgR9MnM2QZsxAAaZR9ZCV6i6koAcBFTvZ1BDbJhWx/AXrx/P1UFs6WOHc
 Dv82nTConBPFziXNMH1ir0mQTEeuaJ9Sd9OYVvAbgFtYsqNjiWzjRMnN0Bc5BsmE1mW7
 Sfbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSeVIb1H5uxY+df5AmjY5Om+2yeWh4jqZV9at0s3K0Cu9qXy+GU6vhMd74HNDoUx8WJ3xFiVHuCrIQelGDRa8O@lists.sourceforge.net
X-Gm-Message-State: AFuF++mTc7Y4/gc8ih7StN7ohVYWduBnI4ArZ25TDUwaeuCnCim5sQhK
 fLbyF3wRTWYxUAjJK59OvJb+740q2fgoOPkENu6ATzazoAkKEIRmvh9syt7DkanlkHfs397lbKw
 wiWM=
X-Gm-Gg: AYBFou0tauhUgL4RyMsBuXdu5cl6e/gg0zq2YkTzXoo0qr0A7U4GxxMmCIhtnXzhWu6
 v1DgW5BdH33y3hwus3pLDisB0telX5G95TLCkqZ7ifTRmwP+1hXUl8ijk18kHCMILP4QEKvftKK
 rUM8rEUPZ6mWYaoEjABcE25Y+SZWyq5qdRp9L/QqbNAflbcPTIK9G1n5Dffk7zRH0t3/0mM8Rfw
 iQCwdpXjouDY5cbJ6+z+NvMTTTTo0KKSq4vcmL33gZa0Z6SdHH0VM2q+zwdSj0jD4nGdVHeM8M2
 Yi0fnYYvUptS/xnLB+FL+jw98r5ss1ZoEzwCO8oIjSnBm+QvgZmsDc8/rd9ncpy2vUHfEgxA8Hr
 /gKPTnxKyeavCP6Y64JU0/DAES54taVHmRAqyi3P5aMh9GANC42UpzsGf40sB0XfmODhLq2Tqet
 2ziXmSsYwUbM6H9YaIedqwEfSh67A3O152GFv4xD2W9YNKTnDEJpQCeJ9pjlkaGCKmoCBp8LUyr
 fQ3YjSmrOKsc7Yd1wYowKoq5K8DQIMSOczK+pc=
X-Received: by 2002:a17:90b:3b4b:b0:3a0:d2f3:fa80 with SMTP id
 98e67ed59e1d1-3a0d2f40159mr5894433a91.6.1790569562955; 
 Sun, 27 Sep 2026 21:26:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b99917besm17891690a91.14.2026.09.27.21.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 21:26:02 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:25:53 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <arnr-Su0uJdK_rOb@google.com>
References: <CGME20260925113450eucas1p2fcf838f00f35e1bce0ca04a694cd0cd2@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
X-Headers-End: 1xB3Oj-0001KO-I0
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
> Michal Wilczynski (9):
>       lib/lz4: import upstream LZ4 sources verbatim
>       lib/lz4: backport upstream's -Wmissing-prototypes fix
>       lib/lz4: add the build environment for the vendored sources
>       arch: boot: put the LZ4 freestanding headers on the decompressor path
>       lib/lz4: switch the compressor to the vendored sources
>       lib/lz4: switch the HC compressor to the vendored sources
>       lib/lz4: switch the decompressor to the vendored sources
>       lib/lz4: fold lz4_kernel_api.h into <linux/lz4.h>
>       MAINTAINERS: add an entry for the LZ4 compression library

On my x86_64 build .text size change seems to be quite significant:

 ./scripts/bloat-o-meter lib/lz4/lz4_compress-old.ko lib/lz4/lz4_compress.ko
add/remove: 0/2 grow/shrink: 5/1 up/down: 8022/-1755 (6267)
Function                                     old     new   delta
LZ4_compress_fast_continue                  6028   10486   +4458
LZ4_compress_destSize                        158    3112   +2954
LZ4_compress_fast_extState                  4078    4597    +519
LZ4_saveDict                                  82     153     +71
__UNIQUE_ID_modinfo_466                       52      72     +20
__pfx_LZ4_compress_destSize_generic           16       -     -16
LZ4_loadDict                                 261     204     -57
LZ4_compress_destSize_generic               1682       -   -1682
Total: Before=14756, After=21023, chg +42.47%


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
