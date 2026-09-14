Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA0BC88E67
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:In-Reply-To:References:
	Message-Id:Date:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b4hRPcwYsyAjvdGAPdJRLqQLFf9G74RY3bmDxtamXsE=; b=kHeCO+JMaDO+cl+sTiiqFAMmoQ
	2QwIQFGQyNB1QVNmZ8pOqHMo7+tXiPu7qTmSeeh99yHxaUnTm+6McM1Ejmvi9C5MeunaJHK4f0UDB
	Mq9A3ufN+qLiR0cuzqbAAGVY5phP3PetoEIbWe2D1aAz1LNIBiBSX/Fkr+SvIzV1gnlo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5yhz-0008I3-Px;
	Mon, 14 Sep 2026 04:54:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ziy@nvidia.com>) id 1x5yhy-0008Ho-Lj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 04:54:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Cc:To:In-Reply-To:References:
 Message-Id:Content-Transfer-Encoding:Content-Type:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HasRKPn3UDqP5j5UF+LW8uyeu9a77x8SVglJqgdfW8M=; b=ZVQ32cEeEvIsfHifeZ8hG/qlYX
 aX/nEhbQsvNR7nSW1cIIpsgUeeicB1WwPteCXF7hf0WSV8C8FNeq7PZ+DA2PRcvohuglmsl4I3uIC
 dJfxpKo7hFRz68fiEHuGfPt8Mh17AoCkXaZ8Kjl5ezAqUc/XkVEhpC7nDpd9srIV7uBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=MIME-Version:Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HasRKPn3UDqP5j5UF+LW8uyeu9a77x8SVglJqgdfW8M=; b=AAnZ04+1UIFVzzkoAhiY4g77o7
 Py7V+gGDOa31iT6e6tAzLETmoZRYm4kqk45nKaRDqlm/mesUvFf/HeLtP6UaxvV3YvyTZgNg5A51g
 BuXI7hES/BTXpta8kHNcsFljx77bY1R5zrK4CWzf3EZ5BPAEW44enlOs5Z6VVAapCEeA=;
Received: from mail-southcentralusazon11012027.outbound.protection.outlook.com
 ([40.93.195.27] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5yhy-0002Mh-2Q for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 04:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgp73E2sj2Hv8jbKvCB3wBmyHiHwJEmDetP+5PkqYMUR9Fk5EIU7G/GdlXqLO+5QGtQzUrnUfFFsqTGdeP2qrqx/pj2GUHD8AT27gnX3HfnIn+JE83xhoweoUsrUNw8ziOfME1gmdcE4O++04MSj5Pe6GiwRJLYjTxFav/uVsy/XWzDCEQ+BH+hAqQKH3yoEeWhQD5T6wZ+vM7+BZhqCQ/KcANKQlhl+8ptifrCbVeoQkm8RuuNiayeFT45d9uNw+0+/Gb+b9xQP/NdXD40x7Delvci1dCONWG8VZEdoVe8nCDMGTc8FF/EG/ZG0iQkzMBztn3WiijlaqjFdpJrFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HasRKPn3UDqP5j5UF+LW8uyeu9a77x8SVglJqgdfW8M=;
 b=UitOy4NiMyJ5pSoAq1cOwAV84ygZY+PUivIk2AFcKfb4H2bpE+sh3dwqbFaffNYAHSVz2evzM5TL8ANwzqr1UkKas0iacVDNZgv22698bCrpocMWtAIdx1Z1BePsJg0aVm1ZtK/WDvFuzwd/X8d5gdgNjQdamNK9hzAxWb1cJp5c2N28JfjqHRk/f9LT0ybXvPYxkH7aAx9ox+J1Si9aFMmbfSPesFitE7X+FQ6X0oJZYo8qgU/uVXP6idcxlTh9sj+FOOh3uNNGyQeEbBKzoJaHE+qVo4vhZaA4GBSeXIH94RFe11RMl18u90w2WBd4HUc9AOwaQJxGBaLxOI2IWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HasRKPn3UDqP5j5UF+LW8uyeu9a77x8SVglJqgdfW8M=;
 b=g38Bk7h/2nsGglUO9xeMYGgeizJzm5ah0Di5VUmdcxYfq2dBlujfcuV5ZwwG93JCLbPQPbRYKBW+KetYJEOTmaVeosWdZCmuAsG6COLF43C95FJJfCpBaniiwn8zq32GKOzle5XTqsk4Z9gS44zMdodhQghVomU1zVQDtEiDTetgRbLOGqEHWPmJUqhn9PocD/AaFAcchRyeU9fTLMc1lAu0ILIkkOyV21zy5wFRiO/IN0Fano5tc+UgCGBXgcNDsF5FD6oHcN4r/KLns3oBKBmMIa/GT6dYRv5lq8oLFArzxcwpTLm6HRFFjchjpZFOmwflfFj2TihPXQ7LDRUWRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 02:24:19 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 02:24:19 +0000
Date: Sun, 13 Sep 2026 22:24:04 -0400
Message-Id: <20260913-remove-pg_private-v4-6-848550f7574e@nvidia.com>
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
X-ClientProxiedBy: BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::24) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c02016-ad4e-4665-c382-08df12074840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 6xaKpcsb+7Ggr65nmvoxRDgpxTIMa9AX/IXn9IPXGPfIyAQKocr9uNvmxMcACkfekf65Gtndru7w/M37mKzP338ZfYTjrXx41F37EKHKFBrgP4V38pD5tiItTUWHebqKl0A2pp3+jAXgsahSBAsTRISuC02Mnom2LZrrua1X8Zwq++LPapoDUhdoYYgP8o2WSLbJjEbE85RQBkMnW/tZwUsX4aCc2T0btH7lSlr7G7FcVe0lJYzor1yXRcyee2+TkQYCnCnd3ZlpKRdjYSuZGEeuNdYnI0Tu2PIoBUyues3P3gnNepo00LjvN+C9LLf8a7YU+TuGdsS3ltxiNfPTMIFWRtRkW+ND96JmPsWKh4MFDe3jJvLMC3ohVVY/fPsWenT1AKapYxc/CGUkACFJ/zSopHuPiKzFAApu7IRxfzZre71YyfmMSU7IW+3BAsSQss6oXh0ZK4yGNP4sh2FjD55zjNmLsb4xVuwsnMQRRwj89HrbrKhFu8SHpCdeJo1MFsP8Xhx6Th6ye/RgsUUPM2rE+sBBTHQtdode/PDL8M0Ax0dmlaQkHm/V2ZRCYX6L/iDrQLZQJwsa2gJB3tOnjlaHXqvj/1RU9FrhK9Cn10iNb07OhcrlR/dgObGXcl9IJBFh4N9DpjP4f59wS29dE+/I6dbIgNK9MMFGMaT2wp+YYRLJ9pYvA693DCIunWZWA2+ygME93Fw/0QBrpHF28w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9YYjd1SDNIMXpScGtUVC9EdU54dElhVmdoc3ZVMU45bnV3bGMrWTNMM2Rx?=
 =?utf-8?B?cjdQWE1kZ0FCOTJxWTdQK1ZqN0RFYUVHeitHUkFKWVJXMHIreWo5S3pjcmY0?=
 =?utf-8?B?S2ZLcEVUc3I2NXM3NE1NL1p1c1ZuRVo3ekdyUWpxcDhyZXhoMVFFdlNJU1Vq?=
 =?utf-8?B?dWFrTmthTEJRWE84WjAwMk5iUXNlT3h2V3k3WmFQWXA2b1NxY2NpR3JrSHhR?=
 =?utf-8?B?NXF0aGw4NDhDSUxzMDVrZUhkOFZqWko0RmdPN0ZsdzJUTy82NnVQWnVHUzhQ?=
 =?utf-8?B?MWZRZXhqOCs5Y25Vb29hczdlem11S0VyN2MrMk5iSUpmOXhNNG1ma1BOMUVI?=
 =?utf-8?B?ZXUzamRSdnltVzRXU0R3UWxHREEzNlNQcFJxRGNSeTlydytKQlRyNjhGRTdZ?=
 =?utf-8?B?MVlzdkpSQ3lHVmhhRFlaaDNTU0cwM1dSdFExUHhTNTkycENUQ044MU5aeWsz?=
 =?utf-8?B?V2E3R282VEtzNm5oREJlb2x2UWZ5TjFvNnQ0RjN0MlJ3cEtYWW8wZGpuK1Nx?=
 =?utf-8?B?ZUNZS2kxZnQ1dTVjTHhLak1XZ0o4QUxrT1NOM2F3K0VvaWcyMllHUmtjMDNt?=
 =?utf-8?B?WkozNjk5OVBDdStjRjZ5VkZKb0dyVTZhL0lPVjhOMkVDWncvcmQyRi9IRlpH?=
 =?utf-8?B?WmM2U1lzVFlzLzJKOHl3dG1SWlhSM0hCcGV1SEs4SThGZnEzTWtDVDBTUXNZ?=
 =?utf-8?B?Z2MwdDBvelM0dHk0Q01XMC9GVi8xWG12UHZDM2llTUJjdjJCeGVZQ3ZocGRP?=
 =?utf-8?B?RTJES0g1bTRxVjdXbnlPZGc3MndqUHpKa0xkQkVEeTlzU1hDK2NuSW1nUWx2?=
 =?utf-8?B?VkladWNFL2VFT3NNNmhnS2hlbnVjNFd2YWJsUjY0c1JvR214aTl1UmVPbHB6?=
 =?utf-8?B?M1lCZ3JHSzdpNi8yVmZoMXA4THNHZ2ZPbCt6Ym5ncEkrcW1WTlJsYURna0NQ?=
 =?utf-8?B?VitaYUEzaXNsSTgzakhqMi9qT3Q5QVRJYkJpKzY2ZVV0OFQvbm1KS0dZUGlX?=
 =?utf-8?B?MzlORTVjalZrK1FRUG5BbzEvc0I0RUdwUTgrWHE5VmRnR1JYaGdMM0d2NHU1?=
 =?utf-8?B?eDR3cTF3Zno4aFJRbkRuZTVqaTdEUHdic0greHcxRlNPdmt0MDY5RlI5ejJm?=
 =?utf-8?B?Q3diU2JUM1RqbTZBNkFhWUhFVzZpRVhpSHBZZGNYZWpCVXUrK0dVUzdSbHIy?=
 =?utf-8?B?TlIzeVdiQkZxemZQWHRoMS81U1V1cXV2N3hRVEtCb05WTHR6RjNPcGZLNWlN?=
 =?utf-8?B?ZUExb2dQUXNCUDRFL1QvMTQ5YTRSdU1heGtJT2NwNGoyT090b2JRNDlxUWM1?=
 =?utf-8?B?QjI0c1A0citvZThac3h6V3EyZTNKeFhraEV4Y1NUVlJkdERrWEh3MEVrNEx4?=
 =?utf-8?B?d3JpcCs3cHcyTjhoNVlCU05mQ2wybjR1Sk00eWp1M2s2dWhIV1JJK1NadVFQ?=
 =?utf-8?B?K1FCWVRPbFBGRERsNytXWTY2Lys4SmlnZkV0SExDV0pHd05sMCtqdEg0eS9C?=
 =?utf-8?B?clpqTStYVVF5L0d5dlduYW9OQnMrNjFMazZsek5aMGQ4WjA1VmFnU0lIWlFM?=
 =?utf-8?B?d0tiQU8zTStNSnBaY0tpTnh2Q3ZLNm8reVVhV2ZrNi9vZkpGZnVjc2RXNUpt?=
 =?utf-8?B?RnBIK2w3N2h4MTgyZWlzSC94bDNCVFpGSitJanhBSk5wNnA1blpJY2xwamxz?=
 =?utf-8?B?d0tsRHhEUUpNaWU1SkQ1ZEJ6QmRTMDcxYU5lVGp5ZDlLTWFER2trVStwSFk0?=
 =?utf-8?B?Mk9ZZ1lDL29XWmFvZlZ0eGgrbGQ2U1Q2ZldyTHkvRVFaaU42T1UxbEtpcC9x?=
 =?utf-8?B?d2VVdVgycjg0bGFsUkxtTnNlMHlHY1MwSVc5WkJBOVhFaVBodkV1dUJrSFZp?=
 =?utf-8?B?NU1MWFFNQWtXUGc3Smh1STIzTXByMUMrYks0bEQwcmQ4cGdldURHOVpVZUxS?=
 =?utf-8?B?dEVGMytha29sWlhZVUorbXh6NTZFRkcrMVdXVGJyaUZ2ZUVSN0h6bURuVk1y?=
 =?utf-8?B?Y3NxMWNZWkExdlFrYmphZjljd0UyUGhxejRmNmxzNlpKMVB3NEJKOFZzVXIr?=
 =?utf-8?B?bFVSQjJGUTZsNHF1aVBzc2F6L3RCVUkwRm1jalY3SVpSTTJ2SmFFVE9MaldG?=
 =?utf-8?B?a3ZqVTgvSGVKWkdsTEFndkU1amdyT2pCRW14NEZFdnBFbGdqZWNuQjEyK1lX?=
 =?utf-8?B?aFgyZlMvcklFR0JHb2JPVEh2U2JKSHlKYWtyT21qcSttckx4aW80cTc0cEwy?=
 =?utf-8?B?SE5DSXZ2WFNzdGtqcmF5MndRZ0VZTG1nTXJnajNTRmNLd3QvUitUeVlGUTE0?=
 =?utf-8?Q?Xl9gqi+Fj4JiNsIQOd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c02016-ad4e-4665-c382-08df12074840
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 02:24:19.7050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbwsFzFzPyqTf+fHpyVZmiBojpPjl1DMt0nJVyjSaSoIIOthZ8VwvQjvhySIKTx3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
X-Headers-End: 1x5yhy-0002Mh-2Q
Subject: [f2fs-dev] [PATCH v4 06/16] f2fs: stop using PG_private
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
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs sets its PAGE_PRIVATE_* flags in page->private and checking
page->private != NULL is equivalent to checking PG_private. Change
PagePrivate() to page_private(). Meanwhile, in set_page_private_##name(),
page->private is first set to 0/NULL before an PAGE_PRIVATE_* flag is set,
but it can cause confusion when PG_private is removed and
page->private != NULL is used instead. Change it to initialize
page->private to PAGE_PRIVATE_NOT_POINTER instead and retain the original
semantics.

It prepares for a future commit that removes PG_private.

No functional change intended.

Assisted-by: LLM
To: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Acked-by: Usama Arif <usama.arif@linux.dev>
Acked-by: Chao Yu <chao@kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/f2fs/f2fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9940a6cecf1a2..2f7ab5888b078 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2691,7 +2691,7 @@ static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
 }									\
 static inline bool page_private_##name(struct page *page) \
 { \
-	return PagePrivate(page) && \
+	return page_private(page) && \
 		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
 		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
@@ -2710,9 +2710,9 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
 }									\
 static inline void set_page_private_##name(struct page *page) \
 { \
-	if (!PagePrivate(page)) \
-		attach_page_private(page, (void *)0); \
-	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
+	if (!page_private(page)) \
+		attach_page_private(page, \
+				(void *)BIT(PAGE_PRIVATE_NOT_POINTER)); \
 	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
