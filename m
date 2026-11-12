Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F33606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SLhCznZW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ea9GvCIM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Tr1Q4MIg;
	dkim=neutral header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=bCSMFy5h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:In-Reply-To:From:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=qCu24XNtGTtWsgVgmM1ebsaltnYssBbM2fOUX0+7ttk=; b=SLhCznZWTb1y5k7PQsPkC2mbkA
	W2a6xjUOgpUfzmD81Uzb7w/icbdh8qUHBW5pmkmsBYYBI+k16iawDRlHbQ5fbtAsIPwdTBC83y1kx
	SOeWNtaCSWajXD7KrFbe4TTdQXuUsWg+uKrI9A3HkbPWPJRkyt71rZx6sqLcUmQ8YcKQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRTWH-00000000568-1XpI;
	Thu, 12 Nov 2026 12:03:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <m.wilczynski@samsung.com>) id 1xRTWF-00000000560-0GP2
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 12:03:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xw7r6iF+zO8fXkdzLRufgVhinglmDPnuGGdycV+HHa4=; b=Ea9GvCIModw0C5l4VE3oT3Neo9
 JrrisExnyj0j9VTwL0GGKI7SeNpg5iNFl4MPLyKMspP6GupgxyhDZEfGuumuspLbsdWm04SCgZJfs
 zJL6GY436NRM2G9tCXpp43u5m/1PZX4yygOVNzuUt10qy7ztRUMYb5rQpjwsKeIiv2HE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xw7r6iF+zO8fXkdzLRufgVhinglmDPnuGGdycV+HHa4=; b=Tr1Q4MIgS1QRyM8N8JOdZ+MhrU
 0A6/tUlg9u4lT1wUTl7EcqIIBrwcgp88HYZlrZwCkipzssw6lKTkyDuOCeQFjNRBekTVeKV0TThpR
 HA9fQJIUJ6wPIqbOHDX81ayCqkZ9pwDmmqiHjEupw5tzSWltgnVOJwGk5j3R7OJn4dk8=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRTWD-000000003vh-0Q2R
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 12:03:06 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261112120258euoutp01964489faf544bdddd3f3211e2255de7c~nSpSE0Td51139111391euoutp01a;
 Thu, 12 Nov 2026 12:02:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261112120258euoutp01964489faf544bdddd3f3211e2255de7c~nSpSE0Td51139111391euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1794484978;
 bh=Xw7r6iF+zO8fXkdzLRufgVhinglmDPnuGGdycV+HHa4=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=bCSMFy5h9WR5MXhQfr/yYMe50oNl4ZJ3B9PhLvn3AfoVJ3Uyo+MSQBjlm9BDOqF/s
 YI8qgTWpK/VpOR25WqLm1BIOQY430YCMn2hX6owWJ0ZuGG39vX4A1Pt/J8PKIj6edQ
 41nNcZwJxZucP719/0INyVtl5uX7gSp1npjbR8yk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261112120258eucas1p1c5cb56175a355c1eae521563b7e5958f~nSpR05hFs2595725957eucas1p1w;
 Thu, 12 Nov 2026 12:02:58 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261112120256eusmtip247d84ecda0f477bf594f640a7999ebf7~nSpQMIK460511505115eusmtip2L;
 Thu, 12 Nov 2026 12:02:56 +0000 (GMT)
Message-ID: <46236db8-c386-4db6-a8cd-e08073a5db0a@samsung.com>
Date: Thu, 12 Nov 2026 13:02:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <avKs4_S7r6EiUVgC@google.com>
X-CMS-MailID: 20261112120258eucas1p1c5cb56175a355c1eae521563b7e5958f
X-Msg-Generator: CA
X-RootMTR: 20261106144305eucas1p17b3b27d403dc7d13b85cdd9a4bea83b9
X-EPHeader: CA
X-CMS-RootMailID: 20261106144305eucas1p17b3b27d403dc7d13b85cdd9a4bea83b9
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144305eucas1p17b3b27d403dc7d13b85cdd9a4bea83b9@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-10-ee04c3f0d7dc@samsung.com>
 <avKs4_S7r6EiUVgC@google.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRTWD-000000003vh-0Q2R
Subject: Re: [f2fs-dev] [PATCH v2 10/15] lib/lz4: switch the compressor to
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



On 11/10/26 06:36, Sergey Senozhatsky wrote:
> On (26/11/06 15:42), Michal Wilczynski wrote:
> [..]
>> diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
>> index 1e4ad31d39a63f45b3bddd3d8a467d8d7d095beb..50265e3ce256490994cb6dae32a45da376e408e0 100644
>> --- a/drivers/block/zram/backend_lz4.c
>> +++ b/drivers/block/zram/backend_lz4.c
>> @@ -42,7 +42,7 @@ static int lz4_setup_params(struct zcomp_params *params)
>>  	if (!params->dict || !params->dict_sz)
>>  		return 0;
>>  
>> -	dict_stream = kzalloc_obj(*dict_stream);
>> +	dict_stream = kzalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);
>>  	if (!dict_stream)
>>  		return -ENOMEM;
>>  
>> @@ -88,7 +88,7 @@ static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>>  		if (!zctx->dstrm)
>>  			goto error;
>>  
>> -		zctx->cstrm = kzalloc_obj(*zctx->cstrm);
>> +		zctx->cstrm = kzalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);
>>  		if (!zctx->cstrm)
>>  			goto error;
>>  	}
>> @@ -112,7 +112,7 @@ static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
>>  					zctx->mem);
>>  	} else {
>>  		/* Cstrm needs to be reset */
>> -		memcpy(zctx->cstrm, params->drv_data, sizeof(*zctx->cstrm));
>> +		memcpy(zctx->cstrm, params->drv_data, LZ4_MEM_COMPRESS);
>>  		ret = LZ4_compress_fast_continue(zctx->cstrm, req->src,
>>  						 req->dst, req->src_len,
>>  						 req->dst_len, params->level);
> 
> The zram code here is outdated, it has been reworked quite a bit
> (patches are in linux-next and Andrew's trees).
> 

Right, I'll rebase on linux-next.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
