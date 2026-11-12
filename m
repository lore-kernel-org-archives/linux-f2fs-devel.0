Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E24606A889
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gO8n7A2z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Acnu1vdC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G7OgjTwc;
	dkim=neutral header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=nR+r+VBD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:In-Reply-To:From:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ni6eUGC0xd2FtJoBJSIDqOEuaWLj5PVOpEbDyR7m3LI=; b=gO8n7A2ziJH9E4ZkrfzevYbRcB
	ZNA4dVQPMumCyXAjgGzVHw0lyoWQKSzdd3sgB8kaZ3EVQM7FhMVGbX659JKrNRdu5gZevbNFlv5Vt
	J15NupDaITD8BxStiQgfbGNcJjBrce3qDvkQuEbM/h8XMDs8HZM9iWk/92dhai5egifI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRTa1-000000006Th-1jkm;
	Thu, 12 Nov 2026 12:07:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <m.wilczynski@samsung.com>) id 1xRTZz-000000006TQ-1wgm
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 12:06:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Ng2wYSW6+d3+F9nDyhML8DvJgaVLNMXoO8xfsPtTcI=; b=Acnu1vdCWdsFAI52c4g9J1E3FS
 V6Te408IrapLPs84SQjKazYPx9tXjtgp9PmkhMU5WuT8JEIJo9fynEE+SdJrn23t+WLqSS4gxNcbc
 uoIJcadOAFZsRRLa2+h3Fx65EFmGPsahwKotd9ZmOtSF7sk0aiyNJep9tHDa0sucsi/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Ng2wYSW6+d3+F9nDyhML8DvJgaVLNMXoO8xfsPtTcI=; b=G7OgjTwckb+9XSbH3KSeK2Qtut
 KTvmVt5ugaTggkhb6Pz2RCyaqQOlG2crSXv+FOfL4Ki+jtPjATIhS9iFGCmZIzBaNfNyWA0tG56+y
 eDxWEBnKyMIIAP8NgN9t7EQ5waWBTVvhWZco9yPhRqDZvr+LmO1dTw2gV1ysw7hjdgQU=;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRTZx-000000007jh-1V8g
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 12:06:59 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261112120650euoutp023394506fcbdf2a5d3fc56ab466d5f422~nSsqNDOqh0675106751euoutp02X;
 Thu, 12 Nov 2026 12:06:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261112120650euoutp023394506fcbdf2a5d3fc56ab466d5f422~nSsqNDOqh0675106751euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1794485210;
 bh=3Ng2wYSW6+d3+F9nDyhML8DvJgaVLNMXoO8xfsPtTcI=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=nR+r+VBDOV4dVPVZ6tVQVAV+2ufcN1J8T2VQozNQKBTjeh1k71ccWpdHsHNgI8C7r
 CM7J2sePfPZZOiXnXMfytIDh2ES0EF9kB9rcJXE5tsaTcDudkOHHpGSzUVEgKo5+QX
 Epi4ngn19K3aDJSY4rfpKYKsTXWEmx79MdJPM+6M=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261112120649eucas1p2065df671e614cc14e86e0a5504215744~nSspZAxiA2721327213eucas1p2v;
 Thu, 12 Nov 2026 12:06:49 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261112120647eusmtip1e71d40cb998922386d7f896a16ce37a9~nSsnwl8x91412914129eusmtip15;
 Thu, 12 Nov 2026 12:06:47 +0000 (GMT)
Message-ID: <450cbb3b-6118-4b1d-9a71-7f0ea98030ed@samsung.com>
Date: Thu, 12 Nov 2026 13:06:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <avKtyCOOmK3AH0xy@google.com>
X-CMS-MailID: 20261112120649eucas1p2065df671e614cc14e86e0a5504215744
X-Msg-Generator: CA
X-RootMTR: 20261106144310eucas1p1d60fe5c2e0170c49f38a3142bb1d8f94
X-EPHeader: CA
X-CMS-RootMailID: 20261106144310eucas1p1d60fe5c2e0170c49f38a3142bb1d8f94
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144310eucas1p1d60fe5c2e0170c49f38a3142bb1d8f94@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-13-ee04c3f0d7dc@samsung.com>
 <avKtyCOOmK3AH0xy@google.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRTZx-000000007jh-1V8g
Subject: Re: [f2fs-dev] [PATCH v2 13/15] lib/lz4: switch the decompressor to
 the vendored sources
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
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
 linux-f2fs-devel@lists.sourceforge.net, Minchan Kim <minchan@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org,
 David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/26 06:39, Sergey Senozhatsky wrote:
> On (26/11/06 15:42), Michal Wilczynski wrote:
> [..]
>> diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
>> index 50265e3ce256490994cb6dae32a45da376e408e0..b9b8a5f678c155442fa3fd2c1984e45182e6fc38 100644
>> --- a/drivers/block/zram/backend_lz4.c
>> +++ b/drivers/block/zram/backend_lz4.c
>> @@ -84,7 +84,7 @@ static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>>  		if (!zctx->mem)
>>  			goto error;
>>  	} else {
>> -		zctx->dstrm = kzalloc_obj(*zctx->dstrm);
>> +		zctx->dstrm = kzalloc(LZ4_MEM_DECOMPRESS, GFP_KERNEL);
>>  		if (!zctx->dstrm)
>>  			goto error;
>>  
>> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
>> index e7ee3740219852f079d1e0866da6b213a3f3a583..1e09c93016264259c149e2913b2819571b56fab6 100644
>> --- a/drivers/block/zram/backend_lz4hc.c
>> +++ b/drivers/block/zram/backend_lz4hc.c
>> @@ -65,7 +65,7 @@ static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>>  		if (!zctx->mem)
>>  			goto error;
>>  	} else {
>> -		zctx->dstrm = kzalloc_obj(*zctx->dstrm);
>> +		zctx->dstrm = kzalloc(LZ4_MEM_DECOMPRESS, GFP_KERNEL);
>>  		if (!zctx->dstrm)
>>  			goto error;
> 
> Ditto, outdated zram code.
> 
> My ask would be to not squash zram changes with lz4 changes, when (iff)
> possible.
> 

Will do.
The zram changes will go into a separate zram patch ahead of the lib/lz4
ones.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
