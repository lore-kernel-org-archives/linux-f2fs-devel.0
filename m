Return-Path: <SRS0=2O7d=FO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F00C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 05:58:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C5723440
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 05:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C5723440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1knEyH-00068r-AW; Thu, 10 Dec 2020 05:58:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1knEyF-00068Y-B7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 05:58:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6hgFNgX640DCJf40O8hnWGf6VdkL7IqX6kPZsRCv0pc=; b=aFgrJ5/WzzEEnTHcEevoqjaEwW
 KONumreQkpUjYe2U+JX+0wSNYOBEmsz3l0upODlQ72lNyBs4rZMQtHGkwa6dn4S2f0yC5IJiIXrBH
 EuB65lTi6GhR8Qpb/A7fY6fAk0oUZYSlkSV/cQNi913K74Xgx/tL6Uc4Z7OtTzMBs8fY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6hgFNgX640DCJf40O8hnWGf6VdkL7IqX6kPZsRCv0pc=; b=A1CaHDNAEeWiDRMWY46MLIl64U
 Q6Cq2KsYV6uhxdgwYQPgkW3s+t+WGLVQPRPR2b5pwn0DwXWtAnGyCUR60HoXhHJLmCq3nL3vLmDtI
 yF/6SwL4NI73sLpw6FDX5pjXRO/VcliAGJBbfjtQdTvmxjAX9PO+eK7mGijS82ger/V4=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1knEy5-008bWm-2G
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 05:58:31 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cs38g229Rz15b2R;
 Thu, 10 Dec 2020 13:57:07 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 10 Dec
 2020 13:57:39 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
 <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
 <8d293b99-4414-1317-7426-79692bbaa715@gmail.com>
 <1215c353-3c3f-0a61-00a3-021f0c2f0032@huawei.com>
 <38c68ef8-4b9b-cfc1-d8ad-cfeb4c2de845@gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <e72ff237-9d9a-2dbe-6a31-65046db9ee64@huawei.com>
Date: Thu, 10 Dec 2020 13:57:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <38c68ef8-4b9b-cfc1-d8ad-cfeb4c2de845@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1knEy5-008bWm-2G
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix potential shift-out-of-bounds
 error in sanity_check_raw_super()
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
Cc: Anant Thazhemadam <anant.thazhemadam@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net,
 syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Jaegeuk,

Could you please help to add signed-off of Anant manually in

f2fs: fix shift-out-of-bounds in sanity_check_raw_super()

Thanks,

On 2020/12/10 10:14, Anant Thazhemadam wrote:
> 
> On 10/12/20 7:40 am, Chao Yu wrote:
>> On 2020/12/10 10:00, Anant Thazhemadam wrote:
>>>
>>> On 10/12/20 7:16 am, Chao Yu wrote:
>>>> Hi Anant,
>>>>
>>>> I've posted a patch a little earlier. :P
>>>>
>>>> https://lore.kernel.org/linux-f2fs-devel/20201209084936.31711-1-yuchao0@huawei.com/T/#u
>>>>
>>> Ah well, that's alright, especially considering that your patch looks better.
>>> Glad that bug has been fixed nonetheless. :)
>>
>> Anyway, thanks a lot for taking time to fix f2fs bug. :)
>>
>> I prefer to add your Signed-off-by into "f2fs: fix shift-out-of-bounds
>> in sanity_check_raw_super()" if you don't mind.
>>
>>
> 
> Sure, I'd appreciate that. Thank you! :D
> 
> Thanks,
> Anant
> 
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
