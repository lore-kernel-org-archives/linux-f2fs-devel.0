Return-Path: <SRS0=QQ8V=YS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9938BCA9EA0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:08:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A6521929;
	Fri, 25 Oct 2019 09:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="KKZJnq5R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="lZkd7WHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A6521929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iNvZm-0006TL-Kc; Fri, 25 Oct 2019 09:08:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iNvZk-0006T9-Rc
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Oct 2019 09:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:To:CC:References:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GBjav6SR2bU55JWA338BF4dfi0uf+nT6lrYjTxmbQuc=; b=KKZJnq5Rw+G5+cwnDahqTOPZbS
 nkplto1oIyki2jabvBTJMuir9H7BMbMLC8rij9TWJ5nXm36DPukn0Ay1adcFsrM8EYDIkfSojt+gm
 hYdqAfbg3tcGJC01YO91m02WgBtr78xCLGLTrMzFzvyonp+G+YSpnV0VBNt7yybaj/V0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:To:CC:References:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GBjav6SR2bU55JWA338BF4dfi0uf+nT6lrYjTxmbQuc=; b=lZkd7WHPCz9oQ7JRan1Ym69Bjc
 TPpo3O1VdlwKWnLy27UoggqLnPhkcjd06KthLQkHjz9ronBBRlV9HErGkB3rgRJAzNHutbpA22NzM
 lvyGB4AdluUlLwTpTIbd34X7hKThAigAwdnfCjMzw9zRJV0Y8iHs3B4e9GyaPXc8MaVA=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iNvZi-00GYNW-Tj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Oct 2019 09:08:04 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 74C9F518B207AD6D61CF;
 Fri, 25 Oct 2019 17:07:54 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 25 Oct
 2019 17:07:51 +0800
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
 <20191023052447.GD361298@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6fec84e8-82f2-aedc-9149-22ad501a08d3@huawei.com>
Date: Fri, 25 Oct 2019 17:07:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191023052447.GD361298@sol.localdomain>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1iNvZi-00GYNW-Tj
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support data compression
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/10/23 13:24, Eric Biggers wrote:
> How was this tested?  Shouldn't there a mount option analogous to

This should be a pre-RFC version..., I only didn't simple test on it, will do
more later with combination of other features.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
