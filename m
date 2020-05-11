Return-Path: <SRS0=QJsr=6Z=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4636C38A2A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2020 01:12:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D9320820
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2020 01:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ECcOfiz/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UZzG8/b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D9320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jXwzf-0008JK-F1; Mon, 11 May 2020 01:12:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jXwzd-0008J6-6t
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 May 2020 01:12:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SnoYAoXQpmTp/YwQYeJTCMaqT7WCf35mpL/huUUAJDw=; b=ECcOfiz/xsHRc/rAObzm+RYZVn
 FtW7AdjFNxC415u/IjGVT56aeoQ0Tj8UgrtGfAJNSVSfXyFe20xFlALiwocAF4R0Gzp9Z0NnqsgW0
 vYLBEDE3HqdwujaMakYiL2JoB4UzmvycUtMLKmZE174P/jPHTqaMvHQnOYiRemAZNl9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SnoYAoXQpmTp/YwQYeJTCMaqT7WCf35mpL/huUUAJDw=; b=UZzG8/b7c85JCR3QnOO/qu+4wA
 OSNad1XfgeRTJnHE1rKHd0tWFy3y4ZJEJhUmtRFHdlXK/jwjPH3OWdq8QGs6HmlxvHS6OClWZ/kXe
 KIjw6A4papNnRovRnAXF4x8mvbF/CBnGPUgRbFM+5HA2Q4A0vOrXEoTWruRBqY454yVc=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jXwzb-000ENt-8h
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 May 2020 01:12:29 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A16BD23D88B576970A90;
 Mon, 11 May 2020 09:12:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 11 May
 2020 09:12:05 +0800
To: YueHaibing <yuehaibing@huawei.com>, <jaegeuk@kernel.org>,
 <chao@kernel.org>, <hridya@google.com>
References: <20200509112135.51960-1-yuehaibing@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <684636ce-5bcc-328f-b7dc-dfdee06f41cf@huawei.com>
Date: Mon, 11 May 2020 09:12:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200509112135.51960-1-yuehaibing@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jXwzb-000ENt-8h
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Fix wrong stub helper
 update_sit_info
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

On 2020/5/9 19:21, YueHaibing wrote:
> update_sit_info should be f2fs_update_sit_info,
> otherwise build fails while no CONFIG_F2FS_STAT_FS.
> 
> Fixes: fc7100ea2a52 ("f2fs: Add f2fs stats to sysfs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
