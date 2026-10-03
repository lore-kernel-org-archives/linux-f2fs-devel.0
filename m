Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65B5CA5FDD
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:In-Reply-To:From:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oc6Z5fVoqA/LnirdHBK8PcHjoBVdcV+735zC33unYps=; b=VhFY2TZx9NayRbO62BMvcNZ58L
	rVcGr3Gs2utUIG2+AbeQaGfcBCtRXPynwWXqEF94bArSKb0yLmTgldOXabtXnsFZSPjGSp6iJHnAN
	DEbOGjpYR8EaJIK+LcNKDtaYShqsatWRdoahCQe85T0g1MSIlE5NHfvgd0yob8H2+Gus=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xD9JY-00083q-4F;
	Sat, 03 Oct 2026 23:38:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xD9JW-00083i-Kc
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 23:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DCSSTKMktb+HuS50/2vCoVXjx6kQyokLqg66BRCB0B4=; b=Bkgvp7l16/qrwJXOYH7nR6nIb8
 bmay0dPyFtCeC2H10LuZPtXJsfg0moRl35OpXiu8lfs908LVtL5ySbHlwWvkVZcSf2gaXh7haB6IW
 rp4E9250xuxKcjSbo94WZsD7zZZRCp7L05iNy222R2Pp+HhZQJMyb2PaN5oa8aZzlMEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DCSSTKMktb+HuS50/2vCoVXjx6kQyokLqg66BRCB0B4=; b=HtidP9y6U8EBRAugPgMGC81pnT
 +rdM6u9jJUmR5xiC3sjqAKbo4smcmo4yYozsWqsd58Rpc7rFyyNfLwRq0nTkVijJFD+K9433a7ORV
 Wq2djFYcjXsHtmkEyOKCUdVtgNZqvQlck+pU3k1XtEHOytss1L/xQbGJxw9KMDTO7Y6o=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD9JW-0003mC-GE for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 23:38:47 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261003233839euoutp019b93e0a38d74f7844d866dcf976a036b~bKVRYyCTw2859728597euoutp01F;
 Sat,  3 Oct 2026 23:38:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261003233839euoutp019b93e0a38d74f7844d866dcf976a036b~bKVRYyCTw2859728597euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791070719;
 bh=DCSSTKMktb+HuS50/2vCoVXjx6kQyokLqg66BRCB0B4=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=JHm5783mcsClVTOaAWZXZGUM5Mak3g4ei3h3Phsta5hYe2YrnBr40qBI7wEY0xmvN
 UMD5Hqg1kFQ/WCC4EuAuxIXk8MsORKJXSu+n5fnbc6nyJUT/p+4BAj2I/JULzrOMYS
 TIDbvU8ViajQeQ9onvYQmblwNgBjnxB65Btm5B/c=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261003233838eucas1p237c405e495deb98ca1ab7bffb909923a~bKVQa7ruV0031900319eucas1p2V;
 Sat,  3 Oct 2026 23:38:38 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261003233836eusmtip19df22b79e12bcb1dd0f2058e4a99ebb4~bKVO0uuxI2102321023eusmtip1C;
 Sat,  3 Oct 2026 23:38:36 +0000 (GMT)
Message-ID: <d60a30e1-7e9d-4061-a61f-d50909665c19@samsung.com>
Date: Sun, 4 Oct 2026 01:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <arnpj53cgDErAQEz@google.com>
X-CMS-MailID: 20261003233838eucas1p237c405e495deb98ca1ab7bffb909923a
X-Msg-Generator: CA
X-RootMTR: 20260925113504eucas1p25e50de59c02681fc1385220be8acd184
X-EPHeader: CA
X-CMS-RootMailID: 20260925113504eucas1p25e50de59c02681fc1385220be8acd184
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113504eucas1p25e50de59c02681fc1385220be8acd184@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-7-1c7ffbe21c4b@samsung.com>
 <arnpj53cgDErAQEz@google.com>
X-Headers-End: 1xD9JW-0003mC-GE
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



On 9/28/26 06:16, Sergey Senozhatsky wrote:
> On (26/09/25 13:27), Michal Wilczynski wrote:
> [..]
>> -static FORCE_INLINE int LZ4_decompress_generic(
> [..]
>> -			/* Necessarily EOF when !partialDecoding.
>> -			 * When partialDecoding, it is EOF if we've either
>> -			 * filled the output buffer or
>> -			 * can't proceed with reading an offset for following match.
>> -			 */
>> -			if (!partialDecoding || (cpy == oend) || (ip >= (iend - 2)))
>> -				break;
> 
> Worth noting, these lines are downstream commit eafc0a02391b
> (lz4: fix LZ4_decompress_safe_partial read out of bound).
> 
> Is this intended or are we "loosing" some of the downstream fixes?
> 

Yeah it's intended, eafc0a02391b was itself a backport of upstream
c5d6f8a8be39  which is in v1.9.3 and later; its own commit message links
it. The same check is at lib/lz4/upstream/lz4.c in this series.

And upstream's version also clamps a literal run that would read past
the end of the input, which the backport didn't take.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
