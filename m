Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868A2C624D3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jw0uq9l6F+HT5sbmjhm+zz3+cp6X9zkXsfrYpgGyYpM=; b=SYk2vUaodyLhmAoG+IPFnlNc7Y
	jiedHWUVrLNcN9nDZACdpRFa0s9QjElPNLDNUG7+oXFHY/OPrFTlA/EJVpO9o5P1BpcObUtcIuBdi
	rnR/Jnru4g4bRNxNwVWIutgAr6qbRE0FVZjewpT05diMyLZ9nsSlXW2mp+Hc96Tsuy+c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1QSx-0001sV-Tx;
	Tue, 01 Sep 2026 15:32:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x1QSZ-0001ry-Ec
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:31:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=trbjSUimL066O79ZMRgr1uc4znNmcIHwMo53kKP9TCA=; b=OkYn1hR3v/hTFZC0CaEWDRiPvh
 1PH2KHLeQNfFADgelyjP8Z+5Wn38yvKK0ytNPpoXvQe2VSpxFEV/QuVQA/DqpgR4uerV6CpRqkLH7
 W+MPL6JA30IcCLPgC/k/xfF9jQ6nsay/gTsegkn4tR4QMrg3NXwX0Rgj6HpMlN/Xs6/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=trbjSUimL066O79ZMRgr1uc4znNmcIHwMo53kKP9TCA=; b=DSlI9/5FzvRcmdGYHHhABx+6a6
 As9TnEStT3ugnZ414/FmLgCbcOlBiRtxHaKRgz8utq8poQHSW8TMxiMlwnmNKJ5qvsQ87nMpwJmNi
 vko/pv6kGeTYvGwb2KetdQKcvOsaMUvTJ2bxhOh64XPG+RIevtQ98pzdZFp/05OGyKis=;
Received: from mail-lf1-f54.google.com ([209.85.167.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1QSY-00044y-K7 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:31:40 +0000
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5b0115b9e17so1010276e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 08:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788276692; cv=none;
 d=google.com; s=arc-20260327;
 b=nPS9OyW7ik1BGauO4O48xk+GmJOl0Lp8PisZWGxAjM+kjJrb7JQAmfCLcR7kKkwrp4
 TSBE3QQ3Sp/PhDoUK00JTrL2klZuPVQGm3BTxzoGHP/KNkLGQL04qI8VMojTTI+uCapV
 MdROz0PBa0HoKTNDT6WdCL7uPw3w/BIb+j1bDxa2n57eT2I2FbmSSD+jqsszRL1lOyaC
 mQaJdBTQsrL4D2RD2XSnHCSuReIDHzYcF789DbNhfqdYFORCvJLAQozG9seNPJZrVzBl
 aOd82Bn0+dsvDJE+mkQVn3FVM6GmCECgmlun0CiOuc1iDZzDvAS0sHa8mTKvBNhUnyPz
 5SMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=trbjSUimL066O79ZMRgr1uc4znNmcIHwMo53kKP9TCA=;
 fh=DXsgjS1263a7qXOF69bhAPJ7N7IhO/tsKijGxQRHGXY=;
 b=Sy0h1UBBShjm/+QP2qJSqWVMKpzGnNHopgfjuP8ipdpDR1J40dYrpgQ1VX1aNmqlEy
 5pDsFCmE5GNVB6tMIy7YkQHa3ad+LhyLzzEjCNG76c1FQVtQk9j8ZR9jQrGdRbPvUlcx
 I2RHVZLmBMr+A7xHyyI+AhmoYLCiXshczvqmQj9sXexvZ+cygIXx1wtHmVMGYZ6vXXMT
 bpT825QXUUZSuIUQovsEhE++traUooa5qyVyys+ra1+H1iGm50hn7r/CtrwlhAZBACrh
 4zZFBOsFtr/p2UMy/89vo44/+w+cG+8OREy/2wH46+zUnlqc5qqcFDqnjFjurPwMc0CJ
 ayKg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788276692; x=1788881492; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=trbjSUimL066O79ZMRgr1uc4znNmcIHwMo53kKP9TCA=;
 b=kUyH5cXhtziNV+uS2vGDjZMaA38XJXJldb/2SkQVi2+yN44j/IrG64iiDDENrRXrmR
 q9iMCiAoOGLlWQmdJQQz7pvVtrwXwf0+V00ROSFt9BGd0azPY9YwyEdcgXV3r0Tj/lOW
 pDGOrwsrSJw7HzoB0MK6ZkwEcjmM2Br4/nCMJblYSOA12ZEnXmSp0GQWmQUt2nKtYGMO
 htp57oSpgdDM5ZNsXWTuJ8j1vIAEESkGyppQE7Z2IDvpz051AFdiKshaoq+Q07qXLAxu
 Ky9WNcEjG0yLslTPHycQa1pFoLPAInES+GZe9yLwrVl+j4WlWw1p8z3r4wI7jmRagYhs
 ETeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788276692; x=1788881492;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=trbjSUimL066O79ZMRgr1uc4znNmcIHwMo53kKP9TCA=;
 b=eyTjsXHb5c2kA5O/bm9Qlu6mAAvYaNleACPC4vVDWdfx9DShf3fpPybQSx+QYKWW2e
 ZXXGEQEo4OX0JsKFB/anIYSxIocxu5ylvBe1pYYB92UiTLOse4WvjmywwCRLRinf/G8M
 M04M0PzENK6Rk1K7AjcjCb1EvppwM3qI4FNxMUzfjx+FqY3mhO4eanC0peZ1yuOpFmUV
 uapMG+ExIcKRHl2rGnOI6mQcAV3gpGSMmH/x/EwVuV4Nr+7L8V6dUV39tFAMwmm0OC4L
 0ZW2a6f4BWtlcd220SCNGrhMQLq35odDkwOTbLBOmQOtu7zuoe48DmFPFX5UmIztzZlC
 13nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSlPdoX3St1GHn6TbDeO/OCT+pRZ5vuqBjm7MUG8oSgW99hhsBea7HxSaKBbpaF20KSkXVhhPFfeECtbpywGf2@lists.sourceforge.net
X-Gm-Message-State: AFuF++n7PpZbpP5+F16lnu3+eLF4EtzNn2Qz+zaoT1EZJFP9vbNCZqLr
 AXqZQaLLTfTbYRXzQ8vj8CetX+l3Ad8DHeaNvN+ZGJnb7aI67AMVlN3DDeW/KHAikHEtIn7qtVz
 fcGoBuq9j6eS0x3Z6+61Ljb5+XVKZYJk=
X-Gm-Gg: AYBFou15WeimSfuXXlhfPlEo8L5N8aomM1u6//B4YSJkfyaFa380wDJTP+vuYdU/6Da
 kDd6+ZXPMAejxNHj8gnS43Gox56MeuMxQaLTrFqMoqytr8pW1tJT2hZTlVESUVIqtRNqfw8vtA0
 E4prXyDUUI0oEUCXPtQbvWkCkMk9fj84R2GBR63FdX5ABhnW3MmfpYdzXhPa1q1EBA6zaumLVPs
 o2xQ2YpXaL37aLX6wUg/4QfrNlW734qR8rAuXsCMAwjvSBxf4aolba6wA/DvH+CY1n7PL/pRFnU
 Qv7n0oOgklKcuReQdMljC/Vrk0KVG1Tb2ZIZTEIpu75pSp/2dbDy9CAZctaccU0BVxzh0XaX8LX
 SnW72oVZhkYG4C/rfRgo01tah+VzHAXY=
X-Received: by 2002:a05:6512:39c2:b0:5ae:c201:c3d7 with SMTP id
 2adb3069b0e04-5b5e68cc56bmr11174306e87.8.1788276690888; Tue, 01 Sep 2026
 08:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260901031000.786214-1-daeho43@gmail.com>
 <20260901075104.1158778-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260901075104.1158778-1-qiwenjie@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 1 Sep 2026 08:31:17 -0700
X-Gm-Features: AcwNN1VmOJO3WOloym_tyK0d1j9na1G5NHV2K8M5ax3zCm8-dGeKVlKGdwq0wa4
Message-ID: <CACOAw_yJSUTsy8oE1VWsmZJOJA=RMYb0aq6=jy6dHVQSM+P_NA@mail.gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1x1QSY-00044y-K7
Subject: Re: [f2fs-dev] [PATCH] f2fs: drop pending discard commands before
 reserving device alias
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 daehojeong@google.com, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVHVlLCBTZXAgMSwgMjAyNiBhdCAxOjQw4oCvQU0gV2VuamllIFFpIDxxd2podXN0QGdtYWls
LmNvbT4gd3JvdGU6Cj4KPiBIaSBEYWVobywKPgo+IFRoZXJlIGlzIGEgdXNlLWFmdGVyLWZyZWUg
aW4gdGhlIG5ldyBoZWxwZXI6Cj4KPiAgICAgaWYgKGRjLT5zdGF0ZSA9PSBEX1BSRVApIHsKPiAg
ICAgICAgIHN0YXJ0ID0gZGMtPmRpLmxzdGFydCArIGRjLT5kaS5sZW47Cj4gICAgICAgICBfX3Jl
bW92ZV9kaXNjYXJkX2NtZChzYmksIGRjKTsKPiAgICAgICAgIGNvbnRpbnVlOwo+ICAgICB9Cj4g
ICAgIC4uLgo+ICAgICBpZiAoZGMpCj4gICAgICAgICBfX3dhaXRfb25lX2Rpc2NhcmRfYmlvKHNi
aSwgZGMpOwo+Cj4gX19yZW1vdmVfZGlzY2FyZF9jbWQoKSBmcmVlcyBhIERfUFJFUCBjb21tYW5k
LiBJZiB0aGUgbGFzdCBjb21tYW5kIGluIHRoZQo+IHJlcXVlc3RlZCByYW5nZSBpcyBEX1BSRVAs
IGRjIHJlbWFpbnMgbm9uLU5VTEwgd2hlbiB0aGUgbG9vcCBleGl0cywgc28gdGhlCj4gZm9sbG93
aW5nIF9fd2FpdF9vbmVfZGlzY2FyZF9iaW8oKSBkZXJlZmVyZW5jZXMgdGhlIGZyZWVkIG9iamVj
dC4KPgo+IFRoZSByYW5nZSBhcml0aG1ldGljIGFsc28gbmVlZHMgY2FyZS4gYmxvY2tfdCBlbmQg
PSBzdGFydCArIGxlbiBhbmQKPiBzdGFydCA9IGRjLT5kaS5sc3RhcnQgKyBkYy0+ZGkubGVuIGNh
biB3cmFwIGF0IHRoZSAzMi1iaXQgYmxvY2stYWRkcmVzcyBsaW1pdCwKPiBhbmQgdGhlIFJCLXRy
ZWUgbG9va3VwIHN0aWxsIGNvbXBhcmVzIGFnYWluc3QgYSAzMi1iaXQgY29tbWFuZCBlbmQuIEEg
cmFuZ2UKPiBlbmRpbmcgYXQgMl4zMiBibG9ja3Mgd291bGQgdGhlcmVmb3JlIGJlIHNraXBwZWQu
CgpUaGFua3MgZm9yIGxldHRpbmcgbWUga25vdy4KSSB3aWxsIGZpeCBpdC4KCj4KPiBUaGFua3Ms
Cj4gV2VuamllCj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
