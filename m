Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1143CA5FE4
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JgQsNphWhi7G8Rx0AK80fqWp8YYveuNEhBMrVAOA+W4=; b=O5BgW0zrjnh6mlQlnw4z7niJ6+
	afQWG+h7kpfrti7A60Bz17DZebqydlvbqqBAeSnbG65A7Ov7XpCi50mlkqOsAUTdIsprQJufHLrgP
	DQUThGGBRwZ5TMzrHap2r4ZpRjxDl//LBEkfbKEa39lBjnzbw1boTfDc73NxDJ+MGPOM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodw-0007AI-S3;
	Sat, 03 Oct 2026 01:34:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodv-0007AA-Gd
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dp8VyXTYCjr0888oCgwtHXQ7r5/vKbtII0vRpG6MkF0=; b=XGXjFgYP9nlqCE1SpDePFoKjg2
 obUzTlNdjHB1Gaf7VFljkHjtDhPiDnHx6M1GFm8zGaGgm6Ey7ExLu5QhDjHNcz9plAcmAxN6szuyY
 05/eRUTn/vvfXkW/d/Wk6RK+PvthYZH1Myl/TiaLZq7okbAdo9yguNtATnyCdQ92p7Es=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dp8VyXTYCjr0888oCgwtHXQ7r5/vKbtII0vRpG6MkF0=; b=Pm/4QiCs2ryFv3CLzDEAOcWJ9l
 jlxcPJKOlT/0mak0m+rlnnuD8ieP5UaMBaUIDqPrvvj+QfcDrsEq4gE3tGgg2mNc4z2A+97EFneyw
 Z+kgRJVf2qIZXLw8f3VTkopXkhC/BupQ/UV4MrwWZLN1Tqqmxkp5/yJgQL3ke8m5ZIQU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodv-0001jt-LZ for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C26C60DA2;
 Sat,  3 Oct 2026 01:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2691F00898;
 Sat,  3 Oct 2026 01:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991261;
 bh=dp8VyXTYCjr0888oCgwtHXQ7r5/vKbtII0vRpG6MkF0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O0Bz+tghKYNgdJNgETuU/RJsfd6hAvzLN943+lzM/yMkMM6ObeM5nhb+0vxXo6FqM
 EOe5tPdOR4p+dzcl5JCvZ75CgiB8PvsHKygOhytwPWN//5mgQgnGatBmFSLALKVhdM
 YFCIwUa+hNYFn7Oo2EDOvWCb4LaIHwlcWqTamaLr9kUQaGxJfZNOrLFK4i/aCErc7F
 Nmu4KW1nGD6veo74k1N4lpU6oTGiO1nsLNEFiMyFPd6iCR1fPEH3XZMoyNLORKcIZh
 vdQUcjbNmlnnammRD8niFqz+rRzdJm8Q22hf+UfQLc0D5gDG8b/C6oX672oEnew+IH
 37lKif0barwbw==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-15-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-15-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:21 +0000
Message-Id: <20261003013421.AC2691F00898@smtp.kernel.org>
X-Headers-End: 1xCodv-0001jt-LZ
Subject: Re: [f2fs-dev] [PATCH v17 14/21] xfs: don't remove written extents
 past EOF on fsverity inodes
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

PiB4ZnNfZnJlZV9lb2ZibG9ja3MoKSByZW1vdmVzIGFsbCBleHRlbnRzIHBhc3QgRU9GIHVubGVz
cyB0aGUKPiBYRlNfRElGTEFHX1BSRUFMTE9DIG9yIFhGU19ESUZMQUdfQVBQRU5EIGZsYWdzIGFy
ZSBzZXQuIFRoaXMgaXMKPiB1bmRlc2lyZWQgZm9yIGZzdmVyaXR5IGFzIGl0IHN0b3JlcyBtZXRh
ZGF0YSBiZXlvbmQgRU9GLiBIb3dldmVyLCB3aGlsZQo+IG1lcmtsZSB0cmVlIGlzIGJlaW5nIGJ1
aWx0LCBkZWxheWVkIHByZWFsbG9jYXRpb24gYW5kIHVud3JpdHRlbiBleHRlbnRzCj4gYXJlIHVz
ZWQuIEFmdGVyIG1ldGFkYXRhIGNvbnN0cnVjdGlvbiBpcyBkb25lLCBmc3Zlcml0eSBpbm9kZXMg
YmVjb21lcwo+IHJlYWQtb25seSBhbmQgd29uJ3QgYmUgY2hhbmdlZCBhbnltb3JlLCBub25lIG9m
IHRoZXNlIHVud3JpdHRlbiBleHRlbnRzCj4gb3IgcHJlYWxsb2NhdGlvbnMgaW4gcG9zdCBFT0Yg
cmVnaW9uIHdpbGwgYmUgdXNlZC4KPiAKPiBMZXQgeGZzX2ZyZWVfZW9mYmxvY2tzKCkgYmUgY2Fs
bGVkIG9uIGZzdmVyaXR5IGlub2RlIGFzIHVzdWFsIHRvIHJlbW92ZQo+IGFueXRoaW5nIHdoaWNo
IGlzIG5vdCB3cml0dGVuIGV4dGVudC4gSG93ZXZlciwgaW5vZGVzIHdoaWNoIGFyZQo+IHVuZGVy
Z29pbmcgbWVya2xlIHRyZWUgY29uc3RydWN0aW9uIG5lZWQgdG8gYmUgc2tpcHBlZCBpbiBjYXNl
IHJlY2xhaW0KPiB0YWtlcyBwbGFjZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgQWxiZXJz
aHRleW4gPGFhbGJlcnNoQGtlcm5lbC5vcmc+CgpTYXNoaWtvIGhhcyByZXZpZXdlZCB0aGlzIHBh
dGNoIGFuZCBmb3VuZCBubyBpc3N1ZXMuIEl0IGxvb2tzIGdyZWF0IQoKLS0gClNhc2hpa28gQUkg
cmV2aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTAwMjIyMzcwNS4y
MTc1NTQyLTEtYWFsYmVyc2hAa2VybmVsLm9yZz9wYXJ0PTE0CgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
