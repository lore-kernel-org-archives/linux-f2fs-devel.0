Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861B5C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8yvTlHBelL3HxZvyrqLYslH35UbCfncFCeeBtUq+6RM=; b=Y1voH/theYOA+3z0eF+FMXFj30
	NDcn3ehkrwkmKe045fnJp/KI2Y+SplUbpcugoXeNDbw7u6bhQ2cvCNYTejzoXBLUiK1I8gQJ7XOUT
	RkmxeYgZVXo5JcP7+EIbmXYqAQ7iJ/a8gJPmaE4NDtqNRTWqEeOjtSVSGmM05ucKYsb0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x01Qv-0000Lb-Jy;
	Fri, 28 Aug 2026 18:36:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x01Qc-0000L7-VX
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 18:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ynpb+Jwnqqd6rxWLKuDyYF14qvmrfmLGhrgEpg5gM8g=; b=RkZ1SAeDy0PNY3QS7EsX3DYPi8
 fr8F5Cb26ap3kP8odxz0Bd8ZaW7FvCahv7nyNwRggpHzbG+OQbfT53DUQhKyfwFVgflmTfnohNEZR
 Ufbo2lT7bve7xIqObgb/qxwKjvdZ6RNJ1WETV2OnwX7Wzc4JuXvbHRVnZtfibulxVMpo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ynpb+Jwnqqd6rxWLKuDyYF14qvmrfmLGhrgEpg5gM8g=; b=f10i+5/AFEbwF4DNcEJu632qSw
 +Cy9OUUAu6MxMdtbJs+NuGaKAtwFQ2aU1KTukF+BQP+qjL2lMOO6xDxPCE+bpuxaZTWJBcDiDa2sb
 eaJUtChuRhl2k65nW1D6G8+Pl83P1oGntWIm948/9no0I9Xb/lzKPW0SPwaUWdNWwkmQ=;
Received: from mail-lf1-f42.google.com ([209.85.167.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x01Qc-0002zn-B4 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 18:35:50 +0000
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b568dae0e8so1652296e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 11:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787942143; cv=none;
 d=google.com; s=arc-20260327;
 b=s6bkGtXPgIXnQ7hlKyz7ix+IwDVYuKE5Kv6Aucc4bGcg9T/ysMVYthuTEBFKbrFH6g
 ofOV0IwasrZ8vyQ1TVroHARjcCYqqoknlrjFpT58lDkEEpLvHa3EfM45abQI29POls7b
 Acbaify2FTiIcWxmRUHrU3ChvTy59xOY+Vm+pxDXOI9bNx7XRppaHS8dRMfh7+mWHFid
 XRwkykBtmPsSdz9EmYJh3R2sVW5AdeqqE2cW2fIgP5E2Yt+e4Hj7aven5UFCjtYrhxw2
 fXcULrWgYxKkeVbxD6OBQQxmbJ25j5ixxQyoFwYa9CojOGgAWcBJWb0bkBXUAGefZGlw
 nsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ynpb+Jwnqqd6rxWLKuDyYF14qvmrfmLGhrgEpg5gM8g=;
 fh=gZgrm0z2uOcnW5UXB/k8dzHAT30FbZfgaJWKUymkAPw=;
 b=mF5dHNBrI/ryM8yZfzpc/qsko6TrgpwR7MMlLOrl4mwKJn/bcEA+BXM/qPa7TsKKqP
 Tm7LtCdZsbT92buHLK88zLvaHwK90vsBGSTfs+n8ttT+bOU181HlwV8O4RogkX0xOsgh
 aSHPaaGVJCb5YZv80gk5sLsz2t+qeuqqQn6Fc9/IyvFVjKZmTOPLdXi8QQouJdyfq5md
 u0h1kggPPxqyWALFTkFaiCJry+bKL2KNmc3KKgF7hqIC7vaqXIq5eq52/fEaRt/bW/r5
 OzFUs/TU1/KBU11xhbmS9z8v/UGEZ/XQOMQFWZv4Qc5qBzsb+QehZHCP+nha71UnBauo
 3Mzw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787942143; x=1788546943; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ynpb+Jwnqqd6rxWLKuDyYF14qvmrfmLGhrgEpg5gM8g=;
 b=Br8S/jaIwj2msegEarykFQ+5coLcakJvl+wAsDvEcs/NCV8FWTXxQ+DJ8jbI579R+8
 ZZub2extgWp0AdMRuV1MBiCOP2AJx4TLirkoLrjdxGnKjkz7Tav7V2hhWqap3UtpeTo6
 f6T/7NdGUYl5BVfaduO27ObIGNiDRU3kJOxfVgDV+Iy1H80T1T7k3MMfyi+OMult1jPd
 sqmsXGMEVxWBzDqvL9kKU+8a0E7l+J3SgOjOmZIeOstf5oolu9igVEdGHus59gqG4Sti
 gCn88OxGeml/OOADchqLQT0UNONdhT8WxgKhyPqiLe55AZI7V0ZKo5o6ps5Ol9VPVMcd
 jGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787942143; x=1788546943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ynpb+Jwnqqd6rxWLKuDyYF14qvmrfmLGhrgEpg5gM8g=;
 b=Mz0oeKn2Fa2mgxvJ06nichalG+EdBUeUnQilw/PiiO01P2LwuneDTqOdGsT4nuAXcO
 Cp+0nF/aCHWKxb54CBPiXxKBso3P3qKw0iyhWsW9xW97gpNHNdupfbQeDctJMT2WSrP/
 KaQ4xBp/JsS7ctv/8hqy+wrIJ826rYxS789CqTjXkCABCW0yZDNKEl9sj5y7Xypm8DCW
 ayUEUysZJPyPmAVdbY4tSKJR5Sc8LCBKo594NRQyV9wAEjdEZDA1g2jSW5Rk5LN9tICp
 abxxqJri5n9N9qPHegjQ0kvibBpZVKASey7orOjU0Rwb1n26a/UYlwvjAbhmGg1lmdSk
 RuBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9hCFXM9oL2WnAiDWFXhRPYTnu8rcX8M8uGfqzniRmfC2E/Vl8mPyvDrdYAYBXvLAw2s59GfndqmsEO0TrnLJn@lists.sourceforge.net
X-Gm-Message-State: AFuF++lF4hhlu7go32ncvUEvo+F9NBq9UsP5y5wC4OqlK62/p60fj6iO
 EnL2AT6SDhi+Rsi9jjnQGtKtILL6rM3OovEu8nh8CZ8a8Q25cLnTq+9I08+Cwl2OCOBjjouMrJF
 oCba3oYHwE9ALLIQLg39YmIOE1Q16bjc=
X-Gm-Gg: AR+sD10ZejBiGq45ytzN6hZMMY2kCdkZMyJfkmQMMQ5MfwLq7xoO9LkYWKPViiNN0Jb
 R0CH7JYbISRNpV3/wYgPCptqEwJ7K71O71DMsDPXaDocLNl3eblJIPMPgd8niigWg4H/7KJEr92
 L3koVfT/y4xTWNMrvWCtWGz2eCMHo9hvp3F7jfiGqKqEPeYS5J0JpRi2EJ4odhWCJke5PzThkST
 kk2YJRTYRfpqBJq9Eun+ZjejiCc5aFDDot3B7/udOTWZODjq3GvVkUdk9hHC2MHzdmccC+zDSde
 vwk3hayePtNsULKUl26wl8i1AZdOPljBqzqPmvFNmSY5q0fOb/kNmvfaQLVQF4ji9VM7DrI/FXX
 VwHVr3DqWiwdJKb3dOQfQA00ZAOF71m7j9A==
X-Received: by 2002:a05:6512:3c8f:b0:5b0:ceb3:1150 with SMTP id
 2adb3069b0e04-5b5e68c215emr2691269e87.8.1787942143391; Fri, 28 Aug 2026
 11:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260828114125.637513-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260828114125.637513-1-qiwenjie@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 28 Aug 2026 11:35:31 -0700
X-Gm-Features: AcwNN1XKyS8swpSmb2FoICesReCmb-oe2WjEFTdnn3lU_zfqIrEESazdS_1qYyo
Message-ID: <CACOAw_x5wNWf6s7j9FBrC5P28c__UiN9kw6mDvqVGgZZCk-ruA@mail.gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1x01Qc-0002zn-B4
Subject: Re: [f2fs-dev] [PATCH] f2fs: sync pending discards before reserving
 device alias
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gRnJpLCBBdWcgMjgsIDIwMjYgYXQgNDo0NOKAr0FNIFdlbmppZSBRaSA8cXdqaHVzdEBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gQSByZWxlYXNlZCBkZXZpY2UtYWxpYXMgcmFuZ2UgY2FuIGFjY3Vt
dWxhdGUgcGVuZGluZyBkaXNjYXJkCj4gY29tbWFuZHMuIFRoZSByZXNlcnZlIHBhdGggdGhlbiBt
YXJrcyB0aGUgc2FtZSByYW5nZSB2YWxpZCBhZ2Fpbgo+IHRocm91Z2ggZjJmc19yZXNlcnZlX2Rl
dmljZV9hbGlhcygpIHdpdGhvdXQgZmlyc3Qgc3luY2hyb25pemluZwo+IHRob3NlIGRpc2NhcmRz
Lgo+Cj4gSWYgdGhlIGRpc2NhcmQgdGhyZWFkIGxhdGVyIHN1Ym1pdHMgb25lIG9mIHRoZSBzdGFs
ZSBjb21tYW5kcywKPiBfX2NoZWNrX3NpdF9iaXRtYXAoKSBjYW4gc3RpbGwgc2VlIHZhbGlkIGJs
b2NrcyBpbiB0aGF0IHJhbmdlIGFuZAo+IHRyaWdnZXIgYSBCVUcuCj4KPiBTeW5jaHJvbml6ZSBw
ZW5kaW5nIGRpc2NhcmQgY29tbWFuZHMgaW4gdGhlIGFsaWFzIHJhbmdlIGJlZm9yZQo+IG1ha2lu
ZyBpdCB2YWxpZCBhZ2Fpbi4KPgo+IEZpeGVzOiBlYWUzZmFmMjEwYmQgKCJmMmZzOiBzdXBwb3J0
IGR5bmFtaWMgcmVzZXJ2ZS9yZWxlYXNlIGZvciBkZXZpY2UgYWxpYXNpbmciKQo+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnCj4gU2lnbmVkLW9mZi1ieTogV2VuamllIFFpIDxxaXdlbmppZUB4
aWFvbWkuY29tPgo+IC0tLQo+ICAga2VybmVsIEJVRyBhdCBmcy9mMmZzL3NlZ21lbnQuYzoxMjI4
IQo+ICAgT29wczogaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBTTVAgREVCVUdfUEFHRUFMTE9D
IEtBU0FOIFBUSQo+ICAgQ1BVOiAxIFVJRDogMCBQSUQ6IDc5IENvbW06IGYyZnNfZGlzY2FyZC0y
NQo+ICAgUklQOiAwMDEwOl9fY2hlY2tfc2l0X2JpdG1hcCsweDJlMS8weDRlMAo+ICAgQ2FsbCBU
cmFjZToKPiAgICBfX3N1Ym1pdF9kaXNjYXJkX2NtZCsweDkyMS8weDExNDAKPiAgICBfX2lzc3Vl
X2Rpc2NhcmRfY21kKzB4NTI0LzB4MTJmMAo+ICAgIGlzc3VlX2Rpc2NhcmRfdGhyZWFkKzB4Njg2
LzB4ZTIwCj4KPiAgZnMvZjJmcy9mMmZzLmggICAgfCAyICsrCj4gIGZzL2YyZnMvZmlsZS5jICAg
IHwgMSArCj4gIGZzL2YyZnMvc2VnbWVudC5jIHwgOSArKysrKysrKysKPiAgMyBmaWxlcyBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9mMmZzLmggYi9m
cy9mMmZzL2YyZnMuaAo+IGluZGV4IDE2NzIwZjFmMGE5Li4yYjljNmJmMzEwYiAxMDA2NDQKPiAt
LS0gYS9mcy9mMmZzL2YyZnMuaAo+ICsrKyBiL2ZzL2YyZnMvZjJmcy5oCj4gQEAgLTQwNjcsNiAr
NDA2Nyw4IEBAIGludCBmMmZzX3N0YXJ0X2Rpc2NhcmRfdGhyZWFkKHN0cnVjdCBmMmZzX3NiX2lu
Zm8gKnNiaSk7Cj4gIHZvaWQgZjJmc19kcm9wX2Rpc2NhcmRfY21kKHN0cnVjdCBmMmZzX3NiX2lu
Zm8gKnNiaSk7Cj4gIHZvaWQgZjJmc19zdG9wX2Rpc2NhcmRfdGhyZWFkKHN0cnVjdCBmMmZzX3Ni
X2luZm8gKnNiaSk7Cj4gIGJvb2wgZjJmc19pc3N1ZV9kaXNjYXJkX3RpbWVvdXQoc3RydWN0IGYy
ZnNfc2JfaW5mbyAqc2JpLCBib29sIG5lZWRfY2hlY2spOwo+ICt2b2lkIGYyZnNfd2FpdF9kaXNj
YXJkX2Jpb3Moc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICBibG9ja190IGJsa2FkZHIsIHVuc2lnbmVkIGludCBsZW4pOwo+ICB2b2lkIGYyZnNf
Y2xlYXJfcHJlZnJlZV9zZWdtZW50cyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBjcF9jb250cm9sICpjcGMp
Owo+ICB2b2lkIGYyZnNfZGlydHlfdG9fcHJlZnJlZShzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmkp
Owo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2ZpbGUuYyBiL2ZzL2YyZnMvZmlsZS5jCj4gaW5kZXgg
ZDQ0MDIzMWI4Y2IuLjU4Y2VhMmFhMzE0IDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvZmlsZS5jCj4g
KysrIGIvZnMvZjJmcy9maWxlLmMKPiBAQCAtMzg0Nyw2ICszODQ3LDcgQEAgc3RhdGljIGludCBm
MmZzX2lvY19yZXNlcnZlX2Rldl9hbGlhcyhzdHJ1Y3QgZmlsZSAqZmlscCkKPiAgICAgICAgIHdy
aXRlX3VubG9jaygmZXQtPmxvY2spOwo+ICAgICAgICAgY2xlYXJfaW5vZGVfZmxhZyhpbm9kZSwg
RklfTk9fRVhURU5UKTsKPgo+ICsgICAgICAgZjJmc193YWl0X2Rpc2NhcmRfYmlvcyhzYmksIGVp
LmJsaywgZWkubGVuKTsKPiAgICAgICAgIGYyZnNfcmVzZXJ2ZV9kZXZpY2VfYWxpYXMoc2JpLCBl
aS5ibGssIGVpLmxlbik7Cj4KPiAgICAgICAgIGlfc2l6ZV93cml0ZShpbm9kZSwgKGxvZmZfdCll
aS5sZW4gPDwgc2JpLT5sb2dfYmxvY2tzaXplKTsKPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zZWdt
ZW50LmMgYi9mcy9mMmZzL3NlZ21lbnQuYwo+IGluZGV4IDFlN2U3NDViZTcxLi43ZjRmZThjMzRj
MiAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL3NlZ21lbnQuYwo+ICsrKyBiL2ZzL2YyZnMvc2VnbWVu
dC5jCj4gQEAgLTE5MTYsNiArMTkxNiwxNSBAQCBzdGF0aWMgdm9pZCBmMmZzX3dhaXRfZGlzY2Fy
ZF9iaW8oc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBibG9ja190IGJsa2FkZHIpCj4gICAgICAg
ICAgICAgICAgIF9fd2FpdF9vbmVfZGlzY2FyZF9iaW8oc2JpLCBkYyk7Cj4gIH0KPgo+ICt2b2lk
IGYyZnNfd2FpdF9kaXNjYXJkX2Jpb3Moc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICBibG9ja190IGJsa2FkZHIsIHVuc2lnbmVkIGludCBsZW4p
Cj4gK3sKPiArICAgICAgIGJsb2NrX3QgZW5kID0gYmxrYWRkciArIGxlbjsKPiArCj4gKyAgICAg
ICB3aGlsZSAoYmxrYWRkciA8IGVuZCkKPiArICAgICAgICAgICAgICAgZjJmc193YWl0X2Rpc2Nh
cmRfYmlvKHNiaSwgYmxrYWRkcisrKTsKPiArfQo+ICsKPiAgdm9pZCBmMmZzX3N0b3BfZGlzY2Fy
ZF90aHJlYWQoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qg
ZGlzY2FyZF9jbWRfY29udHJvbCAqZGNjID0gU01fSShzYmkpLT5kY2NfaW5mbzsKPiAtLQo+IDIu
NDMuMAo+CgpIaSBXZW5qaWUsCgpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMgZGlzY2FyZCByYWNl
IGFuZCBmb3Igc2VuZGluZyB0aGUgcGF0Y2guCgpUaGlzIGlzIGEgY3JpdGljYWwgaXNzdWUsIGJ1
dCB3ZSBuZWVkIHRvIGFkZHJlc3MgaXQgZGlmZmVyZW50bHk6CjEuIERhdGEgY29ycnVwdGlvbiBy
aXNrIGR1cmluZyB0aGUgcmVsZWFzZWQgc3RhdGU6Ck9uY2UgcmVsZWFzZWQsIGV4dGVybmFsIGFw
cGxpY2F0aW9ucyB3cml0ZSBkYXRhIGRpcmVjdGx5IHRvIHRoZSByYXcKYmxvY2sgZGV2aWNlICgv
ZGV2L2Jsb2NrLy4uLikuIElmIGRlbGF5ZWQgZGlzY2FyZCBjb21tYW5kcyByZW1haW4gaW4KdGhl
IGJhY2tncm91bmQgcXVldWUsIEYyRlMncyBkaXNjYXJkIHRocmVhZCB3aWxsIGFzeW5jaHJvbm91
c2x5IGVyYXNlCnRoZSBkYXRhIHdyaXR0ZW4gYnkgdGhlIGV4dGVybmFsIGFwcGxpY2F0aW9uLgpU
aHVzLCBoYW5kbGluZyB0aGlzIGF0IGByZXNlcnZlYCBpcyB0b28gbGF0ZeKAlHdlIG11c3QgY2xl
YW4gdXAgYWxsCmRpc2NhcmRzIGF0IGByZWxlYXNlYCB0aW1lIGJlZm9yZSByZXR1cm5pbmcgdG8g
dXNlcnNwYWNlLgoyLiBQZXJmb3JtYW5jZSBpc3N1ZSB3aXRoIGJsb2NrIGl0ZXJhdGlvbjoKTG9v
cGluZyBibG9jay1ieS1ibG9jayAoYHdoaWxlIChibGthZGRyIDwgZW5kKWApIGNhdXNlcyBtaWxs
aW9ucyBvZgpsb2NrIGFjcXVpc2l0aW9ucyBhbmQgcmJ0cmVlIGxvb2t1cHMgZm9yIGFuIDhHQisg
ZGV2aWNlLgoKRml4OgpJbiBgZjJmc19pb2NfcmVsZWFzZV9kZXZfYWxpYXMoKWAsIHJpZ2h0IGFm
dGVyCmBmMmZzX3dyaXRlX2NoZWNrcG9pbnQoKWAsIHdlIHNob3VsZCBlaXRoZXI6Ci0gRHJvcC9j
YW5jZWwgcGVuZGluZyBkaXNjYXJkIGNvbW1hbmRzIGZvciB0aGF0IHJhbmdlIGZyb20gdGhlIGRp
c2NhcmQgdHJlZSwgb3IKLSBTeW5jaHJvbm91c2x5IGZsdXNoIGFuZCB3YWl0IGZvciBhbGwgZGlz
Y2FyZCBjb21tYW5kcyBpbiBgW2VpLmJsaywKZWkuYmxrICsgZWkubGVuKWAKCklmIHlvdSdkIGxp
a2UsIEkgY2FuIHdyaXRlIGFuZCBwb3N0IHRoZSBmaXggZm9yIHRoaXMuIExldCBtZSBrbm93IHdo
YXQKeW91IHRoaW5rLgoKVGhhbmtzLAoKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
