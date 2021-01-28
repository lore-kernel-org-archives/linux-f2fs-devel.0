Return-Path: <SRS0=cj9c=G7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF868C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Jan 2021 07:05:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D78E64DCE;
	Thu, 28 Jan 2021 07:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D78E64DCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l51Mr-0002CE-RB; Thu, 28 Jan 2021 07:05:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1l51MV-0002BT-QJ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Jan 2021 07:05:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4koKAdYgRop0jHJt01vFDOEfv6CKTaeQc67fRzO3zpo=; b=DZilqz3cuLwy9eHn13LxjDee87
 18XCqR4NpQtmzZKdCT1dIT0XgaEoj/S1m+eKMW4FCSoApCOPOs/kgZ5dzR24YVqkxZqVwfXt4oihL
 oGbT2/Mbzfhkas6Xy0NocvVOxF0dBVIDiWAXR7mnFspeJcMMAOIUFnZ7TXhYQIGSU/WA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4koKAdYgRop0jHJt01vFDOEfv6CKTaeQc67fRzO3zpo=; b=eWaylRCIhP/N+j6uOyNg3rFtjV
 vo6nL8R8330nsBnW5XX2nGQhVxy5k+CaBANT5ED5jHghh17kc0BNQbB7NL+9bquWh3ie2xaSo1IYc
 m0c525OCWx7qaeqQfCwBr5T0lXI4BXgwR0Z9CtDq2/nEOZcVQ1sjRSoeI+/AuBQ9flP4=;
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1l51MA-00GGKr-Ck
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Jan 2021 07:05:02 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRBJf30QpzjBjN;
 Thu, 28 Jan 2021 15:03:30 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 28 Jan
 2021 15:04:27 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20210127014434.3431893-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <bf5760eb-cdc4-fb41-41cc-03496b6727fe@huawei.com>
Date: Thu, 28 Jan 2021 15:04:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210127014434.3431893-1-jaegeuk@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
X-Headers-End: 1l51MA-00GGKr-Ck
Subject: Re: [f2fs-dev] [PATCH] f2fs: flush data when enabling checkpoint
 back
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
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/1/27 9:44, Jaegeuk Kim wrote:
> During checkpoint=disable period, f2fs bypasses all the synchronous IOs such as
> sync and fsync. So, when enabling it back, we must flush all of them in order
> to keep the data persistent. Otherwise, suddern power-cut right after enabling
> checkpoint will cause data loss.
> 
> Fixes: 4354994f097d ("f2fs: checkpoint disabling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
