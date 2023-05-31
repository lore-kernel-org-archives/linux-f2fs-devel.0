Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3201C7EE2E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 May 2023 13:54:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4MHH-0006Nv-9v;
	Wed, 31 May 2023 13:54:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qkrwngud825@gmail.com>) id 1q4MHG-0006No-25
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 13:54:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y5rCFTJGWdcgITCagf0CQsma1inb7ImDXUHOuHQ7JIc=; b=g7tBbAIld0LUIn648xsVMDmZw9
 bE++1Bcyu+H6Io4WVzzfMRuYw4Tz5x/cNHWhk/aFe13zXNpKYsnnZO40W7uhes2v3Wp0YRN5xGFlA
 jlA7LTV1gEMVTxb79wpfGIeYSH9nKKU9CU6M9IRxgSQK4LjWLmdTUJQWGyCeXcc6kVkE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y5rCFTJGWdcgITCagf0CQsma1inb7ImDXUHOuHQ7JIc=; b=FLuFS0rPKG16CE8H21v9+VMXc1
 y2HVlmK/jWqAubHoTWBtWHmzBYSxslIn8DZpwrzvlhi0tNimIE+XAP4I0F8XOac8+6MwRAi+/G7Dl
 cJ84Z/l3emxZjGHrmvuoujaxtMllrph6pnWogS380iIxQGP0SwDqsikoM2K/o8Wt8m6k=;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1q4MHC-0002lc-3h for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 13:54:14 +0000
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-5147dce372eso8505092a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 31 May 2023 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685541243; x=1688133243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5rCFTJGWdcgITCagf0CQsma1inb7ImDXUHOuHQ7JIc=;
 b=mTj9nIpvxbmnkUxTCLhkDnsKwO0grrOAn2KHj3cH1VG+XsV+HB8rMajYT1okDRh4dL
 OSH1Cn+jpqoEaDU3JctZVL02wCvBfafEW/Z7yzMYrKHSWlupRBmlqT+2neNrSXf7uRNE
 3COHZJfxudAEewu5UtHh7qEpZQRigjCc/LrnKU3owpVJgGwWMH2ja3tsgV7+83BNuHAZ
 /6Wmt0XYQx8eBUghSkDJadejrqVi8t31f6CDiL5ZUxXRVCUqXugI6abyOSXcu7fbTiYU
 rASPCfa/bGxckYckbO/C1Nmw1Hy5O0c/FXnqZt3ChCRhgOHyQjus9U6x21SUCymYLig0
 LbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541243; x=1688133243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5rCFTJGWdcgITCagf0CQsma1inb7ImDXUHOuHQ7JIc=;
 b=Pmo13w67Zbif+MiWwjrrtZ0nn76XEzijhgzf+nxUO3m7muNN/CtYh+JCB16LY1qJ/B
 PmfC5kbVBAXwxlZusfHHPw1n58cnJjouBmYFY1xhukxFC8/3dy7YjKKtl0llTxuvV5xM
 8LaXo95aqd9Qj5lBGYxHY0Vz6aUmYaoZMx5Mt2zQEDhQxeSDiUZix0H0LEN+p1EEpHMo
 6cVe/Mtnq7uvQ7rFAE+X8VkrN+mObTp7nUURkD1Zjeam36zoixPGDGByU0ZFVMsEkLyQ
 T3MXUzYKNx2mbvRSVNu8PObam2HyIPh3CMWZFHwcsn3IhVRZ4jN1moWsKMTdDNjBG0TV
 GzJQ==
X-Gm-Message-State: AC+VfDxnZHNvdwy0Ig4j3VHPz2P/qROecIF4YwP8dz+aQvnircMmVRsm
 9ArzNdV1egxDm69MEBrVJLcXiEcZkNRZJZeN+5M=
X-Google-Smtp-Source: ACHHUZ7AOHP9g2Megr5QVPTq3LJeayM4t3rVmsZgJHwHD+Q/YbNiDgK6CvMQPQgHJCiZfTLZ8kV3EGXsMp9XQ44DsAQ=
X-Received: by 2002:a17:907:a426:b0:96f:c988:93b with SMTP id
 sg38-20020a170907a42600b0096fc988093bmr5344896ejc.35.1685541243317; Wed, 31
 May 2023 06:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230531125918.55609-1-frank.li@vivo.com>
In-Reply-To: <20230531125918.55609-1-frank.li@vivo.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Wed, 31 May 2023 22:53:52 +0900
Message-ID: <CAD14+f1YoiSVvq2M1v8u5bUdCNN_0nurY4ued6ZFu1gaBSHxDw@mail.gmail.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1q4MHC-0002lc-3h
Subject: Re: [f2fs-dev] [PATCH] f2fs: flag as supporting buffered async reads
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 Lu Hongfei <luhongfei@vivo.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgWWFuZ3RhbywKCkkgcmVtZW1iZXIgaGVhcmluZyB0aGF0IGYyZnMgY2FuIHBlcmZvcm0gcmVs
YXRpdmVseSBwb29ybHkgdW5kZXIgaW9fdXJpbmcsCm5pY2UgZmluZC4KCkkgc3VnZ2VzdCByZXdy
aXRpbmcgdGhlIGNvbW1pdCBtZXNzYWdlIHRob3VnaC4gRnJvbSB0aGUgbG9va3Mgb2YgaXQsIGl0
Cm1pZ2h0IHN1Z2dlc3QgdGhhdCBGTU9ERV9CVUZfUkFTWU5DIGlzIGEgbWFnaWMgZmxhZyB0aGF0
IGF1dG9tYXRpY2FsbHkKaW1wcm92ZXMgcGVyZm9ybWFuY2UgdGhhdCBjYW4gYmUgZW5hYmxlZCB3
aWxseSBuaWxseS4KCkhvdyBhYm91dCBzb21ldGhpbmcgbGlrZToKCmYyZnMgdXNlcyBnZW5lcmlj
X2ZpbGVfYnVmZmVyZWRfcmVhZCgpLCB3aGljaCBzdXBwb3J0cyBidWZmZXJlZCBhc3luYwpyZWFk
cyBzaW5jZSBjb21taXQgMWEwYTc4NTNiOTAxICgibW06IHN1cHBvcnQgYXN5bmMgYnVmZmVyZWQg
cmVhZHMgaW4KZ2VuZXJpY19maWxlX2J1ZmZlcmVkX3JlYWQoKSIpLgoKTWF0Y2ggb3RoZXIgZmls
ZS1zeXN0ZW1zIGFuZCBlbmFibGUgaXQuIFRoZSByZWFkIHBlcmZvcm1hbmNlIGhhcyBiZWVuCmdy
ZWF0bHkgaW1wcm92ZWQgdW5kZXIgaW9fdXJpbmc6CgogICAgMTY3TS9zIC0+IDIzNE0vcywgSW5j
cmVhc2UgcmF0aW8gYnkgNDAlCgpUZXN0IHcvOgogICAgLi9maW8gLS1uYW1lPW9uZXNzZCAtLWZp
bGVuYW1lPS9kYXRhL3Rlc3QvbG9jYWwvaW9fdXJpbmdfdGVzdAogICAgLS1zaXplPTI1Nk0gLS1y
dz1yYW5kcmVhZCAtLWJzPTRrIC0tZGlyZWN0PTAgLS1vdmVyd3JpdGU9MAogICAgLS1udW1qb2Jz
PTEgLS1pb2RlcHRoPTEgLS10aW1lX2Jhc2VkPTAgLS1ydW50aW1lPTEwCiAgICAtLWlvZW5naW5l
PWlvX3VyaW5nIC0tcmVnaXN0ZXJmaWxlcyAtLWZpeGVkYnVmcwogICAgLS1ndG9kX3JlZHVjZT0x
IC0tZ3JvdXBfcmVwb3J0aW5nIC0tc3F0aHJlYWRfcG9sbD0xCgpPbiBXZWQsIE1heSAzMSwgMjAy
MyBhdCAxMDowMeKAr1BNIFlhbmd0YW8gTGkgdmlhIExpbnV4LWYyZnMtZGV2ZWwKPGxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0PiB3cm90ZToKPgo+IEFmdGVyIGVuYWJsaW5n
IHRoaXMgZmVhdHVyZSwgdGhlIHJlYWQgcGVyZm9ybWFuY2UgaGFzIGJlZW4gZ3JlYXRseQo+IGlt
cHJvdmVkOgo+Cj4gICAgIDE2N00vcyAtPiAyMzRNL3MsIEluY3JlYXNlIHJhdGlvIGJ5IDQwJQo+
Cj4gVGVzdCB3LzoKPiAgICAgLi9maW8gLS1uYW1lPW9uZXNzZCAtLWZpbGVuYW1lPS9kYXRhL3Rl
c3QvbG9jYWwvaW9fdXJpbmdfdGVzdAo+ICAgICAtLXNpemU9MjU2TSAtLXJ3PXJhbmRyZWFkIC0t
YnM9NGsgLS1kaXJlY3Q9MCAtLW92ZXJ3cml0ZT0wCj4gICAgIC0tbnVtam9icz0xIC0taW9kZXB0
aD0xIC0tdGltZV9iYXNlZD0wIC0tcnVudGltZT0xMAo+ICAgICAtLWlvZW5naW5lPWlvX3VyaW5n
IC0tcmVnaXN0ZXJmaWxlcyAtLWZpeGVkYnVmcwo+ICAgICAtLWd0b2RfcmVkdWNlPTEgLS1ncm91
cF9yZXBvcnRpbmcgLS1zcXRocmVhZF9wb2xsPTEKPgo+IFNpZ25lZC1vZmYtYnk6IEx1IEhvbmdm
ZWkgPGx1aG9uZ2ZlaUB2aXZvLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBZYW5ndGFvIExpIDxmcmFu
ay5saUB2aXZvLmNvbT4KPiAtLS0KPiAgZnMvZjJmcy9maWxlLmMgfCAyICstCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Zz
L2YyZnMvZmlsZS5jIGIvZnMvZjJmcy9maWxlLmMKPiBpbmRleCAwMTVlZDI3NGRjMzEuLjIzYzY4
ZWU5NDZlNSAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL2ZpbGUuYwo+ICsrKyBiL2ZzL2YyZnMvZmls
ZS5jCj4gQEAgLTU0Niw3ICs1NDYsNyBAQCBzdGF0aWMgaW50IGYyZnNfZmlsZV9vcGVuKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxwKQo+ICAgICAgICAgaWYgKGVycikKPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPgo+IC0gICAgICAgZmlscC0+Zl9tb2RlIHw9IEZN
T0RFX05PV0FJVDsKPiArICAgICAgIGZpbHAtPmZfbW9kZSB8PSBGTU9ERV9OT1dBSVQgfCBGTU9E
RV9CVUZfUkFTWU5DOwo+Cj4gICAgICAgICByZXR1cm4gZHF1b3RfZmlsZV9vcGVuKGlub2RlLCBm
aWxwKTsKPiAgfQo+IC0tCj4gMi4zOS4wCj4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+
IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
