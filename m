Return-Path: <SRS0=2T6g=FV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9F3C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Dec 2020 06:52:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6094723603
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Dec 2020 06:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6094723603
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kpn9J-0002WH-O5; Thu, 17 Dec 2020 06:52:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kpn9F-0002Vi-OL
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 06:52:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nc3x90GZMNF0Wa+RLLariRAkbmtSmPPxeqfmTZFPU2c=; b=mljjohKQkWZUxlt4J2Jm04uvsw
 OXn85w3AtYI2qkSFQu6w+M9rmCtix902/Prenqi29aW5zL9wFGBviiSbP594fEMIw+0+ZzAGStAiK
 BB3j8pOcmQZ0cJE5UPgJNiml6Kuvjewm6xAadI2GtbuMXrLuKDeI+6sHICkGaC3KfLFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Nc3x90GZMNF0Wa+RLLariRAkbmtSmPPxeqfmTZFPU2c=; b=mczqvIokGb3fdcWxSoD5CwRc1b
 XEw6+MK8kHdsNG/f9dnkqN8y7h625ERlqmBxYwGHDUmBwu3NSQC8qo+ptC/ddaGGZeUxbaB4izbDz
 93SY/uz5t9gUdarWx+AadWnZAd6LevQE510kWrEBOGcrbcA/h1n9WnLjx4ZiIv2lKR64=;
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kpn97-00HKou-F0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 06:52:25 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CxN2B4G3BzhrYm;
 Thu, 17 Dec 2020 14:51:30 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 17 Dec
 2020 14:51:57 +0800
To: Greg KH <gregkh@linuxfoundation.org>
References: <20201216091523.21411-1-yuchao0@huawei.com>
 <X9nXCdp1ssMHKdNI@kroah.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <a8291621-e472-5b00-d2b3-8d8016386e47@huawei.com>
Date: Thu, 17 Dec 2020 14:51:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X9nXCdp1ssMHKdNI@kroah.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kpn97-00HKou-F0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix out-of-repair __setattr_copy()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/12/16 17:44, Greg KH wrote:
> On Wed, Dec 16, 2020 at 05:15:23PM +0800, Chao Yu wrote:
>> __setattr_copy() was copied from setattr_copy() in fs/attr.c, there is
>> two missing patches doesn't cover this inner function, fix it.
>>
>> Commit 7fa294c8991c ("userns: Allow chown and setgid preservation")
>> Commit 23adbe12ef7d ("fs,userns: Change inode_capable to capable_wrt_inode_uidgid")
> 
> Are these lines supposed to be "Fixes:" instead of "Commit "?

IMO, the issue was introduced when f2fs module was added, and above two commits
missed to cover f2fs module... so I guess we can add Fixes line as below?

Fixes: fbfa2cc58d53 ("f2fs: add file operations")

Thanks,

> 
> thanks,
> 
> greg k-h
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
