Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F399EC79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 02:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6d72HfvLocbR2QthgTguHIrz9SSaXhcvj2v9N/qrKFo=; b=mY03wEFbzMqP2AsBeiRKirpMHd
	Ad0NK65d35WpWY0cFywgtbQjC7KxNF2ze3X4H4nVZnOm8HLO5c5xnJYbJheTCUB77A4BDfbvekwHW
	HWP01hAYX5d3C+kVL89pwejaHbh5l3y0z4fwNbaboNgM87XxBJirdASZyT9s+fInvFcA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4UZN-0002sp-1x;
	Thu, 10 Sep 2026 02:31:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1x4UZM-0002si-5O
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 02:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K9km/7xww4q2cv1mpp8chQv1iN6PCwBbZS1UQn79O0w=; b=hlMCbzXZ2cif9DJ7K7M4c3JTDx
 //Lbqq/rv/12DHqDtRzHW9aFbSQ8aFoM+PljNhSWfGYmpIsJtXT7m98zLcBI6ZAX7Y64Ef3P9ZXSp
 u/nOFUR9254s+Oqb5gq4k0xD/ZVGzBDY9Y/LDwPsYDHbmCMUzsHtjlAJo7MlxqdESsEM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K9km/7xww4q2cv1mpp8chQv1iN6PCwBbZS1UQn79O0w=; b=g1lTuBP8/c4cHPLG5nXoQSf6gw
 1knH9q1qVtrW3LAhDDGxokHjF50+vJTwbPTAreUVVJC4xhSaKVFrNLDJF8A6TIsLAGxo1OWbgGdMx
 i2PjbIcTLVkIgwMPPVgsrn2kvlEoYYozaOKwz5Ivub987ybNbYMmSDloWP/bnwGsjjLg=;
Received: from mail-japaneastazon11023127.outbound.protection.outlook.com
 ([52.101.127.127] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4UZL-0007on-GA for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 02:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdYjJZj0ftAiRbYwDA/kP2+dTgBEe1hqwU0xZ5w4jjkUjzSt/8eDhK3HDTnO2bIfK/1JLQx23BTeymZATHVqTXNRFpsIyh3wWkmuCqQkd+UyEXxe2kXcR6mx0vYdIaTd2P8EHzESjJsiXSw3K+qHSLqI0Gp1obJ5uGrUpvariyDKzyq3GLdK0ost1TPrYZfqTEWh7A4PChap7GaUAv9Z6Poy9K9Ol9wE2eiGcpuPk+J/vF3RSA0ZFdqn63SSx9E8xCUB1OTX5em5TyzrSe+rXW5khKjSPy/GMEj/m6E4xdm3Lj6Fd+6sVK5O9UWVRc2r6a2mkcWeG2PspMpoDo3p8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9km/7xww4q2cv1mpp8chQv1iN6PCwBbZS1UQn79O0w=;
 b=zV28J5A9pDw2H03DdfDsBr19Ckw9alpDarPSpbPeYWTfK0N/vYqfEQcAtg8ZnYR/bygd7hIeZRr9LB2HEM4xgVmnPUf04nH7IQI9GdEI3WvocYvPMsyaTX4Lxcjcs7iOMZC4Ju7CDVGrdexj2cI6rm/vqoAOF7sj/N7qmQwpARjp+sNa+frNL93OANZTZ/oy903O0EHFQlyZcwM2WBrI6GlDua6oJI0qw7p4lzUQuhqc4VZogaONC3dBjW2dG/16um11ZSWFQYSm0FbaRCfw9N6QQuo2hgdCifAYnScCLeV5/n8GGpyymFkaq7csolYXo7fqidkq+MbycuVUklH1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9km/7xww4q2cv1mpp8chQv1iN6PCwBbZS1UQn79O0w=;
 b=qnpcFfFKW9Q5IX+ncr5YhWGoU+QNpgnANiZofIn74mYl30ypi6Kg1O92vbwoov2Eoj/hrlCSzzWE1JQR8b75TpQT52d9In7+VfquSOwRIW/7K3VPDvRWokPfe/cUb7Qi6tIkqKvOw4Zy+puikDODYji57TbOQT6bdGl5IL/dd90=
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5)
 by TYZPR04MB7936.apcprd04.prod.outlook.com (2603:1096:405:b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 02:15:04 +0000
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605]) by KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 02:15:04 +0000
From: =?utf-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
To: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Thread-Topic: [PATCH 0/2] f2fs: multi-device expandable storage support
Thread-Index: AQHdNudYDqah2N+7HkmYRojPuL70wbbHJo+A
Date: Thu, 10 Sep 2026 02:15:03 +0000
Message-ID: <20260910021502.10024-1-ke.li11@transsion.com>
References: <20260828121816.1463654-1-ke.li11@transsion.com>
In-Reply-To: <20260828121816.1463654-1-ke.li11@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6611:EE_|TYZPR04MB7936:EE_
x-ms-office365-filtering-correlation-id: 83964f01-ec1e-4cff-cf62-08df0ee15385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|42112799006|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 7D9xd3k2SU2d2TxWN0qwcoNz8bW1Mse6Sh9IyDqwyZ6cEoreG1Jk4JH7QFVZwkYCr5Lq6RXLKH695APOcI3Ca0oRR2S9VlfOpTovGSqDT+ATFR3jeyYlcz5D1o1G0JTNoJ08p3hmhHacMeYd3JSf//uQ9wr8T/BGjIAud3j77QwavG/BzF7qqJzRmuO8F6YDvs+HvWYLBUM7KfHvKHV42HBCmZ3bafk1urlJsjhRvM2AeDdr3zAzzDKvRWF7oY+dfaPcTT5eTR7oUgrjLHJOeyAeCUS6NfQ1kZYfFv/3t6pfO/Kl9viwGYv1V5RPpTpawatRlKgEXv3yBCeLyhJKntNPtErCfi6jetbfBdulMkAp4nEuD/y7S+ap7wcAioYoQQRUlCaKc4CAGQA7PYjVo2yY5LNZ4yf6i1E+q8DQ4jzoZadk9fMlV7UpcYyQ+j4g8l1SiIc+EsAu31cn2DPLW0m4ymbknll93Zx6qfDAT4JejTcZt1WvwUwtXSZFMgL7IsdfGAb8gGF974Q1p31V7OXLtmL5VLoerF93cOvDJ2YBeA0s9w1wqbIToHg27a67DS0ncJKAJLMIy82hkQePOyXRu1NgtIOjPI/eTJpPd8trR8nExN5e4CXwm57vTjBdfSOKQ2KpUB9gzz9XRTQ5dNmZCxoTBzu+qAYd5PmjoYPHlAtn21w7yJHDS4hMpn6uPDvqYrfa/PK3rzSnZ7HNam38EVK1f69btlN5435kpqQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0401MB6611.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(42112799006)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1VDNzFVbW4zeEViWXpUekN1TU1yZnorbkcwNEZ0YUpVYkFkd3diUG1wOEhS?=
 =?utf-8?B?RFlVbWl2N0dkTFNQdGkvMmN5OENNRXdoV24zWEh6MTk5R3BscnlWWkE4c3hX?=
 =?utf-8?B?WFZXTDlHMUEwK2dQZjZzMVYrS0YvUmFOM1A0VEl5MG5mR2dIRWd4YkZySVdE?=
 =?utf-8?B?dDJtMlNVN2ZkVktLam96MEpIekt5WmljZ0graGcrR3dOd2luRkFYb0lpSzlx?=
 =?utf-8?B?UkE4VnY0T0NuNnJUeDBmcTV4R0RzeFZzUGxQaUswVXQ4aVRxdmNVL2dHaTVo?=
 =?utf-8?B?NWtEQjIrY3pKOExQMjBveE01RGd3WWYzKzN2bVU0dnllRGlIa2wwa29mV2lz?=
 =?utf-8?B?YjNWb2lmNGlyT0FaUExjNENZcSs3RVRzeXNCWGFDQ3ZFOVBhR28ycXh3cHh2?=
 =?utf-8?B?dnkxV2hwSDgxd3U0U0ZPTVExY1RRcjRtRSs0dElFMWVkb3ZiTFE4NXd1QXE0?=
 =?utf-8?B?T0tyWXMycndIR1hobC93SmNiY0Y1WDVZT0hrL1JFeTE3aFRoSTVvNFIvM3pv?=
 =?utf-8?B?NG5idVZkSnFIR1hSTGRlUUVQRHpSazF5eWZCTUIxQklOWVhiVko3eElZTkpl?=
 =?utf-8?B?eUg1SXVxR0ZtNXhJVTliUnYydzFVLzBnWGxqaVVrZlFUL2ZPbW1BVXJqOEtm?=
 =?utf-8?B?bWdFVUM3cTVSNTRoYWVBSURCUDloZ3FkbUw3MW1jT1lKL1Q1Mzc1TUN5cUZH?=
 =?utf-8?B?S2pTY041OVBEWDBMUktNek9UNG1wcXN0NzNybFRoV3p6ZFJWUHFJdFFVeFQr?=
 =?utf-8?B?d0lUM2ZLdG1xUDRvOUNYS2pFNVFhQ091NkJpcFlxSE9zZHVoZnJrVkRzRE81?=
 =?utf-8?B?aVJTYWZBUXZSSVFkM3pnMktkYlI3bFhyc0hVWjlVU05EeXkrNjl4NE5zTTg5?=
 =?utf-8?B?VTVlQlVpaWEwVTZSWVJMeFlaUXhrSldTYmRZbEV3eHBHVGJWY0NjK1o3VzV1?=
 =?utf-8?B?Q3ZoLzM5MUNpTTZLQ1lpdTU3eDh0a0I0Y1FOdWlSbU9mU2FmZDRzcjErM042?=
 =?utf-8?B?YjFBY3FHdFhqK21kRVVwRkg2bmRnY0hzS0wzSUZBOFd1b256OWRXYklKazVk?=
 =?utf-8?B?Tlg5MlNjclJHY1l6bjN4VThET0o5UVhhOGI4SCt2elpDMENuK2lMamxaRnRG?=
 =?utf-8?B?ZE1kOVpGTFVsUlJXbHRkYkhMaWNpOHhNTDN3UVhqQVJZVC84NDZPbEpUUXhs?=
 =?utf-8?B?UU11NlUvRmpNUUo2YXZ0MFRBbmEzZFdZeEZrZ21jRWMxOUNFaHdMR0QreEI5?=
 =?utf-8?B?dU5SNjRLL3ZoazA1L2xXeitkWUdDUWxncVp2SmFIV1IvMGFzdEM0Q01qYWp1?=
 =?utf-8?B?YVFkbmI3bXl5Mi85bUZ4SjhYZ0ZUb0JMQW1rRm5ZSWwwc1J6blgxRjdRcWtC?=
 =?utf-8?B?cHUzLzhIWUtKK1dHQms5eDlXNTlka0QvSVlwYm0vNGZkaVAyUDE1aFZSVVJy?=
 =?utf-8?B?YkM2dnhrOUlsTnFPSkdieWxPVnR2ZGRqVUlkTG9VTk5rUThtT2x6eVNmMEsx?=
 =?utf-8?B?N2FkKytIRnlXL1JMdEVnT2VyVHlqeWdGOXJpd041ZVJHUVQza3dibWZ4UGFo?=
 =?utf-8?B?b3YraGJrbGp6dnZxRWRjYnBvcy9vWlJyY2FWUFRlSklyd0NiSFVKOW9sRTBu?=
 =?utf-8?B?aDRKOStMZHZUaGdEOFg4eG5yV3g5NDFWOUpoNkZBMDBHOGdzNTV2UTAzWWw1?=
 =?utf-8?B?TXhPT1NPcDZQUVZlQlB0ZmZZbkNtSFdFKzBpMzl4eStvM01xTUdYMnlLbjBz?=
 =?utf-8?B?TmdLTGdtNmxrQWlRVnYydTRVM3UzMXFTajBNUnFyZ0JLaEtmaThlRE4rSW82?=
 =?utf-8?B?Qm1VL3E3MDkrcitNOExINHQrR1QzRVlSQk0rdUpTU0VQV3JlNzEwcWJ1YkQy?=
 =?utf-8?B?c0ZNcEVWcVlGU1UxVWJ2U25rVmxXREVEMC9qeGxWUXZ4Sit1UG55bHNrVnRi?=
 =?utf-8?B?cS83cXFxcnJ5YlRYWERVY1NuSEpjbEtrODlFdUl5TDc4TjRRelR1T3UrNlRT?=
 =?utf-8?B?cTQweGltMVBYRUJXOC81ZWVtWCtzU3Jvb1hGUStOSWFZOXNseURGeGZjQkV1?=
 =?utf-8?B?NW5rdHJwd0VTSDhrN0ppcklSUHhyeG5ZN3VNOEpxSEI2TVdCcTMxcmprTFI5?=
 =?utf-8?B?OWMwQzZENHpHNHQ3ckZScXh3TjlSZjhGNFhFcGc5UGpuZWZET0FhVHR5Mlhp?=
 =?utf-8?B?MHE5RVJkeWZXdm11VlZ2WUdNaFFKWGIzYzl2TmVjR1IrVHZnamRETHdpRkh6?=
 =?utf-8?B?TUlrU2VLTDlTbzFuUkd4OXFJYmJ3bFFjWCsyc3ZOamp5Z3EvZkZQa05RaE9j?=
 =?utf-8?B?V3pPelRhMUpUc3F1VWhxY2RjMFhUb2x2MVpkUU10Y2hjRWQzYXkxUT09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6611.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83964f01-ec1e-4cff-cf62-08df0ee15385
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 02:15:04.1167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1M/shjac3teuX0E10pqh/+G4Pa8EyX/vnSiqRdMHuvsZmh3iqEatV4Mc6Sj+MDpeJhh5RHRqbmJp7vxpFWFIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7936
X-Headers-End: 1x4UZL-0007on-GA
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

Gentle ping. This series was posted on Aug 28 and I have not seen
review comments yet:

  https://lore.kernel.org/linux-f2fs-devel/20260828121816.1463654-1-ke.li11@transsion.com/

  1/2  https://lore.kernel.org/linux-f2fs-devel/20260828121816.1463654-2-ke.li11@transsion.com/
  2/2  https://lore.kernel.org/linux-f2fs-devel/20260828121816.1463654-3-ke.li11@transsion.com/

No code change since v1. Happy to revise or add tests if needed.

Thanks,
ke.li11

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
