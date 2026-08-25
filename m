Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE65C61CE3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r6/3T9iBTgJTgwIx8xpJ58nU2N0X7dViqQ0KYyUi+P0=; b=ZkmrRfCryzAcH6DDcdPlpedPFn
	MyvFh020yotlrxjHZBnEjr8csCwtQto4iDJCgEJCtnsCShQgUC0vwlnPxvQz7+WY7DF2E+/9eZzaj
	zjJwTtUnA6e1N8atl8E33jzLnpqHtfGOkHp53y60K5HciVuBmxxDcRzYCfVJFyefrr3k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wykt6-00034X-CZ;
	Tue, 25 Aug 2026 06:44:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wykt4-00034P-J6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:43:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YFFnhjcWX2esFqzTXKdNV82QT3BiE47cZiKBya4IY2Y=; b=MXt3/lrwDZGgdIV59YT3xFua+o
 c//xYChkTMyIlNXtqEOLSy/aazO40MlRaA+HsPWrbobICMITXJwZNFsdHsxk4FUFAQMxaVJWS52WW
 R5iidNt5IbmBVB83QcuaziDGZdw7U8PLxuSfGoFFVqrkFGaX0d8b+nJmPXhJGourtjzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YFFnhjcWX2esFqzTXKdNV82QT3BiE47cZiKBya4IY2Y=; b=HiQn6yulbf21vyr8eFaO36J0N3
 o1KjvojvvMf7EE01YKDeECDTjuLZRkPJv1AJtevAFnebET9azZjBbMtZqeNN2Y/cSQ+CeGnS5pIDk
 nwNZEzRdv0pEKBs1jPplQ7vi/nkpWAYrMJloloEK9WBvNH92oFdSe4REKbHQcyvAVs7Y=;
Received: from mail-lf1-f49.google.com ([209.85.167.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wykt1-0006zc-2R for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:43:58 +0000
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5b14d1f9315so3839782e87.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 23:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787640228; cv=none;
 d=google.com; s=arc-20260327;
 b=Yei7ZKu0HqUVr54mW1FkC/0l0fAsaBHv6WELjVOAJEPgP/vfu9gQsNxkLnm6kgRIg9
 xLEdspGFLIY8N9c4Wsor8XEIcxucUobwh2vVXGrGCePR+IbqNkTxJW8QRX/oDr9Oc9cf
 ASPn/EZMTKXIfBV2HpMsSsIZAwz+Qn4AKBBbcJZIYO0VxdM2Cc4tdqFsl6F5uw9Q7Jh6
 ph4k1CCYqPpepYywqxwc64wyJuaWayDuHajkuAqPVhXnlP8ktbWLNFLv9bh85VKYK5Ht
 o5p1FLc1OYjZiEjQApusvMgrrxf0qA55EkgDVIMGtw1aZsy7Pe4x74nlxMXGV9XV9c3U
 ELsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YFFnhjcWX2esFqzTXKdNV82QT3BiE47cZiKBya4IY2Y=;
 fh=2GWIPgYiLFU0VyeqrF4ezRN30cu+/o7HnVZlSFtR0EQ=;
 b=BHA910OCP4HRuPK3rLQP9Y5IoCRLpsHmeeAl4QQKpmibpA63Vn7z74ZptAuxt+Rt5a
 zbjKE1y+rqH42+OmP0N62B325dH/0oHgqxojLi+1nh2FTUDKKq0EEWr+vqmPt+QWYxwQ
 GpJZ8BNp2LfhBw3o1Lkzj+7LDy7pi7CaFbgNVu90JsGZs4wZqGkXl4k2OHtTGkQnOTJY
 CqdvLLNyiaKpEVlX01EyCDmf7Cm/o8JpRMVeeU5mIvr6VhkQbV8K2W6ZwjU+0QrKL1dQ
 KQ+MUggySTpayRHiM/fLi700DWLk8mBY1X5SQY09Ujku7j24W4kmtyBTDCr0ouTLbtj0
 BhCw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787640228; x=1788245028; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YFFnhjcWX2esFqzTXKdNV82QT3BiE47cZiKBya4IY2Y=;
 b=EIaNWqjh1RYYh7WNf5mi3u58e2BO/IgmVg6Ycp7vQiGM+u0nRDYXFMAj7tFFIqwti6
 oqAvurET8JngX5FRjYFqm+UoT1ZTf41y2b5OiLB1l1QjUnblr6YskFaRlgaICCNDgWeh
 hBTeJnRFMQ9Je0djCBzm9c1DeS5vEpMVL/zXF3o+A5dkPaFQO89rGF9kWv/6jtbEYIsx
 266BNjq6ZDz3POlUBAinqxLIDfp7SMztcRFPXGoy76lkfV7w6ArDM9kr7W/6pirDE9SN
 mnVLvuph/v+xh+qafaAiReGjvI1OAORXo0GwWRZDkpJkDqe6d0y28JryTbDzRERFe33i
 xoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787640228; x=1788245028;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YFFnhjcWX2esFqzTXKdNV82QT3BiE47cZiKBya4IY2Y=;
 b=RJGUSqahwgS13PyCe5PJW0bXdl1+U1m6XTQqZFSKEMaJzR33QUGwgYVVraoPa++aVX
 khuHx2nh40Cg9y5Pv/jqMubzZQ8OQb0XFgogQ2YKJPZF3wE9X/ovY9Y8S6o0/CdgfXzb
 so8kuL4c+v6/qpuvHQCPTsCPJDa2hv74nfJGj7VFUI0oIAsRTjsasSgfqjdXiRDfkAUX
 QRetWeOjixff0Bc7y//il5/opvG9/mr8dRx+8L5ITouKJbi45Wz2nhf9JGP7uUG8nTFl
 JTVJNNGQW+luvDWWZZzHmw6ePvKo+sjfmxJXGKd/HXk9rIS+U6Ajj4CsWZGGEgtlg2oU
 Nl3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqTrchf6VGaLlc8F276v1BBkNCzEieF9jFghreMkGhlKCQdv1Qfc0tmKGYhwhk4Lg2SAiP2DR/34ENv+VJdEjc@lists.sourceforge.net
X-Gm-Message-State: AFuF++kvzZAAFog30OMjbfOjL/HUV9+ZE+SDW6CDTZp/Scjwebh9fGSl
 lVOaXzpuJcCfa20vMHHOl/3OOtatfWe9cAwZ+XyzS+GcmqdwdpccA+sCfscS/W60fvmkyBuc8wK
 gPRb95J9NZ54tjtefzrKFUzlSwRaNq0s=
X-Gm-Gg: AR+sD13EprCd2vPRfoJCfrqOGJWJbZdX2CByGiKRv9iZAzWJDKwIWDr8xoK+11xz4Gm
 MFlaF8B1s14HcVKrgCyA0NWDTTq7xn97yLk1c+TWmB4foGGhzH+iMfSouQWSWhKYb3qsvByUCTc
 5dfV+tPGzdaIXGXa4vIyi64kzEGF3O4wzBq9tRioz/RiUVZJgGd27AkN/WA4H+A+ixY3tR08pgS
 kTb421AUKfdC/bSTFwdsUNaFR7Pfj8jY9T4c5r4vmuBYLGsK6Qa9dwhU6sUkAvVPPq582558Z5f
 GNU/+rR1jPfjcSMEkb8Tp+DYbLxbS5BrV9YvzqbzplKiTw==
X-Received: by 2002:a05:6512:8349:b0:5b0:113d:8ad9 with SMTP id
 2adb3069b0e04-5b48422248bmr7654211e87.12.1787640227948; Mon, 24 Aug 2026
 23:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
 <cover.1787564706.git.qiwenjie@xiaomi.com>
 <ef06bf67db77a009d5fc2932069c2b3366d972c4.1787564706.git.qiwenjie@xiaomi.com>
 <ao0stlR57iUgrY2Y@infradead.org>
In-Reply-To: <ao0stlR57iUgrY2Y@infradead.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 25 Aug 2026 14:43:36 +0800
X-Gm-Features: AcwNN1XlfhuMbQQSog0MnhYGpEbeFP_-um6bcH3M-yGPRIQpgDsdeDCHwg1wJxU
Message-ID: <CAGFpFsQmT47aXkRb=6csbTTeTzaG4jGoyFwHJY_TiNEouKeKuw@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1wykt1-0006zc-2R
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: complete dropbehind write bios
 in safe task context
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 Tal Zussman <tz2294@columbia.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICBUaGFua3MsIEkgbWlzc2VkIHRoYXQgdGhlc2UgaGVscGVycyBoYWQgbGFuZGVkIGZvciA3LjMu
CgogIEknbGwgcmViYXNlIHRoZSBuZXh0IHJldmlzaW9uIGFuZCB1c2UgQklPX0NPTVBMRVRFX0lO
X1RBU0sgZm9yIGRyb3BiZWhpbmQKICB3cml0ZSBiaW9zLCByZW1vdmluZyB0aGUgRjJGUy1sb2Nh
bCBjb250ZXh0IGNoZWNrIGFuZCBkcm9wYmVoaW5kLXNwZWNpZmljCiAgd29ya3F1ZXVlIGRlZmVy
cmFsLiBJJ2xsIGFsc28gQ2MgdGhlIHBlb3BsZSBhbmQgbGlzdHMgaW52b2x2ZWQgd2l0aCB0aGUK
ICBjb21tb24gY29kZS4KCk9uIFR1ZSwgQXVnIDI1LCAyMDI2IGF0IDE6NDjigK9QTSBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gT24gTW9uLCBBdWcgMjQs
IDIwMjYgYXQgMDY6MzM6NDZQTSArMDgwMCwgV2VuamllIFFpIHdyb3RlOgo+ID4gQnVmZmVyZWQg
UldGX0RPTlRDQUNIRSB3cml0ZXMgaW52YWxpZGF0ZSBkcm9wYmVoaW5kIGZvbGlvcyBmcm9tIHdy
aXRlYmFjawo+ID4gY29tcGxldGlvbi4gS2VlcCBub3JtYWwgYW5kIGRyb3BiZWhpbmQgZm9saW9z
IGluIHNlcGFyYXRlIHdyaXRlIGJpb3MsIGFuZAo+ID4gZGVmZXIgZHJvcGJlaGluZCBiaW9zIHRv
IHNiaS0+d3EgdW5sZXNzIGNvbXBsZXRpb24gcnVucyBpbiBwcmVlbXB0aWJsZSB0YXNrCj4gPiBj
b250ZXh0Lgo+ID4KPiA+IFVzZSBhbiBGMkZTLWxvY2FsIGNvbnRleHQgY2hlY2sgZm9yIHRoaXMg
ZGVjaXNpb24uIFRhc2sgY29udGV4dCBhbG9uZSBpcwo+ID4gbm90IHN1ZmZpY2llbnQ6IHByZWVt
cHRpb24gbWF5IHN0aWxsIGJlIGRpc2FibGVkLCBvciBjb21wbGV0aW9uIG1heSBydW4gaW4KPiA+
IGEgcHJlZW1wdGlibGUgUkNVIHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0aW9uLgo+ID4KPiA+IEtl
ZXAgdGhlIGV4aXN0aW5nIGxhcmdlLUFUQyBkZWZlcnJhbCB1bmNoYW5nZWQuCj4KPiBQbGVhc2Ug
cmV1c2UgYWxsIHRoZSBoZWxwZXJzIGFkZGVkIGluIGNvbW1vbiBjb2RlIGluIDcuMyBmb3IgZGVm
ZXJyaW5nCj4gYmlvcyBhbmQgdHN0aW5nIGlmIHRoYXQgdGhhdCBpcyBuZWVlZGVkIGluc3RlYWQg
b2YgYmFkbHkgcmVpbnZlbnRpbmcKPiB0aGUgbG9naWMuICBJdCBhbHNvIGlzIHJlYWxseSBoZWxw
ZnVsIHRvIENjIHBlb3BsZSBpbnZvbHZlZCB3aXRoIHRoZQo+IGNvZGUgYW5kIHRoZSByZWxldmFu
dCBtYWlsaW5nIGxpc3RzLgo+Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogV2VuamllIFFpIDxxaXdl
bmppZUB4aWFvbWkuY29tPgo+ID4gLS0tCj4gPiAgZnMvZjJmcy9kYXRhLmMgfCA1MCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1n
aXQgYS9mcy9mMmZzL2RhdGEuYyBiL2ZzL2YyZnMvZGF0YS5jCj4gPiBpbmRleCA2YWUwZWIzN2Qy
MC4uNzc0YTNlMmQ4ZTMgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9mMmZzL2RhdGEuYwo+ID4gKysrIGIv
ZnMvZjJmcy9kYXRhLmMKPiA+IEBAIC0yMSw2ICsyMSw3IEBACj4gPiAgI2luY2x1ZGUgPGxpbnV4
L2ZpZW1hcC5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9pb21hcC5oPgo+ID4gICNpbmNsdWRlIDxs
aW51eC9mc2Vycm9yLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3JjdXBkYXRlLmg+Cj4gPgo+ID4g
ICNpbmNsdWRlICJmMmZzLmgiCj4gPiAgI2luY2x1ZGUgIm5vZGUuaCIKPiA+IEBAIC00Myw5ICs0
NCwyOSBAQCBzdHJ1Y3QgZjJmc19mb2xpb19zdGF0ZSB7Cj4gPgo+ID4gIHN0cnVjdCBmMmZzX2Jp
byB7Cj4gPiAgICAgICBzdHJ1Y3Qgd29ya19zdHJ1Y3Qgd29yazsKPiA+ICsgICAgIGJvb2wgZHJv
cGJlaGluZDsKPiA+ICAgICAgIHN0cnVjdCBiaW8gYmlvOwo+ID4gIH07Cj4gPgo+ID4gK3N0YXRp
YyBzdHJ1Y3QgZjJmc19iaW8gKnRvX2YyZnNfYmlvKHN0cnVjdCBiaW8gKmJpbykKPiA+ICt7Cj4g
PiArICAgICByZXR1cm4gY29udGFpbmVyX29mKGJpbywgc3RydWN0IGYyZnNfYmlvLCBiaW8pOwo+
ID4gK30KPiA+ICsKPiA+ICsvKiBLZWVwIGluIHN5bmMgd2l0aCB0aGUgcHJvcG9zZWQgYmxvY2st
bGF5ZXIgYmlvX2luX2F0b21pYygpLiAqLwo+ID4gK3N0YXRpYyBib29sIGYyZnNfYmlvX2luX2F0
b21pYyh2b2lkKQo+ID4gK3sKPiA+ICsjaWZkZWYgQ09ORklHX1BSRUVNUFRJT04KPiA+ICsgICAg
IGlmIChyY3VfcHJlZW1wdF9kZXB0aCgpKQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsK
PiA+ICsjZW5kaWYKPiA+ICsjaWZuZGVmIENPTkZJR19QUkVFTVBUX0NPVU5UCj4gPiArICAgICBy
ZXR1cm4gdHJ1ZTsKPiA+ICsjZWxzZQo+ID4gKyAgICAgcmV0dXJuICFwcmVlbXB0aWJsZSgpOwo+
ID4gKyNlbmRpZgo+ID4gK30KPiA+ICsKPiA+ICAjZGVmaW5lICAgICAgRjJGU19CSU9fUE9PTF9T
SVpFICAgICAgTlJfQ1VSU0VHX1RZUEUKPiA+Cj4gPiAgaW50IF9faW5pdCBmMmZzX2luaXRfYmlv
c2V0KHZvaWQpCj4gPiBAQCAtNDI2LDEyICs0NDcsMTMgQEAgc3RhdGljIHZvaWQgZjJmc193cml0
ZV9lbmRfaW8oc3RydWN0IGJpbyAqYmlvKQo+ID4KPiA+ICAgICAgIHNiaSA9IGJpby0+YmlfcHJp
dmF0ZTsKPiA+Cj4gPiAtICAgICBpZiAoaW5fYXRvbWljKCkgJiYgYmlvLT5iaV9pdGVyLmJpX3Np
emUgPiBzYmktPm1heF9hdGNfd3JpdGVfYmlvX3NpemUpIHsKPiA+IC0gICAgICAgICAgICAgc3Ry
dWN0IHdvcmtfc3RydWN0ICp3Owo+ID4gKyAgICAgaWYgKCh0b19mMmZzX2JpbyhiaW8pLT5kcm9w
YmVoaW5kICYmIGYyZnNfYmlvX2luX2F0b21pYygpKSB8fAo+ID4gKyAgICAgICAgIChpbl9hdG9t
aWMoKSAmJgo+ID4gKyAgICAgICAgICBiaW8tPmJpX2l0ZXIuYmlfc2l6ZSA+IHNiaS0+bWF4X2F0
Y193cml0ZV9iaW9fc2l6ZSkpIHsKPiA+ICsgICAgICAgICAgICAgc3RydWN0IHdvcmtfc3RydWN0
ICp3b3JrID0gJnRvX2YyZnNfYmlvKGJpbyktPndvcms7Cj4gPgo+ID4gLSAgICAgICAgICAgICB3
ID0gJmNvbnRhaW5lcl9vZihiaW8sIHN0cnVjdCBmMmZzX2JpbywgYmlvKS0+d29yazsKPiA+IC0g
ICAgICAgICAgICAgSU5JVF9XT1JLKHcsIGYyZnNfd3JpdGVfZW5kX2lvX3dvcmspOwo+ID4gLSAg
ICAgICAgICAgICBxdWV1ZV93b3JrKHNiaS0+d3EsIHcpOwo+ID4gKyAgICAgICAgICAgICBJTklU
X1dPUksod29yaywgZjJmc193cml0ZV9lbmRfaW9fd29yayk7Cj4gPiArICAgICAgICAgICAgIHF1
ZXVlX3dvcmsoc2JpLT53cSwgd29yayk7Cj4gPiAgICAgICB9IGVsc2Ugewo+ID4gICAgICAgICAg
ICAgICBmMmZzX3dyaXRlX2VuZF9iaW8oYmlvKTsKPiA+ICAgICAgIH0KPiA+IEBAIC01MzAsNiAr
NTUyLDggQEAgc3RhdGljIHN0cnVjdCBiaW8gKl9fYmlvX2FsbG9jKHN0cnVjdCBmMmZzX2lvX2lu
Zm8gKmZpbywgaW50IG5wYWdlcykKPiA+ICAgICAgIGJpbyA9IGJpb19hbGxvY19iaW9zZXQoYmRl
diwgbnBhZ2VzLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlvLT5vcCB8IGZp
by0+b3BfZmxhZ3MgfCBmMmZzX2lvX2ZsYWdzKGZpbyksCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBHRlBfTk9JTywgJmYyZnNfYmlvc2V0KTsKPiA+ICsgICAgIHRvX2YyZnNfYmlv
KGJpbyktPmRyb3BiZWhpbmQgPQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICFpc19yZWFkX2lv
KGZpby0+b3ApICYmIGZvbGlvX3Rlc3RfZHJvcGJlaGluZChmaW8tPmZvbGlvKTsKPiA+ICAgICAg
IGJpby0+YmlfaXRlci5iaV9zZWN0b3IgPSBzZWN0b3I7Cj4gPiAgICAgICBpZiAoaXNfcmVhZF9p
byhmaW8tPm9wKSkgewo+ID4gICAgICAgICAgICAgICBiaW8tPmJpX2VuZF9pbyA9IGYyZnNfcmVh
ZF9lbmRfaW87Cj4gPiBAQCAtODI1LDYgKzg0OSwxMyBAQCBzdGF0aWMgYm9vbCBwYWdlX2lzX21l
cmdlYWJsZShzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksIHN0cnVjdCBiaW8gKmJpbywKPiA+ICAg
ICAgIHJldHVybiBiaW8tPmJpX2JkZXYgPT0gZjJmc190YXJnZXRfZGV2aWNlKHNiaSwgY3VyX2Js
a2FkZHIsIE5VTEwpOwo+ID4gIH0KPiA+Cj4gPiArc3RhdGljIGJvb2wgZjJmc19iaW9fZHJvcGJl
aGluZF9tZXJnZWFibGUoc3RydWN0IGJpbyAqYmlvLAo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBmMmZzX2lvX2luZm8gKmZpbykKPiA+ICt7Cj4gPiAr
ICAgICByZXR1cm4gdG9fZjJmc19iaW8oYmlvKS0+ZHJvcGJlaGluZCA9PQo+ID4gKyAgICAgICAg
ICAgICBmb2xpb190ZXN0X2Ryb3BiZWhpbmQoZmlvLT5mb2xpbyk7Cj4gPiArfQo+ID4gKwo+ID4g
IHN0YXRpYyBib29sIGlvX3R5cGVfaXNfbWVyZ2VhYmxlKHN0cnVjdCBmMmZzX2Jpb19pbmZvICpp
bywKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgZjJmc19pb19pbmZvICpmaW8pCj4gPiAgewo+ID4gQEAgLTEwMTcsOCArMTA0OCwxMCBAQCBp
bnQgZjJmc19tZXJnZV9wYWdlX2JpbyhzdHJ1Y3QgZjJmc19pb19pbmZvICpmaW8pCj4gPgo+ID4g
ICAgICAgdHJhY2VfZjJmc19zdWJtaXRfZm9saW9fYmlvKGRhdGFfZm9saW8sIGZpbyk7Cj4gPgo+
ID4gLSAgICAgaWYgKGJpbyAmJiAhcGFnZV9pc19tZXJnZWFibGUoZmlvLT5zYmksIGJpbywgKmZp
by0+bGFzdF9ibG9jaywKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBmaW8tPm5ld19ibGthZGRyKSkKPiA+ICsgICAgIGlmIChiaW8gJiYKPiA+ICsgICAg
ICAgICAoIXBhZ2VfaXNfbWVyZ2VhYmxlKGZpby0+c2JpLCBiaW8sICpmaW8tPmxhc3RfYmxvY2ss
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmaW8tPm5ld19ibGthZGRyKSB8fAo+
ID4gKyAgICAgICAgICAhZjJmc19iaW9fZHJvcGJlaGluZF9tZXJnZWFibGUoYmlvLCBmaW8pKSkK
PiA+ICAgICAgICAgICAgICAgZjJmc19zdWJtaXRfbWVyZ2VkX2lwdV93cml0ZShmaW8tPnNiaSwg
JmJpbywgTlVMTCk7Cj4gPiAgYWxsb2NfbmV3Ogo+ID4gICAgICAgaWYgKCFiaW8pIHsKPiA+IEBA
IC0xMTE4LDcgKzExNTEsOCBAQCB2b2lkIGYyZnNfc3VibWl0X3BhZ2Vfd3JpdGUoc3RydWN0IGYy
ZnNfaW9faW5mbyAqZmlvKQo+ID4gICAgICAgICAgICghaW9faXNfbWVyZ2VhYmxlKHNiaSwgaW8t
PmJpbywgaW8sIGZpbywgaW8tPmxhc3RfYmxvY2tfaW5fYmlvLAo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGZpby0+bmV3X2Jsa2FkZHIpIHx8Cj4gPiAgICAgICAgICAgICFmMmZzX2Ny
eXB0X21lcmdlYWJsZV9iaW8oaW8tPmJpbywgZmlvX2lub2RlKGZpbyksCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBiaW9fZm9saW8tPmluZGV4LCBmaW8pKSkKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJpb19mb2xpby0+aW5kZXgsIGZpbykgfHwKPiA+ICsgICAg
ICAgICAgIWYyZnNfYmlvX2Ryb3BiZWhpbmRfbWVyZ2VhYmxlKGlvLT5iaW8sIGZpbykpKQo+ID4g
ICAgICAgICAgICAgICBfX3N1Ym1pdF9tZXJnZWRfYmlvKGlvKTsKPiA+ICBhbGxvY19uZXc6Cj4g
PiAgICAgICBpZiAoaW8tPmJpbyA9PSBOVUxMKSB7Cj4gPiAtLQo+ID4gMi40My4wCj4gPgo+IC0t
LWVuZCBxdW90ZWQgdGV4dC0tLQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
