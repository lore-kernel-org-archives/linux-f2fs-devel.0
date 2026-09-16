Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B1AC88E77
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LIhyYAZ8NHJvxA8AbgwCj4LwMfxxEOVE9OADs6Qutks=; b=ks/KN9wyW/yXYo+uVyXHtP/MiX
	jUoX1UgxJ9NHl2mAHXrtf4CGKmWGXmXfUo+lfYKfN0E/qg512vBncqbWlgwGjXPMPoUHCNOuhjt7U
	Zg5FwTP4j3WqOPEhN26rfLSGAbwCsWxpPsA5DQP4CchlZLtrabN1oZ/CYjTgQFpd5a1M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6imn-0000If-Rg;
	Wed, 16 Sep 2026 06:06:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1x6imm-0000IZ-Ft
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:06:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5ik5uD7tvqHch8Cr5due2D9kncfnl0vNEk+AaZbl1Bo=; b=YhdAgTaxI3y6XEJcwQUMhg0dtE
 IrwP8Strh86D3BlHmA4jjLanC60bwp1zuOsxuWqcSimSzkiKHJju1D5NDi+KZXr4cESTePi6qyfm/
 Kwh1PQ7/krGA0usnK23itZrX3whleN01WqCG3IeypX5xtL0Oj8TVBONQM8p1tvoid0eU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5ik5uD7tvqHch8Cr5due2D9kncfnl0vNEk+AaZbl1Bo=; b=bwopAf412PB+NuLTRJp5jp0tAx
 k3UrKzBpV9FPdOlXrI7B9IL7rMbKIZGjN6C3xf1BuVwLc38v2oubYnPDrCxe4bmGbnxbQNK0Aqw4I
 i3ddOBpI/ZIFUbcPKlNdd6CjgUAVNJVgpYd7TtliAGhF5jt8USq83UKxpiYCUg+kQBCI=;
Received: from mail-japaneastazon11023138.outbound.protection.outlook.com
 ([52.101.127.138] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6iml-00015t-Lc for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elGRy0c8DK+ZMGChOgXZei2PIzc3fUVYN7Mj0EmG247joRMU1m2U6DeUl04vfRFxfX6iFZ/Qgob/35Jqb7o8fZhRRaPvtSEZ5vbszO/bpGtNINY+NywDTLktFqOIncZIR3gcNfUJoufz8hZFdNLvF1MfXPC7KyR7PFjxzQtKBPd32kiNS6vcnTR+/zV91bPP0oa/oxNViI/8iH6Vzw+lcFsy+8eBKe1T+zAttktTlDVldd2AAUhQcLnhHgnL0LiPZWFJL+hgf6uz+ytsB2PRtjkm331/pdGWb9gsZ88N1k7fWs3aNqHyQAajRoON4X2BB9wzuHbx+2XrOtFffNKv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ik5uD7tvqHch8Cr5due2D9kncfnl0vNEk+AaZbl1Bo=;
 b=A2aSR/pCMuneVkVdWlR6JZSLR8CCWqF1BsvLiVds14bcwIIURwwRiZqVmFNmE6HzBQgeDrYKvJk8J2V7D7JMGgDOj1LAWkeAXZ7OGm3UNUxT1cmjAH3v9xxZjXbIiE1Huobndk54/1G4Oh5OtOMpdNGGvvq9YM2HfATzCEOoqSXEUOBrb3zhEHBlC1hQYuyogcJ9aZb7ptuPX6gchpXuqf0sguiFbHDJOLG2iwK8+Ez5Vx8zjdft24Tz0j5ggSrX2LxRfGtKRtPXSpyxAVZtv9wEjeK9ngb0TUldJCMDs220cNYg9+H99fbMivfqKaujyMtUwjyRx3ISL4/SZzoYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ik5uD7tvqHch8Cr5due2D9kncfnl0vNEk+AaZbl1Bo=;
 b=KGWIM8KWZFBUX3XA/LXKv4R32z4tpNiH7bOKT5u80TPtdp109fsR7dykBD6Nd8XUzB2KtPTncwDz1R9stJET1uavAHQPpABqq8qJP2hNA/T/Y77zINP6sLkr1yWxIuMpLL810v0/xWj21UMbEFCqRRYZE9EwQaeqLJRN3HxHJTo=
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5)
 by KL1PR04MB7819.apcprd04.prod.outlook.com (2603:1096:820:135::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:06:13 +0000
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605]) by KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 06:06:13 +0000
From: =?utf-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
To: "daeho43@gmail.com" <daeho43@gmail.com>
Thread-Topic: [PATCH 0/2] f2fs: multi-device expandable storage support
Thread-Index: AQHdRByjvgq1d+cgtUiNBlbw1C1BW7bOHWqAgADGtgCAABO/AIAANpwAgACZNoCAAPMGAA==
Date: Wed, 16 Sep 2026 06:06:13 +0000
Message-ID: <20260916060610.1098289-1-ke.li11@transsion.com>
References: <CACOAw_xEqmpDQ9T-zqqvd4G6sxR+AZj_+v_3uV45G6SR4RFEgg@mail.gmail.com>
In-Reply-To: <CACOAw_xEqmpDQ9T-zqqvd4G6sxR+AZj_+v_3uV45G6SR4RFEgg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6611:EE_|KL1PR04MB7819:EE_
x-ms-office365-filtering-correlation-id: 70402880-cedd-4480-e86d-08df13b89cc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|42112799006|38070700021|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8zpncSik9VO7ICxeyMI5hdJd5ViFktTsHFf1zBKriMv85Am6vbiVtRKtNNx/tY+1o0I/59ISp+26x2W+1sLbEf15z3i8VaT94lYT+MKGK13VMJZK/Dszsit9I9f/nwFhn3eZW5P5LQV50lvuPHyz/5fdi4L6XQ1McLEBziVy75gqzUfj3B0M49xqaYXGOzVf9o+cak560dLCLtWnmsNbdNwBze6IYkQlLPiGGi8deUi22BmxZK3cVZCjLhxhLB0qohIQDwK9wckPPqE2wXEKECvKiDAisQkphMTDgbYtTgzXoBb5x+zi0B8j7tGLRdmHcdStdVVHsJ8pKjWvhdj99SzEGdW9hcd5txmJFqcb+/ZIGN3WMaLlx3uR3Db09Nx17xF1rdA9UWBEeWMSFAjwEWXPXEqwlzE5HtV71BUsQhPjL6R7qPX69hZO/8Kx3jtDVKcU46KMk3pawnVlQdahi1SCwDv/uR1Dbh0KCw6+Y7NI+QzpvK3EcXaWetOWqbUcq3PFNV49ZBdrcPYWgSr1WXfxmzOLUERVgf3pVF1c6ELeqCBhJn5JD4vltXMABLGHSrqgZL9hgJeGpWWbp/OzGOmQupCatSDJLvb2AIQCzgcsGIMJ4h2a2jlVtoL+JQz1qGfQHwzbm4s9omk0z1xr8ASXyHd/4mx3qopZ921s6R3AieD93MbvZ2UKrmAAo831FcVWwprxJ1etzsbVn9GpgWVaLPv8gTkaWdb6LNJIEvc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0401MB6611.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(42112799006)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHFoOWFiZFdIQ0d0OVpEbGNBQ2phRUtTeFdHbXN2Q3VsYWRlTXducjVjRXRL?=
 =?utf-8?B?U1NHYmxIRlUxN0NYQW1DaHRTYlJpc0VQbU5MNy9QSS9xNEgzemlwUnFuM0lq?=
 =?utf-8?B?anVDTEJNRW9TVTZwOGxUeGlJRUoxdWtQQzhVYUs0dHdzRzZidCswdUJGV283?=
 =?utf-8?B?RWE2clJuRnE4ZFlSTFdZOFByb1JhUVlra0ZmTUpCdUFQL29nZ1BOYm40Umw4?=
 =?utf-8?B?NUIvNzl5cU9oVG9LeURHMk5jQkxKY0xnOVZ4cTNDZzgvdkRkNjAzblIrZXJQ?=
 =?utf-8?B?eVlLL1BwSTJBLzNYVWx4THdxMG1QRXBrVnRQd0x5bGlabmEvVWlaQXlsZ2Vr?=
 =?utf-8?B?UUg2elRRR0JjR3JtNUFBYlp2MXFhQ3dSV1BwVk5zSlVseTNvVnFZY0t4cjVS?=
 =?utf-8?B?dlNqUGM1SDFjRkhzcHBkb3UrYXFmVlFQeFMrdFRxZmRucXVVMUcwN0NBKzRn?=
 =?utf-8?B?c1lqY2l3TkNJSFgvYXRZdHJ5ZTFlTGt1OUdGSGtxMEJEMnpIa3IrbzcwSnRT?=
 =?utf-8?B?YlgxdWZoK01lZm1idCtMWjladUh2NHNIckI3VXNYaDdhYUhCMXREU0t5T2Iv?=
 =?utf-8?B?MW9NV0NVbHFRbnpBQU5WWnNKMEp1cWJNSkwzaFVpN1BBR2hUZElOa3RObW5q?=
 =?utf-8?B?NW0zd3V4ZmNwMzZWQ1Y4MjJhOEZmZ2ZZeUFrSUYySEhEZHg2ZEhyRko3NzNO?=
 =?utf-8?B?NklWUHBFWlB4eGJYS2k3UkxjWEh6OXRKNVJkcmwrcnorTENzWEgrdlgzbnBI?=
 =?utf-8?B?Zjk1cExpZ2hTSjVuRVFGaXJ1Z0F5ZU12cGIzcmJBcFo0MFFsWTE1eEFXQktx?=
 =?utf-8?B?WWhiRk1uaEJzOXpPZ2NPeWdGdkhITHZSbXN5KzRlYU9kZGZFMzFEVUowTGhR?=
 =?utf-8?B?QmdSOWFEamJnWHlhenoyRHFUeFVkTFZoQXk2aG12NnlSUDAzNmlKdy80Z2hV?=
 =?utf-8?B?SkRxK0FaakVGTm9HYkdhc2hkMlEzamR5UFA2RWlUY2VUeVV1K1FLZWl1V2I5?=
 =?utf-8?B?QUtNSDRrdThKcElwR2I5MFdKSEhPZ0V3UUpSVDZwb3l1RUg0Ym1aVTBVQnFx?=
 =?utf-8?B?SnhlUVF3TmRJQk5YUGFiMm1PZDl5SW1rOW1jdjUxUTZLUXlPRUJOREUycmpI?=
 =?utf-8?B?cEZrdURXUXhNNnBURStZRjNHcUV5ZXowanZKdVhCM2JvVzF1SWdVYnpocDYv?=
 =?utf-8?B?M25SK3F4d0dxYXpEb1F0VGQwMk1GWTJjMlFZWWp0QnV5QmxSa2lWbFY2Tmh3?=
 =?utf-8?B?U3daa2xTdnZ2dmJ0Q0x5aVR4NmFubU1MOEZzeS93N2czVUFJN1hxc3BQWGlz?=
 =?utf-8?B?WUJIUGNHUjkvb3FQMXF4eG5rSjVpeU1KVlc5YjZXdnhXNGNLb2FrOWlQdGdz?=
 =?utf-8?B?d3dRenV1TlNTTllBNGkxSVZ5b3JNTnFRLzRYV3NIOUdOeDR0Mk9Kd3pBZGQ1?=
 =?utf-8?B?aU5tZWllMXdXaW5TWmthMDZxdFEySjJQWjN0UE5sQ1JHVFVMM29mUGwxWUF1?=
 =?utf-8?B?eEY1aWZZeEhXNjJ2SUdnYWVQSUhpQ0ZWWjVXNGtSUnZwSjNSS0Izc2NGWmoy?=
 =?utf-8?B?K0xCckJzUGNFNytwb0RVdXh3SHRxbXlBOU5wUHplTHB5c3hHWkk5elB2WmRy?=
 =?utf-8?B?M0Y1akc0bEpKRFlSV0F1aGplclc2bmpZcXhIdzFIQzRMNlBUZ3IyQU9reHc1?=
 =?utf-8?B?NURMcDlhZC85b01uakhMQmNHZlNGb0dwM01hUnBpNTBwSzJhM3VmMTFHYnk4?=
 =?utf-8?B?SmwwNzlRRzZFSTVDUTI0M1U1SzJOOTRickNhd0ppSHdUOElXZUR5R0xjMTNz?=
 =?utf-8?B?bzZPZ0VJNWdZOTZXcUxQeEs5NXRDbEk1ZmhCNFBuZFo4UGNDd3hIdGVCSjZU?=
 =?utf-8?B?MkRLekZiZmNXT2c3c1RwN2ZNcDZobCtreGloUFNWWFpHbzNCTUw2MFUvc3RN?=
 =?utf-8?B?NC9XcmpKM2NPUUhwblVJVkZ6Y2g2MERxR09VT09XZThRWm96bkJnNmtRd1JZ?=
 =?utf-8?B?NzN3ckpMMXMwcWZsYlQ0RlN4RzA4L1k1L0hTQXVrV2ZrTkF1WDlCajJoRkZo?=
 =?utf-8?B?UFNWdUZzYlRPblpQckl0a0xTc3pjUnhnMk0xeVJhaUJtY0N5M2U2QkZHQUdO?=
 =?utf-8?B?aTVyUEh6bnBVZzc2dW4wbEpON0hnd0RXZkVsTElPN25XSldmeGVoT2c0MEpX?=
 =?utf-8?B?NVA2L202dGNQWkw4VEI0YnBweXJDK2FvZVJaWXVCTnJrZFo3aWRraDluR0FW?=
 =?utf-8?B?RDBFanJVdHFsUCtiTkdKT3AzM2FRZHp2SllFQkxuejZ1K3JxV2UwTkR2L0NZ?=
 =?utf-8?B?eDB2d1hqODZaL0U2SEV2c0dyYXZicXF0SzJnWXNJdmduS2QwbUZaUT09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6611.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70402880-cedd-4480-e86d-08df13b89cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:06:13.4147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6N0ql+iptZvTXWmOC5cWNwVLyl9S95998MdRyQPiQtycBRpppB6dPOgK3PF5yXFkxLg0CfaIPnS263H6fHxkMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7819
X-Headers-End: 1x6iml-00015t-Lc
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

Thanks for suggesting dm-linear.

We thought about a single-device F2FS setup with dm-linear,
resizable_tail_secno, and a normal resize. That path should be able to
reclaim a super-adjacent region and let userspace hand the space to
super, but we have not implemented or verified it.

We would still like this series to be considered for upstream, because
our layout uses F2FS native multi-device with a real secondary block
device, not a concatenated linear disk:

- while the secondary is attached, we need allocations to stay on the
  primary (alloc_primary);
- after a final shrink that removes the last secondary, F2FS must drop
  that device and clear its on-disk path, otherwise the next mount still
  opens a block device that userspace has already reassigned.

dm-linear can hide that lifecycle from F2FS, but native multi-device
already exists, and the shrink-to-single-device case is currently
rejected. These two patches fill that gap in F2FS rather than moving
the same problem into a mapper table.

We can evaluate dm-linear on our side as an alternative product
implementation. For the posted series, please let us know what else you
would need in order to continue review.

Thanks,
Ke Li

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
