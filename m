Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A27C79FA0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ziggApK1cZSAeczfoKwrSkEA++LJEH7Az77oPZUFLkY=; b=fZcJczZcfOuo77EKMsuyt8mIDr
	drQTQXZQOZL6qW/r6vtfNNzPIo4UwvEO+T3bKl09Umr5HNJTA6P4UMzMOBxgthiPzL5kfzs2vlQPs
	3THeXcDY+XA4LhIIDV/pvT94wrPjYYIP0BVT31cdzshXkyc/R3S93L71KTWMKhxr1BGs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3qWZ-0007wr-6w;
	Tue, 08 Sep 2026 07:45:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ziy@nvidia.com>) id 1x3qWY-0007wd-1I
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 07:45:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Cc:To:Content-Transfer-Encoding:
 Content-Type:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0/+loFgTpB5WI64K9N4RnP70y5sRGMjPtenQs1tbBDA=; b=XRi4TJmrIQEp1IvAo8drN5kGyr
 zEMaeZb+XhpV37wuWN5vZaxOpeLsLKJcGfLRA6W8AN5rmHGDnppzF9czeBwNaSZxSTAVufddb4y/B
 NG9X1sOuTQET4cpLKn0D+xGOixvdTtzrIsq6E60kt5zdZuf1wf+WNnlYPk0JyzH7i4a8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Cc:To:Content-Transfer-Encoding:Content-Type:Message-Id:Date
 :Subject:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0/+loFgTpB5WI64K9N4RnP70y5sRGMjPtenQs1tbBDA=; b=i
 m3+Md1BYApM9I4IXQ2THFXiVgJceG5GegUgu8CDBS/tda7y3v64nGPpyaSvZUwNrdHuyd1c5jXUwr
 GBV6hBIU3YXIb54Hy9Cht5X8raiTLZInD6MN4RfZButkgiKWJM+KgowJnJg1JMq22Hd6N3bY7X9h4
 N9lkSGVyFHg6BRPA=;
Received: from mail-westcentralusazon11013032.outbound.protection.outlook.com
 ([40.93.201.32] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3qWX-0000Dp-GQ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 07:45:46 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 03:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNLKY/TL9ihjVf2a51ONNvLPuDvfAHEdEwlp53OPvKoYISnQQCA1Pe3CuSbYICUW75wUwpeq4vqynBY714801xJh2vGx0V302o5ftHSglYgVDCUyLqlubRlMBRt3M/du4b95mEDv/WmKdIeRZxufODQNX0K/jxby0sWLM/+kSf4LndFxaTIVE44HayniZ9TespyJWKuOrV1dkjkGd7Binj3Nb2Y38hxDZwCAAoabkSD6wvnhgSwv0K2NlbS4hrf/ZCHMNqQsdvJd89lIjHxEUEbqG7xOR7CQ89JaQNBRfuM6GY33kpv5qRbsasVCoNQa5C7mihcg97TM+rEAj2xsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/+loFgTpB5WI64K9N4RnP70y5sRGMjPtenQs1tbBDA=;
 b=lTeeySTtb4b/YkEw9x3cLjYc0qImguU9uDMHWRKpgl+r3iioTtN2l5VS0TPf2FqB82Zw8VfxqaA8LnUnUMnEJEOXI40UVp7lobphhdoFnRRsTwiakI8PrpUn4VefNlAvMYTCK8vH4qXM5c3XxfuXO4zQor7tF/YNB2N8H2eZnH+Var5a6JLgL173TsC2Z8d7LBC3Pq1+VqdlkR3g62QHWBruGh7IkdaubyHRPPXGjl5d/TJnpodOEJToSHKRn4hJcOzAp9VdD6n+g7MtGBn6EhgLMKakXPsJzxrdCtTNzU1GfwdSWmnpxGJqfpJqwMIy1OPonfEY9IPzys26aoA3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/+loFgTpB5WI64K9N4RnP70y5sRGMjPtenQs1tbBDA=;
 b=O7zqGrJipndOZP+iH4uMuHVRC/jFfGog+WpzDfJc48qIu1XEmMioqbdt1soIAjrJi9tD2laD1hutZUAdLf6QmmC8EWG8ZPJSGgIXVl/5ZzLy+XnpQJ4FXR6k+8e35lfIafxsS4BC/tKH/fwqoaWpcREealRy0eT0Ij2bKudWYOXRyl/wKtFIdQNhegY+kjBoCKrd7uYIJ87o5ts0MnRt2YEsUJ+RtX2KPa/+wz9rHaBBOpye4ptOGIkLndknWWTy2+oCBMqu1uC0rgV2A5hG4gm+HWonFtSV8vddbrmU/bBfTmLQ269DUCpZ8nZ592kK3WNDA6sPi/FZ5M0e/YMbgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 02:56:27 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 02:56:27 +0000
Date: Mon, 07 Sep 2026 22:56:07 -0400
Message-Id: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23N0QqCMBTG8VeRXbdwZzm3rnqPiFjzqOciJ5uMQ
 nz3pgQRePn/4PzOzCIGwsjOxcwCJorkhxzyUDDX26FDTk1uBiWosgbNAz59Qj529zFQshNy16I
 B5epWS8fy3RiwpddmXm+5e4qTD+/tRRLr+tWk2NGS4CUXJ3CmflhZKbgMiRqyR+efbOUS/Ai9T
 0AmpFJaVMY1BvUfsSzLB/oTPbj2AAAA
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
X-ClientProxiedBy: BL1PR13CA0376.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::21) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM6PR12MB4435:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a43f69-1177-4e40-a343-08df0d54c6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|921020|6133799003|5023799004|10067099003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: DFa4PsxrZxBeb2/5wrXjfZDIHi2Fxy5+95qvY6K4FHW1tGYNOuTnl0W80trBtV+yMqR20GMCuTgFr7jFXcNEmVzhUYPAo027yju8Vx8gRqUcB+HEeQIptn/BNF1M2gTahlQnDAjgZ1/7THy+UX6nw2ejea5UInnMW5HhPRVMTAOyfICe/ya5H/gVoTCIMTledsODGZHVBYq7eNHD25KQ2GLYI0p/4QzIptdrvqJ89u4P/Cmg2sYCOS44wtcqJFMO3E4+Gc0QNeSm6FmDKV9HuhPkcOGKidN2Uk3xf/LGljecrN4+ePb0TJHhNXaEzTYCJjHU2sh5N5IJEZKT9DyaF5FLJcUiXZ+Vu5pvTGykaT0fVMnLXB2ykNEDDChCUP/P5gPd+UWNCnPVmW+wG3jY1tjDAJDQZ8Y4Tw9WQ4N3Za69ZGQEHPcoKgWN8EdXlh6QFhDag1F4I13DZvFbkNJDd0wTgp3uAE9sXC9BdB0R6wjKihtaEqmWZlXl+Apul6nfDUVeSp9cnZGCmobaPmOm6VphOHAn+wqKtQvCDuQ/4LvGuWIDl29E9xye9CdVGd8AonXkh3hIaL5KTr72yUqyS4+cD6kawxp5eavsy7pDA09skWDfYkGrCQuWjrwgZazW3JQXALmF24ITJylhDA244hv+dhXgFOM5ftIrMEpncTy1cE49CJOt5h8rABb1CEKW3lf4jTlhiR8tLDtRPWDFFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(921020)(6133799003)(5023799004)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0ZkUmxZZjFYTzVXbExEWUhiMGkyWk9VWjc2aE1yTUl4UnVURW1lZWY2RGNW?=
 =?utf-8?B?S3ozbW9vV20xazBDUVFzNlFTRkRYVlJSQUhFS3pDTWVLZGNLQ0prd1M3R2k5?=
 =?utf-8?B?MlZoc0c3ZHFXMGRkSUFaejlWQTNLZm4xYUp5TjZPNGZEczRzUy9CdkdOa3o3?=
 =?utf-8?B?bStheEdaSGlQNnIxTjdZOXU5em0wekVoTjcyR2Q3TStmNWVWZldQSGRVRXRP?=
 =?utf-8?B?VkNHWHdMZFU2ZFBzOEpQNURzYm13dXVBQU5wSmtQQXc4dHBmc0lTeVJKbGJo?=
 =?utf-8?B?TkxMYW5uNnZRUWlweDFORE5sUERQeUtlcTdLeGEyU0RNbTltWndwR3l4L2ZO?=
 =?utf-8?B?V1MybllhMUtlYlY4Z2ZlT0VtOHpkTktwLzJEaFdnVE1lMVdtR3BMT0dlaGly?=
 =?utf-8?B?NXdGWUl0cHR1anRVcy9MV3M4dWNVSWx0QmtmSVZ6NEdYcmVCbUJQaDY4QmRk?=
 =?utf-8?B?alRQOUZYU09PZ2pva2c4YW1FeXhBSDVGMFRzM0ZyYnVtQ2dWemx0bCs5dW5u?=
 =?utf-8?B?eEorTENjbnRKU3ZIWDZKcldBR0p1R2dTV3ZZTVdPUHJuWjZRUUUxWXNlRXJj?=
 =?utf-8?B?eTA2VzFtRjFSMGk0OEZLcDc4QTJIa21hZmJTNUoxZlpzQ1d5V3FvQWxxWWVO?=
 =?utf-8?B?Qi9sczVsU2Z5K0p1TW5GTnJldUtjc0hEOWdSbWtWcGV3RnhtSGlaOUdQWW9x?=
 =?utf-8?B?enhzRWsrMU04bDJzSlUvNm5HY1M0OE1GY29VRjk1Z1FsNDZscVJIMFIyVHBr?=
 =?utf-8?B?bloxSUNCRXJLWnVQMHduZVdEZ2EvVzVvUDJva3Z3UXhaSmpUU1hsZG53aG1D?=
 =?utf-8?B?Tmt0ZmNJQjY4WkpMdng4TWt1MmFHZG1QQi9Wa2dXNzc5NEdWdnNqY09QbUw4?=
 =?utf-8?B?SzJPbUcycVpvQmtiS1c1QmlWRUEzMGM0OGhJVWR6RDh2ZTZNbWppSjlBWGdi?=
 =?utf-8?B?dTkrdmFja25tekpnYXROSFJRK3FtNWU2WFA4TkE2MFBPeTZsak5ZTVkvS0h5?=
 =?utf-8?B?dVZheFRqSUxJSXZSSHc0dG95RXVVVnMyYytBUTNoQ1QrZUZ4M2xuRVZ6Y2F3?=
 =?utf-8?B?T0VGcFprY3lmbkNVSksrUEVBSDkrNTdzS21MSzB2VEVRUFNQNTgzcVQ4S2Nl?=
 =?utf-8?B?Q0VGUEVOTk9MZS9Ebk02azhaQkNrQTM2ZVFWazNBUjBtS3gzdlovR1lGMk1r?=
 =?utf-8?B?V0NKaytEQzMvNlE1UGJJTEFnK01GQ0J0d2lCNkxRM3ZGRWJFUGw0UERDdVEx?=
 =?utf-8?B?UVFMaWV4NERCU1MvZlhIbEJuN1psWXBvSWJvNGIrdW9ZRXlhemZuckltOFVr?=
 =?utf-8?B?NHUvSGp6Y2psbWRhcVdZTkFsSDhWMkJHNEc0eUtESldzRkNmb3NiSFR6akk5?=
 =?utf-8?B?UGRzcHNTaGpFRVMzVUlnSmJ1dzRuL0NkaHVTWk1OSC9qNU5IVk9CQWhvQ3dZ?=
 =?utf-8?B?Sy9aUHJRNWtxWlkza0RqSFVOL0FYRTVINXF1YS9vVTRyM2l4RkZBVXFpSzlk?=
 =?utf-8?B?c0pNTGtVOGRobTBkWHZCeUc0YTFybUt6U3c3UlpObWpoRWlKd3k5MzVXdjZM?=
 =?utf-8?B?cHNFSzFRL0JpV0ZOUzlRY09ldE94Vkg2RzJOZFJ3Y2IyTUVjNURyRzZMNlNw?=
 =?utf-8?B?MStzSG1nZHIvdEZLdVJVQ25FYi8yTkRKaFF1OTVQUlNINXJOVXZJM0JuczhN?=
 =?utf-8?B?SjRIVFJNUEpqNFlsc3FlTWUvaVBodTN0ZVZBb01zYk5YdkJzUDdGNVVtd3RV?=
 =?utf-8?B?eFpKY0g5MTN4NkhxM2ZnZUlpeTBvMTQ1WTg0emFadi9heTRORGF3Y2pqU2do?=
 =?utf-8?B?US9PaTN3VnJTYSt3MHA4R3FsN1JYS0dqTWRpdFdwU0ozNEJKUHd3djNVMzlt?=
 =?utf-8?B?cmRjN2htTDRTajVxc3JhYi9xeHg1WTlzeXc1SU9jWmxTeTNoRW1IWjRRMVBR?=
 =?utf-8?B?VVJCYVRaSVdiL3JYaVplWnJmNjFFUW5zclArN3J4WTF6YUx6WFdDYmdrNlVt?=
 =?utf-8?B?c1krOGFHcVlNblRFUkFESDBEb2tHc2VXNTBVTUY5eTh4dmZieHJpUGQ2K01n?=
 =?utf-8?B?UVlRUWdUOUVSNmhiRmYyU3dLSnJIZ05vRjVCM0RpZWtPRTUwT3NaRHFQQXJL?=
 =?utf-8?B?cGQ4MzAxQ0tPRVhBa3A4dC85bVlNRElEd1JMUUJObkNqRStQeHdzMm1uNThS?=
 =?utf-8?B?c3pQTXNIUCtxS3lKRURaUU9BUDV3TlBhVGxXZHNmZzZHUFczVWFGMjdUN1R3?=
 =?utf-8?B?MDRBZzd4T1VsM0wrTzY1M0hUem5zR0pJRDE2SU1IcS8wVG81TUkzNS9aYzhx?=
 =?utf-8?Q?tqOmrccOv/+NYgACkW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a43f69-1177-4e40-a343-08df0d54c6aa
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 02:56:27.2502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INmokXrarh8Yoor8WTq7CLfba+LlxdubfXkWLLcIL40rtSGcfkO9FCQhfhZ4OJUH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
X-OriginatorOrg: Nvidia.com
X-Headers-End: 1x3qWX-0000Dp-GQ
Subject: [f2fs-dev] [PATCH v3 00/14] Remove PG_private by using
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
ciBsZXR0ZXIgYW5kIGNvcnJlc3BvbmRpbmcgcGF0Y2hlcy4KClBhdGNoIDYgaXMgcGlja2VkIHVw
IHNlcGFyYXRlbHkgaW4gZjJmcyB0cmVlLCBidXQgc2luY2UgbW0tbmV3IGRvZXMgbm90CmhhdmUg
aXQgeWV0LCBpdCBpcyBzZW50IGZvciBNTSB0ZXN0aW5nLgoKT3ZlcnZpZXcKPT09Ck1vc3QgY29k
ZSB1c2VzIGZvbGlvX2F0dGFjaC9kZXRhY2gvY2hhbmdlX3ByaXZhdGUoKSBmdW5jdGlvbnMsIHNv
IGZvbGlvCnJlZmNvdW50IGlzIGluY3JlYXNlZCBhbmQgZGVjcmVhc2VkIHdoZW4gZm9saW8tPnBy
aXZhdGUgaXMgc2V0IGFuZCByZXNldCwKcmVzcGVjdGl2ZWx5LiBUaGVyZSBpcyBubyBuZWVkIHRv
IGNoYW5nZSB0aGVtLgoKQ2hhbmdlcyBhcmUgbmVlZGVkIGZvciBleGNlcHRpb25hbCB1c2VyczoK
MS4genNtYWxsb2MgdXNlcyBQR19wcml2YXRlIHRvIGluZGljYXRlIGZpcnN0IGNvbXBvbmVudCB6
cGRlc2MgcGFnZSBhbmQKICAgcGFnZS0+cHJpdmF0ZSBpcyB1c2VkIHRvIHN0b3JlIHpzcGFnZSBp
biB6cGRlc2MuIFRvIHJlbW92ZSBQR19wcml2YXRlLAogICBpc19maXJzdF96cGRlc2MoKSBpcyBy
ZXBsYWNlZCBieSBwb2ludGVyIGNvbXBhcmlzb24uCgoyLiBrZXJuZWwvZXZlbnRzL3JpbmdfYnVm
ZmVyLmMgc3RvcmVzIHBhZ2Ugb3JkZXIgaW4gcGFnZS0+cHJpdmF0ZS4KICAgUmVwbGFjaW5nIFBH
X3ByaXZhdGUgd2l0aCBwYWdlLT5wcml2YXRlICE9IE5VTEwgd29ya3MuCgozLiBkcml2ZXJzL3hl
bi9ncmFudC10YWJsZS5jIHN0b3JlcyB4ZW5fcGFnZV9mb3JlaWduIGluIHBhZ2UtPnByaXZhdGUs
CiAgIHdoZXJlIG9uIDMyLWJpdCwgYSBwb2ludGVyIHRvIHhlbl9wYWdlX2ZvcmVpZ24gaXMgc3Rv
cmVkOyBvbiA2NC1iaXQsCiAgIHBhZ2UtPnByaXZhdGUgaXMgdXNlZCBhcyB4ZW5fcGFnZV9mb3Jl
aWduLiBQR19wcml2YXRlIGNoZWNrIGlzIHJlcGxhY2VkCiAgIGJ5IHBhZ2UtPnByaXZhdGUgIT0g
TlVMTCBvbiAzMi1iaXQgZm9yIHhlbl9wYWdlX2ZvcmVpZ24gZGVhbGxvY2F0aW9uLgogICBPbiA2
NC1iaXQsIHBhZ2UtPnByaXZhdGUgaXMgY2xlYXJlZCB1bmNvbmRpdGlvbmFsbHkgc2luY2Uge2Rv
bWlkPTAsCiAgIGdyZWY9MH0gKHhlbl9wYWdlX2ZvcmVpZ24gY2FuIGJlIDApIGlzIHZhbGlkLgoK
NC4gZnMvY3J5cHRvL2NyeXB0by5jIHN0b3JlcyBhIGZvbGlvIHBvaW50ZXIgaW4gcGFnZS0+cHJp
dmF0ZSwgUEdfcHJpdmF0ZQogICBjaGVja3MgYXJlIHJlcGxhY2VkIGJ5IHBhZ2UtPnByaXZhdGUg
IT0gTlVMTC4KCjUuIGZzL2Vyb2ZzIGhhcyB0d28gZGlmZmVyZW50IHVzZXM6CgogICAgNWEuIGZv
bGlvLT5wcml2YXRlIGlzIHVzZWQgdG8gZm9ybSBhIHJldmVyc2VkIGxpc3Qgb2YKICAgIHRoZSBv
dXRwdXRzIG9mIHJlYWRhaGVhZF9mb2xpbygpLiByZWFkYWhlYWRfZm9saW9fbGFzdCgpIGlzIGFk
ZGVkIHRvCiAgICBvdXRwdXQgZm9saW9zIGluIHJldmVyc2VkIG9yZGVyLCBzbyB0aGF0IC0+cHJp
dmF0ZSBpcyBubyBsb25nZXIgbmVlZGVkLgoKICAgIDViLiBmb2xpby0+cHJpdmF0ZSBpcyB1c2Vk
IGFzIGFuIGluLWZsaWdodCBJL08gY291bnRlci4gQ29udmVydCB0aGUKICAgIGNvZGUgdG8gdXNl
IGZvbGlvX2F0dGFjaC9kZXRhY2gvZ2V0X3ByaXZhdGUoKSBhbmQgYWRkIGJpYXM9PTEgdG8gdGhl
CiAgICBjb3VudGVyIHRvIGF2b2lkIGZvbGlvLT5wcml2YXRlIGJlaW5nIHplcm8uCgo2LiBmcy9u
ZnMvd3JpdGUuYzogZm9saW8gcmVmY291bnQgbWFpbnRlbmFuY2UgaXMgaW4gYSBiaWdnZXIgc2Nv
cGUgdGhhbgogICBmb2xpby0+cHJpdmF0ZS4gU28gZm9saW9fYXR0YWNoL2RldGFjaC9nZXRfcHJp
dmF0ZSgpIGlzIG5vdCB1c2VkLgogICBOb3RoaW5nIHRvIGNoYW5nZS4KCjcuIGZzL2YyZnMgdXNl
cyBhdHRhY2hfcGFnZV9wcml2YXRlKCkgdG8gZmlyc3QgcmVzZXQgZm9saW8tPnByaXZhdGUgdGhl
bgogICBpbW1lZGlhdGVseSBzZXRzIFBBR0VfUFJJVkFURV9OT1RfUE9JTlRFUiBiaXQgb24gaXQu
IENoYW5nZSBpdCB0byB1c2UKICAgYXR0YWNoX3BhZ2VfcHJpdmF0ZSgpIHRvIHNldCBQQUdFX1BS
SVZBVEVfTk9UX1BPSU5URVIgYml0IGRpcmVjdGx5IHRvCiAgIGF2b2lkIGZvbGlvLT5wcml2YXRl
ID09IE5VTEwgZ2FwIGluc2lkZSBzZXRfcGFnZV9wcml2YXRlXyMjbmFtZSgpLgoKOC4gaHVnZXRs
YiB1c2VzIGZvbGlvX2NoYW5nZV9wcml2YXRlKGZvbGlvLCBOVUxMKSB3aXRob3V0IGZvbGlvIHJl
ZmNvdW50CiAgIG1haW50ZW5hbmNlLiBDaGFuZ2UgaXQgdG8gZm9saW8tPnByaXZhdGUgPSBOVUxM
LgoKQWZ0ZXIgdGhlIGFib3ZlIGNoYW5nZXMsIFBHX3ByaXZhdGUgb3BzIGFyZSBjb252ZXJ0ZWQg
dG8KcGFnZS9mb2xpby0+cHJpdmF0ZSBvcHMuCgpmb2xpb190ZXN0X2ZzX3ByaXZhdGUoKSBpcyBh
ZGRlZCB0byBjaGVjayBmaWxlc3lzdGVtLW9ubHkgcHJpdmF0ZSBkYXRhIGJ5CmV4Y2x1ZGluZyBz
d2FwY2FjaGUgYW5kIGh1Z2V0bGIgZm9saW9zLCBiZWNhdXNlIHN3YXBjYWNoZSBmb2xpb3Mgb3Zl
cmxhcApzd3BfZW50cnlfdCBzd2FwIHdpdGggLT5wcml2YXRlIGFuZCBodWdldGxiIHNldHMgaXRz
IG93biBmbGFncyBpbgotPnByaXZhdGUuCgpOb3RlCj09PQoxLiBLUEZfUFJJVkFURSBpcyByZW1v
dmVkIGFmdGVyIFBHX3ByaXZhdGUgaXMgcmVtb3ZlZC4KCjIuIERvY3VtZW50YXRpb24vbW0vaHVn
ZXRsYmZzX3Jlc2Vydi5yc3QgaXMgb3V0ZGF0ZWQsIHNvIEkgZGlkIG5vdCByZW1vdmUKICAgUEdf
cHJpdmF0ZSByZWxhdGVkIHRleHQuIEl0IHNob3VsZCBiZSByZXdyaXR0ZW4uCgozLiBQR19mb2xp
byBpcyBwbGFubmVkIHRvIGJlIHNldCBvbiBldmVyeSBwYWdlIGZyb20gYSBmb2xpbyBpbgogICBw
YWdlX3JtYXBwYWJsZV9mb2xpbygpLCBzbyBmb2xpb3Mgd2l0aCBhbnkgb3JkZXIgKGN1cnJlbnRs
eQogICBQR19sYXJnZV9ybWFwcGFibGUgaXMgdXNlZCB0byBpZGVudGlmeSA+MCBvcmRlciBmb2xp
b3MsIGJ1dCBub3Qgb3JkZXItMAogICBmb2xpb3MpIGNhbiBiZSBpZGVudGlmaWVkLiBUaGVuIHZt
X2luc2VydF8qKCkgY2FuIGNvcnJlY3RseSByZWplY3QgYWxsCiAgIGZvbGlvcyBhbmQgcm1hcCBj
b2RlIHdpbGwgb25seSBzZWUgZm9saW9zLiBFdmVudHVhbGx5LCBwYWdlX2ZvbGlvKCkKICAgd2ls
bCByZXR1cm4gTlVMTCBmb3Igbm9uLWZvbGlvIHBhZ2VzIGJ5IGNoZWNraW5nIFBHX2ZvbGlvLCBi
dXQgYmVmb3JlCiAgIHRoYXQgYWxsIGV4aXN0aW5nIHVzZXJzIHRoYXQgdHJlYXQgY29tcG91bmQg
cGFnZXMgYXMgZm9saW9zIHdpbGwgbmVlZAogICB0byBiZSBjb252ZXJ0ZWQuCgpUZXN0cwo9PT0K
MS4gYWxsbW9kY29uZmlnIGJ1aWxkIHBhc3NlZC4KCjIuIHpzbWFsbG9jIGlzIHRlc3RlZCB1c2lu
ZyBleHQ0IG9uIGEgMUdCIGx6NCB6cmFtOgogICAgMmEuIHpyYW0gbG9hZCArIHpzbWFsbG9jIGNv
bXBhY3Rpb247CiAgICAyYi4gY29uY3VycmVudCB6c3BhZ2UgbWlncmF0aW9uIHZpYSBtZW1vcnkg
Y29tcGFjdGlvbjsKICAgIDJjLiBjb25maXJtZWQgdGhhdCBtdWx0aS1wYWdlIHpzcGFnZXMgYWN0
dWFsbHkgZm9ybWVkLgoKICAgIERldGFpbHM6IGh0dHBzOi8vZ2l0aHViLmNvbS94LXktei9saW51
eC1kZXYvYmxvYi9iNC9yZW1vdmUtcGdfcHJpdmF0ZS90ZXN0X3pzbWFsbG9jLm1kCgozLiBlcm9m
cyBpcyB0ZXN0ZWQgb24gaW1hZ2VzIGNyZWF0ZWQgd2l0aCAtQzQwOTYgYW5kIGx6NGhjLCBsem1h
LAogICBkZWZsYXRlLCBhbmQgenN0ZCBhbGdvcml0aG1zOgogICAzYS4gY29sZCByZWFkIG9mIGFs
bCBmaWxlcywgdmVyaWZ5IGNoZWNrc3VtcyBtYXRjaCBzb3VyY2U7CiAgIDNiLiByZWFkYWhlYWQg
KyByZWNsYWltL21pZ3JhdGlvbiByYWNlLgoKICAgRGV0YWlsczogaHR0cHM6Ly9naXRodWIuY29t
L3gteS16L2xpbnV4LWRldi9ibG9iL2I0L3JlbW92ZS1wZ19wcml2YXRlL3Rlc3RfZXJvZnMubWQK
CjQuIGZzY3J5cHQgaXMgdGVzdGVkIG9uIHNvZnR3YXJlLWVuY3J5cHRlZCBleHQ0IHdpdGggd3Jp
dGVzIHRvIGV4ZXJjaXNlCiAgIGJvdW5jZSBwYWdlcy4KCiAgIERldGFpbHM6IGh0dHBzOi8vZ2l0
aHViLmNvbS94LXktei9saW51eC1kZXYvYmxvYi9iNC9yZW1vdmUtcGdfcHJpdmF0ZS90ZXN0X2Zz
Y3J5cHQubWQKCjUuIGYyZnMgaXMgdGVzdGVkIG9uIGFuIGltYWdlIHdpdGggaW5saW5lX2RhdGEs
Y29tcHJlc3NfYWxnb3JpdGhtPWx6NDoKICAgIDVhLiBJTkxJTkVfSU5PREUg4oCUIGxvdHMgb2Yg
dGlueSBmaWxlczsKICAgIDViLiBSRUZfUkVTT1VSQ0UgKyBnZW5lcmFsIHdyaXRlYmFjayDigJQg
YnVmZmVyZWQgd3JpdGUgY2h1cm4gd2l0aCBmc3luYzsKICAgIDVjLiBPTkdPSU5HX01JR1JBVElP
TiDigJQgZm9yY2UgR0MgLyBwYWdlIG1pZ3JhdGlvbjsKICAgIDVkLiBBVE9NSUNfV1JJVEUg4oCU
IGF0b21pYy13cml0ZSBpb2N0bCBwYXRoLgoKICAgIERldGFpbHM6IGh0dHBzOi8vZ2l0aHViLmNv
bS94LXktei9saW51eC1kZXYvYmxvYi9iNC9yZW1vdmUtcGdfcHJpdmF0ZS90ZXN0X2YyZnMubWQK
ICAgIChJIGRpZCBub3QgcnVuIHhmc3Rlc3RzKQoKNi4gTU0gc2VsZnRlc3RzIHBhc3NlZC4KCkxM
TSB1c2UKPT09CkNsYXVkZSB3YXMgdXNlZCB0byBmb3JtIGEgY29uY3JldGUgcGxhbiBvbiB3aGF0
IGNvZGUgbmVlZHMgdG8gYmUgY2hhbmdlZAphbmQgaG93IHRvIGNoYW5nZSB0aGVtLiBUaGUgcGxh
biB3YXMgcmV2aWV3ZWQgYnkgQ29kZXggdW50aWwgbm8gaXNzdWUgd2FzCnNwb3R0ZWQuCgpQbGFu
IGlzIGF0OiBodHRwczovL2dpdGh1Yi5jb20veC15LXovbGludXgtZGV2L2Jsb2IvYjQvcmVtb3Zl
LXBnX3ByaXZhdGUvcGxhbi5tZAoKSSB0aGVuIGZvbGxvd2VkIHRoZSBwbGFuIHRvIG1ha2UgY29k
ZSBjaGFuZ2VzLiBJIGRpZCBib3VuY2UgaWRlYXMgd2l0aApDbGF1ZGUgaG93IHRvIGNoYW5nZSBm
cy9lcm9mcywgc2luY2UgSSBkaWQgbm90IGxpa2UgdGhlIG9yaWdpbmFsIGlkZWEuCkFmdGVyIGVh
Y2ggY2hhbmdlLCBJIGFza2VkIENsYXVkZSB0byByZXZpZXcgbXkgY29kZSBhbmQgZ2l0IGNvbW1p
dCBtZXNzYWdlLgpJIGFsc28gYXNrZWQgQ2xhdWRlIHRvIGdpdmUgbWUgdGVzdCBwbGFucyAoc2Vl
IGFib3ZlKS4KCkF0IGxhc3QsIENvZGV4IHdhcyB1c2VkIHRvIHJldmlldyBhbGwgcGF0Y2hlcy4K
CkNvbW1lbnRzIGFuZCBzdWdnZXN0aW9ucyBhcmUgd2VsY29tZS4gVGhhbmtzLgoKQXNzaXN0ZWQt
Ynk6IENsYXVkZTpjbGF1ZGUtb3B1cy00LTgKQXNzaXN0ZWQtYnk6IENvZGV4OmdwdC01ClNpZ25l
ZC1vZmYtYnk6IFppIFlhbiA8eml5QG52aWRpYS5jb20+Ci0tLQpDaGFuZ2VzIGluIHYzOgoxLiBj
aGFuZ2VkIGZvbGlvX3Rlc3RfZnNfcHJpdmF0ZSgpIHRvIGNoZWNrIFBHX3N3YXBiYWNrZWQgaW5z
dGVhZCBvZgogICBQR19zd2FwY2FjaGUgZm9yIGV4Y2x1ZGluZyBzd2FwY2FjaGUgZm9saW9zLiBC
ZWNhdXNlIGZvbGlvLT5wcml2YXRlIGFuZAogICBQR19zd2FwY2FjaGUgYXJlIG5vdCBzZXQgYXMg
YSB3aG9sZSwgbWFraW5nIGZvbGlvX3Rlc3RfZnNfcHJpdmF0ZSgpIGdpdmUKICAgZmFsc2UgcG9z
aXRpdmUsIHdoZXJlYXMgUEdfc3dhcGJhY2tlZCBpcyBhbHdheXMgc2V0IGZvciBzd2FwY2FjaGUK
ICAgZm9saW9zLgoyLiBhZGRlZCBfX0RFRl9QQUdFRkxBR19OQU1FKCkgdG8gc2hvdyBfX1BHX2Zv
bGlvIGluc3RlYWQgb2Ygb3BlbiBjb2RlLgozLiBmMmZzIGNoYW5nZSBpcyBwaWNrZWQgdXAgYXQK
ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9qYWVnZXVrL2YyZnMvYy81YWQ5NDA5YTk1MzMsIG1t
LW5ldyBjdXJyZW50bHkKICAgZG9lcyBub3QgaGF2ZSBpdCwgc28gdGhlIHBhdGNoIGlzIHNlbnQg
Zm9yIE1NIHRlc3RpbmcgcHVycG9zZS4KLSBMaW5rIHRvIHYyOiBodHRwczovL3BhdGNoLm1zZ2lk
LmxpbmsvMjAyNjA4MzEtcmVtb3ZlLXBnX3ByaXZhdGUtdjItMC0zNjY4MTU5Y2Q5ZThAbnZpZGlh
LmNvbQoKQ2hhbmdlcyBpbiB2MjoKMS4gcmVtb3ZlZCBpc19maXJzdF96cGRlc2MoKSBpbiBwYXRj
aCAxIGFuZCBvcGVuIGNvZGVkIHRoZSBjaGVja3MuCjIuIGZpeGVkIHdvcmRpbmcgaW4gcGF0Y2gg
MidzIGNvbW1pdCBtZXNzYWdlIGFuZCBjbGFyaWZpZWQgcGFnZV9wcml2YXRlKCkKICAgYWxzbyB3
b3JrcyB3aGVuIHJpbmcgYnVmZmVyJ3MgQVVYIHBhZ2Ugb3JkZXIgaXMgMC4KMy4gcmVtb3ZlZCB0
aGUgZW1wdHkgbG9vcCBpbiA2NC1iaXQgZ250dGFiX3BhZ2VzX3NldF9wcml2YXRlKCkuCjQuIGNs
YXJpZmllZCBmb2xpby0+cHJpdmF0ZSB3aWxsIGJlIHJlc2V0IHRvIE5VTEwgYnkKICAgZnNjcnlw
dF9mcmVlX2JvdW5jZV9wYWdlKCkgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgo1LiBjbGFyaWZpZWQg
d2h5IGh1Z2V0bGIgbmVlZHMgdG8gcmVzdG9yZSBodWdldGxiX3ZtZW1tYXBfb3B0aW1pemVkLgo2
LiByZW5hbWVkIHJlYWRhaGVhZF9mb2xpb19yZXZlcnNlKCkgcmVhZGFoZWFkX2ZvbGlvX2xhc3Qo
KSBhbmQKICAgcmVpbXBsZW1lbnRlZCByZWFkYWhlYWRfZm9saW9fbGFzdCgpIGJ5IGFkZGluZyBh
IG5ldyByZWFkYWhlYWRfY29udHJvbAogICBwcml2YXRlIG1lbWJlciwgX2ZvcndhcmQsIGFuZCBh
IG5ldyBoZWxwZXIgX19yZWFkYWhlYWRfYWR2YW5jZSgpLgo3LiBhZGRlZCBhIGJpYXMsIDEsIHRv
IGVyb2ZzIEkvTyBjb3VudGVyLCBzbyB0aGF0IGZvbGlvLT5wcml2YXRlIHN0YXlzIG5vbgogICBO
VUxMIGJldHdlZW4gZm9saW9fYXR0YWNoX3ByaXZhdGUoKSBhbmQgZm9saW9fZGV0YWNoX3ByaXZh
dGUoKS4KOC4gY29udmVydGVkIG1vcmUgY2FsbCBzaXRlcyB0byB1c2UgZm9saW9fdGVzdF9mc19w
cml2YXRlKCkuCi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDcz
MS1yZW1vdmUtcGdfcHJpdmF0ZS12MS0wLTE0MmM5N2JhMzU2MkBudmlkaWEuY29tCgotLS0KWmkg
WWFuICgxNCk6CiAgICAgIG1tL3pzbWFsbG9jOiByZXBsYWNlIFBHX3ByaXZhdGUgd2l0aCBwb2lu
dGVyIGNvbXBhcmlzb24KICAgICAgcGVyZi9yaW5nX2J1ZmZlcjogc3RvcCB1c2luZyBQR19wcml2
YXRlIGFzIEFVWCBwYWdlIGhpZ2gtb3JkZXIgbWFya2VyCiAgICAgIHhlbi9ncmFudC10YWJsZTog
c3RvcCBzZXR0aW5nIFBHX3ByaXZhdGUgb24gcGFnZXMgZm9yIGdyYW50IG1hcHBpbmcKICAgICAg
ZnNjcnlwdDogc3RvcCBzZXR0aW5nIFBHX3ByaXZhdGUgb24gYm91bmNlIHBhZ2UKICAgICAgbW0v
aHVnZXRsYjogdXNlIGRpcmVjdCBhc3NpZ25tZW50IGluc3RlYWQgb2YgZm9saW9fY2hhbmdlX3By
aXZhdGUoKQogICAgICBmMmZzOiBzdG9wIHVzaW5nIFBHX3ByaXZhdGUKICAgICAgZXJvZnM6IG1t
L3BhZ2VtYXA6IGFkZCByZWFkYWhlYWRfZm9saW9fbGFzdCgpIHRvIGF2b2lkIGZvbGlvLT5wcml2
YXRlCiAgICAgIGVyb2ZzOiB1c2UgZm9saW9fYXR0YWNoL2RldGFjaF9wcml2YXRlKCkgaW5zdGVh
ZCBvZiBkaXJlY3QgYXNzaWdubWVudAogICAgICBtbS9wYWdlLWZsYWdzOiBjaGVjayBwYWdlL2Zv
bGlvLT5wcml2YXRlIGluc3RlYWQgb2YgUEdfcHJpdmF0ZQogICAgICBtbS9wYWdlLWZsYWdzOiBp
bnRyb2R1Y2UgZm9saW9fdGVzdF9mc19wcml2YXRlKCkKICAgICAgdHJlZXdpZGU6IHJlbW92ZSBm
b2xpb19zZXQvY2xlYXJfcHJpdmF0ZSgpCiAgICAgIHRyZWV3aWRlOiByZXBsYWNlIFBhZ2VQcml2
YXRlKCkgd2l0aCBwYWdlX3ByaXZhdGUoKQogICAgICB0cmVld2lkZTogYWRqdXN0IGNvbW1lbnRz
IG9uIFBhZ2VQcml2YXRlIGFuZCBQR19wcml2YXRlCiAgICAgIG1tL3BhZ2UtZmxhZ3M6IHJlbW92
ZSBQR19wcml2YXRlCgogRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVpbmZv
LnJzdCB8ICAyICstCiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Zmcy5yc3QgICAgICAgICAg
ICAgIHwgIDYgKy0tCiBhcmNoL3g4Ni9ldmVudHMvaW50ZWwvYnRzLmMgICAgICAgICAgICAgICAg
ICAgIHwgIDMgLS0KIGFyY2gveDg2L2V2ZW50cy9pbnRlbC9wdC5jICAgICAgICAgICAgICAgICAg
ICAgfCAgNiArLS0KIGRyaXZlcnMvbWQvbWQtYml0bWFwLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgNiArLS0KIGRyaXZlcnMveGVuL2JhbGxvb24uYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgNSArKysKIGRyaXZlcnMveGVuL2dyYW50LXRhYmxlLmMgICAgICAgICAgICAgICAgICAg
ICAgfCAxMSArKystLQogZnMvY2VwaC9hZGRyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICA4ICsrLS0KIGZzL2NyeXB0by9jcnlwdG8uYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMiAtCiBmcy9lcm9mcy9kYXRhLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgMTYgKysrKy0tLQogZnMvZXJvZnMvemRhdGEuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDEzICsrLS0tLQogZnMvZjJmcy9mMmZzLmggICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICA4ICsrLS0KIGZzL25mcy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgNCArLQogZnMvbmZzL3dyaXRlLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAyIC0KIGZzL3Byb2MvcGFnZS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMSAtCiBmcy91Ymlmcy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDggKystLQogaW5jbHVkZS9saW51eC9idWZmZXJfaGVhZC5oICAgICAgICAgICAg
ICAgICAgICB8ICA2IC0tLQogaW5jbHVkZS9saW51eC9rZXJuZWwtcGFnZS1mbGFncy5oICAgICAg
ICAgICAgICB8ICAxIC0KIGluY2x1ZGUvbGludXgvbW0uaCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAzNSArKysrKysrKystLS0tLS0KIGluY2x1ZGUvbGludXgvbW1fdHlwZXMuaCAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNCArLQogaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmggICAg
ICAgICAgICAgICAgICAgICB8IDQzICsrKysrKysrKysrKystLS0tLQogaW5jbHVkZS9saW51eC9w
YWdlbWFwLmggICAgICAgICAgICAgICAgICAgICAgICB8IDYwICsrKysrKysrKysrKysrKysrKysr
Ky0tLS0tCiBpbmNsdWRlL3RyYWNlL2V2ZW50cy9tbWZsYWdzLmggICAgICAgICAgICAgICAgIHwg
IDMgKy0KIGluY2x1ZGUvdHJhY2UvZXZlbnRzL3BhZ2VtYXAuaCAgICAgICAgICAgICAgICAgfCAg
MyArLQoga2VybmVsL2V2ZW50cy9yaW5nX2J1ZmZlci5jICAgICAgICAgICAgICAgICAgICB8ICA3
ICsrLQoga2VybmVsL3ZtY29yZV9pbmZvLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
IC0KIG1tL2h1Z2VfbWVtb3J5LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAr
LQogbW0vaHVnZXRsYi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICst
LQogbW0vbWlncmF0ZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICst
CiBtbS9wYWdlLXdyaXRlYmFjay5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgKy0K
IG1tL3Ztc2Nhbi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQog
bW0venBkZXNjLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCiBt
bS96c21hbGxvYy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjQgKysrLS0t
LS0tLS0KIHRvb2xzL21tL3BhZ2UtdHlwZXMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MiAtCiAzNCBmaWxlcyBjaGFuZ2VkLCAxNzIgaW5zZXJ0aW9ucygrKSwgMTM3IGRlbGV0aW9ucygt
KQotLS0KYmFzZS1jb21taXQ6IDVmNGMwOTk5YjJiZGUxZmJiYmEzYzQ5OTIwOGI0MTU0NDdjYTRj
N2EKY2hhbmdlLWlkOiAyMDI2MDcyOC1yZW1vdmUtcGdfcHJpdmF0ZS1jZmU5MjZjN2Y4M2MKCkJl
c3QgcmVnYXJkcywKLS0gIApZYW4sIFppCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
