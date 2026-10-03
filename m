Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6F4CA5FE9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUKKlR/q4QwYfjlz74PAfTFbyHm7hhwX+2DRElE07dg=; b=gN0p7BU2bBlE/LYDmVX/0DMp1J
	uIFCDi6LvD+nDPuZfj0ztrbCzhivKVqb2lmf0Q1QtlAQoagrKcLg6UnVTjgo4wHhL4I9gAUTp1FkK
	tNdoCgSfdBVvK01/7eflAl6p7xTWeiIgfpCsVn25tZgPh+RY8wEZGHP3/4qQepSQY8m0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCoe4-0004EP-8h;
	Sat, 03 Oct 2026 01:34:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCoe0-0003u4-Pg
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DbIzpBVN3WRd7NTzQMjDbnLE/zFKPQ+K6jvKXl2+ERU=; b=giR6f5CJ52dT92bqcKqOyLMmie
 b9KRjGJaZVA9LwhDTZHuHPOf0sC60HjkWHekIXqzIs9J2i5KbgOePshDVw7b8bLZbN6wiLlbxtiRS
 o6K4OnOTksQfdqt/KFoZ8pZB3Tj1JpthWj+Brs+1HvI4LGCNtmzjFyiRUUUZxsLnTVGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DbIzpBVN3WRd7NTzQMjDbnLE/zFKPQ+K6jvKXl2+ERU=; b=jSn/+yzGMzsZF7Y0bCeJPC/uVl
 cUddBNaBxxy5Mn53UwiQj3nA4wpyNCEcmMS7N/iyoAE+qTtFRMOzelHtTq+D+aSWgEnTGqI+E2k+r
 MYiv+2PDxRUj9g5crOMBNED4ddrfZLvc2IWfweRZRtpg6+bO+XUSDTLm/nYYjFwIws5I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodx-0001k3-M9 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66453407FD;
 Sat,  3 Oct 2026 01:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BC41F000FF;
 Sat,  3 Oct 2026 01:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991264;
 bh=DbIzpBVN3WRd7NTzQMjDbnLE/zFKPQ+K6jvKXl2+ERU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jPyo05PwPwv2tk+Mbzf8HcytvfQvPKrmMF9mN1+yH0DUBcBje8Swqf55aH8iZInnm
 HLIy2WH5eckZt4iz8A2oAMT6SIaLaqxrUyFn6zMebKngruj1JXWdZRjsXjmjBjbXOY
 j40HaU+B6tqhLPOY4jjmPi1kysJ+Gsu0vMnRMtMkEnBqbySry7dzkBkZstlF8Lbg7b
 /GiqwMA5ow/qh/hLk862lIHttlNORUAs2TjgNWHQ6kUIgTeC7Sck3O6lqkPtfk03s4
 VBldvUTyB4+x/LTkleQHZjTTrH7ZI+IVKzi/4BaHx1Z+Ag3fW4//gd+3lPeMj7xIZN
 7f9voUaEFjw5Q==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-20-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-20-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:23 +0000
Message-Id: <20261003013424.08BC41F000FF@smtp.kernel.org>
X-Headers-End: 1xCodx-0001k3-M9
Subject: Re: [f2fs-dev] [PATCH v17 19/21] xfs: check and repair the verity
 inode flag state
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
From: sashiko-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
 dsterba@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

VGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQg
MSBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6Ci0gW01lZGl1bV0geGZzOiBzY3J1YiBh
Ym9ydHMgb24gZnN2ZXJpdHkgdmFsaWRhdGlvbiBlcnJvcnMgLUVJTlZBTCBhbmQgLUVGQklHCi0t
Cgpjb21taXQgODU2ZDQ0ODg3NjllMjFhYjExMTg4ZGUyY2QzNDhiMmMyYjljYjYzMQpBdXRob3I6
IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+Cgp4ZnM6IGNoZWNrIGFuZCByZXBh
aXIgdGhlIHZlcml0eSBpbm9kZSBmbGFnIHN0YXRlCgpJZiBhbiBpbm9kZSBoYXMgdGhlIGluY29y
ZSB2ZXJpdHkgaWZsYWcgc2V0LCBtYWtlIHN1cmUgdGhhdCB3ZSBjYW4KYWN0dWFsbHkgYWN0aXZh
dGUgZnN2ZXJpdHkgb24gdGhhdCBpbm9kZS4gIElmIGFjdGl2YXRpb24gZmFpbHMgZHVlIHRvCmEg
ZnN2ZXJpdHkgbWV0YWRhdGEgdmFsaWRhdGlvbiBlcnJvciwgY2xlYXIgdGhlIGZsYWcuCgo+IGRp
ZmYgLS1naXQgYS9mcy94ZnMvc2NydWIvY29tbW9uLmMgYi9mcy94ZnMvc2NydWIvY29tbW9uLmMK
PiBpbmRleCBlNTIzM2UzMWFiYjc1Li5lYmJlZjNhZmI3ZDZlIDEwMDY0NAo+IC0tLSBhL2ZzL3hm
cy9zY3J1Yi9jb21tb24uYwo+ICsrKyBiL2ZzL3hmcy9zY3J1Yi9jb21tb24uYwpbIC4uLiBdCj4g
QEAgLTE3NTQsMyArMTc1Niw1NCBAQCB4Y2hrX2lub2RlX2NvdW50X2Jsb2NrcygKPiAgCXJldHVy
biB4ZnNfYm1hcF9jb3VudF9ibG9ja3Moc2MtPnRwLCBzYy0+aXAsIHdoaWNoZm9yaywgbmV4dGVu
dHMsCj4gIAkJCWNvdW50KTsKPiAgfQo+ICsKPiArLyoKPiArICogSWYgdGhpcyBpbm9kZSBoYXMg
U19WRVJJVFkgc2V0IG9uIGl0LCByZWFkIHRoZSB2ZXJpdHkgaW5mby4gSWYgdGhlIHJlYWRpbmcK
PiArICogZmFpbHMgd2l0aCBhbnl0aGluZyBvdGhlciB0aGFuIEVOT01FTSwgdGhlIGZpbGUgaXMg
Y29ycnVwdCwgd2hpY2ggd2UgY2FuCj4gKyAqIGRldGVjdCBsYXRlciB3aXRoIGZzdmVyaXR5X2Fj
dGl2ZS4KPiArICoKPiArICogQ2FsbGVycyBtdXN0IGhvbGQgdGhlIElPTE9DSyBhbmQgbXVzdCBu
b3QgaG9sZCB0aGUgSUxPQ0sgb2Ygc2MtPmlwIGJlY2F1c2UKPiArICogYWN0aXZhdGlvbiByZWFk
cyBpbm9kZSBkYXRhLgo+ICsgKi8KPiAraW50Cj4gK3hjaGtfaW5vZGVfc2V0dXBfdmVyaXR5KAo+
ICsJc3RydWN0IHhmc19zY3J1Ygkqc2MpCj4gK3sKPiArCWludAkJCWVycm9yOwo+ICsKPiArCWlm
ICghZnN2ZXJpdHlfYWN0aXZlKFZGU19JKHNjLT5pcCkpKQo+ICsJCXJldHVybiAwOwo+ICsKPiAr
CWVycm9yID0gZnN2ZXJpdHlfZW5zdXJlX3Zlcml0eV9pbmZvKFZGU19JKHNjLT5pcCkpOwo+ICsJ
c3dpdGNoIChlcnJvcikgewo+ICsJY2FzZSAwOgo+ICsJCS8qIGZzdmVyaXR5IGlzIGFjdGl2ZSAq
Lwo+ICsJCWJyZWFrOwo+ICsJY2FzZSAtRU5PREFUQToKPiArCWNhc2UgLUVNU0dTSVpFOgo+ICsJ
Y2FzZSAtRUZTQ09SUlVQVEVEOgo+ICsJY2FzZSAtRVJBTkdFOgo+ICsJY2FzZSAtRUJBRE1TRzoK
PiArCQkvKgo+ICsJCSAqIFRoZSBub256ZXJvIGVycm5vIGNvZGVzIGFib3ZlIGFyZSB0aGUgZXJy
b3IgY29kZXMgdGhhdCBjYW4KPiArCQkgKiBiZSByZXR1cm5lZCBmcm9tIGZzdmVyaXR5IG9uIG1l
dGFkYXRhIHZhbGlkYXRpb24gZXJyb3JzLgo+ICsJCSAqLwo+ICsJCXJldHVybiAwOwo+ICsJZGVm
YXVsdDoKPiArCQkvKiBydW50aW1lIGVycm9ycyAqLwo+ICsJCXJldHVybiBlcnJvcjsKPiArCX0K
CltTZXZlcml0eTogTWVkaXVtXQpTaG91bGQgLUVJTlZBTCBhbmQgLUVGQklHIGJlIGluY2x1ZGVk
IGluIHRoZSBhbGxvd2VkIHZhbGlkYXRpb24gZXJyb3IgY29kZXM/CgpBIGNvcnJ1cHRlZCBmc3Zl
cml0eSBkZXNjcmlwdG9yIG9uIGRpc2sgY2FuIHRyaWdnZXIKdmFsaWRhdGVfZnN2ZXJpdHlfZGVz
Y3JpcHRvcigpIHRvIHJldHVybiAtRUlOVkFMIG9yCmZzdmVyaXR5X2luaXRfbWVya2xlX3RyZWVf
cGFyYW1zKCkgdG8gcmV0dXJuIC1FRkJJRy4KCkJlY2F1c2UgdGhleSBhcmUgb21pdHRlZCBmcm9t
IHRoaXMgc3dpdGNoIHN0YXRlbWVudCwgdGhleSBmYWxsIHRocm91Z2ggdG8gdGhlCmRlZmF1bHQg
Y2FzZSBhbmQgcmV0dXJuIHRoZSBlcnJvciwgYWJvcnRpbmcgdGhlIHNjcnViIHNldHVwIGluc3Rl
YWQgb2YKZ3JhY2VmdWxseSBtYXJraW5nIHRoZSBpbm9kZSBhcyBicm9rZW4gYW5kIGNvbnRpbnVp
bmcgdGhlIHJlcGFpciBwaXBlbGluZS4KCi0tIApTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczov
L3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjEwMDIyMjM3MDUuMjE3NTU0Mi0xLWFhbGJlcnNo
QGtlcm5lbC5vcmc/cGFydD0xOQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
