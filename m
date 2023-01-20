Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3787BC05027
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Jan 2023 18:30:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pIw9O-0001mI-L0;
	Fri, 20 Jan 2023 18:30:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <mkarcher@zedat.fu-berlin.de>) id 1pIw9N-0001mB-EX
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Jan 2023 18:30:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZGWBbZCWHPcpFdvi7SgCcyqriFNr+a8nlCDlnaaK9M8=; b=P8GOwgNzZFcI7gxzW72Vmtq0XI
 co/dtRXMW5VkSjv4O6Dc8o7vpbzLDfVOq62CVKTx9r/lIq0NkqEQa9zrPSaJ9y3CCi3fDvfMa1vfy
 9oMC6ggFAODM2VOLiFuZxL0mKjr+OyuTyd8hRJ2/aq/ehAy4C18/gS+fgjCx+EJndaKc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZGWBbZCWHPcpFdvi7SgCcyqriFNr+a8nlCDlnaaK9M8=; b=VNfxzvUQnCBXV4Am/tVsJt2+4q
 6L2TfRwFLg7pdImEOyN9k3W4UfZNst53NK3lnsEAXGsMk4BxAk2kST796OIgLXY9Z2OcksU3GOqY5
 mosSSEdRIYQiMqkqOob7x0Rcnl2hEMHgvux66yrcei4XSiraxZ70pqEWJ0hUzDq2LQzA=;
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pIw9I-00034A-3x for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Jan 2023 18:30:03 +0000
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.95) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <mkarcher@zedat.fu-berlin.de>)
 id 1pIw91-002ZeP-SB; Fri, 20 Jan 2023 19:29:43 +0100
Received: from pd9f631ca.dip0.t-ipconnect.de ([217.246.49.202]
 helo=[192.168.144.87]) by inpost2.zedat.fu-berlin.de (Exim 4.95)
 with esmtpsa (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (envelope-from <Michael.Karcher@fu-berlin.de>)
 id 1pIw91-002DWz-Lq; Fri, 20 Jan 2023 19:29:43 +0100
Message-ID: <9e037a3d-56a6-6a06-834a-48c0b8d9225f@fu-berlin.de>
Date: Fri, 20 Jan 2023 19:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Rob Landley <rob@landley.net>
References: <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
 <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
 <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
 <CAMuHMdWbBRkhecrqcir92TgZnffMe8ku2t7PcVLqA6e6F-j=iw@mail.gmail.com>
 <429140e0-72fe-c91c-53bc-124d33ab5ffa@physik.fu-berlin.de>
 <CAMuHMdWpHSsAB3WosyCVgS6+t4pU35Xfj3tjmdCDoyS2QkS7iw@mail.gmail.com>
 <0d238f02-4d78-6f14-1b1b-f53f0317a910@physik.fu-berlin.de>
 <1732342f-49fe-c20e-b877-bc0a340e1a50@fu-berlin.de>
 <0f51dac4-836b-0ff2-38c6-5521745c1c88@landley.net>
 <20230120105341.GI25951@gate.crashing.org>
From: "Michael.Karcher" <Michael.Karcher@fu-berlin.de>
In-Reply-To: <20230120105341.GI25951@gate.crashing.org>
X-Original-Sender: Michael.Karcher@fu-berlin.de
X-Originating-IP: 217.246.49.202
X-ZEDAT-Hint: T
X-Headers-End: 1pIw9I-00034A-3x
Subject: Re: [f2fs-dev] Calculating array sizes in C - was: Re: Build
 regressions/improvements in v6.2-rc1
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
Cc: linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 kasan-dev@googlegroups.com,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-f2fs-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGVsbG8hCj4gQ2FuIHNvbWVvbmUgcGxlYXNlIGZpbGUgYSBHQ0MgUFI/ICBXaXRoIHJlZHVjZWQg
dGVzdGNhc2UgcHJlZmVyYWJseS4KCmh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19i
dWcuY2dpP2lkPTEwODQ4MwoKVGhlcmUgeW91IGFyZS4KCktpbmQgcmVnYXJzLAogwqAgTWljaGFl
bCBLYXJjaGVyCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL2xpbnV4LWYyZnMtZGV2ZWwK
