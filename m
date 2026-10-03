Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D6FCA5FE9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+OxVIAIr+yKlNDxqmuImtEQPF5oLbAVv83/xHpausRY=; b=NWEb8lRlTS5690qCETMGosfb2S
	9XYN1iCdVwVRVlFHNHCHC4zo01jIujZfrueq4sOXI+A8g30hw6pcoK4jtrjJ+0Nu6/F+Z6/rVDdpZ
	jDYIjRk3YzXK37Ql8hB9C6lctIZpOEf9K9FA4i/vmVhhKskcH5pGmwjqDGEV7zrn46jg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodu-0005Ix-As;
	Sat, 03 Oct 2026 01:34:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCods-0005If-Cb
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RXilpDvC3P9Od+aYPGoREKfyvq16X7Y3kHy/B9Ndgts=; b=jsgIQr295mCWUBfWkfWMowaRYL
 YPNk8ph8N26EeXO9Y+zA7BoaeOeE/Rqd7zJCORp2x4wa8M7dOdnTLDUtCyOiUex5xQTRxCGitDaAm
 YC8SSpqIpJ5j3NGMm4Cd4Lq08qb/MkzR6gEZcxFuaXP/KtWMDQI8Mfgi5WHtzpD3Dzn8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RXilpDvC3P9Od+aYPGoREKfyvq16X7Y3kHy/B9Ndgts=; b=KYzNpmtspQquqWKlwoHsffaXXd
 Ke73NKz4tOE91oD3ukK2tRWOnaa/HxnSztqojH5PGDRoDSIHiWT4TCnfpaRrnmvCiRx4GKDcrf1bR
 YfjwNq1XP+8gA3G61mYtC0trOEwMnkzD0RT6R6Oz21D92amQMD7e9i19RP3Q9LzXSOhY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodr-0001jj-S1 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5052260DA0;
 Sat,  3 Oct 2026 01:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91CF1F00899;
 Sat,  3 Oct 2026 01:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991258;
 bh=RXilpDvC3P9Od+aYPGoREKfyvq16X7Y3kHy/B9Ndgts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TzMLpLNi9fS4UMJMLSMXtJS6cZaHojGSO1g4vqL9xo7Y5aIV0+EJtlUEjf0VsjxZN
 xgGvKmRbJeRZGBNO53vkcBETrH/jIO6Jw7rT3cwyOJNqu7QvNnbvquW3M894O/uFvJ
 sZQaxkmTb5hBul7Ac96E3hhXJTIiWCe/nEjqWNzXJSR4WMIGRpSJtE7F3foR5wfWnT
 pFc+pchiHVOnNU49KG9WR4nqz8rorYCqZ8oSou03Xz2nMvBjl8eHfBUBumtE20URuR
 7qjOWYeWj99mD7X8mByRaximfEZEbryVbdA7PiRqv8BM4ceuNtKzH11QuvNoADEhw4
 Fn2ehQivIpwBw==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-21-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-21-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:17 +0000
Message-Id: <20261003013417.B91CF1F00899@smtp.kernel.org>
X-Headers-End: 1xCodr-0001jj-S1
Subject: Re: [f2fs-dev] [PATCH v17 20/21] xfs: introduce health state for
 corrupted fsverity metadata
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

PiBSZXBvcnQgY29ycnVwdGVkIGZzdmVyaXR5IGRlc2NyaXB0b3IgdGhyb3VnaCBoZWFsdGggc3lz
dGVtLgo+IAo+IFJldmlld2VkLWJ5OiBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3Jn
Pgo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZXkgQWxiZXJzaHRleW4gPGFhbGJlcnNoQGtlcm5lbC5vcmc+CgpTYXNoaWtv
IGhhcyByZXZpZXdlZCB0aGlzIHBhdGNoIGFuZCBmb3VuZCBubyBpc3N1ZXMuIEl0IGxvb2tzIGdy
ZWF0IQoKLS0gClNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRj
aHNldC8yMDI2MTAwMjIyMzcwNS4yMTc1NTQyLTEtYWFsYmVyc2hAa2VybmVsLm9yZz9wYXJ0PTIw
CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
