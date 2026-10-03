Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A57CA5FDD
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:In-Reply-To:From:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=szZGWjgh4AQGqzi3QXQkuNdjTaISlp4hdJMgVHeu8S4=; b=CfSu20TDWFCPRccfvIbsFOZG1o
	GByMmitEWLPPLNUiw9a3sfcLnjRStY5tRcfVY2Om2G+zOcVwGGtkmOiSEghYULUMwvZp47qxTSVQ7
	yOtkkXXiLSHZv9PEkZEtvjOhdy88Z0NWGJ1O3DMfmyLOH121tB4sm4nqCeWBXgOHMdSI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xD9VD-00060w-Nk;
	Sat, 03 Oct 2026 23:50:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xD9VC-00060o-3L
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 23:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6il4wp6k9x9TZkz/+h7OllEoUNqhyj9iIClTYmBbfBE=; b=IEaHnhsVdh5VBFPcfn3iA4O3iJ
 IJlng+UH9NL4I+5o4Y7vnYp2reY4SXeE+Cp71YUN0QFZA73za3ZddzU0lAS3l+bQqzWkow2l19hus
 5fIAobXSlwsceN3Nwk9v+72TLpkRFwwFCWvOf106n08J9o6fYeN5CgWsMMS8S7/C0cXA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6il4wp6k9x9TZkz/+h7OllEoUNqhyj9iIClTYmBbfBE=; b=ME42xK/1W4mHJxkBEq+d+3i9sC
 yV1pZJVtI4IMg/dTvCZQmQge6OwhqbO4T89oyItBrh56PQg8stj/brsOfxzwW7Xv6JHVRsyiLCgke
 6AapuAS72eZ+4O7jhU2CIASrDkUqmJHJAhLWblSqx6EQpygZAG8bEvtMX0mIYyQifQCo=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD9VB-0000gA-Mc for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 23:50:50 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261003235042euoutp010ae13b921807e43a815feb68ae19742a~bKfy8ONYY1131411314euoutp01C;
 Sat,  3 Oct 2026 23:50:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261003235042euoutp010ae13b921807e43a815feb68ae19742a~bKfy8ONYY1131411314euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791071442;
 bh=6il4wp6k9x9TZkz/+h7OllEoUNqhyj9iIClTYmBbfBE=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=J6UYA23GbXzSgWDiylsYXmqPqrWmGrxHinr+zo153Mh5xVMO3Fq4093yCW56RM5zv
 TyAOK++gZXWwfZ1rhR13Mfp5PEywRRMqi6WkuWaomAKaDMbZmHoF11QNolqip1ZlRU
 w4hnoy1FfOTb+5wYvNiuKO9RUPya9G8Bd3toECJc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261003235041eucas1p15384f0a3889321f025161bbe2b71bb94~bKfyB3g9T0047100471eucas1p1e;
 Sat,  3 Oct 2026 23:50:41 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261003235039eusmtip254e0d6be44f5a841ebd1c20bd2d1c117~bKfwWPKr40220102201eusmtip2G;
 Sat,  3 Oct 2026 23:50:39 +0000 (GMT)
Message-ID: <fac0f401-bbd3-444b-a755-53cc393673de@samsung.com>
Date: Sun, 4 Oct 2026 01:50:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <arn3TC7BgjTXWmdG@google.com>
X-CMS-MailID: 20261003235041eucas1p15384f0a3889321f025161bbe2b71bb94
X-Msg-Generator: CA
X-RootMTR: 20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a
X-EPHeader: CA
X-CMS-RootMailID: 20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
 <arn3TC7BgjTXWmdG@google.com>
X-Headers-End: 1xD9VB-0000gA-Mc
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



On 9/28/26 07:19, Sergey Senozhatsky wrote:
> On (26/09/25 13:27), Michal Wilczynski wrote:
> [..]
>> +int LZ4_compress_fast_extState(void* state, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
>> +{
>> +    LZ4_stream_t_internal* const ctx = & LZ4_initStream(state, sizeof(LZ4_stream_t)) -> internal_donotuse;
>> +    assert(ctx != NULL);
> 
> Probably in some other places as well:
> 
> LZ4_initStream() can return NULL, but the code immediately derefs
> the pointer.  The assert() check seems to be misplaced, unless I'm
> missing something.
> 
> I suppose those need to be decoupled.  First LZ4_initStream() call and
> NULL check, then stream->internal_donotuse.

Good catch, this assert() is a noop in the kernel (as any build without
LZ4_DEBUG), so a NULL, undersized or misaligned wrkmem oopses in
LZ4_compress_fast(), and LZ4_compress_destSize() and LZ4_resetStreamHC()
carry on with an uninitialised state.

No in-tree caller hits it (all use kmalloc/vmalloc), and I listed the
alignment requirement as a behaviour change in the cover letter. Still,
the vendored files need to stay verbatim.

So in v2 our own entry points can check alignment with a WARN_ON_ONCE()
and bail out early. It might be something that we can fix upstream as
well.


> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
