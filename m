Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE44C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Dec 2023 03:28:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r9zdC-00042j-Ta;
	Mon, 04 Dec 2023 03:28:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hsiangkao@linux.alibaba.com>) id 1r9zdB-00042d-Aa
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 03:28:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ltfr1lZEbQgPJHr0/T7QgA7mE1cSBuRmQ3j17DfEgJo=; b=TgjJQ00knrXNTLzJas45P+ZX0W
 dhv3rpwDYYVxNhpGtlYAupGpmrQ7rCJzI2QqdGf2jnt2dQ2idFSl/2+4AC6b77T/YWalcgODFiV4B
 Xja8DLn9pC/+wJ5upXsX5/yWY/X7hPqyOz3MQev1r0wnzIHwjR11jAiO+8AI/hoOyUjQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ltfr1lZEbQgPJHr0/T7QgA7mE1cSBuRmQ3j17DfEgJo=; b=MT7yT2AGYRnEP8/wCohGEYFMm7
 sElHiuxoFe2vslc3GaN0imAozA90X3IuE8vRWiXBsozf+X6V17KYl+pNuVTlioXu7sfF9CIvhX4Be
 gXY3BYS2dCr5WxwQAuAdNZIt41WHi+a1VUdLkHIGCO0Bz+xdUQUXjC/tyx/4ECYTh6NI=;
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r9zd4-0003rK-PH for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 03:28:22 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0Vxhh90d_1701660484; 
Received: from 30.97.49.36(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Vxhh90d_1701660484) by smtp.aliyun-inc.com;
 Mon, 04 Dec 2023 11:28:05 +0800
Message-ID: <275f025d-e2f1-eaff-6af1-e909d370cee0@linux.alibaba.com>
Date: Mon, 4 Dec 2023 11:28:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
To: Juhyung Park <qkrwngud825@gmail.com>
References: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
 <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com>
 <CAD14+f2G-buxTaWgb23DYW-HSd1sch6tJNKV2strt=toASZXQQ@mail.gmail.com>
 <649a3bc4-58bb-1dc8-85fb-a56e47b3d5c9@linux.alibaba.com>
 <CAD14+f1u6gnHLhGSoQxL9wLq9vDYse+Ac8zxep-O2E8hHreT2w@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAD14+f1u6gnHLhGSoQxL9wLq9vDYse+Ac8zxep-O2E8hHreT2w@mail.gmail.com>
X-Headers-End: 1r9zd4-0003rK-PH
Subject: Re: [f2fs-dev] Weird EROFS data corruption
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
Cc: Yann Collet <yann.collet.73@gmail.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 2023/12/4 01:32, Juhyung Park wrote:
> Hi Gao,

...

>>>
>>>>
>>>> What is the difference between these two machines? just different CPU or
>>>> they have some other difference like different compliers?
>>>
>>> I fully and exclusively control both devices, and the setup is almost the same.
>>> Same Ubuntu version, kernel/compiler version.
>>>
>>> But as I said, on my laptop, the issue happens on kernels that someone
>>> else (Canonical) built, so I don't think it matters.
>>
>> The only thing I could say is that the kernel side has optimized
>> inplace decompression compared to fuse so that it will reuse the
>> same buffer for decompression but with a safe margin (according to
>> the current lz4 decompression implementation).  It shouldn't behave
>> different just due to different CPUs.  Let me find more clues
>> later, also maybe we should introduce a way for users to turn off
>> this if needed.
> 
> Cool :)
> 
> I'm comfortable changing and building my own custom kernel for this
> specific laptop. Feel free to ask me to try out some patches.

Thanks, I need to narrow down this issue:

-  First, could you apply the following diff to test if it's still
    reproducable?

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 021be5feb1bc..40a306628e1a 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -131,7 +131,7 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,

  	if (rq->inplace_io) {
  		omargin = PAGE_ALIGN(ctx->oend) - ctx->oend;
-		if (rq->partial_decoding || !may_inplace ||
+		if (1 || rq->partial_decoding || !may_inplace ||
  		    omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
  			goto docopy;

- Could you share the full message about the output of `lscpu`?

Thanks,
Gao Xiang


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
