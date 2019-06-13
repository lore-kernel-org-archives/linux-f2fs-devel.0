Return-Path: <SRS0=4Diz=UM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD6DC31E45
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Jun 2019 06:53:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E1720866;
	Thu, 13 Jun 2019 06:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="EsrJkPnP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SbDuRftQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E1720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hbJby-0001e8-2c; Thu, 13 Jun 2019 06:53:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hbJbw-0001dz-AM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:53:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RIif+zXImghfWZEK1l2IfgtPGz7numtdCvn60azWB1Q=; b=EsrJkPnPvjKHHzvl9Zvq0MAnMQ
 BetDjRhSoPJ4wbqLE9RrArZ4xpOK7BuQ7KWjg3uxeb0wUvCAIBLCas7qSN+u+SdB3SnMZBrCRHKpo
 gobOPmu7/LNfucuSzaFN8Yq4pnoLKnrNQiQ3hzcjJx4k5aZ1BKPU5AhBDufSeUF+z8jc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RIif+zXImghfWZEK1l2IfgtPGz7numtdCvn60azWB1Q=; b=SbDuRftQLqqojjep9KOHI6t/Ll
 6BgHrOT9JmXt0QefPmgDoO8Le7yYJqKfGv6iH3/7DJLQ1t4blaRPytg0s2i07/fleOcbsmelOgpxv
 MDf5xQmxTQHcy3Ng+j0vKadOcn3xAYj6slRalyEbI9fDBc/0/k3svUxKF7dVyOQ2dWZ4=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hbJbt-00BBgH-GP
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:53:22 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 518A76E69A3BD068B9B5;
 Thu, 13 Jun 2019 14:53:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 14:53:10 +0800
To: Kimberly Brown <kimbrownkd@gmail.com>, <jaegeuk@kernel.org>,
 <gregkh@linuxfoundation.org>
References: <20190607174041.11201-1-kimbrownkd@gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <907b6488-e214-1543-28db-20f9f9d01557@huawei.com>
Date: Thu, 13 Jun 2019 14:53:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190607174041.11201-1-kimbrownkd@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1hbJbt-00BBgH-GP
Subject: Re: [f2fs-dev] [PATCH] f2fs: replace ktype default_attrs with
 default_groups
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190613065309.LoW_nvm6FNyI7HxMtLU4gSfEuIQLG0RxzqGIR0zdG9A@z>

On 2019/6/8 1:40, Kimberly Brown wrote:
> The kobj_type default_attrs field is being replaced by the
> default_groups field. Replace the default_attrs fields in f2fs_sb_ktype
> and f2fs_feat_ktype with default_groups. Use the ATTRIBUTE_GROUPS macro
> to create f2fs_groups and f2fs_feat_groups.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
