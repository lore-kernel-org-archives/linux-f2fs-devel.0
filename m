Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F88BCA5FDD
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 23:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:In-Reply-To:From:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VeCnTacZ1Wt0q3+EpobSixbqDL6lpLtit5aXiP37vu8=; b=IgVTDVzAZFPArtl089YNAjArXk
	7mVBtHsfcqtoLfg4oI+hwp1qCCX8SOTNERY7cuNjMibl9FJMw12nXRQ4yZZCI3AQyhZ6qgrM4J05+
	S4TaGd1ycc6HG5+nBgs3L7jFBjzI8fRUjpudLnJxcGSif2kxDwyOMkIigkv4mO0wtqFU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xD9Fs-0005mZ-FX;
	Sat, 03 Oct 2026 23:35:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xD9Fr-0005mS-0u
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 23:34:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=06jrm1eJOKkEfVYjfM8urZVFEtTHJTgdf4MXi9Zr75I=; b=GH1qi/C2NgMmeUglhyzrV0n+mt
 lN8NhsM5Lo/E81W5R9vqHB1BZq1WvTpzV9N6vFENflRdblOPBU8b+1CjNJHy7U4ZB2tDDceedHW6F
 dQK9ESiJI++DtWpM7hJ5WJ3UclXMxFpu+WKTee8dKTc/R7/L78PQfMjP4fF7cM6n0wL4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=06jrm1eJOKkEfVYjfM8urZVFEtTHJTgdf4MXi9Zr75I=; b=JZhxFFLEeYVpnwUWieHq3cWwX7
 2ndAVRsZnVFOCrAtkGr7Pm1hu16n564reOW8L/iDxjfi/xIBM4HNS9o5SK3CfleEKr1faP2A8oEkD
 tW6QyZo5dmwccATz16nPTXGm7G3likN1160czGxn9thdbkuZf5ZUI7WY/pV46ze+/Xps=;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD9Fp-0003ip-MC for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 23:34:58 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261003233450euoutp02c1894a969f4aa7dcdc13711324b510bc~bKR8fdgbC2968329683euoutp02C;
 Sat,  3 Oct 2026 23:34:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261003233450euoutp02c1894a969f4aa7dcdc13711324b510bc~bKR8fdgbC2968329683euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791070490;
 bh=06jrm1eJOKkEfVYjfM8urZVFEtTHJTgdf4MXi9Zr75I=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=QA/UIMngsEzopfyR2oMgeAvIpsxY8XFVWR6aszTu2KASkTE9HgfdfrEoibwj1+Ish
 q+q0jX7mWyllAGunxNTWrLk9JIZLUZdZDUhz/mwcYRQDpGduTJEE52K7M5/4/L7CfC
 t/2nqVLqsIrV+xGRicpyEUeoh56qvM0ZzTVHWVaE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261003233448eucas1p1a273f9ebf3e825f88405f45e28ff1fc6~bKR66LqvF0047100471eucas1p1Z;
 Sat,  3 Oct 2026 23:34:48 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261003233446eusmtip1e9b417cfe901275fcda452a3fc458927~bKR5M2kGA1826618266eusmtip1H;
 Sat,  3 Oct 2026 23:34:46 +0000 (GMT)
Message-ID: <34143c5f-5b1c-4ae2-90e7-d999d10b73cf@samsung.com>
Date: Sun, 4 Oct 2026 01:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <arnosKlQYVIdmTR7@google.com>
X-CMS-MailID: 20261003233448eucas1p1a273f9ebf3e825f88405f45e28ff1fc6
X-Msg-Generator: CA
X-RootMTR: 20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a
X-EPHeader: CA
X-CMS-RootMailID: 20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
 <arnosKlQYVIdmTR7@google.com>
X-Headers-End: 1xD9Fp-0003ip-MC
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
 Herbert Xu <herbert@gondor.apana.org.au>, Helge Deller <deller@gmx.de>,
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



On 9/28/26 06:12, Sergey Senozhatsky wrote:
> On (26/09/25 13:27), Michal Wilczynski wrote:
> [..]
>> +#ifndef LZ4_FAST_DEC_LOOP
>> +#  if defined __i386__ || defined _M_IX86 || defined __x86_64__ || defined _M_X64
>> +#    define LZ4_FAST_DEC_LOOP 1
>> +#  elif defined(__aarch64__) && defined(__APPLE__)
>> +#    define LZ4_FAST_DEC_LOOP 1
>> +#  elif defined(__aarch64__) && !defined(__clang__)
>> +     /* On non-Apple aarch64, we disable this optimization for clang because
>> +      * on certain mobile chipsets, performance is reduced with clang. For
>> +      * more information refer to https://protect2.fireeye.com/v1/url?k=e59d343e-8402d40e-e59cbf71-000babe403ab-24cad800d51083a3&q=1&e=1265adcb-d286-42f9-9d57-b9b998ba2ed0&u=https%3A%2F%2Fgithub.com%2Flz4%2Flz4%2Fpull%2F707 */
>> +#    define LZ4_FAST_DEC_LOOP 1
>> +#  else
>> +#    define LZ4_FAST_DEC_LOOP 0
>> +#  endif
>> +#endif
> 
> I just checked https://protect2.fireeye.com/v1/url?k=f36de8be-92f2088e-f36c63f1-000babe403ab-1972efa3caab0762&q=1&e=1265adcb-d286-42f9-9d57-b9b998ba2ed0&u=https%3A%2F%2Fgithub.com%2Flz4%2Flz4%2Fpull%2F707 and it seems that
> LZ4_FAST_DEC_LOOP is enabled on aarch64 now, but we still disable it.
> Am I missing something?
> 

You're right for clang builds. v1.10.0 enables the fast loop on aarch64
only with GCC clang has been excluded since PR you mentioned. Upstream
has since changed that neither of those commits is released yet:

0aa33884faf5 ("[LZ4] Limit disabling LZ4_FAST_DEC_LOOP to
aarch64+clang+android")

ed86bc1ed802 ("AArch64: Enable LZ4_FAST_DEC_LOOP for Android")


The first is already enough for the kernel.

For v2 I'll backport both commits into the vendored lz4.c the same
way patch 2 backports 5ef1f16929b5. They apply cleanly in order and
give exactly upstream's current condition, and they go away at the next
resync.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
