Return-Path: <SRS0=hpJI=7Y=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD344C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 11 Jun 2020 02:05:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B37D206A4;
	Thu, 11 Jun 2020 02:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ROIIe3OX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LFMiMLEg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAdfqTa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B37D206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jjCb3-0007ju-3g; Thu, 11 Jun 2020 02:05:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1jjCb1-0007jm-Bd
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jun 2020 02:05:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hnHKIzS41GEo89Iuw03X5GmSxi7D1lwQQJW4EUMasuw=; b=ROIIe3OXH6N8kKKnOfwfkESG00
 HqJXSz5rG7Cqx81pf4XjsA15XG8qY5rt4alW8I1/FJ2vl+niS5l7lyKKwqzc5gRc2/1Ftr6Ly7uR9
 fDDVbC/8Lpla7sxEvNoJGQJeQHYH3wzROAHWwkn9TXjZT5RlvlUUbDbosw8+EYeYxeFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hnHKIzS41GEo89Iuw03X5GmSxi7D1lwQQJW4EUMasuw=; b=LFMiMLEgkD/kOiz0keboJy+K71
 hF5S8LxT6/aX2bH09+ZYuBIPEGwEJ5/py3K7qhwbmjqUDZwTLauVsH6TujFZmPczUhEjSW72n+qs5
 HIW3tx1qDKVFkcheTA6ObT2aMfX1pZAn3zGIVFq/jI8OVx68IFUGlbKO/umkM+8zZkvQ=;
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jjCaw-00GCDY-JP
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jun 2020 02:05:35 +0000
Received: by mail-lf1-f67.google.com with SMTP id z206so2612341lfc.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2020 19:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hnHKIzS41GEo89Iuw03X5GmSxi7D1lwQQJW4EUMasuw=;
 b=rAdfqTa6+gIX/5dokn44QP7FxNEPlLZQBT4iSMRctA6FapNrfwSqgJ2c6joLmBDKe2
 KOemYJhFqy3xzk0yT3ONnQvy2RBMtcQF33RRSgw20SZRfjuFnq1PjQiSR/THpgyIA7CQ
 ZWWDaJ/dbk687ltRarmYsbZOyFfndJhnY6qNV2QuJJXYdoj/W6LdMOoEFWoaiZCXSBHi
 /YQWmFMdfEDninsH5hnglKA5NXGpU4E1wp+NFtTp9FXrvEX3kAjrewhz4QKHaLVQf9CN
 3uaVYK+SqNhS7yTuct7vtMt/wlWvWzxyi0+9+2nMuhYK0wdXrBbvM+Bp/FY2Lkh9QJ0t
 30Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hnHKIzS41GEo89Iuw03X5GmSxi7D1lwQQJW4EUMasuw=;
 b=mIqVSDAjpg+4a+8wUedo9N7DJFlbQAdtYDnlaMgi+sBN+rwPPeeySe7pYzdpZHF4Vs
 hm0wc+SuImTsgzPBIqzCWRJUmEEWNpY9RXrnuD1As2R0UR8JZVHE1sIJxM63dIsXVfng
 JxAmQEHVll3vGYFBzxcWGwiJOE5zo+w8aBvSumAd3jDga7L9pQO0IixGbNFlvLVXL3O1
 bPDZ8eBIADp9xQ7ehE08SkxHgQ8KvylYkwmRXfA1kVLsjyrPqOBx3BeG3SFaJOoKqXkC
 TLzj6kchTljSemeHkdjv6I/KSehQqpf4GvVP663iH7ZVOhIcetT+t7A756vtzTf8ZYZB
 siBw==
X-Gm-Message-State: AOAM533Fe8lyc/h40jm60kI6rIXziynuPFisdWeS1iHP3eoBp1zfSkv4
 n8y8btjXzNZw4vOt1mVUOVs/hCGfF7XltO1pAcg=
X-Google-Smtp-Source: ABdhPJzdqqERhweDWlto+RkiPjeDngTuAhrvRQ5bexxWheNvxTjVEXuD7WA3Dq8HdYyFsrbPRvJ3RVfEywt0VIlzgVc=
X-Received: by 2002:a19:6554:: with SMTP id c20mr3051122lfj.140.1591841123919; 
 Wed, 10 Jun 2020 19:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200609060137.143501-1-daeho43@gmail.com>
 <20200609165107.GA228564@gmail.com>
 <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
 <20200610031532.GA6286@sol.localdomain>
 <CACOAw_wErOPC=Kf3UU8nFGhWRy84ZnCeJbsyPhSCcXv51B_XxQ@mail.gmail.com>
 <CACOAw_zka6d06RxFOUTwEV7B6o8A2-_6FvqWh_A1nJ0+7FU9yQ@mail.gmail.com>
 <CACOAw_yc4hxdyxyO+Lb4MArHek1tP4wxCq0tezWOocgqvK+tqg@mail.gmail.com>
 <20200611000037.GC1339@sol.localdomain>
 <CACOAw_xqHnL0MthPykSrKJ8OXez-XigCFgC-vwm_keEZh_g8zw@mail.gmail.com>
 <20200611015651.GD1339@sol.localdomain>
In-Reply-To: <20200611015651.GD1339@sol.localdomain>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 11 Jun 2020 11:05:12 +0900
Message-ID: <CACOAw_x3yC8ELYj7qSC7PM2RwpYRwQu7mT1vJhoFUQX4uzx2=w@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1jjCaw-00GCDY-JP
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T2ssIEkgZ290IGl0LiBUaGFua3MgZm9yIHF1aWNrIHJlc3BvbnNlfiA6KQoKMjAyMOuFhCA27JuU
IDEx7J28ICjrqqkpIOyYpOyghCAxMDo1NiwgRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwu
b3JnPuuLmOydtCDsnpHshLE6Cj4KPiBPbiBUaHUsIEp1biAxMSwgMjAyMCBhdCAwOToyMzoyM0FN
ICswOTAwLCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IFllcywgSSBzYXcgdGhlIGltcGxlbWVudGF0
aW9uIGluIHZmc193cml0ZSgpLgo+ID4gQnV0IGlmIHdlIHVzZSBtbnRfd2FudF93cml0ZV9maWxl
KCkgaGVyZSwgaXQnbGwgY2FsbCBtbnRfY2xvbmVfd3JpdGUoKQo+ID4gaW50ZXJuYWxseSBpZiB0
aGUgZmlsZSBpcyBhbHJlYWR5IG9wZW4gaW4gd3JpdGUgbW9kZS4KPiA+IERvbid0IHlvdSB0aGlu
ayB0aGUgYmVsb3cgdGhpbmcgaXMgbmVlZGVkPyBXZSBjYW4gaW5jcmVhc2UgdGhlIGNvdW50ZXIK
PiA+IGVhY2ggb2YgdGhlbSwgb3BlbiBhbmQgaW9jdGwsIGxpa2Ugb3RoZXIgZmlsZXN5c3RlbXMg
c3VjaCBhcyBleHQ0Lgo+ID4KPiA+IGludCBtbnRfY2xvbmVfd3JpdGUoc3RydWN0IHZmc21vdW50
ICptbnQpCj4gPiB7Cj4gPiAgICAgICAgIC8qIHN1cGVyYmxvY2sgbWF5IGJlIHIvbyAqLwo+ID4g
ICAgICAgICBpZiAoX19tbnRfaXNfcmVhZG9ubHkobW50KSkKPiA+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVST0ZTOwo+ID4gICAgICAgICBwcmVlbXB0X2Rpc2FibGUoKTsKPiA+ICAgICAgICAg
bW50X2luY193cml0ZXJzKHJlYWxfbW91bnQobW50KSk7Cj4gPiAgICAgICAgIHByZWVtcHRfZW5h
YmxlKCk7Cj4gPiAgICAgICAgIHJldHVybiAwOwo+ID4gfQo+Cj4gTm8sIHRoaXMgc2VlbXMgdG8g
YmUgbGVmdCBvdmVyIGZyb20gd2hlbiBtbnRfd2FudF93cml0ZV9maWxlKCkgd2FzIHBhaXJlZCB3
aXRoCj4gbW50X2Ryb3Bfd3JpdGUoKSBpbnN0ZWFkIG9mIG1udF9kcm9wX3dyaXRlX2ZpbGUoKS4g
IEkgc2VudCBhIHBhdGNoIHRvIHJlbW92ZSBpdDoKPiBodHRwczovL2xrbWwua2VybmVsLm9yZy9y
LzIwMjAwNjExMDE0OTQ1LjIzNzIxMC0xLWViaWdnZXJzQGtlcm5lbC5vcmcKPgo+IC0gRXJpYwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
