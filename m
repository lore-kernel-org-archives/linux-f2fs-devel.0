Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B27C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IndxOK4k+pT46T6Mu9wxahJi1Khx2h7bVUDE4p+D1ug=; b=RSMmKF2L4SXg65PuWKuCqgeJtS
	eQSHEPs6fyXwTpbQGDyZdfcZlyJPa6B9F7EmghsTdDPM8wc53xBy/cyBuUyALLSWEN31QT0cqWfO0
	T7xgcSDnbVtCia6G90sBz2gUSEUi18uCdYXac0sqcXi1mBqYaneXN6RdNqERVFBN8AqM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzwzY-0006Pq-M5;
	Fri, 28 Aug 2026 13:51:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1wzwzX-0006Pi-Ed
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:51:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XAnD7NW3HgGrLJN+k5MWmmddWuXIabMVCPIQ0ZkBUSo=; b=j8ShesKo3mq59noe5TGVmLhXjD
 64Bw4XSOoXzTHyAGlrfs5jyi868w8lIBJy9cQ1ee6io005xstgIGga53XoW6DTuG9+HOaU6aRsfau
 sfOPz5CETz/gS5Ump2tVAAc9Sh9yNYvz8M42HsHMRITFaZUIfuico8jp/bcP90NjfSe4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XAnD7NW3HgGrLJN+k5MWmmddWuXIabMVCPIQ0ZkBUSo=; b=OlfvGQo5+byiDUpbF618z0mp58
 G5LFWGyoc3frtZVr+XXN6KGTtFyVfmKXlDAR93ChkFC+rI7q72XkQ/q90wr8vOwkszjqIYKBcvBLM
 26sM4PB0s+59B+tMJH+xDzaBNt8afhpFjbbV7QItJH1qo/1Cmn2PfJ7sdNPCfm/h+Pjs=;
Received: from mail-koreacentralazon11023085.outbound.protection.outlook.com
 ([40.107.44.85] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzwzS-0006jE-CD for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcvxpMqqKol/0SChNUo4cVpXLQ+A/qQ1a4l9Cug7Xq5+h0lIs0HaqGhADBquVw0g/RdkpDfOMgS2f/jJyhApkemdX9FbiDV1RCSn1RRZE4TqF1oGiU38FffzPueIkC2K/tFJhOjLkkhzdNkGQh26rBFHUgHdHVnuaO+BmkrN674/dcIOu1b5fp61+bqv2OWuBUL//pluZTfpeZ5+0IyIWJf3Ao3fyUIEgD+b43b7IZEES7ujcNH+C3SFOWuztDeaAmbYnXZEAmyQ+dqTFmO6kk9LhMmVqiYYB+7wDvjuhskideoW6qxYy+7kUkgv2mrOCyKnAsfK+rTsZHhqhNYKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAnD7NW3HgGrLJN+k5MWmmddWuXIabMVCPIQ0ZkBUSo=;
 b=oKksicS1M3QGsjECBoNHWkZbWIXqdJvXhgfhZ1nvMpEwgZEOzBWo19NJYqWW6RYu2O0pz5MLwtEeW9EaY4ipymFtvEbOc8wu0CmY+d8E3OEaRWuNzADrFZHfnDxpI2DPRZO2JmBEUDcumZ5d+xMlm8x1FVtbp+nC8Sp4LdTMb+ICM9f1E1RdKf5wx58GJgFoVVTLu0Q+rltfoQQGAJwEVA6WpcKMP6we6ql5hPHQhVPsuXfIvAvZD6yaeJdnP7oca92e/xXxgkQgtjzLR1uMEWSTHir9B1rr3WOvPaBfbm5+DKQ8lp1TbO6DgzF3VB/I6rZ6Euhz3HUeAtvmNw/wWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAnD7NW3HgGrLJN+k5MWmmddWuXIabMVCPIQ0ZkBUSo=;
 b=HLACF3EeQnFZQF2Lm1STX0qPxQScoG1z35Des1r3nme9KT56sib94e/Cy5bf5Elbl1NHLc1Hgdd5qaAP4h0kLQmHTBqipSx8PRGwbVhVGF1Hwp5p/f4mJnz802mzEHwLoDe5dAg7OYW7LRt4gQoP28n5IV64p6cb/3WPK01Uag4=
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5)
 by TYSPR04MB8074.apcprd04.prod.outlook.com (2603:1096:405:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:18:42 +0000
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605]) by KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605%3]) with mapi id 15.21.0360.003; Fri, 28 Aug 2026
 12:18:41 +0000
From: =?iso-2022-jp?B?GyRCTXsyURsoQjEx?= <ke.li11@transsion.com>
To: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Thread-Topic: [PATCH 1/2] f2fs: add alloc_primary mount option
Thread-Index: AQHdNudcyX9ZYWVVTUyngBkWc1pPag==
Date: Fri, 28 Aug 2026 12:18:41 +0000
Message-ID: <20260828121816.1463654-2-ke.li11@transsion.com>
References: <20260828121816.1463654-1-ke.li11@transsion.com>
In-Reply-To: <20260828121816.1463654-1-ke.li11@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6611:EE_|TYSPR04MB8074:EE_
x-ms-office365-filtering-correlation-id: b7028695-ea9b-466a-8e4b-08df04fe7f55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|23010399003|376014|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: CKQk303XJ3OfeI8qaAe2nnjc3A1nJwsu/m3oRyYGX4nxoEfphpQbtJaAky0AZn6zs5q6Zd4tu0sum2CDfMZMNu4ju+cM+G3C5zd2TQWoq361XvL5nOBqknI5upDT+6Einz2VkuRtO4gvYhM2Z/UU9xSFat3ew4bVGP9KaJ1lrD2bszsz7rj4eqriGIa4kVei56sx/qy1tOG+NqIMaL540aD9bUVGq/UQ6Tw/pShJ0ewVFbF3xLorqqPTOeadKn9kVmiWonywMlvIB8u8BdY1pLg0Z3iLZMa4O+c3APC6dyxruB8vcvhk5gXRUxRzTM0KiTHcac3Zj4LvNO94FX8KkGjKQD9KaRoSGfAXmnSwq/k+6L5sWjTaw9RkCPL4/TvJqQ6ThophbkI2mMSeJKOjPoaMOUB9kShNCyXhN52+fSowuPFQWfwoSQNwPEHwXNAJi6SlPkAeRfrQj4Grc0BT1bnLz/3rM36TZm9OMAy02NptGpz3Z1MvVr4gbNPhujdBk7HNTi3xSoB6epINulhiZmW+fVmKgClVYc5X2vf8dTy0QhPV1C+i5lhIabR2+yNx84JGlubxiYAQWfMhx+nd+SZSoWfVUiv2aWqotFAUuXp7Abq5PJqQkdKfpCylHGeNKaShodkk7koYiXQWitYwKxkLf/SWb6oLtp+p94DKqNC46gp+foluJsNTtBcXvUHRCqZnEbRPYSBGFZgyiJHmF9XXWuOiwkA2g9CGT2eY7/g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0401MB6611.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(23010399003)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UjgvSUxKaHloZGtUTktZYnhFZ0wzTDJhbjM5dm9aY2VXYitZb2Z4VWdW?=
 =?iso-2022-jp?B?MkZpaGpnZGIvQ1Y1SThlK3F0WVVuMlhIS0hCV3VSNU9NTkFPdGUzMVRt?=
 =?iso-2022-jp?B?RGtYQUVDTE13VEpUc29SUXkzVExEeDVJZ2JQZ2ZzNE5ORGJTZm1tM0F4?=
 =?iso-2022-jp?B?dmpYV2ZxK0Q2YmtPUXpVMjM1eE9PV21oWnF3aWY5ZnZ1a3FJUld5cHl2?=
 =?iso-2022-jp?B?VlY0TFVUTFg5SVFIM2NOM0k1Q2hZT0hESUJ4VkhUMnJ2MmVKQU5HQ1o5?=
 =?iso-2022-jp?B?T2xtUXlIVERpbDB1TUtXY29xU2F4M1lqa1pPbi9qQTk4RzFLc1lLKzFt?=
 =?iso-2022-jp?B?MFptbklaT1ZOSUNOKzh5aHpFcjBNcXBZZjdZdXZ5a0h6dTE1WVRNcG5D?=
 =?iso-2022-jp?B?N3JIRmZGL2dWU0tlYkYrOHIxQmhoY0VYUmppWFBGbDBzQTZRUzZvclFD?=
 =?iso-2022-jp?B?TU9mbFFmY1E2YUJLNENWZUdpTnFzd0oraVl6R0YyUHFsdzRyc1V6TWRU?=
 =?iso-2022-jp?B?TjZWNWplMzJkREkyTkdvYnJ2OG9vVkFPZUw3a08rUDlkL05BQkxBdGpy?=
 =?iso-2022-jp?B?bWkyNnVwRTk4cElHUXpldHJzbDNudFZWQVlJQmpBRGhxcG1OTjh1bGdn?=
 =?iso-2022-jp?B?bjN0c3Rvb2lvck96OFBNM2tKaHd0MHVVWDB4WUJDZjhDVDFpZXNKcm9T?=
 =?iso-2022-jp?B?REdkdDRFNFpwcEZUWVRSNHc1b3pzRDZYN25ENkRYdmFkaXV2MURVeWtF?=
 =?iso-2022-jp?B?R0JaVGs4ejRaUmNBbURoNG81M3FBQmZyMTVWcGFxM2t0d29CS2pjL2sx?=
 =?iso-2022-jp?B?ZUxmTDF0NzJoY3RDOHU4WEp1NDBzUVVyK1MwdmYwbjlKNkU4VEFCc1kv?=
 =?iso-2022-jp?B?U3hjNjJpKzJ6a0dMeDBlNkZrRGkvczdSTHdSek1FazdINVIyRDFPUHU3?=
 =?iso-2022-jp?B?blg0N1pDejkzNFVBOHY3ODAwZnN4SEZuZExOaDFacUNKOU5hYTBMWE05?=
 =?iso-2022-jp?B?S1l3dWw1UzlIN1FSaUZLSXRJbEJpTzViRFg4UXV4QTlnSyt6MXdXU0I2?=
 =?iso-2022-jp?B?UitFeVVxSE5kMkdLcyt1UnZGalkyaTVEUktWdWZOSG05Tlh4RFNwbGM1?=
 =?iso-2022-jp?B?V3MyOHlOZG5lWVlLWWdKSDE1aGZ1dnVnNnlGVEdGSGF3MURjaHFtMmJw?=
 =?iso-2022-jp?B?RVJ5bzV4MFlYRmlGK05CbmxGWkJBU3BSSnlsekNvNmFpY1lYTVMzVHFS?=
 =?iso-2022-jp?B?cG1aMW5iMVhhdk5aUEJhU3VVZ1FrdFpUQUgxVXJqNy9pRXVXVlAxaWtk?=
 =?iso-2022-jp?B?c0piZExOQzNuei9HOHRVVjNlcmZrNjRSVG1UUDFrcmtkbWhZKy9HbFlR?=
 =?iso-2022-jp?B?QTUrT0Q5THpOSUc1Q3c2YTVRNG1vak9kWmNoOFF3V3Uva1F6eDhjNWQ3?=
 =?iso-2022-jp?B?SmlUSGVYUmt3YzZUZ3JKcENMZWoxVmxUMzMrRDhmc3ZGTHp2MWF1QnVy?=
 =?iso-2022-jp?B?cFVweDlOUCsyRysrMkpSY21QeHUvWlNoR0ZpUzEzSHdLQ1Jsa1ZOT0kz?=
 =?iso-2022-jp?B?VGUvWDRMaWNaTjFESXlNN01nc1JwdUh2MUNtYnRsbnhpVVhXeWg1SE4x?=
 =?iso-2022-jp?B?MjFCUytlOWVQbDBkeFRacC9TOHlLSkc0ck9lUFllaGU4d2ZJZW1ocGVt?=
 =?iso-2022-jp?B?QkVTa01NNWIwcW5lM004SGYzN0ZaZTVOR1hZUk5seFlCTkxtbEYxRGRH?=
 =?iso-2022-jp?B?OGF1YmpGSnB5cHZKbk1YN1pid1IybEg5R1d4SVpOTURtNENsWWIxL3Zr?=
 =?iso-2022-jp?B?eWlHMC9kaHZjNGg3bGNTS1Q3ekRCdXhYbHFsdjdKNndaaTlwQVRKL3Mw?=
 =?iso-2022-jp?B?Q2RoaU1LVm9jMXUzKzcvMTVtKzRuTm5XYzRJaVl3Y2VsRzZMMU5PdnhU?=
 =?iso-2022-jp?B?ZjBxQTVBNktwZSszdkR4SmkrbzVuSlVnczZBc0JENHFveDJNZG9YTG5P?=
 =?iso-2022-jp?B?a1kyaXhoYUV4WHNlSUllNlkwVGxlb3V3OGlySjMybWlDbUZuSG1wdkJo?=
 =?iso-2022-jp?B?emNoSUxXYjg2YzdoRDhnb3RNWGk5cTYzS08rdnRZWUVpYkp5YXNBdjJN?=
 =?iso-2022-jp?B?OFNpRGhiY0h1aGNGb3haYXZEYTQ0TXIyVUN6Q0lIM0VRSHA4MUVoQWxU?=
 =?iso-2022-jp?B?eXdNY3RTVE9BY09FdWZjTTZWQjZwcXdPSmtOTE9xYUNDKzNTS25aN3pT?=
 =?iso-2022-jp?B?eldXSEc3N3JqeGdHc3VYWUVvdGU4bVBaQzVpWXRFck5lTElYRmxwRjNv?=
 =?iso-2022-jp?B?aXlPTUFVd043bGs2SGZrTWRTWGNGY1BmRkJJMFJwS1hVbXFzMzIxN2o0?=
 =?iso-2022-jp?B?eHZOVVU3cVR0bXhRUmFVTGVqOUM2ZG1VcGh2K2g2YTlGYU5DekpSNkRz?=
 =?iso-2022-jp?B?NllQSFI2R2lzTzdiWTBJUmxRNEg5N1lqYjJEdlUvT0s4UEtpc1lPajRl?=
 =?iso-2022-jp?B?QmNNN2xLMEdzTHNqeWc2Zlc5eHlIUDNUOFFCdz09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6611.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7028695-ea9b-466a-8e4b-08df04fe7f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 12:18:41.4011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9IDROHD9+i5HBwsNRP4Fevm0FuHcKE8m9WvSclElC1TuWHRmfDF9cV/40JCKNg3gj2LPPkiqeJZOysOrfiSBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8074
X-Headers-End: 1wzwzS-0006jE-CD
Subject: [f2fs-dev] [PATCH 1/2] f2fs: add alloc_primary mount option
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
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 =?iso-2022-jp?B?GyRCTXsyURsoQjEx?= <ke.li11@transsion.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: "ke.li11" <ke.li11@transsion.com>

In multi-device setups, F2FS steers warm/cold data to the secondary
device by setting ALLOC_NEXT past the primary device end.  Add an
alloc_primary mount option to keep such allocations on the primary
device when userspace manages expandable storage on a separate volume.

Document the new option in Documentation/filesystems/f2fs.rst.

Signed-off-by: ke.li11 <ke.li11@transsion.com>
---
 Documentation/filesystems/f2fs.rst |  3 +++
 fs/f2fs/f2fs.h                     |  6 ++++++
 fs/f2fs/gc.c                       |  3 ++-
 fs/f2fs/super.c                    | 12 ++++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index b45d7a687625..f065639d931d 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -395,6 +395,9 @@ errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
 			     ====================== =============== =============== ========
 nat_bits		 Enable nat_bits feature to enhance full/empty nat blocks access,
 			 by default it's disabled.
+alloc_primary		 Keep warm/cold/pin data allocation on the primary device
+			 in a multi-device configuration.  Without this option, F2FS
+			 steers ALLOC_NEXT segments to the secondary device.
 lookup_mode=%s		 Control the directory lookup behavior for casefolded
 			 directories. This option has no effect on directories
 			 that do not have the casefold feature enabled.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8376bbe58ee3..2db4d6a2837a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -266,6 +266,12 @@ struct f2fs_mount_info {
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 	unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
 	unsigned int lookup_mode;
+	/*
+	 * alloc_primary: keep warm/cold/pin allocation on the primary
+	 * device.  Skips the multi-device ALLOC_NEXT hint that would
+	 * otherwise steer them onto the secondary (expand) device.
+	 */
+	bool alloc_primary;
 };
 
 #define F2FS_FEATURE_ENCRYPT			0x00000001
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ffaa7ba76a1b..c5c243e6d3b2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2147,7 +2147,8 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
 
 	/* give warm/cold data area from slower device */
-	if (f2fs_is_multi_device(sbi) && !__is_large_section(sbi))
+	if (!F2FS_OPTION(sbi).alloc_primary &&
+	    f2fs_is_multi_device(sbi) && !__is_large_section(sbi))
 		SIT_I(sbi)->last_victim[ALLOC_NEXT] =
 				GET_SEGNO(sbi, FDEV(0).end_blk) + 1;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index be22c31015ef..3df06c525a2c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -235,6 +235,7 @@ enum {
 	Opt_jqfmt,
 	Opt_checkpoint,
 	Opt_lookup_mode,
+	Opt_alloc_primary,
 	Opt_err,
 };
 
@@ -366,6 +367,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_flag("age_extent_cache", Opt_age_extent_cache),
 	fsparam_enum("errors", Opt_errors, f2fs_param_errors),
 	fsparam_enum("lookup_mode", Opt_lookup_mode, f2fs_param_lookup_mode),
+	fsparam_flag("alloc_primary", Opt_alloc_primary),
 	{}
 };
 
@@ -404,6 +406,7 @@ static match_table_t f2fs_checkpoint_tokens = {
 #define F2FS_SPEC_errors			(1 << 23)
 #define F2FS_SPEC_lookup_mode			(1 << 24)
 #define F2FS_SPEC_reserve_node			(1 << 25)
+#define F2FS_SPEC_alloc_primary			(1 << 26)
 
 struct f2fs_fs_context {
 	struct f2fs_mount_info info;
@@ -1235,6 +1238,10 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		F2FS_CTX_INFO(ctx).lookup_mode = result.uint_32;
 		ctx->spec_mask |= F2FS_SPEC_lookup_mode;
 		break;
+	case Opt_alloc_primary:
+		F2FS_CTX_INFO(ctx).alloc_primary = true;
+		ctx->spec_mask |= F2FS_SPEC_alloc_primary;
+		break;
 	}
 	return 0;
 }
@@ -1763,6 +1770,8 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 		F2FS_OPTION(sbi).errors = F2FS_CTX_INFO(ctx).errors;
 	if (ctx->spec_mask & F2FS_SPEC_lookup_mode)
 		F2FS_OPTION(sbi).lookup_mode = F2FS_CTX_INFO(ctx).lookup_mode;
+	if (ctx->spec_mask & F2FS_SPEC_alloc_primary)
+		F2FS_OPTION(sbi).alloc_primary = F2FS_CTX_INFO(ctx).alloc_primary;
 
 	f2fs_apply_compression(fc, sb);
 	f2fs_apply_test_dummy_encryption(fc, sb);
@@ -2543,6 +2552,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_AUTO)
 		seq_show_option(seq, "lookup_mode", "auto");
 
+	if (F2FS_OPTION(sbi).alloc_primary)
+		seq_puts(seq, ",alloc_primary");
+
 	return 0;
 }
 
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
