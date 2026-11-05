Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB27606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=f9IcYLq2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=C11S7GlO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GTJdp39L;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmEA6gJ6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Date:References:In-Reply-To:To:Message-ID:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ks1eXra3KK6L4ygyPj9heJH+xHvGa0DLsTPju6S8ECs=; b=f9IcYLq2R7GhKKabno4i1gkbnj
	I6WgcUEKDGEr2TUdBfKgnW+dxnpWFFh5Ifyss56/pf4LX+GFmGZ5xU2Y60zlAYJpS69Y30mJSwoWA
	iupuHKGO0yvgmQoIFWrAjyS+kcs0f/dr6I7SLgBIHa+ZFYTEiDH//AmDJWWhRyLZSGTM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOwCl-000000003il-1Xna;
	Thu, 05 Nov 2026 12:04:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <sashiko-bot@kernel.org>) id 1xOwCj-000000003gl-1Htc
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Date:Content-Transfer-Encoding:Content-Type:
 References:In-Reply-To:Cc:To:Reply-To:Subject:From:Message-ID:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=BD7l9yO/ye2/Qj7a8/wZw8zRvBFJtyyeadiv5aaacGM=; b=C11S7GlOm2lZ
 B2PBu4sdlbwsmwjIvKa/blaknaJWuEg2q6FPpc3s45TXbAdukLgBhNoOyxANsE2YAbgKLs2adXyV6
 xE9G8jcxX9HDJDoJoUkXQqlpyjnz4cXOB/PsjFAHBbEvHVuEdE3OPyETTMKLtP0ZxWOG3iG8m1hF2
 ESW3E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:
 Reply-To:Subject:From:Message-ID:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BD7l9yO/ye2/Qj7a8/wZw8zRvBFJtyyeadiv5aaacGM=; b=GTJdp39Lq1GQdz0bR4nyEIvGZO
 mln7D8Dl2UnrXUGL/HruoAuekWqwb6yU1zEzQzFgEicb52mF613EYX+64cEUq6b+fGAykgu+skGOC
 VQWUlUuJ+dI3UrYUuYTgdLmhsfO3r+QVxEsJG9M+krWOyUjwMwjhOaCEVxuzxa2vlOPQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOwCK-000000002R5-2MZs
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:04:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06C34602C3;
 Thu,  5 Nov 2026 12:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3FE1F000C1;
 Thu,  5 Nov 2026 12:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793880238;
 bh=BD7l9yO/ye2/Qj7a8/wZw8zRvBFJtyyeadiv5aaacGM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AmEA6gJ6kfLXJvWBDkwHxr+05lYdcOabYVdHH4F8yahX1Hsap97fiRVJX/r0GTIx8
 pJKqIJhYOkYnJh1UUdg5bGvrifrOnowPDyRbRWN+ZkhFChXXx6XuaQTzj0VTGArD/v
 6Lf/FWZofG13EuyZhJ4DM5R2EffoNe6Gp5veV8a5C3t663Y4h2+S3KM8WH7NdLpxU0
 sQNyO0yNjv9OLqNWq+FC3Q5XY1UcqqyGsYvU2mZquT57btxFVc64sFJYraSJVEvvSt
 bvjtl3p2inqWl8tswbvxNknbDRiSmiCNLIk6Gkvcrt5t39tbHDMvHv0XdHfBPP1iiF
 vRiKOVZlwwTWQ==
Message-ID: <sashiko-outbox-198988@kernel.org>
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261105115532.613467-3-aalbersh@kernel.org>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-3-aalbersh@kernel.org>
Date: Thu, 05 Nov 2026 12:03:58 +0000
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOwCK-000000002R5-2MZs
Subject: Re: [f2fs-dev] [PATCH v2 2/5] fsverity: add I_VERITY_BUILDING inode
 state flag
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: sashiko-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBFdmVyeSBmaWxlc3lzdGVtIHRoYXQgc3VwcG9ydHMgZnMtdmVyaXR5IGtlZXBzIGEgcHJpdmF0
ZSBydW50aW1lIGlub2RlCj4gZmxhZyBtZWFuaW5nIE1lcmtsZSB0cmVlIGlzIGN1cnJlbnRseSBi
ZWluZyBidWlsdCAqX1ZFUklUWV9JTl9QUk9HUkVTUy4KPiBUaGV5IGFsbCBzZXJ2ZSB0aGUgc2Ft
ZSB0d28gcHVycG9zZXM6IHJlamVjdCBhIGNvbmN1cnJlbnQgZW5hYmxlIHdpdGgKPiAtRUJVU1kg
YW5kIGxldCB0aGUgd3JpdGUgcGF0aHMgcmVjb2duaXplIHRoZSBzcGVjaWFsIHdyaXRlcyBkb25l
IHdoaWxlCj4gdGhlIHRyZWUgaXMgdW5kZXIgY29uc3RydWN0aW9uLgo+IAo+IEhvaXN0IHRoaXMg
ZmxhZyBpbnRvIHRoZSBWRlMgYXMgYSBuZXcgaW5vZGUgc3RhdGUgZmxhZywKPiBJX1ZFUklUWV9C
VUlMRElORywgYW5kIG1hbmFnZSBpdHMgbGlmZXRpbWUgaW4gdGhlIGdlbmVyaWMgZnMtdmVyaXR5
Cj4gZW5hYmxlIHBhdGguIFRoZSBmbGFnIGlzIHNldCBhZnRlciAtPmJlZ2luX2VuYWJsZV92ZXJp
dHkoKSBzdWNjZWVkcyBhbmQKPiBjbGVhcmVkIGFmdGVyIC0+ZW5kX2VuYWJsZV92ZXJpdHkoKSBy
ZXR1cm5zIChib3RoIG9uIHRoZSBzdWNjZXNzIGFuZCB0aGUKPiByb2xsYmFjayBwYXRocykuIEFk
ZCB0aGUgY29uY3VycmVudC1lbmFibGUgZ3VhcmQuCj4gCj4gQSBuZXcgaGVscGVyLCBmc3Zlcml0
eV9pc19idWlsZGluZygpLCBpcyBwcm92aWRlZCBmb3IgZmlsZXN5c3RlbXMgdG8KPiBxdWVyeSB0
aGUgZmxhZy4gTm8gZmlsZXN5c3RlbSB1c2VzIGl0IHlldDsgdGhlIHBlci1mcyBmbGFncyBhcmUK
PiBjb252ZXJ0ZWQgaW4gZm9sbG93aW5nIHBhdGNoZXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogQW5k
cmV5IEFsYmVyc2h0ZXluIDxhYWxiZXJzaEBrZXJuZWwub3JnPgoKU2FzaGlrbyBoYXMgcmV2aWV3
ZWQgdGhpcyBwYXRjaCBhbmQgZm91bmQgbm8gaXNzdWVzLgoKLS0gClNhc2hpa28gQUkgcmV2aWV3
IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTEwNTExNTUzMi42MTM0Njct
MS1hYWxiZXJzaEBrZXJuZWwub3JnP3BhcnQ9MgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
