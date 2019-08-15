Return-Path: <SRS0=5qoe=WL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1614C32753
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Aug 2019 03:04:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6A92084F;
	Thu, 15 Aug 2019 03:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="EA2zaqBR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="V2bjIrUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6A92084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hy63z-0007WB-Fv; Thu, 15 Aug 2019 03:04:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hy63y-0007W5-Di
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 15 Aug 2019 03:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GKZ32krMdZ1ax7iLCN+81iV5rYzIPM/kf4k7cM44qQg=; b=EA2zaqBRVJ2d0ujODMz4GLCHRG
 zBFO6b2UxmCgKt+TjZZdTyGyru/v/YPEB/bBi9GsmEnG8a7bZyx8SJamtlISk7WEIvcVdNygjkpMo
 FKXwam/r2ZEqjfBF14An3T3NCiF+4pSZuPDOd0r2vAyN8WOYF9RSBm65ilExblgx3WaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GKZ32krMdZ1ax7iLCN+81iV5rYzIPM/kf4k7cM44qQg=; b=V2bjIrUtZPsR1zioX0zh2SFE+d
 4HSvpbMjSOzdvPpb4t0qL7Bu0hQmOR+F9ibTpLUxMnW2WCHXCma0QXTWgCY/HUuQRxqHQ4OBEihJ+
 g8eLKPnIUPBkg61p0ZiY2oA9ZsqS10O8n7XUYcpYX8bTCoezTuBufetY3wRh17NL+s3k=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hy63u-0042Ev-U9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 15 Aug 2019 03:04:30 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B79CDAFF1B5CACDCA75A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Aug 2019 11:04:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 15 Aug
 2019 11:04:15 +0800
To: Ju Hyung Park <qkrwngud825@gmail.com>
References: <20190812225211.1737-1-qkrwngud825@gmail.com>
 <c5fbcb16-c7b2-988d-2110-8ce53a6137f6@huawei.com>
 <CAD14+f3bu8WqCE5jAqR968p=DvUqronR8QCg_EhgFD9x2PJQeA@mail.gmail.com>
 <aea1a700-7d31-9b39-8f30-b6acf1fd8a21@huawei.com>
 <CAD14+f0PkiuFkg04eGVJQkeeG+JjFdas6hWCc_FazGK5VQh0KA@mail.gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <a8f420d3-178b-9200-b4a6-cccf11c420db@huawei.com>
Date: Thu, 15 Aug 2019 11:04:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD14+f0PkiuFkg04eGVJQkeeG+JjFdas6hWCc_FazGK5VQh0KA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1hy63u-0042Ev-U9
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Ju Hyung,

On 2019/8/14 22:10, Ju Hyung Park wrote:
> Hi Chao,
> 
> /data/log isn't even here.
> I think it must be specific to EMUI.

Alright, at least in EMUI, it looks not proper to me to set cold flag on zip
file according to result of hot/cold separation investigation recently.

IMO, it will be more common to store large stable zip/rar file in Linux
desktop/server or Window OS...

Thanks,

> 
> Thanks.
> 
> On Wed, Aug 14, 2019 at 6:48 PM Chao Yu <yuchao0@huawei.com> wrote:
>>
>> Hi Ju Hyung,
>>
>> On 2019/8/14 17:20, Ju Hyung Park wrote:
>>> Hi Chao,
>>>
>>> On Wed, Aug 14, 2019 at 10:47 AM Chao Yu <yuchao0@huawei.com> wrote:
>>>> In android, as I see, most zip file is small-sized log type, and will be removed
>>>> after a roll-back, such as:
>>>>
>>>> time1: create log1.zip
>>>> time2: create log2.zip
>>>> time3: create log3.zip
>>>> time4: remove log1.zip, rename log2.zip -> log1.zip; rename log3.zip ->
>>>> log2.zip; create log3.zip
>>>>
>>>> I suggest we can keep zip type in android as warm type with IPU mode to avoid
>>>> fragmentation caused by small holes in cold area. In linux distro, I agreed to
>>>> treat zip as cold type.
>>>
>>> I actually thought your original suggestion of adding "zip" was to
>>> handle big zip files under /sdcard(/data/media).
>>>
>>> The one case you've mentioned will be entirely dependent on which apps
>>> user's using.
>>
>> Yeah, actually, now I didn't see much large zip file in my external storage,
>> most of them are xxxKB or xMB, some of them looks very old tho. :)
>>
>>> In case of mine, I don't have any zip files under /data that's
>>> seemingly used for logs.
>>
>> Huawei cell phone has log file with .zip/.gz type locating in /data/log/... can
>> you search that directory?
>>
>> If we relocate them into cold area, they will make holes in cold area crazily,
>> as they have small size and will be created/unlinked frequently.
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>> .
>>>
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
