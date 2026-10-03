Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50174CA5FE2
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2KZaFW7hi9259KH2jk2SFTyO2t+Atcu+JNR6P5hVvE=; b=SVpb8nJ94s5lt2LIsjWRIcNPKb
	soFSjrC2ygrrlAm0htW2y0h6R1I+Tlrqv2BImfNO00tIzTVymj9wxTHcqr9czVPcpXlZwNWjV54XY
	oEVzHqiylpjRP+A3t5GwPcZNpzvLubwGcIloKkP+b45JY5pJecLpapnr6TS8WdI9CUjw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodi-000786-PQ;
	Sat, 03 Oct 2026 01:34:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodh-00077y-OP
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=retjv276DMbfkXVjd5UNojsS2lKORkHAybiSCADKjZw=; b=NfJk3I+9uFDkD8JSpsr0q/xtsD
 cyuu6fERlwcWk1CpIt4KQlopguPeCVh3Ym6ueTgyiVPf7giPIooqIf7kO9LOR7i4BZgUgwSKE/xHa
 t8is8vJ43urYnUrwFQzsqpvvz5MjJl959lxKYUMVkd0AKrc88NA0BGPFtCwVO5oyemBo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=retjv276DMbfkXVjd5UNojsS2lKORkHAybiSCADKjZw=; b=l8U+qmqNtW5bm8MNx8TUe4IAIL
 4CSNPysEbzwKs9sPTS0dFqDmRKU4YJXJFvK2or/fpH1sY8+RWutTHCGaO1Dqo8b0yWQHJ/Y0a2wK5
 wKODSpLGHwKBsVxme/Gxd1rVUVZi6m3DtHesgeeajLPaxNA4wLG5pPWdtyguczwus9Y4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodh-000710-TF for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 599BF60DA1;
 Sat,  3 Oct 2026 01:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F6C1F00899;
 Sat,  3 Oct 2026 01:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991248;
 bh=retjv276DMbfkXVjd5UNojsS2lKORkHAybiSCADKjZw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dL20owRF63oJscZreT5KHeSqXAnc6HSC+yIgEq70osePVdJzhziAFkaXtqzSZ8UMa
 qMqnkBHRWno8GufmNCkqgV1rWGNbn6Tcw70Cnq1n9zwXtNqZC7+0wfuPF6lQrYGMCm
 KwBufYzwjg+MLxWDjeBRATN47kpvTbW2B9QvJjM1DKaSAuON2qev70PEzPALE0QMvv
 ybKoLBoMdmogdXVrzs2/mz1YmMXM3ik5nEji7JXatTxLOKccs7gXJJssVIJ7ziSX4P
 mu5RxbY8jUE5PXwe0tLiCXY+QmPgp++zKQeM3ihUZOwVcwdcMpi08mC5xOfDKgFlz2
 0GC8Od5Zezogw==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-4-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-4-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:07 +0000
Message-Id: <20261003013407.C3F6C1F00899@smtp.kernel.org>
X-Headers-End: 1xCodh-000710-TF
Subject: Re: [f2fs-dev] [PATCH v17 03/21] fsverity: pass digest size and
 hash of the all-zeroes block to ->write
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

PiBMZXQgZmlsZXN5c3RlbSBpdGVyYXRlIG92ZXIgaGFzaGVzIGluIHRoZSBibG9jayBhbmQgY2hl
Y2sgaWYgdGhlc2UgYXJlCj4gaGFzaGVzIG9mIHplcm9lZCBkYXRhIGJsb2Nrcy4gWEZTIHdpbGwg
dXNlIHRoaXMgdG8gZGVjaWRlIGlmIGl0IHdhbnQgdG8KPiBzdG9yZSB0cmVlIGJsb2NrIGZ1bGwg
b2YgdGhlc2UgaGFzaGVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBBbGJlcnNodGV5biA8
YWFsYmVyc2hAa2VybmVsLm9yZz4KClNhc2hpa28gaGFzIHJldmlld2VkIHRoaXMgcGF0Y2ggYW5k
IGZvdW5kIG5vIGlzc3Vlcy4gSXQgbG9va3MgZ3JlYXQhCgotLSAKU2FzaGlrbyBBSSByZXZpZXcg
wrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYxMDAyMjIzNzA1LjIxNzU1NDIt
MS1hYWxiZXJzaEBrZXJuZWwub3JnP3BhcnQ9MwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
