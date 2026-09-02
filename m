Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7469EC61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nin0d4MnBfF3xqnr3EfMHO9RJtHJfnb4UqMFBVeJqdU=; b=WvRoJUVvPTbKpP2hR32s4Fd5Kc
	vynVKBIeU9Eu6W41EQQbgwWoqUjfBN/qD3NDYHB6SgH6Go+8Ub0rhFMuNZynxZnK53C2egn/u1F1i
	LKF1xxVGPhIoM79gD3gBfQ+VlOQUsCkS9aLHkvLYbNuiX3P2EkscSvVZT8qu59IUiT7I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1ftD-000827-5P;
	Wed, 02 Sep 2026 08:00:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1x1ftC-00081w-3O
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 08:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BpFao2QaZrT+6VT+0NHHkaaoN+ufqPmvyjw2Zum5Fhc=; b=gvNMew+9TiEIdO0bUX558bShA3
 rDzmOH3tRq148A41OhlBqP1zKazWCJ4Ks7zv9i9Nnh6iPfpmWKylo34qnxBOpIZO2hC5knBfOp+B4
 X5QWsIAMY0YLFA3NcknWpcL/OFmxb06YBfnCg3twV2RqevYbmX8vXcE/HC10LRK0odqw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BpFao2QaZrT+6VT+0NHHkaaoN+ufqPmvyjw2Zum5Fhc=; b=IT8AY1dNdvtgRzqqvZTzEYl8SD
 dMQHCClTZoEZSD099aSJWqmL1DpMvILMs6kmdJhd/8BAEtKW5xjuYrdHfG5bKwNarD2aWFRvX/cw0
 cR/u5+/paiPmYsWoMoilLNp8XxBxdOTesUcqay5nYBGx5o9gWxPClb60jJDN0NuYyisU=;
Received: from mail-koreacentralazon11023126.outbound.protection.outlook.com
 ([40.107.44.126] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1ftA-0000Xq-Ba for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 08:00:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUWZ3RWBdeLBoF1SY3v9UJhB6qLIrsO4K+0I/tc0OivoL9us/wAhZeXTZ6wOt2h1jFqND14bZ9f1Ye05t2aVC6TAif2DrZ05wElvxr6acPPDNBOZ3ZoHnYUq9dWF51Tss/QlU8s+aFQHVkvY/oIx/6Fi0V0OcMBXPvZ/T5joq8gefAiZJbHf4DTahaT/RgeiwnEWPfutQCJQPH85V0FjIbaMPHglxRCcogjrP7Art7co4BxI1LN1bgveoD7vGKZ5HzJx1vpXoFs5twBql/8VQRMtxUAlYUxiE8BO0UqLA3vtBqsyilmVteg7PAfHgHVzPW6GforL4mOsEmTdj3X/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpFao2QaZrT+6VT+0NHHkaaoN+ufqPmvyjw2Zum5Fhc=;
 b=pjskjJm3ewKxAC0rmO2wXijVxYOK+xOrFVKAP9nwctgOf5Xuj+5VfCeZufl8qjKzBng2FMP9NCq73r0zjoSQ9vvRR45ffSljMZQ32AEYdne9bT8oHgzjcIG81+IW2wQPKxq6kSkKqcN42xa2Ezh0dtGumL2E3eyDiBPbCZQYaLZW3w1iX6KY8PTW9rYYwL2VdWbu99f9MPKK0S3OUFXgySn/A1Wi0qew5TcvEvaOF6+raGeMMoBF568rg3ZAUFAHe8lRVQdnbfQTwMUjeyj50ypsRe4ezMCQxew3h95g0fBxnR1DHVZJFOjDghgd/CO5brxGupfxAx/K9a4QYZizdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpFao2QaZrT+6VT+0NHHkaaoN+ufqPmvyjw2Zum5Fhc=;
 b=YnRUipkosZ9avFeULx7yyMDyQ+Z6i5xxU20Ec77CuY+BQjEKQlZmAX9RShltuMhqd7MqEtXzK8sdprvgTAgMwSCgLojJCElhsp4hMkWj1fRv+3dmSxD/tehz1k8LThskRDl3rDx09sjn7JfL8kJDUKd+s0aF/d9S/md6SIaRnn8=
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5)
 by OSQPR04MB8233.apcprd04.prod.outlook.com (2603:1096:604:29d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:45:27 +0000
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605]) by KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 07:45:27 +0000
From: =?utf-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
To: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Thread-Topic: [PATCH 0/2] f2fs: multi-device expandable storage support
Thread-Index: AQHdNudYDqah2N+7HkmYRojPuL70wba68DcA
Date: Wed, 2 Sep 2026 07:45:27 +0000
Message-ID: <20260902074524.70719-1-ke.li11@transsion.com>
References: <20260828121816.1463654-1-ke.li11@transsion.com>
In-Reply-To: <20260828121816.1463654-1-ke.li11@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6611:EE_|OSQPR04MB8233:EE_
x-ms-office365-filtering-correlation-id: db92dfd0-29b3-4bbc-e440-08df08c627bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|42112799006|366016|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: pGTVxqzzESZatZzJYcmxjMCCW34nULkQ4TMpD69WsApBM2ZxL4GdsuNUcXspAjQVLZTGtCmqeBuS84G6qsk8TOjj+17e8d+bRIxXnN14tqmFecFImPl5pG1xGO2SRuCTI8v9ol0Gw+qoYhPwrSdLtKbgGxNGTVIgbmaT/370QWGNJdbS1ngJCOy6c+/sYWgHl2S7kfst7GWHZ0Po+mbu6/WQ67sKvAeDi1AB7+hNGxj8VRCvlT/baUMurs1QqzbKdctCcuI8wmPYByD8CcN8eQRPOwVYj+zMZIB/kcebaULsJ+P3SNLwrfprPloDyQF6IlUx1INlDcta414g0EDJVs/tOZdBc7+N4BVbYM+gF/wpYaMC8/d8cxwRb8ZFLZzeBVetJzzzwPki4RqSiFSiNXrBWUnzp1Q+va4a4bW/mGIOvQuPkxBfJwAmBIzT8MHwpjC2sXggLjG3tRfkE6uLEbMAOZz/5G78bd0+oX7PLQYTBKFTfWYKcORZ5yvBrEFSddnVcw1XWjOxg8L8mBNCBDMoiFmQX1hpU1foO1AJ+yZE96DgENwImwphASlxiWRfmUgTb0a35gImd8CFLAlwYn0R+bNCSYOWytlQ/ln2UqAUNFUhpaV5tOEwq121I8Nntd2R468lYPkaX+zPxABM4TmDGexf0WLJ7oFa3warJeYw4S9LJ0YUAbQ0uujUuHajalWKGW9sE/ILSzkca0F7wZysPmaIahMJYA45t0D9H6I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0401MB6611.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(42112799006)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVpXaXZjcStZU2ZjKzB5ZENpai9jNkRKcjYyb25iRzJWVXRGWmlnRGZJQXlm?=
 =?utf-8?B?bUEzajZXQk1SU1ZibHhheE5GQmg5dUgwWEtzS0k4WXpTZmlaK1JjVW1sU2d0?=
 =?utf-8?B?K1gvRFMvQVlDS3I4d2daVFJHcnJKQmtMdE9GZEpMMm1SRzdYeTRhUnM2aVlC?=
 =?utf-8?B?d2dEZG1Xc1RTcGlkUVRwSi9YUDNFVWpUQzN6S0h4SytXQWxMdXhQMUVVTmI1?=
 =?utf-8?B?RXUxWHl2ZDRSaGZIbW94OWhFbVRLTk4vcWphc3Ryc3JNTDBvaXI0K1FXenI2?=
 =?utf-8?B?Ky9IZlc0OVAySnBCV0tabnBCWmxoMmR0WWxoWC9IOExaVDVEOTRUMDBKOWlF?=
 =?utf-8?B?U0hYTWdFSDFXb2RNS0FjcWRUOW56YXprSHhoNzVtTmxBaFlWSklxTWMvT0kw?=
 =?utf-8?B?VWE2WTAvZUhQMTdaeXE3eSszWTc0V2hhd1A5Y0NiRnZSNTFTa2lZeGs0Nkw5?=
 =?utf-8?B?dkY3S3RlR0ZIYnVWRHJFNlBWRzNXWm9sb2FTUEE0RU0vRkliSGQ3Y21yZjBz?=
 =?utf-8?B?UXYvUzUwUzFzRUg3VGpZSFMybGg0SW5xS0xlcHc0M3ExbUFKRUFUSUlrLzNs?=
 =?utf-8?B?aERLdEsva291ejQvVTJuT2pQb2ZDQjIwbjluM0F6eTROVWtmWGhta1hDQkFx?=
 =?utf-8?B?WndCaVpvTmlmRkx2eXVBV1NVbVdNSGE2ak5qTnhwY0M1dWt2L1VTODlsRm1o?=
 =?utf-8?B?akJDK2xzUjh1bHhub0tQZ1lpMzJZZzhtZ25ScitEUWhjRS90cFRUeDlEM0VH?=
 =?utf-8?B?YS95alpsWXhBTUs1UEgzL1dmb3VWaG5LNG1BTi8wWWd4K0NUUHR4TTlJUFFG?=
 =?utf-8?B?cXg3cEtHbTFzL1E3QUxkUGtockpoZ1puRXNUOU9seGhqK3BNMEJjK214aHQ5?=
 =?utf-8?B?d1doYStVL1RkczdWK3ppQWFPdnBzMkpHTWdqelZUQkpKTjJWK1IzMko4MktD?=
 =?utf-8?B?TzFxZUZXT0xycWc5MEU5dnpGVjU5REo5ZGorOEsvVVYvdEFZeC9MUm1mOU1h?=
 =?utf-8?B?NVlqRlgrajZiNFBDakhqakFFZVpaTnRTdGw5V1l3M096Vk1hWEtBek96bHl0?=
 =?utf-8?B?TldTeFFyUG1aS3d0czgyMkdFZElYemdKZHpYcm03YTVRZzhlemFNenY0K3Qv?=
 =?utf-8?B?WU4zUXR1WEpZeTRVcTNyNmFhbzJVSGEvZ3NRM240UC85cFZzcnduQ29YKzNr?=
 =?utf-8?B?Q2Q5WW04Ni9IUFFKR2c1UzBqYnVHdVdBOGlLcU9PUVVxUGs4VWYzamtHZjAy?=
 =?utf-8?B?MzR2RHlFanhObjg0c0FpSVM4eXFUOUhDVkNjWk9MN09RZmNJVEJQOVNEQ1lG?=
 =?utf-8?B?cGo1alBJTGlKeUp1cmZib09pSEZHdlduR1Z0R0ZFc2t5eW1QV3gvWStlM3Nw?=
 =?utf-8?B?RG5vTk5rR2hrWm1FSUhKdFJjMXYrazkwdFNyRWRjS3BWT0xZWTZVR3VoNjVP?=
 =?utf-8?B?ejNrWFl1WXhldDA2VjkrUlllOHpaMWtlZEpWdmw0dEFhYW9JdzRFTTJuYW52?=
 =?utf-8?B?ZzRlbUJ4Q3Z2UUZqTUZPdEdaYVVHZ0pvVkJBRlhUeUVNVHZCL2NCVEM3VzRn?=
 =?utf-8?B?aTlEVnppRDlmYVJtY1NKNVlCc3grTjN5YTB0dXZpcmozZEtTQTV5S1pFaDFw?=
 =?utf-8?B?TU10Uy9CTys5ZVFEdUZaaHk1a3NLNUt2Wk5TQm9MNlJUNFlGbERJRnRhUzVn?=
 =?utf-8?B?K0N6NjhDK1BreUUrRExhdGpjdWxOT0I4ckhUemxCUjlBYXE2bGRQU0ljM1RR?=
 =?utf-8?B?TkVLbWJTdFQ5TTYvZGhMa0tpU0pJeVMyNTllM0Y4WkJvODMzVHhzRHd3VzI2?=
 =?utf-8?B?TmJhY0xKUXl3RFZtck9YWHB1MmVXd2U3SHp2TWRBd0MzUG1lTldwMXRMM1hK?=
 =?utf-8?B?dGtmbnUwVkE0anM2QVR6WVlsMlNUdDVvQXpNUDR0KzBmckRaTFRZWmtDaVFM?=
 =?utf-8?B?VllJSkNhRHJ5VGVqU2NPOU53d3RRSldGWDVkbk9XZTg4UU9rckx6TkMrTTZO?=
 =?utf-8?B?dCtPMGJGYTFDTVNta0hCN3krZmlSc2dsRnVIcklvRGZuYzI0dGJFcm1LdzY5?=
 =?utf-8?B?TythZ2wzbjVaaDlGb1JPN1JSZUFlZWVxbEJBL2tvKzB0TUdqUGlXa0RZV1Fs?=
 =?utf-8?B?MTZ5Q3YvSUlMdlQwb3pjQitoemdtajdqcFdMUk5vRE01NU56Y1lSTTVnTFZP?=
 =?utf-8?B?Nlc0dkRwQTU5SWtYWTluWDZQSy9SYnZLaHNJWmVqaEkxOTFkcWJYcTNXeUs2?=
 =?utf-8?B?ZDlMRXpGbEhLcTVHQzNiSWM0WU1kRE10MFBHR3pWbmxZdFZLaGxXcjU0ZHpz?=
 =?utf-8?B?Rlc1cU1vb3hGbG83Y2JlYzIvT21pbjNGRmJsWGVmSCtiVTZCZlRxQT09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6611.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db92dfd0-29b3-4bbc-e440-08df08c627bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 07:45:27.3070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5J1593WAJ49ky7DwYwYb2eM8MuLgS5QiGYMVDP6KoqK/ldB0yrbFmMrwtJ4XOCWd/GlZY1QdKeD+CsnH+XNHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB8233
X-Headers-End: 1x1ftA-0000Xq-Ba
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
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk, Chao,

Just a gentle ping on this series:

  [PATCH 0/2] f2fs: multi-device expandable storage support
  https://lore.kernel.org/linux-f2fs-devel/20260828121816.1463654-1-ke.li11@transsion.com/

  1/2  https://lore.kernel.org/linux-f2fs-devel/20260828121816.1463654-2-ke.li11@transsion.com/
  2/2  https://lore.kernel.org/linux-f2fs-devel/20260828121816.1463654-3-ke.li11@transsion.com/

It is still based on the version posted on Aug 28. Please let me know
if you would like any changes or extra tests.

Thanks,
ke.li11

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
