Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D17CD5BD0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gfh94HlZX38Eyvgu5MH9Hl57YghsiXZ3b2yw2ho/hS0=; b=Tp4ZV3wfFoLs6WSEoMRKBMgXSr
	rT9O6vsWxIN1od93MQ9X4yNRI+2TdbjS1/cDSZHVVsTSQMJ2IJ5IYXpba1eaIoowy0JYMGMd99gfp
	lU3G4PIJKSnA0jvMT6/HfdCWtTivdeptenBXyy0ybA5lceBiExxNJcvuftqj8I4+XbMY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRq8o-0006rO-Ve;
	Tue, 26 May 2026 11:40:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wRq8m-0006rI-GU
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 11:40:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AuE68QWTDjXxJhuOXj81+H/dNFLHFmhHOTufMSz6duY=; b=L9hWHPPc/mCYrLEMZVn2Le7Rbo
 IC6sDexEGY/dP9bqdL7iYWIkULml+L43cL76NgB78D2L0FhF9Eo63ax7slO130NF3h+Qa0FDNEHPX
 fzmphFsPSU3yk/uEhzjwyu6qu3nnIwUN3SPen7JmXToEWyyCezfepiXwgny3+ts9Gf8Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AuE68QWTDjXxJhuOXj81+H/dNFLHFmhHOTufMSz6duY=; b=lJq/B/dKjkhLw03LHkYx/GpS6/
 ZsHtTj+GceEVu1hJZMY/vPbCLgg53ylnw3zVtnmw5Nuh8PGmTc+KGJE7DuI9Pz4VHwySv0IDwMQAs
 1fHcnmCvPORPsQqshZFzha48sJVKfPIzRrINVXoSPGcqfoODsLg5XYYl3Y6SQtcKmzeY=;
Received: from mail-lf1-f52.google.com ([209.85.167.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wRq8g-00042l-OA for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 11:40:05 +0000
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5aa2d5a1d51so3777157e87.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 26 May 2026 04:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779795591; cv=none;
 d=google.com; s=arc-20240605;
 b=lbvd7zJ5KDds1ZGCsU501yHD77mLpH4hv1gvqBfBfvLk54wVYNHXckjj10oBsTVmPe
 nCOdeacGdkHT3ti4T7fTmPEO05Kl6mrjYDkq9ufZVimNViE4vLFpgb/6Np15MYca4EGf
 fodHUkyFYUOZN+xDANTuMD1ODPVlf8NGbs3ytTsEN9Kxri7g7R2Hsz/jUfMvzc6U31JN
 V+m6Fy/1QbMjlViZvxPg1XQ/rDtkWuezsdYYHPW7YosLdBiY3n3CPU35EPPQL8uCUYWV
 Fwxi9CKJBB+TOlmHqWj4WGZJsUzqZ2aUnynXQhswO5BcxaeW/HzTqYZGwovE5gmsKGYr
 2xDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AuE68QWTDjXxJhuOXj81+H/dNFLHFmhHOTufMSz6duY=;
 fh=PJlULDULG59E0K5Xd9KMq9kqkCEqgFD1nlAeaAnE0s4=;
 b=kfwEsIjstIF1rjqeICGlTD0/8pmhUWqBFbzoJxK7FdrQtdvHWctk6aonoAapRRUOK4
 SBvanZUY3zQlt9gaO1SbiNPq4UdVisfXc7GYf0NfSiDgZmeBbpK9PFMhr79emvaX256d
 xY6yd7x2qbdN7+QdYKJBR/9niXbeD5m0IAJz380bL0R7l1OBgXpVAJrGMYxpVBkU79fC
 EZNrJXQnOlEp60QofY3QiKDnt79QZDEShPVgffz24eZ5oBihsF93+C4dHR5d+T/5pLee
 7SOHRMxVLAy24tB+MXHH6MQN3YIbAeDNNkTLEx/Ikc2rLnpMujXSpdmzAo4OguaUJPi+
 pxmw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779795591; x=1780400391; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuE68QWTDjXxJhuOXj81+H/dNFLHFmhHOTufMSz6duY=;
 b=gX/IGwrhZYXK1zZX4M7N0DXVDRl9naKsyhUQTABEJLf3OU+FlEVfSWicmQwcqc+TT9
 h75yHzGLeMKbdQclUsHh0pJx8q/5pqIb2ER+LJab2XUqmZ64u4/dXvWA0jpsS/grW5Qp
 +OxgrRYukLJuqSR29jyN7MFFl1zO+a76RvQ4tzrfixqn23wiLP57p+muwVaMkMEuFQtj
 VJe1MyrKDyxGW8VTXdpdTnDzjpKjKz6dA/G0Jh78WmpYRwQvPhWBTVSXyOUFhUrFclux
 HRQMr5zPyNigJi/P5LrGKqHSVvMEPHWKyBYLHL9qAUkA45R6Dzts0PHJCqeURp5WZgFI
 yCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795591; x=1780400391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AuE68QWTDjXxJhuOXj81+H/dNFLHFmhHOTufMSz6duY=;
 b=GcCwaHjnJPnwSdkbgrXQOxNEkPNo7tE/mnqrS5x1XWucHzsrI5y47AOqYiIvhB6AuN
 cjfUJQSnVU1osEMoaCUYwXfJ+1z9ZTYOMj6bU1tNAiDTT7SdzKfvStXvLyZxcGCb9iNC
 AadjtMgSKfz93HYWLxjkjeCcFT/defQol25G49IPb6R9XdFOhcgU1wdY1VVYVwBnUvJY
 nuVkLjJfqC5WHId+eFZJREjBCCVRItJe1t8DhlM8YbgeaZmeWtb4JGRtYbEKuO+aleMk
 ePrCwT1JPFqosH4dDXORZPmEOWY8pNCnOvTJ0GbBYFPc0mFhyKPUZJEGre2nZE65NSgK
 cjbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qauRjgmYL0I3abfSbD15QbhrRQ1ORwES7RHmdcv86drbWceAzfzLkYMKmABRVL9UJFyoEbJXDS8Qo4i9V7QP7@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyhzTSJoGMYUeAZOLfWUhluyXiTM3Y4uGP5+AZgSKndFNAW6vUY
 HteI1+tDwQrvLYDRYEFrzNgyDRvDPplmMUxo1kWUXXKFUrHfvOU55A00jcCdCebgbCRY+rhoyS2
 sXJaUkFg2yRL28MM+qQJoIumHAk4ARuY=
X-Gm-Gg: Acq92OGHwdecLcO4t+BJB1X4y+SOaUrRAl6nujF7fa3eFaOz4m3Jy+ORiVunJj92XPN
 YEXZ8YzeJMUZxwmzL/iu0x8X8uzdaoUGzsi0bGUDNddkHMRvyQ5JbEHt3l45/O4rBimrYhB+9Yf
 +lUNFJTQBQudqRvt+VSfdzAQEU6PizGqGjdThiCFYyUgTOGOoREWILW5EoGrCV14CJZLtBfT6Mh
 KCagAQ6F4C35fh1mot/vZlSNQskosqslknQcHsK1gA3bPA02oe9KAJgSz10LmKGyIbfLOc5tgnD
 1nb/2XiW
X-Received: by 2002:a05:6512:1108:b0:5aa:106f:87bb with SMTP id
 2adb3069b0e04-5aa3237d3d0mr5173917e87.3.1779795591119; Tue, 26 May 2026
 04:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260525114621.571845-1-qiwenjie@xiaomi.com>
 <86c2f79d-ee26-4009-8051-82d25abf6d7b@kernel.org>
 <CAGFpFsQimHFADZGKA2ezyz7eXRG1mMNFOFiJHbsQban_vjb5qQ@mail.gmail.com>
 <534bc0fc-bb0f-4741-9156-11a66d47f1c3@kernel.org>
In-Reply-To: <534bc0fc-bb0f-4741-9156-11a66d47f1c3@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 26 May 2026 19:39:37 +0800
X-Gm-Features: AVHnY4Jd1D5OXqF-D77wYlSiRAOSDzH1-Xe05ivm-yoWqM0B6KkN4CH_Zc3ySAs
Message-ID: <CAGFpFsSYCBPMOkcf2UEX0DCVZG+29zGtNtbsjpBCWA-OKg57iw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wRq8g-00042l-OA
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate orphan inode entry count
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICBZZXMuIEkgc2VudCBhIHNlcGFyYXRlIGYyZnMtdG9vbHMgcGF0Y2ggdG8gcmVjb2duaXplIGFu
ZCBwcmludCB0aGUgbmV3CiAgRVJST1JfSU5DT05TSVNURU5UX09SUEhBTiBzX2Vycm9ycyBiaXQg
aW4gZnNjay5mMmZzOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZjJmcy1kZXZlbC8y
MDI2MDUyNjExMzUwNS4xMzEyNDMxLTEtcWl3ZW5qaWVAeGlhb21pLmNvbS9ULyN1CgogIFRoYW5r
cywKCk9uIFR1ZSwgTWF5IDI2LCAyMDI2IGF0IDc6MDPigK9QTSBDaGFvIFl1IDxjaGFvQGtlcm5l
bC5vcmc+IHdyb3RlOgo+Cj4gT24gNS8yNi8yNiAxMzozOCwgV2VuamllIFFpIHdyb3RlOgo+ID4g
QWdyZWVkLCBTQklfTkVFRF9GU0NLIG1heSBub3QgYmUgcGVyc2lzdGVkIGF0IHRoaXMgc3RhZ2Uu
Cj4gPgo+ID4gICBJIHNlbnQgdjIgdG8gYWRkIEVSUk9SX0lOQ09OU0lTVEVOVF9PUlBIQU4gYW5k
IGNhbGwgZjJmc19oYW5kbGVfZXJyb3IoKSBvbgo+ID4gICBpbnZhbGlkIG9ycGhhbiBlbnRyeV9j
b3VudCwgc28gdGhlIGNvcnJ1cHRpb24gcmVhc29uIGNhbiBiZSByZWNvcmRlZCBpbgo+ID4gICBz
X2Vycm9yc1tdIGFzIGEgcGVyc2lzdGVudCBoaW50IGZvciBmc2NrLgo+Cj4gU28sIGl0IG5lZWRz
IGFub3RoZXIgcGF0Y2ggdG8gbGV0IGZzY2sgcmVjb2duaXplIHRoZSBuZXcgZmxhZz8KPgo+IFRo
YW5rcywKPgo+ID4KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWYyZnMtZGV2ZWwv
MjAyNjA1MjYwNTM1NTcuMTA5NjIyOS0xLXFpd2VuamllQHhpYW9taS5jb20vVC8jdQo+ID4KPiA+
IE9uIFR1ZSwgTWF5IDI2LCAyMDI2IGF0IDEwOjE54oCvQU0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwu
b3JnPiB3cm90ZToKPiA+Pgo+ID4+IE9uIDUvMjUvMjYgMTk6NDYsIFdlbmppZSBRaSB3cm90ZToK
PiA+Pj4gZjJmc19yZWNvdmVyX29ycGhhbl9pbm9kZXMoKSB0cnVzdHMgdGhlIG9ycGhhbiBibG9j
ayBlbnRyeV9jb3VudCB3aGVuCj4gPj4+IHJlcGxheWluZyBvcnBoYW4gaW5vZGVzIGZyb20gdGhl
IGNoZWNrcG9pbnQgcGFjay4gIEEgY29ycnVwdGVkCj4gPj4+IGVudHJ5X2NvdW50IGxhcmdlciB0
aGFuIEYyRlNfT1JQSEFOU19QRVJfQkxPQ0sgbWFrZXMgdGhlIHJlY292ZXJ5IGxvb3AKPiA+Pj4g
cmVhZCBwYXN0IHRoZSBpbm9bXSBhcnJheSBhbmQgaW50ZXJwcmV0IGZvb3RlciBvciBmb2xsb3dp
bmcgZGF0YSBhcwo+ID4+PiBpbm9kZSBudW1iZXJzLgo+ID4+Pgo+ID4+PiBPbiBhIGNyYWZ0ZWQg
aW1hZ2UsIG1vdW50aW5nIGFuIHVucGF0Y2hlZCBrZXJuZWwgY2FuIGRyaXZlIG9ycGhhbgo+ID4+
PiByZWNvdmVyeSBpbnRvIGYyZnNfYnVnX29uKCkgYW5kIHBhbmljIHRoZSBrZXJuZWwuICBWYWxp
ZGF0ZSBlbnRyeV9jb3VudAo+ID4+PiBiZWZvcmUgY29uc3VtaW5nIGVudHJpZXMgc28gY29ycnVw
dGVkIGNoZWNrcG9pbnQgZGF0YSBmYWlscyB0aGUgbW91bnQKPiA+Pj4gd2l0aCAtRUZTQ09SUlVQ
VEVEIGFuZCByZXF1ZXN0cyBmc2NrIGluc3RlYWQuCj4gPj4+Cj4gPj4+IEZpeGVzOiAxMjdlNjcw
YWJmYTcgKCJmMmZzOiBhZGQgY2hlY2twb2ludCBvcGVyYXRpb25zIikKPiA+Pj4gQ2M6IHN0YWJs
ZUBrZXJuZWwub3JnCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFdlbmppZSBRaSA8cWl3ZW5qaWVAeGlh
b21pLmNvbT4KPiA+Pj4gLS0tCj4gPj4+ICBmcy9mMmZzL2NoZWNrcG9pbnQuYyB8IDEzICsrKysr
KysrKysrKy0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4gPj4+Cj4gPj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2NoZWNrcG9pbnQuYyBiL2Zz
L2YyZnMvY2hlY2twb2ludC5jCj4gPj4+IGluZGV4IGMwMGE2YjZlYmNiZC4uZmM3MmI2OWZmNzY5
IDEwMDY0NAo+ID4+PiAtLS0gYS9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+ID4+PiArKysgYi9mcy9m
MmZzL2NoZWNrcG9pbnQuYwo+ID4+PiBAQCAtOTQzLDYgKzk0Myw3IEBAIGludCBmMmZzX3JlY292
ZXJfb3JwaGFuX2lub2RlcyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmkpCj4gPj4+ICAgICAgIGZv
ciAoaSA9IDA7IGkgPCBvcnBoYW5fYmxvY2tzOyBpKyspIHsKPiA+Pj4gICAgICAgICAgICAgICBz
dHJ1Y3QgZm9saW8gKmZvbGlvOwo+ID4+PiAgICAgICAgICAgICAgIHN0cnVjdCBmMmZzX29ycGhh
bl9ibG9jayAqb3JwaGFuX2JsazsKPiA+Pj4gKyAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgZW50
cnlfY291bnQ7Cj4gPj4+Cj4gPj4+ICAgICAgICAgICAgICAgZm9saW8gPSBmMmZzX2dldF9tZXRh
X2ZvbGlvKHNiaSwgc3RhcnRfYmxrICsgaSk7Cj4gPj4+ICAgICAgICAgICAgICAgaWYgKElTX0VS
Uihmb2xpbykpIHsKPiA+Pj4gQEAgLTk1MSw3ICs5NTIsMTcgQEAgaW50IGYyZnNfcmVjb3Zlcl9v
cnBoYW5faW5vZGVzKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSkKPiA+Pj4gICAgICAgICAgICAg
ICB9Cj4gPj4+Cj4gPj4+ICAgICAgICAgICAgICAgb3JwaGFuX2JsayA9IGZvbGlvX2FkZHJlc3Mo
Zm9saW8pOwo+ID4+PiAtICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBsZTMyX3RvX2NwdShv
cnBoYW5fYmxrLT5lbnRyeV9jb3VudCk7IGorKykgewo+ID4+PiArICAgICAgICAgICAgIGVudHJ5
X2NvdW50ID0gbGUzMl90b19jcHUob3JwaGFuX2Jsay0+ZW50cnlfY291bnQpOwo+ID4+PiArICAg
ICAgICAgICAgIGlmIChlbnRyeV9jb3VudCA+IEYyRlNfT1JQSEFOU19QRVJfQkxPQ0spIHsKPiA+
Pj4gKyAgICAgICAgICAgICAgICAgICAgIGYyZnNfZXJyKHNiaSwgImludmFsaWQgb3JwaGFuIGlu
b2RlIGVudHJ5IGNvdW50ICV1IiwKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGVudHJ5X2NvdW50KTsKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHNldF9zYmlfZmxhZyhz
YmksIFNCSV9ORUVEX0ZTQ0spOwo+ID4+Cj4gPj4gV2VsbCwgYXQgdGhpcyBzdGFnZSwgSSBndWVz
cyB0aGVyZSBpcyBubyBjaGFuY2UgdG8gcGVyc2lzdCBTQklfTkVFRF9GU0NLIGZsYWcsCj4gPj4g
d2hhdCBhYm91dCBpbnRyb2R1Y2UgRVJST1JfSU5DT05TSVNURU5UX09SUEhBTiBpbiBlbnVtIGYy
ZnNfZXJyb3IsIHNvIHRoYXQKPiA+PiB3ZSBjYW4gcGVyc2lzdCB0aGUgbmV3IGJpdCB0byBwcm92
aWRlIGhpbnQgdG8gZnNjaz8KPiA+Pgo+ID4+IFRoYW5rcywKPiA+Pgo+ID4+PiArICAgICAgICAg
ICAgICAgICAgICAgZXJyID0gLUVGU0NPUlJVUFRFRDsKPiA+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgIGYyZnNfZm9saW9fcHV0KGZvbGlvLCB0cnVlKTsKPiA+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gb3V0Owo+ID4+PiArICAgICAgICAgICAgIH0KPiA+Pj4gKwo+ID4+PiArICAgICAg
ICAgICAgIGZvciAoaiA9IDA7IGogPCBlbnRyeV9jb3VudDsgaisrKSB7Cj4gPj4+ICAgICAgICAg
ICAgICAgICAgICAgICBuaWRfdCBpbm8gPSBsZTMyX3RvX2NwdShvcnBoYW5fYmxrLT5pbm9bal0p
Owo+ID4+Pgo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgZXJyID0gcmVjb3Zlcl9vcnBoYW5f
aW5vZGUoc2JpLCBpbm8pOwo+ID4+Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZz
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
