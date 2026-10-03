Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F27CA5FDD
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 23:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:In-Reply-To:From:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m9dgHy6jD+n+LeZdhiveoZVql0RjzD3JBSPKo+FqK6w=; b=CYDqL6DUcSPXbYctlo+TwK36r+
	jwxIt++w8luM8G45PTYcESDw8id56BGTszuMygyj3t0f8nktVi2IUsJ+C83MjYlkUd7MpO/a2Vr0+
	2FFJOYcgh1Sw3FymupW6F2PY+XfSJR39bZsAh7oneAPtCyICWatvWR4S7QpGGSJxa5RY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xD9Wt-0004ri-5V;
	Sat, 03 Oct 2026 23:52:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xD9Wr-0004rb-3p
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 23:52:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YeQG0aX9+npnHOTaEcmH5NapglKt88z5G6eNYrYY23s=; b=Z35Ik/hIBqgDAAy0SP9piFTXa8
 ZBwNIe8SkYi0VCe7+FqGsCcfqQu7kZz4hvXuQze5ItA6zzV8CGNCqv5G43PXrJaT/jBeRqPrwzc1c
 c+AXlxFIRlhC9Vsu8e+QR/AiFV65E7xpuufdbjiFwCqblYPw+zE9LX9B21y6HE388rzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YeQG0aX9+npnHOTaEcmH5NapglKt88z5G6eNYrYY23s=; b=grM7KaDB13Vluiq9pNapRQi3Gz
 bFNWfLbas6gS6oj5RVXGkqcdUv+sO8DEeleqDfqZ5iKLXDI5/RL9TrDsMWHK+wY4DBMYpj9TNBstd
 CDx6UrcqAq83x53ylFyI6SibMzE4+FHGM/1BQqPd05eL4Uvv7VaFLWQH3YsmohUa2tfg=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD9Wn-0000hN-Th for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 23:52:30 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261003235223euoutp015f6ea317b7d01367963d56f0330b92c0~bKhRbuz8P1130611306euoutp01G;
 Sat,  3 Oct 2026 23:52:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261003235223euoutp015f6ea317b7d01367963d56f0330b92c0~bKhRbuz8P1130611306euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791071543;
 bh=YeQG0aX9+npnHOTaEcmH5NapglKt88z5G6eNYrYY23s=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=jDX+SDoPeqthUbyezzmLfesvArpjYDdQ4hJeBkfnkqoS34/xmNDT1vDXi0Aa4KDGp
 B1WE786E3+ww5NxOcqsxNS41E3neVhoX3HlbfJiHz3MCsh2ZIeBpoGDHWMKEorIE1G
 sTeUWeJvYHBG/84vAj6zcIQLBKS8ZZfwYDdcLoZY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261003235222eucas1p242b448a9a62dbc7c349b9311eb8f9076~bKhQnPtml0031100311eucas1p2q;
 Sat,  3 Oct 2026 23:52:22 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261003235220eusmtip1b9a9db4570335d897d7c2b7512376bca~bKhOxuwOT1826618266eusmtip18;
 Sat,  3 Oct 2026 23:52:20 +0000 (GMT)
Message-ID: <b0df8c61-0feb-40cb-8bb9-5d4874309944@samsung.com>
Date: Sun, 4 Oct 2026 01:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aryehUJml8fTy0o-@google.com>
X-CMS-MailID: 20261003235222eucas1p242b448a9a62dbc7c349b9311eb8f9076
X-Msg-Generator: CA
X-RootMTR: 20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a
X-EPHeader: CA
X-CMS-RootMailID: 20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
 <aryehUJml8fTy0o-@google.com>
X-Headers-End: 1xD9Wn-0000hN-Th
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



On 9/30/26 08:07, Sergey Senozhatsky wrote:
> On (26/09/25 13:27), Michal Wilczynski wrote:
> [..]
> 
>> +void LZ4_resetStream_fast(LZ4_stream_t* ctx) {
>> +    LZ4_prepareTable(&(ctx->internal_donotuse), 0, byU32);
>> +}
> 
> [..]
> 
>> +void LZ4_attach_dictionary(LZ4_stream_t* workingStream, const LZ4_stream_t* dictionaryStream)
>> +{
>> +    const LZ4_stream_t_internal* dictCtx = (dictionaryStream == NULL) ? NULL :
>> +        &(dictionaryStream->internal_donotuse);
>> +
>> +    DEBUGLOG(4, "LZ4_attach_dictionary (%p, %p, size %u)",
>> +             workingStream, dictionaryStream,
>> +             dictCtx != NULL ? dictCtx->dictSize : 0);
>> +
>> +    if (dictCtx != NULL) {
>> +        /* If the current offset is zero, we will never look in the
>> +         * external dictionary context, since there is no value a table
>> +         * entry can take that indicate a miss. In that case, we need
>> +         * to bump the offset to something non-zero.
>> +         */
>> +        if (workingStream->internal_donotuse.currentOffset == 0) {
>> +            workingStream->internal_donotuse.currentOffset = 64 KB;
>> +        }
>> +
>> +        /* Don't actually attach an empty dictionary.
>> +         */
>> +        if (dictCtx->dictSize == 0) {
>> +            dictCtx = NULL;
>> +        }
>> +    }
>> +    workingStream->internal_donotuse.dictCtx = dictCtx;
>> +}
> 
> Just a side note,
> there is a bunch of new helpful API added in this release.  Currently,
> we do some memcpy hacks to avoid re-init of lz4 C/D-dict in zram, but
> once this series lands I'll be happy to send some trivial EXPORT_SYMBOL
> patches so that zram (and other lz4 users) can use standard lz4 dict
> API instead of hacks.
> 

Sounds great, thank you !

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
