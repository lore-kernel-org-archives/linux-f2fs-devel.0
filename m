Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A170DCA5FE9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FjGghOZQNkT8MSymv+53U7vGvQbpN/FJ9y4eicAxFPk=; b=L0NFQisnt2HeyMNkxgSad0BUnu
	qCaXfip7yPzewfYt/h70Ps1tG6dW2zTygsmqTMmlSfGJa1IrSs/IRLSdLUuT6Z16x7E+6q2cCfx40
	VvgrtYmIeZzXpxp2Y00pXGcrkfIPPHWsad6IbBO92+2vjfcObkRKKzWjx/ig7YhH2M5o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodp-00078i-4Y;
	Sat, 03 Oct 2026 01:34:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodl-00078T-MN
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eBopooOWrNnJRmcfg3vqA0pA1Mpkfo2rR1lIK2/DWEg=; b=m7bQjfuVB6/k5rh2uS55nkTZ46
 6PM75DzoI2EvKFuaqZPpqIfXcI+f3XZR/sDDqVdIY+hZBI1f9rTuD1g8adhd00SMm3c+5C6F9XVt1
 bV3gMMF2BKyzj3fJli93PCCUbIJQuP5kw9s3fSLrsHXdwMc2sGMPjyOjMBQB3c7ry7uc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eBopooOWrNnJRmcfg3vqA0pA1Mpkfo2rR1lIK2/DWEg=; b=Tv3fgdRGfgFzP88B8NNEun0nBE
 ZA5UjgORfDia3LFzrzRn3XyT6zHBkrv31Kl3PFq4v+6KWyR9fRmxZq/UfUfipUSlwMkR0OtJ9SWsK
 MXdJMBLrcfARJzczKMJ+E9SEgaEBWfsWkh0hfF/7OtQaAuEqT5GDaIIKNHsC78Bq1Yl0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodl-0001jW-Sx for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 822A541AE2;
 Sat,  3 Oct 2026 01:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1C91F00893;
 Sat,  3 Oct 2026 01:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991252;
 bh=eBopooOWrNnJRmcfg3vqA0pA1Mpkfo2rR1lIK2/DWEg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mejqa70lTxSfyxW0Q27N0ngkrGfMooqxBmUtAdEvaPd+junGc9uchpFTgoRkMaITk
 25SGUzYS3HWOL3hSNOSWPw2yQmCufYFkA7BWm+vG4AMUMvJQCGOWF6oESt1GOM0v4Y
 umtkmml05n0pXd+G2ho3UsFMwcP+fg8aIk3AhJeZv4iGKKIPn4IY512lEsrtWNw6rZ
 /JyJhYy+m1iYM7WaSAjqZgoQBWoHLXU4Z19znJwlTJega8GCRYYIEk0J3RjVYlxFHm
 +15WAWeQJoJhSFpksj5B1+c9IxctMFEirM3hcxEWm2MVW6Yru4VNiFq0hCRDziY+2V
 Op4zPcjUc6vhA==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-10-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-10-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:11 +0000
Message-Id: <20261003013412.2D1C91F00893@smtp.kernel.org>
X-Headers-End: 1xCodl-0001jW-Sx
Subject: Re: [f2fs-dev] [PATCH v17 09/21] xfs: disable direct read path for
 fs-verity files
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

PiBUaGUgZGlyZWN0IHBhdGggaXMgbm90IHN1cHBvcnRlZCBvbiB2ZXJpdHkgZmlsZXMuIEF0dGVt
cHRzIHRvIHVzZSBkaXJlY3QKPiBJL08gcGF0aCBvbiBzdWNoIGZpbGVzIHNob3VsZCBmYWxsIGJh
Y2sgdG8gYnVmZmVyZWQgSS9PIHBhdGguCj4gCj4gQWRkIGEgZmFsbCBiYWNrIHRvIGJ1ZmZlcmVk
IEkvTyBhdCB0d28gcGxhY2UsIGluIGEgY29tbW9uIGZhc3QgcGF0aCBhbmQKPiBsYXR0ZXIgd2hl
biBsb2NrIGlzIGFjcXVpcmVkLiBUaGUgc2Vjb25kIGNoZWNrIHByZXZlbnRzIFRPQ1RPVSBpc3N1
ZQo+IHdpdGggcmVhZGluZyBmc3Zlcml0eV9hY3RpdmUoKSBzdGF0dXMgYW5kIHJlc2V0dGluZyBJ
T0NCX0RJUkVDVCBmbGFnLgo+IAo+IElmIG9uZSB0aHJlYWQgc2F3IGZzdmVyaXR5X2FjdGl2ZSgp
IHRvIGJlIGZhbHNlLCBhbmQgdGhlbiBzZWNvbmQgdGhyZWFkCj4gYWNxdWlyZWQgWEZTX0lPTE9D
S19FWENMIGFuZCBlbmFibGVkIGZzdmVyaXR5LiBUaGUgZmlyc3QgdGhyZWFkIHdpbGwgZ28KPiB0
aHJvdWdoIHRoZSBESU8gcGF0aC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYXJyaWNrIEouIFdvbmcg
PGRqd29uZ0BrZXJuZWwub3JnPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBBbGJlcnNodGV5biA8
YWFsYmVyc2hAa2VybmVsLm9yZz4KClNhc2hpa28gaGFzIHJldmlld2VkIHRoaXMgcGF0Y2ggYW5k
IGZvdW5kIG5vIGlzc3Vlcy4gSXQgbG9va3MgZ3JlYXQhCgotLSAKU2FzaGlrbyBBSSByZXZpZXcg
wrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYxMDAyMjIzNzA1LjIxNzU1NDIt
MS1hYWxiZXJzaEBrZXJuZWwub3JnP3BhcnQ9OQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
