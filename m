Return-Path: <SRS0=zE18=AR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A2C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:30:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB1D2075B;
	Mon,  6 Jul 2020 07:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="N7wK9UL8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WutyXEtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB1D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jsLZt-00032Q-UE; Mon, 06 Jul 2020 07:30:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jsLZt-00032F-3h
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jul 2020 07:30:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wMtdDzjllpvOmR4DGpyJ/7Zzx0BNChMOSCoV9po8IzY=; b=N7wK9UL8l5FD/9dqHofEJIxCtB
 UNWo59p0r6Wbs3/M4LC2DvEzSq10cPwP0AVZWNP+LFdvwLa/lpb3ocUTZqdta/u29KV2cxGMSTb6a
 JZaPODmSrZWRiOHRyNNzqyCUYdcRn8KIhsKqmFQuMV8hEqOZ8tjXlMVd6J0U7YmzZHyw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wMtdDzjllpvOmR4DGpyJ/7Zzx0BNChMOSCoV9po8IzY=; b=WutyXEtvtZhHFWKIf92wkIBLqT
 7BmLYoRXnK2JlaCXy7HQSaP2xEas3zTO2r4Z7Yk/qSLM4YUwiD9O1FzOhizbXBDGH4Nh5Ch6DUy9V
 F+6xbuVZZRG7vRQ2KjVIvIA0iux8W2u2h27Jh4wUHJCNzuNBazsI0J57/bNizIisiKDQ=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jsLZo-00EkvF-MW
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jul 2020 07:30:13 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 833A7E33D0076DB66370;
 Mon,  6 Jul 2020 15:29:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 6 Jul 2020
 15:29:40 +0800
To: lampahome <pahome.chen@mirlab.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <CAB3eZfvyo4OzN_odXsnvDO6E=YHTt4qe5CXqQUyG7Mrk+MhzaQ@mail.gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <0ea89e42-8ea7-5557-8717-26d2e6965104@huawei.com>
Date: Mon, 6 Jul 2020 15:29:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAB3eZfvyo4OzN_odXsnvDO6E=YHTt4qe5CXqQUyG7Mrk+MhzaQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jsLZo-00EkvF-MW
Subject: Re: [f2fs-dev] Can I know if now is gc-ing or checkpointing?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/7/6 15:10, lampahome wrote:
> I tried to test  performance with f2fs and create many fio to test it.
> 
> I found when fio reach a number(e.g. 25 fio), the performance degrade
> not in proportional with small number
> 
> EX:
> 5 fio: bandwidth 300MB/s
> 10 fio: bandwidth 150MB/s
> 25 fio: bandwidth 30MB/s

What's your buffer size for each flush?

> 
> I wonder many trigger the gc or checkpoint, may I know if it running
> foreground or background?

cat /sys/kernel/debug/f2fs/status |grep CP

and

cat /sys/kernel/debug/f2fs/status |grep GC

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
