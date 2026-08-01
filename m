Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0291C54FCD
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  1 Aug 2026 06:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k4gdvQkrzcWWkhPCvFWtXqu3Axh0fZkPYZ7kb+yawcQ=; b=N97vFbsTJHwcMLZPSF/yAxMYOa
	KO+WDeTQKNcQAApsmImu540jDgE4460PpzCHBnA2joOwp+B9nn22AimmwXTbf76Gxow5d+4bMdBMV
	CrdphNUUpsTwev6VpVSbWsjy7jtUpHbaC0SvBSwm6NdlbVeqb7f1mFyW+maNrSfCKa3U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wq3YS-0005Ht-1h;
	Sat, 01 Aug 2026 06:50:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ziy@nvidia.com>) id 1wq3Y8-0005G0-5d
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Aug 2026 06:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Cc:To:Content-Transfer-Encoding:
 Content-Type:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Dj2NYUyQZvuonVfcvoKoW2H3adtSVWranxYgEi8YQU=; b=bdu7UwhZw6JBX1AWvYmQkVmmaj
 IYvxE4Kvfx3c7/vZkPZF6Tox6MJ0e4EV6Gx4t8v5W1+7bPxEQHWMkMLVkVz7ZR2sO/n+vUqfzBTiR
 IEcoywTJ2zVAJ3a9yd8ckXGCbE8va+ytgtY4XFOjMxRYP/D84Q8T76kWY1osEqqT4D4o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Cc:To:Content-Transfer-Encoding:Content-Type:Message-Id:Date
 :Subject:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1Dj2NYUyQZvuonVfcvoKoW2H3adtSVWranxYgEi8YQU=; b=b
 9WFcHA0QxdCpqG12vd9N/Aswq/+FsHY1t7oCOSPTq2LdJc0dfQML5RhA76JWG4XSNgQcgO9e9UopR
 +VV992tP2G1AJoXeHpqby3q6KJ8Qg8u+zhvubBb0s3lxm00FpnVDWH9ErsG/fDOw1SK8tVX32PNEW
 I1YO2QlxM9R3102s=;
Received: from mail-southcentralusazon11012019.outbound.protection.outlook.com
 ([40.93.195.19] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wq3YB-0008Tg-MC for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Aug 2026 06:50:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juOG2d/steEklncNOvTy2HvMCzBRsBGtDaBigF+Zw99wCtxthKH9xaGYT9qWEVMP8Q76Iov7fdZDUGjwHlvM66fNmEIIPjId1D7gZZLIViWJAtaPlxuhcb7/aCtyiXWtwjSDdkuhSj4uxmaU6voqSMzVv+wLCaZdEpm1UniIM6XXr/y08d3cNmlDzA37/s+JyM+lKktnI+pPDcw4LcroYMhMWSlFXabL9JX7qqq2G9GkbyzxNZZdBfDXhiVcwodCDaUwfV4RLlUop1Vjl3p2ixOvETBfmnPpPYyDCHPwUZ6z8D4R4UBbp3gbajUber9EYwmfNycR/9reTyem8JAXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Dj2NYUyQZvuonVfcvoKoW2H3adtSVWranxYgEi8YQU=;
 b=nS22Y21LUCkU9rE1tarBHVVoAOS6WoqXifPtaQIE8OYP/CiU7e1kuVgaMB8YfpBfwoWAzik518UdioQWoZmjgtRvCkiZoV18o6PNnRTVj6ggOgtj6OEdb9s9LF2yhoqyLMGg1EJ5eSVv4eBT1+JcD+3kJZrBt9FU0cKgRk9BBrqrjgM5c0KkO59dyK/lRP96h2SLx1wu57lFNzyM/iAKasNf3twQFbmJao0qMCbFWmBjeHqehUINFK536hvgVac4mYp2NrOIMZcRh5B4mo81JHleaUmUx1urY27cvvzQgM2iZgZQWkKx38i1rxQ8hux3PaeLK5OtUsv35myLt1YIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dj2NYUyQZvuonVfcvoKoW2H3adtSVWranxYgEi8YQU=;
 b=FB5Uzv+jjIOz2Gqd5kNRUmj0oMIAGc13ZaO7PxN87N2Vsm1h2AmI6UBCGxbiU8v7rBmpSk66cpyjk9doS0l2Cwug3L6tWxa7EnpwkUAI8obSHPvyEZtRmsQRP4Ad/qzEarvlDy1s6rnXeWJmaBg7+kXQP80MMmTUTKKx60Kkrzh78dZdHaCQVnN4Ent82GUKgm+hwh7r8TitUV618trGITHpcjPjn9zyBwtkgbG20BWoOZwi5n1SC1ZzVLkEqAMp7SKzKMlAu2o6c8XmMv0HO0zTS1DVdv1s4GB47p2UxxkBgmCmVu6y6Mvahl6HousWTQ32VDFXU9udlm0xGrD9Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 02:16:55 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 02:16:55 +0000
Date: Fri, 31 Jul 2026 22:13:23 -0400
Message-Id: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAENWbWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyML3aLU3PyyVN2C9PiCosyyxJJU3eS0VEsjs2TzNAvjZCWgvoKi1LT
 MCrCZ0UpBbs5KsbW1AC4r+oRoAAAA
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
X-Mailer: b4 0.14.3
X-ClientProxiedBy: BL1PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:208:2be::33) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8049e82e-f2ed-4234-27b6-08deef72f511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|5023799004|11063799006|56012099006|10067099003|18002099003|3023799007|6133799003|921020;
X-Microsoft-Antispam-Message-Info: pNDbTnWlggYMSHNy6jsULJFDGtRzmhD27769oJzJU2pngka0LaGEKVpniUoUJ3CQmbg9xv959+2z+JRtqFf67HdU+qB4JaCwRrXHvxitHS4+X0w1LJjCqx7wSOTmTpy3XxuOd9+f8rK/oQHRePQKndJw/6mlHZZMRqE9wjM6o1AKyiS+KOoN9AwCyphX8Vge1MTQ4lDkgWBEWecQpXPpnk0UVsgsZQXPhDQPsCCipKZBMP4VxfsQyzGYHKkCHv+pjywEZE4DEG6l+4rl5dqSNtc7Qp/DQhsoH47boah3/NyuS1fH0f4kWHFAY6G6Uc40wwSbnwNwgs+WyRKk+i8gXQhhXxEgFiKIttIR6DzHA+ZDDvqLRYbRPY4/hfrCcr7v8m7gnFeK1A/TZtrfpXTX8OQHDcrLTPwZSWiqO7CgFcVOlcx6g3XcpK6DY058ctzvMykbyqZaT3/MipYsv6FlMBL6ObuDgleNuUqlH1qFmIrE1zerLMArOoouhPo7b0s2r8t/oX7VceX7KaXz8dR06EcgNpjyds4vn+pl4J9+JGfO801D7wUbLE0kNRfs3NfM96JMpb8PT2+Pv0dezg5+fDtkUnY8TRZh/pSBDuNLl0m7gAChrxtLbAkf1kt7TaGiF4i0NjEzc+x2hdxLFU5P8kIq8nFhZ6pjA5bStDcTp7wi6cPDfsKsUTMx1/68zgx1mYhoWmcx/XO8OqmYGdg28g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(3023799007)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xSZ2tsSUJ1YURzL2lvL2tRdmRuVEFFNFlkQnBtd1dkOG4vbTg2cHFsVnRG?=
 =?utf-8?B?VFNoYzN2cXdwK3picTlObkZKZGdHYTMxUjNlR0xycFB4WXUycHhxeEhYOHd3?=
 =?utf-8?B?K0J2Uk9rVk1WUkZOVEFtd2ZwNWdOZ2QxekZNTEphRWh5L2NxRlFZZFlVUXZB?=
 =?utf-8?B?K3NxZWdPQ0lyVThKaFZBelNPV1EzOVl5VEhQaFZydTRzblRDNDY1U01mQnhD?=
 =?utf-8?B?NDhiU1dKdE5SWXVoSjkvdDc0dnNUSzdoVjdSQnordHV1Tk0zSFZwaS9EUGto?=
 =?utf-8?B?aEtpY2ExQzM3T1VTbWEycmdiT1hzSTVFclVkMXg0eWJhWDI5WmhtL1duV0Z2?=
 =?utf-8?B?SlNBK1lYUCtaVkFtdFdRZ2RuQVZuTGdoVjl4V2xmVTBTRmhZQ2JYUDBORDJH?=
 =?utf-8?B?QnV2b2RvbnVFRUtOcnZHcTlRQlZMaWtzMXFyWnk5OXpvd1Vib0ZkSUdJZWdP?=
 =?utf-8?B?UDJ3Y2xwTmtNRVdYR1JJeTgvMXNOTERXcDFRaDBiQlpHOThGTnFQR1RCNnRr?=
 =?utf-8?B?SHE4M1BFZXBFTW9BbXExQWJYNEZsNTl6WkRtd1NMU08ycU5wRVFnWHlxb05L?=
 =?utf-8?B?a1pFT2h1VW9BdDlrYnBCNExFdWRTYnNmbVk4UEdaYnJyL0pueVZJczJ1MC85?=
 =?utf-8?B?RlJhcnRCbkl2SzZuV3ovN01xcjhkcWVNSVJqZHp1akNhUDA2b2Q1YWY5RkNa?=
 =?utf-8?B?TVpvUG9tSG5mcm0xMG9mTHFwZnVMYjBrdVRleG5UcmlXSVlnWGs5eWQ0Kzll?=
 =?utf-8?B?RDBSMlFuL3JucEFxeHRGYURTOERQdkxmYWMrWEFLak0xZVZ2RGVqUWZieFBu?=
 =?utf-8?B?NmhZMk9yci9URFpuaHUwQVpGa2p3VnJFK2pNRjduanF2Lys0Z0JDMTBkblBp?=
 =?utf-8?B?L3dQd2hhTC9PSkZhY09neFIxWEo1d2Q2UmJQQWdyMkF0aGQwWVprQ1hJTVcv?=
 =?utf-8?B?RTl0Z25ZM2J5SW8rMkMrblhROS9vZFZNTHIzY1BjKzFlTEZOTGd6ckozVmhY?=
 =?utf-8?B?YXBPdHVMRjgzNHgra3VibnRFbkdScXNjVkdFQ2pIdVJBRE81OWlsaS9IL01R?=
 =?utf-8?B?L25MZE92SFBFVFd6TFpEdG4wZ1JlRVdxS2x3WE5JbVViOXFsdU92eVN1TFdE?=
 =?utf-8?B?ak1UUjRUak5tVVh4MzFqdVpUT3BNbFNVRFBPUDc3d1ZXSlV6Nktoa0RhSjlW?=
 =?utf-8?B?UDlpRlViYzJaM09aY1lEYjVOOVNpWExmVFo1cFNSaXB3WGRKWlNaUGt1WkVv?=
 =?utf-8?B?bVp5QTFDM1BHZWZqZGQzbjFRMC8zM1I1Q1VtZWVhZWp5Ull6T2hJMmszTGFl?=
 =?utf-8?B?eXo5V0RMQWFUVHFMMG1ZQThHVW1nMDVIaEVKOEc5djY0TFIvNEpKVnJPM093?=
 =?utf-8?B?MHh4NmdhV0dERDZYTE5RdGF6OURVRThnUko4aDBsTmppSVRyb0pMYkV3b05u?=
 =?utf-8?B?UUVaNkxQNlp0NHRCWkFlVHhiR3hRZDF0RHMvcjFnelhHZU1peEpqYlNyLzlY?=
 =?utf-8?B?c1VsL1lNbHBEYk12cDkxZHJHM3Q2eS82UnZmT00vY0p2eWlwelRpeXc0cWxM?=
 =?utf-8?B?cVRpVExMSXdEQk1LUllBQ3RmOW02S0lOWDRqMFhoL2JTSkh0SnFhcGNzZWpC?=
 =?utf-8?B?eDYwR05Xbmg1WVhybkRrWW1sRTJZM1NENjlUNkM4RzdEWVZBSHN4NlcyRFdP?=
 =?utf-8?B?UUxDOEVZTXFsQVk1dCtmQ2Z0THZHTlRGdzlwV0FkTU5wdVdzZ3VncFNweEVH?=
 =?utf-8?B?WHBvSGUwcG5qVU10ZVBGYitrSkc2aUQvdzZaZXFKdzh5SjFHemVMTkhtSEhi?=
 =?utf-8?B?Slo0ZE9Cdjk4UkdVZ3I5dXhoNzlqdGE3c0xkOFM3clRCSDlnN2puNnFDWlhw?=
 =?utf-8?B?ZDZyTXNEQXBKdGc2LzhUSzNTVmYvOGZ0WEpxQXptbTA0ME5KWTQ5cHVybGov?=
 =?utf-8?B?SWNYYnJ3QVJlaW91d3VvMjFEcGl3R0RWemdqM1hYTHAxak5wL1VQeUo0TFdY?=
 =?utf-8?B?RDdmS3kxSUYwMlBwN01CTmlZMlpvQlg5Mkp0SWxzZTFMY3BrcEpqMHdGZ2Fy?=
 =?utf-8?B?Y0g3eWE3UlRuUmkrTnVnc29adHdwM3J2V3VrS21NUU92T3dBVHkwcThlbWJh?=
 =?utf-8?B?UkRmUDYwdy95cVByVklSRHpXenhpdHNORWJKdTNFaFV6WjNsbmZpaFRvM052?=
 =?utf-8?B?clUzczgvaXVmaWZjamxqNDVqQTRHR2M4MzFUQmN0Z2NkUjVROHJvakFZVlhD?=
 =?utf-8?B?TWRpYnhlNU5ZMjFXZDFzellUTlloTDMwZE1aTkxWYi8rM0xCbmpuM3JabDVp?=
 =?utf-8?Q?rIlyagVXs903sFdXgk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8049e82e-f2ed-4234-27b6-08deef72f511
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 02:16:55.1454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHRY+Bi+1YHiBNSqzAr7tvYfQ+7uKeAf5TdP84c5qEpoH6FkhhVKrN9emBFarEQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
X-Headers-End: 1wq3YB-0008Tg-MC
Subject: [f2fs-dev] [PATCH RFC 00/14] Remove PG_private by using
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
Y2hhbmdlZCB0byB6cGRlc2MtPnpzcGFnZS0+Zmlyc3RfenBkZXNjID09IHpwZGVzYwogICBpbnN0
ZWFkIG9mIGNoZWNraW5nIFBHX3ByaXZhdGUuCgoyLiBrZXJuZWwvZXZlbnRzL3JpbmdfYnVmZmVy
LmMgc3RvcmVzIHBhZ2Ugb3JkZXIgaW4gcGFnZS0+cHJpdmF0ZS4KICAgUmVwbGFjaW5nIFBHX3By
aXZhdGUgd2l0aCBwYWdlLT5wcml2YXRlICE9IE5VTEwgd29ya3MuCgozLiBkcml2ZXJzL3hlbi9n
cmFudC10YWJsZS5jIHN0b3JlcyB4ZW5fcGFnZV9mb3JlaWduIGluIHBhZ2UtPnByaXZhdGUsCiAg
IHdoZXJlIG9uIDMyLWJpdCwgYSBwb2ludGVyIHRvIHhlbl9wYWdlX2ZvcmVpZ24gaXMgc3RvcmVk
OyBvbiA2NC1iaXQsCiAgIHBhZ2UtPnByaXZhdGUgaXMgdXNlZCBhcyB4ZW5fcGFnZV9mb3JlaWdu
LiBQR19wcml2YXRlIGNoZWNrIGlzIHJlcGxhY2VkCiAgIGJ5IHBhZ2UtPnByaXZhdGUgIT0gTlVM
TCBvbiAzMi1iaXQgZm9yIHhlbl9wYWdlX2ZvcmVpZ24gZGVhbGxvY2F0aW9uLgogICBPbiA2NC1i
aXQsIHBhZ2UtPnByaXZhdGUgaXMgY2xlYXJlZCB1bmNvbmRpdGlvbmFsbHkgc2luY2Uge2RvbWlk
PTAsCiAgIGdyZWY9MH0gKHhlbl9wYWdlX2ZvcmVpZ24gY2FuIGJlIDApIGlzIHZhbGlkLgoKNC4g
ZnMvY3J5cHRvL2NyeXB0by5jIHN0b3JlcyBhIGZvbGlvIHBvaW50ZXIgaW4gcGFnZS0+cHJpdmF0
ZSwgUEdfcHJpdmF0ZQogICBjaGVja3MgYXJlIHJlcGxhY2VkIGJ5IHBhZ2UtPnByaXZhdGUgIT0g
TlVMTC4KCjUuIGZzL2Vyb2ZzIGhhcyB0d28gZGlmZmVyZW50IHVzZXM6CgogICAgNWEuIGZvbGlv
LT5wcml2YXRlIGlzIHVzZWQgdG8gZm9ybSBhIHJldmVyc2VkIGxpc3Qgb2YKICAgIHRoZSBvdXRw
dXRzIG9mIHJlYWRhaGVhZF9mb2xpbygpLiByZWFkYWhlYWRfZm9saW9fcmV2ZXJzZSgpIGlzIGFk
ZGVkIHRvCiAgICBvdXRwdXQgZm9saW9zIGluIHJldmVyc2VkIG9yZGVyLCBzbyB0aGF0IC0+cHJp
dmF0ZSBpcyBubyBsb25nZXIgbmVlZGVkLgoKICAgIDViLiBmb2xpby0+cHJpdmF0ZSBpcyB1c2Vk
IGFzIGFuIGluLWZsaWdodCBJL08gY291bnRlci4gQ29udmVydCB0aGUKICAgIGNvZGUgdG8gdXNl
IGZvbGlvX2F0dGFjaC9kZXRhY2gvZ2V0X3ByaXZhdGUoKS4KCjYuIGZzL25mcy93cml0ZS5jOiBm
b2xpbyByZWZjb3VudCBtYWludGVuYW5jZSBpcyBpbiBhIGJpZ2dlciBzY29wZSB0aGFuCiAgIGZv
bGlvLT5wcml2YXRlLiBTbyBmb2xpb19hdHRhY2gvZGV0YWNoL2dldF9wcml2YXRlKCkgaXMgbm90
IHVzZWQuCiAgIE5vdGhpbmcgdG8gY2hhbmdlLgoKNy4gZnMvZjJmcyB1c2VzIGF0dGFjaF9wYWdl
X3ByaXZhdGUoKSB0byBmaXJzdCByZXNldCBmb2xpby0+cHJpdmF0ZSB0aGVuCiAgIGltbWVkaWF0
ZWx5IHNldHMgUEFHRV9QUklWQVRFX05PVF9QT0lOVEVSIGJpdCBvbiBpdC4gQ2hhbmdlIGl0IHRv
IHVzZQogICBhdHRhY2hfcGFnZV9wcml2YXRlKCkgdG8gc2V0IFBBR0VfUFJJVkFURV9OT1RfUE9J
TlRFUiBiaXQgZGlyZWN0bHkgdG8KICAgYXZvaWQgZm9saW8tPnByaXZhdGUgPT0gTlVMTCBnYXAg
aW5zaWRlIHNldF9wYWdlX3ByaXZhdGVfIyNuYW1lKCkuCgo4LiBodWdldGxiIHVzZXMgZm9saW9f
Y2hhbmdlX3ByaXZhdGUoZm9saW8sIE5VTEwpIHdpdGhvdXQgZm9saW8gcmVmY291bnQKICAgbWFp
bnRlbmFuY2UuIENoYW5nZSBpdCB0byBmb2xpby0+cHJpdmF0ZSA9IE5VTEwuCgpBZnRlciB0aGUg
YWJvdmUgY2hhbmdlcywgUEdfcHJpdmF0ZSBvcHMgYXJlIGNvbnZlcnRlZCB0bwpwYWdlL2ZvbGlv
LT5wcml2YXRlIG9wcy4KCmZvbGlvX3Rlc3RfZnNfcHJpdmF0ZSgpIGlzIGFkZGVkIHRvIGNoZWNr
IGZpbGVzeXN0ZW0tb25seSBwcml2YXRlIGRhdGEgYnkKZXhjbHVkaW5nIHN3YXBjYWNoZSBhbmQg
aHVnZXRsYiBmb2xpb3MsIGJlY2F1c2Ugc3dhcGNhY2hlIGZvbGlvcyBvdmVybGFwCnN3cF9lbnRy
eV90IHN3YXAgd2l0aCAtPnByaXZhdGUgYW5kIGh1Z2V0bGIgc2V0cyBpdHMgb3duIGZsYWdzIGlu
Ci0+cHJpdmF0ZS4KCk5vdGUKPT09CjEuIEtQRl9QUklWQVRFIGhhcyBhIG1pbm9yIHNlbWFudGlj
IGNoYW5nZS4gU2luY2UgUEdfcHJpdmF0ZSB3aWxsIGJlCiAgIHJlbW92ZWQsIEtQRl9QUklWQVRF
IHJlcHJlc2VudHMgcGFnZWNhY2hlIGZvbGlvcyB3aG9zZSAtPm1hcHBpbmcgaXMgbm90CiAgIE5V
TEwgYW5kIHdpdGggLT5wcml2YXRlIHNldC4gQ3VycmVudGx5IEtQRl9QUklWQVRFIGNhbiBiZSBz
ZXQgZm9yCiAgIG9ycGhhbmVkIHBhZ2VjYWNoZSBmb2xpb3Mgd2l0aCAtPm1hcHBpbmcgPT0gTlVM
TC4KCjIuIERvY3VtZW50YXRpb24vbW0vaHVnZXRsYmZzX3Jlc2Vydi5yc3QgaXMgb3V0ZGF0ZWQs
IHNvIEkgZGlkIG5vdCByZW1vdmUKICAgUEdfcHJpdmF0ZSByZWxhdGVkIHRleHQuIEl0IHNob3Vs
ZCBiZSByZXdyaXR0ZW4uCgozLiBQR19mb2xpbyBpcyBwbGFubmVkIHRvIGJlIHNldCBvbiBldmVy
eSBwYWdlIGZyb20gYSBmb2xpbyBpbgogICBwYWdlX3JtYXBwYWJsZV9mb2xpbygpLCBzbyBmb2xp
b3Mgd2l0aCBhbnkgb3JkZXIgKGN1cnJlbnRseQogICBQR19sYXJnZV9ybWFwcGFibGUgaXMgdXNl
ZCB0byBpZGVudGlmeSA+MCBvcmRlciBmb2xpb3MpIGNhbiBiZQogICBpZGVudGlmaWVkLCB2bV9p
bnNlcnRfKigpIGNhbiBjb3JyZWN0bHkgcmVqZWN0IGFsbCBmb2xpb3MsIGFuZCBybWFwIGNvZGUK
ICAgY2FuIGFjY2VwdCBvbmx5IGZvbGlvcy4gRXZlbnR1YWxseSwgcGFnZV9mb2xpbygpIHdpbGwg
cmV0dXJuIE5VTEwgZm9yCiAgIG5vbi1mb2xpbyBwYWdlcy4KClRlc3RzCj09PQoxLiBhbGxtb2Rj
b25maWcgYnVpbGQgcGFzc2VkLgoKMi4genNtYWxsb2MgaXMgdGVzdGVkIHVzaW5nIGV4dDQgb24g
YSAxR0IgbHo0IHpyYW06CiAgICAyYS4genJhbSBsb2FkICsgenNtYWxsb2MgY29tcGFjdGlvbjsK
ICAgIDJiLiBjb25jdXJyZW50IHpzcGFnZSBtaWdyYXRpb24gdmlhIG1lbW9yeSBjb21wYWN0aW9u
OwogICAgMmMuIGNvbmZpcm1lZCB0aGF0IG11bHRpLXBhZ2UgenNwYWdlcyBhY3R1YWxseSBmb3Jt
ZWQuCgogICAgRGV0YWlsczogaHR0cHM6Ly9naXRodWIuY29tL3gteS16L2xpbnV4LWRldi9ibG9i
L2I0L3JlbW92ZS1wZ19wcml2YXRlL3Rlc3RfenNtYWxsb2MubWQKCjMuIGVyb2ZzIGlzIHRlc3Rl
ZCBvbiBpbWFnZXMgY3JlYXRlZCB3aXRoIC1DNDA5NiBhbmQgbHo0aGMsIGx6bWEsCiAgIGRlZmxh
dGUsIGFuZCB6c3RkIGFsZ29yaXRobXM6CiAgIDNhLiBjb2xkIHJlYWQgb2YgYWxsIGZpbGVzLCB2
ZXJpZnkgY2hlY2tzdW1zIG1hdGNoIHNvdXJjZTsKICAgM2IuIHJlYWRhaGVhZCArIHJlY2xhaW0v
bWlncmF0aW9uIHJhY2UuCgogICBEZXRhaWxzOiBodHRwczovL2dpdGh1Yi5jb20veC15LXovbGlu
dXgtZGV2L2Jsb2IvYjQvcmVtb3ZlLXBnX3ByaXZhdGUvdGVzdF9lcm9mcy5tZAoKNC4gZnNjcnlw
dCBpcyB0ZXN0ZWQgb24gc29mdHdhcmUtZW5jcnlwdGVkIGV4dDQgd2l0aCB3cml0ZXMgdG8gZXhl
cmNpc2UKICAgYm91bmNlIHBhZ2VzLgoKICAgRGV0YWlsczogaHR0cHM6Ly9naXRodWIuY29tL3gt
eS16L2xpbnV4LWRldi9ibG9iL2I0L3JlbW92ZS1wZ19wcml2YXRlL3Rlc3RfZnNjcnlwdC5tZAoK
NS4gZjJmcyBpcyB0ZXN0ZWQgb24gYW4gaW1hZ2Ugd2l0aCBpbmxpbmVfZGF0YSxjb21wcmVzc19h
bGdvcml0aG09bHo0OgogICAgNWEuIElOTElORV9JTk9ERSDigJQgbG90cyBvZiB0aW55IGZpbGVz
OwogICAgNWIuIFJFRl9SRVNPVVJDRSArIGdlbmVyYWwgd3JpdGViYWNrIOKAlCBidWZmZXJlZCB3
cml0ZSBjaHVybiB3aXRoIGZzeW5jOwogICAgNWMuIE9OR09JTkdfTUlHUkFUSU9OIOKAlCBmb3Jj
ZSBHQyAvIHBhZ2UgbWlncmF0aW9uOwogICAgNWQuIEFUT01JQ19XUklURSDigJQgYXRvbWljLXdy
aXRlIGlvY3RsIHBhdGguCgogICAgRGV0YWlsczogaHR0cHM6Ly9naXRodWIuY29tL3gteS16L2xp
bnV4LWRldi9ibG9iL2I0L3JlbW92ZS1wZ19wcml2YXRlL3Rlc3RfZjJmcy5tZAogICAgKEkgZGlk
IG5vdCBydW4geGZzdGVzdHMpCgo2LiBNTSBzZWxmdGVzdHMgcGFzc2VkLgoKTExNIHVzZQo9PT0K
Q2xhdWRlIHdhcyB1c2VkIHRvIGZvcm0gYSBjb25jcmV0ZSBwbGFuIG9uIHdoYXQgY29kZSBuZWVk
cyB0byBiZSBjaGFuZ2VkCmFuZCBob3cgdG8gY2hhbmdlIHRoZW0uIFRoZSBwbGFuIHdhcyByZXZp
ZXdlZCBieSBDb2RleCB1bnRpbCBubyBpc3N1ZSB3YXMKc3BvdHRlZC4KClBsYW4gaXMgYXQ6IGh0
dHBzOi8vZ2l0aHViLmNvbS94LXktei9saW51eC1kZXYvYmxvYi9iNC9yZW1vdmUtcGdfcHJpdmF0
ZS9wbGFuLm1kCgpJIHRoZW4gZm9sbG93ZWQgdGhlIHBsYW4gdG8gbWFrZSBjb2RlIGNoYW5nZXMu
IEkgZGlkIGJvdW5jZSBpZGVhcyB3aXRoCkNsYXVkZSBob3cgdG8gY2hhbmdlIGZzL2Vyb2ZzLCBz
aW5jZSBJIGRpZCBub3QgbGlrZSB0aGUgb3JpZ2luYWwgaWRlYS4KQWZ0ZXIgZWFjaCBjaGFuZ2Us
IEkgYXNrZWQgQ2xhdWRlIHRvIHJldmlldyBteSBjb2RlIGFuZCBnaXQgY29tbWl0IG1lc3NhZ2Uu
CkkgYWxzbyBhc2tlZCBDbGF1ZGUgdG8gZ2l2ZSBtZSB0ZXN0IHBsYW5zIChzZWUgYWJvdmUpLgoK
QXQgbGFzdCwgQ29kZXggd2FzIHVzZWQgdG8gcmV2aWV3IGFsbCBwYXRjaGVzLgoKQ29tbWVudHMg
YW5kIHN1Z2dlc3Rpb25zIGFyZSB3ZWxjb21lLiBUaGFua3MuCgpBc3Npc3RlZC1ieTogQ2xhdWRl
OmNsYXVkZS1vcHVzLTQtOApBc3Npc3RlZC1ieTogQ29kZXg6Z3B0LTUKU2lnbmVkLW9mZi1ieTog
WmkgWWFuIDx6aXlAbnZpZGlhLmNvbT4KLS0tClppIFlhbiAoMTQpOgogICAgICBtbS96c21hbGxv
YzogcmVwbGFjZSBQR19wcml2YXRlIHdpdGggcG9pbnRlciBjb21wYXJpc29uCiAgICAgIHBlcmYv
cmluZ19idWZmZXI6IHN0b3AgdXNpbmcgUEdfcHJpdmF0ZSBhcyBBVVggcGFnZSBoaWdoLW9yZGVy
IG1hcmtlcgogICAgICB4ZW4vZ3JhbnQtdGFibGU6IHN0b3Agc2V0dGluZyBQR19wcml2YXRlIG9u
IHBhZ2VzIGZvciBncmFudCBtYXBwaW5nCiAgICAgIGZzL2NyeXB0bzogc3RvcCBzZXR0aW5nIFBH
X3ByaXZhdGUgb24gYm91bmNlIHBhZ2UKICAgICAgbW0vaHVnZXRsYjogdXNlIGRpcmVjdCBhc3Np
Z25tZW50IGluc3RlYWQgb2YgZm9saW9fY2hhbmdlX3ByaXZhdGUoKQogICAgICBmcy9mMmZzOiBz
dG9wIHVzaW5nIFBHX3ByaXZhdGUKICAgICAgZnMvZXJvZnM6IG1tL3BhZ2VtYXA6IGFkZCByZWFk
YWhlYWRfZm9saW9fcmV2ZXJzZSgpIHRvIGF2b2lkIGZvbGlvLT5wcml2YXRlCiAgICAgIGZzL2Vy
b2ZzOiB1c2UgZm9saW9fYXR0YWNoL2RldGFjaF9wcml2YXRlKCkgaW5zdGVhZCBvZiBkaXJlY3Qg
YXNzaWdubWVudAogICAgICBtbS9wYWdlLWZsYWdzOiBjaGVjayBwYWdlL2ZvbGlvLT5wcml2YXRl
IGluc3RlYWQgb2YgUEdfcHJpdmF0ZQogICAgICBtbS9wYWdlLWZsYWdzOiBpbnRyb2R1Y2UgZm9s
aW9fdGVzdF9mc19wcml2YXRlKCkKICAgICAgdHJlZXdpZGU6IHJlbW92ZSBmb2xpb19zZXQvY2xl
YXJfcHJpdmF0ZSgpCiAgICAgIHRyZWV3aWRlOiByZXBsYWNlIFBhZ2VQcml2YXRlKCkgd2l0aCBw
YWdlX3ByaXZhdGUoKQogICAgICB0cmVld2lkZTogYWRqdXN0IGNvbW1lbnRzIG9uIFBhZ2VQcml2
YXRlIGFuZCBQR19wcml2YXRlCiAgICAgIG1tL3BhZ2UtZmxhZ3M6IHJlbW92ZSBQR19wcml2YXRl
CgogRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVpbmZvLnJzdCB8ICAyICst
CiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Zmcy5yc3QgICAgICAgICAgICAgIHwgIDYgKyst
LQogYXJjaC94ODYvZXZlbnRzL2ludGVsL2J0cy5jICAgICAgICAgICAgICAgICAgICB8ICAzIC0t
CiBhcmNoL3g4Ni9ldmVudHMvaW50ZWwvcHQuYyAgICAgICAgICAgICAgICAgICAgIHwgIDYgKyst
LQogZHJpdmVycy9tZC9tZC1iaXRtYXAuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsr
LS0KIGRyaXZlcnMveGVuL2JhbGxvb24uYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNSAr
KysrCiBkcml2ZXJzL3hlbi9ncmFudC10YWJsZS5jICAgICAgICAgICAgICAgICAgICAgIHwgIDcg
KystLS0KIGZzL2NlcGgvYWRkci5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
OCArKy0tLS0KIGZzL2NyeXB0by9jcnlwdG8uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMiAtLQogZnMvZXJvZnMvZGF0YS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICA1ICsrLS0KIGZzL2Vyb2ZzL3pkYXRhLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAxMSArKy0tLS0tLQogZnMvZjJmcy9mMmZzLmggICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICA4ICsrKy0tLQogZnMvbmZzL2ZpbGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICA0ICstLQogZnMvbmZzL3dyaXRlLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAyIC0tCiBmcy9wcm9jL3BhZ2UuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDUgKysrLQogZnMvdWJpZnMvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICA2ICsrLS0KIGluY2x1ZGUvbGludXgvYnVmZmVyX2hlYWQuaCAgICAgICAgICAg
ICAgICAgICAgfCAgNiAtLS0tCiBpbmNsdWRlL2xpbnV4L21tLmggICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgMTYgKysrKystLS0tLS0KIGluY2x1ZGUvbGludXgvbW1fdHlwZXMuaCAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNCArLS0KIGluY2x1ZGUvbGludXgvcGFnZS1mbGFncy5oICAg
ICAgICAgICAgICAgICAgICAgfCAzOCArKysrKysrKysrKysrKysrKystLS0tLS0tLQogaW5jbHVk
ZS9saW51eC9wYWdlbWFwLmggICAgICAgICAgICAgICAgICAgICAgICB8IDM1ICsrKysrKysrKysr
KysrKysrKysrKystLQogaW5jbHVkZS90cmFjZS9ldmVudHMvbW1mbGFncy5oICAgICAgICAgICAg
ICAgICB8ICAyICstCiBpbmNsdWRlL3RyYWNlL2V2ZW50cy9wYWdlbWFwLmggICAgICAgICAgICAg
ICAgIHwgIDIgKy0KIGtlcm5lbC9ldmVudHMvcmluZ19idWZmZXIuYyAgICAgICAgICAgICAgICAg
ICAgfCAgNyArKy0tLQoga2VybmVsL3ZtY29yZV9pbmZvLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxIC0KIG1tL2h1Z2VfbWVtb3J5LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMiArLQogbW0vaHVnZXRsYi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICA2ICsrLS0KIG1tL21pZ3JhdGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMyArLQogbW0vcGFnZS13cml0ZWJhY2suYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICA1ICsrKy0KIG1tL3Ztc2Nhbi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMyArLQogbW0venBkZXNjLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyICstCiBtbS96c21hbGxvYy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMTUgKystLS0tLS0tLQogMzIgZmlsZXMgY2hhbmdlZCwgMTI3IGluc2VydGlvbnMoKyksIDEw
NiBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0OiBiY2Q1ZWI2OGE2YTE4OTQ5N2ViMjZjMWI5
ZjYyMjUzOGFhNDg4OTVkCmNoYW5nZS1pZDogMjAyNjA3MjgtcmVtb3ZlLXBnX3ByaXZhdGUtY2Zl
OTI2YzdmODNjCgpCZXN0IHJlZ2FyZHMsCi0tIApZYW4sIFppCgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
