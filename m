Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439C4C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LSfEa7RYJg/JJ2SXfCKNkC6dHTVVEfEPButngVlNBgs=; b=T5N7xkdjQfs/HI1ItBs4I/Zm8D
	vDt1n6wHKzGC0h841/D8Zy2yCSmRXpnnrBtrOpkhnR2XLweiG+jFww8nPtjdQ12RViPoJnaLdJKWs
	bYlDtiXQJxDt7JfRaSFCC1UUE/M50lW2oT6jfoRZcBT45/D8MXttFFdDFeSBM8nfvQJw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzw3o-0001LT-KM;
	Fri, 28 Aug 2026 12:51:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1wzw3n-0001L8-8Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t01yi1nox2TJ4LBFe5bGIiw1hu6OuiO953GFUdDqzUI=; b=QnzdYxTVZoMtI9jCeSd6EnAFle
 uMHMeoNeH3SJx13bs8psGu4UxUB3j+TBTssJg49pml3xYNYJ+tdI3g7Il9+MKC5HZeesOrJE8rFKk
 Tco08xrC3zxXup82Asz85oDNizZjhdYIFEpZYh6FF4+hJ1dzwTaNnjVbilMxRNFBCps4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t01yi1nox2TJ4LBFe5bGIiw1hu6OuiO953GFUdDqzUI=; b=il4+UnarhpEtmxChy3pYmuRK3Z
 kBVX5Bvkj3qs/Vd5bzkKSNww+6qwW5qYSfNCH/0z/uNHDC3T2bwnx5MwHKzKsDWKZY8Mf52e2FN4s
 Alt5TMpHx08RrojAjh7n0ODEHoQ6Q6xTgvebubveArC5r+XGqXquiNDzk98QiTP4lboo=;
Received: from mail-japaneastazon11023114.outbound.protection.outlook.com
 ([52.101.127.114] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzw3m-0005HM-Sm for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc6Av/i0eTum/FtG7DDGg7hnx5CLU2J0SjAYKYtEg3PN3IJ83zK5ZF9oo3umS6gqB/rURaXDv+FnRiDq5cx9qh4KXeutT7PD8DzaOgywkeNtFQyOUXlgKetH3wxcAtxG0tS565Zy8BhVRpeTmuIChkDfAZOc+4J/Vic75mNNYTa//ZvkKn+PiL7oVCDgT2dwsGIjVu2GpCkgo/avQcGuxIi03K+zYto+gqWyJwZwGN7D65AjPolhlzBduDUzAQ/zS5pwJP77ovpYsLDJ2WRp9j4oBzUQfX3tfZbkvUnKU9VUtdguAxQQOlTQOKgMO3L5cwtnD2MFIRbBePwdSJU8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t01yi1nox2TJ4LBFe5bGIiw1hu6OuiO953GFUdDqzUI=;
 b=bpkMqR83c3hYsrA5LucViCmxu92FgEp+zyy4IXOhNYIBgT6Pfs7VCasVW7fEK5HGunSd1l9y8v5D/HtWnqaAo3HGGBoFesS82hFZXe8Y7EA9fYZ/JeRM/Go0fuHzaW7BP+mE0z86vWHAj6i20JpAURWFQn7pPrGog5DEoimttC26kgTbTMF57HN1haPPbrJRbeklRD5TOiMkXjPtLkjKUnrMIXrq78vBywfxfJqtoyymLwuXvhL1qY2PAbxMsWF/0JaBAoyIOH8C/IN+CaJRcgA1R9HoProI1rsGlU8rCu4yVGIF4Xnu2XooELyaYI9AW5ib7W55pVHgusLgbcfYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t01yi1nox2TJ4LBFe5bGIiw1hu6OuiO953GFUdDqzUI=;
 b=EW6Xne62Qxf20s9e2mqmGWsmPQ92J0usTH7pJfAvH9vRhyveqshG+aD2MJNZleHEQlYXHx86UOed/Iak9u8GOfZC8fc22977oHxVj58zdEs3Yf+G06YUQjh5kN+GnAgx/w38rTauIiI5WjggRC7wQCl60UGNL8j0xQQH2eKP7V8=
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5)
 by TYSPR04MB8074.apcprd04.prod.outlook.com (2603:1096:405:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:18:44 +0000
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605]) by KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605%3]) with mapi id 15.21.0360.003; Fri, 28 Aug 2026
 12:18:44 +0000
From: =?iso-2022-jp?B?GyRCTXsyURsoQjEx?= <ke.li11@transsion.com>
To: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Thread-Topic: [PATCH 2/2] f2fs: allow f2fs_resize_fs to drop the last
 secondary device
Thread-Index: AQHdNudeNBcuZawmbEGEhEBkn48wrg==
Date: Fri, 28 Aug 2026 12:18:44 +0000
Message-ID: <20260828121816.1463654-3-ke.li11@transsion.com>
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
x-ms-office365-filtering-correlation-id: 270b1f55-ac12-442a-c03f-08df04fe80eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|23010399003|376014|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: 5c9JChh1M8G5WOXX3rZUqHczAlx183nlEb1fHip617Fv+MoIHD0AgXEjVWPWPdApIjR3yQYZ6ZxjiIq+rjSXBCQjmOX1kdSkWLk7IGuoW2Tv8xL6wv/5AQdig3da+aJMT81os+wupYLKtlkxIarAGjBhzy3VEgpce+AZwi5QnrNhLO9Zuv4qo2fBS3HDJOiPd84GxN2J0Q4YkYFuePc6P1Gkd2kE675ySmcoAVqWQj/mhKB2gDqQ4c2tNALzQrZ+0GvqsSYWmiL+Qtt6nlG+YGs/7165D54PcZ0ps7XSTB6/WMWElEE9FEjl1Lde4gPoBtRv8zULGNQWizB0WoiorExDSVHmgBXC+bo8mIRcZi1+XDGFXdSOM5sFShtTzsV1b0b7cZsAXvAv9dy2Zdl6RzkAPAGWMMrW8okf1VdKgzduP80d6j9CbVVqbK/Zpt4S53M8itKhNk8ZRebPj3BfguwjHpY935Xw0BYhViTZQONU7ycE5RagnI79ec0tEicxLZ90uS8W12HBgL7kFJRW7sx7yALGBnkxjIBRMKYXHOfNDzjAyeAOIQdYAQcFHNOw7uoM3uHTYS4+MAKifWH3YO3Kg+sXv7WKfNNVjB6wUAf2IH68kg3Kmnyazhjrdp891fOT5nT8R+Ahwc36EYJlEWLz/LObMJaUSxsesM19nYweh8Ly6fpIfDro7jWpn3af2nNZvqTlLhoo4vTVxQP/p34E18qTvOFcP1KJuhQWgo4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0401MB6611.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(23010399003)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UURzdVhrbmFOaEhCb2VwMG5QMnE3aEtBRWR2V0RSdEpTekprUDQvbmNJ?=
 =?iso-2022-jp?B?UmdHRFFSVEYrOHdKVlpTMHRiOEFHakNpdFVNaUUzZmVvNEdXaXhhNU9L?=
 =?iso-2022-jp?B?b2llUzdteGlTbmFiM0RHQ1FRMlh2SXpNZUdlVENZYy9jY3dJa0lxUVlX?=
 =?iso-2022-jp?B?dlJtRDZ5RHlDTFcxemFBbENvOFUxM0FrZFduNE81Uyt3U3VXbmd0Wms0?=
 =?iso-2022-jp?B?WUp0TkhUd0VPZFVUTFVKWCtIbE5Ta1BFQ01TNGRhSEZ1VjU4WUNaQnpv?=
 =?iso-2022-jp?B?SDRTU2tDNkE0SzJyR1VMNHdyei9JUEpQOTQ4U0RoWlBWQU5WRm04emJX?=
 =?iso-2022-jp?B?SnRPRHBIUTBabXRERHVWOUU3cnE0SE1pU0tGbGxvL3BNa280RCtyU25x?=
 =?iso-2022-jp?B?Ri82a0VGaStJYlkzOElPdHRwdm10M1k5WmtZUGJld255blFYZzRLaWtT?=
 =?iso-2022-jp?B?TithTithRGxHZmhGeldrSHlhNi95eVRDcVRBeXhteHAxbDdNMEFPSjNM?=
 =?iso-2022-jp?B?dytOclE2eHJNSzlzck5GM1F3aE42citYd0FXTFFvS2Z5VXhXR0pJbTZN?=
 =?iso-2022-jp?B?NkpMaEhGUE1QUGplT1V1dkV0Mm1LTkszMzQzdzNvMVBPR3N1eGJjVWl5?=
 =?iso-2022-jp?B?NE9wcjFKN2xkQjhsMmhSRDBmbXV6L1h1SG0wbVR5OG84MUc0LzNiK3hB?=
 =?iso-2022-jp?B?N0JKUmRBclZWUXozTlZGTmU4dFBmMHY2ZUhsakRIWXFpM2tNcWwxcDRY?=
 =?iso-2022-jp?B?V1dFS0NvSVNWVy9tK3ZmYTNpNG1WSWN6YXlBWVlrSzlQYmRDRjlhVW94?=
 =?iso-2022-jp?B?K2c4SnhvY2kwL3ZBRndUZ3R5VmlFa2h4NU5YbEVKelp3aXU4bFdSVGxn?=
 =?iso-2022-jp?B?UE5kaUE2djVzcXhyMi9ISjd4UVVZM2VEVHJQM3E2T0pnWTBMN3ZzaElU?=
 =?iso-2022-jp?B?Smp5blFXLzRlKzVkOGR4MUo3ZEh6NUE5aDFjaTd6ZmRiMjhIY05xK0dZ?=
 =?iso-2022-jp?B?dEY2S0MvWThEWkkyeTM4bWl2VWx6aHdPSys2Y1ZRMXRURWd5ZFVLYmVy?=
 =?iso-2022-jp?B?azlYVWZ0bFpWNTd3YytHcXArZURZbVlWU0xkQWplSHRPazdVMHU5OG9F?=
 =?iso-2022-jp?B?czVyVzFEOGlNVkp3MHptK3I0U0VRc095dndhRWx1UEVVendiV3hlVlVt?=
 =?iso-2022-jp?B?MGtiaU5Bd0FtSWRjQzRQeExOUkdvTjB1ZFFleEJ1anVEUUZSZjJHZjAv?=
 =?iso-2022-jp?B?NjE4UDNlZ0cvNGkvWU5DV3lLeEFkNWtXc0ZzUkp3WnJKTWFIbFdGMVNk?=
 =?iso-2022-jp?B?Y1F5dmcrby9mWUhPVGxkek1QQ1lXWENuR1U1UTArZnY3WEM5VCtzaWd0?=
 =?iso-2022-jp?B?QThLWlJZTEtYbWVaWUdSbkZuaUdhWGFVSDVZT1h0VDh0SEwwTlViejJY?=
 =?iso-2022-jp?B?djE0OGQrRGFBL0psWDc5bkc5Q2VucXh1Tjc5Y2loR1ZZTi81SGtzbEJ3?=
 =?iso-2022-jp?B?SzVwN0dHdXdRVklCSkFFd3dxUEJhSjZrTHZhUjdYeENldEZRbGhaRUMz?=
 =?iso-2022-jp?B?amRaTVVmK01WU1BxZ3JJMDhyYy9iWG9heUYvTlo2MXZGWXphYzJhNUhE?=
 =?iso-2022-jp?B?TzVZR28xN0xSeXNnVjA5b0N2eCtOL295RWVKMStUVy9DZEdqNCt3QVl4?=
 =?iso-2022-jp?B?akJLaXJoZTFqYUd5ZUJXdzBYajFyNTlsUVljWU9PT1FJend3azQ0NUdX?=
 =?iso-2022-jp?B?WWl4K1l0L2ZwYzFWclR4QWIreEQ2NSsxTmdabkl3NTZRejlKMW5lTG1u?=
 =?iso-2022-jp?B?dC9Dd2VURUJTM3l3dGxZUkdRVHBOM1JkK1ZCNW9pcng3MXl3angxazJ5?=
 =?iso-2022-jp?B?bjRRcElXT09MbC8rRHUvM21qNVF0T1NXazFVSXFXNVRTajZDZEZjZkY0?=
 =?iso-2022-jp?B?b1N1QTQyOWxuZitOQi9QUEI0V1lJcmk3UWl2Y3ZMUlVYeXk3RHA5M1o2?=
 =?iso-2022-jp?B?UlU3SHczMXNmYnR3bHpsYm5ORXhJTkx5aVgwTldSUG8zRzJtOGNOL1JV?=
 =?iso-2022-jp?B?aWZxUjFRNGdqSkZRM3BkN3R0eDEzcWsySkFZUGpoZTdWUnEyNHZ1bUV4?=
 =?iso-2022-jp?B?NzcxZ1dsUTVZWm5vcWYvTCswWW1DaU1YMEFjbEpEZWpMUWZDTy82MnpO?=
 =?iso-2022-jp?B?MnN0dG16TVdDUkJtMy8rMU9YTm5iNzNCOVdYUW94OUk2QmhicDQ3eksr?=
 =?iso-2022-jp?B?emFwaFdiaEZ6WXNlU2I2aXdDQndUR05SaDRLRnZid0F0VHFlYk5BQWI0?=
 =?iso-2022-jp?B?UURyeUVtWjZSU2F1aitRNlQyNHNHZ3BaMHhhL1c0TjdNVFU4NFhLMmEy?=
 =?iso-2022-jp?B?RGhTRlFyc1hZODg0eEtZMWV0OFRQYlRreVpVYnBDeWNBMzZyVGNpemNR?=
 =?iso-2022-jp?B?dGo4bmo1ZTB5bGt4bG15QlBseUtWTUEwQm1kbGpEQ3JHaFVaK2QyV29j?=
 =?iso-2022-jp?B?NmFQcFhGZVVEckxveEQyYzZjRjNweFJ2Y0h4QT09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6611.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270b1f55-ac12-442a-c03f-08df04fe80eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 12:18:44.0916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3BbcF5L66mZLQAmQ3PwnwTpjnU6vk/S23FSd9tsS1weGBNIPrDtqhX/1SGBx7245mQzv5ChxwjJr3dkRpHFcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8074
X-Headers-End: 1wzw3m-0005HM-Sm
Subject: [f2fs-dev] [PATCH 2/2] f2fs: allow f2fs_resize_fs to drop the last
 secondary device
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

When shrinking a multi-device filesystem, allow a section-aligned
resize that fully removes the last secondary device.  Clear the
device path in the on-disk superblock before commit so the next
mount does not open a block device that userspace is removing, and
detach the in-memory device only after superblock and checkpoint
are both persisted.  Restore the path if commit or checkpoint fails.

Signed-off-by: ke.li11 <ke.li11@transsion.com>
---
 fs/f2fs/gc.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c5c243e6d3b2..737bac48c8f5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2316,6 +2316,84 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
+/*
+ * After a shrink that zeroes the last secondary device's total_segments,
+ * clear its on-disk path so the next mount does not try to open a mapper
+ * that userspace is about to tear down.
+ *
+ * Must be called with total_segments already updated; restores path on
+ * the raw superblock if @restore is true (commit failed).
+ */
+static void f2fs_update_empty_secondary_sb_path(struct f2fs_sb_info *sbi,
+					     char path_backup[MAX_PATH_LEN],
+					     bool restore)
+{
+	struct f2fs_super_block *raw_sb = F2FS_RAW_SUPER(sbi);
+	int last_dev;
+
+	if (!f2fs_is_multi_device(sbi))
+		return;
+
+	last_dev = sbi->s_ndevs - 1;
+	if (last_dev < 1)
+		return;
+
+	f2fs_down_write(&sbi->sb_lock);
+	if (restore) {
+		if (path_backup[0]) {
+			memcpy(raw_sb->devs[last_dev].path, path_backup,
+			       MAX_PATH_LEN);
+			f2fs_info(sbi,
+				  "resize_fs: restored FDEV[%d] path after failed drop",
+				  last_dev);
+		}
+	} else if (le32_to_cpu(raw_sb->devs[last_dev].total_segments) == 0 &&
+		   raw_sb->devs[last_dev].path[0]) {
+		memcpy(path_backup, raw_sb->devs[last_dev].path, MAX_PATH_LEN);
+		memset(raw_sb->devs[last_dev].path, 0, MAX_PATH_LEN);
+		f2fs_info(sbi,
+			  "resize_fs: cleared FDEV[%d] path (total_segments=0)",
+			  last_dev);
+	}
+	f2fs_up_write(&sbi->sb_lock);
+}
+
+/* Detach last empty secondary from in-memory FDEV[] after successful SB+CP. */
+static void f2fs_detach_empty_secondary(struct f2fs_sb_info *sbi)
+{
+	int last_dev;
+
+	if (!f2fs_is_multi_device(sbi))
+		return;
+
+	last_dev = sbi->s_ndevs - 1;
+	if (last_dev < 1)
+		return;
+
+	if (FDEV(last_dev).total_segments != 0)
+		return;
+
+	f2fs_info(sbi,
+		  "resize_fs: dropping FDEV[%d], ndevs %d->%d",
+		  last_dev, sbi->s_ndevs, sbi->s_ndevs - 1);
+
+	if (FDEV(last_dev).bdev_file) {
+		fs_bdev_file_release(FDEV(last_dev).bdev_file, sbi->sb);
+		FDEV(last_dev).bdev_file = NULL;
+		FDEV(last_dev).bdev = NULL;
+	}
+#ifdef CONFIG_BLK_DEV_ZONED
+	kvfree(FDEV(last_dev).blkz_seq);
+	FDEV(last_dev).blkz_seq = NULL;
+#endif
+	memset(FDEV(last_dev).path, 0, MAX_PATH_LEN + 1);
+	FDEV(last_dev).total_segments = 0;
+	FDEV(last_dev).start_blk = 0;
+	FDEV(last_dev).end_blk = 0;
+	sbi->s_ndevs--;
+}
+
+
 int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
@@ -2327,6 +2405,8 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	unsigned int secs;
 	int err = 0;
 	__u32 rem;
+	bool drop_last_dev = false;
+	char drop_path_backup[MAX_PATH_LEN] = {};
 
 	old_block_count = le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count);
 	if (block_count > old_block_count)
@@ -2336,9 +2416,33 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 		int last_dev = sbi->s_ndevs - 1;
 		__u64 last_segs = FDEV(last_dev).total_segments;
 
-		if (block_count + SEGS_TO_BLKS(sbi, last_segs) <=
-								old_block_count)
-			return -EINVAL;
+		__u64 last_blks = SEGS_TO_BLKS(sbi, last_segs);
+		__u64 primary_end = old_block_count - last_blks;
+
+		/*
+		 * Stock F2FS rejects any shrink with block_count + last_blks <=
+		 * old_block_count, i.e. the new size would no longer cover the
+		 * last secondary device.  As an exception, accept a section-
+		 * aligned @block_count at or below primary_end when it removes
+		 * the entire last device (drop_last_dev), so userspace can
+		 * delete the expand volume after the final shrink.  Still reject
+		 * if @block_count falls below the section boundary at
+		 * primary_end and would shrink into the primary device.
+		 */
+		if (block_count <= primary_end) {
+			__u64 primary_aligned = rounddown(primary_end,
+							  BLKS_PER_SEC(sbi));
+
+			if (block_count < primary_aligned) {
+				f2fs_err(sbi,
+					 "resize_fs: reject new=%llu < primary_aligned=%llu (primary_end=%llu)",
+					 (unsigned long long)block_count,
+					 (unsigned long long)primary_aligned,
+					 (unsigned long long)primary_end);
+				return -EINVAL;
+			}
+			drop_last_dev = true;
+		}
 	}
 
 	/* new fs size should align to section size */
@@ -2426,9 +2530,14 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 		goto recover_out;
 
 	update_sb_metadata(sbi, -secs);
+	if (drop_last_dev)
+		f2fs_update_empty_secondary_sb_path(sbi, drop_path_backup, false);
 
 	err = f2fs_commit_super(sbi, false);
 	if (err) {
+		if (drop_last_dev)
+			f2fs_update_empty_secondary_sb_path(sbi, drop_path_backup,
+							 true);
 		update_sb_metadata(sbi, secs);
 		goto recover_out;
 	}
@@ -2441,14 +2550,21 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err) {
 		update_fs_metadata(sbi, secs);
+		if (drop_last_dev)
+			f2fs_update_empty_secondary_sb_path(sbi, drop_path_backup,
+							 true);
 		update_sb_metadata(sbi, secs);
 		f2fs_commit_super(sbi, false);
+	} else if (drop_last_dev) {
+		f2fs_detach_empty_secondary(sbi);
 	}
 recover_out:
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
 	if (err) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_err(sbi, "resize_fs failed, should run fsck to repair!");
+		f2fs_err(sbi,
+			"resize_fs failed err=%d, should run fsck to repair!",
+			err);
 
 		spin_lock(&sbi->stat_lock);
 		sbi->user_block_count += shrunk_blocks;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
