Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C3BC55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G0T8KPJtzwacUGeX3tVgLIVmD81msmusHkAAEY+oGOw=; b=SgKPkf3aUfA+o39PG6ghVVpqKB
	Wj2sVbwjDqSRuSjHOMd7N36DKZ+wxzMz930DzVHXZI2Oz4QRfIDFgQgkxZf448BotVzJY57bYT1he
	3HvYA+s85+kIFZjR3ZnARCfQbY8KU7om3gsg5E1DED7+Uj8MSrHrx/hmnjc1ZpcIlPUo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqp8B-0001Zi-Jr;
	Mon, 03 Aug 2026 09:38:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqp89-0001ZU-LX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:38:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e9v0jq/fzk9IoYVtE/z6InJOvOIDqzq59/pNaORw3Ao=; b=dHCZLW+UYNMFG3X3mzjaPyPfui
 i3gLpWFxsm5tDwJe4SOqLlT+DdluES1vAMCxJrNdy4e5O8FCp+pv6eTelAjvX5LrbMgxldscwNZj/
 5vzgChRfIPNoQvCqS/MHSopClGDPnr0IVEKb1lrjoYSuNyE3UshpCofsysfK6BLJqrPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=e9v0jq/fzk9IoYVtE/z6InJOvOIDqzq59/pNaORw3Ao=; b=SgorQ7IqoCfPNyjASkO++6LFIL
 9p9+CKHCeol0PzqUwGCLHx5WZvclE7PJPCBjCHpTA1eTgUejqrOfRLG82d9xyN/tZLH/1eG+OMT/S
 Gwq2QVrBW3z9KXGTZr2O2d8CXTITMHvwzNzTi/JycGMkBqin9wGipL3aclHgrwel4ns4=;
Received: from mail-lf1-f52.google.com ([209.85.167.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqp8D-0004Bu-Ed for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:38:46 +0000
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5b28c91fba5so3686088e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 02:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785749919; cv=none;
 d=google.com; s=arc-20260327;
 b=ZZvUNv430gSWg66OgLIocimeHM4kivO0vWRaJ7A18MmsbrunDHp1OIt8WsPp7QfVRS
 Ne1Ur45vXoRZpLXvl+M32uubpcdxh4xF8AF5uYYn3R11gy3VLSy9qXMtMToXEpd6iv7h
 EtEsWWkJmOhS0CD5y+BUyMnReiOAxZf3yE9TkLn+R6XqLVuYMUfdPut1nvyZGmflw6Fk
 e/1r4TmPEw7IxJrAYxNy5Ke/xrD9YTbEjPvOcROOjHUBgIZCHJ+L+IQPx5rDvwJB+/0G
 h3Rte2JtcTBLjeDoERhdHdo0Fj/ps15Kq2pIvn4cX2jxodASB4/XsSfBEKYNyIyvfd0w
 4Sdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e9v0jq/fzk9IoYVtE/z6InJOvOIDqzq59/pNaORw3Ao=;
 fh=FGkoCNfgcX71+VVylSI3JVqXmGAc5OGfwUTXNwZjdko=;
 b=XHFE+3bzDhB4Mr+N0jzcWxsYN+6Oag1kr/B0FqpdtJ5ltuc2HWV1Fl+qX3QSTLMQzD
 6+v8CIG5TXUNDwMeSeUVxibJ/hoxS4IHu76/3fWclk/W6umVF/nQ2teevdDmR27IvObs
 1XN628SDvbwSJW3zjjym8ZF/Icp3DG0qw3MdOdBCnpqVep/LmwCFogmOUyl3Vu+8+6YI
 +N96ZwgJFFfxcdC1OtGFuLwF8LwKC+25EOTzRzd+QNkziedl+hey1s8npEvxgczz1oe6
 XyTQQaFwElZhHohhpmAE3dnAD1YcQH6Vr/ClIqZT/SzzudmfJ9L1prW6C4gPVkI4N2m4
 vVQg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785749919; x=1786354719; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e9v0jq/fzk9IoYVtE/z6InJOvOIDqzq59/pNaORw3Ao=;
 b=Qfu1vEXQOnBd4f7JeTZ8vdQdJr4XvYCx0zxD9ih6xxkqT3XBUzE+3W6sXmJWngq8MV
 ipUqAN9MFu+t0i6ILIyr9ArBlP2GcXWcsyjrFcpEeYYx62Q5b/Lp6EsnSqzTaWTxX1sJ
 3mf3FJAg5W4JMHdC7NFhSP1QQQPgqkm6YpcjaWCKc0/2X4yGBLOJc+aKYVpdL2yja57p
 FAV2UasfaIMFUrbuStp0CTJ5taNW4RzUaHJP6hN405tyXuYanSllsgCpUoBat0tZwdcP
 RGSz6Fvz/lFe1dRHw8x8jV/7BalbUWg16DK1fYwaWAQc27NhEabrWg2SsKgeFu5t09Ro
 yT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785749919; x=1786354719;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e9v0jq/fzk9IoYVtE/z6InJOvOIDqzq59/pNaORw3Ao=;
 b=VGijwrCD8z1iJYnoeja00+5KJrh8RfPO2KaXaHj3xM3ykS0+YiKN+qUZliDAFJ2VOS
 9Bsl73RKYv6tiFKFr8hvVfUNL5+7qgVtd8oV9+uYUDo4fMupNsbkcVMogsZDRrSEd2Ei
 qYfFZH4+B1JB4fDDbdr8PFEeKPKLVG6wDDPqh4lE62YmAy7iE/wYeUL5jni6ANSPou6J
 XP/Y3geChbG60J0Dh/jxI/ivu8RGptClSTVnHK/mOY91L1q91qG9E941UIL/rIWh/iIH
 yqPZproG4pgGIzFyNP4rFjcD8MoPwRv5kJdTZWP4n7p1P9Z5/hv/BRgqsJhJuA9QPXSk
 frjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9VJkiLGetszqPR3YFC1SuhAtl7e+sI1Ky19N8CR1H6PHevjavsKun5phvgdprddgrM3mnIr0Gfy6XY8qcsyzI@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyN6i6Hmcrap5MizhWoKwIjarFQjly5YQH260+acFsgxsEOhphM
 negyydrOElkCDQfB2xGzq1IsgKzVPxzwaTI96z1gwn2ATC1MriD/bjBDBAybHkiKwDjuQsOwwZq
 P+hpIHLudGqxuEQVXr9hl8RO7RiP1nI4=
X-Gm-Gg: AR+sD11kMqAC2CDC1r6f17qbr0PijyJryf+w4R5dSjzqRcUkC2eecaUPeyaMY3b8xcN
 rzBDfP+QlYnWh/rukClsT78dwsWplZLJpOSVhiuBjDQATvw+JImolDgmivHwsPgE4ygHIbA4a8/
 nM6Hc7wUFtY90I240p6E7tEq+yPfsAnr3L5YDo/CMu3xIoKu05uc3jIsLSjCmXH4YpDDUnBqSHW
 HfIMhP4t9ZjSZtgEXfupOPkFyX14E71r8y1Wt4fpxZWBs3QBCeONSmRgOdULKN67P79NnSwQoFF
 AILWlkLbTNcV78L2xtLIBmudk3fv+KWAkm/rYdRkNEks2JEFfcE8YiMw
X-Received: by 2002:a05:6512:3e14:b0:5b2:aa73:ea6a with SMTP id
 2adb3069b0e04-5b2e4f0fc6bmr1487825e87.10.1785749919041; Mon, 03 Aug 2026
 02:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260724135026.500859-1-qiwenjie@xiaomi.com>
 <fbd2bbbb-4131-4cc5-ba7d-4e77b7bf8517@kernel.org>
In-Reply-To: <fbd2bbbb-4131-4cc5-ba7d-4e77b7bf8517@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 3 Aug 2026 17:38:27 +0800
X-Gm-Features: AUfX_myXXuCyI0RhvU3WZUKGX5jdT6vde_JbZwGca2TTPbMU8ArHDNU628RABeg
Message-ID: <CAGFpFsTags+QyzP5=_Ox+Q1-uMPouPRP=ctxzWYyV9ABve0iNg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wqp8D-0004Bu-Ed
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid stale FI_COMPRESS_RELEASED on
 release failure
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
Cc: jaegeuk@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICBZZXMsIHRoYXQgaXMgaW50ZW50aW9uYWwuCgogIElmIHJldCA8IDAgYnV0IHJlbGVhc2VkX2Js
b2NrcyA+IDAsIHRoZSBpb2N0bCBoYXMgYWxyZWFkeSByZWxlYXNlZCBzb21lCiAgY29tcHJlc3Nl
ZCByZXNlcnZlZCBibG9ja3MgYW5kIHVwZGF0ZWQgdGhlIGlub2RlL2Jsb2NrIGFjY291bnRpbmcK
ICBwYXJ0aWFsbHkuIEF0IHRoYXQgcG9pbnQgdGhlIGlub2RlIGlzIG5vIGxvbmdlciBpbiB0aGUg
b3JpZ2luYWwKICBwcmUtcmVsZWFzZSBzdGF0ZSwgc28ga2VlcGluZyBGSV9DT01QUkVTU19SRUxF
QVNFRCBpcyBkZWxpYmVyYXRlLgoKICBUaGUgY2FzZSB0aGlzIHBhdGNoIGlzIHRyeWluZyB0byBm
aXggaXMgb25seSByZXQgPCAwICYmCiAgcmVsZWFzZWRfYmxvY2tzID09IDAsIHdoZXJlIG5vIHJl
bGVhc2Utc2lkZSBzdGF0ZSBjaGFuZ2UgaGFwcGVuZWQgYnV0CiAgdGhlIG9sZCBjb2RlIHN0aWxs
IGxlZnQgRklfQ09NUFJFU1NfUkVMRUFTRUQgc2V0LgoKT24gTW9uLCBBdWcgMywgMjAyNiBhdCA0
OjMx4oCvUE0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIDcvMjQvMjYg
MjE6NTAsIFdlbmppZSBRaSB3cm90ZToKPiA+IEYyRlNfSU9DX1JFTEVBU0VfQ09NUFJFU1NfQkxP
Q0tTIHNldHMgRklfQ09NUFJFU1NfUkVMRUFTRUQgYmVmb3JlIHdhbGtpbmcKPiA+IGRhdGEgbm9k
ZXMuIElmIHJlbGVhc2VfY29tcHJlc3NfYmxvY2tzKCkgZmFpbHMgYmVmb3JlIGZyZWVpbmcgYW55
IHJlc2VydmVkCj4gPiBibG9jaywgdGhlIGlub2RlIGtlZXBzIHRoZSBmbGFnIHdoaWxlIGlfY29t
cHJfYmxvY2tzIGlzIHN0aWxsIG5vbi16ZXJvLgo+ID4KPiA+IFRoZW4gRjJGU19JT0NfUkVTRVJW
RV9DT01QUkVTU19CTE9DS1MgcmV0dXJucyBzdWNjZXNzIHdpdGggemVybyByZXNlcnZlZAo+ID4g
YmxvY2tzLCBhbmQgcmVndWxhciB3cml0ZXMga2VlcCBmYWlsaW5nIHdpdGggLUVQRVJNLgo+ID4K
PiA+IFNldCB0aGUgZmxhZyBvbmx5IGFmdGVyIHRoZSBpb2N0bCBzdWNjZWVkcywgb3IgYWZ0ZXIg
aXQgaGFzIGFjdHVhbGx5Cj4gPiByZWxlYXNlZCBzb21lIGJsb2Nrcy4gVGhpcyBwcmVzZXJ2ZXMg
dGhlIGV4aXN0aW5nIHBhcnRpYWwtcmVsZWFzZSBlcnJvcgo+ID4gaGFuZGxpbmcgYW5kIGxlYXZl
cyBhIGZhaWxlZCB6ZXJvLXJlbGVhc2UgYXR0ZW1wdCB1bmNoYW5nZWQuCj4gPgo+ID4gRml4ZXM6
IGVmOGQ1NjNmMTg0ZSAoImYyZnM6IGludHJvZHVjZSBGMkZTX0lPQ19SRUxFQVNFX0NPTVBSRVNT
X0JMT0NLUyIpCj4gPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6IFdl
bmppZSBRaSA8cWl3ZW5qaWVAeGlhb21pLmNvbT4KPiA+IC0tLQo+ID4gUUVNVSBmYXVsdC1pbmpl
Y3Rpb24gdGVzdCB3aXRoIEZBVUxUX0JMS0FERFJfVkFMSURJVFk6Cj4gPiAtIGJlZm9yZTogcmVs
ZWFzZSBmYWlsZWQgd2l0aCAtRUZTQ09SUlVQVEVELCByZXNlcnZlIHJldHVybmVkIDAgYmxvY2tz
LAo+ID4gICAgYW5kIHB3cml0ZSBrZXB0IGZhaWxpbmcgd2l0aCAtRVBFUk0gYWZ0ZXIgcmVtb3Vu
dC4KPiA+IC0gYWZ0ZXI6IHJlbGVhc2Ugc3RpbGwgZmFpbGVkLCByZXNlcnZlIHJldHVybmVkIC1F
SU5WQUwsIGFuZCBwd3JpdGUgc3VjY2VlZGVkLgo+ID4gLSBub3JtYWwgcmVsZWFzZS9yZXNlcnZl
IHN0aWxsIHJlbGVhc2VkIGFuZCByZXNlcnZlZCAxOTIgYmxvY2tzLgo+ID4KPiA+ICAgZnMvZjJm
cy9maWxlLmMgfCAxMCArKysrKystLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZmlsZS5j
IGIvZnMvZjJmcy9maWxlLmMKPiA+IGluZGV4IGM1NDg5N2EyNTk4MS4uZGNhMTcyMmY5MmIzIDEw
MDY0NAo+ID4gLS0tIGEvZnMvZjJmcy9maWxlLmMKPiA+ICsrKyBiL2ZzL2YyZnMvZmlsZS5jCj4g
PiBAQCAtMzkxNiwxMCArMzkxNiw2IEBAIHN0YXRpYyBpbnQgZjJmc19yZWxlYXNlX2NvbXByZXNz
X2Jsb2NrcyhzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQgbG9uZyBhcmcpCj4gPiAgICAgICAg
ICAgICAgIGdvdG8gb3V0Owo+ID4gICAgICAgfQo+ID4KPiA+IC0gICAgIHNldF9pbm9kZV9mbGFn
KGlub2RlLCBGSV9DT01QUkVTU19SRUxFQVNFRCk7Cj4gPiAtICAgICBpbm9kZV9zZXRfY3RpbWVf
Y3VycmVudChpbm9kZSk7Cj4gPiAtICAgICBmMmZzX21hcmtfaW5vZGVfZGlydHlfc3luYyhpbm9k
ZSwgdHJ1ZSk7Cj4gPiAtCj4gPiAgICAgICBmMmZzX2Rvd25fd3JpdGUoJmZpLT5pX2djX3J3c2Vt
W1dSSVRFXSk7Cj4gPiAgICAgICBmaWxlbWFwX2ludmFsaWRhdGVfbG9jayhpbm9kZS0+aV9tYXBw
aW5nKTsKPiA+Cj4gPiBAQCAtMzk2Myw2ICszOTU5LDEyIEBAIHN0YXRpYyBpbnQgZjJmc19yZWxl
YXNlX2NvbXByZXNzX2Jsb2NrcyhzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQgbG9uZyBhcmcp
Cj4gPgo+ID4gICAgICAgZmlsZW1hcF9pbnZhbGlkYXRlX3VubG9jayhpbm9kZS0+aV9tYXBwaW5n
KTsKPiA+ICAgICAgIGYyZnNfdXBfd3JpdGUoJmZpLT5pX2djX3J3c2VtW1dSSVRFXSk7Cj4gPiAr
Cj4gPiArICAgICBpZiAocmV0ID49IDAgfHwgcmVsZWFzZWRfYmxvY2tzKSB7Cj4KPiBXZSB3aWxs
IHNldCBGSV9DT01QUkVTU19SRUxFQVNFRCBpZiByZXQgPCAwIGFuZCByZWxlYXNlZF9ibG9ja3Mg
PiAwPwo+Cj4gVGhhbmtzLAo+Cj4gPiArICAgICAgICAgICAgIHNldF9pbm9kZV9mbGFnKGlub2Rl
LCBGSV9DT01QUkVTU19SRUxFQVNFRCk7Cj4gPiArICAgICAgICAgICAgIGlub2RlX3NldF9jdGlt
ZV9jdXJyZW50KGlub2RlKTsKPiA+ICsgICAgICAgICAgICAgZjJmc19tYXJrX2lub2RlX2RpcnR5
X3N5bmMoaW5vZGUsIHRydWUpOwo+ID4gKyAgICAgfQo+ID4gICBvdXQ6Cj4gPiAgICAgICBpZiAo
cmVsZWFzZWRfYmxvY2tzKQo+ID4gICAgICAgICAgICAgICBmMmZzX3VwZGF0ZV90aW1lKHNiaSwg
UkVRX1RJTUUpOwo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbAo=
