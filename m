Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36397C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 02:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Dj6fed2uHOkgznqfaoKjv73Yc8s4Y0HmH4Vi/v8QZM=; b=gvPeuFM7QPtZimF/IvNMK+icVa
	IIgii2slSGzJr43j2XuqLKT3u/vmxW/auPt1s/tbtlYh6aUda6woKjABg6yxWQhJEeIKOBWM15JE+
	QinLF89+/FtIs1X64tEWYX3PU60F9fnb2ucvdbpLeM4jgrcKuijRNrl/uZHtO8H53pCQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz3Mw-00026l-Ro;
	Wed, 26 Aug 2026 02:28:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wz3Mb-00026G-HV
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 02:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rk1kDiRXbYOmvO39ivqDXPnr9rDmL7peofcLaftIhMI=; b=NY8dEyvaYovrgu27fQQSY+FQ2Y
 o/deVz4EaCDSVKBtjzRpqdUrOSve7jOsIm1Sj2CpnMSlLdj1Q0fmgdUOla9ZVrpmSKxephpJObxdl
 BIkcJKiu0sh49W8Iydri91uA68Hm1YeVoxxOKUXQic9DEhU4wD4NF9XRMqJ6/WmIoOqA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rk1kDiRXbYOmvO39ivqDXPnr9rDmL7peofcLaftIhMI=; b=m8sBPo1r9RE6V3/l39jNn4Z/6r
 qm8GnG4tL3x7PXY3sbIznVG02CZ0S4uaRyoT0dRFp8TxiEEAaEmvPxoin9cigt6+FG2WNSPbr8qOP
 /L1rhlnOL4MWn7T1z5TbItjrpaWk7ciJAszc6kzhLbEIMnzFXTcZBKn3nuVE94eRw+4Y=;
Received: from mail-lf1-f53.google.com ([209.85.167.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz3Ma-0001zB-W9 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 02:27:41 +0000
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5b45f1cd80eso383771e87.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 19:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787711254; cv=none;
 d=google.com; s=arc-20260327;
 b=TsZJWCM/loKOpoCeOCh3gfEyHArBQxEgJ0dGdhbPWTjwYuFjeK0akp0UkIYqLjz/Gm
 xbmho+cRydz4g7cDEGlkMeh313ClZNEfgsCU7iIIBZJeS2JepxPsndeF2VplEvBmW2pa
 1mG/sGWqriQcvIAbfjiHXiUFLfuEVUshBUpmP19qyc+UBg0nDOqnL/kT9AIRPN9YPWWV
 0mjxSsZPHu2JQ3IGSD8EC0OsTYdGw3v9tACGnj1QDL3uHVsoYmphe81UKjt4wvBT9DYr
 tWKyiADy/CfiW+ze6mdFADHg7xog2srInG9xwaEGVWrZVwg8Nl3EzCTG37BuQOBBdlkR
 koBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rk1kDiRXbYOmvO39ivqDXPnr9rDmL7peofcLaftIhMI=;
 fh=wqHgBNO9YeegThEQd4fg1QrV0fYybnECSYombkgVGSo=;
 b=GKhJsr0m2IMGG0MNoWXJJQST3Hl06Whhu2SOUDVhWk/EJ1hV8hpLNuRE4CbhaFK8JD
 8bFvFOunYnAHXSA06C155zayjxiY92Zx6iB7cuTSN16wTomIC33JkmAN5gFmwxUMkCoI
 NS7twmTI6vKla7Q97bhBPedq0GMYMnfHs/VNvN76YBO33Z4TY52Lzz9+6sLTBXZ3pNWz
 f8LWXbgYb+j8lrvs56Ae8mqSXIB14RVu82ttl8J4B3kOC37eTAtQ+ERN2s0/yOosas9x
 v4R+bytQqM32wH/wGBPiyROTR1DLu6ZlH0MJ0PJ7wVX8A+HJQ4HOzagF9Z5Cgg5i+zK9
 6/lg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787711254; x=1788316054; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rk1kDiRXbYOmvO39ivqDXPnr9rDmL7peofcLaftIhMI=;
 b=MwmbgU7dc5NFWMcVt1q8dWS+4YlkzraKZ7V+JVwTMGQbm1MjKFtQRuYI2+2qDixZ9C
 vFoCrc5oaxMn48EKxhOz4Ey7YPLMRZZNmbNhzaRKEW8n2poUsvkJcKuKcjZkVe+odGIi
 wnVvY7n+F0xnH8T7d53dFliC7X7udvUCaOkSRYouHg5kiB4ai4B291ZzZHWElJIXFL3M
 5Hk+3a4GqCzrQeXMOjazW20Uj2oKJzltYW+Apkcl4PI9b/ILDsUbTpmJWMi2Q32Br5GN
 xynYRwooKWh4P5HtAPCDWritKJa9o99rxFYDrQSnNfKSkMSRSByvjk2o+kgA1WogYpvc
 bnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787711254; x=1788316054;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rk1kDiRXbYOmvO39ivqDXPnr9rDmL7peofcLaftIhMI=;
 b=oc9NX9lmspOzcSYLtpWwcBaaw76ZZCJ8RFsB5uZkTnfZuxBQG6kQ2UnPHZOelk32AX
 O/Y3O8kHjPdJ+rc/n0rk5mq1ZjyVg7/IYOVNI9kT8GXAa60nbvatYhYncqamvy/tKisI
 IltxlTk5TPu5D8zEpVq1lytkOpEbvtI4eb4EcNw+hFKUbSN4IZ9OSIDdIZtATTGSrZaZ
 mA9B5ZZ7BVk64RP4N8p0SpqImUsIwC+y9WefwQAKYi4HsoqtdtllR6QvqE0o7MP+52pO
 9hGNQC7Io8bF634av+E0Eh2xfKH4MzuQxSqn7GrEqY3GoxyvZo8qX+62hWsy7Kw2e6Hz
 ESvA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/nSYyrB0ikZst9aLrI2swiw0cHYbW7LL2J1YR/IaZjs3WZxPFlXnJgtsvtufPbqZy2v+UOz+rGcZjtxb0KHvt@lists.sourceforge.net
X-Gm-Message-State: AFuF++nKS81+PypdcdesOjpO3t/S/dsd9c7E7dz9JFY1uv3CZt+bfPmf
 ZcCyvxHGwUgj9oipWVXwZwDWcY2ggINX1oePrmxQAgB/EgIaTLaky0Fgy6lGFrRS7IflUmg0lrZ
 8N453+nzre+OYl2JKahCq3cc7Ub63wGA=
X-Gm-Gg: AR+sD13UvGzGlSrtVkI9o05Q+9EuvHTuHauzdNPoQ8vwstfPQVMa/VrINWXGQmBdMke
 BUx5XnjMhlm7KH/4Bzvx2aMrSpJ4Muh01k25J4eR/1Im4H5fckSjK9Mm+Kp4d24ASreoQ3itN6m
 EIS2Ij87kupF4JUwnOXGMOkEmWVLA0BdF6gMNiJM28HtA+n2tCvL/vAtMW4Tz+6Rwvbx7xxWp5Q
 79QBXW6gQvKSyDaOM74knIUiYkyoYMbnIXyc8lYY+ySU6cnlZSIy8HhmmmCpRZ9JKtRdCHjoU9o
 El5B7RWLr1QuX05V3mM/+Z1ZXTZDd6k06Xb/9dBCGW/K5w==
X-Received: by 2002:a05:6512:6689:20b0:5b1:5379:8b6d with SMTP id
 2adb3069b0e04-5b4a90bb0afmr450185e87.23.1787711253988; Tue, 25 Aug 2026
 19:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260825083738.526423-1-qiwenjie@xiaomi.com>
 <CACOAw_y0FwrNasvN5jWv4QLuXnuDhKW3hoOc3NM8vdX6oOxXYg@mail.gmail.com>
 <0702a9a1-6f69-4c7e-8ab7-809d04526ce4@kernel.org>
In-Reply-To: <0702a9a1-6f69-4c7e-8ab7-809d04526ce4@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Wed, 26 Aug 2026 10:27:22 +0800
X-Gm-Features: AcwNN1X0Dr3qi_Pn93l1oh0eoEAYWjxMpdC_vzzRKGZBi-pjfpHh9wXwJH1Xc3c
Message-ID: <CAGFpFsRP2KN2_a++TULsqYn_bAskr_FoeFYVE_SLYBZdZNxi-w@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wz3Ma-0001zB-W9
Subject: Re: [f2fs-dev] [PATCH] f2fs: propagate resizable_tail_secno mount
 option
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgQ2hhbywKClllcy4gUGxlYXNlIGRpc3JlZ2FyZCB0aGlzIHN0YW5kYWxvbmUgcGF0Y2guCgpP
biBXZWQsIEF1ZyAyNiwgMjAyNiBhdCAxMDowNeKAr0FNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiA4LzI1LzI2IDIzOjQ4LCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IE9u
IFR1ZSwgQXVnIDI1LCAyMDI2IGF0IDE6NDLigK9BTSBXZW5qaWUgUWkgPHF3amh1c3RAZ21haWwu
Y29tPiB3cm90ZToKPiA+Pgo+ID4+IE1vdW50IHBhcnNpbmcgc3RvcmVzIHJlc2l6YWJsZV90YWls
X3NlY25vIGluIEYyRlNfQ1RYX0lORk8oY3R4KSwKPiA+PiBidXQgaXQgZG9lcyBub3QgbWFyayB0
aGUgb3B0aW9uIGluIGN0eC0+c3BlY19tYXNrLiBBcyBhCj4gPj4gcmVzdWx0LCBmMmZzX2FwcGx5
X29wdGlvbnMoKSBuZXZlciBjb3BpZXMgdGhlIHZhbHVlIGludG8KPiA+PiBGMkZTX09QVElPTihz
YmkpLCBzbyBhZGp1c3RfcGlubmVkX2FyZWFfYm91bmRhcnkoKSBpZ25vcmVzCj4gPj4gdGhlIHJl
cXVlc3RlZCB0YWlsIHJlc2VydmF0aW9uLgo+ID4+Cj4gPj4gU2V0IHRoZSBtaXNzaW5nIHNwZWNf
bWFzayBiaXQgYW5kIHByb3BhZ2F0ZSB0aGUgcGFyc2VkIHZhbHVlCj4gPj4gdGhyb3VnaCBmMmZz
X2FwcGx5X29wdGlvbnMoKS4KPiA+Pgo+ID4+IEZpeGVzOiBkODc0NWJhMjYwYWIgKCJmMmZzOiBz
dXBwb3J0IHJlc2l6YWJsZSB0YWlsIHNlY3Rpb24gYW5kIHVuaWZ5IHBpbm5lZCBhbGxvY2F0aW9u
IikKPiA+PiBTaWduZWQtb2ZmLWJ5OiBXZW5qaWUgUWkgPHFpd2VuamllQHhpYW9taS5jb20+Cj4g
Pj4gLS0tCj4gPj4gUUVNVSB2YWxpZGF0aW9uIHN1bW1hcnk6Cj4gPj4gLSBwbGFpbiBtb3VudCBy
ZXBvcnRlZCBgcGlubmVkX2FyZWFfbWF4X3NlY25vPTUwMmAKPiA+PiAtIGAtbyByZXNpemFibGVf
dGFpbF9zZWNubz0xYCByZXBvcnRlZCBgcGlubmVkX2FyZWFfbWF4X3NlY25vPTUwMWAKPiA+PiAt
IGJvdW5kZWQgZmlsbCBzdGF5ZWQgd2l0aGluIHRoZSByZWR1Y2VkIGJvdW5kYXJ5IHRocm91Z2gg
dGhlIGZpcnN0Cj4gPj4gICBgRkFMTE9DX1JFVD0tMSBFUlJOTz0yOGAKPiA+Pgo+ID4+ICBmcy9m
MmZzL3N1cGVyLmMgfCA1ICsrKysrCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KykKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL3N1cGVyLmMgYi9mcy9mMmZzL3N1cGVy
LmMKPiA+PiBpbmRleCBjMWUzMTUyODJlYy4uNjIzOGRmZTZmNGUgMTAwNjQ0Cj4gPj4gLS0tIGEv
ZnMvZjJmcy9zdXBlci5jCj4gPj4gKysrIGIvZnMvZjJmcy9zdXBlci5jCj4gPj4gQEAgLTQwNiw2
ICs0MDYsNyBAQCBzdGF0aWMgbWF0Y2hfdGFibGVfdCBmMmZzX2NoZWNrcG9pbnRfdG9rZW5zID0g
ewo+ID4+ICAjZGVmaW5lIEYyRlNfU1BFQ19lcnJvcnMgICAgICAgICAgICAgICAgICAgICAgICgx
IDw8IDIzKQo+ID4+ICAjZGVmaW5lIEYyRlNfU1BFQ19sb29rdXBfbW9kZSAgICAgICAgICAgICAg
ICAgICgxIDw8IDI0KQo+ID4+ICAjZGVmaW5lIEYyRlNfU1BFQ19yZXNlcnZlX25vZGUgICAgICAg
ICAgICAgICAgICgxIDw8IDI1KQo+ID4+ICsjZGVmaW5lIEYyRlNfU1BFQ19yZXNpemFibGVfdGFp
bF9zZWNubyAgICAgICAgIEJJVCgyNikKPiA+Pgo+ID4+ICBzdHJ1Y3QgZjJmc19mc19jb250ZXh0
IHsKPiA+PiAgICAgICAgIHN0cnVjdCBmMmZzX21vdW50X2luZm8gaW5mbzsKPiA+PiBAQCAtMTI1
MCw2ICsxMjUxLDcgQEAgc3RhdGljIGludCBmMmZzX3BhcnNlX3BhcmFtKHN0cnVjdCBmc19jb250
ZXh0ICpmYywgc3RydWN0IGZzX3BhcmFtZXRlciAqcGFyYW0pCj4gPj4gICAgICAgICAgICAgICAg
IGJyZWFrOwo+ID4+ICAgICAgICAgY2FzZSBPcHRfcmVzaXphYmxlX3RhaWxfc2Vjbm86Cj4gPj4g
ICAgICAgICAgICAgICAgIEYyRlNfQ1RYX0lORk8oY3R4KS5yZXNpemFibGVfdGFpbF9zZWNubyA9
IHJlc3VsdC51aW50XzMyOwo+ID4+ICsgICAgICAgICAgICAgICBjdHgtPnNwZWNfbWFzayB8PSBG
MkZTX1NQRUNfcmVzaXphYmxlX3RhaWxfc2Vjbm87Cj4gPj4gICAgICAgICAgICAgICAgIGJyZWFr
Owo+ID4+ICAgICAgICAgfQo+ID4+ICAgICAgICAgcmV0dXJuIDA7Cj4gPj4gQEAgLTE3NzksNiAr
MTc4MSw5IEBAIHN0YXRpYyB2b2lkIGYyZnNfYXBwbHlfb3B0aW9ucyhzdHJ1Y3QgZnNfY29udGV4
dCAqZmMsIHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCj4gPj4gICAgICAgICAgICAgICAgIEYyRlNf
T1BUSU9OKHNiaSkuZXJyb3JzID0gRjJGU19DVFhfSU5GTyhjdHgpLmVycm9yczsKPiA+PiAgICAg
ICAgIGlmIChjdHgtPnNwZWNfbWFzayAmIEYyRlNfU1BFQ19sb29rdXBfbW9kZSkKPiA+PiAgICAg
ICAgICAgICAgICAgRjJGU19PUFRJT04oc2JpKS5sb29rdXBfbW9kZSA9IEYyRlNfQ1RYX0lORk8o
Y3R4KS5sb29rdXBfbW9kZTsKPiA+PiArICAgICAgIGlmIChjdHgtPnNwZWNfbWFzayAmIEYyRlNf
U1BFQ19yZXNpemFibGVfdGFpbF9zZWNubykKPiA+PiArICAgICAgICAgICAgICAgRjJGU19PUFRJ
T04oc2JpKS5yZXNpemFibGVfdGFpbF9zZWNubyA9Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBGMkZTX0NUWF9JTkZPKGN0eCkucmVzaXphYmxlX3RhaWxfc2Vjbm87Cj4gPgo+
ID4gSGkgV2VuamllLAo+ID4KPiA+IFRoZSBvcmlnaW5hbCBwYXRjaCBpcyBzdGlsbCB1bmRlciBy
ZXZpZXcuIElmIHlvdSBmb3VuZCBhbiBpc3N1ZSBvcgo+ID4gaGF2ZSBmZWVkYmFjaywgcGxlYXNl
IHJlcGx5IHdpdGggYSByZXZpZXcgY29tbWVudCBvbiB0aGUgb3JpZ2luYWwKPiA+IHBhdGNoIHRo
cmVhZCBpbnN0ZWFkLgo+ID4KPiA+IEFsc28sIGlmIHRoaXMgcGF0Y2ggd2FzIGF1dG8tZ2VuZXJh
dGVkIGJ5IEFJLCBwbGVhc2UgYWRqdXN0IHlvdXIKPiA+IHN5c3RlbSBhY2NvcmRpbmdseS4KPgo+
IEhpIFdlbmppZSwKPgo+IEkgYWdyZWUgdy8gRGFlaG8sIHBsZWFzZSBhZGp1c3QgcG9saWN5IHRv
IGdpdmUgY29tbWVudCBvbiBwZW5kaW5nIHBhdGNoCj4gcmF0aGVyIHRoYW4ganVzdCBwYXRjaGlu
ZyB3LyBhIG5ldyBvbmUuCj4KPiBUaGFua3MsCj4KPiA+Cj4gPiBUaGFua3MsCj4gPgo+ID4+Cj4g
Pj4gICAgICAgICBmMmZzX2FwcGx5X2NvbXByZXNzaW9uKGZjLCBzYik7Cj4gPj4gICAgICAgICBm
MmZzX2FwcGx5X3Rlc3RfZHVtbXlfZW5jcnlwdGlvbihmYywgc2IpOwo+ID4+Cj4gPj4gYmFzZS1j
b21taXQ6IGQ4NzQ1YmEyNjBhYmJjYWY3NWZkNDU4ODgxMzgxMDE5YWIzYzVjMDcKPiA+PiAtLQo+
ID4+IDIuNDMuMAo+ID4+Cj4gPj4KPiA+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+ID4+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gPj4g
TGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiA+PiBodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCj4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRl
dmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApo
dHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRl
dmVsCg==
