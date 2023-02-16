Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A87C61DA4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Feb 2023 08:49:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pSZxV-000636-NO;
	Thu, 16 Feb 2023 08:49:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lukas.horvath@amblevebiz.com>) id 1pSZxT-00062j-T5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Feb 2023 08:49:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mG5KF9rXIT2hCcIXZaMY449X9Ndwb1czFhgZLlqDg7A=; b=f0aWoK21RSqKZkPkfx7GJU2BZJ
 UpqwbeyDIun2rqIcOWihuqi0Pm5Oc1GCkpMHfuKtNKhanIKKSG0v1hZZ8HBsUmYiw1KjbMj0BCEOt
 uSjEP53//qs8YPghUafzNVvU3Mx8hnqwUpDYTqtXYR/dtW5VmEhLgnaMSJv7cQlFOS9E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mG5KF9rXIT2hCcIXZaMY449X9Ndwb1czFhgZLlqDg7A=; b=U
 bPKCZ4+aEIrdPAMxm3AJKaWccdYHcKoo/tC5nNpArWxW6odtR//CVUIUIs88qmi09N8azC6P1f4Vm
 hcg6Yorxk2iwLEKHamkhO1yaDk9oOVEK+wlGZ1ncP+N8jtMIQ1NQLZmI9EdfC+X3eoaTDcCr9cCSN
 ji8PqfYMeItMV/Ts=;
Received: from mail.amblevebiz.com ([80.211.239.97])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pSZxQ-0004WI-Al for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Feb 2023 08:49:39 +0000
Received: by mail.amblevebiz.com (Postfix, from userid 1002)
 id D83EC82244; Thu, 16 Feb 2023 09:29:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=amblevebiz.com;
 s=mail; t=1676536203;
 bh=mG5KF9rXIT2hCcIXZaMY449X9Ndwb1czFhgZLlqDg7A=;
 h=Date:From:To:Subject:From;
 b=wqsc1aWG/ZeVEZGu/2KotNIvap0HchCEaFnjpv/7nMUQ2N+gB78SNUoM9c/q6JQaD
 JtOeTwygWNRyUR8Vf3tUnze7Tr3/cMs4/+pcdFHJQLBctUaql4Aj6EBZftmEsVkMVJ
 ICmVy5DIdDlZnjdK0EL0k8mZH62+hHg2l/R6+QerPR7Q5mnVCi1k6cTLR9qUCpfeBe
 BfG8j/4SvqU13uwYLN0IOT68IqbZaYRQRlE2WFTbNuCuM4elQXy3Xl8RfCAPh+jajt
 qRZOgBwRx9ELMhvid69LzYCODxrFDgc9GsG6gEq0tc5Dd9g3AReGnqZSrGl9xVRx4/
 V45mkWPZW98KA==
Received: by mail.amblevebiz.com for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Feb 2023 08:29:36 GMT
Message-ID: <20230216083000-0.1.6.161.0.s55mg0lpbf@amblevebiz.com>
Date: Thu, 16 Feb 2023 08:29:36 GMT
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.amblevebiz.com
MIME-Version: 1.0
X-Headers-End: 1pSZxQ-0004WI-Al
Subject: [f2fs-dev] =?utf-8?q?Technick=C3=BD_audit_podlah?=
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
From: =?UTF-8?Q? Luk=C3=A1=C5=A1_Horv=C3=A1th ?= via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: =?UTF-8?Q? Luk=C3=A1=C5=A1_Horv=C3=A1th ?=
 <lukas.horvath@amblevebiz.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RG9icsOpIHLDoW5vLAoKdXZhxb51amV0ZSBvIGJlemVzcMOhcm92w6kgcG9kbGF6ZSBwcm8gdsO9
cm9ibsOtIHByb3Zvej8KCkpha28gc3bEm3RvdsO9IGzDrWRyIHZlIHbDvXJvYsSbIGEgcG9rbMOh
ZGNlIHBvZGxhaCDFmWXFocOtbWUgcHJvYmzDqW15IHZ5cGzDvXZhasOtY8OtIHogdmxpdnUgY2hl
bWlja8O9Y2ggc2xvdcSNZW5pbiwgb3TEm3J1LCBuw6FyYXrFrywgdmxoa29zdGkgbmVibyBuw6Fo
bMO9Y2ggem3Em24gdGVwbG90IC0gbmHFoWUgcG9kbGFob3bDqSBzeXN0w6lteSBqc291IHDFmWl6
cMWvc29iZW55IG5lanTEm8W+xaHDrW0gcG9kbcOtbmvDoW0gcHJvc3TFmWVkw60uCgpHYXJhbnR1
amVtZSB2w6FtIMWZZcWhZW7DrSwga3RlcsOhIGpzb3UgxaFldHJuw6EgayDFvml2b3Ruw61tdSBw
cm9zdMWZZWTDrSwgb2RvbG7DoSBhIHNuYWRubyBzZSDEjWlzdMOtLCBoeWdpZW5pY2vDoSwgcHJv
dGlza2x1em92w6EgYSBiZXpwZcSNbsOhIHBybyB6YW3Em3N0bmFuY2UuCgpQb3NreXR1amVtZSBr
csOhdGtvdSBkb2J1IGluc3RhbGFjZSBhIG5lcMWZZXRyxb5pdMO9IHByb3ZveiBpIG8gdsOta2Vu
ZGVjaCBhIHN2w6F0Y8OtY2gsIMSNw61txb4gZWxpbWludWplbWUgcml6aWtvIHByb3N0b2rFry4K
Ck1vaHUgVsOhbSB6ZGFybWEgbmFiw61kbm91dCB0ZWNobmlja8O9IGF1ZGl0IHBvZGxhaCBzIGtv
bXBsZXhuw61tIHJvemJvcmVtIHBvZGtsYWR1LgoKTcWvxb5lbWUgcHJvIHbDoXMgbWx1dml0IG8g
xZllxaFlbsOtY2g/CgoKTHVrw6HFoSBIb3J2w6F0aAoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
