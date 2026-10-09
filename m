Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6279DCA601D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5OE6kBJUpbPKuppRR72u8RvlBef+LTco+q+IUJMpI8=; b=kSXs/Bp6OefbMagjb6wjzjTXqP
	d//+QJLSs45/5LUWm15ffoqELPiw5KxSBxazQc+/iHvYaT1cqpmQN1rRWrn9lQrsw9bcJiu+/fGcZ
	qxXUY3M3WUmEaBznLzxiHfSIP1Ejd0ILRNl7heXAzBoRe1jNRGLSTmVvBgWlO+52xQ88=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFCAO-00010Z-7K;
	Fri, 09 Oct 2026 15:05:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xFCAM-00010S-H0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:05:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wDZ2vMGrGE4GsgsQilcLhHHSrN6fikmAwg6tgPE8yrU=; b=HMvG++EgZh3rFYSeVZZmtCcY5r
 lqnOy7fVTgK0Q78wC6DHHnelf48Qb839DPBK1xeqw5Z47WzJk8E5zCIBXw0rReOiI6AZOONbqOzRq
 do/Tcjs/ndMykPKN6+3rTTLyUNMHOKYImTxkTS8PHmUvCImwx6l+oiZ8yRb8RPem5wfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wDZ2vMGrGE4GsgsQilcLhHHSrN6fikmAwg6tgPE8yrU=; b=BRZQmm6uVZLPqQxKp2mLoxzsxg
 /5ztp5S8DMg5AfSD+ITygQk6jgz8kqB5o11Y/YRF7UDGd9lWrto9T0rAXsKjcJXAvITHEVPwaYGaW
 ej/IxCAsqB//lLJiw3Md2rzeUT0DowN5rf/ssy/ntYmEQ0SnfA+/Gy78Eynk1N5Bkp4w=;
Received: from mail-lf1-f48.google.com ([209.85.167.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFCAK-0003Ih-Vd for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:05:46 +0000
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5bcbd8df6fdso2913863e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 08:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791558338; cv=none;
 d=google.com; s=arc-20260327;
 b=XzE/k3JiuU0+jLT7f05t1tT0MT9gegonfWdhUknZT+9QHiHUXiFBuGrNMawuN622Zq
 D472mLBqHRBkofxpBRohkWeCueD/LDIjNBmGrf9wXRkSMoniz2zO4Hq2oF1C1+v6l3M4
 SIBa1clKTAQ+DBGlna9Wp7uImmXMzP/hukkYpwSWAYsTWqq57w8e20LBie6jpgM4GqsY
 qE59WQRoBCZhc2wc2Jl22FWkbIkZF5geYlT93eUAi1OiKIAx1OEOXKZnxld+0nHZ8m6N
 o9CarmZmI7ADqi8kBmzb/NUGazWQfmO3/uw09KpGCNS3eSvYI56irZUyF7FQdaXQouPC
 +AUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wDZ2vMGrGE4GsgsQilcLhHHSrN6fikmAwg6tgPE8yrU=;
 fh=AzytvgDrcNe+3UBhVvy+KTsZumqJ7mgVXfY3BIfPlEw=;
 b=MwPsdXQa73luOFRMm3bdHqZk55S0x/Aur2c276hqAJzaWTiXZDqtyZSw37uF264uxB
 eKRJywLwcsfD1Yy10nG2Us6Sxl6WzWUYQiLiq331AG/Q927RelepAOX0LYwtqX7039yV
 Q9bgqiDRkEJsj+V2feWFHxaG8LmjjE4lPWWOKbCBRFO+Gh1ilU6e7Jov3Z9iLd5yH5ow
 KZP6t2Xl89WdaiG2wtewoA0lFw5IVgrMITpQcvW7w/OLW+qPpyYtoB8jSrhkTIbczo8+
 cqPoCv/FX4U65DKJSstAVro39rF3W9ck14kguLOnZvaYXXo4eGuE7gLxYmTMDDCGr2cT
 wPYQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791558338; x=1792163138; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wDZ2vMGrGE4GsgsQilcLhHHSrN6fikmAwg6tgPE8yrU=;
 b=X5g+R5/kQha8q9clg4VA/UXlSAm9ir+vYWuuUoXUUCGXbYRvnp9mgkR3yv4y4MSLhk
 SiHZS2zzQgYHBP1vEzdlMWKbYNxx6eB0MeDPOL5S9D9QJJERnvvgP5bJHrAYRSJKeVe3
 +I5poh+kKrpQc3noXaewokkzPkTMNHmDZJTkNOXR0eZ0eDmVZ0QsW4qJbeS6Npoy/Fwd
 /vtE0Mpy9EMEpi0bWrVwjMgvIVITLt55As1JQfAgzHrSxvnGHeyL4hetIxJp+VegHNAm
 UwmFfdlw78b8U86QLi/t/paWcynr0oMuq8Cxc0KO1JmU35sAaPvrMU0RI6VwUfphABqS
 nxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791558338; x=1792163138;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wDZ2vMGrGE4GsgsQilcLhHHSrN6fikmAwg6tgPE8yrU=;
 b=x8Ec7dBsgHk2EkLlNlWXfmiJz6K5nqMZogtok8ljKo9AbHuKNNsnfCGVNK2a2sdc04
 ZANfsA+/Oh8h9ZWDYlLxVyQ/y8g0XgyToCXpLNyKE9sK9Y42jK2D8lEZDnEFuIEiOLn7
 BWkOuJFHfbKd41PJyXlt6bC95XIReLB2cCDv/y9Qz8U9SD595+gfJtlBcPFaq3qJdVvK
 Gh8RQXEQYsjpPBoh5tcniU73uVwAxqP5Ru43/oa1BtEc0sh6xORLKLzXwf8WCMre4+Gi
 +tWjo8waw1c4ClyTuScslJu2aUczTPwzTSCvtj6S9k58kZXsIZjGhCx3y5wZxqTabucz
 2MJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxakcxGpm8jaO7y1wJTndHD0rMZ9hmQTxKpLvQj4ac8YsvU7fC+eRe1GkzFShhc4jJPhH+tnkRHccThvOicRY44@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLdEmk+5StHA1EJZVUnrC91VWd84zZ0Odl7EufpFebpiiFdRvEP
 h/9lGFlEadL/DAzyAwHcm6AaU5900J+X0ZnAzoUWV8lhqlyrDtAy/F2KvVLKmqr17kaaqOtVk6B
 JVuRZICow6YH53ubMOLNGuFC7gqaRz9M=
X-Gm-Gg: AYBFou0d7TwHxedjJgy/WJRKbPArK+RyKyUJVBXVZoH2bfw5tdyKPfpn3dJ4FR5EBpj
 gqhu9NoXVV630P5QtyN5XtJBxoM9CbiYW93Uas1YkouZiHq9GJnYNgA+oXVpBgt4XFRz1s8UGOS
 dRkDOmEuec9Uf5xAg7x+QQuXnBlt4FYbMjbhecC8bEV1kKNe3ZPmtoO1qcDYR8pUsw8XKi6rvQR
 5Jv/Xd78t7sX3+vynHWgr9HR5kdLVykz86/DOLfMKHEmcK7ZYGmHbL/MnEdnwc58TivnMkvA2K0
 cgnGkLD3hIbWddnRW/dQShQ9RLzsSxk+2xkqhTbW9pzchLZULepfVZxlL3lA7PpIQf//QIldVDX
 T0B36bT+ClF8ZjBW1rbgze1iDGWdeoeH0N5aE1XeVxBUV
X-Received: by 2002:a05:6512:3189:b0:5b8:f1ae:cbf3 with SMTP id
 2adb3069b0e04-5bcde6bb716mr785623e87.21.1791558337820; Fri, 09 Oct 2026
 08:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261002171704.3652570-1-daeho43@gmail.com>
 <63812000-4677-4af6-a3e1-4e87e39f0d88@kernel.org>
In-Reply-To: <63812000-4677-4af6-a3e1-4e87e39f0d88@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 9 Oct 2026 08:05:25 -0700
X-Gm-Features: AclHuK_BanzYX18T1PuwZKeUxRb9PVETFkcfnNYDdUp-utwELe1CHp99YcU5vzM
Message-ID: <CACOAw_w5uXiYqGObti+uiWwJSeaNCZc6+t3j2yopL-PLf226=A@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xFCAK-0003Ih-Vd
Subject: Re: [f2fs-dev] [PATCH] f2fs: disallow mmap write and data-modifying
 fallocate on atomic files
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

T24gRnJpLCBPY3QgOSwgMjAyNiBhdCAxOjM14oCvQU0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3Jn
PiB3cm90ZToKPgo+IE9uIDEwLzMvMjYgMDE6MTcsIERhZWhvIEplb25nIHdyb3RlOgo+ID4gRnJv
bTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPiA+Cj4gPiBTdG9yZXMgdGhy
b3VnaCBhIHNoYXJlZCB3cml0YWJsZSBtYXBwaW5nIGFuZCBmYWxsb2NhdGUgd2l0aAo+ID4gRkFM
TE9DX0ZMX1BVTkNIX0hPTEUsIEZBTExPQ19GTF9aRVJPX1JBTkdFLCBGQUxMT0NfRkxfQ09MTEFQ
U0VfUkFOR0Ugb3IKPiA+IEZBTExPQ19GTF9JTlNFUlRfUkFOR0UgZG8gbm90IGdvIHRocm91Z2gg
LT53cml0ZV9iZWdpbiwgc28gdGhleSBieXBhc3MKPiA+IHRoZSBDT1cgaW5vZGUgYW5kIG1vZGlm
eSB0aGUgb3JpZ2luYWwgaW5vZGUgZGlyZWN0bHkuIFJlamVjdCB0aGVtIHdoaWxlCj4gPiB0aGUg
ZmlsZSBpcyBpbiBhdG9taWMgd3JpdGUgbW9kZSwgYXMgZmFsbG9jYXRlIGFscmVhZHkgZG9lcyBm
b3IgcGlubmVkCj4gPiBhbmQgY29tcHJlc3NlZCBmaWxlcy4gQSB3cml0ZSBmYXVsdCBnZXRzIFNJ
R0JVUyBhbmQgZmFsbG9jYXRlIGdldHMKPiA+IC1FT1BOT1RTVVBQLgo+ID4KPiA+IGZhbGxvY2F0
ZSB3aXRob3V0IHRoZXNlIGZsYWdzIG9ubHkgcHJlYWxsb2NhdGVzIGJsb2NrcyBhbmQgc3RheXMK
PiA+IGFsbG93ZWQuCj4gPgo+ID4gRml4ZXM6IDNkYjFkZTBlNTgyYyAoImYyZnM6IGNoYW5nZSB0
aGUgY3VycmVudCBhdG9taWMgd3JpdGUgd2F5IikKPiA+IFNpZ25lZC1vZmYtYnk6IERhZWhvIEpl
b25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4gPiAtLS0KPiA+ICBmcy9mMmZzL2ZpbGUuYyB8
IDEwICsrKysrKysrLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2ZpbGUuYyBiL2ZzL2YyZnMv
ZmlsZS5jCj4gPiBpbmRleCBlZjRkMjE4ZTY5NC4uNTZjNjg2Yjg1ODAgMTAwNjQ0Cj4gPiAtLS0g
YS9mcy9mMmZzL2ZpbGUuYwo+ID4gKysrIGIvZnMvZjJmcy9maWxlLmMKPiA+IEBAIC0xNDAsNiAr
MTQwLDEwIEBAIHN0YXRpYyB2bV9mYXVsdF90IGYyZnNfdm1fcGFnZV9ta3dyaXRlKHN0cnVjdCB2
bV9mYXVsdCAqdm1mKQo+ID4gICAgICAgICAgICAgICByZXR1cm4gVk1fRkFVTFRfU0lHQlVTOwo+
ID4gICAgICAgfQo+ID4KPiA+ICsgICAgIC8qIG1tYXAgc3RvcmVzIGJ5cGFzcyB0aGUgQ09XIGlu
b2RlIGFuZCB3b3VsZCBicmVhayBhdG9taWNpdHkgKi8KPiA+ICsgICAgIGlmIChmMmZzX2lzX2F0
b21pY19maWxlKGlub2RlKSkKPiA+ICsgICAgICAgICAgICAgcmV0dXJuIFZNX0ZBVUxUX1NJR0JV
UzsKPgo+IFdpbGwgd2Ugc3VmZmVyIHJhY2UgaXNzdWUgZHVlIHRvIHRoZSBjaGVjayB3L28gbG9j
az8KPgo+IFRoYW5rcywKCkhpIENoYW8sCgpZZXMsIHRoZXJlIGlzIGEgcmFjZSB3aXRoIGYyZnNf
aW9jX3N0YXJ0X2F0b21pY193cml0ZSgpLgoKcGFnZV9ta3dyaXRlIGNhbm5vdCB0YWtlIGlub2Rl
X2xvY2ssIGJlY2F1c2UgdGhlIGxvY2sgb3JkZXIgaXMgaV9yd3NlbQotPiBtbWFwX2xvY2sgKGUu
Zy4gZmllbWFwIGNvcGllcyB0byB1c2VyIHVuZGVyIGlub2RlX2xvY2spLiBTbyB2MiB3aWxsCnVz
ZSBpbnZhbGlkYXRlX2xvY2sgaW5zdGVhZDoKCmYyZnNfaW9jX3N0YXJ0X2F0b21pY193cml0ZSgp
IGhvbGRzIGZpbGVtYXBfaW52YWxpZGF0ZV9sb2NrKCkgZnJvbSB0aGUKZmx1c2ggdW50aWwgRklf
QVRPTUlDX0ZJTEUgaXMgc2V0LgpmMmZzX3ZtX3BhZ2VfbWt3cml0ZSgpIHJlY2hlY2tzIHRoZSBm
bGFnIGFmdGVyCmZpbGVtYXBfaW52YWxpZGF0ZV9sb2NrX3NoYXJlZCgpLCB3aGljaCBpdCBob2xk
cyB1bnRpbCB0aGUgZm9saW8gaXMKZGlydGllZC4KCklmIHlvdSBhcmUgb2theSB3aXRoIHRoaXMs
IEknbGwgc2VuZCB2Mi4KClRoYW5rcywKCj4KPiA+ICsKPiA+ICAgICAgIGlmIChpc19pbm9kZV9m
bGFnX3NldChpbm9kZSwgRklfQ09NUFJFU1NfUkVMRUFTRUQpKSB7Cj4gPiAgICAgICAgICAgICAg
IGVyciA9IC1FSU87Cj4gPiAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ID4gQEAgLTIxMTMsOSAr
MjExNywxMSBAQCBzdGF0aWMgbG9uZyBmMmZzX2ZhbGxvY2F0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwg
aW50IG1vZGUsCj4gPgo+ID4gICAgICAgLyoKPiA+ICAgICAgICAqIFBpbm5lZCBmaWxlIHNob3Vs
ZCBub3Qgc3VwcG9ydCBwYXJ0aWFsIHRydW5jYXRpb24gc2luY2UgdGhlIGJsb2NrCj4gPiAtICAg
ICAgKiBjYW4gYmUgdXNlZCBieSBhcHBsaWNhdGlvbnMuCj4gPiArICAgICAgKiBjYW4gYmUgdXNl
ZCBieSBhcHBsaWNhdGlvbnMuIEF0b21pYyBmaWxlcyBzaG91bGQgbm90IGVpdGhlciwgc2luY2UK
PiA+ICsgICAgICAqIHRoZXNlIG1vZGlmeSB0aGUgb3JpZ2luYWwgaW5vZGUgZGlyZWN0bHkgYW5k
IGJyZWFrIGF0b21pY2l0eS4KPiA+ICAgICAgICAqLwo+ID4gLSAgICAgaWYgKChmMmZzX2NvbXBy
ZXNzZWRfZmlsZShpbm9kZSkgfHwgZjJmc19pc19waW5uZWRfZmlsZShpbm9kZSkpICYmCj4gPiAr
ICAgICBpZiAoKGYyZnNfY29tcHJlc3NlZF9maWxlKGlub2RlKSB8fCBmMmZzX2lzX3Bpbm5lZF9m
aWxlKGlub2RlKSB8fAo+ID4gKyAgICAgICAgICBmMmZzX2lzX2F0b21pY19maWxlKGlub2RlKSkg
JiYKPiA+ICAgICAgICAgICAgICAgKG1vZGUgJiAoRkFMTE9DX0ZMX1BVTkNIX0hPTEUgfCBGQUxM
T0NfRkxfQ09MTEFQU0VfUkFOR0UgfAo+ID4gICAgICAgICAgICAgICAgICAgICAgIEZBTExPQ19G
TF9aRVJPX1JBTkdFIHwgRkFMTE9DX0ZMX0lOU0VSVF9SQU5HRSkpKSB7Cj4gPiAgICAgICAgICAg
ICAgIHJldCA9IC1FT1BOT1RTVVBQOwo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
