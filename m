Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26A0CA5FA3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4peiD6eYha/6AMrBwPFH/dV5x5rwF7Fqt+P4+BuhhiE=; b=NpuXYFQXhUsULJb9oLA8Di/398
	LpP/2xIknMbG19uz3fkfD7F/j9jFedCyXqJ89DF8L5L0BPZ1hN4E9TxzPyFUav/iMh/OWSHwgFStl
	GBil73R76YJPp1ruPbLNHFd7C7fn1UmQ/fUkPHJdqV5Z6OoTuNFulf0DOX8V7DMFUMdo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xB6i4-00028t-Mt;
	Mon, 28 Sep 2026 08:27:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <senozhatsky@chromium.org>) id 1xB6i4-00028n-4n
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 08:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XfTNwTEf8cXEoiVJjaR2wzaM0AVgLL//fGyHvTOkwQs=; b=Nq1j0SHV/j1Tc2UlpQtTDf98yy
 6WlHgYWqLunYXcQdnx9bTCBpEJ65FizCR3IEjkk377SFVlrk8BxE49fW97kYqXAYlqQzpMQQCTQST
 mMRw6xToX/AjeCh9/ixmzbbU03Jy4HvLcn9gkKfDLb4UNtyVB+oZre/sDWTCKyaE8y98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XfTNwTEf8cXEoiVJjaR2wzaM0AVgLL//fGyHvTOkwQs=; b=D+XfmH3UED1OZ3JcQbiLORT+8o
 fo56S/uT3lAyfucgoFkqArrHYvR7658bULg34ogTHKZ6HBooG1x55tS7mJTHMmm6iCDa7E9tjpzrg
 W0JNph2w1Ecggm9xlkKhIzWgs0bzTIQk/2tEqPKwp6sRsNZJgpUdDlaNwFMecw05YBwE=;
Received: from mail-pz2-f40.google.com ([74.125.228.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB6i2-0003sY-P9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 08:27:40 +0000
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-87c90648f99so2101206b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790584053; x=1791188853;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XfTNwTEf8cXEoiVJjaR2wzaM0AVgLL//fGyHvTOkwQs=;
 b=JM1BuQlvH4IE/+gGkuovsKzkPWwi1EBD3Ld5Y3p2895y4kMAIAbnGUBU+cKegz0zgR
 L/4T2i4kLTMIaGbKEHaDPTCqFYKP7CLg0Y/j22Pag5CXdEbDhHKgLZvJlcPs974BsIvV
 JHVEjHlPM75h35QtVnOtgZRs6L5iSmjI4U9ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790584053; x=1791188853;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XfTNwTEf8cXEoiVJjaR2wzaM0AVgLL//fGyHvTOkwQs=;
 b=iziHsrVnQVqyxotKFE+4F0vfJtQQP2CUQMmjLPh7Eoxb/Hc4fhR2DBziShDF+Q1slR
 q3f88lHkheuiiCLWiVcMkwOFMJ8b3l2CY4TKG7BDDeoeInPTvw4U3ZjrmYtrDcDaAfr4
 5BVxIY4R2mliuoxMJanl0G7Le+bLA5he9jqrQHgafCJuSY5uOq6t97RcRykBjUE0kukJ
 zl3ZH0FYtSTVCKD86tBHNaxSvs5YnRdXruTy3BomnIzT2vTRelS5bt1lBDFsb1RSC1qa
 sfED9cS7jL8bSzNjqm5f1gzHcNRD51fAOBR61qIA6xTFeZ2Iy3m0HirqqnSD7aOAP4sH
 I15A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1jCf0B9sBphx8NCscMoEuqm+M3726KRJDDKEN9+ifAZKEiqYR1asDh1CCTs8OMV8ld0XFiRK1p6EZSgS24y2T@lists.sourceforge.net
X-Gm-Message-State: AFuF++lYsQZa6UkZaXIJYFaU4noLdfwZt88dzwsvuMH7m4fuqQVxuFo0
 V+RhM6bxcLMOybPAQs2ayTMRZesqJDn3zurz7CZJ2hEAisS5KKj/Qe4hTeq9xF1Piw==
X-Gm-Gg: AYBFou1YLltLDa6NIqbryZSgOPPAX2ptBsl2cSOr4A76YBCJ+VDGH7y9zhVu5AE1+9d
 SP5JaLFc1b2RJLj6NaIMYyw9hTAFuUtYWepz1J5rCpZuckhOF9Mze2sxkrndjWMajMXSyYcAJdK
 RB4KPzgL7mzDk+/R1B2ik0QhUYe+rZ5xws2h3YwbRwlTqndoXh7y+vJsxTUSFlVLyJmCVFv7ZKd
 QGsf4lmvSt21/mVMvbblN08zgMKVHhqEkQx9MmuL8BH+Q7P4gAfeSwxEwnJm9qOfODDeC+JNjzZ
 2rfnjmucqBZv+/kD2K6ps2Lwsx1g8u0SteHVb8sUd07uqWJVmoK/CJOmNEN4zgTCQa0ucK0RXxR
 0NRBjESoKseTOK/U4zPspc480ZpmL3V7Z+vyZVJc1+ngEzecT1J8rTOCTeehXhXu3EZZh1sbwhP
 S857X9NkAo3/yzEtAWRHjmiumenvdnmM+/l46eutD0YydBAw3B5TNxlKuZavi5gFvd1f13DPR2x
 ghyUmJFSnDwZ5XsQRsxbbaBDeWBm/f0xacWL94=
X-Received: by 2002:a05:6a00:7619:b0:880:8fe8:a3ea with SMTP id
 d2e1a72fcca58-8808fe8a798mr3659738b3a.45.1790584053122; 
 Mon, 28 Sep 2026 01:27:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87feae8d827sm3676965b3a.36.2026.09.28.01.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 01:27:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:27:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <arokqo4gVQVglkBa@google.com>
References: <CGME20260925113450eucas1p2fcf838f00f35e1bce0ca04a694cd0cd2@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <arnr-Su0uJdK_rOb@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arnr-Su0uJdK_rOb@google.com>
X-Headers-End: 1xB6i2-0003sY-P9
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
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
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
 linux-f2fs-devel@lists.sourceforge.net, Minchan Kim <minchan@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Justin Stitt <justinstitt@google.com>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On (26/09/28 13:25), Sergey Senozhatsky wrote:
> On my x86_64 build .text size change seems to be quite significant:
> 
>  ./scripts/bloat-o-meter lib/lz4/lz4_compress-old.ko lib/lz4/lz4_compress.ko
> add/remove: 0/2 grow/shrink: 5/1 up/down: 8022/-1755 (6267)
> Function                                     old     new   delta
> LZ4_compress_fast_continue                  6028   10486   +4458
> LZ4_compress_destSize                        158    3112   +2954
> LZ4_compress_fast_extState                  4078    4597    +519
> LZ4_saveDict                                  82     153     +71
> __UNIQUE_ID_modinfo_466                       52      72     +20
> __pfx_LZ4_compress_destSize_generic           16       -     -16
> LZ4_loadDict                                 261     204     -57
> LZ4_compress_destSize_generic               1682       -   -1682
> Total: Before=14756, After=21023, chg +42.47%

D'oh you actually point that out in the commit message, sorry for the noise.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
