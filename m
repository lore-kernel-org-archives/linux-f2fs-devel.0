Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72950C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MuD3otpVjwg09bVbqwPIDnzmTyAyf3XxHjTS+95SA30=; b=X8ruVd2/VjR+wWPl52DEcZHiCI
	PvRPI+c5pWk14TwcjunOe3NDvkvz2Mq9Nmi9vheROk8AvGj9TzKxXSqh9D840yTp2h8FOTMfAqo68
	yTDV0UxLZawnKywCN3sgq8xaV0QU/RP2nLp/AqPuHJwiRPEE/4Xoqs68Nigy2xj12GpM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9J9q-0000i4-NC;
	Wed, 23 Sep 2026 09:20:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1x9J9j-0000hu-Kc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:20:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iP9bBIjaGdtwIZHqJKbYedx0fIgneaWgF+0FeTxvATI=; b=ZboJpWFyIEgnO/q5guv9Cse9FD
 e+xAVtT9+oOGl8QrVC2SwVPUj+K4IHDlPt14EzlcH5LrobmtWkwA1fLYOnIUytsr4GBrD6wnjacMR
 cce9TLd9nLvWLjfGBYlzOktNTkCTAqLOKC63NgFyk0DCf49H8Agdz33kyXB8KfWzS6oY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iP9bBIjaGdtwIZHqJKbYedx0fIgneaWgF+0FeTxvATI=; b=Co6B2zI8h1pxYbGPT6ROEIcuOT
 K13a8wjnmVg70Y+5H2r2MfFZN/AKXrpZz+B/YJQkdoVTIToti22Ukddfn9x/9lf787XkQe9JhX+gk
 1OwuDKZOj7/og0RHvmPBrcSH16cmRy0sVGDh0zh4nR6SuPFmwbohzURkO7hJ0MQ2Bla4=;
Received: from mail-japaneastazon11023087.outbound.protection.outlook.com
 ([52.101.127.87] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9J9i-0004Wy-1X for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpyVyNghOGLXjuRTNAK2FDvTLKPwfnIKnpdWc0Y9Li9eaR0Cw3msDutkxIf3Jo5AO2DRaSVIqsI9xW8VtCxeEw8ZwJe8H2AgotTn3E9VRYSuWKiY2S86cORhitpWssz8lJ3BiMjM8TvB8SjdPVzClZdrZZklXI1H1I4LoW5ZnK9IYkPfrgL2eKFsJAWuOLNy9Z9S9QL6tGU9FJD8d6pis3Z41e4+BVVMcuEmPFmHf8EAfc4/mBDfXsWlDdU9/mzEsujqqP3oWxYn6tyE2JRvwO/0e/5V+JLdJgKD3NxK/YAVN6mbwsml/+n432XCnt7GcMBKQ8f4iZfwrf5O9qSM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP9bBIjaGdtwIZHqJKbYedx0fIgneaWgF+0FeTxvATI=;
 b=LGCZCel8ObSWBad2M0G3JHrrzap78u2id1+ZBzc9jUp8vq6WwhhHs9MLtdMYMkeYl689vu5xQjsWjgdhbMuzbSP0I+9stjL7JvoIIAN+EOUWki6xoDLA9WeQpooOng4mjw/vR/FonFEInm42Y0JyqtylM38rWqrBjSBeg82anSCtYlIJd0GsE505mEkTcUO0761dqOtR99NAog7+D1YfHI/LGyzqAaSpLI4r2Q0cl+lPHEgEgnFzWBF0KdAGtLdxUyLKVPEEeH9Tjybqp82TlXsyUt6XkZGbbrlMw+ILLUt/1juTwUeOck8gItU+kW9KRgm+jahoNNDmS8qi716UJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP9bBIjaGdtwIZHqJKbYedx0fIgneaWgF+0FeTxvATI=;
 b=swVITNpqQ4bSo38W7havmKG/MBbfWT/xBLnehhZFqrinoZXiHOmr8QDAqPZTelE3I7bI5RB0wi5pEcBMa9t4sousxDwYqcd1VWY9XxgfoMgwRGIaVbS/JmvxzEz4SF8qJ5nk7hKFdx4LIGmcdt5bMdojqOxzcsiIr7QR9UrOKWs=
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5)
 by SEZPR04MB8048.apcprd04.prod.outlook.com (2603:1096:101:238::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:20:37 +0000
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605]) by KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605%6]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 09:20:37 +0000
From: =?utf-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
To: "daeho43@gmail.com" <daeho43@gmail.com>
Thread-Topic: [PATCH 0/2] f2fs: multi-device expandable storage support
Thread-Index: AQHdRByjvgq1d+cgtUiNBlbw1C1BW7bOHWqAgADGtgCAABO/AIAANpwAgACZNoCAAPMGAIALNkGA
Date: Wed, 23 Sep 2026 09:20:37 +0000
Message-ID: <20260923091913.1152395-1-ke.li11@transsion.com>
References: <20260916060610.1098289-1-ke.li11@transsion.com>
In-Reply-To: <20260916060610.1098289-1-ke.li11@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6611:EE_|SEZPR04MB8048:EE_
x-ms-office365-filtering-correlation-id: 83dc5ecc-3caa-49cc-cff6-08df1953ee13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|23010399003|376014|11063799006|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 4/SyBZ7jc5l70uFNYqb8v1XBefM+fj3jKoI25xUFJNjYDcJ+9y1sltchE7u5npMh1aIIU2yjsssiQtbvNCBhqb2nIj4SlksmrQXKarJDz3vaMTyw5HibQlN9RuSpuvxpTWvfXiwpbxI1dOJm9mkgUq1A9SA4lXW4BYEtnTcAKH8mY8d+24gxreVAdO4n3bkJcgLT7hNyGR/R/FK35+LMhMx6GOFVL1UFOD1o9OE3trKgoVkilSPj4EgfpX5gsoOPwR/1tFoByywC7DkPdWVYb8rILSSA4kzVkF4/bCZm2zwRWatCUdiSjX593pnIrOWO2f8CYEWlkX/8y3hCSDV4b+KMzioxw7wb8K2llsqeoe40YoFxlOJpoEiu6VEMCBBSpTatcJfZ91ARNw0myQ9QpnLC85mWgO9qcRVHW7SxP1igwkGrYu1ctwd1EKP7agSyFht1JlPaGDVLK2vUZd3pifgd+JsZWu1G0pkxoJ7E/1d9DF27L/QWNvIbZoTfuQ730lY56k0DdKf5jLPF8xoUV+WkdqTmKbaxJUaswAyoSTI4U/ZPiawZNLKSfwO6iEjeKjjWDjDncT9yZXB4ERmAbzo2SVqm30DQOmUUUHgbpbac05i9yhTW550OrG+WTXSAlN7G5TX6Pxq+K3jAZjhc5Zun8dHhUN5fyMu2lJFoIY5KawQq0b3ZkEWMJrilRBpW+vat1YTyfv2sFvwgxts78BoK/pnCLE/98XNkOoggFDk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0401MB6611.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(23010399003)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amhQNldrWmtoMHh5b1MwK3duSGNxSkZ6cFE2dTd1REQxWThybS9LMzlweWlU?=
 =?utf-8?B?QVhud05BRW1tTzNMSE5aL0xSbmlpZ1dHWWUxZ1pYSlNpMGdLRm03T1hMOFRX?=
 =?utf-8?B?Zi9zdk4rUU14bHkzTUxvTmQ3SGU2eTVSSjRRTnh1azMydE9xQlNCdFJaRlVo?=
 =?utf-8?B?OEdaa0pNdjlHdkYyMDRMdVQxaGNVVlpSUVR5dFVjSC9VMmJuRHkzMkY1WTlO?=
 =?utf-8?B?SlZhbUhGZGh4ZnB3WGhnTTA3akJnM3loY0t4TFZCWVhmR1d0c0NMRlZMZzJF?=
 =?utf-8?B?STU4Um16ZHkzZHMweE9kbm03MXZKaXFxSWpLN3ozanJTZzByL1ZKV0F4cU9K?=
 =?utf-8?B?Z3dWT2NLeU9GTDdVbFlMN1lISktVb015aW16K2FIV3NST1pGVzVOZmdieWRE?=
 =?utf-8?B?MkdpMHVGTWQvTDhYc2FHekFqOC9uZUJOenBTVEtsblNyRjBuaHR6OFE0V3hZ?=
 =?utf-8?B?eHBkeUlrdW80OEhsejhsTUVXMFRza1ZocmdtaCtSZjN3MGxiaXlJcWY0NFZm?=
 =?utf-8?B?SWxsUDdGeXJENGRxYmc3dmZNNCt5aU1HanBPSjBudCs1TTR5N0plQWV6TU5F?=
 =?utf-8?B?dEdVa3lNRTRtSDNMTmxqWDdZWTMxa1pTVG1ySDJOUlFKbFh3WnZLcGNkNUl0?=
 =?utf-8?B?bDZIVlpSdlBUZTlJeEthT0sveXlwTVM2ck0rcS9OYlhQRFVtZ3hnQ0ZtR3kz?=
 =?utf-8?B?SkNHK3c4MGg1ZjRiaFQ0UmNreVV3NE1SN1YyRWxaTmNFNFpVTWJLKzJSalY4?=
 =?utf-8?B?aks5Q00zZDFaM0d5ZFptaGlNeGtpREFXcWlTNlZLcjZVMjUrM1JneUVqSnN0?=
 =?utf-8?B?ZkR1cXBRa1FOcXBDUzR0cm15VUxFOFFkS21rRzBnQzFNUmt4MVk3d1ZVbUxI?=
 =?utf-8?B?cnRvRUduOE5tVFdIZEY1eVY5NHdaTGx1VzB1cXdXT0pHNEFyc20xenZ0Qkcx?=
 =?utf-8?B?bm43MjJIcVErWXRiNHk1dUhBdnRwOXdQR3dNTUpuR1FEeFp3dkl0WFRjVTNs?=
 =?utf-8?B?R2d4QXpvMUdZVlFpQ21CTFc1UW14MFgxRWNpM0RpNnVuTFlya3c0U3I3MnN0?=
 =?utf-8?B?bzJEelZuTEZUQVhmVXVNMkhEenhqbW1qVDRiZ2tzWHpYYWxXMUhROGs0ci82?=
 =?utf-8?B?d0lCcWp0UndlbGtZQTgxT1hQczV4UXluSk52bHFsOE1pYk43VXNjRmJwOEIy?=
 =?utf-8?B?RFJQRHJMZnRHdGthdU1oVXg4QVhmMi9HSDh3cS9aL2QySVdmVzNidkpuWVdC?=
 =?utf-8?B?K09kSlNZdmlGY0t1WmcwekRTZjByYWdoNlZzbEtsckIxVjNWZFlNMEZwYWV3?=
 =?utf-8?B?Rkx0SHpoZ29NSXRTcmVlZHFQdklXd0ZjR3psdG4zeWtVMjMrOU1HVzF1YUdu?=
 =?utf-8?B?djF1UEZrL3pGMGcwN1FGQ2VyekpwZ3MyRTBJVUxybnJ4VFUvWXI5ZDBpQjBv?=
 =?utf-8?B?K0xINzNvK2JoQ1VpR1pDN0o5R1BSY0ZhTm92MVM4dzl6dkxOYlMrdnBXc3Mx?=
 =?utf-8?B?SWZIV2plV1ZiNEpYRlQ3RHpHUzkreGFiWW9MZ251Qlh3eXozbnRFS05jSk1Z?=
 =?utf-8?B?NFkwWmp4RWhwNVdXWDFKS3RLeFloTlk2S3FPWlV2dytOdlAybTNoQ0RDUFJn?=
 =?utf-8?B?SHRUT0lhcXJCNG8vMjJEWkdIWTdEMUlrSUtqSUNBbWtZRjJsblVHTlVaaFBx?=
 =?utf-8?B?ZVRHRGVlRDhCRUFWcUR1NkU5UW10Mmo1U1lHQThnMzdzMEYySUdaNm1KcUhP?=
 =?utf-8?B?Q2x3alFXYnJvclJmOUNIaU5uVjRORERuOUZ0WnNGN3RaeUgvZU51Ni90R280?=
 =?utf-8?B?SUlxTVVYUHJmdzFuc2FtczNHUWhZTWZWK1VYNlBKVExMOUJNU1NMZm5zam9G?=
 =?utf-8?B?RFNlQ01IL0FDN1lKdVFvbWZsakR2N1BGMldBaHhMRDR4VVdXMkhTWkduM2pB?=
 =?utf-8?B?MWpPRVkzbXhGOW1EMWpyQ2FRb01Tbm9ONU5KVXhLMGtOK0JFcjI1N2NEZ0lR?=
 =?utf-8?B?NndYK2Vpajl0NE0rd1YvMWRlcVJMendyNGxKOG5RQ3llRHJ4VE5XbVNkK2dI?=
 =?utf-8?B?SWlxZ25TU01jT1JyU05CYzNFTk84ZUZRVStza0d5UThoYTRPS2xRY2JpaFJQ?=
 =?utf-8?B?VUlHV1ZtYTdQWnM1aENKdENsUHdhT1AwN2xPZjcwMWN1WU1PQ1lTejIrL2lP?=
 =?utf-8?B?a0FGeHFrY1FiYmY1QkNzbWNEN214ZUJhcCtRaWJUOWhjZ2hsQUcwQnJBNmZ1?=
 =?utf-8?B?UjB6NllsN1ZNVDhncGZkeXhhSVlLbWsrSnVDVXBuNng1R1lEVGFjVTUwN3cr?=
 =?utf-8?B?c2RsOG9pZitkM2UwMThVNDNCVnZpSnJtcTNrVlRuN2V6Ty9kVXBaZz09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6611.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dc5ecc-3caa-49cc-cff6-08df1953ee13
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 09:20:37.6633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ky/M7Yaji2A6CMVpBwlH9TAJ5V+xcx/MXNK9o6UnCYiRPkwOOiHj7Evj3wTavrYKDMHzLcureRSKFAcvqzz9uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8048
X-Headers-End: 1x9J9i-0004Wy-1X
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

Gentle ping on my previous reply about dm-linear.

We still hope this series can be reviewed as a native multi-device
change. Please let me know if you need any extra detail.

Thanks,
Ke Li

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
