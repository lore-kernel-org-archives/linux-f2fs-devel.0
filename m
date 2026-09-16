Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B8BC88E7F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 02:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTqcgVBNfLZ6QEHV1b7M60c5Zb9TyWxNciN4Djk8zYw=; b=clpFrC2Xmny0y+q+ZOXEl7nthw
	JdFAqUGm9PHEK6Hufqkm4VMHGXsq86vdb7x29BgBh3dHncASmOehMy3C5zdQQiT8Mvcbx5aZcUwi6
	FvHFirqCrXPNW4/xgOdyHVvSi808fI3YTS70WY/NI193PrBcmOFlmBhmuk6xajBn/RyE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6fVe-0008OT-FT;
	Wed, 16 Sep 2026 02:36:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ziy@nvidia.com>) id 1x6fVc-0008OA-L4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 02:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Type:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8iSbxoSYJSXL5nZj8aASWmVAQ7Z2qhna9/vGbeVxCvs=; b=k6HYOwgSKvFfjod9X56DMgG8a6
 yYvZ8s/jevUJ62HE8oFIByNVk39fRDr2d9Vi6nCeneoXcuhE/J60Z6z9LwguV1fXeoLRUz/13Ntbj
 cMzxc88AKxe3H8diB0963RUEmQF0gDcDCODNkChV8b0Yb1pGOEWdmHVT0GAhfWtsFnM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Type:References:In-Reply-To:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8iSbxoSYJSXL5nZj8aASWmVAQ7Z2qhna9/vGbeVxCvs=; b=V7vEc8j6pAox7q54Jpf6/hB2F7
 /N9vrBUTGZJkvoeo4U+SR4uCTvi3waSZkfBW2gKaWZLwRPtaSb+E7PBVMWF/dZpigKvT0crkAYMZ5
 RJiSBfPiD9ral+aSwoCN8XxOUOrqwRtZhxSoD3jChRO+2nNiT+wW8972QV7Wm3iHignQ=;
Received: from mail-westus3azon11011001.outbound.protection.outlook.com
 ([40.107.208.1] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6fVc-0001iX-Ha for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 02:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4k0+1BaewR3zk0Y07/I7iPNFf9aapJK9QUB2R3h354Hnu/cQU0xRDl+Lx7h7peu+KnbAYszccpfAEk8j7mKy+Fa95eW5pH8iSC0GBBjMhmsoXiTmhHbSDteS4IMhabpkGog+EM5sFZwYvn4Yd8nKxNQHoASrK10GKunaXwgPSF3ZqI2AxbLOgK/WGbNn9AIBpW91S/AZJ4cvy+R2eP/Y/hLZQ1/3rPunuijdO6BSg0gKW9mVxVgzMQNdzmgiiGMc3rMrQedZpEzVV777Mf8xd//NhftDeQ5j1h0+Y3Pgdwpca1CoggsoP0+idBviNwk6fBySlZKDLlEOC+/1vLoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iSbxoSYJSXL5nZj8aASWmVAQ7Z2qhna9/vGbeVxCvs=;
 b=OQW45YdTYmXXUCchvSfP2fI5cEatb2PQaeGU1Ug/XlnblBbU3YFOL3SHU3jqz86uGTtwoPN91Gg62eqLxI5MybVX9ectmJCSbSg0qteqZJcrwqNEs9rSpw5U7S3s+uyoIKUa4l6fGeRVZ6nrfv1xQ2HbziHjiM2o2n6CwDgeaE8x4o8cx+OBauS0pDVO5MtT8Rxw0/Bycp7wqyQS+npdesjgxCObKAzZ9InOqNhVyVnrKx2J8zqZ9VCqjqN2uRe7aC2aL+GLmnkmYmvRI6iaXNpeAz00GO+C6tiaAblsiSiYQwB6CkGICGvzAQI29Ymitls+pqSYRJ9q/yU9cdnalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iSbxoSYJSXL5nZj8aASWmVAQ7Z2qhna9/vGbeVxCvs=;
 b=U5AI83LAlbKHxtWx+Rjsc4/Ku7WIUEMR5Tlbcbw87noNKwgj2NJjBpixnZuV51MYY94Xhs/WYp4irts4USzZjCZIP8PDY0TxvMAyQ7d/pr6s0cwULau9ilTahDYE7DmVbzdbLwZU1sxI84eDYAk+3KlV9wXImpaGCmstPgUkVTVAytAEdLLP2hhZnLcB2+l1XFeJ8ebDGHmJkW5KgmdR94OWnHEYxADTEOLL7kBq7mo8Vo7Zw5s9+JKhm+5B9wtO7LVZsgNl5b5zsouv3N4CuTyH5DsJJvCMqO7RCFQnbhDCLel3KRIEs5DDPeSj7EUEpo6cUWQSKI/sehh1tIKU6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) by
 DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 02:20:41 +0000
Received: from DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a]) by DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 02:20:41 +0000
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
 Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kairui Song <kasong@tencent.com>
Date: Tue, 15 Sep 2026 22:20:40 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <2DF8A821-30B4-42E7-80CB-E7B1CCF37930@nvidia.com>
In-Reply-To: <20260913-remove-pg_private-v4-7-848550f7574e@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
 <20260913-remove-pg_private-v4-7-848550f7574e@nvidia.com>
X-MS-Reactions: disallow
X-ClientProxiedBy: BL1P221CA0044.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::16) To DS7PR12MB8371.namprd12.prod.outlook.com
 (2603:10b6:8:e9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8371:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8daeed-958f-4966-f8dd-08df13991afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: QYRfbFunuMKc6OgRWk7A7SGyQlpS4VvyfjNgXFX7TTTulAEDHp0NelRCSdTOxc4SD5aoPhFODl2Bp9qnLGrun+eGRURPRjuwZ0PNaPYchHenMOoqeZKVW9cvfm+gcsgp8sbcFq7w9BsRV5FBqaSqRQAAACaGv8w3ihv+7//Wkfika3/dBtz2HL7Yml/jh5HhIOLZrrsmNXJH1MxI+w4uyw7fjyYhPFIVAEYTsJPrA9mEc2imr/zbRR3IukCekX0PWqt4CyUqTlFRthhwW6f7SSmg9xoJxMfhS3fSMasR6LXl8KqmSyxoUhcrZ50ey1mFC+qCqHks7kZm+c7IwaWK5h+hpJ1b17ono+SKE6z07jZDw8ODR5mgdVMvjKJi0vjzJMBt9E2JrdBsm54Wbj1b1XInCb1A6QR597eVOIPlIrFG+BpciczlDASNiBBRRLHYcNiahqeY8GB+GJBZkmj95uPRF5pbPo5v75fihaFfR1XB0fpe2SB9ZhWfK8haEHTzR20+ekdMTIhzcRfdRuWxrZ3mdu+dv9z+IoJOrygPbwceYQjkqJ8fGw4lFwCcD5fl/znrQih0uwyOBl6PzbiJEbDTtkv54u328/KFlQoWQ3sQEeUxyq/1/xNaNAvZDQo1o5808db+5dU2ooFO3x7nk8clzK08ZzUD8vTNv5dGhT1CpJnF45KlPIXjHUECiMdYLpvx0bBN93Ts15I7A65xxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8371.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YLuMJf/A8OEh5d+CUtxMSwpdUybMHDapFaYTgz+QGrYevvgXRlW4r6x/2Ndk?=
 =?us-ascii?Q?81Pa0AHx4nUiBl0uRvb1w49ytAHXEl/U1Km2E+fT5LHShMlNTGbhVdv9vhTE?=
 =?us-ascii?Q?T4gQjfSAsegDSU3jQMbwlLea2HIN6VZhq+qe9BLYbPt6Bs270GXT9n3v6LC0?=
 =?us-ascii?Q?oa/+0gne/N28n0cmNksSN6stlLv8oppbo6VCk11MR0rGZ0HCFDkQcKFzJ7B5?=
 =?us-ascii?Q?gSTXJq23Tn8ey7dl/HIyEBxIeePj+r6gOlow2RGesvBxc4N9c1uY2CC4lMST?=
 =?us-ascii?Q?hOlLgrLu1VD646nrpDsIS7Q6pU1o8tBECF+kUNt4o7LeQMn35LWxVPDXGKbq?=
 =?us-ascii?Q?DYxpRlYoRypVTvyjWZET+TVNPyQlUCVY0abmGVMwBPvwPqzgW4c2GwZl4SvF?=
 =?us-ascii?Q?esrDLbj7Wf029qo6I7/clBcKPb/zmBcP5cFZ73vYkuzJPbzPJN+kQ8oQHidC?=
 =?us-ascii?Q?3lH748IuCwMyLu/q/X68+1H9Mj0WBQymtPsKAl1LMexwdzPRm4szrOvI07uD?=
 =?us-ascii?Q?eHkQQ9ETdsWQwaECTKoKxAlyrNn+E+UXibycb8i42m6O3DORW45X5sQt1Q8Y?=
 =?us-ascii?Q?SNfctHSMtKdkUU9LonVBBmlWe+/q7TzjUsaoNFWYTGioDu6nKTzBeY4acImL?=
 =?us-ascii?Q?h2tPZcQ/tZexHLGjkSEBLHAa76mvkgmQOjKpOwj8/6rnpdO73ofAs7DmekJ7?=
 =?us-ascii?Q?McIl+QQPtCbosCnZkyPdnH8DKVsqYNkV8QEPGiSWVMo5DH2Oq5zKrAsyfFe/?=
 =?us-ascii?Q?8zYtSI8OWcJLDqk1hhodjzAmhNHvg5aB9D2jDmwAd9g7kAEOai5VoIDr3rns?=
 =?us-ascii?Q?rSXSiwCGeIcwEEFUpmngyuZF8Bb8TlXDvhNuSvWAJfxdwYabzuP00lveuip5?=
 =?us-ascii?Q?bFTFfmvxMuzuuUvw+ufSsakmx+O9gbYp+qWVyIqkzE3dtELFZTJot3JbTgEt?=
 =?us-ascii?Q?3vwfJfvoFdQcCMP2qZhXQHnc+eIPxMWwqBWgZgRivtprCCDAC4BBMKvWTn+g?=
 =?us-ascii?Q?ZafKyX9yB/gAlMMMLxiDxGWIgJHXIKcN1JOpTQ4t+c0pn9gxhLwOH4YwBBRU?=
 =?us-ascii?Q?n+HLJW1FZ6HpI/sRsnqnQrzdwYlxyoVp6Hs0I90WXGgDSN/LBaBOBExnef62?=
 =?us-ascii?Q?3rcjdQ1OrqvQrR4eEw0/w323QG+v2xGmW4kHe9ZLeGr51DFV9VzrQbkvhCtD?=
 =?us-ascii?Q?OYziwxzoUEx6sOv64y5EKlRDy4b2MeHrRfwxqFphL5lsJmKSX0bs3aqbnVJr?=
 =?us-ascii?Q?qKEz51N8d39ETcvVnOIiQWSbstiiGQkiov7JdGmmx+x9DEF+UV+t4cDh00tB?=
 =?us-ascii?Q?ehW/M+RQxUKkZYoBCywrs8AMSuMyOSNhiNaOtFDLnCjpMwOambU21u6lIxuS?=
 =?us-ascii?Q?35NxqpfCtGamFv67HuBvC3zrP8C2IH4q/4Qy7pP/2m0cXyyQfRA5nwPr5l6p?=
 =?us-ascii?Q?xn99I0e64vPYG3pDJAOMGCt7sSCgKEh4IoTXKxbfIzm5b+HdnFstPh2bkVjd?=
 =?us-ascii?Q?Ajg/Pb2o2xIhmGVDsdkI970mxTjCj8CMzm3Zw9XBkN2C2ESbg5GWLL9MZg3n?=
 =?us-ascii?Q?PKko/fAlmriMEkj34w0NueswMGwew3d1PIK7KkbaSxahL3gxaD4hoy9yLeoK?=
 =?us-ascii?Q?TcMjGyeZZvaYUzy1oC4d3oL5ch8zbPV2GHp38Ihvk+4ru72Hu0MveG+UArRo?=
 =?us-ascii?Q?J5SPDRYaf0Ll1bTQoe/Rleo3TEB8KK6jysTlQhIjgbiRRVjz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8daeed-958f-4966-f8dd-08df13991afc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 02:20:41.5782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /p8VU1vzRI3Dm5zw63J2+kfML9Tkg/TLzwxagLY6SHGKrmNhjFcuBKV4kXvZ3Rgd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
X-Headers-End: 1x6fVc-0001iX-Ha
Subject: Re: [f2fs-dev] [PATCH v4 07/16] f2fs: convert the ->private flag
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

On 13 Sep 2026, at 22:24, Zi Yan wrote:

> page-based ->private flag helpers are used in the compression path, where
> large folios are not enabled. They can use folio versions with
> page_folio(). The two remaining users in data.c and segment.c can use
> fio->folio instead of fio->page (two are in a union).
>
> Drop page-based helpers after the conversion and rename
> PAGE_PRIVATE_{GET,SET,CLEAR}_FUNC() and the PAGE_PRIVATE_* flags to
> F2FS_FOLIO_PRIVATE_* to match. Convert the folio/page union from
> f2fs_io_info union to folio only, since no page user is left.
>
> The folio helpers do a plain read-modify-write where the page ones used
> set_bit()/clear_bit(). It is fine because the converted code either holds
> folio lock or, in f2fs_compress_write_end_io(), matches what the
> non-compressed code does in f2fs_write_end_bio().
>
> Assisted-by: LLM
> Suggested-by: Tal Zussman <tz2294@columbia.edu>
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  fs/f2fs/compress.c | 35 ++++++++++++-------
>  fs/f2fs/data.c     |  2 +-
>  fs/f2fs/f2fs.h     | 99 +++++++++++++++++++++---------------------------------
>  fs/f2fs/segment.c  |  2 +-
>  4 files changed, 63 insertions(+), 75 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index ce88092d9ce26..09d9b8d0fdcce 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1064,13 +1064,15 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
>
>  	/* Cancel writeback and stay locked. */
>  	for (i = 0; i < cc->cluster_size; i++) {
> +		struct folio *folio = page_folio(cc->rpages[i]);
> +
>  		if (i < submitted) {
>  			inode_inc_dirty_pages(cc->inode);
> -			lock_page(cc->rpages[i]);
> +			folio_lock(folio);
>  		}
> -		clear_page_private_gcing(cc->rpages[i]);
> -		if (folio_test_writeback(page_folio(cc->rpages[i])))
> -			end_page_writeback(cc->rpages[i]);
> +		folio_clear_f2fs_gcing(folio);
> +		if (folio_test_writeback(folio))
> +			folio_end_writeback(folio);
>  	}
>  }

Sashiko[1] said there is a pre-existing deadlock here. Submitted
pages are unlocked and remain under writeback. If someone else locks
one of such pages and waits for writeback to be completed, like
truncate_inode_pages_range(), they can wait forever, since
cancel_cluster_writeback() can end the writeback only after it locks
the page.

Answer:

Yes. I have submitted a patch[2] for comments.

[1] https://sashiko.dev/#/patchset/73521?part=7
[2] https://lore.kernel.org/all/862E7DC4-14D6-48AE-87C8-11664354718C@nvidia.com/


<snip>

>
> -#define PAGE_PRIVATE_SET_FUNC(name, flagname) \
> +#define F2FS_FOLIO_PRIVATE_SET_FUNC(name, flagname) \
>  static inline void folio_set_f2fs_##name(struct folio *folio)		\
>  {									\
> -	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
> -			     (1UL << PAGE_PRIVATE_##flagname);		\
> +	unsigned long v = (1UL << F2FS_FOLIO_PRIVATE_NOT_POINTER) |	\
> +			     (1UL << F2FS_FOLIO_PRIVATE_##flagname);	\
>  	if (!folio->private)						\
>  		folio_attach_private(folio, (void *)v);			\
>  	else {								\
>  		v |= (unsigned long)folio->private;			\
>  		folio->private = (void *)v;				\
>  	}								\
> -}									\

Sashiko also complained that folio version is a non-atomic read-modify-write
sequence, whereas the page version uses atomic bit ops. During IO completion,
f2fs_write_end_bio() executes in softirq context and calls
folio_clear_f2fs_gcing() without holding the folio lock. Concurrently,
a user process dirtying an mmapped F2FS atomic file could trigger
folio_set_f2fs_atomic() in process context. Even though the process holds
the folio lock, the softirq can interrupt the CPU during this non-atomic
assignment sequence. This is racy and can cause a silent drop of ATOMIC_WRITE
flag.

Answer:

The above commit message talked about it. It matches the non-compressed code
path. In addition, atomic-write files cannot be compressed, so
folio_set_f2fs_atomic() never runs on a compressed folio.

Best Regards,
Yan, Zi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
