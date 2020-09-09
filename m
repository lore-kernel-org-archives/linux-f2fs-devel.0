Return-Path: <SRS0=fJIO=CS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94428C43461
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:14:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1D121D79;
	Wed,  9 Sep 2020 07:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="f+8LN/nB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cyTD4AMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1D121D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kFuJ1-0003W7-UV; Wed, 09 Sep 2020 07:14:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kFuJ0-0003W0-L4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Sep 2020 07:14:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GpTVH89pcbIX2ymuU/NiXMwgTwU76tW1R6QRyA+aguo=; b=f+8LN/nBF5QFeWliR+ws0f7R8P
 eF7KVM13QC0cPnQwR+cVhYQEPr50E83cNUlQSESCHubljo+Ouxs/WVP5MzDHEeyZEqUPdcZzg0GBR
 K3RLmrhNT06YfYLcZpJMwp+FUinM93xN4wPYcUlosf2F2HBIQjrS5L0s4noIgRlITuKc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GpTVH89pcbIX2ymuU/NiXMwgTwU76tW1R6QRyA+aguo=; b=cyTD4AMjTEr/W0h/c1maGOM9vS
 8XMukMTJJfzgYBFVJMTf/9wClDgl/bWvQlUaKLherUjMt4to2jDLoQ5hoGAqTty2ayCIYNoVqvWq/
 SM+c+iuSkVXZ+mgTe7sXswSWvgRFjYXTU2AFIh9ga07iGc6KSIE6gbfiPALJHu2A9StY=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kFuIv-000DoS-4Z
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Sep 2020 07:14:10 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5E817F02400258A90C6E;
 Wed,  9 Sep 2020 15:13:46 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Sep 2020
 15:13:45 +0800
To: Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <CACOAw_wHONVJL438_Akvo3wZewJeVKiT_8LqW0EXULxAscpGjA@mail.gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <220b1cb4-9c2e-c9db-5590-6dcd43b9aaed@huawei.com>
Date: Wed, 9 Sep 2020 15:13:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_wHONVJL438_Akvo3wZewJeVKiT_8LqW0EXULxAscpGjA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kFuIv-000DoS-4Z
Subject: Re: [f2fs-dev] Question about STEP_DECOMPRESS_NOWQ
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

On 2020/9/9 12:43, Daeho Jeong wrote:
> Hi Chao,
> 
> I have a question about the below flag for decompression.
> 
> STEP_DECOMPRESS_NOWQ,           /* handle normal cluster data inplace */
> 
> According to the comment, you added this for using inplace

I added this for the condition that: in compressed inode, partial clusters are
written as normal (non-compressed) one due to bad compress ratio, during reading
data in normal cluster, we don't need to queue them in workqueue, instead, we
can just handle them in IRQ context (end_io()).

That says, if all pages in bio are non-compressed, we tag step w/ STEP_DECOMPRESS_NOWQ,
once there is at least one page is compressed, we change step to
STEP_DECOMPRESS.

> decompression but inplace decompression mode is not being activated

'inplace decompression' means decompress in
a. reader thread or
b. IRQ context ?

Thanks

> now, since we are setting STEP_DECOMPRESS right after bio_add_page().
> 
>                  if (bio_add_page(bio, page, blocksize, 0) < blocksize)
>                          goto submit_and_realloc;
> 
>                  /* tag STEP_DECOMPRESS to handle IO in wq */
>                  ctx = bio->bi_private;
>                  if (!(ctx->enabled_steps & (1 << STEP_DECOMPRESS)))
>                          ctx->enabled_steps |= 1 << STEP_DECOMPRESS;
> 
> Did you mean to deactivate inplace decompression mode on purpose,
> since it had an issue? I am a little bit confused about this.
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
