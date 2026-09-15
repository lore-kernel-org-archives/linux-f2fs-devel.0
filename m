Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB43AC88E7D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bYQEAN/tZf8T3LFeDDlx4AdvEzfPp8nNWgJA18J7hqE=; b=HcEYUUAtXTza7mV8b3ACAUVAOl
	FT+Kw2gYGUJhRo0VtRdjA03lqonBjso7klPCqqwLp2BeKOGQwRW7DRQUV2ojme6uoTrNhWd4c26//
	65AQljLmd/okuTYMixVu2Fky+mXB4wHHbDOZDvDtzLX971JyCRMuIO7EIRoxY7KQ17d8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6YG7-00020A-AD;
	Tue, 15 Sep 2026 18:51:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ziy@nvidia.com>) id 1x6YG5-000201-Q2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 18:51:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dlbsRc5b6ALuv1Mu+j7XrRWpRMdndr8g8ipoaHfCILs=; b=idmlw3nuWBFT7kQiTmFyi4KeDv
 kUuWsoHj5gJGYSEsHC+qaiybcAa30KSqv9T3JPS4hifh8t1I/97+5kEB1eOqjEd5P9TYUhGSGpz7c
 0vkGqKhdnXjxhiZ8Fyy6Y97jI7JvVQnBJ0ystTJG0fgIfPdzIz58wYBeCSpIOADwQTbU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dlbsRc5b6ALuv1Mu+j7XrRWpRMdndr8g8ipoaHfCILs=; b=d1K4gu29qRDslYIiw7MR0d4KrE
 7BhtQIX2JjLjtQtUwuCT/PNEfyyVIU4LNMr6D/s7CnBam998vY88bi2SlWgzprwaB1L+m2CU3Zffo
 filbPhdspg0tVv09NHCKupRfemYZlIj4k9XzRV8rYZ/cvw7rO2IMcSrosJX9go8a1dHw=;
Received: from mail-southcentralusazon11012000.outbound.protection.outlook.com
 ([40.93.195.0] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6YG4-0001QA-6P for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 18:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqzRfTMnOSq1dRBGNtFzFPcucjAvtRip8v+Yb+YkKqqW5w/DK20Ob2GnJyTtLIZ6DLtIFBaG2LoYHrWuuUE44t/EQvEprF3JPMFbF9KpHcg58EbKRR/2RNx4k3UBCsupAPUoT4wJwGpDlNlKNVun3xTQEm8Nc+1laKMdaWY8XTPrj4C1Pu07uOhI9gVs2BG7eqSmuPUTSRC2K/epTiFPlNDceJRGYrx3O+OtJJ96fqXezucGC1cgThgO5g+nwv7M+cGMpMeAJH4IzjeaJvb49nJ0s+2Ok0NKZqEHDlNijlV7xzed6SaWW7C2mViReooaPY1Tk/ZVEwOyhWGj2yM7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlbsRc5b6ALuv1Mu+j7XrRWpRMdndr8g8ipoaHfCILs=;
 b=d2vyvNf1Ha8BckV3aheirCtyfVw10whwl+JNmter8Iy/4aBuQdK32InzfMRHDWP+pYF+6PwZVRRPIhU7F6N0RTq5pq5ApxAj2j4RzJZAA6/UHXx34eztoKILRgdB4B2F6TNnOQPIJsX9LFyE0ehQfitgUZMSnUFV2/nA2dsfUFODMKxJQdxGC3cg5A5ZHUEGhVO1MsYwOwXW0BAdS+z0XAyYJpW6edUyVu/lP2Sq4PMTz91EuXxSzBvAqrQ8qjCGi/n7+AB6vW1Kal1pEYM/KkxHFjBJC80XokTdMtfSLHEmanQ0YzspMrCLJbu2Y8daMU2gAFqOOsj4cXdmsFFi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlbsRc5b6ALuv1Mu+j7XrRWpRMdndr8g8ipoaHfCILs=;
 b=CdxMCr3NsekMH52Gp8Y6+WR9tNNgHV1QXCHvgQ4diXjH0xMJcvuViu75NFme6K9id0Wa3IqaQrzOzOqhBfP+0hJu9M9guuvfSldfPYBxQCJ7YSfMVrZT9OsNhWqWyhIabws6rTuCxyFpOYYLrDj2sJ8Ws930PSoryk7toxnus8Ifkb3LJqJ0DRjlM/Cix7HPlXMeKHtWhgL3sP7bQns9fHNHQkNVQ3tb2Y0028MdfB3B56fOCB8cU8s0zbtPIpBvOysCN3vVU1NiS3ErxTnPz+EpWmewqs++Ql5CQxuI8vAFMI2RPOthA+62qTjILtbgDnapVMlZFKiq59SH6z88uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) by
 CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Tue, 15 Sep 2026 18:18:09 +0000
Received: from DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a]) by DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 18:18:09 +0000
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Daeho Jeong <daehojeong@google.com>
Date: Tue, 15 Sep 2026 14:18:09 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <862E7DC4-14D6-48AE-87C8-11664354718C@nvidia.com>
In-Reply-To: <20260913203959.6b46b0b5a052aec818a7f267@linux-foundation.org>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
 <20260913203959.6b46b0b5a052aec818a7f267@linux-foundation.org>
X-MS-Reactions: disallow
X-ClientProxiedBy: CH5P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::14) To DS7PR12MB8371.namprd12.prod.outlook.com
 (2603:10b6:8:e9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8371:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df2b240-d853-40ab-98e2-08df1355b1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5avak+ASL2k070JmJq0qUfFoA+WlI9EefkJ5OVgbng4kM4eP9MRagco4Z97CG5nI/979U1b1N1dMzc3TuSJHErdwtBjya77VUko2PgqI0zPkg+dzZv9oK2rO+qyP/Sw8Aohfn6qcIWbxZmUu5Bd231SzOmDhfUhLYnCvyoB0L8rjRiaCeEnxwEyzGSY0ij3bpVI/iGvwSQ2i3FDk6EYvRPo7YIiMc3Qv9VoCeUdRjmvB3mlqn1YuZoPCq3AQBHEMyNbWBF03T9q9a7Rxp3rXgJ16uQIUJTEikuBGj5S84ZExScjhj7U3SJwY7/9XnvWr2d64wRSWujI0FoVdoWl5YDA4X+gNuBtu9jqGkYVsbwl6+Cldbh35co4IDsImd3vDLMYWxZyeyEbFcOStXjkVwblO6ABpZC7C11yuqG8pW3VoqIpX5lZ6gtfzgjF4xgrjMiOH6UvIzWx0hi8HE30BhBOCsKOnRWvPBnYfoEW3IVv4GUMk3kIPDzTcNPYYckPIUyOEKdKymXnphZMnoEYAmKUXYiCq+rJDTkruD6NTXtn1UKGty4RTeQRx/HeQGGBac3nyjFuF7FYB64fxE1ScQznRSNjOqcfVQvXsZq1xvKX68sXp+IucZt1HjLVALQ0upf7ar0vBXfXrUcq6sOxS9pv3JrVLyNkCmmYDSTd6iO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8371.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cVBAcSGvItFODUzAiu129DNTSg+xIgqVMVGzW0ZfHchyVcPoi2yPaFeLR8qA?=
 =?us-ascii?Q?fwLkJ073BEe4IVWRLGLeryCsEWxY6Y9bSklxa/yl8PX6jfI0dz6j1BesQpkb?=
 =?us-ascii?Q?sJvZckr1PMmWup+v4dD8eYeLDE2UVFLcPFiUAaYdxQRWGbiHTLrH5OsQ6jG4?=
 =?us-ascii?Q?bppJqf5qcgLqKIk44FE2ROd9pu+Qc7zC46b33kH3NRuL79BmPTHQBms4k7Mw?=
 =?us-ascii?Q?QpUHBwO4BMxB2/KI90gPj7KZzNx6cvkp2fEIbKOiXxtCCDbM7u63O1IxmFrg?=
 =?us-ascii?Q?djFs7KgkhOE5ZzuFpNeUSyg/qpwwM12JYyi3zBRi3HrqGXuvtmxmDGjCeEod?=
 =?us-ascii?Q?889fxqq65ixNTH6cL+RRxQwxogVqvQRlL39hQc04aRyLv9cx1gjkW0nn1iy+?=
 =?us-ascii?Q?d1Hsi4V8K27WrPy/d9SnhMSRP7mOkfzo/USSiviUnIZ7+yfy61HG8X05eWUY?=
 =?us-ascii?Q?82sWsiUwczxC1ixEeFPFDab+eGJJq6yqblcYYRF7vWy/PwrKl+7x1mBxIKcV?=
 =?us-ascii?Q?SNTr911khHbxKxhpTwkjg4KvRSHPFaylaOojeq3Dz/VPGOJtQ3rtMrKcpjAM?=
 =?us-ascii?Q?uIiNbIL3lTaA8Uwsgrnf+vKsXIwPPlDdYZlTmWfvJXDWHDbztlzPQY+9g1xo?=
 =?us-ascii?Q?8VUdao3QuDEALNprnxtRxdERTZ6I7ytXJXF1mAGU/O5uuLL1vJvMxS1GTHdp?=
 =?us-ascii?Q?ZSp/0gPcE03NqVPhp7RHyuNt4+yucuEJrCq5XjPJFv31DowlB3KZONDrHCZ2?=
 =?us-ascii?Q?zbSV0h0ZeYzxcfLTf9HnHNO5C/oezFCHAvO4esMEMTHhAV2T+PYtE3E51yZZ?=
 =?us-ascii?Q?CbV91m8XkRaNKhZ1q5y2zE/hMsS5leYwTmOASFevN+/qGWhdyWvjAsn0fTe6?=
 =?us-ascii?Q?zV1Iqr8AlJouXZ87qDVvXIvq3wmreTfdcbt6cliI7e8xNxanAiL0rXdTi+BA?=
 =?us-ascii?Q?OZSfFrqXqRQ/Loh8Oj8pe0xFMAvdK5DRtysdzziKDNL7yve4WFClwvlEsi11?=
 =?us-ascii?Q?D9InIiuj2h5P5wfHk4WPYHMRG9tlskQL9m/lkUF1lgnyidl9Om+IkY12qnPT?=
 =?us-ascii?Q?CnpbzVUVrJPFc0Vd74vG+hFJZL8XWYZEJfoyiNA+MCyj/HwuvdNM0k9QI3wv?=
 =?us-ascii?Q?Nyba8Kxg/G2jNZpaf+wf9d8HIqhp+asTKWrtbZf4Skr1vF5HMQcvXN+qnM+O?=
 =?us-ascii?Q?M9YkSSF5UQaFknHFtRiIEVQjjUpiLTR9I77cxtMyStrntUfWH3ah/viP/MI9?=
 =?us-ascii?Q?bQln01WVopyYnfpaEMeIzaIqXJH3uk7yD5dymU7HebBVwu7dLX9Ul/ByHrB7?=
 =?us-ascii?Q?9OygTNJ+HC3HjhuYLqr4LM16tkXhc79B5cA+Ir+OFTk6teGVwhOyBSR6d2dl?=
 =?us-ascii?Q?vXW/cFaIYfcFlYLAy+T6GBNb7REfPR16ycOLc6PwO62+fktnUYkSgwVmGKlG?=
 =?us-ascii?Q?6wfBDMz12wJeR4+Lr+mWoPAt81wiPCNfFxiVWm9cFkQDBOYAqoU9aYEtcFMD?=
 =?us-ascii?Q?32WYB3NH29f06mki4iHgVd+uLq/6toNtMES6akbBwiNZelQDUmJIhv29XlOd?=
 =?us-ascii?Q?a+Pob7wwvh1iddFjFXnGHczibQNE/DWUNMqY3GS61igANPqjk0WY4+ldpckZ?=
 =?us-ascii?Q?Z9zYOvgvUoSK5SEooYoNtHLw7SE9pCupo3qZP7M3evjwTyBK5bKDqRE4/IfU?=
 =?us-ascii?Q?ImLS4qjthName1UVzcLNhJdlPPWJyWon7qp2olSN8+zrci0H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df2b240-d853-40ab-98e2-08df1355b1eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 18:18:08.9937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJV1UOgQ+0f30UuYsU6MjnPU8jzZmf187uIev1uU2f0h2IRiWlR0j08lsaQuq5G/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
X-Headers-End: 1x6YG4-0001QA-6P
Subject: Re: [f2fs-dev] [PATCH v4 00/16] Remove PG_private by using
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 13 Sep 2026, at 23:39, Andrew Morton wrote:

> On Sun, 13 Sep 2026 22:23:58 -0400 Zi Yan <ziy@nvidia.com> wrote:
>
>> This patchset removes PG_private to make space for upcoming PG_folio for
>> identifying pages from a folio (more details in Note below). Instead of
>> checking PG_private, all code is changed to check page/folio->private !=
>> NULL instead.
>>
>> MM people are cc'd on all patches and subsystem people are cc'd on the
>> cover letter and corresponding patches.
>>
>> Patch 6 is picked up separately in f2fs tree, but since mm-new does not
>> have it yet, it is sent for MM testing.
>
> AI review claims to have found a pre-existing critical level deadlock
> in f2fs:
>
> 	https://sashiko.dev/#/patchset/20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com
>

drop non f2fs people and lists

Hi Chao, Jaegeuk, and Daeho,

I used LLM locally and discovered the deadlock issue in f2fs (sashiko's report
is overwritten. The fix is below, let me know your thoughts. Thanks.

It applies on top of my other f2fs patches.


From f0c1e94d229a97614738d5c317187bf42a3ff2b2 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 15 Sep 2026 13:43:35 -0400
Subject: [PATCH] f2fs: fix potential deadlocks in cancel_cluster_writeback()

When f2fs_write_compressed_pages() fails to submit a compressed page, it
calls cancel_cluster_writeback() to end writeback and lock all pages.

cancel_cluster_writeback() relocks unlocked folios in [0, submitted), while
still holding the locks of the folios in [submitted, cluster_size).
The folio locks are no longer held in order of ascending index, violating
the requirement of folio_lock().

cancel_cluster_writeback() also ends folio writeback after taking its lock
for folios in [0, submitted). A deadlock can happen if one like
truncate_inode_pages_range() takes the folio lock and is waiting for the
completion of folio writeback forever.

Fix both by ending writeback and dropping all folio locks first, then
retaking them in ascending index order.

Fixes: 2174035a7f11 ("f2fs: clear writeback when compression failed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zi Yan <ziy@nvidia.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
To: Daeho Jeong <daehojeong@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
---
 fs/f2fs/compress.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 09d9b8d0fdcce..88797dedc96bf 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1062,18 +1062,28 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
 			f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 	}

-	/* Cancel writeback and stay locked. */
+	/*
+	 * Cancel writeback and lock every folio in the cluster.
+	 * Drop the locks on [submitted, cluster_size) before retaking dropped
+	 * locks on [0, submitted) to prevent deadlocks.
+	 */
 	for (i = 0; i < cc->cluster_size; i++) {
 		struct folio *folio = page_folio(cc->rpages[i]);

-		if (i < submitted) {
+		if (i < submitted)
 			inode_inc_dirty_pages(cc->inode);
-			folio_lock(folio);
-		}
-		folio_clear_f2fs_gcing(folio);
+		else
+			folio_unlock(folio);
 		if (folio_test_writeback(folio))
 			folio_end_writeback(folio);
 	}
+	/* Retake all folio locks in ascending order */
+	for (i = 0; i < cc->cluster_size; i++) {
+		struct folio *folio = page_folio(cc->rpages[i]);
+
+		folio_lock(folio);
+		folio_clear_f2fs_gcing(folio);
+	}
 }

 static void set_cluster_dirty(struct compress_ctx *cc)
-- 
2.53.0



Best Regards,
Yan, Zi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
