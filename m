Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9418FCA5FE2
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qDeat82yyk87HLWz1c7F9+q92HbafH2mXbWgH4p6zpg=; b=PVZdK1Neesy1blxPR7fRoxHu49
	1Q+k+d8i3wHkoEn/53rGKhwbkdWlGvWfEvf+V+psVQesUbrIBC0+7p7qqTdwdSrCqCMH1NCeLZJC2
	IoU+zmBQSrhrajnot9HQ6fDJFQ22ovfue/RRwjqnPGPpg58+TcICdxup4p9IgNNXR7lY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodr-00079L-Fi;
	Sat, 03 Oct 2026 01:34:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodq-000795-Bw
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t/FYEeN9SYMRxzfuvOUUNm8bZlWgx1w0JtUwPKv25gg=; b=jtE8WySK6l/DlZJiUavT8bO27Q
 O/sZOJ/yqxLN9xemov37o+Kqdacq5t9QbgcX34yD38kcHH2tOV71pHA1lWrI/fjoKzUbKxbH7xbhO
 wv3u77j2Fntw8UWql2xdTU1IksaIj4SoNto7wblxTMiqCLAsth0XuHZMUYWopoKYAMq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t/FYEeN9SYMRxzfuvOUUNm8bZlWgx1w0JtUwPKv25gg=; b=WZHIOEKNq9mbGiJMu7bjvH7JlR
 x1aqpdmOxBSvNfluBYtGBhVLsZ8KDDO08pBuQPFNEXZs8dpvgcWeBBsYG3h1q7VJc8OTaAqJTukyM
 hbCRlgvBwhe/uK4mGCPpvaccJ3tUA74jYe5DmjlADvcpqWEpMvO5jL18PBAtkFlQLq2c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodq-0001je-HI for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F63844813;
 Sat,  3 Oct 2026 01:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56D61F000FF;
 Sat,  3 Oct 2026 01:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991257;
 bh=t/FYEeN9SYMRxzfuvOUUNm8bZlWgx1w0JtUwPKv25gg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UBa3YT39C0yc2/n9soB2gvDOK0mrOvBWeYxOPmC8RjsEErj2Jf3LVDM9ZO3livDme
 9flRvYqs2PJEjypVEapUF2DpZIFUuArpa3BFqAkaeFEGKpvq2RQrSA3vfL3YIEIU2N
 I+MNbfdriObgSlvUO3MqEGTILm1BLR3X6u2CgKzYq87jVeLXPb9tsm9+majc0usL7T
 /bSHBzDlAStSRMUdR/TmqulChoNYGmkXMoWAnzv1oFqH2+6Qf6X9AsqV1wAjaJsdhc
 4PYqlL+B9vsMPqQ2qvIgqPwQMVeGLkziezTlEEeDlJCdyNoRk/Puq65p7KG3fjPstO
 YprGgc2/+nBsA==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-3-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-3-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:16 +0000
Message-Id: <20261003013416.D56D61F000FF@smtp.kernel.org>
X-Headers-End: 1xCodq-0001je-HI
Subject: Re: [f2fs-dev] [PATCH v17 02/21] fsverity: expose
 ensure_fsverity_info()
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

PiBUaGlzIGZ1bmN0aW9uIHdpbGwgYmUgdXNlZCBieSBYRlMncyBzY3J1YiB0byBmb3JjZSBmc3Zl
cml0eSBhY3RpdmF0aW9uLAo+IHRoZXJlZm9yZSwgdG8gcmVhZCBmc3Zlcml0eSBjb250ZXh0Lgo+
IAo+IFJldmlld2VkLWJ5OiBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPgo+IEFj
a2VkLWJ5OiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+Cj4gU2lnbmVkLW9mZi1i
eTogQW5kcmV5IEFsYmVyc2h0ZXluIDxhYWxiZXJzaEBrZXJuZWwub3JnPgoKU2FzaGlrbyBoYXMg
cmV2aWV3ZWQgdGhpcyBwYXRjaCBhbmQgZm91bmQgbm8gaXNzdWVzLiBJdCBsb29rcyBncmVhdCEK
Ci0tIApTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQv
MjAyNjEwMDIyMjM3MDUuMjE3NTU0Mi0xLWFhbGJlcnNoQGtlcm5lbC5vcmc/cGFydD0yCgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMt
ZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwK
