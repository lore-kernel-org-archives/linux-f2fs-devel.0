Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E15C4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XwcLBv3+Z0z0zOnqz+rC5ddSYarsiBjOUAPpbK996B8=; b=B8c2SKrh5TmdQ5d/07RYcloSZk
	PkRAW5WD3UZ+ebyvi7dOQTT4c6yuorSnn8R/onBKShfpWpGqiJBtOLoqeW3lpWlJHzyWZLhPmorQ+
	xQnwRUehYCi0kBguNpCGP0y3D1RwPZC26bvLDozZdUOJ2yu8esbU6fNCXrVqPjghnhHg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlgb2-0000YN-Ig;
	Mon, 20 Jul 2026 05:31:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wlgan-0000X8-Ir
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 05:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sPm59SK7i//7W50z2AKWjiPmMBSaMtZbIwTV1EeD0so=; b=VP/3C68JlXFkNhdqvYTt4UVUW6
 Tkm1eIkEEnpTNaUfBdsyJbyAnRl2KO120yNcL7/OGxVaZw1VQXXhZbyN7ki8XgDAjZgfCIlHr4jKg
 zDjUyB6ttH7zt12Qvn3dthVyi8yAR2sWXANzwdYOKSJ0/Lv+HURZjrUSz/cXX91MnkP8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sPm59SK7i//7W50z2AKWjiPmMBSaMtZbIwTV1EeD0so=; b=UzdaMgUjjkL9z77Ka38PcP9qLh
 LomMDNJpIVpqgjyeSM0hYbbYyKMnB741Dd3VsKa0sqOF6W9syFum4tBLoBOYidza5pJz/YC5dTDwv
 GC/jl5nluo2F7pnoeetYf2HGamWIqVLUwTDxouWLS8sNO4WznYlTD+FzCQx3xn7IV8F4=;
Received: from mail-lf1-f42.google.com ([209.85.167.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlgam-0004aj-QA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 05:31:06 +0000
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b0231a3e86so9235731e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 19 Jul 2026 22:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784525453; cv=none;
 d=google.com; s=arc-20260327;
 b=qKxptRHmLCVi1s4FiptDWjNFSv0MufNpds81PrVQdcFV+Ti0hGJnAKYtQAMHDGDQcB
 VLPrz4DJ2bxctDFRFbJCDfw2edT3LuDejsqMEVyEJmi06Q7S9FLEY6ZVysI7FYL3i0/R
 pVX0u8FkO1e+caYjP3k4pEhuuatDbNeqolk6xq7VtOMyCmbkmDddDZd2NE5nXJSVNi3U
 q9/de7ig5TZFM94SSwKHzDdDv22VwNhe2E5qdTbf4QQHRSJrl9WrBpZpi4JUTMmnXpqE
 x5NOqT6mbXfdmdFKc8fTxpD2ocvPbs5u1879DsWLz4J1jQ6ubaQsRutOOM0M4eR+qqfs
 r/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sPm59SK7i//7W50z2AKWjiPmMBSaMtZbIwTV1EeD0so=;
 fh=qZ1gNFymmrpDo8N90RIjMAo/z7Q1fQSM+e2kxPWpXek=;
 b=Fd0+UWFG7UYDJGxFl7xs0TTxc72JT6s3DZMzrzZVvjw7we8ecPxlmrO9cE+2gLXCHk
 GGaZMsga7YqGG0AcEvTkUVsk81lIZ0GIgMa6SBTo6OZI65gKp3oWG/FISWJeB5+T0+Hd
 9eaRMsj00ZdvGAnBsjn0ukgCuycQeJiWrVCIISdD2SPlU2Kt5gvbRky24WyIxkB7Tbqu
 QHfj5cnXXJlA0ImX/VM2dvUA8CyIYTpcvTbLMbgtpfqNcLUR53TblY9xubOEuMQcDKMc
 PPXrsyjohc8dZN4mEpFDT8EjuBGfQZTqNN9BxhtwPlIHyS0oRfTq5BgR2+CNamImDm9V
 R3aw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784525453; x=1785130253; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sPm59SK7i//7W50z2AKWjiPmMBSaMtZbIwTV1EeD0so=;
 b=i6RQLvbgFa/xhg1dUrU4AJglt3bPG6HMm3ZVxYjahWlzdabofB87jRn1wL1j8eQ5Rs
 ciX0iQ8N4fWJFI/CMvjnmbk80aMClyOWty3Nrz/efZFfmvhvHL9/Lip5eEYUY0lyXa62
 CIDX+2a/vstJZhafuJtJogxPQsMR4AOUgZ+huB3OJ5uUbzGAhUoJjYteeL6p4wsOgGsF
 9cTRUER6RSSfgycEoi7mCphl0/Vtb4+uigeTXpKAb0f43SAK9Gz9WB3mueHXTa+DqJLe
 mXndwHChCZeL5uJq7BaE9R5f6Byh2Qm1AA2tcQsB/9i6mtmLhMlbPttl8KeMK6r4QSAE
 IN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784525453; x=1785130253;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sPm59SK7i//7W50z2AKWjiPmMBSaMtZbIwTV1EeD0so=;
 b=M3x2UAYEtK2Z9gtHK7623OEwjhBIN19XCFC1dSwebUlLWZVzZgjUDa+Myns1QSWKa3
 vwCmMysDdeRF/16TnB79NY3OpVUnULzPNdQEjsf4iKCVEXuyv7/lm0oPf5oVH6bEKoB5
 NIFrRLvlIdWJn+iJCIDFW2pF5icoub3WeM9bwsAL+mkd3hJyey7FXHdFT8fuZ/M4mHt4
 eAMXSotDqnoQC4ImtFYARdIOMQdvaVAMYbCCwxQlTAQRJ2z3CVK6BiKbiFjtCuO3eB90
 NuM6b/K2K3MGBEm+8z+qHFWZbTzSk1Kb5oUAWrPXqzfrZR17IaYZcxdaKWi3xh3DZG4t
 PkxA==
X-Gm-Message-State: AOJu0YzoQbXuGywtwieLf+kSQhK/LiIuU+eezV1wuF8J5v2XQazhoDW5
 L44+yj3urso0Sdi0PRkFZMO7hwUapirSUNoLcczTLBaJmlL1gcrwNmR1NiAVnftjiGYZ3gym2U/
 tYcCIUfXzyQKr7Oxgv7Ns5vj+QQRYtbA=
X-Gm-Gg: AfdE7cnxYVZHUtH2N1nAPibkrk/Soo2LRjNknCG+iNugexy1H6IFF0ZwC6L+pfioAEN
 Zew34DdS9PYLK/M/Yme2/HgS5JhaAmGSv4lmFVqxYgcU9ptc4Vc3ufEu0lmeTru7zyaZ5CM0hRu
 xahxSwZ83i7vzGQ5iKAVAOQiurIY949kWBm1JuadGtVwyaZvvwS2Y0o9YKsnNl0Zbk95mZ88byL
 +NGax4iMLxDt33ikD/8CufR3N1w3yeHTFGgtZBvrG3r5Pqz5h70M7qzUheqATg=
X-Received: by 2002:a05:6512:3185:b0:5ae:b2e3:fc24 with SMTP id
 2adb3069b0e04-5b28fabb0afmr3051909e87.60.1784525452785; Sun, 19 Jul 2026
 22:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260630031700.2573819-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260630031700.2573819-1-qiwenjie@xiaomi.com>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 20 Jul 2026 13:30:41 +0800
X-Gm-Features: AUfX_mzx5IW3sPF336jcB0B4HmcAJ4rmYMKmG07-i54NrJaS8farF6wVkmffM78
Message-ID: <CAGFpFsR8nMA9ZaDhOHvRd=kKaO_HN_7OtCy+aWSuvURUA_jHEw@mail.gmail.com>
To: jaegeuk@kernel.org, chao@kernel.org
X-Headers-End: 1wlgam-0004aj-QA
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate MOVE_RANGE destination size
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

cGluZwoKT24gVHVlLCBKdW4gMzAsIDIwMjYgYXQgMTE6MTfigK9BTSBXZW5qaWUgUWkgPHF3amh1
c3RAZ21haWwuY29tPiB3cm90ZToKPgo+IEYyRlNfSU9DX01PVkVfUkFOR0UgY2hlY2tzIHRoZSBz
b3VyY2UgcmFuZ2UsIGJ1dCBub3QgdGhlIGRlc3RpbmF0aW9uIGVuZAo+IGJlZm9yZSB1cGRhdGlu
ZyBpX3NpemUuIEEgc291cmNlIGhvbGUgY2FuIGV4cG9zZSB0aGlzOiBfX2Nsb25lX2Jsa2FkZHJz
KCkKPiBza2lwcyBOVUxMX0FERFIgZW50cmllcyBhbmQgcmV0dXJucyBzdWNjZXNzLCBzbyB0aGUg
Y2FsbGVyIGNhbiBzdGlsbCBleHRlbmQKPiB0aGUgZGVzdGluYXRpb24gaW5vZGUgd2l0aCB1bmNo
ZWNrZWQgcG9zX291dCArIGxlbi4KPgo+IFJlamVjdCBkZXN0aW5hdGlvbiBvdmVyZmxvdyBhbmQg
dXNlIGlub2RlX25ld3NpemVfb2soKSBiZWZvcmUgZXh0ZW5kaW5nCj4gdGhlIGRlc3RpbmF0aW9u
IGlub2RlLgo+Cj4gRml4ZXM6IDRkZDZmOTc3ZmM3NyAoImYyZnM6IHN1cHBvcnQgYW4gaW9jdGwg
dG8gbW92ZSBhIHJhbmdlIG9mIGRhdGEgYmxvY2tzIikKPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcK
PiBBc3Npc3RlZC1ieTogQ29kZXg6Z3B0LTUuNQo+IFNpZ25lZC1vZmYtYnk6IFdlbmppZSBRaSA8
cWl3ZW5qaWVAeGlhb21pLmNvbT4KPiAtLS0KPiAgZnMvZjJmcy9maWxlLmMgfCAxNiArKysrKysr
KysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZmlsZS5jIGIvZnMvZjJmcy9maWxlLmMKPiBp
bmRleCA0YjUyYzU2ZDcxZjAuLjJhNWM2Zjc0MWY1NiAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL2Zp
bGUuYwo+ICsrKyBiL2ZzL2YyZnMvZmlsZS5jCj4gQEAgLTMxMjEsOCArMzEyMSw5IEBAIHN0YXRp
YyBpbnQgZjJmc19tb3ZlX2ZpbGVfcmFuZ2Uoc3RydWN0IGZpbGUgKmZpbGVfaW4sIGxvZmZfdCBw
b3NfaW4sCj4gICAgICAgICBzdHJ1Y3QgaW5vZGUgKmRzdCA9IGZpbGVfaW5vZGUoZmlsZV9vdXQp
Owo+ICAgICAgICAgc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpID0gRjJGU19JX1NCKHNyYyk7Cj4g
ICAgICAgICBzdHJ1Y3QgZjJmc19sb2NrX2NvbnRleHQgbGM7Cj4gLSAgICAgICBzaXplX3Qgb2xl
biA9IGxlbiwgZHN0X21heF9pX3NpemUgPSAwOwo+IC0gICAgICAgc2l6ZV90IGRzdF9vc2l6ZTsK
PiArICAgICAgIHNpemVfdCBvbGVuID0gbGVuOwo+ICsgICAgICAgbG9mZl90IGRzdF9tYXhfaV9z
aXplID0gMDsKPiArICAgICAgIGxvZmZfdCBkc3Rfb3NpemUsIGRzdF9lbmQ7Cj4gICAgICAgICBp
bnQgcmV0Owo+Cj4gICAgICAgICBpZiAoZmlsZV9pbi0+Zl9wYXRoLm1udCAhPSBmaWxlX291dC0+
Zl9wYXRoLm1udCB8fAo+IEBAIC0zMTc5LDggKzMxODAsMTUgQEAgc3RhdGljIGludCBmMmZzX21v
dmVfZmlsZV9yYW5nZShzdHJ1Y3QgZmlsZSAqZmlsZV9pbiwgbG9mZl90IHBvc19pbiwKPiAgICAg
ICAgIH0KPgo+ICAgICAgICAgZHN0X29zaXplID0gZHN0LT5pX3NpemU7Cj4gLSAgICAgICBpZiAo
cG9zX291dCArIG9sZW4gPiBkc3QtPmlfc2l6ZSkKPiAtICAgICAgICAgICAgICAgZHN0X21heF9p
X3NpemUgPSBwb3Nfb3V0ICsgb2xlbjsKPiArICAgICAgIGlmIChvbGVuID4gTExPTkdfTUFYIC0g
cG9zX291dCkKPiArICAgICAgICAgICAgICAgZ290byBvdXRfdW5sb2NrOwo+ICsgICAgICAgZHN0
X2VuZCA9IHBvc19vdXQgKyBvbGVuOwo+ICsgICAgICAgaWYgKGRzdF9lbmQgPiBkc3QtPmlfc2l6
ZSkgewo+ICsgICAgICAgICAgICAgICByZXQgPSBpbm9kZV9uZXdzaXplX29rKGRzdCwgZHN0X2Vu
ZCk7Cj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Z290byBvdXRfdW5sb2NrOwo+ICsgICAgICAgICAgICAgICBkc3RfbWF4X2lfc2l6ZSA9IGRzdF9l
bmQ7Cj4gKyAgICAgICB9Cj4KPiAgICAgICAgIC8qIHZlcmlmeSB0aGUgZW5kIHJlc3VsdCBpcyBi
bG9jayBhbGlnbmVkICovCj4gICAgICAgICBpZiAoIUlTX0FMSUdORUQocG9zX2luLCBGMkZTX0JM
S1NJWkUpIHx8Cj4gLS0KPiAyLjQzLjAKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
