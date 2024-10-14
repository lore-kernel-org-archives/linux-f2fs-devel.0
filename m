Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC1BD1812F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:28:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t0Nvn-0006xO-Hy;
	Mon, 14 Oct 2024 16:28:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1t0Nvm-0006xH-8g
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Oct 2024 16:28:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3lfAMO91it2cDxvAsrXrdZ8WvRxbUyiDWy7XG1lwedI=; b=P1j4Js7u4fnj2Y23nOe+K45JUX
 qLb916BIBAG1IRH3Wd3Z6us7oW3KITsF6zvnoOG9hiiJfvAUD5Z6hGxE2x8ZUnK9+j+OuQexv3kDU
 N3h9t+NmpcEeRJ8opP/6d0FOfK14DGnA5hpxep+89n4aJlZxG0mkRn/6BZcW0bQM+0dc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3lfAMO91it2cDxvAsrXrdZ8WvRxbUyiDWy7XG1lwedI=; b=F54TAdCw23iokMV4fnpEQNedZE
 a3ImKvVqCZGP4uj0MnlYLd6tM3q5iXS4mpwVjHU+S9UOF3CCVArR2J3QD8mis5dfVNdDKY6niiZbc
 3PHvlvdGq3RtwhfOiINrBuwKunynd0TpAl8RkROVPpgRxGOfCLZ9iNIt97sBrtCqCvnM=;
Received: from mail-ua1-f43.google.com ([209.85.222.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1t0Nvm-00007v-Bx for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Oct 2024 16:28:26 +0000
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-84fc1a5e65bso1045906241.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Oct 2024 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728923295; x=1729528095; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lfAMO91it2cDxvAsrXrdZ8WvRxbUyiDWy7XG1lwedI=;
 b=Js/tihBLBoBi6VmoK7BxBMnEVUvtfzeVL212OaumPWB+J4CLSnrnx6ZN+u3VjuvPY9
 vh7P3y0B1EJqBHgjlMyXbn6/5lztCRUnu2cDdo1h5e57JF4waPvgufpsL/YwHR9/8nHy
 mLDd4H2kVqGpyDqXdNXQ7wJh3YqG9C0y6qa+O9BTqgZaPIs7NDCX3wtMgY3DaXGBidaB
 eELBFamyp2XrW55QbgIcAQcoexP77dNom3E+LVO3MHDSuXADiTUaueHosinmXA2zLIuG
 ekcEuSC+5dsPhkDH9JjxVkAaSwyYZCsOApGg30NoZhpIUGgoGU7zg8ROJ7Qpd1+F9tjg
 4zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728923295; x=1729528095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lfAMO91it2cDxvAsrXrdZ8WvRxbUyiDWy7XG1lwedI=;
 b=PtQujdtCKO2o1XagJ5990WPI3pjwMmYcoIphSECKt+StZlwMxEKBnZiHORymqDGupm
 qtUZZDQ5kqvmVrrsLP2AL12dDAj5EoFnjkv2hKex81B2xBrvkVzCcBrP66FSidGVoOyy
 tYIx4sz5m2ZCpglkwMUtLUUVZyGeo8z8SDy8LMhZyg63KPFM/Bud/m1TlqECbiNTt/1I
 7syuoSO577g9bYH5btufBSW31fQzRHgq2eRXdJoI9BZ2kR6pJXvgrAGYeD4l3J4VAcnt
 FgOi+dm3qGbUbo9jb6Xo13CBG6mxzaivXTqXXa/GgL75JsG98AfzJ5uSRFTlEZmGtP0X
 bmsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYpcpQKgsZ0Uxj11CMh/iKcODnGtzRxPmV0+NLQs040mzR3JDC8mqPFgQfDh71BoQQWxRkKsQ9krq8Yn+Rr+SQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxWRgnjO7U2dlpQLw4qziyloC+ab9D7Pa93rU5Kc+l1kvEDWr3M
 PWKsOw6lCPhhzL5tLuhGaEkz80j014rebqySYxtY1JAJIVXaTLYRKd4E4oPyL9CJ1svnjsFJi85
 F5A8aOEzupKfxwBI+9/G0wEJCn5U=
X-Google-Smtp-Source: AGHT+IE182Fb41RE9AOm8wcIYCzGGR+HdLS3F/hvPllVGWRy7W6ATYjwmFbsnKxabf5DFdYEnhTiw+22kGeCSq6OldE=
X-Received: by 2002:a05:6122:791:b0:50a:b5a3:e00c with SMTP id
 71dfb90a1353d-50d374a2ed3mr4576421e0c.1.1728923295449; Mon, 14 Oct 2024
 09:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241010192626.1597226-1-daeho43@gmail.com>
 <ZwyyiG0pqXoBFIW5@infradead.org>
In-Reply-To: <ZwyyiG0pqXoBFIW5@infradead.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 14 Oct 2024 09:28:04 -0700
Message-ID: <CACOAw_yvb=jacbXVr76bSbCEcud=D1vw5rJVDO+TjZbMLYzdZQ@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1t0Nvm-00007v-Bx
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: introduce device aliasing file
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

T24gU3VuLCBPY3QgMTMsIDIwMjQgYXQgMTA6NTbigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gT24gVGh1LCBPY3QgMTAsIDIwMjQgYXQgMTI6MjY6
MjZQTSAtMDcwMCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gPiBGcm9tOiBEYWVobyBKZW9uZyA8ZGFl
aG9qZW9uZ0Bnb29nbGUuY29tPgo+ID4KPiA+IEYyRlMgc2hvdWxkIHVuZGVyc3RhbmQgaG93IHRo
ZSBkZXZpY2UgYWxpYXNpbmcgZmlsZSB3b3JrcyBhbmQgc3VwcG9ydAo+ID4gZGVsZXRpbmcgdGhl
IGZpbGUgYWZ0ZXIgdXNlLiBBIGRldmljZSBhbGlhc2luZyBmaWxlIGNhbiBiZSBjcmVhdGVkIGJ5
Cj4gPiBta2ZzLmYyZnMgdG9vbCBhbmQgaXQgY2FuIG1hcCB0aGUgd2hvbGUgZGV2aWNlIHdpdGgg
YW4gZXh0cmVudCwgbm90Cj4KPiBzL2V4dHJlbnQvZXh0ZW50L2cKPgo+ID4gdXNpbmcgbm9kZSBi
bG9ja3MuIFRoZSBmaWxlIHNwYWNlIHNob3VsZCBiZSBwaW5uZWQgYW5kIG5vcm1hbGx5IHVzZWQg
Zm9yCj4gPiByZWFkLW9ubHkgdXNhZ2VzLgo+Cj4gSXMgdGhlcmUgYW4gZXhwbGFuYXRpb24gc29t
ZXdoZXJlIHdoYXQgYSAnZGV2aWNlIGFsaWFzaW5nIGZpbGUnIGlzPwoKUGx6LCByZWZlciB0byB0
aGlzIHBhdGNoIGFuZCB0aGUgZGVzY3JpcHRpb24gdGhlcmUuCgpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9qYWVnZXVrL2YyZnMtdG9vbHMuZ2l0L2NvbW1p
dC8/aD1kZXYtdGVzdCZpZD04Y2M0ZTI1N2VjMjBiZWUyMDdiYjAzNGQ1YWM0MDZlMWFiMzFlYWVh
CgpUaGFuayB5b3UsCgoKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
