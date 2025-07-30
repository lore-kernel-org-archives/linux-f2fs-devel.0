Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDDAC87FCA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Jul 2025 02:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:References:Date:Message-ID:In-Reply-To:To:From:Mime-Version:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fXtOrvB0CMvT01BKtshAmgjx+spA3lkcOPkdQj/ijoU=; b=angR3sCD0Jl6TSTihfTF1AGkUZ
	ADyV6fmDUQlJIjs3nCJixwuE4L2xO+v2zTVeOXp8cGEQsh0ZyY70iEZ7ZnBhCImqLmugkk/AmIUiE
	/GFDXru2MUc3EOZDEL60ykb7ubI+k0Epi8tDQ2S4sfVkbuC3aNgAWnomRXVadBql9vLo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ugwJ5-0000jd-Pe;
	Wed, 30 Jul 2025 02:12:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daejun7.park@samsung.com>) id 1ugwJ5-0000jW-24
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Jul 2025 02:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:In-Reply-To:CC:To:From:Sender:Reply-To:Subject:Mime-Version:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mkmA8L5rsx2MksgjFal39snv5i1UbsJ3M4tQZEhMjxs=; b=CM4PG6J1xBrTU612mdxqTKQID9
 Mx38UFXnHIcflFll2kV3VG7RyAF1qoSWQyZS4M4TW2ZBdrKOp+F1/RpdhQxtfB3PmBlgpNCNatvEq
 2TB2bs9hi0RZ/+21oLxV7WhS85kxdW2Wy7J8/a6fVSVa6XEYMIi7mpyi5TmGeq0MTLko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:
 In-Reply-To:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mkmA8L5rsx2MksgjFal39snv5i1UbsJ3M4tQZEhMjxs=; b=NhVuqCGaBWsKL7qnow1MP+Q8Wt
 rT8CAbYV8s4tvcw5fJU/rVYZEUubCrbwNM/IEpnqviZnZwTRgYeQxw1Q1cVwQ9mf//5+aR9kVzEuZ
 EG5F7PG5gTiinuxDSCijTZokzcXL7ml3+NwiR0+SfSrn3fHCWOk9TJpi/LzmRkV4xbrA=;
Received: from mailout2.samsung.com ([203.254.224.25])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ugwJ4-0004SS-6c for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Jul 2025 02:12:38 +0000
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250730015458epoutp02f969788452d5cc4cb913feb18a2a7808~W5KQwKC463158931589epoutp02Y
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 30 Jul 2025 01:54:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250730015458epoutp02f969788452d5cc4cb913feb18a2a7808~W5KQwKC463158931589epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1753840498;
 bh=mkmA8L5rsx2MksgjFal39snv5i1UbsJ3M4tQZEhMjxs=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=LiSxqmh+ZPIM3WXBGd2858RoeKQitcx9ZWHJ7kRsBhbrMYzw0cjqZ39O8xt4DMnFc
 YWKYq+dnKhT/569s6gDzyWEk+e/n6F8/doD8aBovp+IGBxZrXrIVjra4OQcmgY0c2V
 LMmVVtKCpeFShZPVINAfHgwdCjI8QBBpDthvAwiA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
 20250730015458epcas2p1331d15b6c940b2d88cfed36dcc7d56f6~W5KQfPUgJ0505705057epcas2p16;
 Wed, 30 Jul 2025 01:54:58 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.91]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4bsFdt0qHSz6B9mK; Wed, 30 Jul
 2025 01:54:58 +0000 (GMT)
Mime-Version: 1.0
From: Daejun Park <daejun7.park@samsung.com>
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20250721020231.2482090-1-chao@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250730015357epcms2p63d8a9d98265a526f959e33fa2d7c610b@epcms2p6>
Date: Wed, 30 Jul 2025 10:53:57 +0900
X-CMS-MailID: 20250730015357epcms2p63d8a9d98265a526f959e33fa2d7c610b
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250721020241epcas2p1481962181d9f81f127e122736923fe20
References: <20250721020231.2482090-1-chao@kernel.org>
 <CGME20250721020241epcas2p1481962181d9f81f127e122736923fe20@epcms2p6>
X-Headers-End: 1ugwJ4-0004SS-6c
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't break allocation when crossing
 contiguous sections
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
Reply-To: daejun7.park@samsung.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgQ2hhbyBZdSwKCj4gKyDCoCDCoCDCoCDCoGxmc19kaW9fd3JpdGUgPSAoZmxhZyA9PSBGMkZT
X0dFVF9CTE9DS19ESU8gJiYgZjJmc19sZnNfbW9kZShzYmkpICYmDQo+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXAtPm1fbWF5X2NyZWF0ZSk7DQo+
ICsNCg0KQ29uc2lkZXIgbW92aW5nIHRoZSBsZnNfZGlvX3dyaXRlIGFzc2lnbm1lbnQgdG8ganVz
dCBhZnRlciB0aGUgaWYgKCFtYXAtPm1fbWF5X2NyZWF0ZSDigKYpIGNoZWNrDQpzbyBpdCBpc27i
gJl0IGV2YWx1YXRlZCB3aGVuIGNyZWF0aW9uIGlzbuKAmXQgYWxsb3dlZC4NCg0KPiBAQCAtNDE3
MSw2ICs0MTcyLDEwIEBAIHN0YXRpYyBpbnQgZjJmc19pb21hcF9iZWdpbihzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCBsb2ZmX3Qgb2Zmc2V0LCBsb2ZmX3QgbGVuZ3RoLA0KPiDCoCDCoCDCoCDCoCDCoG1h
cC5tX25leHRfcGdvZnMgPSAmbmV4dF9wZ29mczsNCj4gwqAgwqAgwqAgwqAgwqBtYXAubV9zZWdf
dHlwZSA9IGYyZnNfcndfaGludF90b19zZWdfdHlwZShGMkZTX0lfU0IoaW5vZGUpLA0KPiDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlub2RlLT5pX3dyaXRlX2hpbnQpOw0KPiArIMKgIMKgIMKgIMKgaWYgKGZs
YWdzICYgSU9NQVBfV1JJVEUgJiYgaW9tYXAtPnByaXZhdGUpIHsNCg0KU2luY2UgaW9tYXAtPnBy
aXZhdGUgaXMgb25seSBzZXQgb24gdGhlIExGUyBESU8gcGF0aCwgeW91IGNhbiBkcm9wIHRoZSBm
bGFncyAmIElPTUFQX1dSSVRFIGFuZA0KdGVzdCB0aGUgcG9pbnRlciBkaXJlY3RseS4NCg0KPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWFwLm1fbGFzdF9wYmxrID0gKHVuc2lnbmVkIGxvbmcp
aW9tYXAtPnByaXZhdGU7DQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpb21hcC0+cHJpdmF0
ZSA9IE5VTEw7DQo+ICsgwqAgwqAgwqAgwqB9DQo+IA0KPiDCoCDCoCDCoCDCoCDCoC8qDQo+IMKg
IMKgIMKgIMKgIMKgICogSWYgdGhlIGJsb2NrcyBiZWluZyBvdmVyd3JpdHRlbiBhcmUgYWxyZWFk
eSBhbGxvY2F0ZWQsDQo+IEBAIC00MjA5LDYgKzQyMTQsOSBAQCBzdGF0aWMgaW50IGYyZnNfaW9t
YXBfYmVnaW4oc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IG9mZnNldCwgbG9mZl90IGxlbmd0
aCwNCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpb21hcC0+ZmxhZ3MgPSBJT01BUF9GX01F
UkdFRDsNCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpb21hcC0+YmRldiA9IG1hcC5tX2Jk
ZXY7DQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW9tYXAtPmFkZHIgPSBGMkZTX0JMS19U
T19CWVRFUyhtYXAubV9wYmxrKTsNCj4gKw0KPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KGZsYWdzICYgSU9NQVBfV1JJVEUgJiYgbWFwLm1fbGFzdF9wYmxrKQ0KPiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW9tYXAtPnByaXZhdGUgPSAodm9pZCAqKW1hcC5tX2xh
c3RfcGJsazsNCg0KTGlrZXdpc2UsIGNoZWNraW5nIG9ubHkgbWFwLm1fbGFzdF9wYmxrIGlzIHN1
ZmZpY2llbnQgZm9yIHJlc3RvcmluZy4NCg0KUmV2aWV3ZWQtYnk6IERhZWp1biBQYXJrIDxkYWVq
dW43LnBhcmtAc2Ftc3VuZy5jb20+DQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZz
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
