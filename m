Return-Path: <SRS0=G5v/=JQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE9FC433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Apr 2021 06:16:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24207600EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Apr 2021 06:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24207600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lYNCo-0005AX-VD; Mon, 19 Apr 2021 06:16:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1lYNCn-0005AM-Ia
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Apr 2021 06:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qmZwoBQiZilSWbpZl/tTe9impOyAJs0ffP2bCt/8ehw=; b=GcfyI9TEkDj8c4n68MMLYW/8Sk
 KpmBlnsAj5oxf8DFvzPiNVW92GYKm2USOYXIFavHY3SEJU7jgMVAIdl4G5RdKXygIKH/00JGjlL7j
 rX3hQTOiYPAm4yUjggKMu80J5g2fDoaCsdn/yXa2ZiqfMGoGH2tZUcsGhJEpB9gctzi4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qmZwoBQiZilSWbpZl/tTe9impOyAJs0ffP2bCt/8ehw=; b=f1ufAtQMiqL+8oTQkMCg+4dUK8
 5EIZpRB8R2ujT6xQT91Y1s2d+sM4MpYyR9ysPqG5Pgg5zjdVWYCO0qvMyoQTsdiydPOYu6rhQddva
 vDvhZ/Yy+4AsheUeveQP/FxxK3ZknRlADEC0C52ESEnqfcxPoLpPMOTCEqU1znmZT6xY=;
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lYNCh-0000YB-HF
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Apr 2021 06:16:22 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FNxNF501jzlYvR;
 Mon, 19 Apr 2021 14:14:05 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 19 Apr
 2021 14:15:57 +0800
To: Wan Jiabing <wanjiabing@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "Chao Yu" <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
 <linux-kernel@vger.kernel.org>
References: <20210419022003.34172-1-wanjiabing@vivo.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <58457717-a795-d33a-d771-f75fe05b1069@huawei.com>
Date: Mon, 19 Apr 2021 14:15:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210419022003.34172-1-wanjiabing@vivo.com>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
X-Headers-End: 1lYNCh-0000YB-HF
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: Remove unnecessary struct
 declaration
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
Cc: kael_w@yeah.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/4/19 10:20, Wan Jiabing wrote:
> struct dnode_of_data is defined at 897th line.
> The declaration here is unnecessary. Remove it.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
