Return-Path: <SRS0=qkfs=XL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F10C4CEC7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2019 01:16:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA9820665;
	Mon, 16 Sep 2019 01:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="m5NPZBVE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="lI2n0py3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA9820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i9fcV-00038S-Ta; Mon, 16 Sep 2019 01:15:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1i9fcU-00038K-Vz
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Sep 2019 01:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N+ZNmX0/7uNFNhMLVA1exUGOaKkJhK2NGfxQt0eDsV8=; b=m5NPZBVEdgutWDi5NW/iklLAX+
 6jv1ijArOQTMSeKe1dPlczg1tZXX59Vc2ky1doooHOgZAHbiX5BTvlVyUBz5S7iqk1Ja6FsvSzhSU
 v/D/hMiZrQYRyIum40Yqr5jrXrNBsf9xadbNT1h7BVkpg+8e04lH9tx1aHnNX/ZhXVzc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N+ZNmX0/7uNFNhMLVA1exUGOaKkJhK2NGfxQt0eDsV8=; b=lI2n0py3vnwiAq4eqfJh50FtWS
 aExiHnM1p82pmZZ413AbYkJjhCweuVGeeXxQAGrf5fXAg216BdnmFrMslzPYceXJsJ1LeZrvOwav0
 8aMcKG06Y5B7W9MbIsg/NyIzgqFBkJFGaFRAcW60nZcmyatjUymXUMyrLx/QVd71vEpc=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i9fcQ-007259-RH
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Sep 2019 01:15:58 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B9426788CD4FFC694493;
 Mon, 16 Sep 2019 09:15:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 16 Sep
 2019 09:15:45 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20190909080108.GC21625@jaegeuk-macbookpro.roam.corp.google.com>
 <bf0683d9-ac05-1edc-71ea-3d02f7b2fb55@huawei.com>
 <20190909082112.GA25724@jaegeuk-macbookpro.roam.corp.google.com>
 <2f5b844c-f722-6a80-a4ab-61bdd72b8be4@huawei.com>
 <20190909083844.GC25724@jaegeuk-macbookpro.roam.corp.google.com>
 <83759349-644a-b3a0-787d-e463b0565885@huawei.com>
 <20190909143419.GB31108@jaegeuk-macbookpro.roam.corp.google.com>
 <c48f8992-eaef-9b2e-56a3-f6a922daa4af@huawei.com>
 <20190910115850.GA98080@jaegeuk-macbookpro.roam.corp.google.com>
 <2fd8940b-9ebd-d143-5ce6-c056750c596f@huawei.com>
 <20190910120913.GB98080@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <1ba048b4-7dac-1c98-837d-0f0456ccc560@huawei.com>
Date: Mon, 16 Sep 2019 09:15:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190910120913.GB98080@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1i9fcQ-007259-RH
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid infinite GC loop due to
 stale atomic files
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

On 2019/9/10 20:09, Jaegeuk Kim wrote:
>> The lock is used to protect F2FS_I(inode)->inmem_pages list... it should be kept?
> Urg.. yup. I added.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
