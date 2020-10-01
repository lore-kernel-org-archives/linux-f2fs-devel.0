Return-Path: <SRS0=g2Ds=DI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44907C4727C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:20:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9529820848;
	Thu,  1 Oct 2020 10:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="m8cU6KMg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="VKCif8iK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9529820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kNvhL-0008V7-Lj; Thu, 01 Oct 2020 10:20:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dsterba@suse.cz>)
 id 1kNvhK-0008Uw-C9; Thu, 01 Oct 2020 10:20:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gzkOmEPzmsGS+RSqBlP9hiEbTFmUgDhl5xYzV2igasQ=; b=m8cU6KMg5eczO+XPzwKOK36ZEa
 gTo+mDXAg+ZM1NXLReAcIUISXihtjSoEbMGdjiQgmjrovZw4RV7sro4fUkwqwyQklqKF8O7scV8bU
 IoC7Iv2dwxZoguKa5ZoZCCqExltI5aftym2dHQ+DLBkSem9SNJUpF2VbnxmoQNnG61+o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gzkOmEPzmsGS+RSqBlP9hiEbTFmUgDhl5xYzV2igasQ=; b=VKCif8iKEv77sYRoNSAlgrVnzr
 5GITVdTVQrcnRmlB2SbI1Jy2nAvu92izruhBzrMiPyhTABnI7P+Z3/YcDVhnQweAOVinvvehuTLCJ
 9ommEkjWv9aCZuwMbS+J0I9iPvmOHE5E6l4duFH6i5wefidoHNxd9oxwJPB7/nGJ8jmc=;
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kNvhE-00CgvA-UM; Thu, 01 Oct 2020 10:20:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A50E6ABBD;
 Thu,  1 Oct 2020 10:19:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 901EFDA781; Thu,  1 Oct 2020 12:18:33 +0200 (CEST)
Date: Thu, 1 Oct 2020 12:18:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Nick Terrell <terrelln@fb.com>
Message-ID: <20201001101833.GT6756@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Nick Terrell <terrelln@fb.com>,
 Nick Terrell <nickrterrell@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 "squashfs-devel@lists.sourceforge.net" <squashfs-devel@lists.sourceforge.net>, 
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
 Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
 Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
 <293CD1BC-DBED-4344-AC84-C85E0DD7914D@fb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <293CD1BC-DBED-4344-AC84-C85E0DD7914D@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Headers-End: 1kNvhE-00CgvA-UM
Subject: Re: [f2fs-dev] [GIT PULL][PATCH v4 0/9] Update to zstd-1.4.6
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
Reply-To: dsterba@suse.cz
Cc: "squashfs-devel@lists.sourceforge.net"
 <squashfs-devel@lists.sourceforge.net>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Christoph Hellwig <hch@infradead.org>, Nick Terrell <nickrterrell@gmail.com>,
 Yann Collet <cyan@fb.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, Petr Malat <oss@malat.biz>,
 Chris Mason <clm@fb.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Kernel Team <Kernel-team@fb.com>, Niket Agarwal <niketa@fb.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Johannes Weiner <jweiner@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6NDk6NDlQTSArMDAwMCwgTmljayBUZXJyZWxsIHdy
b3RlOgo+ID4gT24gU2VwIDI5LCAyMDIwLCBhdCAxMTo1MyBQTSwgTmljayBUZXJyZWxsIDxuaWNr
cnRlcnJlbGxAZ21haWwuY29tPiB3cm90ZToKPiA+IAo+ID4gRnJvbTogTmljayBUZXJyZWxsIDx0
ZXJyZWxsbkBmYi5jb20+Cj4gCj4gSXQgaGFzIGJlZW4gYnJvdWdodCB0byBteSBhdHRlbnRpb24g
dGhhdCBwYXRjaCAzIGhhc27igJl0IG1hZGUgaXQgdG8gcGF0Y2h3b3JrLAo+IGxpa2VseSBiZWNh
dXNlIGl0IGlzIHRvbyBsYXJnZS4gSeKAmWxsIGluY2x1ZGUgYSBwdWxsIHJlcXVlc3QgaW4gdGhl
IG5leHQgY292ZXIgbGV0dGVyLAo+IHRvZ2V0aGVyIHdpdGggdGhlIHBhdGNoZXMgKGlmIG5lZWRl
ZCkuCgpUaGUgcGF0Y2ggMy85IHNhdmVkIHRvIGEgZmlsZSBpcyAxLjZNLCBvdmVyIDM1MDAwIGxp
bmVzLCB0aGUgZGlmZnN0YXQKc2F5czoKCiA2NiBmaWxlcyBjaGFuZ2VkLCAyNDI2OCBpbnNlcnRp
b25zKCspLCAxMjg4OSBkZWxldGlvbnMoLSkKClNlcmlvdXNseSwgdGhpcyBpcyB3cm9uZyBpbiBz
byBtYW55IHdheXMuIFRoZXJlJ3MgdGhlIHJhdGlvbmFsZSBmb3IKb25lLXRpbWUgY2hhbmdlIGV0
YywgYnV0IHRoZSBhY3R1YWwgcmVzdWx0IGlzIGJleW9uZCB3aGF0IEkgd291bGQgYWNjZXB0CmFu
ZCB3b3VsZCBub3QgZW5jb3VyYWdlIGFueW9uZSB0byBtZXJnZSBhcy1pcy4KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
