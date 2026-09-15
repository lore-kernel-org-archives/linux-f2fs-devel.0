Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87364C88E7F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UgcmvFfUm/FasRQBaaWVY3kyz9hoZ+ZBJgmiX8W9Lcg=; b=Uh5xHII8QAUkffLwGIfWrqEUU/
	3TYb1wJvd9fdehc55smk4+A2RjGwf0SOlctorgBI80Cz/0FeowJWr8gvwFBD83tO7r8trseXJwfhl
	xThJ3fHGW9mLeU8pAfZX29w+JuLDHGbxgmoviILPgS5F46/yRLcu0bXGX8GyxhehzVko=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6VDS-0008Dt-Oj;
	Tue, 15 Sep 2026 15:37:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x6VD7-0008DN-AF
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:36:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hbB5L8Lp9EfrIDSM7Uq03DCbDzCLZY/DNma/JmHtbNw=; b=UWDWF+XL7XcZJxey79kCPeZyEe
 po8rCNt4VYBMESKdldawZ76KpVnBQLVxvGbwP9GWHjzXIP35aH0h+0b56EBq6EEwJL0efJ4OCKHv1
 tmR3Fiue+08UmJR6/RNF1ZAoV47TMwFxnvTb/LJ2zS1Q1aRnAqEI3blYurefQcPP+Ems=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hbB5L8Lp9EfrIDSM7Uq03DCbDzCLZY/DNma/JmHtbNw=; b=QnsRjZO9Vc/pfQjQzFe+k96UdN
 E0K+5AXbe+lT3C6BtaC8r7qL8Zgo6KXzHiwchUDEObNwnBwvrk5MDIfIOEqtSbjHiy+bit93w9Bix
 mh6shyHX9P0UbamBlI9h1+09bkQEPgh6HTjm0XBxmEj2IaZ5JmJOmybhiM3vZwrllBlA=;
Received: from mail-lr2-f12.google.com ([74.125.230.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6VD6-0007YJ-LV for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:36:41 +0000
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a5d4688decso4736201fa.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 08:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789486594; cv=none;
 d=google.com; s=arc-20260327;
 b=kmtV15BURGHsznKD0QW0TeaO7tmufaOKGpHstlsYbEBjh7A6k/MSP6o6p3wVmJF5st
 xhH5+rwoGM7J89AnWcwinSaGYTk6doHchLuF/1Jtdsna9ngsqcpmA5TwyZx/9YY1NbLb
 1azItPO+7a0n4yx/QLpHh87VkO6qO9FaKe1SLZgvjfn0p55LGL7KdTut9zxf12OZvtzj
 IW9MMUrvQcPJdWwhR+8ZuhWgQv5s2zLjvMsWlDCRDoltsbb4MMBiQV94LrutT9C6yt+o
 gZXdrDWSJhLn2IZqICThNkNIhTEekiejAzYJ2sCXNO63FcgkswimfHzybcOTcBzrib4T
 851g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hbB5L8Lp9EfrIDSM7Uq03DCbDzCLZY/DNma/JmHtbNw=;
 fh=dzXMpoe/CQMcjF6OSNabyWJLOJZ/nbvqprQ408er4zM=;
 b=M7nHj1uV0dJbeFWZd9A3pAUUCp3QceuTayc62DE+CRWlLqmuqEE5SUA9NJzGkvHUPr
 1cMcNlGJZNBcpmXd9H/1XS/f9YAd+qiYnZWbu08NxNsaHsE5Je6pLFYwi7iJ1jcEdRdU
 abGa9pylhkNkSv1aUtFoIXSpUwxPpfZwjfx6Waz+zhqvUJ+R6K9zbEprM+qluJ+lX0Uu
 +0HDCOn7HShMxCz5GGnNjzSFjcqfc74uyxC465fN5CC/DqfmoP6axb6ApDWfKw4UGwwR
 Hlk5e5C0SH9sAU03H2bpohh+dIGuu77sDq9MHQGXRp/jVhaKKbuTBnarC9FM1HcQGPym
 Cotw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789486594; x=1790091394; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hbB5L8Lp9EfrIDSM7Uq03DCbDzCLZY/DNma/JmHtbNw=;
 b=rK6WnsApB6YUPRdwpt2H8jxUIdw8ZiwgmnY/TW9kVWv3vaX58gjl1gQCeprz3bjtse
 0BgOy4rtxkeVVjyrFn+XH7dVowgBYjyKGXYmZfxyfU33U5bbunuJvC/hSTlbFYIbJkro
 K0wm/utUjqalOOERgIDosqzKPyi0TK5qTuTbpbqrLoNEBsNeS7HQTUY/Faf+/qkBZdxG
 qIAMZL9G0FoT+OYW1Kqzaa29VBSdxOFJTT197D7C0WDwQo2q87dQsE9jRjz5BQxO9tiX
 yR005WmjeWA0+aKDAB1cxY10SRWhZmVZBx8cT85TuIvlQ76tt3xpLI0DCZAl52Vc2561
 JbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789486594; x=1790091394;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hbB5L8Lp9EfrIDSM7Uq03DCbDzCLZY/DNma/JmHtbNw=;
 b=Yn7tFW+HZr7QXqywXDUmL4pJIfyA7CcpoE0QvelbgEA5wRje3VGdcgIlskYoN0182x
 U3ERBzhnET3ktBfhfSJVi1NZ2ECpSutT7qpY47sVQkFwHvTurY3hlAu6LXf7+YhpMcm9
 1zQVBirqj7etCMzYsYwf60p/gu0m8PsetgPW8ZiMl0tt950TIMcuY7kdN92JpkFJiyjw
 ILBWa6R946CTw2/2r3D2difOWmf6FIaEobUZ2NDKj9Wa1VfScOpbpmD8AdF+oza1G4aR
 xFpx+pOqEn5UQjN+aA62uiX0/GxuJEaqDHuqhnyzHVtd3CWnifH779qPah5fByo6ZE6q
 YrVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwReOtRf0Ne99LIv0GzebqoqtaYRa6TgqhywhcDXR4gjlDNRM82AsuqnTcimx2GK+oibqlp71LiywDQLwO4jQAO@lists.sourceforge.net
X-Gm-Message-State: AFuF++mf88acv5Q0A2wNBZT/OVEqvzu8PNK6np5qFpMFiTkMKoxgasZF
 VUplC9ZdtbMxvVxXznxUck4FniMN1AWYFagjVt54t03iGklnT8GCJdCH1jsga4NrSXeZSz5U86+
 cTGUFBLxAtYI4bPWJ5xmZc8z372mkb7XcxWAm
X-Gm-Gg: AYBFou1vjXFos6vkOz7AIUdXdrFE/God28Cxo9bv6nONYrfCspNu1Zdn3pIKX13jd2d
 YrUY8/X+Zn3hD7LOTmXSwrLxZZmdQ9LR/TZfS2dUJhLvsR+JyZpbuQhGofM8486/YYZyxtuYL1q
 xW7SH9LtgkSmeeuuHDv5bKBwhFVUL0EaBGqnUXGAoTKW5CatAUzXMF4XPsRPGLQJEdxURPJoYh8
 ZmotHJKRURkOJtZqaSwugxW5VfVG3QRt+8NocDu+kM8nanE3JqiaGJVmjRUjTJb8xAdu/noOcBB
 6vKldfrpRsb2otrJSnSb+UPnb/3EVM6PxqcZInf96qAjawCm+KNVoYXWRfd0Ums3ehYOJqGW/VB
 hyocs+pR+5flQV0BK+gdmOUXmfCIFhisIqh+K7yDD6Q==
X-Received: by 2002:a05:6512:61a3:b0:5b4:c00d:23f3 with SMTP id
 2adb3069b0e04-5b8b4fa2f03mr507339e87.14.1789486593518; Tue, 15 Sep 2026
 08:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_wRYcgKhDe_KfEQUoYWrFOe2cm-ux92ZdiL=-SzH3FXeg@mail.gmail.com>
 <20260915062800.1089775-1-ke.li11@transsion.com>
In-Reply-To: <20260915062800.1089775-1-ke.li11@transsion.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 15 Sep 2026 08:36:21 -0700
X-Gm-Features: AcwNN1X0_Ec2zkYEo8U-FRHexnl5SNbgmh2RUwoX8uT6Qy3t0-nVyWlEumy9Tgs
Message-ID: <CACOAw_xEqmpDQ9T-zqqvd4G6sxR+AZj_+v_3uV45G6SR4RFEgg@mail.gmail.com>
To: =?UTF-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
X-Headers-End: 1x6VD6-0007YJ-LV
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: multi-device expandable storage
 support
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
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBTZXAgMTQsIDIwMjYgYXQgMTE6MjjigK9QTSDmnY7nj4IxMSA8a2UubGkxMUB0cmFu
c3Npb24uY29tPiB3cm90ZToKPgo+IEhpIERhZWhvLAo+Cj4gVGhhbmtzIGZvciB0aGUgc3VnZ2Vz
dGlvbi4gV2UgZXZhbHVhdGVkIHNpbmdsZS1kZXZpY2UgL2RhdGEgd2l0aAo+IHJlc2l6YWJsZV90
YWlsX3NlY25vIGFuZCBzdGFuZGFyZCByZXNpemUuIEl0IGNhbiByZWNsYWltIGEgdGFpbCBpbgo+
IHByaW5jaXBsZSwgYnV0IGl0IGRvZXMgbm90IGZpdCBvdXIgcHJvZHVjdGlvbiBsYXlvdXQuCj4K
PiBPbiBvdXIgZGV2aWNlcywgcHJpbWFyeSB1c2VyZGF0YSBpcyBtZXRhZGF0YS1lbmNyeXB0ZWQg
dW5kZXIgaXRzIG93bgo+IEtleXN0b3JlIGtleTsgZXhwYW5kIGlzIGEgc2VwYXJhdGUgYmxvY2sg
ZGV2aWNlIHdpdGggYSBkaWZmZXJlbnQga2V5Lgo+IFdlIG5lZWQgdG8gcmVjbGFpbSBjYXBhY2l0
eSBmb3Igc3VwZXIgd2l0aG91dCByZXNpemluZyB0aGUgZW5jcnlwdGVkCj4gcHJpbWFyeSB1c2Vy
ZGF0YSBkZXZpY2Ugb3IgZGlzdHVyYmluZyBpdHMgY3J5cHRvIG1ldGFkYXRhLgo+Cj4gQWxzbywg
cmVjbGFpbWVkIHNwYWNlIG11c3QgYmUgbWVyZ2VkIGludG8gc3VwZXIgYXQgdGhlIHBoeXNpY2Fs
IGxheW91dAo+IGxldmVsLCBzbyBpdCBtdXN0IGJlIGNvbnRpZ3VvdXMgd2l0aCBzdXBlci4gQSBz
aW5nbGUgdXNlcmRhdGEgZGV2aWNlCj4gcHV0cyB0aGUgcmVjbGFpbWFibGUgcmVnaW9uIGF0IHRo
ZSBlbmQgb2YgdXNlcmRhdGEsIHdoaWNoIGlzIHVzdWFsbHkgbm90Cj4gYWRqYWNlbnQgdG8gc3Vw
ZXIgaW4gb3VyIHBhcnRpdGlvbiB0YWJsZS4gUmVzaGFwaW5nIHBhcnRpdGlvbnMgdG8gY29ubmVj
dAo+IHRoZW0gaXMgZGlmZmljdWx0IGFuZCByaXNreSBkdXJpbmcgT1RBLgo+Cj4gVGhhdCBpcyB3
aHkgd2UgdXNlIGFuIGV4cGFuZCBwYXJ0aXRpb24gYXR0YWNoZWQgYXMgYW4gRjJGUyBzZWNvbmRh
cnk6Cj4gcHJpbWFyeSB1c2VyZGF0YSBzdGF5cyB1bmNoYW5nZWQsIGV4cGFuZCBjYW4gc2l0IG5l
eHQgdG8gc3VwZXIsIGFuZCBhZnRlcgo+IHNocmluayB3ZSBjYW4gZHJvcCBleHBhbmQgZnJvbSBG
MkZTIGFuZCBhc3NpZ24gdGhhdCBzcGFjZSB0byBzdXBlci4KPgo+IFNvIHJlc2l6YWJsZV90YWls
X3NlY25vIGlzIHVzZWZ1bCwgYnV0IGl0IGNhbm5vdCByZXBsYWNlIG91ciBleHBhbmQKPiBzZWNv
bmRhcnkgZmxvdy4gV2Ugc3RpbGwgbmVlZCBhbGxvY19wcmltYXJ5IGFuZCByZXNpemUgZHJvcC1s
YXN0LXNlY29uZGFyeQo+IGZvciB0aGUgcmVhc29ucyBhYm92ZS4KPgoKSGkgS2UgTGksCgpIYXZl
IHlvdSBjb25zaWRlcmVkIGRtLWxpbmVhciB0byByZXNvbHZlIHlvdXIgZGVzaWduIGNvbnN0cmFp
bnQ/CgpUaGFua3MsCkRhZWhvCgo+IFRoYW5rcywKPiBLZSBMaQoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
