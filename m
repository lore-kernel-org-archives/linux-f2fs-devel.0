Return-Path: <SRS0=RqgG=FN=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9254DC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Dec 2020 06:30:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E1A23B7E;
	Wed,  9 Dec 2020 06:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E1A23B7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmszW-0005C9-Dr; Wed, 09 Dec 2020 06:30:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kmszO-0005BK-Jr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Dec 2020 06:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:References:CC:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3BclyRXM2geBeJKm545oR2ZA7lNUzhK2JenG/cQESfI=; b=cKxL45OKC1lGLHwrgu0kNA/YSD
 PjkLLqO9mIHCvr7mNhQkkF6d4Qk3RNLRVZNuIqwXtEx7mhrrU1wSZRip13bDqpQcxlg9ORVdcLvy2
 pQkScWACa9E7dFWjJsm9MxNwwUsHRGRz003HiVL6znu/a/6aIRhPOR/yfJ/YUy+PTFWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:References:CC:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3BclyRXM2geBeJKm545oR2ZA7lNUzhK2JenG/cQESfI=; b=BrZrxqqoKcaV42Y4IuNbOH2jgE
 9rB7KAIjMeeImCCk2dCFREfESdX5dH+V/cnXiOxNXPf/ry2J3qGmzQgxMI4zCpdXZRcCxEarVghzk
 Hc2d9k4f9ImEQzsssBWCTayGFjVfLC8iGd//rPUwbWeqzU6PVXx7lFI1+ID2jZaz/6mI=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmszH-007Qy6-O3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Dec 2020 06:30:14 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CrRwG0gyQzM06d;
 Wed,  9 Dec 2020 14:29:18 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Dec 2020
 14:29:56 +0800
From: Chao Yu <yuchao0@huawei.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20201208031437.56627-1-yuchao0@huawei.com>
 <22ac4df6-53ec-fb7c-c4dd-26435352a701@huawei.com>
 <X9A7Jn+cHRRcAmIi@google.com>
 <37d89d34-add1-5254-380b-233ef7a460d4@huawei.com>
 <X9BKX9PUMFkts9bI@google.com>
 <5398c880-d4d3-81b9-f3c9-765ba1470e96@huawei.com>
Message-ID: <0d4a20ec-f6e4-ff24-8733-94cc3762195d@huawei.com>
Date: Wed, 9 Dec 2020 14:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5398c880-d4d3-81b9-f3c9-765ba1470e96@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kmszH-007Qy6-O3
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: support chksum
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

On 2020/12/9 12:28, Chao Yu wrote:
> On 2020/12/9 11:54, Jaegeuk Kim wrote:
>> Ah, could you please write another patch to adjust the new changes?
> 
> No problem, will drop "f2fs: compress:support chksum" based on your dev branch, and
> apply all compress related patches on top of dev branch.

Jaegeuk, could you please
- drop "f2fs: compress:support chksum",
- manually fix conflict when applying "f2fs: add compress_mode mount option"
- and then apply last my resent patches.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
