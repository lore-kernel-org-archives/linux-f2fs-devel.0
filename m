Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C380CCDB46F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:From:References:To:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b3wkoNpT2qC83LB8v1SrkhrYGXGOFm7K1hXwM2gcsno=; b=LBQXrO9S4u+0oKNGJ0q9udUw5V
	seG6cUL0GSEUCGSoSNv18KAgaffAw7ldgvhU7r0zPPI+Kuwnjc+0+I1f9S7BEVm4JPlMZwD4kNrwC
	cR4+INR0kMLH+15wTI+jPcxr5D1Bd+fjHFlhoWUMCz030fSsNgsRDoWZnb8WxrAmRTeA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbxSX-0002qS-Ta;
	Tue, 23 Jun 2026 09:30:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@outlook.com>)
 id 1wbxSG-0002pV-BE for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 09:30:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UFRAe9mQgfYSgsHDmpWGGnYkRuIV0UVP541wEND7D0E=; b=KfguncZG4VakKc+5xxztvUicw4
 YsWZ6tiZk2sUueJIE3jNu7aDVBSUsRWg2UPHsy07xXdu9Jq3vLV0BLhvZGgoox5d5ZpjIqHMdPu2y
 lOgoXj/Fqo2aV/GcEWU2DrpKEFND5SHrzIx1ODTPY6FApt6WGmdZdN7DA37W70XliKKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UFRAe9mQgfYSgsHDmpWGGnYkRuIV0UVP541wEND7D0E=; b=LBkxJOQFlPMVI/ZgvG6stdHL9d
 xmotj1lOujok8HS/f4Qlw1zBSxeekFafY22OdP/pumLsBvB9Hq85XWOfRKR9V4nRefafk8O9cSUMU
 kczyQoB1i0eQf3XR9oHnNGrUCcsFrhVAinxl9BeBUP96/lFenYuizXUbcJleVVRR6ncA=;
Received: from mail-japaneastazolkn19012058.outbound.protection.outlook.com
 ([52.103.43.58] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbxSB-0000nc-1D for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 09:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FW5Zf1bMqUxNT72JkUcKc3Sik/YU6xFvyY1OqEr/HC4z+GhU/tufLX7dfmd3+1jFG1Z3as1CsVhxCkVwswBiQ9g93eQp4r//BJhiUFtJuZfwuJ6hfcNatdXyiSYAsW/sRFlWtjK+0pALA/2nh0PENVYOlq8SJe2YGiCtIZHp4d3Q0BPGEApc0bb/8SfM549qG1XvlUkDhBch2lz9iB7qXiRkDYJwv/SFsIGlbtjxu23IcOhXE9tLPkdpExodVJxF2BUX2Cm2EoootZlItGHSmpUFTaYnZHsbtBiuCNwVL03bXfsHtxzB2R6wo349TjxF7ZGm/uZKB6OhqRSvHo5dhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFRAe9mQgfYSgsHDmpWGGnYkRuIV0UVP541wEND7D0E=;
 b=rKAPlMNb5Vp12X3tvuEM5pZOvIfkKUaAtMBCAnJX+HZ1qfQ3QJ5UZ0lzh6dvV570CNu+oUqRF1I6Aq5lqEXh5XmIprup3w0gqvzmq3fF10W4ju/A8wMq6PdjijdnL7TZu3snjOD+RaZlkNZvUQGtz+eax9j9y55gnPK2r01RIQgTNcjllwSTrNseS2l7rF4z2y9Z4Mo/Y+i2Ics3frUArTzA1UpkypbooFIC9+BHBaZj9OPUrYeRimFdnjVb9RY0g/l/Z1QcufnWpXClqEjZVFQHWQyJkckgOhgjdMkqBuCA4Wfx24Er2/kJXzr3H6i9LSt1mqEuPnYJ6Zcm1TKZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFRAe9mQgfYSgsHDmpWGGnYkRuIV0UVP541wEND7D0E=;
 b=RAKi6O5q4jvwfSu7KLS/h7mxc5d5a+0cIkP1x5sVFwasbC57S4ct2GL7iUKv/3rSFGXCuRzhxjE/Ls6IPhAY3+YVGgKenoncI8tGPKCjk5XmGa/DXuPqtz5Fa778wzaRHalsaQ5HnhHF6Hb9acSmfVPZO65817ZH/WBB/xbK7pmIdHtGNrPNeRNsfNB5qdQcieIHnkThWOrtl5XDdKxKNc89Ny1tUp7ezPAfd3EEQRkycI1HDXo8EZF7pIF3PRXk3okNqwGTpB5/5XJLPwfprp7K2sSkvmasSF3stq+Yj/7KHS/XZiLkrnXOO1cQtEjpkbn8ZHtmsa7HlqlBJ6UwSQ==
Received: from SEZPR02MB5662.apcprd02.prod.outlook.com (2603:1096:101:4e::13)
 by SEYPR02MB7250.apcprd02.prod.outlook.com (2603:1096:101:1dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Tue, 23 Jun
 2026 09:29:46 +0000
Received: from SEZPR02MB5662.apcprd02.prod.outlook.com
 ([fe80::e4bc:d995:70f6:5b72]) by SEZPR02MB5662.apcprd02.prod.outlook.com
 ([fe80::e4bc:d995:70f6:5b72%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:29:46 +0000
Message-ID: <SEZPR02MB5662929A720F09F0ABFD3DD499EE2@SEZPR02MB5662.apcprd02.prod.outlook.com>
Date: Tue, 23 Jun 2026 17:29:37 +0800
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260612115839.2065903-2-yangyongpeng.storage@gmail.com>
 <20260612115839.2065903-3-yangyongpeng.storage@gmail.com>
 <7ffe0789-1024-4dc7-9089-2dcf856a1bd1@kernel.org>
 <SEZPR02MB5662A85B218D3EF7B2FA8C6599E22@SEZPR02MB5662.apcprd02.prod.outlook.com>
 <e876caa4-37bb-409c-98e5-2d051178d6db@kernel.org>
 <SEZPR02MB5662F1A9AFD88BEA4624BC9699E02@SEZPR02MB5662.apcprd02.prod.outlook.com>
 <d74fd6f1-9c92-4810-9549-e8066ec9d807@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <d74fd6f1-9c92-4810-9549-e8066ec9d807@kernel.org>
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To SEZPR02MB5662.apcprd02.prod.outlook.com
 (2603:1096:101:4e::13)
X-Microsoft-Original-Message-ID: <d2e05042-2899-4728-b50f-089a8dc934e1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5662:EE_|SEYPR02MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 074fb9e5-96fa-4a51-e760-08ded109f4e6
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|45011099003|7042599007|8060799015|19110799012|25010399006|8022599003|15080799012|5072599009|23021999003|22091999003|24121999003|10035399007|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXNtbDJPeFZPSVFoSnJHam0ySWc3ZGhNcEVIV0pXYlAwQUxMRWhDbzdsQU5Z?=
 =?utf-8?B?MCtyMzJrV0JubTRMcktiS0lEd2ZGSzFvODJicUlMenlhU2pMVElrSko1Slpm?=
 =?utf-8?B?MjlONCtzbGM4Yll1RFkwUjBRSHN6VmdaeVBNQWh6dXZPbjNPcTM2YjJTNDNE?=
 =?utf-8?B?Wi9uV25zbzU5dzlSeTFHTmRzbWNOU0Z4eU82NXNxSmY1MWVLbHorLzd3NUdE?=
 =?utf-8?B?Y2dWeHdhVnpleHFSRWVBSWZIOEdTUklnTkpXbG5JNDlKc3ZJRUI2eGppaHFJ?=
 =?utf-8?B?Wml6bzNTN0FPMkhHWE4yamhRVXZPMjVXb1ZzcU5RUzR2UXVGK29EeEJoTVRG?=
 =?utf-8?B?eC9kZ2xqdXhJQmxJTFpVT3JmM0VZd2YzZGxOTlM4ejRORzJDd3p1TmNyYWRh?=
 =?utf-8?B?UnMweXNGaVIweGhMWWg0N0ZJYy81VDhiVE1ZZUFSUEdwRnI5T3puRVIrTFVR?=
 =?utf-8?B?OENjSk9MZjlOTmlqaURaNnk0QUpkd1o3QkR3V0EyTGh0VWNDamQ0b2t6djFX?=
 =?utf-8?B?RTlBMEVWRkQ3Sk12eHhyNENRTWFZVlM5QzNFQzZvSU1IU2hla2o3WmhybG4r?=
 =?utf-8?B?Q3B2VVhnRVYzTkdXT1Y5L1ZBRDBYSkQ3T05RRXlrOXhEc1FzMElReGJYemJG?=
 =?utf-8?B?OGg2WFMrNWRwVlpBaDQwOTBFYjFtNkVBWUxTVFFvZzVRbGpIaW9MNzNXK2ts?=
 =?utf-8?B?NUFibm1XRXU2WnZlSFFvY1Y2YWhxTkxQd0JFTzFiMHYxcmhROEtHN2M3UmVu?=
 =?utf-8?B?ZzRMMmEwNXJoNjdWNUprNTVLbjJnMEdVUHJZa2FIOUtZUCtlR0QyVTdDdUl5?=
 =?utf-8?B?UkpLSFVaa2p4eFJ1SnZZczZjc0c2dFJHYy9pRWdJSVNRR2pzM0FSQmJyZEdo?=
 =?utf-8?B?T3F6UGdTeHdjOGt3alFEUmROQzJSTWhXTnlrdTdhbVVUMDl6cnRWM3ZBQlpr?=
 =?utf-8?B?cFZibmtYR0JyWFhMaEN1VVgvdGowVHkzV1hJbEprVHZwbTRNMGlwZHE5ZUUy?=
 =?utf-8?B?Ymp1UVdvUmxRNERMQ05GZnlzaytKNGNNQmQ5NlRlczZWMTJKamxoaW9Za0lZ?=
 =?utf-8?B?NlFlZ0xOUmErTVg2ZDEwNWl2eExDQ3JTM2cxK0UxWFFmMlR1N0lSUmJ4UnMx?=
 =?utf-8?B?TzZJbmQwaW9yNGd0Rm1mUjYrSTZSV0kyMmJMMElIcWc2RGd6Q1FHSmFCN09p?=
 =?utf-8?B?anVFcHFjV3FNWHI1ejhKbmJqMUR4M0F1Vytra3p5RVhhcG9pREM1TFhHNkpr?=
 =?utf-8?B?WGwzbWM3aXk4a3p4Z0x6aUwrejc0Uk1GWDRFWVFDM2hTL2xXbjgrdFpFN21y?=
 =?utf-8?B?SUI0Zkx5Q0xLdDZFOFY2T083RDZ4RVoyU2N3a3FIWUtkRWxqbk5yVlVXUmwz?=
 =?utf-8?B?bDNkcFdzWXpxWUxCczFaWEFOeUQzNDc5K21GNlFmaitQOE5UeW1vcFZrcjlK?=
 =?utf-8?B?bWJTNUZCZEV5L0ZMMFVqUVhoYkZpdGU5WEY2OTlRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEF1VmdOUDhBS25PTnIzZThxZ3dhOUl6TVd0dmtKWjU4Wjl6a0xZK21tYnBa?=
 =?utf-8?B?bVFCZTB0TTF3ekhRcDVBcm05aU4vY3FVSTdYSnFxQ1FFOW1DNE4reE5aYmxZ?=
 =?utf-8?B?ZjRCUVpIMTBZalYzeE9mNDZFKzJoU3BDT1NRTjNlZndPV0VoZEtDbCt1S1F6?=
 =?utf-8?B?dWp3T3Q2VmV5b1NkemcreFlDRkxBdHRlYm1maElyVjVDd1haR05tekx3UjZV?=
 =?utf-8?B?bEIyVDdnR0Z5Q01TVlVxenFidzVxV3dEc0VCN3pWV3B2TnRVaDdRY2ptRDJ1?=
 =?utf-8?B?SFZrM2pNcUxUa0VYcUw1a3pJL1V5SDBXYkdOaDV5Q0hIZm9JWHpZTW5xdWc0?=
 =?utf-8?B?QzNIVmNtdXpGVW1lOVovWnJod1lrTVY2cERzWnhYNUdRanpXcnZ3VXJVSVJu?=
 =?utf-8?B?dWZ2N0hLajZDRmloR1lyUC9zcWowTlZXcnk1bWI1ODJScUhyZFpGRDhQN2JT?=
 =?utf-8?B?dG51YmdIeWlxV1dpNHhPcEZjcFlXS0FWTllMQW9ER1J0MGZiZzgxNzQyZTU0?=
 =?utf-8?B?emI0SzgvQjhMZmJOcnpiWTZtem1sMDNTUVRZSTREaFBOMmh2MDNlcW5kZEVj?=
 =?utf-8?B?U3RRdkNBRGRUQjAwOHhEL3dtdGdDbXo5emcyZkZsOVRPOGJsTURyNmRqTlQr?=
 =?utf-8?B?ZEFCbW1aeWRIaWZjbDRGZy9xZzRydUhMV2hNWDFxY1NVVGwyck9EbE5oUlZw?=
 =?utf-8?B?L21vMnMyRUo5NExOYlJQNk9NcFA0K2EvSVUrSGFZMFdwWEdEVFdZbWJzUVp5?=
 =?utf-8?B?THd1OGxWSDBLRjJSNDFjdWoxMGE3QVB0eWpvQllxbi9Da0Jxa3F1TFpGeWth?=
 =?utf-8?B?a21CbWVKTDZHS09TbHh6L1YzVk9QRHNPZXJGa3VaMDFDejE0M1o5VHRIRTF0?=
 =?utf-8?B?WURUWXdRZDFvU3ZDOFcvdW5IcTNaVWpmUWxCUkx3MmJMR01mRTdZbThGVzYr?=
 =?utf-8?B?alFmVEZDSkZkbllwdkg1KzdzYnRELzNXQUVMeUN6SXI3eWtFNnduaEtzbFBm?=
 =?utf-8?B?QnJnV2ZNM2NycURZejhzaGJWV2dkZFRodWc1UVFRc25jNTZYdncxdEJPTkU0?=
 =?utf-8?B?N3VhSllwUkhNU1I3QkxjQUlRN2hMSUNsSVNENk4vU3BXZU5ZSGpUZ0U3SnJ5?=
 =?utf-8?B?N0hoWEpYeVREY3A3N1l2VEZGd21yekhWVmx0TDRLbnVvZ2FzS0tzdGcwT3Vj?=
 =?utf-8?B?eVYxMnpsQzFZd0JqaGxKamdWbFNlbi91eWJjUlB3RFo1ZUYzUVY1cnNsUFYr?=
 =?utf-8?B?eStRUlpjZ05wVUNyZElBVmVYZkxVZXlOZ2pCRWM0aXU4ckE5TGJ3aitYYVpq?=
 =?utf-8?B?cSs1eUFMN3NNQmU1T2hpZGtob0dtRTNVSGRzODJ1SnU4ODNLQmZQS1Q2REdN?=
 =?utf-8?B?L3dPaGlXdnFja2xPWDE3MVFJOW5FQzdnZ2grQk5BbDkraHNsd3JCYnZOWDNm?=
 =?utf-8?B?Kzk0STNqMnl3UmlQUTZqSFllYmVJbzVITkZqaytlaXloekNuMllFdkVPQnR3?=
 =?utf-8?B?U0ZSNnhvdHg1K2ZvR2NabE4ybTU3eEtTL25Ea3VpRERYUWo1RFRrNmFEaWFn?=
 =?utf-8?B?NUJtdVVldHhhVGlLZXFIdktwNlFWc3NWTnVCR2dHQVFnSnkwRmladElhdjl0?=
 =?utf-8?B?R3YvK1gwMEppYTUyc0x6WjUzcEhVaE93Q3hyS0xCRE9sTFgvdmt4bms0VmV2?=
 =?utf-8?B?VERidjhsQmR5M2g0L0JQU1Y4cW5HK3k4aDQyTVJ6b2xsdlR0V04zempqdzZU?=
 =?utf-8?B?aEhGS1hzUGM4YlE0Z1FwN2xDQ2ZKb09LVkJza1hzNkdOWHFab3B2TU8vazZJ?=
 =?utf-8?B?TUV1c3pmU3VhZHFUM1VlODI2dCtUMWFsdmx0UCtXL2xJSmh6ZWZHSURVU25p?=
 =?utf-8?B?Wi9HQXlqcmcrS2lRdG43Y3hFSDF3V1ZVUVBpTkVQaUE2VGV6TTM2TU53S09D?=
 =?utf-8?Q?hAFuany/DhM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074fb9e5-96fa-4a51-e760-08ded109f4e6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5662.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:29:45.9024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7250
X-Headers-End: 1wbxSB-0000nc-1D
Subject: Re: [f2fs-dev] [PATCH RESEND 2/5] f2fs: only initialize largest
 extent without extent_node at inode init
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Ck9uIDYvMjIvMjYgMDg6NDIsIENoYW8gWXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwgd3JvdGU6Cj4g
T24gNi8yMS8yNiAyMzo0OCwgWW9uZ3BlbmcgWWFuZyB3cm90ZToKPj4gT24gNi8yMC8yNiAxMToz
MSBBTSwgQ2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCB3cm90ZToKPj4+IE9uIDYvMTkvMjYg
MjI6MzQsIFlvbmdwZW5nIFlhbmcgd3JvdGU6Cj4+Pj4KPj4+PiBPbiA2LzE1LzI2IDc6NTUgUE0s
IENoYW8gWXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwgd3JvdGU6Cj4+Pj4+IE9uIDYvMTIvMjYgMTk6
NTgsIFlvbmdwZW5nIFlhbmcgd3JvdGU6Cj4+Pj4+PiBGcm9tOiBZb25ncGVuZyBZYW5nIDx5YW5n
eW9uZ3BlbmdAeGlhb21pLmNvbT4KPj4+Pj4+Cj4+Pj4+PiBUaGUgbGFyZ2VzdCBleHRlbnQgdGFr
ZXMgZWZmZWN0IGR1cmluZyBib3RoIHJlYWQgbWFwcGluZyBhbmQgd3JpdGUKPj4+Pj4+IG1hcHBp
bmcgbG9va3Vwcywgd2hpbGUgcmVhZCBtYXBwaW5nIGRvZXMgbm90IG5lZWQgdG8gYWNjZXNzIHRo
ZQo+Pj4+Pj4gZXh0ZW50X25vZGUuIEZvciB3cml0ZSBtYXBwaW5nLCB0aGUgY2FzZSB3aGVyZSB0
aGUgbGFyZ2VzdCBleHRlbnQgaXMKPj4+Pj4+IG5vdCBpbiB0aGUgZXh0ZW50IHRyZWUgY2FuIGFs
cmVhZHkgYmUgaGFuZGxlZCBieSB0aGUgbWVyZ2UgbG9naWMsIGFuZAo+Pj4+Pj4gY2FzZXMgdGhh
dCBjYW5ub3QgYmUgbWVyZ2VkIGRvIG5vdCByZXF1aXJlIHRoZSBsYXJnZXN0IGV4dGVudCB0bwo+
Pj4+Pj4gcGFydGljaXBhdGUgZWl0aGVyLgo+Pj4+Pj4KPj4+Pj4+IFRoZXJlZm9yZSwgdGhlIGxh
cmdlc3QgZXh0ZW50IGRvZXMgbm90IG5lZWQgdG8gaW5pdGlhbGl6ZSBhCj4+Pj4+PiBjb3JyZXNw
b25kaW5nIGV4dGVudF9ub2RlLCByZWR1Y2luZyBtZW1vcnkgZm9vdHByaW50Lgo+Pj4+Pj4KPj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IFlvbmdwZW5nIFlhbmcgPHlhbmd5b25ncGVuZ0B4aWFvbWkuY29t
Pgo+Pj4+Pj4gLS0tCj4+Pj4+PiDCoCBmcy9mMmZzL2V4dGVudF9jYWNoZS5jIHwgMTggKy0tLS0t
LS0tLS0tLS0tLS0tCj4+Pj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE3
IGRlbGV0aW9ucygtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2V4dGVudF9j
YWNoZS5jIGIvZnMvZjJmcy9leHRlbnRfY2FjaGUuYwo+Pj4+Pj4gaW5kZXggYWEzNjhhMDFiMDM1
Li5mOGQ5NGRiNjBkYzYgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9mcy9mMmZzL2V4dGVudF9jYWNoZS5j
Cj4+Pj4+PiArKysgYi9mcy9mMmZzL2V4dGVudF9jYWNoZS5jCj4+Pj4+PiBAQCAtNDEwLDEwICs0
MTAsOCBAQCBzdGF0aWMgdm9pZCBfX2Ryb3BfbGFyZ2VzdF9leHRlbnQoc3RydWN0Cj4+Pj4+PiBl
eHRlbnRfdHJlZSAqZXQsCj4+Pj4+PiDCoCB2b2lkIGYyZnNfaW5pdF9yZWFkX2V4dGVudF90cmVl
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdAo+Pj4+Pj4gZm9saW8gKmlmb2xpbykKPj4+Pj4+
IMKgIHsKPj4+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpID0gRjJGU19J
X1NCKGlub2RlKTsKPj4+Pj4+IC3CoMKgwqAgc3RydWN0IGV4dGVudF90cmVlX2luZm8gKmV0aSA9
ICZzYmktPmV4dGVudF90cmVlW0VYX1JFQURdOwo+Pj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZjJm
c19leHRlbnQgKmlfZXh0ID0gJkYyRlNfSU5PREUoaWZvbGlvKS0+aV9leHQ7Cj4+Pj4+PiDCoMKg
wqDCoMKgIHN0cnVjdCBleHRlbnRfdHJlZSAqZXQ7Cj4+Pj4+PiAtwqDCoMKgIHN0cnVjdCBleHRl
bnRfbm9kZSAqZW47Cj4+Pj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBleHRlbnRfaW5mbyBlaSA9IHsw
fTsKPj4+Pj4+IMKgwqDCoMKgwqAgaWYgKCFfX21heV9leHRlbnRfdHJlZShpbm9kZSwgRVhfUkVB
RCkpIHsKPj4+Pj4+IEBAIC00MzUsMjEgKzQzMyw3IEBAIHZvaWQgZjJmc19pbml0X3JlYWRfZXh0
ZW50X3RyZWUoc3RydWN0IGlub2RlCj4+Pj4+PiAqaW5vZGUsIHN0cnVjdCBmb2xpbyAqaWZvbGlv
KQo+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAoYXRvbWljX3JlYWQoJmV0LT5ub2RlX2NudCkgfHwgIWVp
LmxlbikKPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHNraXA7Cj4+Pj4+PiAtwqDCoMKg
IGlmIChJU19ERVZJQ0VfQUxJQVNJTkcoaW5vZGUpKSB7Cj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAg
ZXQtPmxhcmdlc3QgPSBlaTsKPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIHNraXA7Cj4+Pj4+
PiAtwqDCoMKgIH0KPj4+Pj4+IC0KPj4+Pj4+IC3CoMKgwqAgZW4gPSBfX2F0dGFjaF9leHRlbnRf
bm9kZShzYmksIGV0LCAmZWksIE5VTEwsCj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICZldC0+cm9vdC5yYl9yb290LnJiX25vZGUsIHRydWUpOwo+Pj4+Pj4gLcKgwqDCoCBp
ZiAoZW4pIHsKPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBldC0+bGFyZ2VzdCA9IGVuLT5laTsKPj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoCBldC0+Y2FjaGVkX2VuID0gZW47Cj4+Pj4+PiAtCj4+Pj4+PiAt
wqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZldGktPmV4dGVudF9sb2NrKTsKPj4+Pj4+IC3CoMKg
wqDCoMKgwqDCoCBsaXN0X2FkZF90YWlsKCZlbi0+bGlzdCwgJmV0aS0+ZXh0ZW50X2xpc3QpOwo+
Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZldGktPmV4dGVudF9sb2NrKTsKPj4+
Pj4+IC3CoMKgwqAgfQo+Pj4+Pj4gK8KgwqDCoCBldC0+bGFyZ2VzdCA9IGVpOwo+Pj4+Pgo+Pj4+
PiBQcmV2aW91c2x5LCB3ZSBjYW4gc3BsaXQgbGFyZ2VzdCBleHRlbnQgbm9kZSB0byB0d28gaWYg
d2UgcHVuY2hlZAo+Pj4+PiBpdCwgbm93Cj4+Pj4+IHdlIGNhbiBub3Q/IElJVUMuCj4+Pj4KPj4+
PiBQcmlvciB0byB0aGlzIGNoYW5nZSwgdGhlIGxhcmdlc3QgZXh0ZW50IGNvdWxkIGFsc28gYmUg
c2hydW5rLCBzbyB0aGUKPj4+PiBzZXQgb2Ygc2NlbmFyaW9zIHRoYXQgbmVlZCBoYW5kbGluZyBk
dXJpbmcgcHVuY2ggcmVtYWlucyBpZGVudGljYWwKPj4+PiBiZWZvcmUgYW5kIGFmdGVyIHRoZSBt
b2RpZmljYXRpb24uCj4+Pj4KPj4+PiBGb3IgdGhlIGxhcmdlc3QgZXh0ZW50LCBpdCBvbmx5IG5l
ZWRzIHRvIGd1YXJhbnRlZSB0aGF0IHRoZSBtYXBwaW5nCj4+Pj4gaW5mb3JtYXRpb24gaXQgcmVj
b3JkcyBzdGF5cyBjb25zaXN0ZW50IHdpdGggdGhlIG1hcHBpbmdzIHRyYWNrZWQgaW4KPj4+PiB0
aGUKPj4+PiBleHRlbnQgdHJlZSBhbmQgbXVsdGktbGV2ZWwgaW5kaXJlY3QgaW5kaWNlcy4gVGhl
IHB1bmNoIG9wZXJhdGlvbiBkb2VzCj4+Pj4gbm90IGJyZWFrIHRoaXMgY29uc2lzdGVuY3kuIE1v
cmVvdmVyLCB0aGUgbGFyZ2VzdCBleHRlbnQgaXMgbm90Cj4+Pj4gcmVxdWlyZWQKPj4+PiB0byBi
ZSB0aGUgbG9uZ2VzdCBleHRlbnQgYW1vbmcgYWxsIGVudHJpZXMgaW4gdGhlIGV4dGVudCB0cmVl
LiBJdAo+Pj4+IG1lcmVseQo+Pj4+IG5lZWRzIHRvIG1hdGNoIHRoZSBtYXBwaW5ncyBzdG9yZWQg
aW4gbXVsdGktbGV2ZWwgaW5kaXJlY3QgaW5kaWNlcyBhbmQKPj4+PiBiZSBubyBzbWFsbGVyIHRo
YW4gdGhlIG1heGltdW0gZXh0ZW50IHByZXNlbnQgaW4gdGhlIGV4dGVudCB0cmVlLgo+Pj4KPj4+
IFdoYXQgSSBtZWFudCBpczogZS5nLiBwcmV2aW91c2x5LCBpZiBsYXJnZXN0IGV4dGVudCBpcyAx
MDI0LCBwdW5jaGluZwo+Pj4gaW4gdGhlCj4+PiBtaWRkbGUgb2YgdGhlIGV4dGVudCB3aWxsIG1h
a2UgaXQgYmVpbmcgc3BsaXQgdG8gdHdvIGV4dGVudHMgKDUxMiwKPj4+IDUxMSkgaW4KPj4+IF9f
dXBkYXRlX2V4dGVudF90cmVlX3JhbmdlKCkuCj4+Pgo+Pj4gSWYgd2UgZG8gbm90IGFkZCBsYXJn
ZXN0IGV4dGVudCBub2RlIGludG8gcmIgdHJlZSBpbgo+Pj4gZjJmc19pbml0X3JlYWRfZXh0ZW50
X3RyZWUoKSwKPj4+IHRoZW4gd2UgbWF5IGhhcyBubyBjaGFuY2UgdG8ga2VlcCBzbWFsbC1zaXpl
ZCg1MTEpIGV4dGVudCBpbiBhYm92ZQo+Pj4gcHVuY2ggc2NlbmFyaW8sCj4+PiBjYW4geW91IHZl
cmlmeSB0aGF0Pwo+Pgo+PiBZZXMsIHRoZSA1MTEtYmxvY2sgbWFwcGluZyB3aWxsIGJlIGRyb3Bw
ZWQuIEkgY29uc2lkZXJlZCB0aGlzIGNhc2UKPj4gZWFybGllcjogd2hlbiB0aGUgbmV3bHkgaW5z
ZXJ0ZWQgbWFwcGluZyBvdmVybGFwcyB3aXRoIG9yIGFkamFjZW50Cj4+IHdpdGggdGhlIGxhcmdl
c3QgZXh0ZW50LCB3ZSByZWluc2VydCB0aGUgbGFyZ2VzdCBleHRlbnQgYmFjayBpbnRvIHRoZQo+
PiBleHRlbnQgdHJlZS4gV2l0aCB0aGlzIGxvZ2ljLCB0aGUgNTExLWJsb2NrIHNwbGl0IGV4dGVu
dCB3aWxsIHJlbWFpbgo+PiBwcmVzZW50IGluIHRoZSBleHRlbnQgdHJlZS4gSW5zdGVhZCBvZiBw
ZXJmb3JtaW5nIHB1bmNoIGhhbmRsaW5nIG9uCj4+IHRoZSBsYXJnZXN0IGV4dGVudCwgd2UgY2Fu
IHNpbXBseSBkcm9wIGl0IGRpcmVjdGx5Lgo+PiBIb3dldmVyLCB0aGlzIGFwcHJvYWNoIGRvZXMg
bm90IHdvcmsgd2VsbCBmb3IgdXBkYXRlcyB0YXJnZXRpbmcgdGhlCj4+IHRhaWwgb2YgdGhlIG9y
aWdpbmFsIGV4dGVudC4gRm9yIGluc3RhbmNlLCBwdW5jaCAxMDI0IGludG8gMTAyMiBhbmQgMQo+
PiBmb3Igb3ZlcndyaXRlIGNhc2UsIHdoaWNoIHdpbGwgYWxzbyBhbGxvYyBvbmUgbW9yZSBleHRl
bnRfbm9kZS4KPiAKPiBXZSB3aWxsIG9ubHkgYWRkIGV4dGVudCB3aGljaCBoYXMgc2l6ZSA+PSBG
MkZTX01JTl9FWFRFTlRfTEVOLCBzbyAxMDIyCj4gd2lsbCBiZSBhZGRlZCwgYW5kIDEgd2lsbCBi
ZSBkcm9wcGVkLgoKT2gsIHllcywgdGhpcyBleGFtcGxlIGlzIG5vdCBhcHByb3ByaWF0ZS4gRG8g
eW91IHRoaW5rIHRoaXMgYXBwcm9hY2gKd291bGQgYmUgYmV0dGVyLCBvciBpcyBbUEFUQ0ggMS81
XSBhbmQgW1BBVENIIDMvNV0gcHJlZmVyYWJsZT8KClRoYW5rcwpZb25ncGVuZywKCj4gCj4gVGhh
bmtzLAo+IAo+Pgo+PiBUaGFua3MKPj4gWW9uZ3BlbmcsCj4+Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4K
Pj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+IFlvbmdwZW5nLAo+Pj4+Cj4+Pj4KPj4+Pj4KPj4+Pj4gVGhh
bmtzLAo+Pj4+Pgo+Pj4+Pj4gwqAgc2tpcDoKPj4+Pj4+IMKgwqDCoMKgwqAgLyogTGV0J3MgZHJv
cCwgaWYgY2hlY2twb2ludCBnb3QgY29ycnVwdGVkLiAqLwo+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAo
ZjJmc19jcF9lcnJvcihzYmkpKSB7Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4+IExpbnV4LWYyZnMtZGV2
ZWwgbWFpbGluZyBsaXN0Cj4+Pj4+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cj4+Pj4+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwKPj4+Pgo+Pj4KPj4+Cj4+Pgo+Pj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0Cj4+PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+Pj4gaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo+
Pgo+IAo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
