Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0125C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:From:References:To:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nqkT2Nzj6wbzQza0PKk3FCdqRpRMTzrjcRTENvCwKqw=; b=HbKBqYgINVAy9O1HObaImwFbWL
	vKsR77aTOBlq8/OS/Uri7QGTn8e85j4EnF6r7Xaz0KF3YBuFu9SnHoo5auDqBR3AD/Yw18y74Bh82
	64LhWs5GMKwckVYTCHOFCLTFso9SfgysFWk2tCor+87g4krVfbIUcHEwj4YhNtijdeEc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjGsj-0008Nf-HP;
	Mon, 13 Jul 2026 13:39:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@outlook.com>)
 id 1wjGsi-0008NX-2Z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 13:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gvHSZpZQXMyCnwq/4KUUOj7SAfcxye9b2ipsngCcvao=; b=Ilxgf4Hb4HqHauifVcAlgEnpOJ
 fu5n6CDOO2OqxBZ7+Cbt07qOxq9JilCeuQTPQpNc7zcnfOdvngkpgF3KTbUA1JAM4PdBMzVjRHYOh
 QPaYwPiNfai88C6leXLB2RXVv8yaeDQuGOLKXzPGcGT/PiyVUsALi3G49vAIzok0wPco=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gvHSZpZQXMyCnwq/4KUUOj7SAfcxye9b2ipsngCcvao=; b=ELqcatcKA6XllujTqDsJq0P4Ev
 qfgvySlayok9WY9HOWPKAXpk8KNgC8iiDMgySgiBB/xN8/Ac+XQxdYKf04bNIPAvYXJXFcI8tPvn5
 QRdov5+Td1SL529oHj2x1Pdp0bPjARUJaXUTvvIK/u7u0oeFazZF2dGSPh/RDZTTDR5Q=;
Received: from mail-japanwestazolkn19012060.outbound.protection.outlook.com
 ([52.103.66.60] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjGsg-0005m0-Ge for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 13:39:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmV0UrUSVPnkuHu2MiD0vgihMAnteEdaPk0r/f1Gui/ItTrk3LkDer+x1QaJHPY3QITlviKeifJARKmMJ7O9vqQ3575ub3nobv4p4lOKTMS7WS7wAcvul+Fuc/qj7z9736HgegEEgd0SWdboFKFThQyUpQHJgHvYwXxEBwuEGmh/9ZbgaF2KwX4UWRf1cpGvO0Bxbq6heTOOg5o5tF89HaHUkxhH5szqaoM/irE+NGxm2ECIf4AWtY5cUcPpH+BJwgH9e5kzIyBbiuQ5zTum+EvORHob4BpsNHlHyRhxKx3j4EVpAWJoFRTYvPHxBH+xRpjAMJ7fZfLz/DOPOsvrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvHSZpZQXMyCnwq/4KUUOj7SAfcxye9b2ipsngCcvao=;
 b=s3gv5T3QwCi58W3JCEvN1JSG713dcp3b6CDtNdBHDMmynQLH/nS8hUHvRtt11lpBkLipGN8cYbFAjwF4sir37aDpsl2YyUTvn0sIXAmDd3tAKRc95iqYGEIzfUev7CokcHYFoICvclLmAaMo48xA6Yzo2Kc22p/8zZult320kUtPmsQ6+6BojQ9HeT8L8hoRP5/2ncpwfFs5MvHFdtk1yDJJJczzHfSClkiWzR1E4ncAWAUCYzYlI/5sChIVQ4Oj7rkG6kti0cfIHKb/OBeXHHfIcS4h95PBQZbPq+q9abci1QkrEjRNCpl+G2YUF9BfM5SzmTy3l+fyQ5b4AAm5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvHSZpZQXMyCnwq/4KUUOj7SAfcxye9b2ipsngCcvao=;
 b=QR+ehR9ve00JS94dYsakPcExGza0cqEY6w2CTebw/vswR4Gou2+jhOmpF59roRXbDR2mnIhuOoZ73V/PoFtSvUWcRWuIfPciwyV6SLcMmATkWeiXnstalYFYzwllyYvHjbKQMpx7VqocDlAOytMv5guwGRfyzTttD2GbpOpvM2o0E8ZbGB0H94Gq+kYmIkAyDBWCmbkAr6ix4Ou+Yme/RcsiClQgWd8Se4bE9/U+tbCL9buE3/WihgaJEO1nDPLGUMc5Q+WLwMDtXsznGzls2y90nBoQn8h1I6pcKopSaxWTWagr2TeXmunz1gCbpvbvWLpjP5uca2hiiGlVQw8lwA==
Received: from SEZPR02MB5662.apcprd02.prod.outlook.com (2603:1096:101:4e::13)
 by PS1PPF15016DFCB.apcprd02.prod.outlook.com (2603:1096:308::286)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 13:39:25 +0000
Received: from SEZPR02MB5662.apcprd02.prod.outlook.com
 ([fe80::e4bc:d995:70f6:5b72]) by SEZPR02MB5662.apcprd02.prod.outlook.com
 ([fe80::e4bc:d995:70f6:5b72%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 13:39:25 +0000
Message-ID: <SEZPR02MB5662D6AE1DC030A20333BA2D99FA2@SEZPR02MB5662.apcprd02.prod.outlook.com>
Date: Mon, 13 Jul 2026 21:39:20 +0800
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
References: <20260529085629.2664539-1-yangyongpeng.storage@gmail.com>
 <7862f9d0-278f-4bf8-ae6b-9413dc52f841@kernel.org>
 <akZ161iaNMoem0wy@google.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <akZ161iaNMoem0wy@google.com>
X-ClientProxiedBy: SI3PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::15) To SEZPR02MB5662.apcprd02.prod.outlook.com
 (2603:1096:101:4e::13)
X-Microsoft-Original-Message-ID: <f6978089-e2c8-447b-afd5-8a2b890734d9@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5662:EE_|PS1PPF15016DFCB:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cec8d1-c804-4097-d600-08dee0e426c2
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|45011099003|23021999003|19110799012|8060799015|6090799003|41001999006|5072599009|7042599007|15080799012|22091999003|24121999003|51005399006|12121999013|25010399006|10035399007|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cC9MTDZSZ1lBSTFQYm9yVlU5QTNxVSswSVFUQ3NLSzBnOHhnRHZQWE00WVIw?=
 =?utf-8?B?QXZkSWNRd0VOUUdrbTFmdkFwUThqSnhTdmEybEdJZmJXeGgxaXZFaG9oT2lL?=
 =?utf-8?B?TzgyYlM0eDNoZ1ZFdjdGK29MSDdKZUN6STlkenhUeDZScWg3U2k2YXNzVHBJ?=
 =?utf-8?B?NjdIQWpqMkRZK3J1Q20weVVCNzFPZWo0cnI2ZEdUMVRSU3RWWkVpODduTDhi?=
 =?utf-8?B?N2lMZU9UVlQxRXR1NkdGUENUMFRWRURyMi9HMEM5Z1hIVkVvTGxtUUdpSTdj?=
 =?utf-8?B?SmJ4dzVhQ2RacnpVMjdtd3J2ZkkyeVBTQWlPSStoOHRxeE1uZUw4UGIxeWNa?=
 =?utf-8?B?UFpoTVFxd2FNNDdJUnIwOEtNb0FsZ3lKZEtCdXR3UHZURVZPNkpBTjIzOTg4?=
 =?utf-8?B?WkwrMVU4bE1sd05ENUhxTzAvYndQWHZnZHgzeC9CdWdleENyYWtUTENPVzh4?=
 =?utf-8?B?b1hXODFCZjg1TVdLNW5Famp3OUFDQ1NHVThrYXJDeCtDeVlySXU1MXpZcGFG?=
 =?utf-8?B?MmhoU2k2eERSQ01RTGRQSUFUYVZ1VExMQWtCQXhIekQ0T0toV3RGdWE4TURy?=
 =?utf-8?B?Ym1wY040dCtuTFV1L0d1TjF2SUtCREU2V0FudEt4cTMxTjBtRlZDQkFQQWoz?=
 =?utf-8?B?R0Z6REhtcU4rNUJENGRDaHo2ZjgrRldJQ0Z2bjgrL1dlZldQaDk1Ky85Nnhp?=
 =?utf-8?B?Yk1MdXNWVi9TOFJzVGZEZnFOdklBeVFtd0ZTeGZWcHlSVHEwd2I3amtnbDVD?=
 =?utf-8?B?M04wL2xqU2F1alA3V0xCRWM2Qm5tY0lsSW41NDY2QWNyYTJzc09wUmJXdnVO?=
 =?utf-8?B?QmtPa3Roc3VrVEdLMXJqaWlNZzBnVzZ4cW5qcDBwL1ZUaTN2eWJMVTFCbUhV?=
 =?utf-8?B?U2JLOHBIdEM3ekpsVm1yM3Y4ZEc1c1ZjbEVEOEFIMzR1NGUvUlYvNDNHeEJD?=
 =?utf-8?B?aFVIQUlkODNVYXM2RHJ5QlRUUDlhcEsvUXkrRFpSbTBRMVJNZlRlUWpqMllW?=
 =?utf-8?B?TEl2Wm5aRnpzeitDTlVpaDlyanA3UWxoZkxwbXoxb29PRURhNU1oZTVPaVhq?=
 =?utf-8?B?KzA3K3o0RUdjUEFweDFKRlVyOXBpbGFZUXNrbzJZbFZNTnlIRlhjaGxlMlFk?=
 =?utf-8?B?Tm92SXBvMDhFUTNJSVVDUjJwbmlJV0tBNjIzVjF6SFIzK21MMmYzZUtJa1B5?=
 =?utf-8?B?T29kWUNDR1I2TmExMHNYV2I2cmZIbmhLZXVqWEV1UFpQc3NSYzVkRkxLREFO?=
 =?utf-8?B?WW40c0psUTM4RVFHbXJleU44UUVUamlFdmpmRjFMVmdVbG9yek9nSVBHZExu?=
 =?utf-8?B?QjVzajdLYytkREp0Um1nYnRmR1c3REN2WXZYeWNXNklvcFlISisyVUpQMWQ4?=
 =?utf-8?B?Z3I5VWYxOEVaVHlNekxOWjFLS2RJdnpnbmZsRVZQN1I1MjBwTjV0andrYlE3?=
 =?utf-8?B?aSsrSFkrY2NTb1JBZ3ZLQmFJN2tsY3N6c2pLejFkN0tGZi9PZzFuTEZSWjdX?=
 =?utf-8?B?OGtvWnBuSERDMWQzdHdwUXZGV2JHVkhtY0d6VFFzUnFIOEVXQURoaGFReUkz?=
 =?utf-8?B?dC83dz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZMMHFGaXJVZldEaWxGdGZzL2J0bGRQalI0V3Z2azMyK2RJbFY5UTVSQWdN?=
 =?utf-8?B?S2hJQ1Uwb3lOTkJ4Sk4xdkZ0VCt4cExzL1VLT2NaK2J6SHZvVDB1N1o3NE5j?=
 =?utf-8?B?alFTQ3RReURzZVAyL2EwNllaaVhwT2lEK0JkNkhmdlpJTVpMSkdPVlFKNjls?=
 =?utf-8?B?eGpHck03YWlYbEJBWkNOVGo4Sit5TW42alJFMXI3MDU2Q3gxK0lvRVNGYzl0?=
 =?utf-8?B?L1JrbDZlSlJjRXVJd3FMWFJYdHdwUWpMV3VUMFhJNXF2dDVxUnZiMmp1TWNo?=
 =?utf-8?B?SlRSZTZkL043bVZMZUNiZERNZE5KRlltSzJWRktrZ2NPbXh5ZVJjakxYbXBx?=
 =?utf-8?B?d3JUN0hGa3J4M0l1NXRxMThZMy9FQWs3OVR3U2tNNkpLdmV1ZlZEejE0Y0hh?=
 =?utf-8?B?bFJ2ZTVTLzRNK1hXcVZmRVl5SVJnS3Y5ZnE5NXpmVWkzWmM2aVEvK0tmemQ4?=
 =?utf-8?B?MTZOYnlReVRjMDhOS0RqalN1NWhZbk9VNUxwL1pHb2JKcnl6Q2QrekhhY1dn?=
 =?utf-8?B?NUxqYkU2Uk1kMXVyZVluTmJMdUQwM1VMbkp1ZXd2MU9oZ0RGcEJRQTNhZnhF?=
 =?utf-8?B?TDBrUDNZMTd1TnVEbVBFRk1TNHFsRFdieU1qQ3ZFcDd1RVdBQ3NxWHd4L2pF?=
 =?utf-8?B?UnI1dm44SEFWWS9PTm5La3hnaExkakh2OFFhYlBVWDdmWmVPMTJ6cldhNFBy?=
 =?utf-8?B?N0QzeFBNNHMrMldyUitsZDhOeVgrY01pMXJaWWFDU0kxNDZzdmgvY1oyaGtP?=
 =?utf-8?B?OUo0ZXc4Slh4ZFNwanBtUW9tNEE4aGR6M09jZXJ1ZWxGelY5Zk1xbmNFOVlz?=
 =?utf-8?B?bDVjZVl1MzZ2eExFaFZkK1BtOXhid0czREJ2UWw5Vjc3K3ZvWHVpcWJ1YzI5?=
 =?utf-8?B?U2dhcWJFeC95cEJEYmhSY1l1L2poR2dnMldLWXJKWnM0QVA2VkVVVHltRmM5?=
 =?utf-8?B?bHNtSXAxV01yTys0ZnpNMTY1ZmpOZUV2bEFSUVhOZnhtNkt3aDlBWG1oU0dH?=
 =?utf-8?B?NDBzc0VaLzlGU1ErWEdzU1VJNWFmMWhTRFNCYkJIMVd1RGg4U05YSGl5ZWtN?=
 =?utf-8?B?RHByTjgrQjNyeC9CSXNWeUxsV3ZDVnRjWjVmcWpnSXBlS3o5Q2s1OGZpVEpz?=
 =?utf-8?B?c0ZZY25oMXQ0MG1HNjAwN3prbzY3WmlyQ3FDdUZ0VklFeElOYkI1TkY2cEt0?=
 =?utf-8?B?Q0NjOStqU0I3K3Y3UVVId3NRVGZMeHRSZm1RbmNDM001MDB4UDJBVHkzU2Vj?=
 =?utf-8?B?cFRFU1hlRWppdHlvbU5tOUtvaGZhNmw1UEZmSWwyNXdTQUVqREg3ajNndzBL?=
 =?utf-8?B?TFNlZklFMEdraFRXR1hKY0krSEdHQ0loMzRhSWthOWNRTVd0OVVkVU9URVpM?=
 =?utf-8?B?THNJRDZycXNvWmRHZ3A1K1AzbEcwMWRLR01JdkhWSGltb0Jpc3VQTFhjUytH?=
 =?utf-8?B?WU1iLy9sRDlCdXQvaVhHSDVVSHl3YW5NcmlhamdCYkRBb05pZjdEZjJXNVJY?=
 =?utf-8?B?am9JeE9RZ0RIQjhWZWFTc3plTlhZOEg2YWl3cnBrUVJRNll1S1U5di80V1F4?=
 =?utf-8?B?dk9iOUFlSlBDL0ZjUWJTSm9zYmFVbERMR2lQMll2WHR5VjlPYWFXM0tGa0Q4?=
 =?utf-8?B?Qk1PQlVpdTZkZmFrc1NMYzRjM1AwbXRwU2dKSUhubVVYSWRadjc5K3MxREw3?=
 =?utf-8?B?UGpKVktaVWo4OURpUUFnVm1uSWxhSlRlOTdQdGg5REJMNWNBdS9qTzJYTWk2?=
 =?utf-8?B?Vlk5T2tWbWgzN2djOC9FbC9YdFVUbFFFZGxMdmJvY3JhR1NPTmdPVXZDblJG?=
 =?utf-8?B?K1g1Y0J5eDhOZ1MvWlpjbXlHUHo4VTRFd3E2OWJFV254VzdvZkhkWDdqU1ph?=
 =?utf-8?B?dW5lWHJZS2owUjZxVVdjRUdPTUhkVlBoditVMlU5cDJKdENJampzSmFTVUg2?=
 =?utf-8?Q?QzucfYMITpc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cec8d1-c804-4097-d600-08dee0e426c2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5662.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:39:24.6843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF15016DFCB
X-Headers-End: 1wjGsg-0005m0-Ge
Subject: Re: [f2fs-dev] [RFC PATCH v2 0/5] f2fs: introduce inline extent
 mapping for inode data blocks
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
 Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/2/26 22:30, Jaegeuk Kim via Linux-f2fs-devel wrote:
> On 06/25, Chao Yu via Linux-f2fs-devel wrote:
>> Sorry for the delay.
>>
>> On 5/29/26 16:56, Yongpeng Yang wrote:
>>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>
>>> Changes since v1:
>>> - Introduce tracepoints for f2fs_iext_update_data_blkaddr and
>>>   f2fs_iext_lookup_blkaddr to aid debugging (new patch 5/5).
>>> - Bypass inline extent lookup for F2FS_GET_BLOCK_PRECACHE to ensure all
>>>   mappings are loaded into the read extent cache.
>>> - Unify the check for fofs exceeding direct_blocks range to use
>>>   "fofs >= direct_blocks" consistently.
>>> - Remove support for caching NULL_ADDR in inline extent area. If a fofs
>>>   within [0, direct_blocks) is not found in inline extent, it implies
>>>   NULL_ADDR. This simplifies merge and split logic.
>>> - Fix f2fs_iext_enable_inline_extent to use PTR_ERR instead of -ENOMEM.
>>> - Change f2fs_iext_convert_to_inline_extent return type to bool.
>>> - Add benchmark data covering 4K/8K/32K/64K random read.
>>> - Rename __is_extent_mergeable to __is_iextent_mergeable to avoid
>>>   naming collision with extent cache code.
>>> - Remove inode parameter from f2fs_iext_sanity_check (always NULL).
>>> - Reduce #ifdef CONFIG_F2FS_INLINE_EXTENT nesting in node.c.
>>> - Code style fixes to comply with kernel coding style.
>>>
>>> This patchset introduces an inline extent mapping mechanism for f2fs.
>>> Instead of storing individual block addresses in the inode's data block
>>> address area (i_addr[]), this feature packs contiguous block ranges into
>>> compact extent entries, significantly reducing the number of entries
>>> needed and enabling faster block address lookups via binary search.
>>>
>>> The inline extent format is identified by magic numbers in the inode
>>> data area and is transparent to the rest of f2fs -- when the extent
>>> area is full or cannot represent the mapping efficiently, it
>>> automatically converts back to the direct block address format.
>>>
>>> Patch 1: Preparatory refactoring -- replace raw pointer arithmetic
>>>          with f2fs_data_blkaddr() to abstract block address access.
>>> Patch 2: Core implementation -- data structures, extent operations
>>>          (lookup, insert, merge, split, truncate), format conversion,
>>>          and integration with f2fs data/node paths.
>>> Patch 3: ioctl interface -- allow per-file enable/disable of inline
>>>          extent format via F2FS_EXTENT_FL flag.
>>> Patch 4: sysfs interface -- runtime enable/disable toggle and file
>>>          extension list for automatic inline extent activation.
>>> Patch 5: Tracepoints for inline extent lookup and update operations.
>>>
>>> Test setup and results:
>>> =======================
>>>
>>> Platform: Xiaomi smartphone, UFS 4.0 storage
>>>
>>>   # Enable inline extent
>>>   echo 1 > /sys/fs/f2fs/<dev>/inline_extent_enable
>>>   echo 'mp4' > /sys/fs/f2fs/<dev>/inline_extent_extension_list
>>>
>>>   # Prepare data: write with 4K offset stride to create fragmented
>>>   # extents, then overwrite sequentially so inline extent can cache
>>>   # all mappings in compact form.
>>>   fio --name=test --filename=data.mp4 --rw=write:4k --bs=64M \
>>>       --size=8G --ioengine=libaio --direct=1
>>>   sync
>>>   fio --name=test --filename=data.mp4 --rw=write --bs=64M \
>>>       --size=8G --ioengine=libaio --direct=1
>>>   sync
>>>   echo 3 > /proc/sys/vm/drop_caches
>>>
>>>   # Benchmark: random buffered read, 1GB total IO
>>>   fio --name=buffer-read --ioengine=libaio --rw=randread --bs=$BS \
>>>       --size=8G --io_size=1G --numjobs=1 --filename=data.mp4
>>>
>>> Results (random read bandwidth, MiB/s):
>>> +---------------------------------------------------+
>>> | BS     | baseline | inline ext | improvement      |
>>> |--------+----------+------------+------------------|
>>> | 4K     | 35       | 36         | +2.5%            |
>>> | 8K     | 60       | 62         | +3%              |
>>> | 32K    | 179      | 191        | +6.8%            |
>>> | 64K    | 284      | 321        | +13%             |
>>> +---------------------------------------------------+
>>>
>>> The improvement comes from eliminating direct/indirect node page reads
>>> during block address lookup -- all mappings are stored directly in
>>> the inode page and found via O(log n) binary search.
>>>
>>> Yongpeng Yang (5):
>>>   f2fs: replace raw dnode pointer arithmetic with f2fs_data_blkaddr()
>>>   f2fs: introduce inline extent mapping for inode data blocks
>>>   f2fs: support setting inline extent flag via ioctl
>>>   f2fs: add sysfs interface for inline extent management
>>>   f2fs: introduce tracepoints for inline extent lookup and update
>>>
>>>  fs/f2fs/Kconfig             |  18 +
>>>  fs/f2fs/Makefile            |   1 +
>>>  fs/f2fs/data.c              | 157 ++++++-
>>>  fs/f2fs/debug.c             |   4 +
>>>  fs/f2fs/dir.c               |   9 +
>>>  fs/f2fs/f2fs.h              |  23 +-
>>>  fs/f2fs/file.c              |  93 +++-
>>>  fs/f2fs/iextent.c           | 873 ++++++++++++++++++++++++++++++++++++
>>>  fs/f2fs/iextent.h           | 187 ++++++++
>>>  fs/f2fs/inline.c            |   7 +
>>>  fs/f2fs/namei.c             |  48 ++
>>>  fs/f2fs/node.c              |  66 ++-
>>>  fs/f2fs/node.h              |   4 +
>>>  fs/f2fs/recovery.c          |  17 +
>>>  fs/f2fs/super.c             |  13 +
>>>  fs/f2fs/sysfs.c             |  52 +++
>>>  include/trace/events/f2fs.h |  79 ++++
>>>  17 files changed, 1635 insertions(+), 16 deletions(-)
>>
>> It's quite a large number of change (including f2fs-tools change) to support
>> this new feature, it causes the performance price ratio a little bit low.
>>
>> About inode disk layout, as we discuss offline, maybe we can add 4 or 8 ...
>> extents in i_extra_attr area of f2fs_inode structure, it can reduce the
>> change line and code complex, however, not sure how will it affect the
>> benefits.
>>
>> To Jaegeuk, please share your thoughts on this feature.
> 
> Agreed. Can we try to add more extents simply?

Thanks for the feedback and sorry for the delay! Here is a simpler
design I'd like to propose for adding more extents:

1) Shrink i_compr_blocks from __le64 to __le32, reuse the freed upper
   32 bits as a new field: i_inline_ext_capacity.

   The in-kernel fi->i_compr_blocks is already atomic_t (32-bit), so
   the 64-bit on-disk width was never fully utilized.

       /* before */
       __le64 i_compr_blocks;

       /* after */
       __le32 i_compr_blocks;
       __le32 i_inline_ext_capacity;  /* # of extent entries */

2) Place the inline extent area immediately after i_extra_end[0].
   The area format is: struct f2fs_iext_header followed by a
   struct f2fs_extent array, reusing the same inline extent format
   from v2, but without the magic number (since i_inline_ext_capacity
   already indicates the presence and size of the area).

3) Prohibit compressed files from using inline extents.

   On little-endian, the split maps to:

       offset +0: i_compr_blocks        (original le64 low 32 bits)
       offset +4: i_inline_ext_capacity  (original le64 high 32 bits)

   For compressed files i_inline_ext_capacity is always 0, so old fsck
   reading the full 64-bit i_compr_blocks gets the same value as the
   new 32-bit field. For non-compressed files i_compr_blocks is 0
   regardless, so there is no conflict either.

4) Include the inline extent area size in i_extra_isize.

       i_extra_isize = base_extra_size
                     + sizeof(struct f2fs_iext_header)
                     + i_inline_ext_capacity * sizeof(struct f2fs_extent)

   Old kernels use i_extra_isize to skip the extra attribute region,
   so the inline extent area is simply invisible to them, it will not
   be misinterpreted as i_addr[] block addresses.

5) i_inline_ext_capacity is configurable at mkfs/tunefs time. When it
   is 0, no extra space is consumed beyond i_extra_end, so there is no
   impact on inodes that do not use inline extents.

Please review this layout modification.

Thanks
Yongpeng,

> 
>>
>> Thanks,
>>
>>>  create mode 100644 fs/f2fs/iextent.c
>>>  create mode 100644 fs/f2fs/iextent.h
>>>
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
