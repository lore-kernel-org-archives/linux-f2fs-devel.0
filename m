Return-Path: <SRS0=koix=XB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B701C43331
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Sep 2019 02:49:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C2C207E0;
	Fri,  6 Sep 2019 02:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MBn2hTCp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="j90dxUZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C2C207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i64JR-0005WT-4J; Fri, 06 Sep 2019 02:49:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1i64JP-0005WL-5z
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Sep 2019 02:49:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:References:CC:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JtuJSAdwQOIWOdxuHZWdUsfyr563l6BH7Bs2eqZtkUw=; b=MBn2hTCpJn2HG9AE0C952qq0+F
 0yEF9QYjiyVdd9lZhy/cjZOJ06APO1ub7JkRspWYf68Mox0KYkUldpQV+/X6S/lxl6vT+srhgqHfD
 9DLA3oJsyhpEuW0SR0eQHRj1biXHphPa4ePBMshvCC9eWry60TJySbKcSK3zLz7JBv0c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:References:CC:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JtuJSAdwQOIWOdxuHZWdUsfyr563l6BH7Bs2eqZtkUw=; b=j90dxUZy+mjgDlO85LCeS1RLMy
 Kf+yAJznkTJ5JxevZoFMzPUyUMutBkIcjGkF/8dN3JyqO9ecQpUDRGzOSfSaWKNinGa9mQMb26dsD
 q2U/2Jbc/v+PznKdgndkKa9W//TSzdYGK/EBpa08aW8eJPrsujD8etj5ZqvqmaX/Xfsc=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i64JM-00BM7L-R5
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Sep 2019 02:49:23 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 56F871731D68F0548963;
 Fri,  6 Sep 2019 10:49:13 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 6 Sep 2019
 10:49:09 +0800
From: Chao Yu <yuchao0@huawei.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20190723023640.GC60778@jaegeuk-macbookpro.roam.corp.google.com>
 <d4d064a2-2b3c-3536-6488-39e7cfdb1ea4@huawei.com>
 <20190729055738.GA95664@jaegeuk-macbookpro.roam.corp.google.com>
 <07cd3aba-3516-9ba5-286e-277abb98e244@huawei.com>
 <20190730180231.GB76478@jaegeuk-macbookpro.roam.corp.google.com>
 <00e70eb1-c4fa-a6c9-69d7-71ff995c7d6c@huawei.com>
 <20190801041435.GB84433@jaegeuk-macbookpro.roam.corp.google.com>
 <d35d5ad7-5622-fbf5-5853-e541f8c26670@huawei.com>
 <20190801222746.GA27597@jaegeuk-macbookpro.roam.corp.google.com>
 <5d566fce-4412-65b2-e9d9-279b648f7551@huawei.com>
 <20190806003749.GB98101@jaegeuk-macbookpro.roam.corp.google.com>
 <b5549a88-6805-99a8-4b0a-3bbf49da794c@huawei.com>
Message-ID: <5c583e7c-bb69-4bfb-9ff8-29182973c359@huawei.com>
Date: Fri, 6 Sep 2019 10:47:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b5549a88-6805-99a8-4b0a-3bbf49da794c@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1i64JM-00BM7L-R5
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: separate NOCoW and pinfile semantics
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/8/6 9:36, Chao Yu wrote:
>>>> Now WAL mode were set by default in Android, so most of db file are -wal type now.
>>> Will be back again tho.
>> R?
> Q.

Jaegeuk, why we reuse persist mode in Q now?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
