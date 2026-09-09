Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F1BC79FB7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ACeXuiUC/t22QmaFMktEg6EyRCAAHZWkPF8i0o9mEeo=; b=NBKIkCJcbSIdBHbE9xPLf7ZDl5
	gCODwVrU1HvOX51PYABGCYjOtJTzJ121b+N836DE99dsoLbf72gK8vkH29Q4OHkG1qd4JLjpqGOST
	j5IOzuSM9svVWnE7We+/q7POp3zR+OvxbgG5aqN9Pre/ojULqAD7faFNkyEV1ZOFqJd0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4PSL-0005fB-Tq;
	Wed, 09 Sep 2026 21:03:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4PSJ-0005f5-QQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 21:03:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QOSuGBOZT9M6KIAo4leiz4E8LztOD1fqEqF+/FyjpRo=; b=SMva48HOaf+Z26eXCAXx/2W3Z+
 PYo0eRhoVJlVnLDwsWc6Akj8yoVQtuItj9lmtAbH3HcyoORaMtW+rxN6/Vh35askn4tcqrlIor0zl
 BEm/6PgGxwc6xbiDEU8e8YRDb8XfHTMFXDdqaMaLfajQYLJpI9DZj9ATlK9DJyr1gPTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QOSuGBOZT9M6KIAo4leiz4E8LztOD1fqEqF+/FyjpRo=; b=UISUwqVjFnqpD9nCcvFU29NA01
 o3nT90b099rTCNP7hwwuuD/qlqWSMumyH0Heoxxw3cs3sYpaZ137eY95BgK1CYbc+PPBRfJIIFNCh
 TIk4zD8upoKJqhlb98Ab3HromI+5ihXVwnG5xqcUl44YZqumLkmF2BQHRyFpTnBt7Qv0=;
Received: from mail-lf1-f51.google.com ([209.85.167.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4PSF-0007nm-Qe for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 21:03:41 +0000
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5b6036e9c70so5015133e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 14:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788987813; cv=none;
 d=google.com; s=arc-20260327;
 b=Y+ZHNnYxMJt/eW8HIhKg77IaEpyz1CWIrONrohKBnRgiX8raXibaalJdXVWjnS2eg6
 hXB+RskFRjRKKFfLAbYUD6b2uFy3SWgy92IiJEAH8hLaegZV2Gc1vdg99ipyrGgsYSOn
 yl45HfcbM/dRV8+H1YvcwSK9DSIH5XsfaUMb5T60WihjKR/qn2r+moXuhvODHBVZv9Rx
 HIM6Q/eYNJZaURIQ0+Q6KlA+zz6+tinfuxCFJf1YH60ZfDBQEj2rjaRCWDLc++gAVGsY
 DmAkpfZl2SMrBR5AE/E2iJnpViwwD+q5nbr1PHxqmTsOTZ3SjqTuY1yxxD6G2Zr1RWQJ
 izyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QOSuGBOZT9M6KIAo4leiz4E8LztOD1fqEqF+/FyjpRo=;
 fh=vmwOz5d31sD0j6Toy7al6sh5d2jjkGSU6dWPWUNvsQk=;
 b=OMdNAjssYJf4Fq5c3d9P4fkLjZJlinB94CY5pyXNNMK+ok7a+E6+h5oEMr7pJDN7Vu
 4Dxt9d6hGWi2owYGOptzzsvmJRHaGxOubODEB2CZo4IxvjMNCCLs6q29+Y758DW0OInQ
 9E9ceNXMAiCG2ZN8dZtiYs4GH9JM9flyNCOSBOxMwOIxceeJaMgtQ029Me6mf9TR+FJo
 VQ0S8p+dUtsQo02ks9acOSqfhwDv09MslYk98uhFbfJcaB++2qlQQi5VvSgR4v4RyyN2
 Z9DL0QcwnK/2/sF0kD/P1miTe7oSXPXV8rlZ1teg9H1C//MFMisW7FPSAEPEhG1W2LP6
 myGQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788987813; x=1789592613; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QOSuGBOZT9M6KIAo4leiz4E8LztOD1fqEqF+/FyjpRo=;
 b=QMbyY3tFPar0LPiLBBv/O8vhVwntFICIN7bBH0Nj86gcSEM3Da9ST9W89iATuPhnVR
 ZoDD1qkKkW2oFQSznKnvgmCJsEHeI9Y10OM7gNVJLRf6zlWvkYll0Fl2nB4eWCxsFL0H
 s/z96Q1YwCzqtS1gNtjoISk4+gbYKvOW3u/QUenNo9z8Vy82v4dDipCN7ybMCVY3vqSr
 F57a2vsXbSg9eXO+FSJunZffZyC+uQR8a40g2kn5VkZ+BWVnQ0UOLc2MEg7R6+fZgGst
 kHmULhqc0zDJ7aJUFT8jPsXq5ywN39AamPgKTryJFr5yKf4CGYyu5h6Y6iP3PMiQUXoz
 LsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788987813; x=1789592613;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QOSuGBOZT9M6KIAo4leiz4E8LztOD1fqEqF+/FyjpRo=;
 b=kWPQUl0m209HNdEDXLv7tvZkBB9K7vEZ0JSdKTtCC+4zbcuGuajGcNUeBNc+paF10i
 Ipduq6uBAKRrZR6pTNQ9RUWS0G7yw3l4LEqfcTcLGNHYN9NAwagJPKphgoE44n/HMYbZ
 VvJtL6JQQVl/m9ApsAY6tsJF9CwCCrEfHfQLuXaV35/crPcErXP7qPFYh6xJzZGckqp2
 Qk0XreBwAhxmZDJNF8jgfKsCCHM6L91yoeLCaZEyQTF1uA6CjTFVCInd1+yl5pJak9cB
 ZYczcjHjNru3WJvqktxobVy88PYM5X0WsoVM1/uJDsmBOgiqnfrRINK/880SBCHkblke
 TGkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9yOgY2s6vh7LXk81/n45UWXiCV7tVm9OIqVCwFlvjMlFgyVRy+m2kiL6AyIoa17RelnT/mwBES12KSPEzI+VD@lists.sourceforge.net
X-Gm-Message-State: AFuF++m9FZqCTGBe6jKSBMhcwYSWfq0ETPNV/sB8YjxfUZtWOdTif/8W
 cjEL8JUlh6ChV0O/Z5vicDPGquXpRylvzCkxyhapJYVEifo6rkwuh8DHYc7JybCriVdelgkiYte
 gdjvfeTQVaup+GMZzK13Qtj/+/AAirfg=
X-Gm-Gg: AYBFou3x/tSqFerrUvwfLn4BOo1Xc7yv+Bfkq8kE9Z7jBsgpbsZ8BHUBYjUSEcGdYpV
 C3dDW+IMy/MjkWh6+zfVY89OUtzdFFZpiFkkIwHbr/ArxiECToKAxV9ipU7PdnkyL6mOwoMM/8b
 GmqLFuUkdWsqtPyjnXHcFbus/q8rdQAKz5iREFlf2zZFs3F2LP6omm/jDpFd204aGF24rGnMkTu
 C0DkNaFXpIehnRr6ecfkSu8dBoskVbED/ME/LSJVXRpjuumnqsuhOnr4QZ1x6wkVAq4o+xTPmef
 RVr18OUVErbGPO17AT03wXiOI4cUGF10nMTEYNhiCB1xIknyVce3M7mrfdmH6QYKMF30DWkIiud
 /Ul6LHU1SjFSkU2C14i+3JhUWp3QyZql7jUb+R7s3lkq9
X-Received: by 2002:a05:6512:b8d:b0:5b6:1a7c:28 with SMTP id
 2adb3069b0e04-5b61a7c0215mr6003626e87.43.1788987812940; Wed, 09 Sep 2026
 14:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_yX2vdMhZEUyYH6TaS1wHNp3axu-bjuZY+3XsnfM4oGzQ@mail.gmail.com>
 <20260907035746.2189242-1-zhaonanzhe@xiaomi.com>
In-Reply-To: <20260907035746.2189242-1-zhaonanzhe@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 9 Sep 2026 14:03:20 -0700
X-Gm-Features: AcwNN1UYYkHafCjlI7TIc2HEqXYrPv2bUE1rGzZnomZAxNA3fndG9uFj3uWF4Ho
Message-ID: <CACOAw_zhxctzmRhzGSA0mUvQ+jBjiPSz23FjUu-VtmSpNWq7Eg@mail.gmail.com>
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Headers-End: 1x4PSF-0007nm-Qe
Subject: Re: [f2fs-dev] [PATCH 05/14] f2fs: support large folio writeback
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gU3VuLCBTZXAgNiwgMjAyNiBhdCA4OjU34oCvUE0gTmFuemhlIFpoYW8gPG56emhhby5zaWdt
YUBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCAzIFNlcCAyMDI2IDIxOjA0OjM2IC0wNzAw
LCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IEluIF9faGFzX21lcmdlZF9wYWdlKCksIHRhcmdldC0+
bWFwcGluZyBpcyBkaXJlY3RseSBkZXJlZmVyZW5jZWQuIEZvciB0YWlsCj4gPiBwYWdlcywgdGFy
Z2V0LT5tYXBwaW5nIGNvbnRhaW5zIGNvbXBvdW5kX2hlYWQgbWV0YWRhdGEgcmF0aGVyIHRoYW4g
YSB2YWxpZAo+ID4gYWRkcmVzc19zcGFjZSBwb2ludGVyLCBsZWFkaW5nIHRvIGEga2VybmVsIGNy
YXNoIHdoZW4gYWNjZXNzaW5nCj4gPiB0YXJnZXQtPm1hcHBpbmctPmhvc3QuCj4KPiBUaGFua3Mg
Zm9yIHRoZSByZXZpZXcuCj4KPiBJJ3ZlIGJlZW4gdGVzdGluZyBvbiA2LjE4LWJhc2VkIChBbmRy
b2lkKSBhbmQgNy4yLXJjNSB0cmVlcywgYW5kIGluCj4gYm90aCBvZiB0aGVtIGJpb19mb3JfZWFj
aF9mb2xpb19hbGwoKSBnb2VzIHRocm91Z2ggYmlvX2ZpcnN0X2ZvbGlvKCksCj4gd2hpY2ggcmVz
b2x2ZXMgdGhlIGhlYWQgZm9saW8gZnJvbSB0aGUgYnZlYyBkaXJlY3RseToKPgo+ICAgICBmaS0+
Zm9saW8gPSBwYWdlX2ZvbGlvKGJ2ZWMtPmJ2X3BhZ2UpOwo+Cj4gU28gdGhlIGZvbGlvIHlpZWxk
ZWQgdG8gX19oYXNfbWVyZ2VkX3BhZ2UoKSBzaG91bGQgYWx3YXlzIGJlIHRoZSBoZWFkCj4gZm9s
aW8gdGhlcmUuCj4KPiBBcmUgeW91IHRlc3Rpbmcgb24gYSA2LjEyLWJhc2VkIEFuZHJvaWQga2Vy
bmVsPyBJbiA2LjEyLAo+IF9faGFzX21lcmdlZF9wYWdlKCkgc3RpbGwgaXRlcmF0ZWQgd2l0aCBi
aW9fZm9yX2VhY2hfc2VnbWVudF9hbGwoKSBhbmQKPiB0b29rIGJ2ZWMtPmJ2X3BhZ2UgZGlyZWN0
bHkgYXMgdGFyZ2V0LCBzbyBhIHRhaWwgcGFnZSB3b3VsZCBtYWtlCj4gdGFyZ2V0LT5tYXBwaW5n
IHBvaW50IGF0IHRoZSBjb21wb3VuZF9oZWFkIG1ldGFkYXRhIGFuZCBjcmFzaCBvbgo+IHRhcmdl
dC0+bWFwcGluZy0+aG9zdC4KPgo+IElmIHNvLCB3b3VsZCBpdCBiZSBwb3NzaWJsZSB0byByZXRl
c3Qgb24gYSA2LjE4IEFuZHJvaWQga2VybmVsLCB3aGVyZQo+IHRoZSBpdGVyYXRvciBub3JtYWxp
emVzIHRvIHRoZSBoZWFkIGZvbGlvPwoKWWVzLCB5b3UgYXJlIHJpZ2h0LiBJIGZvcmdvdCBJIGJh
Y2twb3J0ZWQgeW91ciBwYXRjaCB0byA2LjEyIGtlcm5lbCB0bwpjaGVjayB3aGV0aGVyIGl0J3Mg
d29ya2luZy4gOikKVGhhbmtzIGZvciB0aGUgY29uZmlybWF0aW9uLgoKPgo+IFRoYW5rcywKPiBO
YW56aGUKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCg==
