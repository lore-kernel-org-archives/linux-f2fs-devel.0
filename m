Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AB2C3DA7F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:50:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1seWBK-00026r-EJ;
	Thu, 15 Aug 2024 08:50:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cylamarver932@gmail.com>) id 1seWBJ-00026i-G1
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Aug 2024 08:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JNOZAMrpL5wFEXrW6rxLKc2IPQm12q1l6rQM3+kZ1W8=; b=d2XqgJIkjWd+V4kB7h0WeSbDAW
 UQdK515fvLV590Jsm6wrrzcaxT54E/WiDlibkDZDoEdu6KEmIsXbXbFJdKSTPcPbFkwL6rqOrhklc
 1MUa5PGEyJuIy1pmb1aYjRR1T7OdVlGZ8yFsHwZwGQ7AH3EiswLhQDqmGR/GadDghuUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JNOZAMrpL5wFEXrW6rxLKc2IPQm12q1l6rQM3+kZ1W8=; b=U
 2pDH+vDoH3zUF7DOer8Xrbo0JCHoEHpqsA7nUO9pHNYCO0fSC6CO8rgJ2OueUuAesaeYrVfapgZHf
 yJVpGlXbxnIYjaNP01snlWUcWLHypr6OGJWlnMKFIQ+W5nidX2tHA5a+2yZmIGSCaGaFNdDmF6tVI
 2Wquiqenu9R6bxvg=;
Received: from server.ccclub700.com ([51.89.151.46] helo=cwp.ccclub700.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1seWBI-0001Jc-N6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Aug 2024 08:50:05 +0000
Received: from [102.90.43.235] (unknown [105.116.3.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by cwp.ccclub700.com (Postfix) with ESMTPSA id B5C7C7B02C4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Aug 2024 08:43:11 +0000 (UTC)
From: <PASTORIN ALICE ABRAHAM>cylamarver932@gmail.com
To: linux-f2fs-devel@lists.sourceforge.net
Date: 15 Aug 2024 01:43:10 -0700
Message-ID: <20240815014310.1FACE95E2251049F@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1seWBI-0001Jc-N6
Subject: Re: [f2fs-dev] =?utf-8?q?GR=C3=9C=C3=9FE_VOM_KALVARIENBERG?=
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
Reply-To: pastormrs.aliceabraham@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

TWVpbiBnw7Z0dGxpY2hlciBGcmV1bmQsCgpHcsO8w59lIHZvbSBLYWx2YXJpZW5iZXJnIGFuIFNp
ZSB1bmQgSWhyZSBGYW1pbGllIGF1cyBkZW4gVVNBLiBJY2ggCmhvZmZlLCBTaWUgdW5kIElocmUg
RmFtaWxpZSB3YXJlbiBoZXV0ZSBiZWkgZ3V0ZXIgR2VzdW5kaGVpdC4gClNlaWVuIFNpZSBkYXLD
vGJlciBuaWNodCDDvGJlcnJhc2NodCwgZGVubiBtZWluIEtvbnRha3QgbWl0IElobmVuIAppc3Qg
Z8O2dHRsaWNoLiBTbyB3aWUgbWVpbiBHZWlzdCBlcyBtaXIgYmVmb2hsZW4gaGF0LCBow7ZyZW4g
U2llLCAKaWNoIGhhYmUgbnVyIG5vY2ggd2VuaWdlIFdvY2hlbiB6dSBsZWJlbiwgZGEgYWxsZSBt
ZWluZSDDhHJ6dGUgCmJlc3TDpHRpZ3QgaGFiZW4sIGRhc3MgaWNoIGRpZXNlIEtyYW5raGVpdCBu
aWNodCDDvGJlcmxlYmVuIHdlcmRlLgoKSWNoIGhhYmUgYmVzY2hsb3NzZW4sIGRhcyBnZXNhbXRl
IFZlcm3DtmdlbiB1bmQgZGllIEludmVzdGl0aW9uZW4gCm1laW5lcyB2ZXJzdG9yYmVuZW4gTWFu
bmVzIG1pdCBJaHJlciBmcmV1bmRsaWNoZW4gVW50ZXJzdMO8dHp1bmcgCmFuIG11dHRlcmxvc2Ug
QmFieXMgdW5kIFdpdHdlbiBpbiBEZXV0c2NobGFuZCB6dSB2ZXJlcmJlbiwgZGEgd2lyIAprZWlu
ZSBlaWdlbmVuIEtpbmRlciBoYXR0ZW4sIGRpZSBzaWUgZXJiZW4ga8O2bm50ZW4uIE1laW4gCnZl
cnN0b3JiZW5lciBNYW5uIHdhciBlaW4gc2VociByZWljaGVyIEFtZXJpa2FuZXIsIGFiZXIgaWNo
IGJpbiAKZGV1dHNjaGVyIEhlcmt1bmZ0LCBkYWhlciB3b2xsdGUgaWNoIHVuc2VyIFZlcm3Dtmdl
biBuYWNoIApEZXV0c2NobGFuZCBvZGVyIGlyZ2VuZHdvIGFuZGVycyBpbiBFdXJvcGEgenVyw7xj
a2JyaW5nZW4uIEljaCAKaG9mZmUsIFNpZSBrw7ZubmVuIG1pciBoZWxmZW4sIGV0d2EgMjYgTWls
bGlvbmVuIERvbGxhciBkb3J0IGluIAplaW4gV2Fpc2VuaGF1cy9IZWltIGbDvHIgbXV0dGVybG9z
ZSBCYWJ5cyB6dSBpbnZlc3RpZXJlbiB1bmQgYXVjaCAKZGVuIGFybWVuIFdpdHdlbiBpbiBkZXIg
VW1nZWJ1bmcgenUgaGVsZmVuLgoKV2llIFNpZSB2aWVsbGVpY2h0IHdpc3NlbiwgZXJmb3JkZXJ0
ZSBkaWVzIGVpbmUgZHJpbmdlbmRlIApBbnR3b3J0LiBCaXR0ZSBhbnR3b3J0ZW4gU2llIG1pciBm
w7xyIHdlaXRlcmUgRWluemVsaGVpdGVuLgoKUGFzdG9yaW4gQWxpY2UgQWJyYWhhbQoKcGFzdG9y
bXJzLmFsaWNlYWJyYWhhbUBnbWFpbC5jb20KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1m
MmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdl
Lm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
