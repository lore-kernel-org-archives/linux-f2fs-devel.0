Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46245C5DF85
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/YcEFSA5Svsv9sNn3U03pdc+tO0c2fr3nmu8/s0PSNg=; b=CT2BnNF/U/rE/4JH75yi3WlUCK
	/0dU1b8lhgcZEFxPDSWlgs487XUYixAucll7omW1YyXvJvUp73aLBiXe/cEIrkkvGJ6UlDSGhtn8v
	k46kS3iW2aKnSk2h0LSPGzpfCJiJayzdDPhEe5/2STWWjfKsGJrQR9LFWRcBRlYvvDnI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwkzs-00078u-V1;
	Wed, 19 Aug 2026 18:26:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wwkzs-00078o-EH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 18:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gemnln6hMnVD04QHISg6j87mMEhiOGN9F8MzklN/I5I=; b=cv/vAq7tM4F/ozGEiYmW+nFAZz
 9z+gDv8y6nRWCphCAZ0gULKbKp9UonM7UKbT+eFILvqE88iehZ5lZnHUvtEWKmv28vfZY9a1iZgI0
 41NELsb2VDdNUTVpZIoHY3ObA/ZO66sUzLvrSePDCrVOkb55WMsapI/Cu8ooA7NHegbQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gemnln6hMnVD04QHISg6j87mMEhiOGN9F8MzklN/I5I=; b=XLK4kpS1ZeLi4LL2Etq3MV/2O1
 TY3kgnJsbcTEvPPUR1GiZZ1ImdXjnUqjSdwGIDBzJZ1mLYwdyePkgVorUT7QAbxWP0BwhsjDBY+qt
 M/vg9KoPeHEa/SxgRx4ZcTLJ6xYL7enRXm53bW6/268Iz/ed38GXTTieDpyNK+typ2oQ=;
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwkzu-0002sh-C8 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 18:26:44 +0000
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc1469c1b83so1416446a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 11:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787163997; cv=none;
 d=google.com; s=arc-20260327;
 b=K1DDMJpO+XtH8Hemk1yLg1jSFEdIJ82ePyVEIOf8YIDVk/Jtlkr0i0fY1KnRCNP0sA
 mLi41E/idfdzy5I3beonMcOWNc3DiS01Iekeb+fnwr6pMZFOxR5DU3Gkszcie8SRZJaH
 La4lpuuusLCRiZFQQgA8tq8DY2FunemYw6B4/OqRn9tF5tH1YfTVvL8cUv+mhKGXV11C
 12dObc1Wiv6gZYG5jxqfURd33cG/EWJ7Yw0HuAEFuzJ5hjSPG1C1obZ8IWtUNqpaRxqm
 IMNkrltH2U62YACz2aD5sh5xMT/4qaWYz5r+++JDwgZ4F/waE/7UDuAmHQYkrbSAKWNR
 nSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gemnln6hMnVD04QHISg6j87mMEhiOGN9F8MzklN/I5I=;
 fh=WuUB1MBXdxXmSWXYxHovG0T9hWGHMsANGt9xgir1QrA=;
 b=rolB89CRNMKuv1em4LyZ9pOgDhwcCeyt5LQH/fzfXGz042cphVgkdqDz2lAP0/RHTu
 nZZKfXpbevo1ZgPWYVtVXDaZlUdHUUOUus20ZpKeyIJskjXqG0PNLhaSk7ORce+TRt83
 lH3LXVXH6Q1J3vwXiLarUIm4R/H1vGcdCjk9oYZC+3R/L/VS0wPs28lqWkwuAyZczkmL
 ArId4PxH5CevkfsTfmzFvDWXzDwOXXDPW40IvzbCxe+O7nZgq6p1GQ13s5dLBOgTMWMl
 dH33CcYrZELT3lHhTBiDb4+jSp5g9s/VVt8o711bOWUzPb0J1dm+xezXbi5s1kHp1xGu
 n8Hg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787163997; x=1787768797; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gemnln6hMnVD04QHISg6j87mMEhiOGN9F8MzklN/I5I=;
 b=qwRiUlLzTGj+E8oFY0uS98xpa1wfPf928A/chv2YZhAivPHWRQvrtVqCSWINAexcyY
 6UcsjnubntOrBhk+FJrD9OYUtg+nHn2/LtMroqgQXO5wa1B29yqYT9Q1btQwi3MUsAiV
 QiuVBx2P//oyo1L8qnjQj6eCixOqDW6kOeHwpuMP8ekZehPjypAEDmHWn4y4Vy+4gzUa
 moPVgTxiTNl4tOlkkgrt/r9en9z33ftLyjo5e7OnmJVn2VQqSBm0eLJWpNDrmnHd1rAU
 2rpOmQYOGAD4mkgQ6gZ96mXkjthlpskqRHxz2GLJ9ce7rSsIIoHiVPfKfjRehkIHWiUM
 0xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787163997; x=1787768797;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gemnln6hMnVD04QHISg6j87mMEhiOGN9F8MzklN/I5I=;
 b=IAttqRqHnto1VrpKu0U9PMEb1/uWN09dcfbK8i5J2Gbwy8UtUfBcdizBXcuvnHIBQS
 ulDv4I6/xjk88ScPHT1H7JD8mci0CaKE6uFRVwL9xFjN6+/Aj4unvyJYOoE+NrZ9c1+5
 ME5SagPR2ukE/BUuAIMhwD3zHgfBYXFQn0C7PV7nORwI7OLcNBeDjf4m2ElneAJkANjh
 21wGKMKEOnQT8s1MTvu+r1moZ7oZ6pXyVUX+66AGWpR46x7SnCBI7l/7JVmPKTnzGn+J
 hqS2iPHYhJxrkIivX1sjzITiBLxjQEMfO9MYvFvOkNHQSZteNgvg9+CHM7YXQ+diYEqQ
 cLWg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq8TPsy8wQS4jB6nOQH5aAJDncHIhzHLbM1Bb3UuYUwutGkk4vlaJK2TV3XKKcKLRhyuGjk3rHlxNX+vSjr8sy@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw0TK0iZ28ikExpIrCupTQ8/C/OjNdcvtaR14I7HQJZwdcVcRxf
 /4ehS4nXlawwL94XgkC1U064inGOOZZJ9hBQFGzhcjx3axlw7zUnJbep3Q8A4W+9HVDGJK3OwuO
 k7zRVvQB9AV93Vad/grW6ogr947N5aVI=
X-Gm-Gg: AR+sD13pHG2Cih9xP9ywwGAQAN76rqcE6LWRuF4gxs2N2Aev2sv54nNQbfhTmwZ4TVU
 /4Y1oIFGU4Grx3Hot9C+iqLck/zoXGN/UiuxWRcEw0jFQo9ZMV4jft1DGwXeDJMZ3beQaYYQs2K
 SIrJ6pdBqP++GhKMDNb5EkTzjNidl83KELLg+gJvJrUwNEglzCaT052cvxuoCuBOIA4TLeKSnFs
 oejNiQGJbkpYfrxXFWFcIxkLpuboojDYiF+oxVlTYjvbDR6VlBaH0ZiBDZfcTlft7131Rc/fe1J
 DHFMRmCuA53zxA6RXD+SWlyP7V2KqvbUWvgnRsgKkzAnwN9B6Ri9ybXCCfYTgIUVObmjmcaxIXb
 PNRIE73JG4vcbm6M/It+L0Ybeak9GoglhAA==
X-Received: by 2002:a05:6a00:2988:b0:851:c1ba:7aa6 with SMTP id
 d2e1a72fcca58-851d3953697mr10959732b3a.11.1787163996976; Wed, 19 Aug 2026
 11:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260818171412.3201082-1-daeho43@gmail.com>
 <0e1162de-1ad4-4c24-a5c9-cd05c5b08cc0@kernel.org>
In-Reply-To: <0e1162de-1ad4-4c24-a5c9-cd05c5b08cc0@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 19 Aug 2026 11:26:21 -0700
X-Gm-Features: AcwNN1WXDrN_IXYS4nCBJ5zUdrUeLj9ODIuQXHDUc-VcePPid7oo1qIeWd55mo4
Message-ID: <CACOAw_zQNVUtoPat0v1KFD5hkqBF1d=+3FwiGAf0bLma=xdq8g@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wwkzu-0002sh-C8
Subject: Re: [f2fs-dev] [PATCH] f2fs: accurately adjust free_sections during
 free_segment_range
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

T24gVHVlLCBBdWcgMTgsIDIwMjYgYXQgODo1N+KAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiA4LzE5LzI2IDAxOjE0LCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IEZy
b206IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4gPgo+ID4gSW4gZnJlZV9z
ZWdtZW50X3JhbmdlKCksIE1BSU5fU0VDUyhzYmkpIGlzIHRlbXBvcmFyaWx5IHJlZHVjZWQgYnkg
YHNlY3NgCj4gPiB3aGlsZSB2YWxpZCBibG9ja3MgaW4gdGhlIHRydW5jYXRlZCByYW5nZSBhcmUg
ZXZhY3VhdGVkIGJ5IEdDLgo+ID4KPiA+IEhvd2V2ZXIsIGlmIGFueSBzZWN0aW9ucyB3aXRoaW4g
dGhlIHRydW5jYXRlZCByYW5nZSB3ZXJlIGFscmVhZHkgZnJlZSwKPiA+IGZhaWxpbmcgdG8gZGVk
dWN0IHRoZW0gZnJvbSBGUkVFX0koc2JpKS0+ZnJlZV9zZWN0aW9ucyBsZWFkcyB0byBhbgo+ID4g
b3Zlci1lc3RpbWF0aW9uIG9mIGF2YWlsYWJsZSBzcGFjZSBpbiB0aGUgcmVkdWNlZCBtYWluIGFy
ZWEsIGNhdXNpbmcKPiA+IGluY29uc2lzdGVudCBmcmVlIHNlY3Rpb24gYWNjb3VudGluZy4KPgo+
IENhbiB5b3UgcGxlYXNlIHNob3cgbWUgYW4gZXhhbXBsZSBmb3IgYWJvdmUgY2FzZT8gSSBkaWRu
J3QgZ2V0IGl0LgoKSGVyZSBpcyBhIGNvbmNyZXRlIGV4YW1wbGUgZXhwbGFpbmluZyB3aHkgdGhp
cyBhZGp1c3RtZW50IGlzIG5lZWRlZDoKClN1cHBvc2U6Ci0gVG90YWwgbWFpbiBzZWN0aW9uczog
TUFJTl9TRUNTID0gMTAwIChzZWN0aW9ucyAwIC4uIDk5KQotIFRvdGFsIGZyZWUgc2VjdGlvbnM6
IGZyZWVfc2VjdGlvbnMgPSAzMAotIFdlIHdhbnQgdG8gc2hyaW5rIHRoZSBmaWxlc3lzdGVtIGJ5
IDEwIHNlY3Rpb25zIChzZWNzID0gMTAsIHJhbmdlIDkwIC4uIDk5KS4KLSBXaXRoaW4gdGhlIHRy
dW5jYXRlZCByYW5nZSAoc2VjdGlvbnMgOTAgLi4gOTkpOgogICogNiBzZWN0aW9ucyBhcmUgYWxy
ZWFkeSBmcmVlIChmcmVlX3NlY21hcCBiaXQgaXMgMCkKICAqIDQgc2VjdGlvbnMgYXJlIGluLXVz
ZSB3aXRoIHZhbGlkIGJsb2NrcyB0aGF0IG5lZWQgdG8gYmUgbWlncmF0ZWQgYnkgR0MuCldoZW4g
ZnJlZV9zZWdtZW50X3JhbmdlKCkgZW50ZXJzOgoxLiBNQUlOX1NFQ1MgaXMgdGVtcG9yYXJpbHkg
cmVkdWNlZCBmcm9tIDEwMCB0byA5MCBzbyB0aGF0IG5ldyBibG9jawogICBhbGxvY2F0aW9ucyBh
cmUgY29uc3RyYWluZWQgdG8gc2VjdGlvbnMgMCAuLiA4OS4KMi4gVGhlIGFjdHVhbCBudW1iZXIg
b2YgZnJlZSBzZWN0aW9ucyBhdmFpbGFibGUgaW4gdGhlIHJlZHVjZWQgcmFuZ2UKICAgKDAgLi4g
ODkpIGlzIG9ubHkgMjQgKDMwIC0gNiA9IDI0KS4KMy4gV2l0aG91dCB0aGlzIHBhdGNoOgogICAt
IGZyZWVfc2VjdGlvbnMgcmVtYWlucyAzMCB3aGlsZSBNQUlOX1NFQ1MgaXMgOTAuCiAgIC0gRHVy
aW5nIHRoZSBzdWJzZXF1ZW50IEdDIG1pZ3JhdGlvbnMsIGZyZWUgc2VjdGlvbiBjaGVja3MgKHN1
Y2ggYXMKICAgICBoYXNfbm90X2Vub3VnaF9mcmVlX3NlY3MoKSkgd2lsbCBvdmVyLWVzdGltYXRl
IGF2YWlsYWJsZSBzcGFjZSBieSA2CiAgICAgc2VjdGlvbnMgaW4gdGhlIGFjdGl2ZSAwIC4uIDg5
IHJhbmdlLgogICAtIElmIGZyZWVfc2VnbWVudF9yYW5nZSgpIGZhaWxzIG1pZHdheSAoZS5nLiAt
RUFHQUlOKSwgZnJlZV9zZWN0aW9ucwogICAgIGFjY291bnRpbmcgYmVjb21lcyBpbmNvbnNpc3Rl
bnQuCldpdGggdGhpcyBwYXRjaDoKLSBXZSBjb3VudCB0aGUgNiBhbHJlYWR5LWZyZWUgc2VjdGlv
bnMgaW4gdGhlIHRydW5jYXRlZCByYW5nZSAoOTAgLi4gOTkpIGFuZAogIGRlZHVjdCB0aGVtIGZy
b20gZnJlZV9zZWN0aW9ucyB1cG9uIGVudGVyaW5nICgzMCAtIDYgPSAyNCksIHBlcmZlY3RseQog
IG1hdGNoaW5nIHRoZSBhY3R1YWwgZnJlZSBzZWN0aW9ucyBpbiB0aGUgYWN0aXZlIHJhbmdlIDAg
Li4gODkuCi0gT24gZXhpdCwgdGhlIGRlZHVjdGVkIGFtb3VudCBpcyByZXN0b3JlZCwga2VlcGlu
ZyBmcmVlX3NlY3Rpb25zIGNvbnNpc3RlbnQKICB0aHJvdWdob3V0IHRoZSBlbnRpcmUgcmVzaXpl
IGxpZmVjeWNsZS4KCkhvcGUgdGhpcyBjbGFyaWZpZXMgdGhlIHNjZW5hcmlvIQoKVGhhbmtzLAoK
Pgo+IEJUVywgaXQgbmVlZHMgdG8gcmViYXNlIHRoaXMgcGF0Y2ggb24gZGV2LXRlc3QgYnJhbmNo
Lgo+Cj4gVGhhbmtzLAo+Cj4gPgo+ID4gRml4IHRoaXMgYnkgY2FsY3VsYXRpbmcgdGhlIG51bWJl
ciBvZiBhbHJlYWR5LWZyZWUgc2VjdGlvbnMgaW4gdGhlCj4gPiB0cnVuY2F0ZWQgcmFuZ2UgdW5k
ZXIgc2VnbWFwX2xvY2ssIGRlZHVjdGluZyB0aGVtIGZyb20gZnJlZV9zZWN0aW9ucyB1cG9uCj4g
PiBlbnRlcmluZyBmcmVlX3NlZ21lbnRfcmFuZ2UoKSwgYW5kIHJlc3RvcmluZyB0aGVtIHVuZGVy
IHNlZ21hcF9sb2NrIG9uIGV4aXQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogRGFlaG8gSmVvbmcg
PGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFN1bm1pbiBKZW9uZyA8
c19taW4uamVvbmdAc2Ftc3VuZy5jb20+Cj4gPiAtLS0KPiA+ICBmcy9mMmZzL2djLmMgfCAxNSAr
KysrKysrKysrKysrKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2djLmMgYi9mcy9mMmZzL2dj
LmMKPiA+IGluZGV4IDc4NzEzM2VlMmViMi4uZjNhNmZjNmQwOGFlIDEwMDY0NAo+ID4gLS0tIGEv
ZnMvZjJmcy9nYy5jCj4gPiArKysgYi9mcy9mMmZzL2djLmMKPiA+IEBAIC0yMjAwLDggKzIyMDAs
OSBAQCBpbnQgZjJmc19nY19yYW5nZShzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksCj4gPiAgc3Rh
dGljIGludCBmcmVlX3NlZ21lbnRfcmFuZ2Uoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHNlY3MsIGJvb2wgZHJ5
X3J1bikKPiA+ICB7Cj4gPiAtICAgICB1bnNpZ25lZCBpbnQgbmV4dF9pbnVzZSwgc3RhcnQsIGVu
ZDsKPiA+ICsgICAgIHVuc2lnbmVkIGludCBzZWNubywgbmV4dF9pbnVzZSwgc3RhcnQsIGVuZCwg
ZW5kX3NlY25vOwo+ID4gICAgICAgc3RydWN0IGNwX2NvbnRyb2wgY3BjID0geyBDUF9SRVNJWkUs
IDAsIDAsIDAgfTsKPiA+ICsgICAgIHVuc2lnbmVkIGludCBmcmVlZF9zZWNzID0gMDsKPiA+ICAg
ICAgIGludCBnY19tb2RlLCBnY190eXBlOwo+ID4gICAgICAgaW50IGVyciA9IDA7Cj4gPiAgICAg
ICBpbnQgdHlwZTsKPiA+IEBAIC0yMjEwLDYgKzIyMTEsNyBAQCBzdGF0aWMgaW50IGZyZWVfc2Vn
bWVudF9yYW5nZShzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksCj4gPiAgICAgICBNQUlOX1NFQ1Mo
c2JpKSAtPSBzZWNzOwo+ID4gICAgICAgc3RhcnQgPSBNQUlOX1NFQ1Moc2JpKSAqIFNFR1NfUEVS
X1NFQyhzYmkpOwo+ID4gICAgICAgZW5kID0gTUFJTl9TRUdTKHNiaSkgLSAxOwo+ID4gKyAgICAg
ZW5kX3NlY25vID0gR0VUX1NFQ19GUk9NX1NFRyhzYmksIGVuZCk7Cj4gPgo+ID4gICAgICAgbXV0
ZXhfbG9jaygmRElSVFlfSShzYmkpLT5zZWdsaXN0X2xvY2spOwo+ID4gICAgICAgZm9yIChnY19t
b2RlID0gMDsgZ2NfbW9kZSA8IE1BWF9HQ19QT0xJQ1k7IGdjX21vZGUrKykKPiA+IEBAIC0yMjIx
LDYgKzIyMjMsMTQgQEAgc3RhdGljIGludCBmcmVlX3NlZ21lbnRfcmFuZ2Uoc3RydWN0IGYyZnNf
c2JfaW5mbyAqc2JpLAo+ID4gICAgICAgICAgICAgICAgICAgICAgIHNiaS0+bmV4dF92aWN0aW1f
c2VnW2djX3R5cGVdID0gTlVMTF9TRUdOTzsKPiA+ICAgICAgIG11dGV4X3VubG9jaygmRElSVFlf
SShzYmkpLT5zZWdsaXN0X2xvY2spOwo+ID4KPiA+ICsgICAgIHNwaW5fbG9jaygmRlJFRV9JKHNi
aSktPnNlZ21hcF9sb2NrKTsKPiA+ICsgICAgIGZvciAoc2Vjbm8gPSBNQUlOX1NFQ1Moc2JpKTsg
c2Vjbm8gPD0gZW5kX3NlY25vOyBzZWNubysrKSB7Cj4gPiArICAgICAgICAgICAgIGlmICghdGVz
dF9iaXQoc2Vjbm8sIEZSRUVfSShzYmkpLT5mcmVlX3NlY21hcCkpCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgZnJlZWRfc2VjcysrOwo+ID4gKyAgICAgfQo+ID4gKyAgICAgRlJFRV9JKHNiaSkt
PmZyZWVfc2VjdGlvbnMgLT0gZnJlZWRfc2VjczsKPiA+ICsgICAgIHNwaW5fdW5sb2NrKCZGUkVF
X0koc2JpKS0+c2VnbWFwX2xvY2spOwo+ID4gKwo+ID4gICAgICAgLyogTW92ZSBvdXQgY3Vyc2Vn
cyBmcm9tIHRoZSB0YXJnZXQgcmFuZ2UgKi8KPiA+ICAgICAgIGZvciAodHlwZSA9IENVUlNFR19I
T1RfREFUQTsgdHlwZSA8IE5SX0NVUlNFR19UWVBFOyB0eXBlKyspIHsKPiA+ICAgICAgICAgICAg
ICAgZXJyID0gZjJmc19hbGxvY2F0ZV9zZWdtZW50X2Zvcl9yZXNpemUoc2JpLCB0eXBlLCBzdGFy
dCwgZW5kKTsKPiA+IEBAIC0yMjQ1LDYgKzIyNTUsOSBAQCBzdGF0aWMgaW50IGZyZWVfc2VnbWVu
dF9yYW5nZShzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksCj4gPiAgICAgICAgICAgICAgIGYyZnNf
YnVnX29uKHNiaSwgMSk7Cj4gPiAgICAgICB9Cj4gPiAgb3V0Ogo+ID4gKyAgICAgc3Bpbl9sb2Nr
KCZGUkVFX0koc2JpKS0+c2VnbWFwX2xvY2spOwo+ID4gKyAgICAgRlJFRV9JKHNiaSktPmZyZWVf
c2VjdGlvbnMgKz0gZnJlZWRfc2VjczsKPiA+ICsgICAgIHNwaW5fdW5sb2NrKCZGUkVFX0koc2Jp
KS0+c2VnbWFwX2xvY2spOwo+ID4gICAgICAgTUFJTl9TRUNTKHNiaSkgKz0gc2VjczsKPiA+ICAg
ICAgIHJldHVybiBlcnI7Cj4gPiAgfQo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
