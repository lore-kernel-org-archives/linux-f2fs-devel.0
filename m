Return-Path: <SRS0=th6E=55=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8F8C2BB85
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Apr 2020 00:35:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484CA20708;
	Mon, 13 Apr 2020 00:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="HfI2yJHB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="djZY16ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484CA20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jNn40-0003hy-6H; Mon, 13 Apr 2020 00:35:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jNn3y-0003hr-Ul
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Apr 2020 00:34:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gmG7yIa+5ppePR4PNm7yQ77aUkXla/tdIhRRYOZ9EOA=; b=HfI2yJHBRRVMg4BXdBBev9SAY/
 1dJD5H9oGgFo8s1fkJf15cRcYXdfMUn9RpQGCVUEgR438kQQIdod+DNNggcBqlhkWeZ0tx14HaGry
 b0RhoNT1IQdwo/7u9b8ARxPn5PccdX83Ph+OH8UEhOOb4cZR7frZ27JkBCQQSc99QX6E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gmG7yIa+5ppePR4PNm7yQ77aUkXla/tdIhRRYOZ9EOA=; b=djZY16lnyrZYxWGW/Efkxn26S9
 BfUVQSs3iZcnSOE4kajIV0+OT4YqyZctYNZkCWd+qFT6UwbIdA4ex2OgfhajNe3Fd2HVPWdikb2p7
 mu+ShYpeVrWC+ZZ7CmLU+/XEox4pJQPOqE03vQ1ZA4LUXvNvbQSqCj67snKgZICClxnA=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jNn3u-00DD51-SO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Apr 2020 00:34:58 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0234DAA1B2BB9BF8950A;
 Mon, 13 Apr 2020 08:34:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 13 Apr
 2020 08:34:40 +0800
To: Markus Elfring <Markus.Elfring@web.de>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <c50f4bff-1c14-931d-ee07-a2f5dc336785@web.de>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <d228c74b-0d33-e22c-56c8-f2bfd691c985@huawei.com>
Date: Mon, 13 Apr 2020 08:34:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c50f4bff-1c14-931d-ee07-a2f5dc336785@web.de>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jNn3u-00DD51-SO
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid page count leak
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMC80LzExIDM6MTksIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+PiBJbiBiZWxvdyBlcnJv
ciBwYXRoLCB3ZSBtaXNzZWQgdG8gcmVsZWFzZSByZWZlcmVuY2UgY291bnQgb2YgcGFnZXMKPj4g
aW4gY29tcHJlc3NlZCBjbHVzdGVyLCBmaXggaXQuCj4+IC0gZjJmc19tcGFnZV9yZWFkcGFnZXMo
KQo+PiAgLSBmMmZzX3JlYWRfbXVsdGlfcGFnZXMoKQo+IAo+IEkgc3VnZ2VzdCB0byBpbXByb3Zl
IHRoZSBjb21taXQgbWVzc2FnZS4KPiAKPiBXb3VsZCB5b3UgbGlrZSB0byBhZGQgdGhlIHRhZyDi
gJxGaXhlc+KAnSB0byB0aGUgY2hhbmdlIGRlc2NyaXB0aW9uPwoKU3VyZSwgd2lsbCB1cGRhdGUg
aW4gdjIsIHRoYW5rcy4KClRoYW5rcywKCj4gCj4gUmVnYXJkcywKPiBNYXJrdXMKPiAuCj4gCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJm
cy1kZXZlbAo=
