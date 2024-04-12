Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C65C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Apr 2024 20:53:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rvNu8-0006sA-9T;
	Fri, 12 Apr 2024 20:53:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rvNu7-0006rz-CO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Apr 2024 20:53:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nqH5byekoftQFNMSmP9xB+au1mAmQyMuXLOOfArUrRE=; b=PP2ZuM+qSis9OBZutC7i+l+uyM
 x1mMNTSNJ7tQTkGFDYjmysC3DXM0+DA2+V2G4IL96RddJPRilqgkDA55lz5thrrNy2SmkLudzyUTf
 mYTeizaQtD4ZeteIBk/7LNjvBj5DYjAZsayiOUYkW6TRtKTCPd3ZiTmoEx2iJI7GVBXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nqH5byekoftQFNMSmP9xB+au1mAmQyMuXLOOfArUrRE=; b=C4h85wvEXCI1T5snmeN3K0Ck1z
 cyk2qUrtqGA6A8SYnZz2h0pc/w9ebhXGsELaN3TqGRbNxWWUMU7xI5mGzrRXWFkUhNOAnyvql1R94
 VJNX6ac4z68kcoO5jrPRc1gZQYCCurkGCsAB7NZH/AL6EaeUyuUnkDXnUQrIZbYbexrs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rvNu7-0004SN-6J for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Apr 2024 20:53:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1659261903;
 Fri, 12 Apr 2024 20:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82740C2BD11;
 Fri, 12 Apr 2024 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712955216;
 bh=7KHEBo/ktcL0Syd+126vMQEFQkCpI3GKOWAVYMxiir4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EkTxfwgZyKHYF+A9q7/OS7701yzGJ8mRojg/TabzLaBZDF/95o/+nZxc5hTBA5fi5
 iDZOIat1qZf8x03nI0ybDg0R+AVU9jOMvz/P5zmUBFN+MDFL4p9yIi0Lp1yhGKdav/
 HmbIYsT8Kd0XmMOfEA0Q/uR+ZH7jeMV0jHG97J2MAccTqlCOvXPLacIkObBwDkqwhT
 xxOvSNRxlKNT8P1eJOiS7vxGKB/5ZoY1S16aqoX2pI1xmJmJlWKR0wbE7EyBBVpiow
 qm8lT5QIGSSoPI6IJc1RW+hYyKHd8dQzD2LBt8YmWKcGs/gHmgEYn9u+il+czzF8TW
 NfpE03UvkKYyw==
Date: Fri, 12 Apr 2024 20:53:34 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Message-ID: <ZhmfTousYopIc0HC@google.com>
References: <1710915736-31823-1-git-send-email-zhiguo.niu@unisoc.com>
 <ee24b313-a168-471e-b60f-1404c69e61a7@kernel.org>
 <CAHJ8P3KaQF8okMOyagH80+BmUUZ=ENSoAApz2H-p_1=Pu5ZTbw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHJ8P3KaQF8okMOyagH80+BmUUZ=ENSoAApz2H-p_1=Pu5ZTbw@mail.gmail.com>
X-Headers-End: 1rvNu7-0004SN-6J
Subject: Re: [f2fs-dev] [PATCH V3] f2fs: add REQ_TIME time update for some
 user behaviors
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMDQvMTAsIFpoaWd1byBOaXUgd3JvdGU6Cj4gSGkgSmFlZ2V1awo+IEFueSBjb21tZW50cyBh
Ym91dCB0aGlzIHBhdGNoPwoKVGhhbmsgeW91IGZvciBoZWFkcyB1cC4gQXBwbGllZC4KCj4gdGhh
bmtzIQo+IAo+IE9uIFdlZCwgTWFyIDIwLCAyMDI0IGF0IDU6MzPigK9QTSBDaGFvIFl1IDxjaGFv
QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+IE9uIDIwMjQvMy8yMCAxNDoyMiwgWmhpZ3VvIE5p
dSB3cm90ZToKPiA+ID4gc29tZSB1c2VyIGJlaGF2aW9ycyByZXF1ZXN0ZWQgZmlsZXN5c3RlbSBv
cGVyYXRpb25zLCB3aGljaAo+ID4gPiB3aWxsIGNhdXNlIGZpbGVzeXN0ZW0gbm90IGlkbGUuCj4g
PiA+IE1lYW53aGlsZSBhZGp1c3Qgc29tZSBmMmZzX3VwZGF0ZV90aW1lKFJFUV9USU1FKSBwb3Np
dGlvbnMuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFpoaWd1byBOaXUgPHpoaWd1by5uaXVA
dW5pc29jLmNvbT4KPiA+Cj4gPiBSZXZpZXdlZC1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3Jn
Pgo+ID4KPiA+IFRoYW5rcywKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
