Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B736C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f7eCm1GvEnhS5zp3/2jySUsjD5c7uGWTTibWJwyqGAk=; b=LyDmjOOAU/1GuLGMcjPer0Viex
	YNX1f5EEjcfzBL6IIn6ijUqB1hXNtfe57VeaeYRi+Mntp4kyt/474vI3l9985kE5vyBn5Zo7+PLuP
	mOHQgYgUV/jaS2dpBgkFz3mrg900+7TQ/TJJp5DC8ryWH75iG3eAVUqbG3tZSLQVCEtc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x17tI-0002vt-6P;
	Mon, 31 Aug 2026 19:42:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ziy@nvidia.com>) id 1x17tG-0002vm-9o
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 19:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Cc:To:Content-Transfer-Encoding:
 Content-Type:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1M7t11bVlX5NiEt6HPea3pXuobyxilLjoOBo2kqy1z0=; b=Dq2yf84kVMWF2SrcZGO1WlQm1R
 HTgwSb3hBgapGn+CLkFfgPvU3zhe6nhkHgTuuEeNv6appo9GPRH35+Gpmy3j9RZ0NfX2i55weqMVa
 9v9A297T0G0+WDF+ta0De9zkAtA94eFpYQStKkEpF/dJddCezyfJwlryeYpyCbqCCdy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Cc:To:Content-Transfer-Encoding:Content-Type:Message-Id:Date
 :Subject:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1M7t11bVlX5NiEt6HPea3pXuobyxilLjoOBo2kqy1z0=; b=U
 Amts/qF+eStumScONhHCHYIBcuItxtWSknDZwX1i3URfGyEJYM7zT+i6Y8R9Ibo8SAmOO7TxT26JV
 FM6qPF67JAWG4ta16goDKo8Do2WyBp59JZqsIdT7vZdyQpEuGxq8kOAcX+O/PLy9acHXcyWZzezxz
 FZ3y0IrPKkDCOsUM=;
Received: from mail-northcentralusazon11012059.outbound.protection.outlook.com
 ([40.107.200.59] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x17tF-0005tc-6O for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 19:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Izag6lOTbk0TC+BKQj5TpYJeX6iV3e5A2yIbAJ+p/egYWEdYGNXsZwZrUvqggEh2hwiX9diiOfbBd884vFz8J5CvP1j4oCa1ae3C5NDjMO0tF/m36mJRIfTOhk2gjkwB9uvEVPFCyMSFCAK7nNA0AyiaulPQoKL1/zgJmjxPrz3dj/wSANoxAIvO9vxRgQGVsywRSH2eVr9aKXS1BNa6vyix0ixu38gweI9ioRfdA5/1H/LmFUTAVwCWW7QAHaf2YsBRvcIgz1Tj/xCniHi3OCjUgLIHcK53JTA3jmRTz5ua3XHTjGNQcsizM65kWx3BLjV3ZhjPpeHX9YL61Nl/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M7t11bVlX5NiEt6HPea3pXuobyxilLjoOBo2kqy1z0=;
 b=ukjJ2fN7T+DluBFHtGO5rHNfOeojWk/xaeHJTLQxVg6RuVo3Y9ZRDrOTQEwLX7nlCmC7ekRG9fn8MGBinHFPbdVHlKoaBgZ5tPFXal7tC0PDSGvyjfEnDuxP55Pp6Fzh9/3pxC5BiESPjggBE3YKBn4XU9fjLu7153NHT1/zWofcKJYvVSJMgpAG2rvl+nNxCY3KxDjQZwXgHYz9ENO2mwxQAeUU6kDtc3GwX2iCb8PAodBhPoKJNN/I8uclDYkudIPUf1jGsGsMMH0NztbwVjmqW7SOuLfn9xrysIZcynND+y2Ol7mMtpUpuJvpDOk9xs9jMcKzuFyjOp1rlgLWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M7t11bVlX5NiEt6HPea3pXuobyxilLjoOBo2kqy1z0=;
 b=d+UgtiZGPj2sblyxOpIcXM7SJktNxDWdOozEjOnkAkye8n7UtMZyN/jOyZM/AeG99DHQ4GIRrAOAz+xOclj925+H0fjxv7k+I4CHW+/6RDwp8cc9deRQ9umdQEpBWBAKZRb0qk5XzOOZEnYW+84/lMlvZMlv5dgUq/3NfITDXJ3lOu/FuUYdp8hHEd+Ho9xG3EfRNRS66dum9BPwBejbuzcQ9NntBMBp6rBCIL8QstpH4GgNV0xiFn1+1cQS1PJvy945hxKSRjuO++Gjoq1uxKWk+ukM84JUWEn7AMWAQJKHcpJ1sm+TLDibqURugxJsSBonc5u71dd8jqTi6fGyBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Mon, 31 Aug
 2026 19:25:38 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 19:25:38 +0000
Date: Mon, 31 Aug 2026 15:25:23 -0400
Message-Id: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4XM2ho6aHms/A9DTC0DzALatKTRk
 P67lbh0eU5yz90hkGcK0BU7eIoc2K4Z8FSAmfU6keAhM2CJqqyxEZ4WG0m46eE8R72RMCO1qEw
 9NpWBvHOeRn4dzXufeeawWf8+LqL82l+tkn9qUYpSyAuatn7q6qrwtkYeWJ+NXaBPKX0AdZkNU
 bMAAAA=
X-Change-ID: 20260728-remove-pg_private-cfe926c7f83c
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
X-Mailer: b4 0.15.2
X-ClientProxiedBy: YQBP288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::27) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 41106e9b-83b1-4289-148e-08df0795a348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|10067099003|5023799004|11063799006|18002099003|3023799007|6133799003|921020;
X-Microsoft-Antispam-Message-Info: htBZZ7Vb0eSvRuQ6i6qCoafiHji3CmdV5q+gWWn3j5SvAJqLVVvyzr7grLrG1sgQn/Bm4NsXVwcpqWuNsYuZSEmYz8wBonsejxrvXRxhgaBiU380txw+dm6fJ6scn8Ya5yOfX5tfwcX9KopytlqfBOVOlbskj1efRgAVY9t1aK/8/nw6ga3RzmTgvdBEjdffhLOJvQOGImpxzMeWnrDjOC+WSQuEU6YwXNa9m23T4iaqk18laKGiTbLXNcUTS1jfWtB8bGkVFvyw5VIosMU3c2N4zUw/PwfzO7DMFK7ym/E4g3JG4N8DxBkkW4K0CAHy0LvCrG1RghbJxVDMCa9CLvk9zpCJzIRoiWtOkjt2S3uDAozEea+p7+YXq133RvaHZXq9ZMqk4Q9a/jdEut7x6VZDz9zgTyAyRitZmmtfUj0IPo6RUIiKKlmxY6brx0yRsJ8IMtBqpWK8XvAspquCK2YpzVcpkZIaKEcN+Dj9CtlKJMrDzf77KLesP4zpGJFJduRBQ9FrOcNHvGGTueB8NPWC59MUIDc4uw6mf1Naa35YScoP/TB6m2jf9NWxq3Zda9+uJ5qXI5Zo0LHl2g/bxA0UtkZAukAQyxh45SaiUn5UjQmZNvVfap3X0UiXa1gKZ40QqNL3VyFBltaZFJCSE92FJQpdbh/p/ybZaVlN5lWMdMWl0n+CCs7YuBljKU8TU5Tgt8PFmUsLS1V5HC7m/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(3023799007)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldNM29LWVhMQWN4WGlpSkJRWkxtZFRZNlFYRFNPMERWbkZyb211NWZRR25K?=
 =?utf-8?B?N2ZrOElmcTcxdXZybjBwLy84WUlRUlh0QjZDdGgzM0JqdEp2YXEyNTJZWUpI?=
 =?utf-8?B?cC80TEo3SzNNcDYwMitaNTdvQUgyck9UUlJkVUhtTVdhRDVjYUNINnRlOWVu?=
 =?utf-8?B?amxwRlN0UC9DTHdaMzlKYWtzVEpucU5zWjgrcUl2VkxjTVZDUUlUUGpub0Jj?=
 =?utf-8?B?RTFDR3VDdXN5T1llNGJMK01xVnNNYTgvTUlBL1VvMklwcFMwVERpTjBhcWll?=
 =?utf-8?B?UENNOUxuYlVIWVhkckhtS3pVQ3dqUnhBVUlIUjc0UmZxZnJkZnJBdWwvWm1E?=
 =?utf-8?B?ZjZrbjIrY21zSTYzYVVlY0d4M3BJb1lxa1ZmWTJBbUZRbUNlNFFuZGdrdDhu?=
 =?utf-8?B?bHlxNG85MnhvZVlVQjM3WlJhMWt1VXprV21jek1sVUdxR3RFTG1iWFNSYkxZ?=
 =?utf-8?B?TjR3eEhqQ3k1bnFubGs1eEZaOHM4WmRKamtPa24xZTFnbFZzQjFiQTBFUmwr?=
 =?utf-8?B?RnRKRkNWT00vRjUvTVBWVVBSRW0xTHQvLzI0T3VLR0VLRGpjR2RCOGYwclUz?=
 =?utf-8?B?dmFNaXlUVElXaWV3QXoxODh1OFFtMmcyM2dHMlU5ZDNCeVZMSFFCaXJzQStm?=
 =?utf-8?B?SFVtZ2c5enlDM3pVMmhEMTBweGFkTDFqZlRQN2tXSWhJZnRpODBzVW5BdW5D?=
 =?utf-8?B?L25CVWdDWG9JaTI0cXR1V2pqSnhRQ09vUTgrakk5OUhpclZra0VSZ2dOTmk2?=
 =?utf-8?B?L25XWEp4b1JPTUxGV0JUQ2ZpM21OOFlJMGZDMmJvQ2FxRUZBRTI5RjBrTGth?=
 =?utf-8?B?VVlOQktYenJ2emJFM2llazU1SUlIRkdEWG9QNldTQW1QWTFpT0tIYkpSdk1a?=
 =?utf-8?B?VzRQb1hYZys3R0lEaHA5Rkp4UEdkbzB3N3JYbElURGpZZWZ3MGttRVFLLzc4?=
 =?utf-8?B?amhBc3gvd21nK0dXb0FUQ2ZENkNKZHh3bFZiR0VBcGdiMTJIcHNkZ21nVHdl?=
 =?utf-8?B?bmZRY3Y1MWhlS2FEUU5UV0JKYmZiT0NWano5dFUyWFJpN0w1aWZENTVvSVNo?=
 =?utf-8?B?dHVHQjIzMmZRN0FDRXJqbGRHTkZEdXRHc3dxNUN0bXpSVVpOeXVJZmNyT3RM?=
 =?utf-8?B?cTA3SGNsdUFoc2QrMWxSNkZJNnFGQjkvQ3pYSDZJQ3NNQnJqRjlBY1pZUFJn?=
 =?utf-8?B?R0VpdndVbFlCa05SNG0rckgyZ0NiZ1dhMlIrSlpmcHBPQXNQMm1USitlaU4y?=
 =?utf-8?B?U0p1WC80UHU4VzJrZDZ5SnhGUm9URUFPajd2MlVWdkRiQTRrN05Jb0xHU1E3?=
 =?utf-8?B?cjBxZTFhWWtVamJHdzBua0Y0Q0JQOTBJYnN5eDJtdnl5YUtEUGc4MUdvWTdu?=
 =?utf-8?B?ZVRtclY2dFZaaFBtSy83aFN5QWdLNXlycUpTNisyNkE1YmZCOFRQQzA1bDdx?=
 =?utf-8?B?SkZDcm5zcEgyWHlYVEQvODliYXN6VTVrcDRTTGJOUVF0VmVRZStDV1dCT2Uw?=
 =?utf-8?B?UVVvYSsxMkpBMkpYeHBJSlM3TWZIeHZqM25LaWJMTG5yaFAxSHFNMlExSlpW?=
 =?utf-8?B?SU01YUk5TlZ6Zm9IZURRelFLNkMxaEZZRGJSa2ZaSTBoNXNRWU52bFd3NzJk?=
 =?utf-8?B?V091Q1RjdWVCMnRmRnh6RGZObmZ1WVhDNWdlUWRzSlBJR3Q2QVo1Szc4L2dB?=
 =?utf-8?B?WFhuN1ZBZjhwOFdFZG85bFNjRDQyYWtsQ1ZsZzZCNXBNU2Y2R21taUZTTlFj?=
 =?utf-8?B?emJPTnBNYUxicGw5cnNwVmlTYzJSMGZIeWh3dG9kcDdYWUJYZFQ4bm5ObG94?=
 =?utf-8?B?VTJCN1cvYy9rZEZDS2xIZjROMnpSMVB1VmVVRDEybEkxU1QveWE5bW5VVnls?=
 =?utf-8?B?RVd0N3VOdmlZb3lTYnpUb3lwckZMbHY1RFJCa05MY05PT090YTErME9BT0Zh?=
 =?utf-8?B?bHpIbTVNb2ZFaU1BQnQyQ1ZtamxuSE1YSFRza2FtaTU4UFN5Q1RDVXY2Y2NS?=
 =?utf-8?B?WmRlQThFNFZ6S043cWpuaWNVQUsyUU5lNGtDYVQzWGhraytqT2ZHakVQc1NE?=
 =?utf-8?B?VU9weW1ONjNrWVVZc2xBSVZKNG85ekg5eE9HQURBaVBxUDNvVUdENDdiR0xI?=
 =?utf-8?B?S1NrcytDZmNEMldBbVRXNnJNMnlEenM4Qml1ZVdJb1k4VXJkMmdHWW9WRFUw?=
 =?utf-8?B?SFNNWXM4UkpXSHl0ZzRXTnRHUThUeHhITmdDTG5la21FVmU1MzhtODAzWkI2?=
 =?utf-8?B?QzZvMkNjNlpVaEp5b0xIaGRuUFl6N3lHYmkxNjBkeUpCNVJoRzRWZUFvcWJI?=
 =?utf-8?Q?QUyE3mqIbnBvqUtxPa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41106e9b-83b1-4289-148e-08df0795a348
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:25:38.2564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n843s1whvSfgneW2wvMilxUPWuaDS8ZfBLBStLsy0PfIZUOOEULUw1e08PmJRM8m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
X-Headers-End: 1x17tF-0005tc-6O
Subject: [f2fs-dev] [PATCH v2 00/14] Remove PG_private by using
 page/folio->private checks instead
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>,
 Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org,
 Alex Markuze <amarkuze@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kexec@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Dave Young <ruirui.yang@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mm@kvack.org, Hongbo Li <hongbohbli@tencent.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Chunhai Guo <guochunhai@vivo.com>,
 Shuah Khan <skhan@linuxfoundation.org>, ceph-devel@vger.kernel.org,
 Baoquan He <baoquan.he@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 Anna Schumaker <anna@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Minchan Kim <minchan@kernel.org>, Richard Weinberger <richard@nod.at>,
 x86@kernel.org, Eric Biggers <ebiggers@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
 Wei Xu <weixugc@google.com>, Zi Yan <ziy@nvidia.com>, Yu Kuai <yukuai@fygo.io>,
 xen-devel@lists.xenproject.org, Gao Xiang <xiang@kernel.org>,
 Li Nan <magiclinan@didiglobal.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Xiao Ni <xiao@kernel.org>,
 Byungchul Park <byungchul@sk.com>, James Clark <james.clark@linaro.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-raid@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Steven Rostedt <rostedt@goodmis.org>, linux-mtd@lists.infradead.org,
 Axel Rasmussen <axelrasmussen@google.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Namhyung Kim <namhyung@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Yuanchu Xie <yuanchu@google.com>,
 Ilya Dryomov <idryomov@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Juergen Gross <jgross@suse.com>, Pratyush Yadav <pratyush@kernel.org>,
 linux-nfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Song Liu <song@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-perf-users@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgYWxsLAoKVGhpcyBwYXRjaHNldCByZW1vdmVzIFBHX3ByaXZhdGUgdG8gbWFrZSBzcGFjZSBm
b3IgdXBjb21pbmcgUEdfZm9saW8KKHJlc2VydmVkIGFzIF9fUEdfZm9saW8pIGZvciBpZGVudGlm
eWluZyBwYWdlcyBmcm9tIGEgZm9saW8gKG1vcmUgZGV0YWlscwppbiBOb3RlIGJlbG93KS4gSW5z
dGVhZCBvZiBjaGVja2luZyBQR19wcml2YXRlLCBhbGwgY29kZSBpcyBjaGFuZ2VkIHRvCmNoZWNr
IHBhZ2UvZm9saW8tPnByaXZhdGUgIT0gTlVMTCBpbnN0ZWFkLgoKTU0gcGVvcGxlIGFyZSBjYydk
IG9uIGFsbCBwYXRjaGVzIGFuZCBzdWJzeXN0ZW0gcGVvcGxlIGFyZSBjYydkIG9uIHRoZQpjb3Zl
ciBsZXR0ZXIgYW5kIGNvcnJlc3BvbmRpbmcgcGF0Y2hlcy4KCk92ZXJ2aWV3Cj09PQpNb3N0IGNv
ZGUgdXNlcyBmb2xpb19hdHRhY2gvZGV0YWNoL2NoYW5nZV9wcml2YXRlKCkgZnVuY3Rpb25zLCBz
byBmb2xpbwpyZWZjb3VudCBpcyBpbmNyZWFzZWQgYW5kIGRlY3JlYXNlZCB3aGVuIGZvbGlvLT5w
cml2YXRlIGlzIHNldCBhbmQgcmVzZXQsCnJlc3BlY3RpdmVseS4gVGhlcmUgaXMgbm8gbmVlZCB0
byBjaGFuZ2UgdGhlbS4KCkNoYW5nZXMgYXJlIG5lZWRlZCBmb3IgZXhjZXB0aW9uYWwgdXNlcnM6
CjEuIHpzbWFsbG9jIHVzZXMgUEdfcHJpdmF0ZSB0byBpbmRpY2F0ZSBmaXJzdCBjb21wb25lbnQg
enBkZXNjIHBhZ2UgYW5kCiAgIHBhZ2UtPnByaXZhdGUgaXMgdXNlZCB0byBzdG9yZSB6c3BhZ2Ug
aW4genBkZXNjLiBUbyByZW1vdmUgUEdfcHJpdmF0ZSwKICAgaXNfZmlyc3RfenBkZXNjKCkgaXMg
cmVwbGFjZWQgYnkgcG9pbnRlciBjb21wYXJpc29uLgoKMi4ga2VybmVsL2V2ZW50cy9yaW5nX2J1
ZmZlci5jIHN0b3JlcyBwYWdlIG9yZGVyIGluIHBhZ2UtPnByaXZhdGUuCiAgIFJlcGxhY2luZyBQ
R19wcml2YXRlIHdpdGggcGFnZS0+cHJpdmF0ZSAhPSBOVUxMIHdvcmtzLgoKMy4gZHJpdmVycy94
ZW4vZ3JhbnQtdGFibGUuYyBzdG9yZXMgeGVuX3BhZ2VfZm9yZWlnbiBpbiBwYWdlLT5wcml2YXRl
LAogICB3aGVyZSBvbiAzMi1iaXQsIGEgcG9pbnRlciB0byB4ZW5fcGFnZV9mb3JlaWduIGlzIHN0
b3JlZDsgb24gNjQtYml0LAogICBwYWdlLT5wcml2YXRlIGlzIHVzZWQgYXMgeGVuX3BhZ2VfZm9y
ZWlnbi4gUEdfcHJpdmF0ZSBjaGVjayBpcyByZXBsYWNlZAogICBieSBwYWdlLT5wcml2YXRlICE9
IE5VTEwgb24gMzItYml0IGZvciB4ZW5fcGFnZV9mb3JlaWduIGRlYWxsb2NhdGlvbi4KICAgT24g
NjQtYml0LCBwYWdlLT5wcml2YXRlIGlzIGNsZWFyZWQgdW5jb25kaXRpb25hbGx5IHNpbmNlIHtk
b21pZD0wLAogICBncmVmPTB9ICh4ZW5fcGFnZV9mb3JlaWduIGNhbiBiZSAwKSBpcyB2YWxpZC4K
CjQuIGZzL2NyeXB0by9jcnlwdG8uYyBzdG9yZXMgYSBmb2xpbyBwb2ludGVyIGluIHBhZ2UtPnBy
aXZhdGUsIFBHX3ByaXZhdGUKICAgY2hlY2tzIGFyZSByZXBsYWNlZCBieSBwYWdlLT5wcml2YXRl
ICE9IE5VTEwuCgo1LiBmcy9lcm9mcyBoYXMgdHdvIGRpZmZlcmVudCB1c2VzOgoKICAgIDVhLiBm
b2xpby0+cHJpdmF0ZSBpcyB1c2VkIHRvIGZvcm0gYSByZXZlcnNlZCBsaXN0IG9mCiAgICB0aGUg
b3V0cHV0cyBvZiByZWFkYWhlYWRfZm9saW8oKS4gcmVhZGFoZWFkX2ZvbGlvX2xhc3QoKSBpcyBh
ZGRlZCB0bwogICAgb3V0cHV0IGZvbGlvcyBpbiByZXZlcnNlZCBvcmRlciwgc28gdGhhdCAtPnBy
aXZhdGUgaXMgbm8gbG9uZ2VyIG5lZWRlZC4KCiAgICA1Yi4gZm9saW8tPnByaXZhdGUgaXMgdXNl
ZCBhcyBhbiBpbi1mbGlnaHQgSS9PIGNvdW50ZXIuIENvbnZlcnQgdGhlCiAgICBjb2RlIHRvIHVz
ZSBmb2xpb19hdHRhY2gvZGV0YWNoL2dldF9wcml2YXRlKCkgYW5kIGFkZCBiaWFzPT0xIHRvIHRo
ZQogICAgY291bnRlciB0byBhdm9pZCBmb2xpby0+cHJpdmF0ZSBiZWluZyB6ZXJvLgoKNi4gZnMv
bmZzL3dyaXRlLmM6IGZvbGlvIHJlZmNvdW50IG1haW50ZW5hbmNlIGlzIGluIGEgYmlnZ2VyIHNj
b3BlIHRoYW4KICAgZm9saW8tPnByaXZhdGUuIFNvIGZvbGlvX2F0dGFjaC9kZXRhY2gvZ2V0X3By
aXZhdGUoKSBpcyBub3QgdXNlZC4KICAgTm90aGluZyB0byBjaGFuZ2UuCgo3LiBmcy9mMmZzIHVz
ZXMgYXR0YWNoX3BhZ2VfcHJpdmF0ZSgpIHRvIGZpcnN0IHJlc2V0IGZvbGlvLT5wcml2YXRlIHRo
ZW4KICAgaW1tZWRpYXRlbHkgc2V0cyBQQUdFX1BSSVZBVEVfTk9UX1BPSU5URVIgYml0IG9uIGl0
LiBDaGFuZ2UgaXQgdG8gdXNlCiAgIGF0dGFjaF9wYWdlX3ByaXZhdGUoKSB0byBzZXQgUEFHRV9Q
UklWQVRFX05PVF9QT0lOVEVSIGJpdCBkaXJlY3RseSB0bwogICBhdm9pZCBmb2xpby0+cHJpdmF0
ZSA9PSBOVUxMIGdhcCBpbnNpZGUgc2V0X3BhZ2VfcHJpdmF0ZV8jI25hbWUoKS4KCjguIGh1Z2V0
bGIgdXNlcyBmb2xpb19jaGFuZ2VfcHJpdmF0ZShmb2xpbywgTlVMTCkgd2l0aG91dCBmb2xpbyBy
ZWZjb3VudAogICBtYWludGVuYW5jZS4gQ2hhbmdlIGl0IHRvIGZvbGlvLT5wcml2YXRlID0gTlVM
TC4KCkFmdGVyIHRoZSBhYm92ZSBjaGFuZ2VzLCBQR19wcml2YXRlIG9wcyBhcmUgY29udmVydGVk
IHRvCnBhZ2UvZm9saW8tPnByaXZhdGUgb3BzLgoKZm9saW9fdGVzdF9mc19wcml2YXRlKCkgaXMg
YWRkZWQgdG8gY2hlY2sgZmlsZXN5c3RlbS1vbmx5IHByaXZhdGUgZGF0YSBieQpleGNsdWRpbmcg
c3dhcGNhY2hlIGFuZCBodWdldGxiIGZvbGlvcywgYmVjYXVzZSBzd2FwY2FjaGUgZm9saW9zIG92
ZXJsYXAKc3dwX2VudHJ5X3Qgc3dhcCB3aXRoIC0+cHJpdmF0ZSBhbmQgaHVnZXRsYiBzZXRzIGl0
cyBvd24gZmxhZ3MgaW4KLT5wcml2YXRlLgoKTm90ZQo9PT0KMS4gS1BGX1BSSVZBVEUgaXMgcmVt
b3ZlZCBhZnRlciBQR19wcml2YXRlIGlzIHJlbW92ZWQuCgoyLiBEb2N1bWVudGF0aW9uL21tL2h1
Z2V0bGJmc19yZXNlcnYucnN0IGlzIG91dGRhdGVkLCBzbyBJIGRpZCBub3QgcmVtb3ZlCiAgIFBH
X3ByaXZhdGUgcmVsYXRlZCB0ZXh0LiBJdCBzaG91bGQgYmUgcmV3cml0dGVuLgoKMy4gUEdfZm9s
aW8gaXMgcGxhbm5lZCB0byBiZSBzZXQgb24gZXZlcnkgcGFnZSBmcm9tIGEgZm9saW8gaW4KICAg
cGFnZV9ybWFwcGFibGVfZm9saW8oKSwgc28gZm9saW9zIHdpdGggYW55IG9yZGVyIChjdXJyZW50
bHkKICAgUEdfbGFyZ2Vfcm1hcHBhYmxlIGlzIHVzZWQgdG8gaWRlbnRpZnkgPjAgb3JkZXIgZm9s
aW9zKSBjYW4gYmUKICAgaWRlbnRpZmllZCwgdm1faW5zZXJ0XyooKSBjYW4gY29ycmVjdGx5IHJl
amVjdCBhbGwgZm9saW9zLCBhbmQgcm1hcCBjb2RlCiAgIGNhbiBhY2NlcHQgb25seSBmb2xpb3Mu
IEV2ZW50dWFsbHksIHBhZ2VfZm9saW8oKSB3aWxsIHJldHVybiBOVUxMIGZvcgogICBub24tZm9s
aW8gcGFnZXMgYnkgY2hlY2tpbmcgUEdfZm9saW8sIGJ1dCBiZWZvcmUgdGhhdCBhbGwgZXhpc3Rp
bmcgdXNlcnMKICAgdGhhdCB0cmVhdCBjb21wb3VuZCBwYWdlcyBhcyBmb2xpb3Mgd2lsbCBiZSBj
b252ZXJ0ZWQuIAoKVGVzdHMKPT09CjEuIGFsbG1vZGNvbmZpZyBidWlsZCBwYXNzZWQuCgoyLiB6
c21hbGxvYyBpcyB0ZXN0ZWQgdXNpbmcgZXh0NCBvbiBhIDFHQiBsejQgenJhbToKICAgIDJhLiB6
cmFtIGxvYWQgKyB6c21hbGxvYyBjb21wYWN0aW9uOwogICAgMmIuIGNvbmN1cnJlbnQgenNwYWdl
IG1pZ3JhdGlvbiB2aWEgbWVtb3J5IGNvbXBhY3Rpb247CiAgICAyYy4gY29uZmlybWVkIHRoYXQg
bXVsdGktcGFnZSB6c3BhZ2VzIGFjdHVhbGx5IGZvcm1lZC4KCiAgICBEZXRhaWxzOiBodHRwczov
L2dpdGh1Yi5jb20veC15LXovbGludXgtZGV2L2Jsb2IvYjQvcmVtb3ZlLXBnX3ByaXZhdGUvdGVz
dF96c21hbGxvYy5tZAoKMy4gZXJvZnMgaXMgdGVzdGVkIG9uIGltYWdlcyBjcmVhdGVkIHdpdGgg
LUM0MDk2IGFuZCBsejRoYywgbHptYSwKICAgZGVmbGF0ZSwgYW5kIHpzdGQgYWxnb3JpdGhtczoK
ICAgM2EuIGNvbGQgcmVhZCBvZiBhbGwgZmlsZXMsIHZlcmlmeSBjaGVja3N1bXMgbWF0Y2ggc291
cmNlOwogICAzYi4gcmVhZGFoZWFkICsgcmVjbGFpbS9taWdyYXRpb24gcmFjZS4KCiAgIERldGFp
bHM6IGh0dHBzOi8vZ2l0aHViLmNvbS94LXktei9saW51eC1kZXYvYmxvYi9iNC9yZW1vdmUtcGdf
cHJpdmF0ZS90ZXN0X2Vyb2ZzLm1kCgo0LiBmc2NyeXB0IGlzIHRlc3RlZCBvbiBzb2Z0d2FyZS1l
bmNyeXB0ZWQgZXh0NCB3aXRoIHdyaXRlcyB0byBleGVyY2lzZQogICBib3VuY2UgcGFnZXMuCgog
ICBEZXRhaWxzOiBodHRwczovL2dpdGh1Yi5jb20veC15LXovbGludXgtZGV2L2Jsb2IvYjQvcmVt
b3ZlLXBnX3ByaXZhdGUvdGVzdF9mc2NyeXB0Lm1kCgo1LiBmMmZzIGlzIHRlc3RlZCBvbiBhbiBp
bWFnZSB3aXRoIGlubGluZV9kYXRhLGNvbXByZXNzX2FsZ29yaXRobT1sejQ6CiAgICA1YS4gSU5M
SU5FX0lOT0RFIOKAlCBsb3RzIG9mIHRpbnkgZmlsZXM7CiAgICA1Yi4gUkVGX1JFU09VUkNFICsg
Z2VuZXJhbCB3cml0ZWJhY2sg4oCUIGJ1ZmZlcmVkIHdyaXRlIGNodXJuIHdpdGggZnN5bmM7CiAg
ICA1Yy4gT05HT0lOR19NSUdSQVRJT04g4oCUIGZvcmNlIEdDIC8gcGFnZSBtaWdyYXRpb247CiAg
ICA1ZC4gQVRPTUlDX1dSSVRFIOKAlCBhdG9taWMtd3JpdGUgaW9jdGwgcGF0aC4KCiAgICBEZXRh
aWxzOiBodHRwczovL2dpdGh1Yi5jb20veC15LXovbGludXgtZGV2L2Jsb2IvYjQvcmVtb3ZlLXBn
X3ByaXZhdGUvdGVzdF9mMmZzLm1kCiAgICAoSSBkaWQgbm90IHJ1biB4ZnN0ZXN0cykKCjYuIE1N
IHNlbGZ0ZXN0cyBwYXNzZWQuCgpMTE0gdXNlCj09PQpDbGF1ZGUgd2FzIHVzZWQgdG8gZm9ybSBh
IGNvbmNyZXRlIHBsYW4gb24gd2hhdCBjb2RlIG5lZWRzIHRvIGJlIGNoYW5nZWQKYW5kIGhvdyB0
byBjaGFuZ2UgdGhlbS4gVGhlIHBsYW4gd2FzIHJldmlld2VkIGJ5IENvZGV4IHVudGlsIG5vIGlz
c3VlIHdhcwpzcG90dGVkLgoKUGxhbiBpcyBhdDogaHR0cHM6Ly9naXRodWIuY29tL3gteS16L2xp
bnV4LWRldi9ibG9iL2I0L3JlbW92ZS1wZ19wcml2YXRlL3BsYW4ubWQKCkkgdGhlbiBmb2xsb3dl
ZCB0aGUgcGxhbiB0byBtYWtlIGNvZGUgY2hhbmdlcy4gSSBkaWQgYm91bmNlIGlkZWFzIHdpdGgK
Q2xhdWRlIGhvdyB0byBjaGFuZ2UgZnMvZXJvZnMsIHNpbmNlIEkgZGlkIG5vdCBsaWtlIHRoZSBv
cmlnaW5hbCBpZGVhLgpBZnRlciBlYWNoIGNoYW5nZSwgSSBhc2tlZCBDbGF1ZGUgdG8gcmV2aWV3
IG15IGNvZGUgYW5kIGdpdCBjb21taXQgbWVzc2FnZS4KSSBhbHNvIGFza2VkIENsYXVkZSB0byBn
aXZlIG1lIHRlc3QgcGxhbnMgKHNlZSBhYm92ZSkuCgpBdCBsYXN0LCBDb2RleCB3YXMgdXNlZCB0
byByZXZpZXcgYWxsIHBhdGNoZXMuCgpDb21tZW50cyBhbmQgc3VnZ2VzdGlvbnMgYXJlIHdlbGNv
bWUuIFRoYW5rcy4KCkFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9wdXMtNC04CkFzc2lzdGVk
LWJ5OiBDb2RleDpncHQtNQpTaWduZWQtb2ZmLWJ5OiBaaSBZYW4gPHppeUBudmlkaWEuY29tPgot
LS0KQ2hhbmdlcyBpbiB2MjoKMS4gcmVtb3ZlZCBpc19maXJzdF96cGRlc2MoKSBpbiBwYXRjaCAx
IGFuZCBvcGVuIGNvZGVkIHRoZSBjaGVja3MuCjIuIGZpeGVkIHdvcmRpbmcgaW4gcGF0Y2ggMidz
IGNvbW1pdCBtZXNzYWdlIGFuZCBjbGFyaWZpZWQgcGFnZV9wcml2YXRlKCkKICAgYWxzbyB3b3Jr
cyB3aGVuIHJpbmcgYnVmZmVyJ3MgQVVYIHBhZ2Ugb3JkZXIgaXMgMC4KMy4gcmVtb3ZlZCB0aGUg
ZW1wdHkgbG9vcCBpbiA2NC1iaXQgZ250dGFiX3BhZ2VzX3NldF9wcml2YXRlKCkuCjQuIGNsYXJp
ZmllZCBmb2xpby0+cHJpdmF0ZSB3aWxsIGJlIHJlc2V0IHRvIE5VTEwgYnkKICAgZnNjcnlwdF9m
cmVlX2JvdW5jZV9wYWdlKCkgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgo1LiBjbGFyaWZpZWQgd2h5
IGh1Z2V0bGIgbmVlZHMgdG8gcmVzdG9yZSBodWdldGxiX3ZtZW1tYXBfb3B0aW1pemVkLgo2LiBy
ZW5hbWVkIHJlYWRhaGVhZF9mb2xpb19yZXZlcnNlKCkgcmVhZGFoZWFkX2ZvbGlvX2xhc3QoKSBh
bmQKICAgcmVpbXBsZW1lbnRlZCByZWFkYWhlYWRfZm9saW9fbGFzdCgpIGJ5IGFkZGluZyBhIG5l
dyByZWFkYWhlYWRfY29udHJvbAogICBwcml2YXRlIG1lbWJlciwgX2ZvcndhcmQsIGFuZCBhIG5l
dyBoZWxwZXIgX19yZWFkYWhlYWRfYWR2YW5jZSgpLgo3LiBhZGRlZCBhIGJpYXMsIDEsIHRvIGVy
b2ZzIEkvTyBjb3VudGVyLCBzbyB0aGF0IGZvbGlvLT5wcml2YXRlIHN0YXlzIG5vbgogICBOVUxM
IGJldHdlZW4gZm9saW9fYXR0YWNoX3ByaXZhdGUoKSBhbmQgZm9saW9fZGV0YWNoX3ByaXZhdGUo
KS4KOC4gY29udmVydGVkIG1vcmUgY2FsbCBzaXRlcyB0byB1c2UgZm9saW9fdGVzdF9mc19wcml2
YXRlKCkuCi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDczMS1y
ZW1vdmUtcGdfcHJpdmF0ZS12MS0wLTE0MmM5N2JhMzU2MkBudmlkaWEuY29tCgotLS0KWmkgWWFu
ICgxNCk6CiAgICAgIG1tL3pzbWFsbG9jOiByZXBsYWNlIFBHX3ByaXZhdGUgd2l0aCBwb2ludGVy
IGNvbXBhcmlzb24KICAgICAgcGVyZi9yaW5nX2J1ZmZlcjogc3RvcCB1c2luZyBQR19wcml2YXRl
IGFzIEFVWCBwYWdlIGhpZ2gtb3JkZXIgbWFya2VyCiAgICAgIHhlbi9ncmFudC10YWJsZTogc3Rv
cCBzZXR0aW5nIFBHX3ByaXZhdGUgb24gcGFnZXMgZm9yIGdyYW50IG1hcHBpbmcKICAgICAgZnNj
cnlwdDogc3RvcCBzZXR0aW5nIFBHX3ByaXZhdGUgb24gYm91bmNlIHBhZ2UKICAgICAgbW0vaHVn
ZXRsYjogdXNlIGRpcmVjdCBhc3NpZ25tZW50IGluc3RlYWQgb2YgZm9saW9fY2hhbmdlX3ByaXZh
dGUoKQogICAgICBmMmZzOiBzdG9wIHVzaW5nIFBHX3ByaXZhdGUKICAgICAgZXJvZnM6IG1tL3Bh
Z2VtYXA6IGFkZCByZWFkYWhlYWRfZm9saW9fbGFzdCgpIHRvIGF2b2lkIGZvbGlvLT5wcml2YXRl
CiAgICAgIGVyb2ZzOiB1c2UgZm9saW9fYXR0YWNoL2RldGFjaF9wcml2YXRlKCkgaW5zdGVhZCBv
ZiBkaXJlY3QgYXNzaWdubWVudAogICAgICBtbS9wYWdlLWZsYWdzOiBjaGVjayBwYWdlL2ZvbGlv
LT5wcml2YXRlIGluc3RlYWQgb2YgUEdfcHJpdmF0ZQogICAgICBtbS9wYWdlLWZsYWdzOiBpbnRy
b2R1Y2UgZm9saW9fdGVzdF9mc19wcml2YXRlKCkKICAgICAgdHJlZXdpZGU6IHJlbW92ZSBmb2xp
b19zZXQvY2xlYXJfcHJpdmF0ZSgpCiAgICAgIHRyZWV3aWRlOiByZXBsYWNlIFBhZ2VQcml2YXRl
KCkgd2l0aCBwYWdlX3ByaXZhdGUoKQogICAgICB0cmVld2lkZTogYWRqdXN0IGNvbW1lbnRzIG9u
IFBhZ2VQcml2YXRlIGFuZCBQR19wcml2YXRlCiAgICAgIG1tL3BhZ2UtZmxhZ3M6IHJlbW92ZSBQ
R19wcml2YXRlCgogRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVpbmZvLnJz
dCB8ICAyICstCiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Zmcy5yc3QgICAgICAgICAgICAg
IHwgIDYgKy0tCiBhcmNoL3g4Ni9ldmVudHMvaW50ZWwvYnRzLmMgICAgICAgICAgICAgICAgICAg
IHwgIDMgLS0KIGFyY2gveDg2L2V2ZW50cy9pbnRlbC9wdC5jICAgICAgICAgICAgICAgICAgICAg
fCAgNiArLS0KIGRyaXZlcnMvbWQvbWQtYml0bWFwLmMgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNiArLS0KIGRyaXZlcnMveGVuL2JhbGxvb24uYyAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNSArKysKIGRyaXZlcnMveGVuL2dyYW50LXRhYmxlLmMgICAgICAgICAgICAgICAgICAgICAg
fCAxMSArKystLQogZnMvY2VwaC9hZGRyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICA4ICsrLS0KIGZzL2NyeXB0by9jcnlwdG8uYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMiAtCiBmcy9lcm9mcy9kYXRhLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMTYgKysrKy0tLQogZnMvZXJvZnMvemRhdGEuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDEzICsrLS0tLQogZnMvZjJmcy9mMmZzLmggICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICA4ICsrLS0KIGZzL25mcy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgNCArLQogZnMvbmZzL3dyaXRlLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAyIC0KIGZzL3Byb2MvcGFnZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMSAtCiBmcy91Ymlmcy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDggKystLQogaW5jbHVkZS9saW51eC9idWZmZXJfaGVhZC5oICAgICAgICAgICAgICAg
ICAgICB8ICA2IC0tLQogaW5jbHVkZS9saW51eC9rZXJuZWwtcGFnZS1mbGFncy5oICAgICAgICAg
ICAgICB8ICAxIC0KIGluY2x1ZGUvbGludXgvbW0uaCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAzNSArKysrKysrKystLS0tLS0KIGluY2x1ZGUvbGludXgvbW1fdHlwZXMuaCAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNCArLQogaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmggICAgICAg
ICAgICAgICAgICAgICB8IDM4ICsrKysrKysrKysrLS0tLS0KIGluY2x1ZGUvbGludXgvcGFnZW1h
cC5oICAgICAgICAgICAgICAgICAgICAgICAgfCA2MCArKysrKysrKysrKysrKysrKysrKystLS0t
LQogaW5jbHVkZS90cmFjZS9ldmVudHMvbW1mbGFncy5oICAgICAgICAgICAgICAgICB8ICAyICst
CiBpbmNsdWRlL3RyYWNlL2V2ZW50cy9wYWdlbWFwLmggICAgICAgICAgICAgICAgIHwgIDIgKy0K
IGtlcm5lbC9ldmVudHMvcmluZ19idWZmZXIuYyAgICAgICAgICAgICAgICAgICAgfCAgNyArKy0K
IGtlcm5lbC92bWNvcmVfaW5mby5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSAtCiBt
bS9odWdlX21lbW9yeS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KIG1t
L2h1Z2V0bGIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArLS0KIG1t
L21pZ3JhdGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArLQogbW0v
cGFnZS13cml0ZWJhY2suYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCiBtbS92
bXNjYW4uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KIG1tL3pw
ZGVzYy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQogbW0venNt
YWxsb2MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDI0ICsrKy0tLS0tLS0t
CiB0b29scy9tbS9wYWdlLXR5cGVzLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgLQog
MzQgZmlsZXMgY2hhbmdlZCwgMTYzIGluc2VydGlvbnMoKyksIDEzNyBkZWxldGlvbnMoLSkKLS0t
CmJhc2UtY29tbWl0OiA0NDM0NTFjODVjYThkNjM4OWQzNGIxMjk5ZGVjYWRhNjIxMjhmMWZlCmNo
YW5nZS1pZDogMjAyNjA3MjgtcmVtb3ZlLXBnX3ByaXZhdGUtY2ZlOTI2YzdmODNjCgpCZXN0IHJl
Z2FyZHMsCi0tICAKWWFuLCBaaQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
