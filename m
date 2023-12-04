Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78415C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Dec 2023 22:09:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rAH8H-0003M0-RR;
	Mon, 04 Dec 2023 22:09:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1rAH8H-0003Lt-2G
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 22:09:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0yaO/BTFuN+hdaZ3dr+nTdBWWXl4w8z8dbFIh9uyCDo=; b=Pregl5ZFaqIr+aEFa7no30AOk9
 dzbOtbI67fUS8enH+EjgLURrx+QDThFm0UHJsBN24mZdWyVHUzxd/RzTyPG4wVxStTkNUJ+HIcGqL
 F1Z4U1lP5DE+VfV9VzBgI2z9sQPYcl0wnhqBOHe13jcOfKEUDQLvEUFfEb85MFpHJ18o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0yaO/BTFuN+hdaZ3dr+nTdBWWXl4w8z8dbFIh9uyCDo=; b=WZS+LRHbOBFMnlHHfJmsAObYYH
 6aD5D1jyoESBj5ubp/FGb/CYFogLg4EoXfGsUex2eTVVqkxSKnUabX0SiTIv5CBbkMHXF2UKoE14i
 N6fdqmOcML7mKyhf1AALP5/qK9ihJYoPD6DC+oHebLUPgPlPWQrmZnszxU6l7ZwIL2gw=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rAH8G-0007Sl-PU for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 22:09:41 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-6cddc148285so5292320b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 04 Dec 2023 14:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701727775; x=1702332575; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yaO/BTFuN+hdaZ3dr+nTdBWWXl4w8z8dbFIh9uyCDo=;
 b=dhP13j6XFTSipmKN9FrzyZR2xc5sr+lxk9uXCt0y/++f8FvqWgj/WTYoj18zt9Y+gk
 uuItC7Zh/LdiQlpPQR0zMFGVdwO4N/uYI5sTZzGUDagpTaglZ9H83hSVE4TAPLp8nqUl
 GXsenmffJjFTmDQrTos74cBUe9bAlL4aHlI0oLS2487d6gAT81ZBCQ5GY/KCPkrdfmhj
 52F3RtKZGTKTAN7GZXrUIvQOS+cjQH47HUJumS4eq7S68kI9shSCMqsRmmdAN1tCmiko
 +i/HUFYbO6l+B8P7XW6jpCNdRBcflHYm7XBOgIlhm6XW3mZLPSfTligYF1uH06seQmZv
 suLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701727775; x=1702332575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yaO/BTFuN+hdaZ3dr+nTdBWWXl4w8z8dbFIh9uyCDo=;
 b=C1ycBZpDVcwrleA59+N1n6A8bjWq63oHGhZYzsrfAPU3T6DiSfel70HcEuYeOCB7Rk
 vgJ/FyYvPa/RWMwsUUBWFXEYpsAm+WuN8lRVWVUa1uKd0nPmikJTA0jmTywbOsU46jh5
 pjtRy8IRxPTJVjAsWlRBcegZtR7f80puc7JAsdCDh0i0MLHF+6fw9OoGW/M72yvY/pZO
 am1GxjbXCcboNIEeSSjo7lU+ZsOzVZ1HND+QQ2ZPViRGb0iKuJ43IZLUC/v5XBUqDPmE
 CNagEo1PJjkOdCyleycrCMYjecZc/uFHd4HiyYasUBvPSGPQJPzzAyG8fyYs08Pzyrtt
 gM1w==
X-Gm-Message-State: AOJu0YwzLHwTiv3ZGBuJfFl+Egjd+ku3qnYYjQCuMRkTOGZzCMdkvUja
 dnfVzfby1sNEmfR2ln3wl0ST0sOe1e66B2A6WepZjuSGLbE=
X-Google-Smtp-Source: AGHT+IHx2fJpWDvTw2VKMw7ZWa7AZ6Rjp2hXyHx6dU/sGjxgbNBWELhAzuwxM3yL2y0OEcXGx6baE8F20seioBN2j/Q=
X-Received: by 2002:a05:6122:1797:b0:4b2:c554:fbb1 with SMTP id
 o23-20020a056122179700b004b2c554fbb1mr2666171vkf.19.1701716589352; Mon, 04
 Dec 2023 11:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20231204180428.925779-1-jaegeuk@kernel.org>
 <20231204180428.925779-2-jaegeuk@kernel.org>
In-Reply-To: <20231204180428.925779-2-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 4 Dec 2023 11:02:58 -0800
Message-ID: <CACOAw_xbm4MinoOeimooCEketA=5oKWr46e-gU-ZtAG_rpWDAg@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1rAH8G-0007Sl-PU
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: fix write pointers on zoned device
 after roll forward
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

TEdUTQoKT24gTW9uLCBEZWMgNCwgMjAyMyBhdCAxMDowNuKAr0FNIEphZWdldWsgS2ltIDxqYWVn
ZXVrQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gMS4gZG8gcm9sbCBmb3J3YXJkIHJlY292ZXJ5Cj4g
Mi4gdXBkYXRlIGN1cnJlbnQgc2VnbWVudHMgcG9pbnRlcnMKPiAzLiBmaXggdGhlIGVudGlyZSB6
b25lcycgd3JpdGUgcG9pbnRlcnMKPiA0LiBkbyBjaGVja3BvaW50Cj4KPiBTaWduZWQtb2ZmLWJ5
OiBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPgo+IC0tLQo+ICBmcy9mMmZzL3JlY292
ZXJ5LmMgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYg
LS1naXQgYS9mcy9mMmZzL3JlY292ZXJ5LmMgYi9mcy9mMmZzL3JlY292ZXJ5LmMKPiBpbmRleCAx
NjQxNWM3NzBiNDUuLmQwZjI0Y2NiZDFhYyAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL3JlY292ZXJ5
LmMKPiArKysgYi9mcy9mMmZzL3JlY292ZXJ5LmMKPiBAQCAtOTE3LDYgKzkxNyw4IEBAIGludCBm
MmZzX3JlY292ZXJfZnN5bmNfZGF0YShzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksIGJvb2wgY2hl
Y2tfb25seSkKPiAgICAgICAgIGlmICghZXJyICYmIGZpeF9jdXJzZWdfd3JpdGVfcG9pbnRlciAm
JiAhZjJmc19yZWFkb25seShzYmktPnNiKSAmJgo+ICAgICAgICAgICAgICAgICAgICAgICAgIGYy
ZnNfc2JfaGFzX2Jsa3pvbmVkKHNiaSkpIHsKPiAgICAgICAgICAgICAgICAgZXJyID0gZjJmc19m
aXhfY3Vyc2VnX3dyaXRlX3BvaW50ZXIoc2JpKTsKPiArICAgICAgICAgICAgICAgaWYgKCFlcnIp
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZXJyID0gZjJmc19jaGVja193cml0ZV9wb2ludGVy
KHNiaSk7Cj4gICAgICAgICAgICAgICAgIHJldCA9IGVycjsKPiAgICAgICAgIH0KPgo+IC0tCj4g
Mi40My4wLnJjMi40NTEuZzg2MzFiYzc0NzItZ29vZwo+Cj4KPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5n
IGxpc3QKPiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZz
LWRldmVsCg==
