Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F1ED0BB5C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Oct 2024 11:02:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t3vcF-0003aR-Da;
	Thu, 24 Oct 2024 11:02:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1t3vcD-0003aE-N7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Oct 2024 11:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6+rBpU1fj2NO0Xxcw+tiXkle1Ph6NpAoy9Tv6zEpu5I=; b=NKXgJ9m2SkcHMlcQtW2c66sv+H
 3WAx8cpg+m+xTp8DcWvNqyx1orYtjGioqgOQi5idPNzcyXy4Fw3e1u34VARnoCbkqQhe7BljTAp9a
 gigIs4U75UxZJpBUWodZdh+uVepq0DPIoW24yj6B4ipTOPzl7sn1Fmm4pYOwLQhgAi/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6+rBpU1fj2NO0Xxcw+tiXkle1Ph6NpAoy9Tv6zEpu5I=; b=Q1ni36+JQS3/F84h9nvBe0PvRz
 vqXL1TCkmBYO6w3tl0fGF9rx8ZJlVzgrQ55B5vFvSj2vr7B74iPKe3Lyuoqu59wSeh7fFdKq8S7J5
 g3LbnhqEMzKztVy11oy+LDlljDZ1eQ+2o1t/hG/Hmb/6WVsos63H+vbJ+MDaL/oxWA+U=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1t3vcD-0002Gh-OZ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Oct 2024 11:02:54 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-37ece998fe6so79635f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Oct 2024 04:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729767762; x=1730372562; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+rBpU1fj2NO0Xxcw+tiXkle1Ph6NpAoy9Tv6zEpu5I=;
 b=LF5fL/y2t8kreskE0d9U0ilrPmIcttBgRmEZnyWeB0oN8pZpsjJzqDeaVdmNF3m1Qe
 QWEHvd6sabJs274LATbum8lR0dVZshXabU+c1nx/+bGgoNmtSmCrutatAHsAzsQkTQSi
 H2IPpzkD9r5DkRF0wjjjP1FrlChFiC9QP66XOe4Zbdj7kXARncSqLyp8mJRAvzkl/qtO
 kmcB5OGlkRtGbYzX9oBZQ47LrIHylrnRFYwV4EdV2WES3myVfRBHWZ6KSiyf//RcHi5S
 bpFekn9kcuhOrFQSN9d1w127CxnnbGxyWzrl9SGWAUTRS4DBdhEkej14XD9gb3jrSf4F
 1SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729767762; x=1730372562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+rBpU1fj2NO0Xxcw+tiXkle1Ph6NpAoy9Tv6zEpu5I=;
 b=AUjzGhBjcsC52fP4Bja9+chtULueKvvvSvE41+U4ABIlLfh4S5cvMqBVt94jPDtcIL
 N/WbtgPes9LMfIQnzAnWHcyuuM5ZyCFdRM7yIOQ98FY+hCLwYRffbzWFXeTIDZoMk1zD
 +Ghqh+EOoJegz29fcyPZ0pzA1Ck8w99iztHn+AfshbOyMaLMav8P+FdDUe0I9OlayKLy
 oWpjrAjMg2ovAnhBV/1LOuGH8zRQYmxF0RzEaOLBsWKfbjowSvQWLIPj0s+ZL4BfGIna
 o5Kk2PLHVkQcc2M1rBx6FFGc+1rJRNpUU85HUw/uGwZ6n7b4fg+W5X2TZd2PVPSGNE3/
 OqbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAQ9ITGqrKXkbbKU+aErAUqz62apF65Q2tBOiV0ksA93gxhpzgHJRvlxPJVYPnswLj7/MDkpf8xlo2qhQgF8N1@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx1oOdjXdeh5mMxdoSd1nBaE6B0iQ5qW2lTWdpO5LUx8WmCWafT
 FRvwrj1FcefQG/b8o/dCe59+wtSb3FcddyD9CPcVWu/4+4RuWcAn6G8jAs3DmC+46LCl/D6R6tl
 vygOTSFguvwwiEaRaTlDEg9ZIBwM=
X-Google-Smtp-Source: AGHT+IH4JGHzRb9jWikDVpbBK3rDzevf9xVNgbJpgC4gFDTY1gFQUQh8FiT//xXAS+ix8wGJO5lE2iFrUjY9jm7bb08=
X-Received: by 2002:a5d:47c2:0:b0:374:cc10:bb42 with SMTP id
 ffacd0b85a97d-37efcef323fmr1802100f8f.2.1729767761844; Thu, 24 Oct 2024
 04:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <1729652883-12202-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1729652883-12202-1-git-send-email-zhiguo.niu@unisoc.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 24 Oct 2024 19:02:30 +0800
Message-ID: <CAHJ8P3+kKayoWk8B6JQ66vC9LGxoWP-pDDGtkF-MQcJG3OS3xQ@mail.gmail.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1t3vcD-0002Gh-OZ
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: fix to avoid use GC_AT when setting
 gc_mode as GC_URGENT_LOW or GC_URGENT_MID
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RGVhciBDaGFvLAphbnkgc3VnZ2VzdGlvbnMgYWJvdXQgdGhpcyBwYXRjaCB2ZXJzaW9uPyBiYXNl
IHlvdXIga2luZGx5IHN1Z2dlc3Rpb25zCm9uIHBhdGNoIHYxCnRoaXMgaXMgdGhlIGlzc3VlIGVu
Y291bnRlcmVkIHdoZW4gSSB0ZXN0IEdDLgp0aGFua3MhCgpaaGlndW8gTml1IDx6aGlndW8ubml1
QHVuaXNvYy5jb20+IOS6jjIwMjTlubQxMOaciDIz5pel5ZGo5LiJIDExOjA45YaZ6YGT77yaCj4K
PiBJZiBnY19tb2RlIGlzIHNldCB0byBHQ19VUkdFTlRfTE9XIG9yIEdDX1VSR0VOVF9NSUQsIGNv
c3QgYmVuZWZpdCBHQwo+IGFwcHJvYWNoIHNob3VsZCBiZSB1c2VkLCBidXQgaWYgQVRHQyBpcyBl
bmFibGVkIGF0IHRoZSBzYW1lIHRpbWUsCj4gQWdlLXRocmVzaG9sZCBhcHByb2FjaCB3aWxsIGJl
IHNlbGVjdGVkLCB3aGljaCBjYW4gb25seSBkbyBhbW91bnQgb2YKPiBHQyBhbmQgaXQgaXMgbXVj
aCBsZXNzIHRoYW4gdGhlIG51bWJlcnMgb2YgQ0IgYXBwcm9hY2guCj4KPiBzb21lIHRyYWNlczoK
PiAgIGYyZnNfZ2MtMjU0OjQ4LTM5NiAgICAgWzAwN10gLi4uLi4gMjMxMTYwMC42ODQwMjg6IGYy
ZnNfZ2NfYmVnaW46IGRldiA9ICgyNTQsNDgpLCBnY190eXBlID0gQmFja2dyb3VuZCBHQywgbm9f
YmFja2dyb3VuZF9HQyA9IDAsIG5yX2ZyZWVfc2VjcyA9IDAsIG5vZGVzID0gMTA1MywgZGVudHMg
PSAyLCBpbWV0YSA9IDE4LCBmcmVlX3NlYzo0NDg5OCwgZnJlZV9zZWc6NDQ4OTgsIHJzdl9zZWc6
MjM5LCBwcmVmcmVlX3NlZzowCj4gICBmMmZzX2djLTI1NDo0OC0zOTYgICAgIFswMDddIC4uLi4u
IDIzMTE2MDAuNjg0NTI3OiBmMmZzX2dldF92aWN0aW06IGRldiA9ICgyNTQsNDgpLCB0eXBlID0g
Tm8gVFlQRSwgcG9saWN5ID0gKEJhY2tncm91bmQgR0MsIExGUy1tb2RlLCBBZ2UtdGhyZXNob2xk
KSwgdmljdGltID0gMTAsIGNvc3QgPSA0Mjk0MzY0OTc1LCBvZnNfdW5pdCA9IDEsIHByZV92aWN0
aW1fc2Vjbm8gPSAtMSwgcHJlZnJlZSA9IDAsIGZyZWUgPSA0NDg5OAo+ICAgZjJmc19nYy0yNTQ6
NDgtMzk2ICAgICBbMDA3XSAuLi4uLiAyMzExNjAwLjcxNDgzNTogZjJmc19nY19lbmQ6IGRldiA9
ICgyNTQsNDgpLCByZXQgPSAwLCBzZWdfZnJlZWQgPSAwLCBzZWNfZnJlZWQgPSAwLCBub2RlcyA9
IDE1NjIsIGRlbnRzID0gMiwgaW1ldGEgPSAxOCwgZnJlZV9zZWM6NDQ4OTgsIGZyZWVfc2VnOjQ0
ODk4LCByc3Zfc2VnOjIzOSwgcHJlZnJlZV9zZWc6MAo+ICAgZjJmc19nYy0yNTQ6NDgtMzk2ICAg
ICBbMDA3XSAuLi4uLiAyMzExNjAwLjcxNDg0MzogZjJmc19iYWNrZ3JvdW5kX2djOiBkZXYgPSAo
MjU0LDQ4KSwgd2FpdF9tcyA9IDUwLCBwcmVmcmVlID0gMCwgZnJlZSA9IDQ0ODk4Cj4gICBmMmZz
X2djLTI1NDo0OC0zOTYgICAgIFswMDddIC4uLi4uIDIzMTE2MDAuNzcxNzg1OiBmMmZzX2djX2Jl
Z2luOiBkZXYgPSAoMjU0LDQ4KSwgZ2NfdHlwZSA9IEJhY2tncm91bmQgR0MsIG5vX2JhY2tncm91
bmRfR0MgPSAwLCBucl9mcmVlX3NlY3MgPSAwLCBub2RlcyA9IDE1NjIsIGRlbnRzID0gMiwgaW1l
dGEgPSAxOCwgZnJlZV9zZWM6NDQ4OTgsIGZyZWVfc2VnOjQ0ODk4LCByc3Zfc2VnOjIzOSwgcHJl
ZnJlZV9zZWc6Cj4gICBmMmZzX2djLTI1NDo0OC0zOTYgICAgIFswMDddIC4uLi4uIDIzMTE2MDAu
NzcyMjc1OiBmMmZzX2djX2VuZDogZGV2ID0gKDI1NCw0OCksIHJldCA9IC02MSwgc2VnX2ZyZWVk
ID0gMCwgc2VjX2ZyZWVkID0gMCwgbm9kZXMgPSAxNTYyLCBkZW50cyA9IDIsIGltZXRhID0gMTgs
IGZyZWVfc2VjOjQ0ODk4LCBmcmVlX3NlZzo0NDg5OCwgcnN2X3NlZzoyMzksIHByZWZyZWVfc2Vn
OjAKPgo+IEZpeGVzOiAwZTVlODExMTRkZTEgKCJmMmZzOiBhZGQgR0NfVVJHRU5UX0xPVyBtb2Rl
IGluIGdjX3VyZ2VudCIpCj4gRml4ZXM6IGQ5OGFmNWY0NTUyMCAoImYyZnM6IGludHJvZHVjZSBn
Y191cmdlbnRfbWlkIG1vZGUiKQo+IFNpZ25lZC1vZmYtYnk6IFpoaWd1byBOaXUgPHpoaWd1by5u
aXVAdW5pc29jLmNvbT4KPiAtLS0KPiB2MjogbWFrZSBHQ19VUkdFTlRfTE9XIGFsc28gdXNlIENC
IGFwcHJvYWNoCj4gLS0tCj4gIGZzL2YyZnMvZ2MuYyB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZ2MuYyBiL2ZzL2YyZnMv
Z2MuYwo+IGluZGV4IGU0MGJkZDEuLjNlMWI2ZDIgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9nYy5j
Cj4gKysrIGIvZnMvZjJmcy9nYy5jCj4gQEAgLTI1Nyw2ICsyNTcsOCBAQCBzdGF0aWMgaW50IHNl
bGVjdF9nY190eXBlKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgaW50IGdjX3R5cGUpCj4KPiAg
ICAgICAgIHN3aXRjaCAoc2JpLT5nY19tb2RlKSB7Cj4gICAgICAgICBjYXNlIEdDX0lETEVfQ0I6
Cj4gKyAgICAgICBjYXNlIEdDX1VSR0VOVF9MT1c6Cj4gKyAgICAgICBjYXNlIEdDX1VSR0VOVF9N
SUQ6Cj4gICAgICAgICAgICAgICAgIGdjX21vZGUgPSBHQ19DQjsKPiAgICAgICAgICAgICAgICAg
YnJlYWs7Cj4gICAgICAgICBjYXNlIEdDX0lETEVfR1JFRURZOgo+IC0tCj4gMS45LjEKPgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMt
ZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwK
