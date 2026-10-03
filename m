Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84936CA5FE8
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uOSmysJJ1LdZ81BQJ+fri2J0Exz+QYd+UHIbPz9gl+0=; b=ACCgcCj04rovPjFPsdpkuquUZR
	znECXbVBaoN3/2mk59WWmmehBZV/khDo/sxM9CSnMSr2/hzYZuEOi+yMmI15/JFnJlb3Cr65JbDha
	h/quoreBVrKbAC8tIbGekbXlwmVsGZrurD10SPtTJ5e6t3pcWqrcyHTGtZf3xVvTqao4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodo-0005I0-Ss;
	Sat, 03 Oct 2026 01:34:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodn-0005Hp-V3
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D7v4czSqaQOBll9kIxMZsEZsf1OcWxv9pCd6XdjqECM=; b=evzLMLO7ltR55yRvbGsAZnWpM+
 4BqB4AXpu2ra+oCVW6ndAihpvmKas+aPHnu82sRV6cAzDJDhNhhOj/zxtPJ9NCQMSOluhxxZzMD6v
 i/VlIZemt87Q4AYPjqpElRrSI0rlusQq0n2FEVB3GLdmzwsEbLLvci7ABwUdywmC8Cy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D7v4czSqaQOBll9kIxMZsEZsf1OcWxv9pCd6XdjqECM=; b=lgejvNGQOUivl0NZxaTQrla1uj
 s89NUTe40DvZGHqKRRBkf4fNOLtLIv8qbG+uUGOFNOs/gZCVxjO4CNoXBJ+C8i02wH2gBDTplhb8A
 pvjWzOspWUqMBR2lzEBk+OK0SpY66PYDM2Ff5FOiSvv84eACYOkoQiDLe1N6a7E+E0GU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodn-000718-DH for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FFB744815;
 Sat,  3 Oct 2026 01:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A921F00899;
 Sat,  3 Oct 2026 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991254;
 bh=D7v4czSqaQOBll9kIxMZsEZsf1OcWxv9pCd6XdjqECM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FNcwYxPqOwjEgtkKz9pxX/mvvgyoCcTiB47GYVeD89oGVGaREQBqe0XeMf6CZ0Eu3
 actWcWjF5Tr3XHdLI+9s9ZrxTmF5qCfZxP7c7uLoS4QmPRQ0USLWgI3hA9HwmEMg28
 Oy+/tySqm795gucmI3yYJmbMkY8GmvCqTFxaPh0b7Qlt175uJuYL4UlLKAG530Eswf
 QGIolBEtUc4DhAESYuV6gg80v2DHLfgmderbl7w1xuwiHSvgK4qQUe4BpjYnfQhz0r
 PfvQqUvBtEeAfnGnPwPABY6uUFEeO5ayN2P2x0eY4LKCsdjEQ2LK2c1sbKaRNevkTR
 DaHyt7NCDE3CA==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-19-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-19-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:13 +0000
Message-Id: <20261003013413.B4A921F00899@smtp.kernel.org>
X-Headers-End: 1xCodn-000718-DH
Subject: Re: [f2fs-dev] [PATCH v17 18/21] xfs: advertise fs-verity being
 available on filesystem
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

PiBGcm9tOiAiRGFycmljayBKLiBXb25nIiA8ZGp3b25nQGtlcm5lbC5vcmc+Cj4gCj4gQWR2ZXJ0
aXNlIHRoYXQgdGhpcyBmaWxlc3lzdGVtIHN1cHBvcnRzIGZzdmVyaXR5Lgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+Cj4gUmV2aWV3ZWQtYnk6
IEFuZHJleSBBbGJlcnNodGV5biA8YWFsYmVyc2hAcmVkaGF0LmNvbT4KPiBSZXZpZXdlZC1ieTog
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEFs
YmVyc2h0ZXluIDxhYWxiZXJzaEBrZXJuZWwub3JnPgoKU2FzaGlrbyBoYXMgcmV2aWV3ZWQgdGhp
cyBwYXRjaCBhbmQgZm91bmQgbm8gaXNzdWVzLiBJdCBsb29rcyBncmVhdCEKCi0tIApTYXNoaWtv
IEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjEwMDIyMjM3
MDUuMjE3NTU0Mi0xLWFhbGJlcnNoQGtlcm5lbC5vcmc/cGFydD0xOAoKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
