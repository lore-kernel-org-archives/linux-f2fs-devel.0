Return-Path: <SRS0=+YV0=6W=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A4AC38A2A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 May 2020 08:26:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81348208CA;
	Fri,  8 May 2020 08:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="M2zhIQ+w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PzdGC+nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81348208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jWyKi-00016h-FW; Fri, 08 May 2020 08:26:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jWyKg-00016V-Gw
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 May 2020 08:26:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MCNMOTt4X5CHohZK8cxgZp11mJ2iE25M/hFJD+3U/mA=; b=M2zhIQ+wkubPNNRO++88FF5JYS
 KEwN0LGEbrTwNNjmB46sbFuw9JHk3UknTljGXwqGL7L8wxANhjqR6Oa+vlG8f1GS1o3pCzdB4bRbn
 ZVMu9cr993GI4mhcwynvtq8tMRuQVbYkl6EgCusyvgTAMpbp5RwJRSczO3/sBIRjVAYc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MCNMOTt4X5CHohZK8cxgZp11mJ2iE25M/hFJD+3U/mA=; b=PzdGC+nHbbh1n+cP/A/rLfl9K7
 ucGCPK7rwHa1c8DFQViauL2QGJCRunISuDYJE2S0W9lXnDH3UWBesQng6egy/YnLFcJ4SJffFTafM
 uCVTzgBauqhpdQ2CVrSis6GYkkGx1divGrtacILSVeM2RflRgtHovGOPx1eMRv0Jr0Qs=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jWyKd-00FGkA-02
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 May 2020 08:26:09 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 164BAB348E0F5B7116A3;
 Fri,  8 May 2020 16:25:57 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 8 May 2020
 16:25:55 +0800
To: Eric Biggers <ebiggers@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20200507075905.953777-1-ebiggers@kernel.org>
 <20200507075905.953777-2-ebiggers@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <be078d08-010e-ad47-b693-8eeacc54b198@huawei.com>
Date: Fri, 8 May 2020 16:25:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200507075905.953777-2-ebiggers@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jWyKd-00FGkA-02
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: don't leak filename in
 f2fs_try_convert_inline_dir()
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
Cc: linux-fscrypt@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>, stable@vger.kernel.org,
 Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/5/7 15:59, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> We need to call fscrypt_free_filename() to free the memory allocated by
> fscrypt_setup_filename().
> 
> Fixes: b06af2aff28b ("f2fs: convert inline_dir early before starting rename")

Thanks for fixing this.

> Cc: <stable@vger.kernel.org> # v5.6+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
