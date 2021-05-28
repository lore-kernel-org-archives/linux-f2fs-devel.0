Return-Path: <SRS0=jEyb=KX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9439AC4707F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 May 2021 02:08:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D26613AA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 May 2021 02:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D26613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lmRvL-0008LF-Tc; Fri, 28 May 2021 02:08:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <yuchao0@huawei.com>) id 1lmRvK-0008L6-NO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 May 2021 02:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Eiz/iz4MNv20NPEu6im0tYTEHn2TUa/MV9TnB6Igv4I=; b=UqVJltJX83tso674LT3LwWxuVC
 e8xH+D9OF9j4aaKDCqGY0yLw1fOEDP3TmHtj+bcw5SEr5DBTYJs3aPIhsEu5gLoKp9GwhmoFLghdW
 9AiaXQ7oMRQrC+/kXAOqsZDj6mfJD8ylqFQ6EwHxjoxBKVUMRXoBfftEJw1VOJbA0HbA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Eiz/iz4MNv20NPEu6im0tYTEHn2TUa/MV9TnB6Igv4I=; b=NZ0CaxhhdD9HSkyGeRKFf2kwSn
 c5UEV77liVnOpcwMoLZjkb3Q2TuVLNWIpIIDYsd4f6xX5L7za1tOu43oX7+GDTFt1eU2NmRk5wmQK
 Hrd4gvWla9DJrxU4I9y3nofTdNITKwreOa0tHUFdSe3abRwNRb4FjPpfGgHEygSM0ymQ=;
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lmRv7-000NGq-Dv
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 May 2021 02:08:31 +0000
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Frnz74bpKzWp7w;
 Fri, 28 May 2021 10:03:31 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 10:08:07 +0800
To: Joe Perches <joe@perches.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
 <chao@kernel.org>
References: <1703a46c87dff3dbfdab008f1d268fe0b24c7db1.camel@perches.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <86100529-fdb6-d06a-b002-454131415975@huawei.com>
Date: Fri, 28 May 2021 10:08:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1703a46c87dff3dbfdab008f1d268fe0b24c7db1.camel@perches.com>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx703-chm.china.huawei.com (10.1.199.50) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
X-Headers-End: 1lmRv7-000NGq-Dv
Subject: Re: [f2fs-dev] [PATCH] f2fs: logging neatening
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/5/27 4:05, Joe Perches wrote:
> Update the logging uses that have unnecessary newlines as the f2fs_printk
> function and so its f2fs_<level> macro callers already adds one.
> 
> This allows searching single line logging entries with an easier grep and
> also avoids unnecessary blank lines in the logging.
> 
> Miscellanea:
> 
> o Coalesce formats
> o Align to open parenthesis
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
