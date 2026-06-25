Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2352CDB466
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:From:References:To:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H3lvG3Um817DxePPP/PSyNkwdXq0nrduQw2Aj8gmnic=; b=gn3NLjgoYhyI3amosq3BdMsbFR
	oifGE02ZibCAU+hiYZKtp94X9ZtSdvqKMPItL0B6LPCOMN0kk6qmCbULiazrDPaPl8MKFLE5jk6ww
	VTe8trqCJmYMYkVl7FUGxRY5rLA0cKzOHwoTCTyP2pMM0xCFgvtfrWp7DeCQjKr+4VpE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcfHk-0006Dt-4b;
	Thu, 25 Jun 2026 08:18:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@outlook.com>)
 id 1wcfHi-0006Dl-PN for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 08:18:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8avRn0xas+b5Spf9JLlK5ipn/nqUprbwKIqypkdZe4g=; b=mwsgGggioTE6c9qARXwDsvuMiw
 02QCOYV999pRjzoh0WnUNizomAKeG5qUpFk+25HR8nxk7uy7J/px0GddTv0qR5wL5xwl7elBTKktn
 i1U3jMbbH8ZjEEk6wwZXbxrQRw6Azh8WhHsx2a69ocqYXRplCMM7BJ6rRMS1h0+E+xsc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8avRn0xas+b5Spf9JLlK5ipn/nqUprbwKIqypkdZe4g=; b=fXo88wxDlpNt3l3euScENDVPkB
 CC+xYgAYk5d8R63O0yZBw9koaXxEsdkqPJFiBKAeSpNXeJ0JK/bIpb/MkjbnFXp07E+SC4BYrahwI
 E38VqaqCkg3szSlrI8wqtxxex2PnIk4Mi2+ZlNgrAlPqm0kcpB+gvDJNRmoAAAm8FlOc=;
Received: from mail-japaneastazolkn19013077.outbound.protection.outlook.com
 ([52.103.43.77] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcfHh-00083M-EM for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 08:18:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzEpiUmQxUaGKDmgVpPQVnpemm1lsSmA90wkTe2iAR65JyFvJhxW9teHWWWqrtbqa5FOHwfyW514cCyQ+zzkMw+nsLwe8ND3ZhqTJb7NF0n4Ai40D7COhRvBAalOg8zVrfqWrzbHZSTwsscsML2S0oaN2Ud+uTVrw5Ji+c2Ihr6ylV1uN8Ab9X9NbkeFJ+ZbzXoecsOvuVBkFLpn6OXaUNrhIFCML6sYuo55131XZNjK1s7a5qR71Q0zYIWMUMGJBEPHCFm9XJSW9E24ht6FOo5OREmhgPa9xNrAY4xCzrqkd/wiN2QsxLyURlYGr5tTxFTXmL+AQrp6QJe1zwiMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8avRn0xas+b5Spf9JLlK5ipn/nqUprbwKIqypkdZe4g=;
 b=stCmLuMUjhSYBRVZU2fA1j3gcLfoqTP+oLGdj6jEDMmHg68+uikByqB92JpBLWlEdCnEcgxDvXuJ+lCCIDnxsaLk09Q2WrPTJdN0jh2LId4mLTrmy7Zhi9ESM1tr9xBs1shKbKy0/yQGI+d3YolXxVRBkPh7if8ewSQBkaM/abHg9Xnk7XHJfgEwmi8HPv8ZwKLvV2bVH+mE3FNFEYGJYdJjE+59J8voI4iR+0oGHDlikbHSBzMjz5VvnPK6HckcVJ00rq+zoMlavbSQsSZE5vilpuPL54uYnp0S1+r1akZ/+yhD/qXy+znh/EDIjUoFeZQR2VabJhZ00rTKTHQXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8avRn0xas+b5Spf9JLlK5ipn/nqUprbwKIqypkdZe4g=;
 b=mILCmcodgRWKc6M6e78G65t2+W0LGi6GOst2BucGZcR+l4AFKGZ8r5dQD1cvbeIDDnh/rIlme8Ha+MRSJ4rxgRB+yPyAZz1pz2szuh/JAFEvxt3klFWIvUldoZicuQLDJanQyv0GTJkvGUW43SBWMH0zAPJ3PLxWPPYJeqRo53wjUik9z/0sY2Fb7oexIo3wPaRBXZMI3oIgBh/cr23Oql/KgW50v6FZ5we3ySZ4UAcSeVXaJ8rz+6Yly2maA3G+NUjQH2sTXQkMzg/0eZKoYIJxODwSfnfLJp2YomOXstRnvIjxCj7xM+4abmOfWqdjCUAH6uTygnYHTN2+QmQYMw==
Received: from SEZPR02MB5662.apcprd02.prod.outlook.com (2603:1096:101:4e::13)
 by KUZPR02MB8762.apcprd02.prod.outlook.com (2603:1096:d10:2d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 08:17:56 +0000
Received: from SEZPR02MB5662.apcprd02.prod.outlook.com
 ([fe80::e4bc:d995:70f6:5b72]) by SEZPR02MB5662.apcprd02.prod.outlook.com
 ([fe80::e4bc:d995:70f6:5b72%6]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 08:17:56 +0000
Message-ID: <SEZPR02MB56623728F9B6E6D6CBDE9C9299EC2@SEZPR02MB5662.apcprd02.prod.outlook.com>
Date: Thu, 25 Jun 2026 16:17:52 +0800
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260612115839.2065903-2-yangyongpeng.storage@gmail.com>
 <20260612115839.2065903-4-yangyongpeng.storage@gmail.com>
 <b380cd69-66db-4ef1-8d33-92ed6c34d263@kernel.org>
 <SEZPR02MB566231EECF99FCD70B8E410F99E22@SEZPR02MB5662.apcprd02.prod.outlook.com>
 <462ef62b-d83c-463f-8f44-4843ac179c2f@kernel.org>
 <SEZPR02MB56622CEC6B0C1B8E320262DE99E02@SEZPR02MB5662.apcprd02.prod.outlook.com>
 <7cad39b2-b822-4c0a-81c0-03e37b8334ef@kernel.org>
 <SEZPR02MB566274C1A81B5BCA484B0DE999EE2@SEZPR02MB5662.apcprd02.prod.outlook.com>
 <51d8c58c-07b8-438a-8b42-89b05a8d7472@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <51d8c58c-07b8-438a-8b42-89b05a8d7472@kernel.org>
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To SEZPR02MB5662.apcprd02.prod.outlook.com
 (2603:1096:101:4e::13)
X-Microsoft-Original-Message-ID: <a6b5a959-f9d9-4900-87d8-dfa551b2fd1a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5662:EE_|KUZPR02MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9ff0b5-164e-44f5-7ec4-08ded2924299
X-MS-Exchange-SLBlob-MailProps: vuaKsetfIZn9IFDOZRHBr3PkJ6iE+FIkOM3L7kH8PFxmRXXyP2A8WEzo3aU8cTM3SYL6U4wkP1Bte4uhJaWrU4xJWfE3gMCQHVKbCnSxLLZXAVMovuSAlKbc0qmTmgstEieCyPsOivoSm0ZrxFMceLRbnuRAA8sW7HEyndSzh5UjqDoVZsTgR/DjoWosI10MaWrl7Izu7dZlI7cadeRFiTV8+mABGFh7N8B+G1BZcZrKM1nUAJj8w91l4BYyAd3xsyHoUx3TYry+M5kTWYsynlYN2rcPbvV0OjBpPh9EDcvBw130rL8vu4Bm1IjKIPPhaRN+1a7l+qT3wabLN33G8EzoxJEeFcKgbLT1lT3HuNLdIS6cUSdV8QkajdAy0oJ0i5d+81f3IxbzvsD3yl9WeTrFbHCTGmuWC+qpuj/sXLyQpdxEZLA65WDp9fuiI6Gtbw8rw7WW6du6GqHlPYMXqWMGquWQxdeN9c7yWDJKT+cfm8nGb0Xc45dkw/pBrCJ25XTnRDQ74qRBD9hCI0xwgOmYuxbIJnPTMhwzM/kTh1/dXcP6uyuG57VoC2yoQkpC0wyC2+TguGvcX2Wab73mJdNRdS8HOkkz6vx7J0LTBNi4S7UbOWj3C1qht8ODJEnTBLrejP2EsPV4AuysYhEqCE56hZ4pPhFRPOjMMRwVXOZ49AYrwmXLaqgf3lXF0vvvTSeLLPphWpG2qC0OUwXWjUf5/iIogNAgJ3P3QevmStG4Ncxpphg9pEwk7yggLrKNJ4dD0bCBXBAnU0xJMBm3SaYmS//36nGMkVo0jqGi0IiuXKoDSiFzouYxFyg5cGc7
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|22091999003|24121999003|5072599009|25010399006|7042599007|45011099003|51005399006|41001999006|6090799003|23021999003|15080799012|19110799012|8060799015|12091999003|3412199025|440099028|10035399007|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1IySjBQNDZnRnBKV2tFaXlqZkF6bGRKejNGTDYvbHBxL1Y5VFNVakRHaDRR?=
 =?utf-8?B?Nnp5SmNJSGh1dVBnQklXZ2trNnZCRHNyWDRHZVBVWm9CWXZxT0s2czJSVW9k?=
 =?utf-8?B?S0ZnRHFSbXJzVWlUMTFTNWhRTDZzM2JlbzI4SHlmWHI0WEFOeFNLcXlPY2xa?=
 =?utf-8?B?c3p0M3FhcE9Wa1B4ek1YU2xZbVlaYnBIa0N5NkJWWjg0OWdtQi82UHk2Zk1T?=
 =?utf-8?B?bE1mVWYreGRiUTJKTWtKZHh1MHhzbW5TZkFRUyttU1BMNVUrbitDa2szVHVV?=
 =?utf-8?B?RTQ2cStWcHZMYkdyQ2w3RUhzdUxYR3A5NEVmVVJ4ekM0VGF4VHY5TjhDUmNM?=
 =?utf-8?B?VWRKVEdVTGVrVWl4ZFNhMlFrdzF5K0Z3NnhLTC9oS0hnbXNIc3VmNm1KS0xo?=
 =?utf-8?B?aVMwa3NwKzNUSUVIemRKRzRMK1FmZSt0QzRwazlqNkwxNERoeVQ2M0dVQjNa?=
 =?utf-8?B?cy9uMC9VQWRGTklIV0w5eGd6RlpqRTl4RU8yMFJBcno5WlpZSzRwYWtyckJS?=
 =?utf-8?B?Z0xZU1NaeGVKYW5rdm81N3l1aVZSNHZ4eEFJVFcwTm9DeHhCYjQrUjJMUmh2?=
 =?utf-8?B?bWpNWHJsR2x0R3JRait2MnZONjhXeVNKVmp6RjhuQUdwbFNjZEhZaEUwU2Ny?=
 =?utf-8?B?Y3N3NDFlc0ZtL2xUMjUrRWh1UUpacjdqQWpuZmZZZFdXNDZCYlNPTXZpdit5?=
 =?utf-8?B?cTFVTFZJREg1aWVZcjQ2TEdKNytsMHF6d3Vna0FrT2prdEMrVDZLQmRSUG4z?=
 =?utf-8?B?SDdpZXd0U3VHQ2MrU2RWSmJkRnBpKzJSOFIxM2xMeWhVRUg1V1hoTmFoRTla?=
 =?utf-8?B?dUV2U0tFTldsd2hMUjg3b2ZQY2NjeFA1anc4dEhRS3J1aWh0cStSUVRFcVU2?=
 =?utf-8?B?UTFVbmcvMmlSbzhRaEdPZXFUYWhIc1Q0RHdGNG15T1hWdGtGTm4yVVJQSml0?=
 =?utf-8?B?UEpBNDc5NHVOR2UrMWc5cVdaSWRVQVNReWZvaUlERXBjdlNvNTJjdzlqZXRQ?=
 =?utf-8?B?ZzRaSmR3VmhGWnZMc3E2WEFGUTlSSU83QjU2RHlrbms3dERoWU9JbktxaHFr?=
 =?utf-8?B?RVo2c0ZDYlZ2M2lRdmliTGxZZ1BDV1JObnZ3R2xBZmNLWjE2MEZQdTNselNn?=
 =?utf-8?B?TTUra2tFTWdtRVNVcElMaEF5aHN2Q1A1YjU2eG1QOTZtQmhFR01zbmoxYThm?=
 =?utf-8?B?VHhEU00wSG1CUjNSQXQ0M1JQcktkcHBkS1RZVXcyQ3ZFYWNnMkpCazk2ZG1i?=
 =?utf-8?B?Nzhsb0NxL2VYenZVUStBRlR1Unk1Z1JRaTZCVWljbzFSMGt3ZXVBUnRKSW50?=
 =?utf-8?B?S3o0QVpyRlcyMksydUZadmNQc2haZ1UwVmlDQ0pBVGpvblg4dGF1UnR0M05D?=
 =?utf-8?B?VERhRk9Ed1FwL2NQVUdFWTVUeERma0pHMHdQeHNHOWFjR1dJTVRrajZSWXdm?=
 =?utf-8?B?OXAzSlR6czlMY1poTU1zejRQQmFVcjgwcjJkVzMrQjI1MG81YVhwbmExcnR5?=
 =?utf-8?B?VnRxQUx6ZXlHYllSYk1Nb1Nwd3ptNThPSzNsUkpIeGRoN1NLakxBZ2dkamIv?=
 =?utf-8?Q?99z2t6zrci8ZpIhSv2LcCnMZWMmzcm/KUKkbWh3fcI4ooB?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FYZnNWSTV5d2N1ZjlyZk5nd1FpS3I5WGVlS1RqUEpJR3pWVTRvTldpRjgx?=
 =?utf-8?B?b01CdEZVcm5lQ0lDWUp3VTczNndlblVhYllQSGNtNjQ3UWlNRHpUWThlWmNY?=
 =?utf-8?B?YjlKNTNzZzdSNDlnTU1RV3FkbjRBc0JTRUJPNjM4aWI1amV4K1Rhdjh2WTEv?=
 =?utf-8?B?R3AyUnk0KzJ5eitrTUE2c3czL3E2M09iQ3I0eG12M3BRRDM2TzlYQU8xYkdY?=
 =?utf-8?B?ZFBFek1NWVltWExkTFA3R1RCRW43dGR5czh3VkF4cER5T21oRm96RldnVjlR?=
 =?utf-8?B?UVlVd25XL2t6T0xvZ2JoSnFmdDdxS05Sd29rOXlUS1ZrTUtpVXNOQ3phOFE0?=
 =?utf-8?B?S0dVMEtUdUwwRzd0WHlJYUlmRjM4aVNINU9UMGRDVmtMeGtRSk53R3pYU0la?=
 =?utf-8?B?eTZ0YkQzYTkyaC84TVJsR3NDN3FRQXJKdGMrL2FjQnFtRFlma2dLaFhuZWND?=
 =?utf-8?B?NTBOK0FNWmhuOHJFbXA2U0xNbVZGano0RTJ0UmdLamloMlI1MVNiWVBVSUlP?=
 =?utf-8?B?MlpsR09pT3VCalhSRk94ZFZqc3g5a24rak9pVWs2RG5vUUpsT3lGY3R5eEF0?=
 =?utf-8?B?eGsydm5GU0dBeTEycTZveGFGcmJpR3l4U1N3YlVvb1M0d1hxd1J2cDJvL1pz?=
 =?utf-8?B?cnIwYzdhSklqNFJ1NHVadVUrWFIyWFZiZmtod0tRQUFMY2diL1B5eDhTMUxq?=
 =?utf-8?B?UTR5N0FpOW94eGZzUVJuTFJzT0c0UUx4TDRmOWNleFhTdWpvVjZVRWw4WmZt?=
 =?utf-8?B?L2FtNlJUZkRmRlM5UG90NWpaSTZIeWJReTBaU0FVR1RBY2tiSEw3cnVIUmRF?=
 =?utf-8?B?SjNXeW1wdy8rZUFLbktHWVFoUkxBQzhoaTUwWjJncEFFaG5rOFB3YVJieUtQ?=
 =?utf-8?B?clAvb3pwSCt2YmZyUmFMUjZJR2VhbVFXQm1QV1l0MnhsS3pHdVhialF3SlJz?=
 =?utf-8?B?OHprY2ErVHRDZDhhQnRkeFdRekJhb1dycXdLVEpWM2pJT2RMdTF3bWtIL1dX?=
 =?utf-8?B?SEZoVzdaQkpJbGNJWWx4S0VHb3dUYWUzb2w2UUlLSGt2YVdIYk9vUHg5aE5m?=
 =?utf-8?B?QkZxR21RQll0UGoyK3FpcWVjWnRwZVJmK1gvdWowU0dzUHk2YUc0Z0tKeUhX?=
 =?utf-8?B?UUlWUWhtblU5SG83T0NOa2s3Unp5dVRabWsxWkh4ZHNnM2hrRkt0N1c1WlI0?=
 =?utf-8?B?MGQ1Vkcrem5udmtsSEFMeER4UUF3YjgwWlVwYzRGb25TbmtRelppNWZMakM1?=
 =?utf-8?B?U1ZYK2IxVXd6OEhBU01IYzZqMzlUYkwyb3JoS2JCWVpUQ0p6RmRFeEsveWZj?=
 =?utf-8?B?M1VnZjdEUnVKQjBLZSt1MlhnbkRwOENXMDBXMGZhekZrU0kyS0MwUDJxTTFV?=
 =?utf-8?B?K0VJcmdWS1NCTUtrZFNxQ1NrWFFldVJ0K3lCTkFHclRCcG1iMVE5SUJjVVpH?=
 =?utf-8?B?aU1rWkFlMlZhTzdIREJ0NGUwSFpBWHlFQVd3WEc0bDVYcGNlaWRTbnhZcXNa?=
 =?utf-8?B?bmt5dE5IRndwdGREQzV2RFoxZnpsMExjY1RHYUIrL0JGOG1WLzRRNkk3R0RU?=
 =?utf-8?B?T1FKZUxFVjVvRjlzeXJ5d2JJL21XMDdyQjQwUXFXaXJ4eHo2M1BUMWd1NnRy?=
 =?utf-8?B?Y2QxMk5EMDJ5YmVOTlJnVXl5eUcxTC9md1VrVXlPYXNNTDZlVWpOTFlBaTlK?=
 =?utf-8?B?U3VXTkxvcHRkakMwaFRRYkZlTitoMUV1azVrOXJiL0xHcmxYTVpLVCtPc0FS?=
 =?utf-8?B?U2hhQ29XUFF0K05aMVVVb2VtRUViN2FMb0tabWtQUlJQeDdoSmxvNkV4b0RJ?=
 =?utf-8?B?bUNBdE8zUEJFOGx2WGpkL1ROdGtHRHV5L3VPaW5PbnRVL3ZFM1A2TU9OaWMv?=
 =?utf-8?B?SGNNOEFHWG0yUHpCbDB2dzhsU2RpYWd0clJhUDlQdTBDbGw0T3BlWUhlMER6?=
 =?utf-8?Q?6wwXiAB7DD0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9ff0b5-164e-44f5-7ec4-08ded2924299
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5662.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:17:56.1561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB8762
X-Headers-End: 1wcfHh-00083M-EM
Subject: Re: [f2fs-dev] [PATCH RESEND 3/5] f2fs: punch largest extent
 instead of dropping it entirely on overlap
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

Ck9uIDYvMjUvMjYgMTU6NDksIENoYW8gWXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwgd3JvdGU6Cj4g
T24gNi8yMy8yNiAxNzozMSwgWW9uZ3BlbmcgWWFuZyB3cm90ZToKPj4KPj4gT24gNi8yMi8yNiAw
ODo0NSwgQ2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCB3cm90ZToKPj4+IE9uIDYvMjIvMjYg
MDA6MDcsIFlvbmdwZW5nIFlhbmcgd3JvdGU6Cj4+Pj4KPj4+PiBPbiA2LzIwLzI2IDI6MTUgUE0s
IENoYW8gWXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwgd3JvdGU6Cj4+Pj4+IE9uIDYvMTkvMjYgMjI6
MzgsIFlvbmdwZW5nIFlhbmcgd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4gT24gNi8xNS8yNiA4OjA1IFBN
LCBDaGFvIFl1IHZpYSBMaW51eC1mMmZzLWRldmVsIHdyb3RlOgo+Pj4+Pj4+IE9uIDYvMTIvMjYg
MTk6NTgsIFlvbmdwZW5nIFlhbmcgd3JvdGU6Cj4+Pj4+Pj4+IEZyb206IFlvbmdwZW5nIFlhbmcg
PHlhbmd5b25ncGVuZ0B4aWFvbWkuY29tPgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBQcmV2aW91c2x5LCB3
aGVuIGFuIGV4dGVudCBiZWluZyBpbnNlcnRlZCBvdmVybGFwcyB3aXRoIHRoZSBsYXJnZXN0Cj4+
Pj4+Pj4+IGV4dGVudCwgdGhlIGxhcmdlc3QgZXh0ZW50IGlzIGRyb3BwZWQgZW50aXJlbHkuIFRo
aXMgd2FzIGRvbmUgdG8KPj4+Pj4+Pj4gaGFuZGxlCj4+Pj4+Pj4KPj4+Pj4+PiBQbGVhc2UgY29y
cmVjdCBtZSBpZiBJIG1pc3NlZCBhbnl0aGluZywgSSByZW1lbWJlciB0aGF0IHdlIHdpbGwgYWRk
Cj4+Pj4+Pj4gbGFyZ2VzdAo+Pj4+Pj4+IGV4dGVudCBpbiBiZWxvdyBwYXRoPwo+Pj4+Pj4+Cj4+
Pj4+Pj4gLSBfX3VwZGF0ZV9leHRlbnRfdHJlZV9yYW5nZQo+Pj4+Pj4+IMKgIC0gX19pbnNlcnRf
ZXh0ZW50X3RyZWUKPj4+Pj4+PiDCoMKgIC0gX190cnlfdXBkYXRlX2xhcmdlc3RfZXh0ZW50IDog
dXBkYXRlIGxhcmdlc3Qgdy8gcmlnaHQgZXh0ZW50Cj4+Pj4+Pj4gwqAgLSBfX3RyeV91cGRhdGVf
bGFyZ2VzdF9leHRlbnQgOiB1cGRhdGUgbGFyZ2VzdCB3LyBsZWZ0IGV4dGVudAo+Pj4+Pj4KPj4+
Pj4+IFRoZSBsYXJnZXN0IGV4dGVudCBtaWdodCBub3QgcmVzaWRlIGluIHRoZSBleHRlbnQgdHJl
ZS4gSWYKPj4+Pj4+IF9fdXBkYXRlX2V4dGVudF90cmVlX3JhbmdlIGludm9rZXMgX19kcm9wX2xh
cmdlc3RfZXh0ZW50LCB0aGUgbGVuZ3RoIG9mCj4+Pj4+Cj4+Pj4+IEkgbWVhbnQgX191cGRhdGVf
ZXh0ZW50X3RyZWVfcmFuZ2UgaW52b2tlcyBfX2Ryb3BfbGFyZ2VzdF9leHRlbnQgdG8gZHJvcAo+
Pj4+PiBsYXJnZXN0IGZpcnN0LCBhbmQgdGhlbiwgaXQgdHJpZXMgdG8gdXBkYXRlIGxhcmdlc3Qg
ZXh0ZW50IHcvIGxhcmdlci0KPj4+Pj4gc2l6ZQo+Pj4+PiBvbmUgb2Ygc2VwYXJhdGVkIHR3byBl
eHRlbnRzLgo+Pj4+Pgo+Pj4+Pj4gdGhlIGxhcmdlc3QgZXh0ZW50IHdpbGwgaGF2ZSBiZWVuIHNl
dCB0byB6ZXJvLiBBcyBhIHJlc3VsdCwgdGhlIGxhcmdlc3QKPj4+Pj4+IGV4dGVudCB1cGRhdGVk
IGluc2lkZSBfX3RyeV91cGRhdGVfbGFyZ2VzdF9leHRlbnQgY2FuIGVuZCB1cCBzbWFsbGVyCj4+
Pj4+PiB0aGFuIHRoZSBsYXJnZXN0IGV4dGVudCBvYnRhaW5lZCBhZnRlciBfX3B1bmNoX2xhcmdl
c3RfZXh0ZW50IGNvbXBsZXRlcwo+Pj4+Pj4gaXRzIHB1bmNoIG9wZXJhdGlvbi4KPj4+Pj4KPj4+
Pj4gSSBkaWRuJ3QgZ2V0IGl0LCBjYW4geW91IGdpdmUgYW4gZXhhbXBsZSBmb3IgdGhpcz8KPj4+
Pgo+Pj4+IFRoZSBvbmx5IGRpc3RpbmN0aW9uIGJldHdlZW4gcHVuY2ggYW5kIGRyb3AgYXJpc2Vz
IHdoZW4gdGhlIGxhcmdlc3QKPj4+PiBleHRlbnQgaXMgbm90IHByZXNlbnQgaW4gdGhlIGV4dGVu
dCB0cmVlLgo+Pj4+Cj4+Pj4gQmVmb3JlIHRoaXMgcGF0Y2goZXh0ZW50IGZvcm1hdCBbZm9mcywg
bGVuLCBibGtdKQo+Pj4+IDEuIGluaXRhbCBzdGF0ZQo+Pj4+IMKgwqDCoMKgIGxhcmdlc3QgZXh0
ZW50OiBbMCwgMTAyNCwgMTBdLCBleHRlbnQgdHJlZTogZW1wdHkKPj4+Cj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5eXl5eCj4+Pgo+Pj4gSXQncyBub3Qg
ZW1wdHkgdy9vIHBhdGNoIDIvNS4KPj4KPj4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24uICJlbXB0
eSIgbWVhbnMgdGhhdCB0aGUgbGFyZ2VzdCBleHRlbnQgaGFzIGJlZW4KPj4gc2hydW5rLgo+IAo+
IE9rYXksCj4gCj4gSG1tLi4uSSBmb3VuZCBpdCdzIGhhcmQgdG8gcmVwcm9kdWNlIHN1Y2ggY29u
ZGl0aW9uICJvbmx5IHNocmluayBleHRlbnQgc2xhYgo+IGNhY2hlIGFuZCBrZWVwIGlub2RlIHNs
YWIgY2FjaGUiLCBzbyBJIHdvbmRlciBob3cgY29tbW9uIHRoaXMgaXNzdWUgd2lsbCBiZQo+IGlu
IHByb2R1Y3QuCj4gCj4gSGF2ZSB5b3Ugc3VmZmVyZWQgcmVhbCBpc3N1ZXMgaW4gcHJvZHVjdD8g
b3IganVzdCBpbnNpZ2h0IGZyb20gTExNIG9yIGNvZGUKPiByZXZpZXc/CgpJIHdhcyBhYmxlIHRv
IHJlcHJvZHVjZSBjYXNlcyB3aGVyZSB0aGUgbGFyZ2VzdCBleHRlbnQgd2FzIHNocnVuaywgYW5k
CnRoZW4gYSA0SyBvdmVyd3JpdGUgb24gdGhhdCBsYXJnZXN0IGV4dGVudCBjYXVzZWQgaXQgdG8g
YmUgZHJvcHBlZC4gVGhlCnRlc3Qgc2NlbmFyaW8gaXMgcm91Z2hseSBhcyBmb2xsb3dzLCBhbHRo
b3VnaCB0aGUgcmVwcm9kdWN0aW9uIGlzIG5vdAoxMDAlIHJlbGlhYmxlOgoKMS4gQ29uc3RydWN0
IGEgbGFyZ2VzdCBleHRlbnQsIHRoZW4gcGVyZm9ybSBzcGFyc2Ugd3JpdGVzIHRvIG90aGVyCnJl
Z2lvbnMgc28gdGhhdCB0aGUgbGFyZ2VzdCBleHRlbnQgaXMgbmVpdGhlciB1cGRhdGVkIG5vciBh
Y2Nlc3NlZC4KMi4gS2VlcCBhIGJhY2tncm91bmQgdGhyZWFkIGNvbnRpbnVvdXNseSBvcGVuaW5n
IHRoZSBmaWxlIHRvIHByZXZlbnQgdGhlCmlub2RlIGZyb20gYmVpbmcgc2hydW5rLgozLiBUcmln
Z2VyIG1lbW9yeSByZWNsYWltLgo0LiBQZXJmb3JtIGEgNEsgb3ZlcndyaXRlIHdpdGhpbiB0aGUg
bGFyZ2VzdCBleHRlbnQuCgpJIGhhdmUgbm90IG9ic2VydmVkIHRoaXMgaW4gYSBwcm9kdWN0aW9u
IGVudmlyb25tZW50LiBJdCB3YXMgaWRlbnRpZmllZAp0aHJvdWdoIGNvZGUgcmV2aWV3IHdoaWxl
IGludmVzdGlnYXRpbmcgdGhlIGZpeCBmb3IgW1BBVENIIDEvNV0sIGFuZAp0aGVuIHZlcmlmaWVk
IHdpdGggdGhlIGFib3ZlIHRlc3QgY2FzZS4KClRoYW5rcwpZb25ncGVuZywKCj4gCj4gVGhhbmtz
LAo+IAo+Pgo+PiBUaGFua3MKPj4gWW9uZ3BlbmcsCj4+Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4KPj4+
PiAyLiBpbnNlcnQgWzUxMSwgMSwgMTAwMDBdCj4+Pj4gwqDCoMKgwqAgbGFyZ2VzdCBleHRlbnQ6
IFs1MTEsIDEsIDEwMDAwXSwgZXh0ZW50IHRyZWU6IFs1MTEsIDEsIDEwMDAwXQo+Pj4+Cj4+Pj4g
QWZ0ZXIgdGhpcyBwYXRjaDoKPj4+PiAxLiBpbml0YWwgc3RhdGUKPj4+PiDCoMKgwqDCoCBsYXJn
ZXN0IGV4dGVudDogWzAsIDEwMjQsIDEwXSwgZXh0ZW50IHRyZWU6IGVtcHR5Cj4+Pj4gMi4gaW5z
ZXJ0IFs1MTEsIDEsIDEwMDAwXQo+Pj4+IMKgwqDCoMKgIGxhcmdlc3QgZXh0ZW50OiBbNTEyLCA1
MTIsIDUyMl0sIGV4dGVudCB0cmVlOiBbNTExLCAxLCAxMDAwMF0KPj4+Pgo+Pj4+IFRoYW5rcwo+
Pj4+IFlvbmdwZW5nLAo+Pj4+Cj4+Pj4+Cj4+Pj4+IFRoYW5rcywKPj4+Pj4KPj4+Pj4+Cj4+Pj4+
PiBUaGFua3MKPj4+Pj4+IFlvbmdwZW5nLAo+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IFRoYW5rcywK
Pj4+Pj4+Pgo+Pj4+Pj4+PiB0aGUgY2FzZSB3aGVyZSB0aGUgbGFyZ2VzdCBleHRlbnQgaXMgbm90
IGluIG1lbW9yeSwgYXZvaWRpbmcKPj4+Pj4+Pj4gaW5jb25zaXN0ZW5jeSBiZXR3ZWVuIHRoZSBs
YXJnZXN0IGV4dGVudCBhbmQgdGhlIGV4dGVudCB0cmVlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBUaGlz
IHBhdGNoIGNoYW5nZXMgdGhlIHNlbWFudGljcyBvZiBfX2Ryb3BfbGFyZ2VzdF9leHRlbnQgKHJl
bmFtZWQgdG8KPj4+Pj4+Pj4gX19wdW5jaF9sYXJnZXN0X2V4dGVudCk6IGluc3RlYWQgb2YgZGlz
Y2FyZGluZyB0aGUgZW50aXJlIGxhcmdlc3QKPj4+Pj4+Pj4gZXh0ZW50IHdoZW4gYW55IG92ZXJs
YXAgaXMgZGV0ZWN0ZWQsIGtlZXAgdGhlIGxhcmdlciByZW1haW5pbmcKPj4+Pj4+Pj4gcG9ydGlv
bgo+Pj4+Pj4+PiAobGVmdCBvciByaWdodCkgYWZ0ZXIgdGhlIHB1bmNoLiBUaGlzIHByZXNlcnZl
cyBleHRlbnQgY2FjaGUgY292ZXJhZ2UKPj4+Pj4+Pj4gZm9yIHRydW5jYXRlIGFuZCBvdmVyd3Jp
dGUgb3BlcmF0aW9ucyB0aGF0IG9ubHkgcGFydGlhbGx5IG92ZXJsYXAgdGhlCj4+Pj4+Pj4+IGxh
cmdlc3QgZXh0ZW50Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZb25ncGVuZyBZ
YW5nIDx5YW5neW9uZ3BlbmdAeGlhb21pLmNvbT4KPj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+IMKgIGZz
L2YyZnMvZXh0ZW50X2NhY2hlLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
Cj4+Pj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9leHRlbnRfY2FjaGUu
YyBiL2ZzL2YyZnMvZXh0ZW50X2NhY2hlLmMKPj4+Pj4+Pj4gaW5kZXggZjhkOTRkYjYwZGM2Li44
MmQ4NGM0ZTk4YjIgMTAwNjQ0Cj4+Pj4+Pj4+IC0tLSBhL2ZzL2YyZnMvZXh0ZW50X2NhY2hlLmMK
Pj4+Pj4+Pj4gKysrIGIvZnMvZjJmcy9leHRlbnRfY2FjaGUuYwo+Pj4+Pj4+PiBAQCAtMzk3LDE0
ICszOTcsMzEgQEAgc3RhdGljIHVuc2lnbmVkIGludAo+Pj4+Pj4+PiBfX2ZyZWVfZXh0ZW50X3Ry
ZWUoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+Pj4+Pj4+PiDCoMKgwqDCoMKgIHJldHVybiBj
b3VudDsKPj4+Pj4+Pj4gwqAgfQo+Pj4+Pj4+PiAtc3RhdGljIHZvaWQgX19kcm9wX2xhcmdlc3Rf
ZXh0ZW50KHN0cnVjdCBleHRlbnRfdHJlZSAqZXQsCj4+Pj4+Pj4+ICtzdGF0aWMgdm9pZCBfX3B1
bmNoX2xhcmdlc3RfZXh0ZW50KHN0cnVjdCBleHRlbnRfdHJlZSAqZXQsCj4+Pj4+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZ29mZl90IGZvZnMsIHVuc2ln
bmVkIGludCBsZW4pCj4+Pj4+Pj4+IMKgIHsKPj4+Pj4+Pj4gLcKgwqDCoCBpZiAoZm9mcyA8IChw
Z29mZl90KWV0LT5sYXJnZXN0LmZvZnMgKyBldC0+bGFyZ2VzdC5sZW4gJiYKPj4+Pj4+Pj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9mcyArIGxlbiA+IGV0LT5sYXJnZXN0LmZvZnMpIHsKPj4+
Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGV0LT5sYXJnZXN0LmxlbiA9IDA7Cj4+Pj4+Pj4+IC3CoMKg
wqDCoMKgwqDCoCBldC0+bGFyZ2VzdF91cGRhdGVkID0gdHJ1ZTsKPj4+Pj4+Pj4gK8KgwqDCoCB1
bnNpZ25lZCBpbnQgbGFyZ2VzdF9lbmQsIHB1bmNoX2VuZDsKPj4+Pj4+Pj4gK8KgwqDCoCB1bnNp
Z25lZCBpbnQgbGVmdF9sZW4sIHJpZ2h0X2xlbjsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArwqDCoMKg
IGlmIChmb2ZzID49IChwZ29mZl90KWV0LT5sYXJnZXN0LmZvZnMgKyBldC0+bGFyZ2VzdC5sZW4g
fHwKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9mcyArIGxlbiA8PSBldC0+bGFy
Z2VzdC5mb2ZzKQo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4+Pj4+PiArCj4+
Pj4+Pj4+ICvCoMKgwqAgLyogUHVuY2ggW2ZvZnMsIGZvZnMgKyBsZW4pIGZyb20gbGFyZ2VzdCBl
eHRlbnQuICovCj4+Pj4+Pj4+ICvCoMKgwqAgbGFyZ2VzdF9lbmQgPSBldC0+bGFyZ2VzdC5mb2Zz
ICsgZXQtPmxhcmdlc3QubGVuOwo+Pj4+Pj4+PiArwqDCoMKgIHB1bmNoX2VuZCA9IGZvZnMgKyBs
ZW47Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gK8KgwqDCoCBsZWZ0X2xlbiA9IGZvZnMgPiBldC0+bGFy
Z2VzdC5mb2ZzID8gZm9mcyAtIGV0LQo+Pj4+Pj4+Pj4gbGFyZ2VzdC5mb2ZzIDogMDsKPj4+Pj4+
Pj4gK8KgwqDCoCByaWdodF9sZW4gPSBsYXJnZXN0X2VuZCA+IHB1bmNoX2VuZCA/IGxhcmdlc3Rf
ZW5kIC0KPj4+Pj4+Pj4gcHVuY2hfZW5kIDogMDsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArwqDCoMKg
IGlmIChsZWZ0X2xlbiA+PSByaWdodF9sZW4pIHsKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGV0
LT5sYXJnZXN0LmxlbiA9IGxlZnRfbGVuOwo+Pj4+Pj4+PiArwqDCoMKgIH0gZWxzZSB7Cj4+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBldC0+bGFyZ2VzdC5ibGsgKz0gcHVuY2hfZW5kIC0gZXQtPmxh
cmdlc3QuZm9mczsKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGV0LT5sYXJnZXN0LmZvZnMgPSBw
dW5jaF9lbmQ7Cj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBldC0+bGFyZ2VzdC5sZW4gPSByaWdo
dF9sZW47Cj4+Pj4+Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+Pj4+PiArwqDCoMKgIGV0LT5sYXJnZXN0
X3VwZGF0ZWQgPSB0cnVlOwo+Pj4+Pj4+PiDCoCB9Cj4+Pj4+Pj4+IMKgIHZvaWQgZjJmc19pbml0
X3JlYWRfZXh0ZW50X3RyZWUoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0Cj4+Pj4+Pj4+IGZv
bGlvICppZm9saW8pCj4+Pj4+Pj4+IEBAIC02ODAsMTAgKzY5NywxMCBAQCBzdGF0aWMgdm9pZAo+
Pj4+Pj4+PiBfX3VwZGF0ZV9leHRlbnRfdHJlZV9yYW5nZShzdHJ1Y3QgaW5vZGUgKmlub2RlLAo+
Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZGVpLmxlbiA9IDA7Cj4+Pj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCAvKgo+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoCAqIGRyb3AgbGFyZ2VzdCBl
eHRlbnQgYmVmb3JlIGxvb2t1cCwgaW4gY2FzZSBpdCdzIGFscmVhZHkKPj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqAgKiBwdW5jaCBsYXJnZXN0IGV4dGVudCBiZWZvcmUgbG9va3VwLCBpbiBjYXNl
IGl0J3MgYWxyZWFkeQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGJlZW4gc2hydW5r
IGZyb20gZXh0ZW50IHRyZWUKPj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4+Pj4+
Pj4gLcKgwqDCoMKgwqDCoMKgIF9fZHJvcF9sYXJnZXN0X2V4dGVudChldCwgZm9mcywgbGVuKTsK
Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIF9fcHVuY2hfbGFyZ2VzdF9leHRlbnQoZXQsIGZvZnMs
IGxlbik7Cj4+Pj4+Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+Pj4+PiDCoMKgwqDCoMKgIGlmIChldC0+
bGFyZ2VzdC5sZW4gIT0gMCAmJgo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4+Pj4gTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPj4+Pj4+PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldAo+Pj4+Pj4+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKPj4+Pj4+Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4+IExp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4+Pj4+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cj4+Pj4+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKPj4+Pgo+Pj4KPj4+Cj4+Pgo+Pj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IExpbnV4LWYyZnMtZGV2
ZWwgbWFpbGluZyBsaXN0Cj4+PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dAo+Pj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo+Pgo+IAo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51eC1m
MmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5n
IGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
