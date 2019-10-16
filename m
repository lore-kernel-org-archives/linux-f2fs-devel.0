Return-Path: <SRS0=Bnpk=YJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E860BC4360C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:33:42 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DBE20872;
	Wed, 16 Oct 2019 09:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UZpIj35N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bNi1+Q6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DBE20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iKfgc-0001Gz-Ao; Wed, 16 Oct 2019 09:33:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <koulihong@huawei.com>) id 1iKfgb-0001Gs-5r
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Oct 2019 09:33:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=npaCkGkCN4UhD9cWalUCVq+G4fCLmD+lUevwt6FrABY=; b=UZpIj35Nhlx+kkDjyktT64DLr8
 oX3Wy5ytM9lfCqCuzWEOWEBV4frx+O8/Di2dkEhoxQUcepkRnfjOjD47Slqe1XbeWXBEupUzT0R1r
 0XRnyboaO4GOh0zDuf3kbmH87vQRUB5IGunc7HQLMBxGUPbRG/GANpnZoQBwxQFjz75M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=npaCkGkCN4UhD9cWalUCVq+G4fCLmD+lUevwt6FrABY=; b=bNi1+Q6GAgf77m052cjYkN7hlN
 IK/sOSBWMNawS7/x+uVHQa6IBRty6RWvxkP7Gs7aS5rRS5VQPGpVHy69HKsS241ElgrkaxQeFIX6s
 HuLg4RY2r5NstVbUY46HjZCEvc9ZWyaaAljtS47NQH1mUbN3X0PyCZqZIMwesxOSyOoc=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iKfgZ-00BFNB-QU
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Oct 2019 09:33:41 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C65CC436D15C4C524FAD;
 Wed, 16 Oct 2019 17:33:32 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.219) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0;
 Wed, 16 Oct 2019 17:33:23 +0800
To: <yuchao0@huawei.com>, <jaegeuk@kernel.org>
References: <1571217722-88090-1-git-send-email-koulihong@huawei.com>
From: lihong <koulihong@huawei.com>
Message-ID: <9e93eae3-18f6-43d7-889d-f22568428bf8@huawei.com>
Date: Wed, 16 Oct 2019 17:33:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571217722-88090-1-git-send-email-koulihong@huawei.com>
X-Originating-IP: [10.133.219.219]
X-CFilter-Loop: Reflected
X-Headers-End: 1iKfgZ-00BFNB-QU
Subject: Re: [f2fs-dev] [PATCH 0/2] add a new fio cache for IPU.
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
Cc: zengguangyue@hisilicon.com, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

UGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLCB0aGVyZSBhcmUgc29tZSBmb3JtYXQgZXJyb3JzIGlu
IHRoZSBjb21taXQgCmRlc2NyaXB0aW9uLCBpIHdpbGwgc2VuZCB0aGUgcGF0Y2hzIHdpdGgKCnRo
ZSBmaXguCgrU2iAyMDE5LzEwLzE2IDE3OjIyLCBMaWhvbmcgS291INC0tcA6Cj4gKioqIEJMVVJC
IEhFUkUgKioqCj4KPiBMaWhvbmcgS291ICgxKToKPiAgICBSZXZlcnQgImYyZnM6IGFkZCBiaW8g
Y2FjaGUgZm9yIElQVSIKPgo+IGswMDQxNzkyNSAoMSk6Cj4gICAgZjJmczogaW50cm9kdWNlIGEg
bmV3IGZpbyBjYWNoZSBmb3IgSVBVLgo+Cj4gICBmcy9mMmZzL2NoZWNrcG9pbnQuYyB8ICAxICsK
PiAgIGZzL2YyZnMvZGF0YS5jICAgICAgIHwgOTMgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgZnMvZjJmcy9mMmZzLmggICAgICAgfCAgNCAr
LS0KPiAgIGZzL2YyZnMvc2VnbWVudC5jICAgIHwgMjIgKysrKysrLS0tLS0tLQo+ICAgZnMvZjJm
cy9zdXBlci5jICAgICAgfCAgMiArKwo+ICAgNSBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25z
KCspLCA5MyBkZWxldGlvbnMoLSkKPgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZz
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
