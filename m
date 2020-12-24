Return-Path: <SRS0=DYO8=F4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2751C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Dec 2020 02:53:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E57224B1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Dec 2020 02:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E57224B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ksGkq-0001xq-0H; Thu, 24 Dec 2020 02:53:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ksGkm-0001xg-1A
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Dec 2020 02:53:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Qc9YHyIeA7dXxvbIXIXGSk6w/JwTOy6UIROG6WdhPc=; b=PCaSKH57QsWSvoCnhEKR8ZTot0
 rghzt7XfQxMn9W0XM71pR08MCfVQK3SLUkOfpSA5moef5JWC8CvoQZkWbRCaZcrpt07pAx4gaxPc0
 g59mG2R3zUSxZfGx5lg/UGb4H4MX+0+wcNSVJMU3T2taKW1ciTtBcyZ41IfKmyuOOpTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4Qc9YHyIeA7dXxvbIXIXGSk6w/JwTOy6UIROG6WdhPc=; b=Na1ePjQKv1mbvnpAw3+4LLz1sU
 Vii+PjydKyhht3QGI96ZpHVd72VNNOEPFBOTOTkaT8214jQayNCiX6muL+TsIykTHQ/RK4ozysJyD
 nRtGlEOOnXqKJTwV5sP18HDCnTPYAyYxNYuZQEOTMC/6RD3aeVpnXtWrzxNFFJxH94/Y=;
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ksGkc-009rll-Mo
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Dec 2020 02:53:23 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D1ZP20f55z7JrS;
 Thu, 24 Dec 2020 10:52:22 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 24 Dec
 2020 10:52:57 +0800
To: Zheng Yongjun <zhengyongjun3@huawei.com>, <jaegeuk@kernel.org>,
 <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
 <linux-kernel@vger.kernel.org>
References: <20201222133415.19915-1-zhengyongjun3@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <36c3cca5-8bd0-19e3-9298-9a67403c5ca4@huawei.com>
Date: Thu, 24 Dec 2020 10:52:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201222133415.19915-1-zhengyongjun3@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1ksGkc-009rll-Mo
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Replace expression with
 offsetof()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/12/22 21:34, Zheng Yongjun wrote:
> Use the existing offsetof() macro instead of duplicating code.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
