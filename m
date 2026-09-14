Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72242C88E64
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 03:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:In-Reply-To:References:
	Message-Id:Date:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pqCSyabpTSiQA+g/LXWAKUcLw5RwSn6tbseBiysq798=; b=WfeJSOOC7LRBiyGN3UL+CPBDJ7
	2KIPUQ6dHf05xMGQ4DzoTUqv6/TtarEPKAdQmgn9ZL/gNX5ZMyBCPVolfh50rVVrlCfCpWuoWDrwv
	+5j8TUs4zS2j7AGIQelk0n7wxDHK7J4cMyF2TS6xY9/5KEGL5LUtK9BK0QpgUDxKfo28=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5xny-0007Yc-Hq;
	Mon, 14 Sep 2026 03:56:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ziy@nvidia.com>) id 1x5xnv-0007YS-Rj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 03:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Cc:To:In-Reply-To:References:
 Message-Id:Content-Transfer-Encoding:Content-Type:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KmJueOys4162YTP727zQmwKPUht4GWCKnV6YwC01lf4=; b=G/0DKyhFJHXljXsTOhvWMYMIZ/
 mCY4/3R0/bzeSp3OPK5IsHcsdZGx7WkwDnnFlzhi5hU7+5qCKfOcTa6ETUw3ozZwwxsAhwGpcHTbe
 pMeGOeTzxQmzWs4IP1gVihwhFxbnVu2P4GXXhqmOBBRidod0ylQINRxFJPcPsg6RxSf0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=MIME-Version:Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KmJueOys4162YTP727zQmwKPUht4GWCKnV6YwC01lf4=; b=ZI57RRNlZVr5Fre8to6ZXFV6fJ
 uUV1cyW2+w54NvUDzDnWzXQqv6tNCPz/nR3KkKUEEpwmD48mDrtox3k8D5G3FHEQXo5+Lm7Tf/ncl
 HoWgo3QWhQT1rWaOkTeMUlRxZP5NQCqkCXIm48j+HQr8Tf/cZp1OSI4iGQpPORvKrjZc=;
Received: from mail-westus2azon11010019.outbound.protection.outlook.com
 ([52.101.46.19] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5xnr-0006pL-LM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 03:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyeUyT24uaoa6vhNMRnp19Q+DjDQYkx8+vKwcJyXEIOjzOjIWXxvSJq0scmoWoo40n224tcSsYvu282BQF0y6g5lqYQ8cOZrl/+DX4wdXDU8zt8HYn39BtlVa+K+54Xuuh9vquqlH0ncHakQ9d1vNAbztxuGF0Py6IAfB2TRTG87gMYcvv1qN8tsXArUy3nrJXVPdcBFYDddAxuRAzkrzMN+GdDI5K/KKYQwjkFRx5QWY6rP3fLUis4wzUhBh0Hhk1WJHDPcgJPjEFjk3H4KdcGvf2Jqqfw4gBwzyYHVHHSuGBRe+c+SpuQeueii4veyJL3msLCuqoM5234wDubX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmJueOys4162YTP727zQmwKPUht4GWCKnV6YwC01lf4=;
 b=x1OstSI4vBfoh86AUdUo4MSY2UKlX47pNESipU/y8c3Ord6w38us0EoFaXhj1JO2PuuEH/8phmztqxwqvQKl19Qbg6XKScMfTaRZmceh3ddu3ym/4Sq3PCpOhx9SEesT3a7EB/V9BVBdThvzSwQU/IvfAcmslIJLY7EjODoA4WHDON+NxzVB6eHOF9g42bMPjwhiGNuppFeY2b98+rRu3oNuNmMbqRbVUZYvUKAGIhLp77jMjF/GSEUyCG2GrvhMsbyp+G1Kvz3rKgrXiRnK+occ1g1C4A0LWdo3+3l+XOr6LjOoiGBv04wOoybXvnfhmlltzqHh66InQzNsGPIyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmJueOys4162YTP727zQmwKPUht4GWCKnV6YwC01lf4=;
 b=ZeGN1PiF9BgyQCXrKhajxbSwPIijlIF6f0+kaqX5Ahm05kOf7WJdDtiyNG4b7VqQ3lrjbnTbdpUV6C7/5g1XkfnP+2kyQ9ZjjWOh+XkbNYLn2m2gpilbu7BwXNvKTOrbld0NHXx9ddBpN25ejJbT77GFUoZDmQfjgI2IV1rVrwFG4DtLd8eZjHTRKix8AtjmWv7mh2e+gqRd6njTsc52u46T6mrM1CKPUqtqS5c/eCbQ8htK2TWwkHp/4g8Q2HgDwrpa3xz1Ufxd68P9XcPhEaaMPKJPqI/OTZOZ0bMLhClnUBtw1G8c0Num1HY1EMVXPBjZYE2/aaHmRgu1oRmNPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 02:24:20 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 02:24:20 +0000
Date: Sun, 13 Sep 2026 22:24:05 -0400
Message-Id: <20260913-remove-pg_private-v4-7-848550f7574e@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
In-Reply-To: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: MN0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:52c::13) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c12b514-a3ba-4eea-979a-08df120748b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: cpMkaUZNJ466GAw45De0V+gsLJuf5jEyB0VOkKILYIA/a5D5sYlllWFG/PwTfSkdFAMxNc0GibU1ryLsZcaw3VM+AoEnHYhB1w3gU13NPn6jxJ2FncUtUB5qstaMJXxfvXybdb/LIvMWx52/dfomvfBefuauSFYzF+j3SWMg0sYE+p8xXQlCawA76fmKk301Hbetso05ZDz1QuhFxDNN0V+wn6paE2ZgAIkypLYYqwqgjI0TcGleyQjlVTOAPKBg56IWYjYmT2GMpO0aqthDB2IUquzBf/uJMNgnp5kt143dC8Ynw/4edjTppQZrARBH0tRbMNX696NZQqQZjQo4MMPFTWID7UUcpH1jYjhYke0mjM9HJsZ7PcuygvwiMZJpKiQBO6ty+Zz5OWY5k+jCm5jO9EqZkK32wK3G2KubHulgSh+FOCOTG5pVNjHOGU/wiCZ+nLKuvufYuGu5t0Mcj5lADiEljyxdfy4lDA9dwsBj0wZxQW5XstGJkuzX+BTB5+pbvQ76exl3vr+O++AiU/cTQNghs+be3EDB7+yqarfZrXYZ86GeInKtxGd8EoZSSfYvfBuINnOoIjkpjN675xsIAGm9Z3M6piUE6VmmR8rPl5NBIy/lWOHkxLvzMWaX1sgW6nobcbHxWDDGdatG9X7G0P0TFyVMycd1VWrgaBQolThpv2rPY7QeL1fdz6G0oFUCw0QWt8fW1i6cGzChsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBKNm1FSTlyZ2JBNG5xSGt0VlZyODdxMjlSUHZCbVRUTCt1Y2JoN0hidXhI?=
 =?utf-8?B?aWQ0cUpUdzBiNXNJN2NNMHgvU3V6Mk9BdXBVZjBRWWExNGpKb2pFc0hMejVV?=
 =?utf-8?B?dXpzcm5nZ3BaY1BxVFZQdDBmS3pxSm1oZ1RmbnBsL1JNU3k3THAwWTc1emNq?=
 =?utf-8?B?TjdSV3V4RzB2aURqQkhpcWhIUkhoS2UydnRDVmNHR1JPQUFaYjdaUVZad1gy?=
 =?utf-8?B?cWZEMEtwcTE0UURpMm0xMTVGQlpaYzR5ZmtLRUZkb1QyYVNJbTQ2S09VbnFz?=
 =?utf-8?B?aTFSaUhoV1pSdlp3RUlxRDhLalU4bWVFVkxEOVFDMDhFblNJT01nblpHK3Nq?=
 =?utf-8?B?MVdFa0xWSlNDS2M4L25JWFJPQXk3M1R1OE5meHdpVkxpd1JndXgrUEpTR1Fz?=
 =?utf-8?B?UmdZaTFNYitLN014ZWdFaUdLTWtlWjhYckJ1M29DOEZwK2wzTDIwMUNqc3BV?=
 =?utf-8?B?Zlk3bGhqYlA2dFEzOHhWQ3V5N1ZXRllTK0RaL2Ewc2FJeFByR2YxZFR2RFVI?=
 =?utf-8?B?aWRyOUpEK1dGL3FKbFl3dEIvSHdUVVFsNklrbUtYYWIzZ3NrbXBXclE4SnJ5?=
 =?utf-8?B?cDMrVEcxOUtqNlEyWmszcjdBTk84blNNT3E3MFJRcE83aGZ4RVNmY0dKRzN5?=
 =?utf-8?B?WXhJekhQMFpRMWQrc2haeFVqbk1XaHR4VHRXOWpxTlBKNWtTMlJyVGMwVEdT?=
 =?utf-8?B?bCt1dUtsa003S3JyV2tWL3MxUU5ldktlRGt3VytxRkVtWHNSUDJqV3RhMndN?=
 =?utf-8?B?Z1laNG9hYUpGWTlDVWR2QWFOYWI2c2tmTFh5ckltajRvTDNmTCt4K3FSNWpE?=
 =?utf-8?B?ZVJRRXkwem5HRVl3a2Q1QUlqeG1FTFNsa2daS3ZuMUJXYnk2ckV4M3M5MzZ2?=
 =?utf-8?B?QVVwQllhbmZ3SFJmOVpvSEh0QWZqQVVNcXJiMHRqUmczV0JxWjhGMXlPNDda?=
 =?utf-8?B?RXhTWXFYdkQzZkJ5SFhsRHdOOWFiVnpHK3k3cnpwYjJLSXJpTXhBMlpDM0dM?=
 =?utf-8?B?TTlmdDJTeVV4UldjT0QwRGxjYjFTZkxXVGJXaERxKzRHYyswbElDdi9XSzVR?=
 =?utf-8?B?SktzY1N3b0FjK3pYbks1d3hYOG1nNzNKZ2hWSGFYaGFNbThnR3BXU3YrMjdF?=
 =?utf-8?B?VWNFT0RvcEVqS2xOQXptaURYUWhJMnMvTjJlTWxZUWswdVZvbFhpbzZGaGYw?=
 =?utf-8?B?eW05aHoxRjNoQnV3VlVuTUlleFQzM0kva1Vmd2EvVWhTTURIa1d3ODVBRzAw?=
 =?utf-8?B?QVBGS1owQ3JKV1A3a0JCNS9KR2s1aC8rNEtIUXZ2enl1a1owUGhILzZON3hz?=
 =?utf-8?B?dzQxYmhRbCs4RHlQUDRRZWlxemliMXcybGNzSmtoNGlDRmVWcnlQWUlYLzdI?=
 =?utf-8?B?SnkxRjhuTlVCdDZncWdHY29JMXhZVk9WMjhLZlk3UCtidU9oY1NiNnhESEJP?=
 =?utf-8?B?NXVyQThGYXZ4MGs3dUNzTzFRK0lJc2xkTXYyZ0pjL3hkM3pFdHBtM0Vwenpi?=
 =?utf-8?B?ZERjU3lmUGFZcTlINkFmWEZjMDlHVDExVC9LaEtoK09MbWFyL3pEdmFKTitO?=
 =?utf-8?B?bkN1aWdNWjFoRi9hSTVkRHc5QzVxQmV4UmZKZjV1MG5qTkZjc05vQjlPdWVR?=
 =?utf-8?B?OHBBc2VKQ254TmE2REVvRFhNN3Z3TC8yVmpUTXMwcGE1TEtuVzUwQ3RpOVo1?=
 =?utf-8?B?MmFBV2pIUzVKazM2Y3lKTENBaTQ1L29BWUlNWFNxQnRVYUYzaDBhQ01pTm50?=
 =?utf-8?B?bGxwdlFrbytzeUhnOThwK0dCSklqZGNUSFJDZVRWYVRzYjlsdVBlZGFMV1ZD?=
 =?utf-8?B?OTdCc0NBZksrZVJUNWd5Z21JQ3htaENnVmVaUWQ1NGl5SVBWRUNDMjdjRjVs?=
 =?utf-8?B?SjNXNk9Xa0lUK1czRmdySjk0L1kwUlI4UG0xVTNoZnhZTEs1MXRGMkZXVkU1?=
 =?utf-8?B?bnZ3V0V2QkIrU0xnWkFhS0xPYU5ySEFYM1B5bjRYdCt3TzFIOXJnMXROR21y?=
 =?utf-8?B?UVZ4cE5ZRXhmNEFpNjFKenlYTEFEMjVaaTlHaUkwdHgwUS9wSHppeUI2K0NX?=
 =?utf-8?B?ckhJZStpdzhhbG9kUEJWOEE4WU9TcS8wUHJQVlhudmcxZ3Fha1JLT0VnSzZ3?=
 =?utf-8?B?bVM3cGpzeGpDd2k5dHpPY1g0R2xQTXM3eVRJcEZkd2pLc1VOY1BnM0NNUGY2?=
 =?utf-8?B?ZlJwOFRkekZUWDdrWkRuSjZvWkd5dWZZVHg4T1hmQ3ZsUGNOSDROZ1A3dEQy?=
 =?utf-8?B?VDlPcG5kS1ZLazN6eE53VWtuKzlUQnFqRk9PVHhZOTBLUUN0UEhiUnJyWEtN?=
 =?utf-8?Q?SyYbQVsUglvuogXEUo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c12b514-a3ba-4eea-979a-08df120748b3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 02:24:20.4722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKsvlYwX6onBWxi3rfWuJ7rRMzPsLuzNJldGgPOSrAsNOodFbjLLiFWqx7+naphA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
X-Headers-End: 1x5xnr-0006pL-LM
Subject: [f2fs-dev] [PATCH v4 07/16] f2fs: convert the ->private flag
 helpers to folio-only
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
From: Zi Yan via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Tal Zussman <tz2294@columbia.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

page-based ->private flag helpers are used in the compression path, where
large folios are not enabled. They can use folio versions with
page_folio(). The two remaining users in data.c and segment.c can use
fio->folio instead of fio->page (two are in a union).

Drop page-based helpers after the conversion and rename
PAGE_PRIVATE_{GET,SET,CLEAR}_FUNC() and the PAGE_PRIVATE_* flags to
F2FS_FOLIO_PRIVATE_* to match. Convert the folio/page union from
f2fs_io_info union to folio only, since no page user is left.

The folio helpers do a plain read-modify-write where the page ones used
set_bit()/clear_bit(). It is fine because the converted code either holds
folio lock or, in f2fs_compress_write_end_io(), matches what the
non-compressed code does in f2fs_write_end_bio().

Assisted-by: LLM
Suggested-by: Tal Zussman <tz2294@columbia.edu>
Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Tal Zussman <tz2294@columbia.edu>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/f2fs/compress.c | 35 ++++++++++++-------
 fs/f2fs/data.c     |  2 +-
 fs/f2fs/f2fs.h     | 99 +++++++++++++++++++++---------------------------------
 fs/f2fs/segment.c  |  2 +-
 4 files changed, 63 insertions(+), 75 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ce88092d9ce26..09d9b8d0fdcce 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1064,13 +1064,15 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
 
 	/* Cancel writeback and stay locked. */
 	for (i = 0; i < cc->cluster_size; i++) {
+		struct folio *folio = page_folio(cc->rpages[i]);
+
 		if (i < submitted) {
 			inode_inc_dirty_pages(cc->inode);
-			lock_page(cc->rpages[i]);
+			folio_lock(folio);
 		}
-		clear_page_private_gcing(cc->rpages[i]);
-		if (folio_test_writeback(page_folio(cc->rpages[i])))
-			end_page_writeback(cc->rpages[i]);
+		folio_clear_f2fs_gcing(folio);
+		if (folio_test_writeback(folio))
+			folio_end_writeback(folio);
 	}
 }
 
@@ -1078,11 +1080,15 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 {
 	int i;
 
-	for (i = 0; i < cc->cluster_size; i++)
-		if (cc->rpages[i]) {
-			set_page_dirty(cc->rpages[i]);
-			set_page_private_gcing(cc->rpages[i]);
-		}
+	for (i = 0; i < cc->cluster_size; i++) {
+		struct folio *folio;
+
+		if (!cc->rpages[i])
+			continue;
+		folio = page_folio(cc->rpages[i]);
+		folio_mark_dirty(folio);
+		folio_set_f2fs_gcing(folio);
+	}
 }
 
 static int prepare_compress_overwrite(struct compress_ctx *cc,
@@ -1281,7 +1287,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.op = REQ_OP_WRITE,
 		.op_flags = wbc_to_write_flags(wbc),
 		.old_blkaddr = NEW_ADDR,
-		.page = NULL,
+		.folio = NULL,
 		.encrypted_page = NULL,
 		.compressed_page = NULL,
 		.io_type = io_type,
@@ -1370,7 +1376,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		block_t blkaddr;
 
 		blkaddr = f2fs_data_blkaddr(&dn);
-		fio.page = cc->rpages[i];
+		fio.folio = page_folio(cc->rpages[i]);
 		fio.old_blkaddr = blkaddr;
 
 		/* cluster header */
@@ -1476,9 +1482,12 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	}
 
 	for (i = 0; i < cic->nr_rpages; i++) {
+		struct folio *rfolio;
+
 		WARN_ON(!cic->rpages[i]);
-		clear_page_private_gcing(cic->rpages[i]);
-		end_page_writeback(cic->rpages[i]);
+		rfolio = page_folio(cic->rpages[i]);
+		folio_clear_f2fs_gcing(rfolio);
+		folio_end_writeback(rfolio);
 	}
 
 	page_array_free(sbi, cic->rpages, cic->nr_rpages);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 21f396ebe22ca..ca8232a9095f8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2923,7 +2923,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 
 	if (fio) {
-		if (page_private_gcing(fio->page))
+		if (folio_test_f2fs_gcing(fio->folio))
 			return true;
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
 			f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2f7ab5888b078..85937de3d7016 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1357,10 +1357,7 @@ struct f2fs_io_info {
 	blk_opf_t op_flags;	/* req_flag_bits */
 	block_t new_blkaddr;	/* new block address to be written */
 	block_t old_blkaddr;	/* old block address before Cow */
-	union {
-		struct page *page;	/* page to be written */
-		struct folio *folio;
-	};
+	struct folio *folio;	/* folio to be written */
 	struct page *encrypted_page;	/* encrypted page */
 	struct page *compressed_page;	/* compressed page */
 	struct list_head list;		/* serialize IOs */
@@ -1613,27 +1610,27 @@ static inline void f2fs_set_bit(unsigned int nr, char *addr);
 static inline void f2fs_clear_bit(unsigned int nr, char *addr);
 
 /*
- * Layout of f2fs page.private:
+ * Layout of f2fs folio->private:
  *
  * Layout A: lowest bit should be 1
  * | bit0 = 1 | bit1 | bit2 | ... | bit MAX | private data .... |
- * bit 0	PAGE_PRIVATE_NOT_POINTER
- * bit 1	PAGE_PRIVATE_ONGOING_MIGRATION
- * bit 2	PAGE_PRIVATE_INLINE_INODE
- * bit 3	PAGE_PRIVATE_REF_RESOURCE
- * bit 4	PAGE_PRIVATE_ATOMIC_WRITE
+ * bit 0	F2FS_FOLIO_PRIVATE_NOT_POINTER
+ * bit 1	F2FS_FOLIO_PRIVATE_ONGOING_MIGRATION
+ * bit 2	F2FS_FOLIO_PRIVATE_INLINE_INODE
+ * bit 3	F2FS_FOLIO_PRIVATE_REF_RESOURCE
+ * bit 4	F2FS_FOLIO_PRIVATE_ATOMIC_WRITE
  * bit 5-	f2fs private data
  *
  * Layout B: lowest bit should be 0
- * page.private is a wrapped pointer.
+ * folio->private is a wrapped pointer.
  */
 enum {
-	PAGE_PRIVATE_NOT_POINTER,		/* private contains non-pointer data */
-	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
-	PAGE_PRIVATE_INLINE_INODE,		/* inode page contains inline data */
-	PAGE_PRIVATE_REF_RESOURCE,		/* dirty page has referenced resources */
-	PAGE_PRIVATE_ATOMIC_WRITE,		/* data page from atomic write path */
-	PAGE_PRIVATE_MAX
+	F2FS_FOLIO_PRIVATE_NOT_POINTER,		/* private contains non-pointer data */
+	F2FS_FOLIO_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
+	F2FS_FOLIO_PRIVATE_INLINE_INODE,		/* inode page contains inline data */
+	F2FS_FOLIO_PRIVATE_REF_RESOURCE,		/* dirty page has referenced resources */
+	F2FS_FOLIO_PRIVATE_ATOMIC_WRITE,		/* data page from atomic write path */
+	F2FS_FOLIO_PRIVATE_MAX
 };
 
 /* For compression */
@@ -2681,86 +2678,68 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	return -ENOSPC;
 }
 
-#define PAGE_PRIVATE_GET_FUNC(name, flagname) \
+#define F2FS_FOLIO_PRIVATE_GET_FUNC(name, flagname) \
 static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
 {									\
 	unsigned long priv = (unsigned long)folio->private;		\
-	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
-			     (1UL << PAGE_PRIVATE_##flagname);		\
+	unsigned long v = (1UL << F2FS_FOLIO_PRIVATE_NOT_POINTER) |	\
+			     (1UL << F2FS_FOLIO_PRIVATE_##flagname);	\
 	return (priv & v) == v;						\
-}									\
-static inline bool page_private_##name(struct page *page) \
-{ \
-	return page_private(page) && \
-		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
-		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
 
-#define PAGE_PRIVATE_SET_FUNC(name, flagname) \
+#define F2FS_FOLIO_PRIVATE_SET_FUNC(name, flagname) \
 static inline void folio_set_f2fs_##name(struct folio *folio)		\
 {									\
-	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
-			     (1UL << PAGE_PRIVATE_##flagname);		\
+	unsigned long v = (1UL << F2FS_FOLIO_PRIVATE_NOT_POINTER) |	\
+			     (1UL << F2FS_FOLIO_PRIVATE_##flagname);	\
 	if (!folio->private)						\
 		folio_attach_private(folio, (void *)v);			\
 	else {								\
 		v |= (unsigned long)folio->private;			\
 		folio->private = (void *)v;				\
 	}								\
-}									\
-static inline void set_page_private_##name(struct page *page) \
-{ \
-	if (!page_private(page)) \
-		attach_page_private(page, \
-				(void *)BIT(PAGE_PRIVATE_NOT_POINTER)); \
-	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
 
-#define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
+#define F2FS_FOLIO_PRIVATE_CLEAR_FUNC(name, flagname) \
 static inline void folio_clear_f2fs_##name(struct folio *folio)		\
 {									\
 	unsigned long v = (unsigned long)folio->private;		\
 									\
-	v &= ~(1UL << PAGE_PRIVATE_##flagname);				\
-	if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))			\
+	v &= ~(1UL << F2FS_FOLIO_PRIVATE_##flagname);			\
+	if (v == (1UL << F2FS_FOLIO_PRIVATE_NOT_POINTER))		\
 		folio_detach_private(folio);				\
 	else								\
 		folio->private = (void *)v;				\
-}									\
-static inline void clear_page_private_##name(struct page *page) \
-{ \
-	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
-		detach_page_private(page); \
 }
 
-PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
-PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
-PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
-PAGE_PRIVATE_GET_FUNC(atomic, ATOMIC_WRITE);
+F2FS_FOLIO_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
+F2FS_FOLIO_PRIVATE_GET_FUNC(inline, INLINE_INODE);
+F2FS_FOLIO_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
+F2FS_FOLIO_PRIVATE_GET_FUNC(atomic, ATOMIC_WRITE);
 
-PAGE_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
-PAGE_PRIVATE_SET_FUNC(inline, INLINE_INODE);
-PAGE_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
-PAGE_PRIVATE_SET_FUNC(atomic, ATOMIC_WRITE);
+F2FS_FOLIO_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
+F2FS_FOLIO_PRIVATE_SET_FUNC(inline, INLINE_INODE);
+F2FS_FOLIO_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
+F2FS_FOLIO_PRIVATE_SET_FUNC(atomic, ATOMIC_WRITE);
 
-PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
-PAGE_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
-PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
-PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
+F2FS_FOLIO_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
+F2FS_FOLIO_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
+F2FS_FOLIO_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
+F2FS_FOLIO_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 
 static inline unsigned long folio_get_f2fs_data(struct folio *folio)
 {
 	unsigned long data = (unsigned long)folio->private;
 
-	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
+	if (!test_bit(F2FS_FOLIO_PRIVATE_NOT_POINTER, &data))
 		return 0;
-	return data >> PAGE_PRIVATE_MAX;
+	return data >> F2FS_FOLIO_PRIVATE_MAX;
 }
 
 static inline void folio_set_f2fs_data(struct folio *folio, unsigned long data)
 {
-	data = (1UL << PAGE_PRIVATE_NOT_POINTER) | (data << PAGE_PRIVATE_MAX);
+	data = (1UL << F2FS_FOLIO_PRIVATE_NOT_POINTER) |
+	       (data << F2FS_FOLIO_PRIVATE_MAX);
 
 	if (!folio_test_private(folio))
 		folio_attach_private(folio, (void *)data);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 63b712d3d599e..8c156e1fd37d0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3803,7 +3803,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
 			return CURSEG_COLD_DATA_PINNED;
 
-		if (page_private_gcing(fio->page)) {
+		if (folio_test_f2fs_gcing(fio->folio)) {
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
 				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
