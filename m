Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09A5C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QaqHQA03gS4sLEzm7vOFB5eJTwuiaxMyvw/CQyIDo0g=; b=lFav5p5/MY6v0Tfopwuy0KyJDQ
	RhUQNPJCLkkha6AtGi7olH0tNeEGusHGobDBDx+ur2D0SsNqmlgGoyF/8M/mNxXHXI4mdjj+kDsEV
	nQg4qcoRbmnktCaRzI/GXDyekCQbqiCTOGqdIVXwSwmangd9dlj1Q+Pd3Uhs+TCTImSw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyQUq-00078Q-4m;
	Mon, 24 Aug 2026 08:57:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyQUo-00078J-VY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 08:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2uRvUUWtl1lJZbmuXqBD0966eF9meh+dTRlx2zjrvB4=; b=WyJQJMSy72UsVgXLuS1EB9kjWz
 6pcWuRAF+nhvs41mrgn33dxZ7jxVXQlaK4V/MctPRLufrZv9JP7tPgCEaVMsV6C5zouJibU/4xqSj
 S2LccIDME/TEyACcJIMtdivmoZcA8dAvbjOWySfWpLwVXawzFQzGSVA/CSB4W7im3y3U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2uRvUUWtl1lJZbmuXqBD0966eF9meh+dTRlx2zjrvB4=; b=HQHbSFBG0SWzmAEypxbYISxuXt
 DTMW+VUmjxPMD+WpvsZouxipdZYVyF20/8lzsDaC5LRT5gNroWymz/zmxzPwL7w8VHKvRh5N2Od9j
 6/jm1lSG4f8AFDjSQOcz+pJAqGbdAgzP0MUouwdIzgrEjR2cG6W64ih4WYCwnYfB3+qE=;
Received: from mail-lf1-f44.google.com ([209.85.167.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyQUl-0006dG-63 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 08:57:32 +0000
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5b0f19bea2fso3244362e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 01:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787561844; cv=none;
 d=google.com; s=arc-20260327;
 b=sg0R7mUxfIGqL1QodVWgyfhLaUrNvtBmqzEOcr07PYumr5+OHuq/vZayOMkE7VrUUv
 Qk8ShYEMY3SXU48K9z9zFaJuU+JqG4RLPr866HOP6WNQQ/V5FPLARAWJZ1wwWUwbgfpl
 +yfy/m7Q92gL5v1xp9zMnGgtAp1/2n2WwGPjCr2AQgtXmDuwW+Ni8/xT4GnZNuLXPSHS
 sQO5Re6zzyigPaqEfmFWchiSPpYLRmRE72sQiYrwY2YTPox4qSoDXiPhyA4FhMK1cZpN
 ogMzxNo9L/9JBZwdjxhmTC8TETFjFspFgnR55yHWmds9nK0+n/kTFz0mZzb5+JAjooWJ
 6B4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2uRvUUWtl1lJZbmuXqBD0966eF9meh+dTRlx2zjrvB4=;
 fh=2+gO/Jj4sMv/Bic0RaEVCGELh7+BahZqQirzCZypqa0=;
 b=BhMwXg401sPTG3tXdBcLO5kszWNJvulvQKiPXZD4APj2jnrsyAmPl3toMz+vQK1wj3
 PSqE96toVCc4TNXrYuc+SBjrMPC3SPcV/gEM/dM+PSsrinJ+5MQFAIEIDBgoVMJRy56p
 CrQy1Jcp4ZyBkc0fgEai9c1m55lzopxNyCgLowcwg+KYz17l3yFPC8Cgex1Mf+K41QZw
 pORAePjN+yJLPrswAJHlgYRp60hC9HU0etnLJOK6vaOSwYjeYi4JZQ2lIeltwTU0+VTY
 WjewtBV4OnuNY7hCCHmi2TGeoAVjdFyqI5KkYiLJYgW093u6X4zQEu5TVjXPtZ921cyZ
 J3Nw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787561844; x=1788166644; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2uRvUUWtl1lJZbmuXqBD0966eF9meh+dTRlx2zjrvB4=;
 b=oX9+l2SX2yqExbMPlLhQ5La7BYgMpKRDucuGHDQwSekSIHnhraddBFFDuEIHVwJg5z
 EQigbE0csjlMfzWb+9qyjmAYBENaRFC+xe0ArsxYIyHOJa83vXes3WBydZvuIgqk7cUO
 OonZGUjyrhrMezcbExIWq1X1qRJjFBkX7qbR/uRvcQetpTZbSBswBe9zUeWkebNqHnO1
 L9xfsUjK3I0pIuKNzRx74OGAUES/OqKG/JPuyrEbs4b1cFaIDvCp9KZZ5t+OsDRGBS7X
 1pSY1bZEg3D6/2SoAGrHv2LY/PHTZ53M6SAoll717ozdvVgXK0gp5MxKSZXpmF9Oif+C
 ac1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561844; x=1788166644;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2uRvUUWtl1lJZbmuXqBD0966eF9meh+dTRlx2zjrvB4=;
 b=m+TH1WuplVcJq620oihgUxHmW+kj218m7vDQMVVFxVHQFLcCb7aNdH45+LKCKhMHac
 q9kqNSOTg/TNCgTj6T49a/t3J8WgUygYaE+TIZnzrelfRJf8zA3avGgGx7zTGDse/nkk
 wxGrxKX8h3mh/NgJ0nxbSAv6k5jzYEz8HG6+Zz9otIaKgrHfJtuXFxrlnncBiZD43qEj
 l0KlXufn6OqIx9NIBDmvMocMgrH0Ki6brgdxDsGOeJL9U3oMK4TTu/ye1OTKL6QgLXNv
 0hY5+LnjpfVh182jaozonceBhXuARkJE7wZ+L5PtM1TUgI2HeGEUfv69IkDIk0zXkL5c
 V7rg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvUdQhgIx7qE0wPgBOS9HpXH5le42gaPRi5wwQjY56KYRpCvKZkJ7ROAv3blHoO+OaFvrmT0lkwr3qsfQ0XGVq@lists.sourceforge.net
X-Gm-Message-State: AFuF++mvUiAZkihV3HXivuKPtO8LpmBSyyzfO494Slcznzomnocr87OX
 UrlLDorkKspXeo1/sjfEpeb/OqNBTvIQe28U+YKliU9oriqCyUsx9g/u1VkRY/u5MTzIfzOM97M
 Jnzd/ShyKSUTb/RdMFtdZFrSOPB3+tuI=
X-Gm-Gg: AR+sD12+bB8PtNJRb7XOqvdJcNU95Nf4c0+C2eR++X2irmd6zP+moAL77EesQEBzbuV
 xoy7jhLLACld+nE4jnYSFnUuJRo5dzu53g4QWX8H/ZccDCFEuzvOlsJd6t/7o/EQPB/8zgUEH5v
 uhhtkOqVXShHMFXshFkiFY/Jd8caVh59xbrGsFhkfVSVp3EPtYOBCBNFQ5RW4hvqlgQ4u5BQmiZ
 QtyF/+vqOpvruXuqmKRZ7VmKpkQNTKeIHMxpNw+5P1Lh5Ek3YjO3rUXKTXt46ccJ+WJaKs0U7li
 7x92gfOkWt1m/Zy06lG68sBlxmb+khCOXjYjlFOyfC9NUVctj+9Fa/6N
X-Received: by 2002:a05:6512:3b90:b0:5ae:c8da:6254 with SMTP id
 2adb3069b0e04-5b484230f39mr7242212e87.22.1787561844161; Mon, 24 Aug 2026
 01:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-8-chao@kernel.org>
 <20260823125735.3230503-1-qiwenjie@xiaomi.com>
 <234a5bd3-76d1-4fea-bdc4-f1dff01e591b@kernel.org>
In-Reply-To: <234a5bd3-76d1-4fea-bdc4-f1dff01e591b@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 24 Aug 2026 16:57:12 +0800
X-Gm-Features: AcwNN1WS7Rq_hHW9WpD2fNhIq4IlRc3NGb8k1DhUthJG37b3E1cB7_WXYClP73o
Message-ID: <CAGFpFsSiP9_hDj-RgMV2+LZDX2qUquE7XBUP9eeV0ER8eLdgJw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wyQUl-0006dG-63
Subject: Re: [f2fs-dev] [PATCH v1 07/12] f2fs: cache: use node cache
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Wenjie Qi <qiwenjie@xiaomi.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

WWVzLCB0aGF0IGlzIHRoZSByYWNlIEkgbWVhbnQuCgpPbiBNb24sIEF1ZyAyNCwgMjAyNiBhdCAz
OjEz4oCvUE0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIDgvMjMvMjYg
MjA6NTcsIFdlbmppZSBRaSB3cm90ZToKPiA+IEhpIENoYW8sCj4gPgo+ID4+IGVudHJ5ID0gZm4t
PmVudHJ5Owo+ID4+IGYyZnNfY2FjaGVfZ2V0KGVudHJ5KTsKPiA+PiBzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZzYmktPmZzeW5jX25vZGVfbG9jaywgZmxhZ3MpOwo+ID4+Cj4gPj4gZjJmc19jYWNo
ZV93YWl0X3dyaXRlYmFjayhlbnRyeSk7Cj4gPgo+ID4gVGhlIGVudHJ5IHJlZmVyZW5jZSBrZWVw
cyB0aGUgZW50cnkgYWxsb2NhdGVkLCBidXQgdGhlIHdhaXRlciBkb2VzIG5vdCBob2xkCj4gPiB0
aGUgZW50cnkgbG9jay4gIEFmdGVyIFdSSVRFQkFDSyBpcyBjbGVhcmVkLCBpbnZhbGlkYXRpb24g
Y2FuIGRldGFjaCB0aGUKPiA+IGVudHJ5IGFuZCBzZXQgYGVudHJ5LT5jYWNoZWAgdG8gTlVMTC4g
IGBmMmZzX2NhY2hlX3dhaXRfd3JpdGViYWNrKClgIGNoZWNrcwo+ID4gYW5kIHVzZXMgYGVudHJ5
LT5jYWNoZWAgdGhyb3VnaCBzZXBhcmF0ZSBhY2Nlc3Nlcy4KPiA+Cj4gPiBEb2VzIHRoZSByZWZl
cmVuY2UgdGFrZW4gaGVyZSBhbHNvIGd1YXJhbnRlZSB0aGF0IHRoZSBwYXJlbnQgY2FjaGUgcmVt
YWlucwo+ID4gYXR0YWNoZWQgYWNyb3NzIHRoZSB3YWl0IGhlbHBlcidzIGNoZWNrIGFuZCB1c2U/
Cj4KPiBEbyB5b3UgbWVhbiByYWNlIGxpa2UgdGhpcz8KPgo+IC0gZjJmc193YWl0X29uX25vZGVf
Y2FjaGVzX3dyaXRlYmFjawo+ICAgLSBmMmZzX2NhY2hlX2dldAo+ICAgLSBmMmZzX2NhY2hlX3dh
aXRfd3JpdGViYWNrCj4gICAgLSBjaGVja2VkIGVudHJ5LT5jYWNoZSwgaXQncyB2YWxpZAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gZjJmc190cnVu
Y2F0ZV9jYWNoZQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAtIGYyZnNfZG9fdHJ1bmNhdGVfY2FjaGUKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC0gZW50cnktPmNhY2hlID0gTlVMTAo+ICAgIC0gZjJm
c19jYWNoZV93YWl0X3dyaXRlYmFja19jb25kIGFjY2Vzc2VzCj4gICAgICBpbnZhbGlkIGVudHJ5
LT5jYWNoZQo+Cj4gVGhhbmtzLAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
