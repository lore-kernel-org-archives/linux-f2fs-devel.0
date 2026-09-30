Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3980ECA5FC1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4/tS9Z3yb43Fx1ykLrYHNF8bUNHvleqLJAs+U5lY5c=; b=Xth81KgllSXbIFLpPkPfyX5RvO
	qJXTOWsmp9d9Gj0dim0dYSc1u5EZznxMu+2i4PUNM47GVZvunVn5EKHSSvzeptMiPIAvSclz66h5f
	w2MzMSORf4m1ztTvLRWyZhz5CJLZ8ZWMdv97y2sxOXkP+6HtlbY/yDifD7X/ov43vUKo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBpXx-0002ED-0D;
	Wed, 30 Sep 2026 08:20:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xBpXv-0002Dy-6T
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:20:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JDjw+45ZNrtvu5F2t9lQCEebxqfaUjTzsJjMtfW+q48=; b=B97q7q/N4IcUNy4VLQaVrP7qL+
 VjLQUTqRoiG3JsrQzeLmOGEiGxjbA11OqDYGvzbBaEdlmj7E3aJKjd3Rz8sEbgoewFc0+wLlVU+KQ
 RhMcvvBngq8/ljNcqw8Fibu06SMgUPwwnVMUKEo4UjMdRKJVdy78BN8pMOjLFHwhTeFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JDjw+45ZNrtvu5F2t9lQCEebxqfaUjTzsJjMtfW+q48=; b=lArKJbYuViQEgaZOxer1JtxmqW
 IhkNq4tfK/3klZTr2ZkRKPkBF7L+H31vbvGJb7pqG6yhy0B8YIGNd6e4MmuzzWUrqnyR1eyE2seZj
 gOx8sWyV9DpbsdNgaWZTiMyqkOs2/A35VeaTdI3IAmReq5Jo4hqxLg3yIHRammj1fLKE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBpXa-0005Wx-FT for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:20:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A71143824;
 Wed, 30 Sep 2026 08:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA55D1F000FF;
 Wed, 30 Sep 2026 08:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790756385;
 bh=JDjw+45ZNrtvu5F2t9lQCEebxqfaUjTzsJjMtfW+q48=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=BVHiiujRfXo4lkjG0Xe27sjzAAibGxO1GEfBaiQC06ZMGsL8CPZg4SEawGP7ZnC3h
 A3kTawXNUNP30NfDDI/GqHIDxsAcFHJtmHZPtjc2piUEzzjlQ3N4gKcgXfJ7F6EqXh
 7XNLIgPea2BU/uhD8VweCZ5Iq2RIQU41dnsfyl54ftq3pIIlKPD4WFL4y/6avNA3DQ
 E+4vcx8Loii9VnezNjNp/WkWzGVROkHzKBj1uSsL8j6VUEd0izqh0y8L0irwoDgHhI
 LeTijnJwrwMy5Jn4xz1cIS9lSPOLbIbPDknxvbD3lLnis0Nhuoj2nHyFqAbYamJs7T
 bt1AV2Y9qgNdw==
Message-ID: <95029d2e-4cea-4c2b-a253-9b7efd989028@kernel.org>
Date: Wed, 30 Sep 2026 16:19:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-7-bb68b6a21869@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260920-remove-pg_private-v5-7-bb68b6a21869@nvidia.com>
X-Headers-End: 1xBpXa-0005Wx-FT
Subject: Re: [f2fs-dev] [PATCH v5 07/17] f2fs: convert the ->private flag
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Tal Zussman <tz2294@columbia.edu>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/21/26 10:28, Zi Yan wrote:
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

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
