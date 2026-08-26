Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3E3C5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8OoubFStM4YR6KIlzsZ97ieil2vwLCbLmmTroRCbAyc=; b=h6RN1t4y3HA5wC+nZ5RGs6NIFp
	ranX1g/PVecbmzIMgVveTVeof+zTzslXggU2ku+Lxf2vIsZRnp7Eqh79cEbJ7Tqdt65Ym4IG6ap4T
	VB4dRJ8+BUzEl45W1X2XPRsU/aSb5LFUj+BfnSc/afUhhDLELiW1z3l+Vh/yYxoa+0rY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzGeM-0006UL-Mu;
	Wed, 26 Aug 2026 16:38:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wzGeG-0006Tw-8M
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fLm3Wj46CL3RhIdYvP1hhVnQ4SPJTUELaPo4u1suXgs=; b=PuDkNoCbBdpZmOSisIxzh+mdhX
 OqzfHfnD2uBMzLrUK0tjeeJtVvX8X+/01wmkRN77Dxy3OhzOYrUBizGxyAVmsMT9shZouMSYcKo7S
 O08RD2NgFKeJLhgn3rNuptLdd49htO7AVFIFOMHS1WSI9c3ySxMrnn5jkcRc3hgAMULw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fLm3Wj46CL3RhIdYvP1hhVnQ4SPJTUELaPo4u1suXgs=; b=f4LsBKNJoDd+wS//5JmrUwhDTj
 kKMS2EmNfWUuJgBpnW4qywkcUGrUKQ5ZJTpKV0qi0HJArH8FlQFZKMTQ32SjJ8uQiE2tCBnfDfqfP
 v7/63PtIPKG4QPz9avBiuGf19lORypLZeFmlF6884z+x8cAzNKu2IhDgOyFm1775jlKw=;
Received: from mail-lf1-f46.google.com ([209.85.167.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGeF-0001C2-Mr for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:38:48 +0000
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5b01910b499so86195e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787762321; cv=none;
 d=google.com; s=arc-20260327;
 b=IeowHjKGwpn8hpc96pYAF8YTzRw9k2KnJcG+jJpAIfdjvk7w6YgHCJnY7IHc/FKj8j
 fgGC4XhSBt2fh++9wjIFAYn83tZz88Acf3u7ieGr8VMXJm3U/p0DLw7CYMULiH1bmJeo
 LelRYm5cv3zMgR6SCJ6fJbYzU5f1hDbDXZz+tgcl1UhA2uV9Hwj69FeyHxZgKQ1oe/oL
 3eZ+criOKURvn4/MBcvmkfYxRkOboGmLFaRbbMy/h9yUFI8AIeq6SImHCI7wdRm0BOkd
 TGHDQ0sdhkmtgubpghLklD83IdgZAk0vEaO83u06voxNO8N+M6fQlrJbrhMmvKXqOF85
 +Zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fLm3Wj46CL3RhIdYvP1hhVnQ4SPJTUELaPo4u1suXgs=;
 fh=Oh6+ycSYL4wF6cPFJrp9ZrP4s7E89twLXxUg9mRH6yw=;
 b=GxF2SbKj44P33IyhnCzjp4+txxivkctwhb5Ae8JDMoQanGL8sG69omLsfNnVK+K7+E
 EvMZpE6UCiiWlusONIxw44IjhoYSuxIA3cmfwVKYZ64a/9CLxjYsBs4ZAg4EjRoSRpoQ
 cSERzR+A5cWo5FTsB8wf3aj1UKGnGMXA2YXzJLBVDmHKTR9ZKysbgolja05D9fr0T9TK
 Xevy6U6P/fyt176yhHojD3T6XY5N6U0RF7JEqjLwciDcL/KZNtv3kymAgvS5sK7LNpja
 QmgzXpPJJadBOHzQtS62Ni+YjPgvPUUsIXdZbX9Oi7Ks5/Ow7ZKzq5m0rIdsRVOtVXpl
 F4mw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787762321; x=1788367121; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fLm3Wj46CL3RhIdYvP1hhVnQ4SPJTUELaPo4u1suXgs=;
 b=OSXtGUE4RMtSQiHgCBJQZ80613jiVtxQYUof2fxkyJ9EG5zNW7r5NevPKjNbN1CX9f
 DOL7r97+Brso8apTfdNZjooWQGL5LoQCqzL9yKKwU2/24pPaxIOkg0DNFU12tzgWRQSu
 MoBuhknio4wEuRBFIYhvfIcyq4bNmiVDKWyVRdma6CjssdiC3KaGB/29KI9wrppd9izB
 DaZ/Bl1KF2yOxs8RDg99Uiso4QPQR0gaEo1rhkN23yH8rkf6+O79c+Kr9pZmSRugXVjb
 BES7XykG9p/F5CIJUEBk40JC79JGFS5nAJTp3RmaA/wsqpRhWjd6ctewoAynxg9HbI7r
 gwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762321; x=1788367121;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fLm3Wj46CL3RhIdYvP1hhVnQ4SPJTUELaPo4u1suXgs=;
 b=Oti5sinzTecZ8Y/3D3AOWV6T77W0ajmIr0+NWiQJJZzrF5hHicMnqVw8m2+TMeUpxf
 gS9Jf/kpHQ8G0egXA5m6uqMc1DUAOTzI0xIJyqocUAScworviw8ozg8NT67iaTfyGetZ
 meoKtpo0t4EkYpS5F5+zGGjcSI1lvilJ5mtFwkSDrg+Vnkzhw9UveXMk+T9I+zpiU1KH
 M1A4ySmu/7pI8nWuuBdG6GoYR5ihjj/+Cji3G3xlhwUsFkpjuVrefwMpioHcEQ4OaPxH
 MGXAznJhVGfm2SvzJAaKSo4rXQMWQRFkqUXiIXtJzVV4GGzeowNCqvgJD4mfLCIieDbR
 74Ag==
X-Forwarded-Encrypted: i=1;
 AHgh+RomNIeCf44YclNMAzIEdzKeAEAlwZh8fSU8KaImRcamNcT/b8CLqFPZI6FwY81rL44SFE97PlRsdOEqc6SWYEMt@lists.sourceforge.net
X-Gm-Message-State: AFuF++k2CBzNAh5XDXj9Oyy2dUrRueg1HSspcfoVmwEK4EbfRKpPSXL7
 duZCqx/+PCrchTkt5PZXbUFy7/OkUj1lQBVWmbrUipvf/6Oy8L7MP6zf+kllJ3B0xVK2m8MdKdg
 wCD0tr0Cf1UtHrwSEMRSWlHTEOGh7sEw=
X-Gm-Gg: AR+sD13geYi2qhMk9o/UHq3K1Q29hC8318pJeSPY3c1vuQ9aXwd6F5kAHz6LC7iA5ni
 3LtwqiG3GGKJyq3udIUh8Q3QOweETaPDsdMx6xYGKZwMm/SNjo8medAqGWe5mp+py84bhlM+IUy
 D22vHGvZGJJWBp3ZHxKNSupOb6HehUTtZk9eSHFaiCMjPFMukH5F2cfNsucQv/65Yd5CworyZ/e
 hPjMTDRY5miqnZdRAufFCnpOXkyG41iCIyv6kUmeyY40IShsESrMlP7CX2bWfHleOw6Nbd8cdYV
 ahOzBd0VKubGR8XSmvYszL2g2dI6IYvGLA2xvqGNapRCQbHjN5lRrPMk9J9P6VXMFap98ZNPDsj
 C906PhQzSHZZyxMCSkguiu72hFOZC9bQhPQ==
X-Received: by 2002:a05:6512:3086:b0:5b4:ab0c:f606 with SMTP id
 2adb3069b0e04-5b4afe94044mr132795e87.2.1787762320578; Wed, 26 Aug 2026
 09:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260826134126.3729507-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260826134126.3729507-1-qiwenjie@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 26 Aug 2026 09:38:26 -0700
X-Gm-Features: AcwNN1V5krk-Lrgjk4QJD4t7rLKQ-7dJrnID72x_erkj7QQ5LgMpyhSvR4rAvDQ
Message-ID: <CACOAw_xpF2fBnJwXPATANo5bK0UWUEx2uNKpy2RCfZRzhOphoA@mail.gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wzGeF-0001C2-Mr
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: fix device alias state across
 remount
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBBdWcgMjYsIDIwMjYgYXQgODo0MuKAr0FNIFdlbmppZSBRaSA8cXdqaHVzdEBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gU3BsaXQgZGV2aWNlLWFsaWFzIHJlbW91bnQgaGFuZGxpbmcgaW50
byB0d28gY2hhbmdlcy4gIFRoZSBmaXJzdCByZWNvcmRzIGEKPiBzdGFibGUgZGV2aWNlLXRvLWlu
b2RlIG1hcHBpbmcgc28gYSBjdXN0b20gYWxpYXMgbmFtZSBjYW4gYmUgcmVzZXJ2ZWQgYWdhaW4K
PiBhZnRlciByZWxlYXNlIGFuZCByZW1vdW50LiAgVGhlIHNlY29uZCB1c2VzIHRoYXQgbWFwcGlu
ZyB0byBrZWVwIHJlbGVhc2VkCj4gYWxpYXMgZGV2aWNlcyBvdXQgb2YgcGlubmVkIGFsbG9jYXRp
b24sIGJvdGggaW1tZWRpYXRlbHkgYW5kIGFmdGVyIHJlbW91bnQuCj4KPiBUaGUgZjJmcy10b29s
cyBsYXlvdXQgYW5kIG1rZnMgdXBkYXRlIHdpbGwgYmUgc2VudCBzZXBhcmF0ZWx5IGJlY2F1c2Ug
aXQKPiBhcHBsaWVzIHRvIGEgZGlmZmVyZW50IHJlcG9zaXRvcnkuCj4KPiBXZW5qaWUgUWkgKDIp
Ogo+ICAgZjJmczogcGVyc2lzdCBkZXZpY2UgYWxpYXMgaW5vZGUgYWNyb3NzIHJlbW91bnQKPiAg
IGYyZnM6IGtlZXAgcmVsZWFzZWQgYWxpYXMgZGV2aWNlcyBvdXQgb2YgcGlubmVkIGFsbG9jYXRp
b24KCkhpIFdlbmppZSwKClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0IHRoaXMgaXNzdWUgYW5kIGZv
ciB0aGUgcGF0Y2ggc2VyaWVzLgoKSG93ZXZlciwgdGhlcmUgYXJlIHNldmVyYWwgY29uY2VybnMg
d2l0aCB0aGUgcHJvcG9zZWQgYXBwcm9hY2g6CgoxLiBGcmVzaCBtb3VudCBpc3N1ZToKU2luY2Ug
bWtmcy5mMmZzIGRvZXMgbm90IHBvcHVsYXRlIGRldl9hbGlhc19pbm8gaW4gdGhlIHN1cGVyYmxv
Y2ssIG9uCnRoZSB2ZXJ5IGZpcnN0IG1vdW50IHJpZ2h0IGFmdGVyIGZvcm1hdCB3aXRoIGEgY3Vz
dG9tIGFsaWFzIG5hbWUsCmYyZnNfcmVzdG9yZV9kZXZpY2VfYWxpYXMoKSB3aWxsIHN0aWxsIGZh
bGwgYmFjayB0byB0aGUgYmFzZW5hbWUKbG9va3VwLCBmYWlsIHRvIGZpbmQgdGhlIGFsaWFzIGZp
bGUsIGFuZCBsZWF2ZSBGREVWKGkpLmhhc19hbGlhcyB1bnNldAp1bnRpbCBhIHJlbGVhc2UgaW9j
dGwgaXMgZXhwbGljaXRseSBjYWxsZWQgYXQgcnVudGltZS4KCjIuIFN1cGVyYmxvY2sgdXBkYXRl
cyBkdXJpbmcgcnVudGltZSBpb2N0bDoKV3JpdGluZyBhbmQgY29tbWl0dGluZyB0aGUgc3VwZXJi
bG9jayAoZjJmc19jb21taXRfc3VwZXIoKSkgZHVyaW5nIHRoZQpydW50aW1lIHJlbGVhc2UgaW9j
dGwgcGF0aCBhZGRzIHVubmVjZXNzYXJ5IGNvbXBsZXhpdHkgYW5kIG92ZXJoZWFkIHRvCnJlZ3Vs
YXIgZmlsZXN5c3RlbSBvcGVyYXRpb25zLgoKMy4gT24tZGlzayBmb3JtYXQgY2hhbmdlIGFuZCBr
ZXJuZWwgY29tcGxleGl0eToKTW9kaWZ5aW5nIHRoZSBvbi1kaXNrIHN1cGVyYmxvY2sgcmVzZXJ2
ZWQgYXJlYSBhbmQgaW50cm9kdWNpbmcKdmFsaWRhdGlvbiBsb2dpYyBpbiB0aGUga2VybmVsIGFk
ZHMgbm90YWJsZSBjb21wbGV4aXR5IHRvIHJlc29sdmUgYQpuYW1lLW1pc21hdGNoIGlzc3VlIHRo
YXQgY2FuIGJlIHByZXZlbnRlZCBhdCBmb3JtYXQgdGltZS4KClRoZSBvcmlnaW5hbCBkZXNpZ24g
aW50ZW50IG9mIGRldmljZSBhbGlhc2luZyB3YXMgdG8gbWFwIGEgZGV2aWNlIHRvCmFuIGFsaWFz
IGZpbGUgdGhhdCBzaGFyZXMgdGhlIGV4YWN0IHNhbWUgbmFtZSBhcyB0aGUgZGV2aWNlIGJhc2Vu
YW1lCihmb3IgZXhhbXBsZSwgL2Rldi9ibG9jay9ieS1uYW1lL3VzZXJkYXRhX2V4cCBtYXBwZWQg
dG8gdXNlcmRhdGFfZXhwKS4KUmF0aGVyIHRoYW4gY2hhbmdpbmcgdGhlIG9uLWRpc2sgZm9ybWF0
IGFuZCBrZXJuZWwgcnVudGltZSBwYXRocywgdGhlCmNsZWFuZXIgYW5kIG1vcmUgZnVuZGFtZW50
YWwgZml4IGlzIHRvIGVuZm9yY2UgdGhhdCB0aGUgYWxpYXMgZmlsZW5hbWUKbWF0Y2hlcyB0aGUg
ZGV2aWNlIGJhc2VuYW1lIGluIG1rZnMuZjJmcy4KSW4gYWRkaXRpb24sIHdlIGNhbiBhbGxvdyB0
aGUgYC1jIDxkZXZpY2VfcGF0aD5AYCBzeW50YXggaW4gbWtmcy5mMmZzCnNvIHRoYXQgdXNlcnMg
ZG9uJ3QgbmVlZCB0byBzcGVjaWZ5IHRoZSBmaWxlbmFtZSByZWR1bmRhbnRseS4KSSB3aWxsIHBy
ZXBhcmUgYW5kIHN1Ym1pdCBhIHBhdGNoIGZvciBmMmZzLXRvb2xzIHRvIGVuZm9yY2UgdGhpcyBh
bGlnbm1lbnQuCgpUaGFua3MsCgo+Cj4gIGZzL2YyZnMvZmlsZS5jICAgICAgICAgIHwgMTAwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPiAgZnMvZjJmcy9zdXBlci5j
ICAgICAgICAgfCAgNDggKysrKysrKysrKysrKysrKysrKwo+ICBpbmNsdWRlL2xpbnV4L2YyZnNf
ZnMuaCB8ICAgMyArLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEzNiBpbnNlcnRpb25zKCspLCAxNSBk
ZWxldGlvbnMoLSkKPgo+IC0tCj4gMi40My4wCj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QK
PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVs
IG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVs
Cg==
