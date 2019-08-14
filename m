Return-Path: <SRS0=U0XC=WK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B639C32750
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Aug 2019 01:53:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EC82067D;
	Wed, 14 Aug 2019 01:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="S3nclMLb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WqLbTo5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EC82067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hxiTh-0006VU-L6; Wed, 14 Aug 2019 01:53:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hxiTg-0006VF-82
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Aug 2019 01:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jBzDy1Po0hxz7xaXe9m+pEaSOEia9tTmkpfp0hux2Pc=; b=S3nclMLbKICssnDuf/Qjsd1n82
 Jbc8EroRTlvedt07fddRx1IjYKV7GGey1YXvyctTwQCoyty7Kuko7B5eAQM4UmngsJ4ikKTlmUWLT
 e6LwR47nOWSghO4iIMZ6R8wI1JJuFKvFpW3ml8LXcSvJBEEKIsaJwSHpSajUaHPAYJps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jBzDy1Po0hxz7xaXe9m+pEaSOEia9tTmkpfp0hux2Pc=; b=WqLbTo5qATl9YQ59udmx03umfx
 2PuakpVsBhnlKrEgnIQdbmIWmuruuhCtaXyOXFWyZFlvX702oKmNtYmAbB8+kU6K4qOeYC2XGxddc
 iov8duxjKDuo/etX5nrZsQ5cFtL6EygcaIk8xfblJIDHT6p8/8kezKFNPLkqgKplW8o0=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hxiTe-003Qel-RQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Aug 2019 01:53:28 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DFD484420083B14B41DD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Aug 2019 09:53:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 14 Aug
 2019 09:53:16 +0800
From: Chao Yu <yuchao0@huawei.com>
To: Park Ju Hyung <qkrwngud825@gmail.com>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20190812225211.1737-1-qkrwngud825@gmail.com>
 <c5fbcb16-c7b2-988d-2110-8ce53a6137f6@huawei.com>
Message-ID: <eff187a3-27a8-f5d1-c667-26f9e7b384d8@huawei.com>
Date: Wed, 14 Aug 2019 09:53:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c5fbcb16-c7b2-988d-2110-8ce53a6137f6@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1hxiTe-003Qel-RQ
Subject: Re: [f2fs-dev] [PATCH 1/2] mkfs.f2fs: add "zip" to cold data types
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

On 2019/8/14 9:47, Chao Yu wrote:
> Hi Ju Hyung,
> 
> On 2019/8/13 6:52, Park Ju Hyung wrote:
>> A lot of Linux users have big, cold "zip" files.
> 
> In android, as I see, most zip file is small-sized log type, and will be removed
> after a roll-back, such as:
> 
> time1: create log1.zip
> time2: create log2.zip
> time3: create log3.zip
> time4: remove log1.zip, rename log2.zip -> log1.zip; rename log3.zip ->
> log2.zip; create log3.zip
> 
> I suggest we can keep zip type in android as warm type with IPU mode to avoid
> fragmentation caused by small holes in cold area. In linux distro, I agreed to
> treat zip as cold type.
> 
> So what about configuring zip type in f2fs_init_configuration() under '#ifndef

It seems it doesn't have to configure this in f2fs_init_configuration(), just
adding #ifndef WITH_ANDROID will be fine.

> WITH_ANDROID'?
> 
> What do you think?
> 
> Thanks,
> 
>>
>> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
>> ---
>>  mkfs/f2fs_format.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index 9402619..37d82c3 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -66,6 +66,7 @@ const char *media_ext_lists[] = {
>>  	"webp",
>>  
>>  	/* archives */
>> +	"zip",
>>  	"jar",
>>  	"deb",
>>  	"iso",
>>
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
