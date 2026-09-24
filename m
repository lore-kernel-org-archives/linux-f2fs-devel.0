Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646F1C98314
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uVrSbEslqg2T8/mF6xbikxLS+AR4XG2UVO3jR1juSpc=; b=VIeQ0TeA1AHB0pQzBAuHJk5gZE
	dh0nmFpwRca4Unh9f3UTq0p4dD53jwf5b/Tw4VejzNt04aIX8xKFwHARk/haXNeHKajLBGnXdoKvW
	2jiBycJE9I3e7AEP7Cc9DAF48if987jhN9vvbcnE2P/nogZ9rOVK77UtUlkKvv8kMbNA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9clP-00058m-Ih;
	Thu, 24 Sep 2026 06:16:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1x9clO-00058e-AW
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 06:16:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/dEPP44q4XCDp/xNa5fzyszsnD8/ejRO/4JDq7vnDGI=; b=hT8D2r6o2EbIsF+w85AMGW/4nV
 hnu9Q0SG2A3EzTlLHJ/kGRbs9E6YWwF3wI/5oFfC1MwBQyzrUHetuRYi9O+UtQNG1twlGEDIGCthB
 klCRdmmx4466xLlWvGb6NG6P0NFE9nlvXfs1LBHKyvTW4/otS5WwBHuA5JijzkUcw7Ec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/dEPP44q4XCDp/xNa5fzyszsnD8/ejRO/4JDq7vnDGI=; b=jzNOC8dMhl/nFn1cdAiJ2xVHWV
 95ZryVFsfDtIfKCWKuL+2yWJ30kecDjN6hrdpNkZPgj45n+qBymbd/eE4cf3bZ+WG6s+hOBsQ5o5e
 2me09aIMZMvYIeoqLiTCFG4V8XPAJxt9/HumVV6Qx3scJiu0Pn2Sz2CAdcHw821WoI50=;
Received: from mail-koreacentralazon11023104.outbound.protection.outlook.com
 ([40.107.44.104] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9clK-0005Jc-95 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 06:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoJyipIy7Csi9+b2tboycpmdaY6GnUTt1cVWzATXQdVjDTs+1MTk6V9OLo5nY1PpYsdFkVFAA/iJ90nE9KX6ExhSAwlUAQ+ln2I4Qk96iGp0wOHfQ7slNBIB9hxPr44cZpxlgZrt9C7oBs0ee+rYdH7gnjcOjYVfWuowGQ2Ml/LJaFAUWwEgCk1qXfJdvBgCut3GDNxh38ju4Be+6XqyC/VR2Fo+IncjkJaofhGTOlHxgQeaCtTv/vs+B5jYGBIc0CHpy+S2h2e4TUmWF4ZYmdCuXstg27RWmFj8buYI9KWkfTiKV2w3PuRp0AoW1u4MHYyLAeAD8uEed4bl1O8Xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dEPP44q4XCDp/xNa5fzyszsnD8/ejRO/4JDq7vnDGI=;
 b=mh47geNxxAH2Rr3Pb1fW1PLdK+US4PpuezEtPFN+dean7a5XakpykburKnAq0vv8N0JT38E+H6BBSKq86fcrOha1ncDfiZShqEo3KhRTZKNryq4WzqCSofCSx8q+c+7aDTpV/c+8JKaH8P5NKXhYVrAcfUXdOQvypi7XKiHPl6hOTh+DXzbboj4ykVPgMt3g6QxlamKeLDUInsNAgEbqEWfZTnuZn1hhGZCL6T042xcJzAwyqVJNgZVx5vKa6GwgSIvNyKZfpMYmg7vL0ZSOvmB7HKx4bFibqcn5uae09OlRdI7SYi3gNAAzDXAgn/EYQ1UyMfHw1bqgnf99UX3k8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dEPP44q4XCDp/xNa5fzyszsnD8/ejRO/4JDq7vnDGI=;
 b=ZhJwuJHbuepTJserB3ym9RLaocPRFXMn6+1LZ0571KhH9xjlc9N3Q2YcgqhuzB5xT28ozrjvMYhqY/rJaZt8UMKPoLRourD7GQlKxexPmPUwYExZJ8uzSOB4ONnWiYvNqt192sW7jmEKQh+XjDeoYaHtnWd0ZYQ/P/DytdZPJmE=
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5)
 by TYZPR04MB5879.apcprd04.prod.outlook.com (2603:1096:400:1f1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 06:16:44 +0000
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605]) by KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 06:16:44 +0000
From: =?iso-2022-jp?B?GyRCTXsyURsoQjEx?= <ke.li11@transsion.com>
To: "daeho43@gmail.com" <daeho43@gmail.com>
Thread-Topic: [PATCH 0/2] f2fs: multi-device expandable storage support
Thread-Index: AQHdRByjvgq1d+cgtUiNBlbw1C1BW7bOHWqAgADGtgCAABO/AIAANpwAgACZNoCAAPMGAIALNkGAgABacACAAAFHAIABA56A
Date: Thu, 24 Sep 2026 06:16:43 +0000
Message-ID: <20260924061641.2188583-1-ke.li11@transsion.com>
References: <CACOAw_xP_xNt8km5rxEC1-eiBpm83AK6=m+p_N5GK7H+Djj68A@mail.gmail.com>
In-Reply-To: <CACOAw_xP_xNt8km5rxEC1-eiBpm83AK6=m+p_N5GK7H+Djj68A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6611:EE_|TYZPR04MB5879:EE_
x-ms-office365-filtering-correlation-id: 39ad1e1b-95b6-403e-619f-08df1a0367e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|376014|1800799024|23010399003|6133799003|11063799006|18002099003|22082099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: Ob1OGMpvwKENYaxoMZoWV4COuMECOTFD/FETzG6UbCYtpkkzvmYZx8ivBZZs5xGbCf476WzFIhHO/gN4Pf8up1qaRQvMxJYcYP55TDXX7bQnMnHjzrdEiorBS56euXrSDO2y6JGk7dN9aIyCK6WMc+sKvFVMLHo4QU+JJK/BK9aMDPqQD6t2W3pmkIyNsxb5qKEEKhdn/efWr4jthgOxSpZrCAkRvp5qvRo1CtVtlD5gIGPvNQhQrew4lhaGC/Qqn76YWO3nlHpn+vYkhcmOlvWal6ezc2EHKLfwQ3OIrrjecC66+Z9c9KrgZgZDs0KiG8YwfKFLIbriTb5Bv6BpqOv6gQUurngIduY/iesE6sqN0yHf/EeOR33q+CrMRVkYLSGZ5l5c/EV38krGm9tsnIB2GJN8wZWWsR/daOZlEq4UilXdy0Krd8ZuhlKeuc5nUsSMx2ScXNYYFEpH/ayASggQP3A1ZezGtROFTBZlpI5xEeiAEiYCqk5n6BJ511rSF6a1jR0UJOg5q+MyQTWW/Rljnh/A04gfR0YoqIeZUhcVNGt70cqsxzWP8g7G7wWpcwBGLsnIRpLuQMPRUNQjp8QDdWdRBqB3pKQDaW1uoQftMi154LoUY6wnRveAOPVY77nGX133yfwOFX0/pDWBgpVSW7ChbMMxPY/ra/gCnbCl1igJpzPoqUxWIEE8vRgja7SGZFhUogUHS4XU3IgDebh0puPPyjfXbLW5myOp530=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0401MB6611.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(18002099003)(22082099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UWxES0dXdHZBVi95Zlg5OU1Rd2EwNnhwQjdEMnVKdFFhMmRZRU1TOFVR?=
 =?iso-2022-jp?B?YXFmNXduTWNTVnRlTFhTY0JwMU1xdkRFeDE5eWp0OCtPTisyc2NURmJa?=
 =?iso-2022-jp?B?cHZqSDR5NlhhUUxqMWRSNys4RzdIcGFNNUhQcFY0UWlJaWRjTkN2Nm9t?=
 =?iso-2022-jp?B?VTdqN2FYcXNFWUo5cG5udWhZMnY5VWhkMTV1TDFaZlFRdGcybGVET3hz?=
 =?iso-2022-jp?B?SnA0QmJKdlk3MUxMNU5idTE2aXdic3o5OGtHVDVOTHVqazJsanQ5Z0pE?=
 =?iso-2022-jp?B?cnN6SjFNcnRSQlUyL1RQUjFJeXNXaWVNZm5kaUFubG1DNTZKQVFTQ1Iy?=
 =?iso-2022-jp?B?NC9EYzJ5S0tWcnB2dnFRekN6ZWo0YkVxR282UlB3K2xZOTl5L0hxOWgw?=
 =?iso-2022-jp?B?b0FFQktvMFZzeXNIRlRrSFB3dTVrSEZ4c3dPMDFkM1RZWmlsTjBSRmdj?=
 =?iso-2022-jp?B?NW9DeXFnVk1lM1B4ZHI2RW9EdjM0Y1FSdGRmRmFIVFdjQ3gzdTY1a1dk?=
 =?iso-2022-jp?B?RFdkU0hucEQyUHFXVU5lSW9vY3ArQUx3UlY0UjB1dVB5UVJoeHN3dTh1?=
 =?iso-2022-jp?B?a1lUUDZtS3YwR0ZSZFJKRWVRQ1ZqeTVPWm5vajg0eUFEREVxREtoU0dE?=
 =?iso-2022-jp?B?WmNZSjZXOU1kVDYyMHJ3ZjV0cW81NlpEem00SndKUHZPVDFuR2dXQVNa?=
 =?iso-2022-jp?B?b2t1NUdacXlVUWIreEYzRmJ6K3BuYm5Sam5TSUJublkxTVNSZHl4ZkVK?=
 =?iso-2022-jp?B?cWtyUE9hMXdXbU9SQ1pRcHI3bTBBTmRTU3Z5VG1pc2NYSWlKSkVoRGtI?=
 =?iso-2022-jp?B?djFZcGNZWkgwUWNnV3l0elZoSCtKK1o0ZUl3UDA2SnBnVHlhVXR1dWI2?=
 =?iso-2022-jp?B?dzRXOXJCTkFIdmx2bTQ2c3hFNkk3MlF1OG96elZkRDF3Ti9Nd1RRU3hJ?=
 =?iso-2022-jp?B?U1U1L29JdzIzZkFNQVJvU2lyN0w0S3hzdjJqcUV3bFlaMWFQSWhDeHc1?=
 =?iso-2022-jp?B?QlgvdjZ5T2JQMkRubE5lK2E0VWkwRUl3bjI5SUJheHFMcWM2V200TTNy?=
 =?iso-2022-jp?B?N3B6VzVKUmpBTWhhVTZac01tTnVrbkYwTzhDTmZJVTlkM1pzRmpiMmVh?=
 =?iso-2022-jp?B?am14NmdhWXE3SVdWY1MvNVlWeHM2SWtHTnJ5dy9RY1YwY3RJOUFKcnJy?=
 =?iso-2022-jp?B?N2FHM3d6NnhsTDZLZjh4NStubHh1T1RBcHljWWpxVDZ2RzcwRUZUaEhp?=
 =?iso-2022-jp?B?VFN3c2JibVFyeWExbXNYaTZLU2dyWlJJVjFscmtHazM2b3F2ZFE3TS9r?=
 =?iso-2022-jp?B?alViY3lmUk9ZeW9mQlV2VnFzejZOVnVJLzl2N2psYVpBSG9yeHI4aTZx?=
 =?iso-2022-jp?B?Y293OWZ2SzJpazQrS2xjYTAxcjIwa090c1hmSVJLdHk5bVA2RVRKZm1l?=
 =?iso-2022-jp?B?V3crbm1NRG42ck9ZLzNxUEF2Y2hCV3NBckFMN3M5Tmx3UDdYa3NqdFZD?=
 =?iso-2022-jp?B?cC9mOHNGNWdlaGNEclFGY0hvRGZRZEFWcEp0U0JFOTFPZHUwcit2TWdX?=
 =?iso-2022-jp?B?WVo5cGdaVkJGVC90VnUrTVpMNDhPLzc4UmtxZUl5U0w0YjNDMzR5VUpJ?=
 =?iso-2022-jp?B?YWJGQ2c2WUkvYmNYQWxLZldIVkNLQW9kQlQ3cmVCb2ZpQVIwV04zWnJw?=
 =?iso-2022-jp?B?eDJBSW53S3lkb0IvMWpzOE94OEVRREE1a29IS0FmS0pxZHdqaE5qUzlN?=
 =?iso-2022-jp?B?YWtiYnVZM1NEVHlEL3liYlJSZzh1V3lwbEVjSUpyVm04T0JjYTM1ZGNF?=
 =?iso-2022-jp?B?NS8xSXRGeVdKdVQ3YncvV0VDbFR1d0s0NWtleE1ESjdZT00xZWwvMDI4?=
 =?iso-2022-jp?B?cnJsQjdpaTBtR0czSWZqM3ExZ3pOQ2Q0ZmhhNFpNME9SNnluam9TSmV2?=
 =?iso-2022-jp?B?K0lmU0ExeVlySU5lM0crNXRodXNsZWVvQ1VTK090am4rSW5VcHB4bVlU?=
 =?iso-2022-jp?B?NFdFZzZSYkcvTDhONDhBdTFzZDhuOTBDZWxyVllzRktVY054T2lwWTVV?=
 =?iso-2022-jp?B?ZXhGSlA2WlhRNktWRHZ2MHVSQzY2aUlDamZhSFFOYjN3Zy8rVnpuMUpZ?=
 =?iso-2022-jp?B?ZzJ5RGFhQld1RytMZUxDRGRMWU83ak9qV3U2YThKbUNKVVR6US8zQzk3?=
 =?iso-2022-jp?B?SUhZNWNXc1ZGaHVZOTBObFArYXVJUm0vTk1SaUcwRTh6bE43Z1E5Vytk?=
 =?iso-2022-jp?B?VjJyZlJ5dWdDdGpRVVluSjNyVVFjRjNuWEkvcC84RHdNaVNvUm92WlVm?=
 =?iso-2022-jp?B?VVZwVmVvZDRtWEpTT1grREtxTzQ1aVEwSDg3UG1IT29Wb0RxSWVPM3NJ?=
 =?iso-2022-jp?B?bzdLVG5hS3YwRmJISFZQZ1kxNkFiTnkxSDdsUHFXK1ljUzQ2Y3JXR1Bn?=
 =?iso-2022-jp?B?Qk5aQzJ6QlpNbEx0Q0lNTm4wREhqZDNPdW5ubVJMWmd3ZFk2WnQ4Njl2?=
 =?iso-2022-jp?B?OGFodWVYTlZ1dk5xRmloNnUxT0tTR29DTWNXZz09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6611.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ad1e1b-95b6-403e-619f-08df1a0367e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 06:16:43.9831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PyRHhMj2pX5DVuoRUDBwoHCLLSVy1CNIAZqMaZlmNSOAUQ6uD/D1ikGDMdEqF2BpvaR511HiqUoGdeBmROt7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5879
X-Headers-End: 1x9clK-0005Jc-95
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: multi-device expandable storage
 support
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
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

Three points on this series:

1. Patch 1 can be done with resizable_tail_secno, so that patch does not
   need to be merged.

2. Dynamic device aliasing does not fit this use case. After reserve, the
   space stays on the secondary device and cannot be used by the Android
   super partition.

3. Patch 2 is still necessary. It covers the resize boundary in the
   multi-device case: once the shrink drops the last secondary device,
   F2FS clears that device's on-disk path and detaches it.

Thanks,
Ke Li


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
