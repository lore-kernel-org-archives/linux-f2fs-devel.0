Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB871CA5FEA
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d8sGJ7II8VrghZjNBz7j6JGuFB1t/tDMjYQTTWSEUhc=; b=VG41DXwrmmV8cenN0JK/oARwcx
	nHj0agQFaqzZNzIB+fKrLpTn0PJxMaqWpnKwPekcuchqgWHZAihA2mD/49l4fpAhcEZoCDvleFDay
	NJao55/z7cQa2JhCKSPaYDQQ0ZndDexmZ6QGUB+JKkJdwjDhJcPH6uF/dQbb77mV1Nxk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodr-0003G6-V8;
	Sat, 03 Oct 2026 01:34:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodr-000396-6k
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5mnYw/Q3hhZyQTGx26TjPWwuu2r4YUGujWvPrRUMqCs=; b=QcPB0A/hFy8xxe6WrDO+wqLZsO
 cAPfp+uve/pdDGNWFcoWzTvksVnrHVkulzbUzrepBmp8N+PSZOEjFglpzFFchzTn4Yy/SF1D2moWC
 WVuyMUQh3Gadlrsl0D2wvN/f92DDoA93pGZPQczX41XLOihjRD1OZXvW1Uu0mGYflH0c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5mnYw/Q3hhZyQTGx26TjPWwuu2r4YUGujWvPrRUMqCs=; b=NeAxs0KCiVIBRorCaTkKWwHu+f
 WuzB20+6dgu6Vq4s2XzxjgRca2T+owp/OxOrz/ONk6caHkLvEPXQu7cMP6pyahhczDwHJOP5kjuvS
 Nd4gTTC8hAa1R4kLnEz1Ob0gf31y6/LReXfBuST0fzZE71x7lLztYy/COsb3NnBj95wA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodo-0001jZ-5e for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCE9241FF0;
 Sat,  3 Oct 2026 01:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801FE1F00893;
 Sat,  3 Oct 2026 01:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991254;
 bh=5mnYw/Q3hhZyQTGx26TjPWwuu2r4YUGujWvPrRUMqCs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WZLzKjI8hiP8w4frEJA2qn3nuGNoUwqu9bajUCPRxUtYm9q5KfxgPmMhKbydwx7Le
 9jqHSvKttIiiwb5WPBzfsdsE6Ld+OpUs4MsB/5ocU8LzkRebrlA5SjfJ/VRvFpTV14
 +LuL4Ag7dZ3qOWUztNCfnk9uDYMF373RRglXpyhCkncQBz5GlNzx0bSBLOq+R5AmDG
 aVh16hZiEygSKShhZyt8OginjS6eQi6QGR6wXMDpMeIi2p9xMoXw5bkrAnU7lzvF4Q
 5v9KLH1erjUtC2KIsazc6upH00PLqIlJ0vJIdF/5O8Lxr+QLbU00SHOd3IIvjkuE/q
 LSeUMk7FNB6bQ==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-22-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-22-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:14 +0000
Message-Id: <20261003013414.801FE1F00893@smtp.kernel.org>
X-Headers-End: 1xCodo-0001jZ-5e
Subject: Re: [f2fs-dev] [PATCH v17 21/21] xfs: enable ro-compat fs-verity
 flag
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

PiBGaW5hbGl6ZSBmcy12ZXJpdHkgaW50ZWdyYXRpb24gaW4gWEZTIGJ5IG1ha2luZyBrZXJuZWwg
ZnMtdmVyaXR5Cj4gYXdhcmUgd2l0aCByby1jb21wYXQgZmxhZy4KPiAKPiBSZXZpZXdlZC1ieTog
RGFycmljayBKLiBXb25nIDxkandvbmdAa2VybmVsLm9yZz4KPiBbZGp3b25nOiBhZGQgc3BhY2Vz
XQo+IFNpZ25lZC1vZmYtYnk6IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+Cj4g
UmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IFNpZ25lZC1vZmYt
Ynk6IEFuZHJleSBBbGJlcnNodGV5biA8YWFsYmVyc2hAa2VybmVsLm9yZz4KClNhc2hpa28gaGFz
IHJldmlld2VkIHRoaXMgcGF0Y2ggYW5kIGZvdW5kIG5vIGlzc3Vlcy4gSXQgbG9va3MgZ3JlYXQh
CgotLSAKU2FzaGlrbyBBSSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0
LzIwMjYxMDAyMjIzNzA1LjIxNzU1NDItMS1hYWxiZXJzaEBrZXJuZWwub3JnP3BhcnQ9MjEKCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJm
cy1kZXZlbAo=
