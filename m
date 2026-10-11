Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E0CA9EC7
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 08:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fnaRUL99kCixcTy06KqxOsjsmzENztLy04rf2MAVKCw=; b=CyxuXxp/Lbk0c3G1othWluWf/F
	kSDC0OJs62IzcEyftsgbEPn1wNaRvTb5pkAFTN+nJsIL5qZdHUE78UsbzBJulsZnp9jLlVLKmwxuy
	4jNu94VWxblYq0iRunOq3UxfFd7xpInXHDIbm67RNqfnKFqlP/xqQrxvxr6TCiAAyKpo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFoxe-00079o-VS;
	Sun, 11 Oct 2026 08:31:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFoxe-00079i-7r
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 08:31:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FCNJ5i6bslo+im/y7a9u+NMO84y1l/5W4Y7QyLBVlNM=; b=KigbIA5fvg3NRsD7z/qRgL8iLd
 r04vPieXf/lRzk+dtboiiHtLbT0ii99ZLd1r3DiV32ZDhR6wxmSVvUo/7IyW9gH1PI9lZ54Olh1D3
 mIUPCO7cQ9w20Pzb9BdqmMykTufEDygbK4ffdtg9/A/xcqAifmqgIim1aagvUs11Ecos=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FCNJ5i6bslo+im/y7a9u+NMO84y1l/5W4Y7QyLBVlNM=; b=GKDXyWKcPqJiU5HFvYhZiYbLse
 e9/SdPk/AJw23jB1mkdvuhRtHscmxiG60VtV4b+Vh9C3362ebuNd4781E0xJ5kAo2kronX4XVqHxK
 iVdaslYOuU7k3mt1pDjxAA4xLGQohJU9Ry9X2Xfz6taNvcQVhk0y+tMGJSU7S49EKwIE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFoxd-0005Xh-JY for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 08:31:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 266AF41E73;
 Sun, 11 Oct 2026 08:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0361C1F0089B;
 Sun, 11 Oct 2026 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791707468;
 bh=FCNJ5i6bslo+im/y7a9u+NMO84y1l/5W4Y7QyLBVlNM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ldrFaKSlYSPuuqD1l60qLVBpOHr1vY1ptE6FwgZiy1D430nh6HeQrMFxJyJsLPeM/
 oXcFfwkXlk7nvvplaJXlymtfFjXrP9z8PRvwSSSXvBC7u7Cy7g6OsBwISZXTFGh8Dn
 byZ7nIAOOqmeFjCaaRlpXr9r8sq1ru3suTXXgi2j+Oe9JUwWHUVZUrKPE34rhe+Bz9
 Qf0m9C8gYptRdFMgfGFOychtM5Uvdjzoi8Z0mXEo0glIOp90QsmjEwvGbpp0ok4H33
 tBzfaEhv0/9F4lDgm4YpK2qQx3bpFumxlFj5y9ETI87bCaZdkJwNPJRR0kGP4a8L3w
 oVG7O7f3kyLZQ==
Message-ID: <2ae11ebc-dd27-409f-9b9f-a153fe310178@kernel.org>
Date: Sun, 11 Oct 2026 16:31:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joanne Chang <joannechien@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261009095335.749891-1-joannechien@google.com>
Content-Language: en-US
In-Reply-To: <20261009095335.749891-1-joannechien@google.com>
X-Headers-End: 1xFoxd-0005Xh-JY
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: allow pinning empty compressed files
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMTAvOS8yNiAxNzo1MywgSm9hbm5lIENoYW5nIHdyb3RlOgo+IENvbW1pdCBhNjRhM2ZlYzEx
ZTcgKCJmMmZzOiBmb3JjZSBvdXQtcGxhY2UgdXBkYXRlIGZvciBhbGwgd3JpdGVzIG9uCj4gY29t
cHJlc3NlZCBmaWxlIikgdXBkYXRlZCBmMmZzX3Nob3VsZF91cGRhdGVfb3V0cGxhY2UoKSB0byBh
bHdheXMKPiByZXR1cm4gdHJ1ZSBmb3IgY29tcHJlc3NlZCBmaWxlcy4gSG93ZXZlciwgdGhpcyBm
dW5jdGlvbiBpcyBhbHNvCj4gY2FsbGVkIGR1cmluZyBmMmZzX2lvY19zZXRfcGluX2ZpbGUoKSB2
YWxpZGF0aW9uLCBzbyBwaW5uaW5nIGFuCj4gZW1wdHkgZmlsZSB3aXRoIGNvbXByZXNzaW9uIGVu
YWJsZWQgbm93IGZhaWxzIHdpdGggLUVJTlZBTCBiZWZvcmUgdGhlCj4gY29tcHJlc3Npb24gZmxh
ZyBjYW4gYmUgc3RyaXBwZWQuCgpKb2FubmUsCgpUaGFua3MgZm9yIHRoZSBwYXRjaC4KCkJ1dCwg
SSB0aGluayBpdCdzIGFzIGV4cGVjdGVkLCB3ZSBmb3JjZSBjb21wcmVzc2VkIGZpbGUgdG8gT1BV
LCBhbmQgcGluZmlsZQp0byBJUFUsIGl0J3MgY29uZmxpY3QuCgpMZXQgbWUga25vdyBpZiBJIG1p
c3NlZCBzb21ldGhpbmcuCgpUaGFua3MsCgo+IAo+IEZpeCB0aGlzIGJ5IGd1YXJkaW5nIHRoZSBm
MmZzX2NvbXByZXNzZWRfZmlsZShpbm9kZSkgY2hlY2sgd2l0aCBmaW8gaW4KPiBmMmZzX3Nob3Vs
ZF91cGRhdGVfb3V0cGxhY2UoKS4gVGhpcyBwcmVzZXJ2ZXMgZm9yY2VkIE9QVSBmb3IgYWN0dWFs
Cj4gY29tcHJlc3NlZCB3cml0ZXMgKGZpbyAhPSBOVUxMKSwgd2hpbGUgYWxsb3dpbmcgZjJmc19p
b2Nfc2V0X3Bpbl9maWxlKCkKPiAoZmlvID09IE5VTEwpIHRvIHByb2NlZWQgdG8gZjJmc19kaXNh
YmxlX2NvbXByZXNzZWRfZmlsZShpbm9kZSkuCj4gCj4gRml4ZXM6IGE2NGEzZmVjMTFlNyAoImYy
ZnM6IGZvcmNlIG91dC1wbGFjZSB1cGRhdGUgZm9yIGFsbCB3cml0ZXMgb24gY29tcHJlc3NlZCBm
aWxlIikKPiBBc3Npc3RlZC1ieTogTExNCj4gU2lnbmVkLW9mZi1ieTogSm9hbm5lIENoYW5nIDxq
b2FubmVjaGllbkBnb29nbGUuY29tPgo+IC0tLQo+ICAgZnMvZjJmcy9kYXRhLmMgfCAyICstCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvZnMvZjJmcy9kYXRhLmMgYi9mcy9mMmZzL2RhdGEuYwo+IGluZGV4IDI2MTNlODgy
MWFmNi4uMWQwNzFlN2NiMWMyIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvZGF0YS5jCj4gKysrIGIv
ZnMvZjJmcy9kYXRhLmMKPiBAQCAtMzE1MCw3ICszMTUwLDcgQEAgYm9vbCBmMmZzX3Nob3VsZF91
cGRhdGVfb3V0cGxhY2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGYyZnNfaW9faW5mbyAq
ZmlvKQo+ICAgCSAqIElmIElPIGNvbWVzIGZyb20gY29tcHJlc3NlZCB3cml0ZSBwYXRoIGFuZCBm
YWxsYmFjayB0byByYXcgd3JpdGUsCj4gICAJICogZm9yY2Ugb3V04oCRcGxhY2UgdG8gcHJldmVu
dCBtZXRhZGF0YeKAkWRhdGEgaW5jb25zaXN0ZW5jeS4KPiAgIAkgKi8KPiAtCWlmIChmMmZzX2Nv
bXByZXNzZWRfZmlsZShpbm9kZSkpCj4gKwlpZiAoZmlvICYmIGYyZnNfY29tcHJlc3NlZF9maWxl
KGlub2RlKSkKPiAgIAkJcmV0dXJuIHRydWU7Cj4gICAKPiAgIAkvKiBzd2FwIGZpbGUgaXMgbWln
cmF0aW5nIGluIGFsaWduZWQgd3JpdGUgbW9kZSAqLwoKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApM
aW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
