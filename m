Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035A4C982E1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j1MhxMAVwsVwszOlNEJF+cBK5kuWxByw7WmDCv7Bf5E=; b=Nc6KVgubL4pSuGIH+XwatVthHf
	aZDoYBSSXvJ57oPWctQ0oblkRew6sepgjOZKxhtXTD4nAjGVumaU0OJ4trF272rSLy/16Sg5QX6c6
	Uala3nxegfXgUyCaR/2H9LShlbwgr4Q4PXTFjRerOXXLRgmmj1+JEu90dguCRI0nliEk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8YOi-00072M-JK;
	Mon, 21 Sep 2026 07:25:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lance.yang@linux.dev>) id 1x8YOd-00072D-Cd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 07:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XYfb6ENu9z05LITXdP+abHeFIFgnzSa/Qk0FF2ckOZM=; b=lDh0Hs5pylYnqFv5eiuWBv5sLv
 1UyOtRw50STjTTJTwNBAFGU8Gge+lFyqQUSedjxwgCVxY00rDI5viXz4u0/dG7C0tagzFS+r83qbG
 3pJ3TpSiGiAf34NxEtJp6XbDTV9jqcSB3KF2SRCv8phyvNE8AttMT2/kkBDGCHyXPQrM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XYfb6ENu9z05LITXdP+abHeFIFgnzSa/Qk0FF2ckOZM=; b=JsiwRhMhPfmSJGEmNoAouiki7r
 IU3X1IgflrOOJRYfA6aJ+PZWAccHG3DZo+/PQdPOBVELRgFrCqUz0jlgeBnUXZIvrmIl+TTFrNUzt
 hZmGFmMGV83tUFENV79BjnLho2EW+AP4UAMcMjLaCx/EF7jme2xzfdExCs/QNvdLnNzU=;
Received: from [95.215.58.225] (helo=mta1.migadu.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8YOb-0006W1-0R for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 07:25:04 +0000
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
DKIM-Signature: a=rsa-sha256; bh=Q2h6+eU+5UZjnvGnYVU6mhubmYWept3jKn5v+HruplI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789975494; v=1; x=1790580294;
 b=hHPpvsdQocNJjRA1KZ29kuc0sLubTq5vL4gNpUx4YgMo0qS9tRjKWLTbOrz60iQhfhdrVKAf
 8rsO9+Sr7ZeSTaQ0G2hqhn12P/tqQsfdJexVGEzppWWBeuSX4xGzMKqU0/ZTvfrB3HFwPC/t8t9
 bgUUJLjN0TDjFna1Yp/R9Fzs=
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
Received: by smtp.migadu.com with ESMTPS id 4c701f708d715319;
 Mon, 21 Sep 2026 07:24:54 +0000
X-Mizu-Trace-ID: 4c701f708d715319
X-Migadu-Flow: FLOW_OUT
Message-ID: <c7871a6d-bc51-43c1-a4a7-ed68a8e5aa23@linux.dev>
Date: Mon, 21 Sep 2026 15:24:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-6-bb68b6a21869@nvidia.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260920-remove-pg_private-v5-6-bb68b6a21869@nvidia.com>
X-Headers-End: 1x8YOb-0006W1-0R
Subject: Re: [f2fs-dev] [PATCH v5 06/17] f2fs: stop using PG_private
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
Cc: Michal Hocko <mhocko@suse.com>, "Liam R. Howlett" <liam@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Ying Huang <ying.huang@linux.alibaba.com>, Qi Zheng <qi.zheng@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>, Alistair Popple <apopple@nvidia.com>,
 Dev Jain <dev.jain@arm.com>, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Gregory Price <gourry@gourry.net>, Ryan Roberts <ryan.roberts@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Barry Song <baohua@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
 Nico Pache <nico.pache@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 2026/9/21 10:28, Zi Yan wrote:
> f2fs sets its PAGE_PRIVATE_* flags in page->private and checking
> page->private != NULL is equivalent to checking PG_private. Change
> PagePrivate() to page_private(). Meanwhile, in set_page_private_##name(),
> page->private is first set to 0/NULL before an PAGE_PRIVATE_* flag is set,
> but it can cause confusion when PG_private is removed and
> page->private != NULL is used instead. Change it to initialize
> page->private to PAGE_PRIVATE_NOT_POINTER instead and retain the original
> semantics.
> 
> It prepares for a future commit that removes PG_private.
> 
> No functional change intended.
> 
> Assisted-by: LLM
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Acked-by: Chao Yu <chao@kernel.org>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

LGTM. Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
