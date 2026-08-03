Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4897C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o6gU6oK7dcvmBXJoYoOiiPJx7254L4pePO56f682guk=; b=XO6+2Sr6KpR28+njbUPA49m/k4
	FVGxzw5G76psfC2IlYBgOzaE8UuTZJCH+KA7tzXCqeq9DkxNSMMkwJylgmC4ZtTy8eS+IQUjEd1Xs
	Ti5q13RwOvy7j8hvgTpEgeOF7JznzmsjD3D6ltjqJG3lwTi2sFUK9S8KEkHG3rRz+dVY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqnAL-0006YB-H2;
	Mon, 03 Aug 2026 07:32:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqnA4-0006Xv-PQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C20qL4DLsVfxTSyFxCMT9Fnd7JJlndIgylziskpd6FA=; b=WlH4I6S/4gyawtqkGr0SDZMb8N
 ei0FwQVrSKuWWbODi0KLrk/LNk1TSLEZFX9XQ8BuM96dwuGlb2Zw0iviQ+9xLWAPLhoDekEBguKH0
 UQDCxRZoGJx5Rckn/ahJ87zAfuoXAO0iEqQ98O5iCcUv2Fu5ZwajjUHeATwsPBVGrAdw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C20qL4DLsVfxTSyFxCMT9Fnd7JJlndIgylziskpd6FA=; b=dnbonRDq5/y6uF2Nui5Y0k7HG3
 x8cYkEyvRymvPfBTdaHtoC50fnlmHUgTw54ZFJvBdM5ghV9Bg7m7N0PBOmPJqwsFJAbJRMCBuTDdS
 MxisInY0K2eyWE6P9UufHQJ7hnxFY/uodCwes9A19MbeuoVy1VjhDT9h95uN9djiuXac=;
Received: from mail-lf1-f44.google.com ([209.85.167.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqnA4-0006sx-Rj for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:32:34 +0000
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5b0117d49dcso3384660e87.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 00:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785742346; cv=none;
 d=google.com; s=arc-20260327;
 b=pHDugWFjuZx59UGD4LRIr9QS8RIH9bNjcGYNHHGBKWWTgOspbQvqiAIR9JC+hS0ikV
 t5O0BGv/2h+W44b7y6+JqaFjud9ELBwqEW7MaO4OHO0i+rGMDVs1TCgp+YZITIVuA1cL
 7dpDvaxLBlRyu4mPMFGfBhFl+g4tL9hW+kzQjNTMeWKd4dngfYycY8rLy9QCbTbGPB6h
 w/39UCMIi2BZjx4muG8vNqONYxhvzEDcWNNk8u2rojbPcW5jlfc1nkvmtqugyg5Ht9ih
 KYW9UDrIEEldPTqgOu4Z2IJysiU2tQDIbfXr6k0VxzCw24l3HtA+x78INzYDRJkgAw04
 39Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C20qL4DLsVfxTSyFxCMT9Fnd7JJlndIgylziskpd6FA=;
 fh=xY+gKnnvo1Eg+dei6lkKV0/HZYzCrjKMM2edzfH4sU8=;
 b=qM5dTItsA61iCSzUPtHLGGFzpx+wStDpRiQ80MUb2GG/2rq3Oeu5RNGSOUyCdvKNIl
 /jqoU4HqXFdWgO2n54w9Uku/IwkPQgMEEmErG8hH+008p+VgKbAZyzkCM18pkzRxAGkH
 s3LywakR2bsQNMA50ywlKlCtOsmRCIWpjXtpGmF7vwtdpVKj9ZPf2fD+4XT30jaQgu1n
 OkevbnrsFkdfTKsqAujoPY7jfD9TLU1sHwZqnv3vEIbmQV59jY52JGrBltEdkQqpV/3r
 Hfq4ho0dqwfNEc3/hZZhRhl1o00oG0igti6Ee2mhriy/JYxfj6W8WehiZTVeWPbAUVS/
 5SYA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785742346; x=1786347146; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C20qL4DLsVfxTSyFxCMT9Fnd7JJlndIgylziskpd6FA=;
 b=l6ZeXBN8L2p1A2yZQIJ/4G9tH0jstteFIGBsyI3Hp8/ViLb062YSZABqwwvxHhZQQ+
 WN40RLPgf31rFilcXalhYCo/FeLKl0AAU9RmNcZzgssE7oRZ8ugwInz9s56VkmP/4Mt8
 NhO9Ags4sS5Mwn/gaiNvamtZ23isvFANyf0ib4ZSPev+evs+17H8Oxt5LpUfQGOxQFdH
 QRZXAecOXZUNz/kpMwYbiu7C6vaTQa86wBi8roGTv92vk94cvNVLN5wcwqdyRILP3khn
 IG25tTyIr999QXpK4LiX2y3BIWAOek2flNCEpy6t45DNYhIpR0V5AS1P39gkQOge/Ufj
 GI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785742346; x=1786347146;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C20qL4DLsVfxTSyFxCMT9Fnd7JJlndIgylziskpd6FA=;
 b=kGwlzGOU7FcvXHtRnxAMgpvJER6bT1ngKjydCrP+EI2MlEj1MNhFU0DaOFMpSgnXap
 IpmrjfM2kuG2a4B5EL7qdHzOfsqGDGyGI07Ewrw6fu3jCEOUcwnax66MIXdvj6mZp7bL
 R/L2xk4PhntpKCKo0cm3MFDoYHGAoPlOS7Zl2NWtkm5xxXSFrP/J0Nc1wG3Dott1ZhHX
 sT0fUtDy6asRiPs0R+0EnCdRvFvwHrv/IJkRHQ5LaF7eLn0JcJTB8ZPSmRKPQX8P7E8s
 wxe4LOs59nnJWWi7ZN8BrVo2uKVzNCSJaDsBuHItI7hauv8ruLDpL9Meg5YM6MZTVu8j
 yTug==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUNLa/VFwqqH2zIU30rJz00Bb3v38t+BUtduFc4QbO8noG6ebKecg5tOanVBgJhV9g+JCydY7n6IsRsxYa+eqS@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzl7iHI9Mtk+nsDIG6wzmNK/1yHkEggd21agmGB6KPGHJqVdwki
 rE1oyVQjdLysipcKSjiWgco/chH4EEy47fa/UkCy+FXZfuCkfXiG6D9QOynaakorUnM9wYyFatQ
 sdBUpTPHtB/MVvGEOxqlnJBJcEIn4fNA=
X-Gm-Gg: AR+sD11VW0lLXVAon48zlFR5pjrFduy9xrYwDlQHTZc7bPA9eCEMrHfYDI5R19oSORT
 +FL/ODlLMAvz7ISxgSCFzJkwM6JkfLhG+PfKccexkWJQqW3E0WwbBhciEwzgqqGcuX82T0yBGjT
 g+he5z3pMx6h+Wm86NijHIGx5YkmGvs5rUKuOJIBZz/OjfVKQ3LyOPzAz/9fqYz6JIRhTlcn6NY
 byeRLxF88ZFtjW4Oun97Jzhncr5FSw6zqBYvjCj9VTM2qGcZQT3LBEzEaYdxszaXgLwprjnlb3s
 lmOw+z0T64cnBX5FVFx9AnI6lWjn216rN2je2kNzur9ta/0=
X-Received: by 2002:a05:6512:6883:10b0:5ae:d80f:c77c with SMTP id
 2adb3069b0e04-5b2e4f6d4f2mr908220e87.30.1785742346119; Mon, 03 Aug 2026
 00:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260616125219.1396871-1-qiwenjie@xiaomi.com>
 <4549a2d6-f512-4f34-a6bd-5e7324f037ad@kernel.org>
In-Reply-To: <4549a2d6-f512-4f34-a6bd-5e7324f037ad@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 3 Aug 2026 15:32:14 +0800
X-Gm-Features: AUfX_mwTDFETsWM5fvh-6LLzX3t2eVmgJomPOedBxLtd0cn2Y_Ap1Bmpuw0hInI
Message-ID: <CAGFpFsRNcyP3JPY=Zhdgdk-o7HKuU0_+UuqbQfyfsqWtExOOXA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wqnA4-0006sx-Rj
Subject: Re: [f2fs-dev] [PATCH] f2fs: account compressed writeback by raw
 folio type
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
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICBJIHJlY2hlY2tlZCB0aGUgZWFybGllciBkaXNjdXNzaW9uIGFuZCB0aGUgY3VycmVudCBjb2Rl
LgogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWYyZnMtZGV2ZWwvQ0FHRnBGc1JRbXZx
VFk9Vzlfb2ZGOTNoelFBaTdyRjl0UzN6VWlMV2l4ZlNpWWQ0V0J3QG1haWwuZ21haWwuY29tL1Qv
I3UKCiAgSSBzZWUgdGhlIGlzc3VlIG5vdy4gSSBoYWQgYmVlbiB0cmVhdGluZyB0aGlzIGFzIGEK
d3JpdGViYWNrLWFjY291bnRpbmcgcHJvYmxlbSBhbmQgYXNzdW1lZAogIHRoZSB0eXBlIHNob3Vs
ZCBmb2xsb3cgdGhlIHJhdyBmb2xpby4gWW91ciBleHBsYW5hdGlvbiBtYWtlcyBpdApjbGVhcgog
IHRoYXQgdGhlIGN1cnJlbnQgRjJGU19XQl9DUF9EQVRBIGNsYXNzaWZpY2F0aW9uIGZvciBjb21w
cmVzc2VkCndyaXRlYmFjawogIHdhcyBpbnRlbnRpb25hbCwgc28gdGhhdCBmc3luYy9zeW5jIGtl
ZXBzIHRoZSBjb21wcmVzc2VkIGNsdXN0ZXIKdW5kZXIKICB0aGUgY2hlY2twb2ludC1ndWFyYW50
ZWVkIHBhdGggZm9yIFBPUiBzYWZldHkuCgogIFdpdGggdGhhdCBpbiBtaW5kLCB0aGUgcmVhc29u
aW5nIGZvciBteSBwYXRjaCBpcyBub3Qgc291bmQsIHNpbmNlIEkKZGlkCiAgbm90IHNob3cgdGhh
dCB0aGUgc2FtZSBndWFyYW50ZWUgaXMgcHJlc2VydmVkIGFmdGVyIGNoYW5naW5nIHRoZQp0eXBl
LgoKICBQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guCgpPbiBNb24sIEF1ZyAzLCAyMDI2IGF0IDEw
OjMz4oCvQU0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIDYvMTYvMjYg
MjA6NTIsIFdlbmppZSBRaSB3cm90ZToKPiA+IENvbXByZXNzZWQgd3JpdGViYWNrIGlzIGFsd2F5
cyBjaGFyZ2VkIGFzIEYyRlNfV0JfQ1BfREFUQSB0b2RheSBiZWNhdXNlCj4gPiBXQl9EQVRBX1RZ
UEUoKSBpcyBjYWxsZWQgd2l0aCBjb21wcmVzc2VkX3BhZ2Ugc2V0LiAgVGhhdCBpcyB3cm9uZyBm
b3IKPiA+IG5vcm1hbCBjb21wcmVzc2VkIGZpbGUgd3JpdGViYWNrOyB0aGUgQ1AgZ3VhcmFudGVl
IGJlbG9uZ3MgdG8gdGhlIHJhdwo+ID4gcGFnZWNhY2hlIGZvbGlvLCBub3QgdGhlIGNvbXByZXNz
ZWQgYm91bmNlIHBhZ2UuCj4KPiBJSVVDLCBJIGNoYW5nZWQgY29tcHJlc3NlZCB3cml0ZWJhY2sg
Z3VhcmFudGVlZCBieSBjaGVja3BvaW50IHRvIGF2b2lkCj4gY29tcHJlc3NlZCBjbHVzdGVyIGNv
cnJ1cHRpb24gd2hlbiBlbmNvdW50ZXJpbmcgcG93ZXIgb2ZmIHJlY292ZXJ5IGFmdGVyCj4gZnN5
bmMvc3luYy4KPgo+IEkgZGlkbid0IGdldCB3aHkgaXQncyB3cm9uZyB0byBzZXQgRjJGU19XQl9D
UF9EQVRBIGZvciBjb21wcmVzc2VkIHBhZ2UsCj4gY2FuIHlvdSBwbGVhc2UgZXhwbGFpbiBtb3Jl
Pwo+Cj4gVGhhbmtzLAo+Cj4gPgo+ID4gVXNlIHRoZSByYXcgZm9saW8gZm9yIHRoZSB3cml0ZWJh
Y2sgY291bnQgdHlwZS4gIEFsc28ga2VlcCBvbmUgcmF3IHBhZ2UKPiA+IHVuZGVyIHdyaXRlYmFj
ayB1bnRpbCB0aGUgY29tcHJlc3NlZCBlbmRfaW8gY2FsbGJhY2sgaXMgZG9uZSB1c2luZyBzYmks
Cj4gPiBhcyBub3JtYWwgY29tcHJlc3NlZCB3cml0ZWJhY2sgaXMgbm8gbG9uZ2VyIHByb3RlY3Rl
ZCBieSB0aGUgQ1AtZGF0YQo+ID4gY291bnRlci4KPiAgPiA+IFNpZ25lZC1vZmYtYnk6IFdlbmpp
ZSBRaSA8cWl3ZW5qaWVAeGlhb21pLmNvbT4KPiA+IC0tLQo+ID4gUUVNVS9LQVNBTiB0ZXN0ZWQg
d2l0aCBjb21wcmVzc19tb2RlPWZzIGFuZCBjb21wcmVzc19tb2RlPXVzZXIsIHVzaW5nCj4gPiBj
b25jdXJyZW50IDFNaUIgY29tcHJlc3NlZCB3cml0ZXMgYW5kIGEgYmFja2dyb3VuZCBzeW5jIGxv
b3AuICBUaGUgdXNlcgo+ID4gbW9kZSBjYXNlIGFsc28gcmFuIEYyRlNfSU9DX0NPTVBSRVNTX0ZJ
TEUgYW5kIGZzeW5jLiAgTm8gZG1lc2cgc3BsYXQgd2FzCj4gPiByZXBvcnRlZCBhbmQgZnNjay5m
MmZzIHBhc3NlZCBhZnRlciB1bm1vdW50Lgo+ID4KPiA+ICAgZnMvZjJmcy9jb21wcmVzcy5jIHwg
MzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ID4gICBmcy9mMmZzL2RhdGEu
YyAgICAgfCAgMiArLQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvY29tcHJlc3MuYyBiL2Zz
L2YyZnMvY29tcHJlc3MuYwo+ID4gaW5kZXggOTE4NTVkOTFiYmRkLi5iZTk0ODNiOWE0MDEgMTAw
NjQ0Cj4gPiAtLS0gYS9mcy9mMmZzL2NvbXByZXNzLmMKPiA+ICsrKyBiL2ZzL2YyZnMvY29tcHJl
c3MuYwo+ID4gQEAgLTE0ODcsOSArMTQ4NywxOSBAQCB2b2lkIGYyZnNfY29tcHJlc3Nfd3JpdGVf
ZW5kX2lvKHN0cnVjdCBiaW8gKmJpbywgc3RydWN0IGZvbGlvICpmb2xpbykKPiA+ICAgICAgIHN0
cnVjdCBwYWdlICpwYWdlID0gJmZvbGlvLT5wYWdlOwo+ID4gICAgICAgc3RydWN0IGYyZnNfc2Jf
aW5mbyAqc2JpID0gYmlvLT5iaV9wcml2YXRlOwo+ID4gICAgICAgc3RydWN0IGNvbXByZXNzX2lv
X2N0eCAqY2ljID0gZm9saW8tPnByaXZhdGU7Cj4gPiAtICAgICBlbnVtIGNvdW50X3R5cGUgdHlw
ZSA9IFdCX0RBVEFfVFlQRShmb2xpbywgdHJ1ZSk7Cj4gPiArICAgICB1bnNpZ25lZCBpbnQgb2Zm
c2V0ID0gZm9saW8tPmluZGV4ICYgKGNpYy0+bnJfcnBhZ2VzIC0gMSk7Cj4gPiArICAgICBzdHJ1
Y3QgcGFnZSAqbGFzdF9wYWdlID0gTlVMTDsKPiA+ICsgICAgIGVudW0gY291bnRfdHlwZSB0eXBl
Owo+ID4gICAgICAgaW50IGk7Cj4gPgo+ID4gKyAgICAgaWYgKHVubGlrZWx5KCFvZmZzZXQgfHwg
b2Zmc2V0ID49IGNpYy0+bnJfcnBhZ2VzIHx8Cj4gPiArICAgICAgICAgICAgICAgICAgIWNpYy0+
cnBhZ2VzW29mZnNldF0pKSB7Cj4gPiArICAgICAgICAgICAgIGYyZnNfYnVnX29uKHNiaSwgMSk7
Cj4gPiArICAgICAgICAgICAgIHR5cGUgPSBGMkZTX1dCX0NQX0RBVEE7Cj4gPiArICAgICB9IGVs
c2Ugewo+ID4gKyAgICAgICAgICAgICB0eXBlID0gV0JfREFUQV9UWVBFKHBhZ2VfZm9saW8oY2lj
LT5ycGFnZXNbb2Zmc2V0XSksIGZhbHNlKTsKPiA+ICsgICAgIH0KPiA+ICsKPiA+ICAgICAgIGlm
ICh1bmxpa2VseShiaW8tPmJpX3N0YXR1cyAhPSBCTEtfU1RTX09LKSkKPiA+ICAgICAgICAgICAg
ICAgbWFwcGluZ19zZXRfZXJyb3IoY2ljLT5pbm9kZS0+aV9tYXBwaW5nLCAtRUlPKTsKPiA+Cj4g
PiBAQCAtMTUwMSwyMSArMTUxMSwzMSBAQCB2b2lkIGYyZnNfY29tcHJlc3Nfd3JpdGVfZW5kX2lv
KHN0cnVjdCBiaW8gKmJpbywgc3RydWN0IGZvbGlvICpmb2xpbykKPiA+ICAgICAgIH0KPiA+Cj4g
PiAgICAgICBmb3IgKGkgPSAwOyBpIDwgY2ljLT5ucl9ycGFnZXM7IGkrKykgewo+ID4gLSAgICAg
ICAgICAgICBXQVJOX09OKCFjaWMtPnJwYWdlc1tpXSk7Cj4gPiArICAgICAgICAgICAgIGlmIChX
QVJOX09OKCFjaWMtPnJwYWdlc1tpXSkpCj4gPiArICAgICAgICAgICAgICAgICAgICAgY29udGlu
dWU7Cj4gPiArICAgICAgICAgICAgIGxhc3RfcGFnZSA9IGNpYy0+cnBhZ2VzW2ldOwo+ID4gKyAg
ICAgfQo+ID4gKwo+ID4gKyAgICAgZm9yIChpID0gMDsgaSA8IGNpYy0+bnJfcnBhZ2VzOyBpKysp
IHsKPiA+ICsgICAgICAgICAgICAgaWYgKCFjaWMtPnJwYWdlc1tpXSkKPiA+ICsgICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsKPiA+ICAgICAgICAgICAgICAgY2xlYXJfcGFnZV9wcml2YXRl
X2djaW5nKGNpYy0+cnBhZ2VzW2ldKTsKPiA+IC0gICAgICAgICAgICAgZW5kX3BhZ2Vfd3JpdGVi
YWNrKGNpYy0+cnBhZ2VzW2ldKTsKPiA+ICsKPiA+ICsgICAgICAgICAgICAgaWYgKGNpYy0+cnBh
Z2VzW2ldICE9IGxhc3RfcGFnZSkKPiA+ICsgICAgICAgICAgICAgICAgICAgICBlbmRfcGFnZV93
cml0ZWJhY2soY2ljLT5ycGFnZXNbaV0pOwo+ID4gICAgICAgfQo+ID4KPiA+ICAgICAgIHBhZ2Vf
YXJyYXlfZnJlZShzYmksIGNpYy0+cnBhZ2VzLCBjaWMtPm5yX3JwYWdlcyk7Cj4gPiAgICAgICBr
bWVtX2NhY2hlX2ZyZWUoY2ljX2VudHJ5X3NsYWIsIGNpYyk7Cj4gPgo+ID4gICAgICAgLyoKPiA+
IC0gICAgICAqIE1ha2Ugc3VyZSBkZWNfcGFnZV9jb3VudCgpIGlzIHRoZSBsYXN0IGFjY2VzcyB0
byBzYmkuCj4gPiAtICAgICAgKiBPbmNlIGl0IGRyb3BzIHRoZSBGMkZTX1dCX0NQX0RBVEEgY291
bnRlciB0byB6ZXJvLCB0aGUKPiA+IC0gICAgICAqIHVubW91bnQgdGhyZWFkIGNhbiBwcm9jZWVk
IHRvIGRlc3Ryb3kgc2JpIGFuZAo+ID4gLSAgICAgICogc2JpLT5wYWdlX2FycmF5X3NsYWIuCj4g
PiArICAgICAgKiBLZWVwIGFsbCBzYmkgYWNjZXNzZXMgYmVmb3JlIHRoZSBsYXN0IHJhdyBwYWdl
IHdyaXRlYmFjayBpcwo+ID4gKyAgICAgICogcmVsZWFzZWQsIHNvIGFuIHVubW91bnQgdGhyZWFk
IGNhbm5vdCBmcmVlIHNiaSB3aGlsZSB0aGlzIGNhbGxiYWNrCj4gPiArICAgICAgKiBpcyBzdGls
bCB1c2luZyBpdC4KPiA+ICAgICAgICAqLwo+ID4gICAgICAgZGVjX3BhZ2VfY291bnQoc2JpLCB0
eXBlKTsKPiA+ICsgICAgIGlmIChsYXN0X3BhZ2UpCj4gPiArICAgICAgICAgICAgIGVuZF9wYWdl
X3dyaXRlYmFjayhsYXN0X3BhZ2UpOwo+ID4gICB9Cj4gPgo+ID4gICBzdGF0aWMgaW50IGYyZnNf
d3JpdGVfcmF3X3BhZ2VzKHN0cnVjdCBjb21wcmVzc19jdHggKmNjLAo+ID4gZGlmZiAtLWdpdCBh
L2ZzL2YyZnMvZGF0YS5jIGIvZnMvZjJmcy9kYXRhLmMKPiA+IGluZGV4IGE3NjVmZGE3MTUzNi4u
MTQ2NmE3ODI1ZGM1IDEwMDY0NAo+ID4gLS0tIGEvZnMvZjJmcy9kYXRhLmMKPiA+ICsrKyBiL2Zz
L2YyZnMvZGF0YS5jCj4gPiBAQCAtMTA5Miw3ICsxMDkyLDcgQEAgdm9pZCBmMmZzX3N1Ym1pdF9w
YWdlX3dyaXRlKHN0cnVjdCBmMmZzX2lvX2luZm8gKmZpbykKPiA+ICAgICAgIC8qIHNldCBzdWJt
aXR0ZWQgPSB0cnVlIGFzIGEgcmV0dXJuIHZhbHVlICovCj4gPiAgICAgICBmaW8tPnN1Ym1pdHRl
ZCA9IDE7Cj4gPgo+ID4gLSAgICAgdHlwZSA9IFdCX0RBVEFfVFlQRShiaW9fZm9saW8sIGZpby0+
Y29tcHJlc3NlZF9wYWdlKTsKPiA+ICsgICAgIHR5cGUgPSBXQl9EQVRBX1RZUEUoZmlvLT5jb21w
cmVzc2VkX3BhZ2UgPyBmaW8tPmZvbGlvIDogYmlvX2ZvbGlvLCBmYWxzZSk7Cj4gPiAgICAgICBp
bmNfcGFnZV9jb3VudChzYmksIHR5cGUpOwo+ID4KPiA+ICAgICAgIGlmIChpby0+YmlvICYmCj4g
Pgo+ID4gYmFzZS1jb21taXQ6IDdjYzQ4ZWFkMWE4YTk2ZjJkZDFlYWJkODdjMmYyMjk0N2RjODRj
ZGYKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwK
