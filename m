Return-Path: <SRS0=cknU=57=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60062C2BA2B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:15:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AF3206F9;
	Wed, 15 Apr 2020 07:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Pza3GEDC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ebwtJF8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AF3206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jOcGg-0004mv-6Z; Wed, 15 Apr 2020 07:15:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jOcGe-0004mn-Qm
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Apr 2020 07:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DseiJMvzr8BmRtZ280O4khRQ8+CmpZSjUdaXR8TO8Ak=; b=Pza3GEDCWsEGHydRh3AzGj0YHl
 jD+dDukb5OkH/8JeTz9Ie2q+09ZWcbPwdIv74EQ5hI5t8DpolMpcitfXNqCcjXqxxkfLN6n8/2EPZ
 daDp78yzEeaMC2VlOZDoSBy+MmZCvesPWQtlLIkmwAavE+y+AFdcVa174Gxh9rr6twYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DseiJMvzr8BmRtZ280O4khRQ8+CmpZSjUdaXR8TO8Ak=; b=ebwtJF8vffBRJ7GkY5aIEr+P7/
 liGLZQ87mKquVq4IU0TDi9IMKNc5+iuV4m0cPsLNNr1q3azzUQgRS8dFMjm2T+jcP6ckjdWWmAQ3b
 C5SumMWy3F00JyZZWTwGSXXhqeO3E8+JhFBv6Go7uZ3puHy6OqYozd/d2lget40kjR6s=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jOcGZ-001s7b-SA
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Apr 2020 07:15:28 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EF9D0294396DEF9D0493
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Apr 2020 15:15:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 15 Apr
 2020 15:15:10 +0800
To: Tim Walker <timtwalker@outlook.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
References: <BN6PR02MB3379134F5821A8D6995E3084DEDA0@BN6PR02MB3379.namprd02.prod.outlook.com>
 <c81b3ef8-1266-829e-5276-a11e167810c7@huawei.com>
 <BN6PR02MB3379ACB0F0777D5D932EF641DEDB0@BN6PR02MB3379.namprd02.prod.outlook.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <cf8dd5fb-17a8-f6a0-ad54-e70c50a8eff5@huawei.com>
Date: Wed, 15 Apr 2020 15:15:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BN6PR02MB3379ACB0F0777D5D932EF641DEDB0@BN6PR02MB3379.namprd02.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jOcGZ-001s7b-SA
Subject: Re: [f2fs-dev] [question] ZBC/ZAC Offline/read-only zone support
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

Hi Tim,

On 2020/4/15 10:54, Tim Walker wrote:
>> Hi Chao Yu-
> 
> Yes the zones can have different status, according to the spec. I don't know how many drive manufactures use those zone states - if any. I was only asking to see if I had missed Offline or Read_Only zone support when I examined the f2fs source code. I was interested in the implementation details if support had been included. Thanks!

Unfortunately, that support on f2fs has not been done yet.

Thanks,

> 
> Best regards,
> -Tim Walker
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
