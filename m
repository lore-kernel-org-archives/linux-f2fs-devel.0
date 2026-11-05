Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46F606A333
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XOXqRW2/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=amtqJADM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gIAvtofU;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ik2wl13d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Date:References:In-Reply-To:To:Message-ID:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=H/OitBtr6IZkY9LRZ+cjyvBMrOn6kt66cpKBpIBRC4o=; b=XOXqRW2/RMpASCXiQ9N4JiAtc0
	s9xlP76qfE51bVOQ7sGwe5GZEElJBNMaQkd6qlSYtlChXPhIiGHV92u/6da+3aU26rR4z7okvgxSs
	f6T+bEGP0sHVS9kclGKWblPNxbE5yNWqazEsdazHc8juQ33XiKTtrY9VbQ4M5pITDO+E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOwCC-0000000088b-18qM;
	Thu, 05 Nov 2026 12:03:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <sashiko-bot@kernel.org>) id 1xOwCA-0000000088Q-3PxU
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:03:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Date:Content-Transfer-Encoding:Content-Type:
 References:In-Reply-To:Cc:To:Reply-To:Subject:From:Message-ID:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=k/wi11Q8Kbwq/8dtX7S4+c84XHKcQGErwPRnzMyAsJw=; b=amtqJADMjJDD
 voiyXtwGOOtXHyfqcIwEYrEmM3eJtnbsZ9UMEY74m3nxyNT56bWqVreTrGwcFCUiRgXnIq+q9L1X9
 jZevo4TG0aAqYVB9+FFq37euYjdyv7uCuMeG8OxK8Kbzl3Ue22HIlJ1AAhzWM6OyqiT1xQuGrLW5I
 xI+WE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:
 Reply-To:Subject:From:Message-ID:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k/wi11Q8Kbwq/8dtX7S4+c84XHKcQGErwPRnzMyAsJw=; b=gIAvtofURM0cfrVYAxzIs1Q8k/
 3c5lGZZcwurwv0GCXekb7+D0YMee/khiOBnyEu5D/PuwgsegqAt+y4tMUNe8IUcw0gNdtSRPt/HHx
 pOmq5qUIGJUVDxrWCh+a5HX4DpUt81Uj8lUnEDUck9KidV5Si2ehU1acJxTfZG5BCn7Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOwC9-000000002QZ-0toC
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:03:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A2EF2605F4;
 Thu,  5 Nov 2026 12:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328FC1F000C1;
 Thu,  5 Nov 2026 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793880227;
 bh=k/wi11Q8Kbwq/8dtX7S4+c84XHKcQGErwPRnzMyAsJw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ik2wl13d/USMdBZVuezajsFt0QoQiThbp/4So/UbVqw3aBzjyZVGsJ5iB322vMNOL
 SBOaQTTeKxYY4lqvnSswK5TP13TRs91b9oq6Pt6utI1p4Yct8kpqCnic3vMDhrn5kA
 CP9Ha4p/3DUoEthF6FzDCkyE3yzf8FTbSU3Uir5z9ASiPR7wvmbavsR8IS3osWsuNZ
 +1gHRJ6mlKmLjihpLPzO8PqHGqFZAGyvrcNKpQE+pse2I11AakQ/Fs9eLGG289BFEh
 qzI3oJwu6ZzOeLqBGS18M8Poe0i6VyfXDyYkurMJu2mFwDEwt0gBU8N/QIgiNbcdvJ
 3Q5nbeNg3mi5A==
Message-ID: <sashiko-outbox-198986@kernel.org>
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261105115532.613467-2-aalbersh@kernel.org>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-2-aalbersh@kernel.org>
Date: Thu, 05 Nov 2026 12:03:46 +0000
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOwC9-000000002QZ-0toC
Subject: Re: [f2fs-dev] [PATCH v2 1/5] fsverity: strip FS_VERITY_FL from
 FS_IOC_SETFLAGS
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

PiBUaGUgY29tbW9uIHVzZSBvZiBGU19JT0NfR0VURkxBR1MvU0VURkxBR1MgaXMgZ2V0LW1vZGlm
eS1zZXQgbG9vcC4KPiBGaWxlc3lzdGVtcyBjb3VsZCByZXR1cm4gdmVyaXR5IHN0YXR1cyB3aXRo
IEdFVEZMQUdTLCBhdHRlbXB0aW5nIHRvIHRoZW4KPiBwYXNzIEZTX1ZFUklUWV9GTCB0byBTRVRG
TEFHUyBpcyBub3QgYWxsb3dlZC4KPiAKPiBUaGUgZXh0NCBhbmQgZjJmcyBhbHJlYWR5IHRyZWF0
IEZTX1ZFUklUWV9GTCBpbiB0aGUgc2V0IHBhdGggYXMgbm8tb3AsCj4gaG93ZXZlciwgQlRSRlMg
cmV0dXJucyAtRU9QTk9UU1VQUC4gU28sIHRoZSBtb2RpZmljYXRpb24gb2Ygb3RoZXIgZmxhZ3MK
PiBkb2Vzbid0IHdvcmsgb24gQlRSRlMgZm9yIGZzdmVyaXR5IGlub2Rlcy4KPiAKPiBGaXggaXQg
Zm9yIEJUUkZTIGFuZCBhbnlvbmUgZWxzZSwgdGhlIGV4dDQgYW5kIGYyZnMgbWFza2luZyBiZWNv
bWVzCj4gbm8tb3AuIFRoZSBmaWxlX2dldC9zZXRhdHRyKCkgcGF0aCBpcyBmaW5lIGhlcmUgYXMg
dGhpcyBmbGFnIGlzIGNsZWFyZWQKPiByaWdodCBiZWZvcmUgZmlsZWF0dHJfc2V0X3ByZXBhcmUo
KS4gVGhlIGZ1dHVyZSBmc3Zlcml0eSBzdXBwb3J0IGluIFhGUwo+IHdvdWxkIGFsc28gbmVlZCBp
dC4KPiAKPiBDYzogQm9yaXMgQnVya292IDxib3Jpc0BidXIuaW8+Cj4gQ2M6IERhdmlkIFN0ZXJi
YSA8ZHN0ZXJiYUBzdXNlLmNvbT4KPiBGaXhlczogMTQ2MDU0MDkwYjA4ICgiYnRyZnM6IGluaXRp
YWwgZnN2ZXJpdHkgc3VwcG9ydCIpCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEFsYmVyc2h0ZXlu
IDxhYWxiZXJzaEBrZXJuZWwub3JnPgoKU2FzaGlrbyBoYXMgcmV2aWV3ZWQgdGhpcyBwYXRjaCBh
bmQgZm91bmQgbm8gaXNzdWVzLgoKLS0gClNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2Fz
aGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTEwNTExNTUzMi42MTM0NjctMS1hYWxiZXJzaEBrZXJu
ZWwub3JnP3BhcnQ9MQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
