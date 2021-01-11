Return-Path: <SRS0=V0x5=GO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCCEC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Jan 2021 11:46:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C40622510;
	Mon, 11 Jan 2021 11:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C40622510
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kyveR-0008F4-If; Mon, 11 Jan 2021 11:46:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kyveP-0008Eq-K1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jan 2021 11:46:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:References:CC:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K+M5psITX6jYjPY16h2py/mfK3EhSXtM3h6fi9yjqkg=; b=GsxRN9COdwLcFdnlgkAWB96nCM
 LsXKTCsoTkskeobf41r2+KdxF9tiUZvu8vjNZ/sGKiHQt8YH6miKBr0KjYXA05rhXy3q64OICZr6S
 BTXFBYNIdUeUhaTjw419tlKruRoau5VV28vVOaUP8tNRL6UHVmLnSltvuVPFhTzsoGGU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:References:CC:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K+M5psITX6jYjPY16h2py/mfK3EhSXtM3h6fi9yjqkg=; b=ezXrmulNwZ+R99Bjf64q4pz8mH
 Tvd14rPcdRXmD4rhy1tMxMHyPCEAaMeawIHUlfmQzai+7vKO6VD8f7N9vQowt+wedrqwiYki3W77t
 YsG3/SKxDdd2KL/q24D8de6YzI39Bjwv8yvNCpPp9Q4Ht8reGUxMWG7WX9+KRum4B3d0=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kyveC-000yf1-So
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jan 2021 11:46:21 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DDsMG5Q4Vzj61M;
 Mon, 11 Jan 2021 19:44:58 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 11 Jan
 2021 19:45:53 +0800
From: Chao Yu <yuchao0@huawei.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210107093126.116958-1-yuchao0@huawei.com>
 <X/we0NoUqAwuW82+@google.com>
 <6b0060b9-460a-617a-3778-e67f35d551f0@huawei.com>
Message-ID: <cdd681ad-462d-cb37-2b4b-8f9d547bc718@huawei.com>
Date: Mon, 11 Jan 2021 19:45:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6b0060b9-460a-617a-3778-e67f35d551f0@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kyveC-000yf1-So
Subject: Re: [f2fs-dev] [PATCH v3 1/5] f2fs: compress: add compress_inode to
 cache compressed blocks
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/1/11 18:31, Chao Yu wrote:
> On 2021/1/11 17:48, Jaegeuk Kim wrote:
>> Hi Chao,
>>
>> After quick test of fsstress w/ fault injection, it gave wrong block address
>> errors. Could you please run the test a bit?
> 
> Jaegeuk,
> 
> Oh, I've covered with fstest cases and there is no such error message, let me
> try fault injection + SPO case soon.

Till now, I haven't see any problem... will let the test run for longer time in
this night.

Could you share me detailed error message you encounter?

Thanks,

> 
> Thanks,
> 
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
