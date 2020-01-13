Return-Path: <SRS0=A0xd=3C=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECADEC33CA8
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:56:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2E020678;
	Mon, 13 Jan 2020 08:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ImAcVNfn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SS1ejeFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2E020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iqvWd-0003si-A2; Mon, 13 Jan 2020 08:56:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iqvWa-0003sW-Ko
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Jan 2020 08:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1UvYsQNOqCKqSLe1+LPOr/hLzf/8E8WIykOvz0mIhSo=; b=ImAcVNfnyUzeGF0tqG0W6K9/Sn
 unGHeCaXoVqr2ShUPGBpCMccYKc96wS5b10t63uhp5Eqj3uMCNGMYMSMRbod6TsMS9ju0SjY0dg/9
 SIP/umvgAMUrYFVdrnqxwSIBGLCDzj4Kd1phLiyg9layZR9fQ7qdwNg706teZoJDtE7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1UvYsQNOqCKqSLe1+LPOr/hLzf/8E8WIykOvz0mIhSo=; b=SS1ejeFPAwcsXlP8qAmMlnJmLL
 6VvLJKLsxqwthqlr1u9yugt8s3i66DQARHdWnMx6JJhN/O3UyzcOLrdOxDCyFTvvwsPeDYOMIAchj
 724kI4uyNWj8xKIn7ZuDwOfN5GB5WReoQSz4vNZuQMaDIxUqNgHg5/e7kLUKUkETTaO4=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iqvWY-002tdL-4l
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Jan 2020 08:56:40 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 12CE9F26DD09C2D7CF29;
 Mon, 13 Jan 2020 16:56:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 13 Jan
 2020 16:56:27 +0800
To: ping xiong <xp1982.06.06@gmail.com>
References: <1578898350-29607-1-git-send-email-xp1982.06.06@gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6304784c-69f3-6542-a660-8513c3895b07@huawei.com>
Date: Mon, 13 Jan 2020 16:56:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1578898350-29607-1-git-send-email-xp1982.06.06@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1iqvWY-002tdL-4l
Subject: Re: [f2fs-dev] [PATCH V2] resize.f2fs: add option for
 large_nat_bitmap feature
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
Cc: jaegeuk@kernel.org, xiongping1 <xiongping1@xiaomi.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/1/13 14:52, ping xiong wrote:
> From: xiongping1 <xiongping1@xiaomi.com>
> 
> resize.f2fs has already supported large_nat_bitmap feature, but has no
> option to turn on it.
> 
> This change add a new '-i' option to control turning on it.
> 
> Signed-off-by: xiongping1 <xiongping1@xiaomi.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
