Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1966EC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0sBLktcMpbsNRFhqFrhfPOKwDweabYsS5+DDBf/Ixc=; b=SInJQs8rsjbVlZ3iOBGP87fEdD
	asddbhUT33B7qj+FB0QA4oC3JhG+LI5LtNM7XbAcmpymjj7pHvyuZUiOoFGV4HUvl2M+ufEJ1ABsH
	IVcn71WoWevAhUUSu37CTQtBzdxuHCFSbkFZq5hnhfE+BoMv2Nb7i/N173o4gQ/4XQZY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwVOf-00043T-Jm;
	Wed, 19 Aug 2026 01:47:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwVOe-00043M-9n
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 01:47:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qoQwe2sWJ0MbRaZViAD/nPZTyI4dpqFu3NiN2Dfommo=; b=YNSR6xfS4XxJd/0LBbbcqHNmMh
 Xly5shIPHS9wb0tgqeafq47KkUgJvC8wWNRiMXwVVdwcaL2s4Udt11h33K+AKynfIZImb+/Um2TVk
 NVXR9qzHjt1qHDOJCTi/9pAiGeWkS4s0r7HCQRO0grVbyV0wX2QBjM1LeMaJq2JENiPU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qoQwe2sWJ0MbRaZViAD/nPZTyI4dpqFu3NiN2Dfommo=; b=gTT/wUbSC+XqsU3ZtOEY5ySMWj
 w1Dt/r09wV0ZfuintrUUKKWFIx6gpkt5OmdiFDCjd/++FTrDgXXiXpTj7womshApKVQC39c0eqTh6
 7JwMukxcd1U2hmgC4Ek1eHHcRCyh98VvChJ7HUg27G4XM+e8ReTDRUC6WueixuCu9qeA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwVOd-00086l-15 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 01:47:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57A4F601DE;
 Wed, 19 Aug 2026 01:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07671F000E9;
 Wed, 19 Aug 2026 01:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787104029;
 bh=qoQwe2sWJ0MbRaZViAD/nPZTyI4dpqFu3NiN2Dfommo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=hgyO5vL78VktH1YqCIX6i9q2EYBTyZtVi2RDnzd8+kFcAqwNLJt1tb1hFMO0Io2Oi
 ASxrdfSL6fQ20VnwO1/AB9nHEKOiTtTzPNE1vT7KXWro5jwSHajqdCaK3TNXtBstu5
 /4zsvonEFoRPzEjAruGj02rsdbgf+bbWopaDJVtrUNcNyKDD2CxV7Zk1rwcqgROqRt
 U020kGYd1U3nH8oBdCzY/0UOEX1keJgykX7Q/DADONOWROEpw6cUlRsyBHuOlNCPWZ
 s24TIBKvT4vt3LcNsymho6CnpveFKVdCR0/3denWZkgGUaktMWmdV0X02rw6YsUutD
 KMevdVXED/i5g==
Message-ID: <f40d5ab3-0073-4af4-902a-f17548961638@kernel.org>
Date: Wed, 19 Aug 2026 09:47:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?7KCV7ISx7J6s?= <jsjlee1020@gmail.com>
References: <20260814105234.31620-1-jsjlee1020@gmail.com>
 <2a3d8702-f7fd-4013-8181-d9fd68b6aa18@kernel.org>
 <CAPHXVrzgPpxgAJrCmJ_Ro19AertMnqKfC1oW_y_FpbLoqO7nug@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPHXVrzgPpxgAJrCmJ_Ro19AertMnqKfC1oW_y_FpbLoqO7nug@mail.gmail.com>
X-Headers-End: 1wwVOd-00086l-15
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix O_DIRECT cleanup range for append
 writes
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8xOC8yNiAyMDoyMywg7KCV7ISx7J6sIHdyb3RlOgo+PiBJZiBnZW5lcmljX3dyaXRlX2No
ZWNrcygpIGNhbiBhZGp1c3Qgd3JpdGluZyBwb3NpdGlvbiBvciBhbW91bnQgb2YgYnl0ZXMKPj4g
dG8gd3JpdGUsIHNob3VsZG4ndCB3ZSBhY2Nlc3MgaW9jYi0+a2lfcG9zIGFuZCBpb3ZfaXRlcl9j
b3VudChmcm9tKSBhZnRlcgo+PiBnZW5lcmljX3dyaXRlX2NoZWNrcygpPwo+IAo+IFllcywgYWdy
ZWVkLiBnZW5lcmljX3dyaXRlX2NoZWNrcygpIGNhbiBhZGp1c3QgYm90aCBpb2NiLT5raV9wb3Mg
YW5kCj4gdGhlIGl0ZXJhdG9yIGNvdW50Lgo+IAo+IEkgbm90aWNlZCB0aGF0IHRoZSBwaW5uZWQg
ZmlsZSBvdmVyd3JpdGUgY2hlY2sgdXNlcyBwb3MgYW5kIGNvdW50Cj4gc2F2ZWQgYmVmb3JlIGYy
ZnNfd3JpdGVfY2hlY2tzKCkuIEkgcGxhbiB0byBrZWVwIHRoZSBjaGVjayBpbgo+IGYyZnNfZmls
ZV93cml0ZV9pdGVyKCksIGJ1dCBtb3ZlIGl0IGFmdGVyIGYyZnNfd3JpdGVfY2hlY2tzKCkgYW5k
IHVzZQo+IHRoZSBhZGp1c3RlZCBpb2NiLT5raV9wb3MgYW5kIGlvdl9pdGVyX2NvdW50KGZyb20p
LgoKWWVhaCwgSSB0aGluayBpdCdzIHRoZSBjb3JyZWN0IHdheS4KCj4gCj4gVGhpcyBhbHNvIGtl
ZXBzIHRoZSBjaGFuZ2UgbG9jYWwgdG8gZjJmc19maWxlX3dyaXRlX2l0ZXIoKSwgd2hlcmUgb3Ro
ZXIKPiBjaGVja3MgYXJlIGFscmVhZHkgcGVyZm9ybWVkIGFmdGVyIGYyZnNfd3JpdGVfY2hlY2tz
KCkuCj4gCj4gRm9yIHRoZSBidWZmZXJlZCBjbGVhbnVwLCBhcyBpbiBteSBvcmlnaW5hbCBwYXRj
aCwgSSBwbGFuIHRvIHNhdmUgdGhlCj4gYWRqdXN0ZWQgd3JpdGUgcG9zaXRpb24gYWZ0ZXIgZjJm
c193cml0ZV9jaGVja3MoKSBhbmQgdXNlIGl0IGZvcgo+IGYyZnNfZmx1c2hfYnVmZmVyZWRfd3Jp
dGUoKS4KPiAKPiBEb2VzIHRoaXMgYXBwcm9hY2ggbG9vayByZWFzb25hYmxlIHRvIHlvdT8KCkl0
IG1ha2Ugc2Vuc2UsIHBsZWFzZSBnbyBhaGVhZC4gOikKClRoYW5rcywKCj4gCj4gVGhhbmtzLAo+
IFNlb25namFlCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL2xpbnV4LWYyZnMtZGV2ZWwK
