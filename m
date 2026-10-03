Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE3DCA5FE2
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QzdCKsIXF6cVe3NulHq+ODscyOU0TezAOfgyy1bSysU=; b=DZGqJgrDLrit2MfrNyBf6p22HF
	q9NTRu+YpaUyujWcMnjNkbiEcqGtzGJG+jhFMdJ+lkCWMa4gkqxEGpSX9li5863Rs+fKwpg2Jf/5q
	+4OiF9ZyjBh5u9wGKm3CuZ0pma5ZmXNP/b0Xp1vxkR3aKfd2YEoO/ulhhbOpGy5Yyjnc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodm-00064q-R4;
	Sat, 03 Oct 2026 01:34:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodl-00064Z-Db
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RGiHbsQAzr00/PQscUywtgDahe38a7wI2DyeGVG0f0o=; b=bsDwQz3yOsR8TMjRQFGp0uyAd0
 Ws4yPeXXZ5BnQcOzdZoGQvR4sD9vHlJ1chlDt+fcaacdSMF5majN+rrcBhuQYw4lxkrqnTbZWqfVf
 Y0PGT5gTQlTZc8AeoWFYbzhR3t27esp8ucLtKwP0m8nz/vNNDqtWFzcsp9pYi4ODYz+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RGiHbsQAzr00/PQscUywtgDahe38a7wI2DyeGVG0f0o=; b=XThn1qwv5yVvW5yWFlmNRD6APs
 3FEtSynZ401LMHS9SGFQYmn0sxhHfoYaX+0DKWLkXHcoQB6gFC5evkV7WUasPZYYqaCecprBQmRj9
 59bZqr+D0Z8aCnAb+6bmHdHIwR8F6ivrnO7DJcA4pjjFZk2ig0pQYor8CNcTtjk7YzKc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodl-000713-Gm for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECB3660D91;
 Sat,  3 Oct 2026 01:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056911F00898;
 Sat,  3 Oct 2026 01:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991251;
 bh=RGiHbsQAzr00/PQscUywtgDahe38a7wI2DyeGVG0f0o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oNHigDoYb/QGI8ydcTun/TixDHMKY59MDINk27dFzvyTJnAtoHxfGRIub0uNVPoql
 xwXSVkq+YmtwGwecaMNgTy9ETWmD77561KCQo72DhQg9uLiHXsZPOGSSW30ix+e3wz
 PCqybB624RfDmGoWZ5A60oj+ChUP7c9AMH3vkuIMz+1VEZEp+4SsDSifGvO5cgis2J
 zk+w1imKQktX3iC8NS0gxC5aTa67/H3R4cBvJwyYax6BSK3Y/u0KieozFc2ADx/pU3
 e6Damsy1afWNgm6/PdVe+XKHrN4x/ottsRt3nrRcL3HE3nJWscS4puudE1Dsuaiot5
 cWTLCT/7qkGMA==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-2-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-2-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:10 +0000
Message-Id: <20261003013411.056911F00898@smtp.kernel.org>
X-Headers-End: 1xCodl-000713-Gm
Subject: Re: [f2fs-dev] [PATCH v17 01/21] fsverity: report validation errors
 through fserror to fsnotify
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

PiBSZXBvcnRlZCB2ZXJpZmljYXRpb24gZXJyb3JzIHRvIGZzbm90aWZ5IHRocm91Z2ggcmVjZW50
bHkgYWRkZWQgZnNlcnJvcgo+IGludGVyZmFjZS4KPiAKPiBSZXZpZXdlZC1ieTogRGFycmljayBK
LiBXb25nIDxkandvbmdAa2VybmVsLm9yZz4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+Cj4gQWNrZWQtYnk6IEVyaWMgQmlnZ2VycyA8ZWJpZ2dlcnNAa2VybmVs
Lm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgQWxiZXJzaHRleW4gPGFhbGJlcnNoQGtlcm5l
bC5vcmc+CgpTYXNoaWtvIGhhcyByZXZpZXdlZCB0aGlzIHBhdGNoIGFuZCBmb3VuZCBubyBpc3N1
ZXMuIEl0IGxvb2tzIGdyZWF0IQoKLS0gClNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2Fz
aGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTAwMjIyMzcwNS4yMTc1NTQyLTEtYWFsYmVyc2hAa2Vy
bmVsLm9yZz9wYXJ0PTEKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
