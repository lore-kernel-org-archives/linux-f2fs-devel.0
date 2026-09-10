Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EE7C79FBF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lAZiQww9JjTOlKOxlIw1mBTii1cn2BJBwFJcn58cPlY=; b=aptiqUVWy2IyQtSXMXf2oxUZR6
	2f33wKzFJCkXX8biinYm2+W88gGQwAl2Uuy3in9FhZ43xlGpO/IslO14WyasfUGIcHoEI+uzSYCPN
	DhD+bpJrH2EyDwYS9D9t7Pko5g5JdHS12KGM1eBSTfl9RyRFu0Fd6ZUwK1BZepZM/l2s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4h69-0003Nk-RD;
	Thu, 10 Sep 2026 15:54:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ziy@nvidia.com>) id 1x4h66-0003NS-7A
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 15:53:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Se4HlPyGVigrGHnWPlCoT/Tt6qCSfO0pnPQmufzoLRw=; b=U0XEybM010wpmz+X1yoVzs1DCy
 s7MG+cB08uw0LvoTBWoLwDYWcCj8W/xIIKqBlkqxArNmiyPgDUY4nvgmExLCiOmGpfQa7kVRfZ9kM
 o2vsjNNpWHm4E3brcJze7lCNNpjV0Lw/yrI/fpmVSFd90airdwhvGSly0N65v/S3e/ds=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Se4HlPyGVigrGHnWPlCoT/Tt6qCSfO0pnPQmufzoLRw=; b=YEbpMdSmSCIcBWZ+Eate9QIsVp
 L+2quRTt1S8BxpixhFQ1Kra79UudKHcAYv3c3NaW0YBjIXW/kkoT1PANlfpxWq7q4+DwgZuqK0lQv
 CxlHsQfl6qUkfwjQkxgHvzFRMCnKThIWQiwBKnThNdI3MPK4PZ2bjub0gL/G/iUYHiN0=;
Received: from mail-northcentralusazon11012045.outbound.protection.outlook.com
 ([40.107.200.45] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4h66-0005LA-CO for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 15:53:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyX2lP4yL4yyiNmSIdIZaKatetnjQAHMgPJWzfzL5I61m7x7H8BovKfaAW0hHC4ZA8pwWH7nNxjHOfkHtnq+PimVACQaceRb0ZeIl2FGhvsKQEFv2l1qCbOlGLF3RQP4mIG+2/P6RDNx3B6bMD538q9UVxwB2HFqJrnsdyEOubg+eifaIxU4lj/TEO4UPNO49QC3Pzp7GTsNDNxqtLSEALcInamvDk0OCjHoiCyoFWEuiYdzuxUQ0jFVrJ6wFM/6Ck4IT3c/geR5bIU182rAB28SMQhg+1+mAgGVcGMsfIpB1Z+MolucFWeitBGV0Dg313tsLxodOBtng6iUBcHe4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se4HlPyGVigrGHnWPlCoT/Tt6qCSfO0pnPQmufzoLRw=;
 b=wDNFeLDyxtXBN/vHeqRTX9duRj1+LDXIuxPSKBiqtd+lAg906R3Giln4lhqQZqUG6+TMHjaS+I3BNW8XsGu/GUwrUfoCPG6A3go9QTgmNM3KIBVlilvMD9AAOeLLoN4UgWRzkUysOZ/XHglCivqdiKWkPtJvQzCJqviGUj31AgXGJ8/0h+xz52XSyKZRAIzceVbP+42G0irF0g8PsBswKa7gXVFckDjX6Pulcw575oryqpqyPTj9KbVDLPfYLHm17WHIxV9f36+3bhUOFlin2STh+Uw9jGLqJNdp5iUOEHmGeSwYjYt58Crf/4XKeXwSPL2oZOdPRZEKa9BcyKJNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se4HlPyGVigrGHnWPlCoT/Tt6qCSfO0pnPQmufzoLRw=;
 b=kM54kR5GCpGKLKYjEGx1aqNyZkNtg2N8GkcrrRkvHIS3//HavE5/cwqc3xrxUZDlxLsW4QqWX4ZvOMnFBrkGK5pUuAaLrsXHTOetuR1LF/Rea5dzZ2nh+i33Hl1/svD+0awRiKyOv4kGeUJRgVthP/6RSxQ7o3Ip3qysz+p1tNwzE5oy8PtOEi/hTIEtW6bdlHGNlo1+ev6lvYVT4+XT75J+H5T8MstHfOKuElaCmlPQ7le3SvhJZHj5Z5yO5lNhXP5CfCQwJD437/hxIDmEyETmsQoV4w0n+7X2CmvNKGusD4GKYKOYkSmD3V+ceO973VS1OU+hemp0SnudiO1xbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 12:21:52 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 12:21:51 +0000
To: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 10 Sep 2026 08:21:52 -0400
X-Mailer: MailMate (3.0r7028)
Message-ID: <30DEBE66-9E26-4468-9A12-123539ED68A3@nvidia.com>
In-Reply-To: <927c0ec3-4183-4355-9269-721d79f4983c@kernel.org>
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-6-6ae22f9d9272@nvidia.com>
 <e5792e81-e8a5-42e1-aafe-58dc603f4968@kernel.org>
 <178889163877.1334491.3646957026033534678.b4-reply@b4>
 <83a8743b-9cbb-42a5-9ff5-718297916a76@kernel.org>
 <3dfab5df-c205-4853-bf48-86351a02b4e2@columbia.edu>
 <927c0ec3-4183-4355-9269-721d79f4983c@kernel.org>
X-MS-Reactions: disallow
X-ClientProxiedBy: MN2PR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:208:235::10) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9d0721-82cf-491d-7215-08df0f3617f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|10067099003|4143699003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jWdcUDHCijees+S+jIrnV6n897ChONRQehwY61dyn6edq/JJpj3pvAbvdWrUiFEL7B/NIgdw8s9wOMyVDaEnF/IQo3wXTWodLErpOj6+EUfr/qNR8u+F4mwfhkgHO5c133AGoiQPzdNhFwQTyFQH/3DexVSoCPQONFVW+caYj2OnGWFUFNpwHBRCZI6yhY31mN1ldgO6veVBM8sRlYKnkz0CSHJZc4PPi2B3N2bhie1JNoT4kyY2S9u5jme2iNxnn5V0OUVbz/C7igDCtEmnenwe1w8kUyoysw/XM5WoLRCqjfQGZ4447yMksR6lXDIo6fw0MfTFpP4hkCSlFteAlgQmDGkHxH9tjAg2PekWL29XPcuRBxdrwBWNivk+6DiF4BPBK4oX3i7t5XPo6wTYm9UvLHJoVIruj28M6y1upJaaYsTlRtol/3YjKVmbfeGJ0TGpfAV6xBJLx/BKwvDZIXNbQePB5X/3Or/K+bNcBrNEGSqxACtsSyjjC3WLPNbhWR7VIOOFGP8ZZ5LVhwN3WtMhoCfHOQbXIKoM/YuN0PpgXRclMCYiEYsLO6yFhKT5gU+1Gzt12aBv7bScf7vXU69TI57Smd3m42dSiOSijE3REzk7vFu7p1TM3t68+s/KrMKpyd2qVcC3OGQOMXfcoUMqt233G6sQChdgYzqpUgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhRa1plN3JIT2ZNc1JSaTNtUGhBbkIrUDR4UWZuTmZaWGJETWRtNTJRZVhR?=
 =?utf-8?B?dzhRZmRRdUxiL2doak9ONXpIVVkrYnhJSDVwYzcvQ3gwbm8xcklrOHkydnoy?=
 =?utf-8?B?YzVLTU5YWEkwOCs2ck9VL0IwdnhINnVyZmY0UjVnc1BYR1FnQkt0REFWelgy?=
 =?utf-8?B?RVRYT1VrMWE3ZUNMeHlKak5KQS96TEltNDJudVpySkI3VDBtS3RNWWp5M2Y0?=
 =?utf-8?B?VW4zc1JoWkhVbm8yS01OZHBRc1hoNHdOSFFrSVQ0aTFPSmhscUgyMmNIcUVE?=
 =?utf-8?B?RndKSmNVV2FlY1ZHaWhxY1B0ZUtTd3ZBR1hUQ25kYVk3a0Zwc25zajZLeS8y?=
 =?utf-8?B?QzlvQ1JxZnNOdEF1UjZBL1lwTWVIN2xjYXZCQ0dOZG5RVmg3OThwYVBHU2NE?=
 =?utf-8?B?ekFpVnMyRVRiOUI3bU0zV0swK3NTejhjQTRUN3BFVFBFVUk1NUJ0RldsTldr?=
 =?utf-8?B?aENiTUlmTTZaa29pWlpsam5vVG1sVzdsNnBtQU9pcXRoMitoeU9BdmIyZS9s?=
 =?utf-8?B?WVJiQy9rZlUxRHZQd0pkeXBiTk82d3E0bmZTMnYyZW91bThreTZNN0JPcUhE?=
 =?utf-8?B?d0ZuaFBMVEw1a2JMaUV2WlBsOW51VjJzakwrUEx2eDEzZ1VRUThtNGFDY0Y1?=
 =?utf-8?B?OC9LRnkzekw4RFpha3BwQ0VaVXllbE5pbFBpZ1RFQ1VZa1BnWWFGbVA1ckxx?=
 =?utf-8?B?ZVZkVTcyS25ibTJuVFlJSElUWXZhQVp6YU5BN1FQb0RaZkFwTDRDZUlUMWlL?=
 =?utf-8?B?Rk9aWDQzaldRNkVKc3dZRFhVYTZORk0vazVtc2thMVpWYTB0dE1kWXZwR3FD?=
 =?utf-8?B?R2dkVEVuQThhdE5pb0Z6N1N3TnE1Tkc3S2RmR3BLc3Fjb2U5WTZBRkdtRHNF?=
 =?utf-8?B?S3FKQW1WK04wN3o5ejBVaUd0dy9QOWVPSEtqa2ZlTVNlaWJ2ZnhyWUNzZlYz?=
 =?utf-8?B?VkU3QS9TeWplVVd3RWdsejlaWTdLVjVkNXNKSGZmbzZRTXQ0TFBGNjN3eDFr?=
 =?utf-8?B?QjdkNFQxUlFuSjByRW5Wamk5ek9LVzhoa0RBWExSWCt5R1cyQWtmWjAwS3FT?=
 =?utf-8?B?ZnBCendVUWMzdUY3Rm43N2NXU0t0d0RDMjJnUTVSdFRWckxiN3J2blBtbE9w?=
 =?utf-8?B?eThReTFWUll0V09rbkt1dzJXczY5Z052RlhONTZ2UjQ4Nm9mK3U0WnFFMVpW?=
 =?utf-8?B?Ulp0T2ZOOU0xQjVwSWdVYlBrN0JWSHB3QmYwMHczR2J3a0s2UGdvcFlMdHU4?=
 =?utf-8?B?S3ZINUpqc1hGeDJGZGM5M3B6VDlBNzB5WVgyRmZtblJyK1QwK3dLWlBMM1NM?=
 =?utf-8?B?NXVEeHlMNStRQ0lXWlF3MFRBTCtDOG13cXd4VjBrMExZSE9IWGhjem1XUnBL?=
 =?utf-8?B?VWpGSER6QVlUcklldGFtTFFMb00zZnREcWs3L0RJbC81c1Z3am9LVjlGWWpZ?=
 =?utf-8?B?M3I5cVZ1akxkc3RMSHR6K1R0Zm1jSzcrM3NqbEN4dTZkU24xcmd4UUxTZVl6?=
 =?utf-8?B?c1VNTXQ4YXk3ZUozRjVSclArRldHMVlBUzd0UXplN21xSm1lNm9nQUtFazY4?=
 =?utf-8?B?ZlMxd3pjOEdpUytlVytvZC9rMUpjVk9pck1QdmpZTlVVUTllV3dWUWs4TmNY?=
 =?utf-8?B?ZDhEZVVkd2s1SmhkQTNxWlNJNzNkQkl4R1dTTUFsdmh4SXNYZWZpSlFaNEM4?=
 =?utf-8?B?WWFxM1E2Yis0NGxsS3M4VXhZWFppTFo5VU8xM0dES3lFYytvVitMVWdnMFMy?=
 =?utf-8?B?WmlQaUNmQUU2ZXoxZFh2dUk3dk5HR2poSk5LZHBZRzUzK0RyQmJWQkY0N1Fy?=
 =?utf-8?B?U0Y4d0IrMDJFSzZjUDVOL2J5bjVMZHBpQWR6RWlaQ2lEdzMwVi81d3NEN29O?=
 =?utf-8?B?dlE5Y1hta2ZndTl5elJOT0piRlBZRWJSblQ2V2ZPdUp3RGkvalhxa2d5TzFD?=
 =?utf-8?B?WTRBeWp2ZDhLblFmanZTTWxyUEpUOGZEc0xEbEN4ejFVbHNad0xvcGpiODgy?=
 =?utf-8?B?LzR1OFplK0NFNHpVZXBhODBMUlYxd1dXazBKaWhHa0ZYZGpIc29LWEIweWhj?=
 =?utf-8?B?L3A3ZEEwb2VSNGNwaWc1N0h6eGxBb2t2RExxRkozM1hCR3Z4MXBaM2Z2ZUtO?=
 =?utf-8?B?YlNsdmhmNFVGREVrZjE3WWZGNmswZzY0RndQVW1HdFZwV3NYOHFySW4wR3lH?=
 =?utf-8?B?MjQrMVdJQ3RCNElxYjVjV0g2Vmd5VUNMZVhGaENZamlpL3RYbUNtMFkvOSs5?=
 =?utf-8?B?VGh6K3NOVm82S09ITC9zSk1GR0IwL0VDQm5iTTdHVDBicVZ6UURtMHcwbG5u?=
 =?utf-8?B?WEZldmREWTkyQzRxSlRrN2lZRXNMbU5WcFovSVlSSHBpUmRuQTBWdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9d0721-82cf-491d-7215-08df0f3617f8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 12:21:51.5990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRwrEhgW/YqLSR8eK12KW4CbfVA1uPJAcA+9PW0diz3hLjUZra0T/4EA5lBYcF8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
X-Headers-End: 1x4h66-0005LA-CO
Subject: Re: [f2fs-dev] [PATCH v3 06/14] f2fs: stop using PG_private
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
Cc: Michal Hocko <mhocko@suse.com>, "Liam R. Howlett" <liam@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Ying Huang <ying.huang@linux.alibaba.com>,
 Tal Zussman <tz2294@columbia.edu>, Qi Zheng <qi.zheng@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>, Alistair Popple <apopple@nvidia.com>,
 Dev Jain <dev.jain@arm.com>, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Gregory Price <gourry@gourry.net>, Ryan Roberts <ryan.roberts@arm.com>,
 Usama Arif <usama.arif@linux.dev>, linux-f2fs-devel@lists.sourceforge.net,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
 Nico Pache <nico.pache@linux.dev>, Lance Yang <lance.yang@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMTAgU2VwIDIwMjYsIGF0IDM6MzUsIERhdmlkIEhpbGRlbmJyYW5kIChBcm0pIHdyb3RlOgoK
PiBPbiA5LzkvMjYgMTk6NDcsIFRhbCBadXNzbWFuIHdyb3RlOgo+PiBPbiA5LzkvMjYgMzo0OCBQ
TSwgRGF2aWQgSGlsZGVuYnJhbmQgKEFybSkgd3JvdGU6Cj4+PiBPbiA5LzgvMjYgMjA6MjAsIFRh
bCBadXNzbWFuIHdyb3RlOgo+Pj4+Cj4+Pj4gSSBoYXZlIGEgV0lQIHNlcmllcyBvZiB+MzAgcGF0
Y2hlcyBjb252ZXJ0aW5nIG11Y2ggb2YgdGhlIHJlbWFpbmluZyBwYWdlCj4+Pj4gdXNlcnMgaW4g
ZjJmcyAoaW5jbHVkaW5nIHRoZSBiZWxvdykgdG8gZm9saW9zLiBTdGlsbCBoYXZlIHRvIGRvIHNv
bWUKPj4+PiB0ZXN0aW5nIGFuZCBjbGVhbiBpdCB1cCwgYnV0IGhvcGluZyB0byBzZW5kIGl0IG91
dCBpbiB0aGUgbmV4dCBjb3VwbGUgb2YKPj4+PiB3ZWVrcyAoaW4gdGhlIGhvcGVzIG9mIGVsaW1p
bmF0aW5nIHNvbWUgbW9yZSBmb2xpb19jb21wYXQuYyBmdW5jdGlvbnMgYnkKPj4+PiBuZXh0IGN5
Y2xlLi4uKQo+Pj4KPj4+IEluZGVlZCBiZXN0IHRvIHdhaXQgYSBiaXQgYmVmb3JlIGZsb29kaW5n
IC1tbSBldmVuIG1vcmUsIGl0J3MgcmF0aGVyIGEgbG90IGF0Cj4+PiB0aGlzIHBvaW50Lgo+Pj4K
Pj4+IEluIHRoZSBjb250ZXh0IG9mIHRoaXMgc2VyaWVzLCBpdCB3b3VsZCBiZSBncmVhdCBpZiB5
b3UgY291bGQgcmV2aWV3IHdoZXRoZXIgdGhlCj4+PiBkaWZmIEkgcHJvcG9zZWQgd291bGQgZ2V0
IHRoZSBqb2IgZG9uZSwgdGhhbmtzIQo+Pj4KPj4KPj4gV2hhdCBpdCBjaGFuZ2VzIGxvb2tzIGdv
b2QsIGJ1dCBJIHdvdWxkIGdvIGEgbGl0dGxlIGZ1cnRoZXIuCj4KPiBUaGFua3MhCj4KPj4KPj4g
VGhlcmUgYXJlIG9ubHkgdHdvIG1vcmUgdXNlcnMgb2YgcGFnZV9wcml2YXRlX2djaW5nKCksIHdo
aWNoIHBhc3MgZmlvLT5wYWdlLgo+PiBUaG9zZSBjb3VsZCBlYXNpbHkgYmUgY29udmVydGVkIHRv
IGZvbGlvX3Rlc3RfZjJmc19nY2luZygpIGJ5IHBhc3NpbmcgZmlvLT5mb2xpbywKPj4gd2hpY2gg
aXMgaW4gYSB1bmlvbiB3aXRoIGZpby0+cGFnZS4gVGhhdCB3b3VsZCBsZXQgeW91IGRlbGV0ZSB0
aGUKPj4gcGFnZV9wcml2YXRlXyMjbmFtZSgpIGltcGxlbWVudGF0aW9uIGluIFBBR0VfUFJJVkFU
RV9HRVRfRlVOQygpIGFzIHdlbGwgYW5kIGp1c3QKPj4gcmVtb3ZlIHRoZSBlbnRpcmUgZmFtaWx5
LiBBdCB0aGF0IHBvaW50IFBBR0VfUFJJVkFURV97R0VULFNFVCxDTEVBUn1fRlVOQygpCj4+IGNv
dWxkIGJlIHJlbmFtZWQgdG8gc29tZXRoaW5nIGxpa2UgRjJGU19GT0xJT19QUklWQVRFX3tHRVQs
U0VULENMRUFSfV9GVU5DKCkgYW5kCj4+IGFsbCBvZiB0aGlzIGNydWZ0IGlzIGdvbmUgYW5kIGZv
bGlvLWJhc2VkLCB3aXRoIG5vIG1vcmUgZjJmcyB1c2Ugb2YgcGFnZV9wcml2YXRlKCkKPj4gZWl0
aGVyLgo+Pgo+PiBUaGUgcmVuYW1pbmcgY291bGQgYmUgZG9uZSBhcyBhIGxhdGVyIHN0ZXAsIGJ1
dCBJIHdvdWxkIGdldCByaWQgb2YgdGhlIGFjY2Vzc29ycwo+PiBhcyB3ZWxsIGluIG9uZSBzd29v
cC4KPgo+IFllcywgZWl0aGVyIGFzIHBhcnQgb2YgdGhlIHNhbWUgcGF0Y2ggb3IgYXMgYSBzZXBh
cmF0ZSBwYXRjaC4gWmksIGNhbiB5b3UgdGFrZQo+IGNhcmUgb2YgdGhhdD8gVGhhbmtzIQoKT0ss
IEkgd2lsbCBjb21lIHVwIHdpdGggYSBwYXRjaCBiYXNlZCBvbiB5b3VyIHBhdGNoIHBsdXMgdGhl
IHN1Z2dlc3Rpb24gaGVyZQpvbiB0b3Agb2YgdGhpcyDigJxmMmZzOiBzdG9wIHVzaW5nIFBHX3By
aXZhdGXigJ0uIEkgd2lsbCBwb3N0IHRoZSBwYXRjaCBoZXJlCmZvciBmZWVkYmFjayB0byBhdm9p
ZCBleHRyYSBjaHVybiBvZiB0aGUgd2hvbGUgc2VyaWVzLgoKQmVzdCBSZWdhcmRzLApZYW4sIFpp
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo=
