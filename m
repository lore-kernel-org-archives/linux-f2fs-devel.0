Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55866C79F9F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5r76rBln7LJtq01wJueRGBtYIHjB6Ux0y0FHKeBy/Y=; b=Vi1+Wy0kY5CLV7cD//idOKkfDK
	17R2feBnbN2tvf82TXsF3KxH7G/hmB8iSeEyVtithMbpjsnBOv/+1T7pvWGOYxnIDa9OSOXN9yDKc
	LitxyagyjwjXERjwNL2YgX5n53Cw8A11hPig8EU3fUiFcaGyQHWLMARa2Gp+kYT8NbTg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4aNp-0001pJ-7N;
	Thu, 10 Sep 2026 08:43:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4aNk-0001p8-Ft
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=isEbLjZPk/dWe3bh3R3NrHmu/Mf2w2fxrs7ayu2qcdw=; b=mMmuzI3WkLsPmUm/xNkWEb15BQ
 sNddVd7JPtTVULBJANkRyBU9v3s3+G/SLInFzP9+lHdP6XUi5td+hU/tD+N3MID+yGraRBdmkKMvk
 0R1T8I1qVIJ23n6BnZy9EeSZ48OAIXUgr/Q2Mh2xlEMNtWTNcjqzPb9xqUIWi9udaS+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=isEbLjZPk/dWe3bh3R3NrHmu/Mf2w2fxrs7ayu2qcdw=; b=TSk11Os473fLkWQxMZ4ls56Xqu
 hCR9XM1+5JnymU1B7XqfjUT+kN3z61q7Q1KAiaDLaEaGaPdHywZzoV2uF2c2l4Tp4RHbT1K1fCm6G
 mHxTvizT5aVB/xGj64IRB57BWy/aI0Lg7gP9RzCVyJcsiVI7yQTrSCyGZmMLSN7Bwpnk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4aNg-0001OT-4l for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:43:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 302A2601F1;
 Thu, 10 Sep 2026 08:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E2E1F000FF;
 Thu, 10 Sep 2026 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789029813;
 bh=isEbLjZPk/dWe3bh3R3NrHmu/Mf2w2fxrs7ayu2qcdw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=byq2LKLh5wTPUorRM31M4sIDve1usn/sR9AsugS+bvOrGQ0q2EKGgRVXELonBPepU
 Gn/ViuRSmp4XQJIJwRhWXFWkxkPKm2DGlFogH16zZxZ4iQ+ZT657K+3xZK25i/81Ba
 /x9+5v5YgJ/Ss1CNrGmD1seqX2AeaYn3Rr6m+Y3DTYKPFs/q+eB8Z4G12iJU0ttEVS
 FO3rPrBkfjpUK1Xapvv8Y6OhQTd8GKz4pDNUe7SJmYLqM0XOoH+1pPTyY8r0Qp7xJI
 usAbolvU3Qop8LaA1p6AQexHn/SCerYpxEyDLJh0l50wTRBXHITBGPYo166RCBroFP
 bfg4rcYtiE2Qw==
Message-ID: <d700c4ea-b54e-4195-b124-3c89177ee49e@kernel.org>
Date: Thu, 10 Sep 2026 16:43:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
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
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-6-6ae22f9d9272@nvidia.com>
 <e5792e81-e8a5-42e1-aafe-58dc603f4968@kernel.org>
 <7e11c56d-05e6-48f0-b5b8-b4a0e18ddc1d@kernel.org>
 <520b6aca-b515-4720-977f-1adb484f2e08@kernel.org>
Content-Language: en-US
In-Reply-To: <520b6aca-b515-4720-977f-1adb484f2e08@kernel.org>
X-Headers-End: 1x4aNg-0001OT-4l
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-mm@kvack.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/10/26 15:34, David Hildenbrand (Arm) wrote:
> On 9/10/26 04:41, Chao Yu wrote:
>> On 9/8/26 23:47, David Hildenbrand (Arm) wrote:
>>> On 9/8/26 04:56, Zi Yan wrote:
>>>> f2fs sets its PAGE_PRIVATE_* flags in page->private and checking
>>>> page->private != NULL is equivalent to checking PG_private. Change
>>>> PagePrivate() to page_private(). Meanwhile, in set_page_private_##name(),
>>>> page->private is first set to 0/NULL before an PAGE_PRIVATE_* flag is set,
>>>> but it can cause confusion when PG_private is removed and
>>>> page->private != NULL is used instead. Change it to initialize
>>>> page->private to PAGE_PRIVATE_NOT_POINTER instead and retain the original
>>>> semantics.
>>>>
>>>> It prepares for a future commit that removes PG_private.
>>>>
>>>> No functional change intended.
>>>>
>>>> Assisted-by: Claude:claude-opus-4-8
>>>> Assisted-by: Codex:gpt-5
>>>> To: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> To: Chao Yu <chao@kernel.org>
>>>> Cc: linux-f2fs-devel@lists.sourceforge.net
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Acked-by: Usama Arif <usama.arif@linux.dev>
>>>> Acked-by: Chao Yu <chao@kernel.org>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  fs/f2fs/f2fs.h | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 9940a6cecf1a2..2f7ab5888b078 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -2691,7 +2691,7 @@ static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
>>>>  }									\
>>>>  static inline bool page_private_##name(struct page *page) \
>>>>  { \
>>>> -	return PagePrivate(page) && \
>>>> +	return page_private(page) && \
>>>>  		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
>>>>  		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>>>>  }
>>>> @@ -2710,9 +2710,9 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
>>>>  }									\
>>>>  static inline void set_page_private_##name(struct page *page) \
>>>>  { \
>>>> -	if (!PagePrivate(page)) \
>>>> -		attach_page_private(page, (void *)0); \
>>>> -	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
>>>> +	if (!page_private(page)) \
>>>> +		attach_page_private(page, \
>>>> +				(void *)BIT(PAGE_PRIVATE_NOT_POINTER)); \
>>>>  	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>>>>  }
>>>
>>> Very weird interface. Why do we even need the page-based interface still?
>>>
>>> $ git grep -E "(set|clear)_page_private"
>>> compress.c:             clear_page_private_gcing(cc->rpages[i]);
>>> compress.c:                     set_page_private_gcing(cc->rpages[i]);
>>> compress.c:             clear_page_private_gcing(cic->rpages[i]);
>>> f2fs.h:static inline void set_page_private_##name(struct page *page) \
>>> f2fs.h:static inline void clear_page_private_##name(struct page *page) \
>>>
>>> Seeing code like:
>>>
>>> clear_page_private_gcing(cc->rpages[i]);
>>> if (folio_test_writeback(page_folio(cc->rpages[i])))
>>> 	end_page_writeback(cc->rpages[i]);
>>>
>>> Makes me wonder whether we can just use the folio helper instead?
>>>
>>> In f2fs_iget(), we enable large folios only when !f2fs_compressed_file(inode).
>>>
>>> So naive me would assume that we can just get rid of the
>>> set_page_private_/clear_page_private_ stuff entirely.
>>
>> David,
>>
>> Thanks for the patch, at a glance, it seems fine, can you please send
>> a formal patch? then we can apply to dev-test for test.
> 
> I'm hoping Zi will drag that along as part of this patch set. Is this fine or do

Oh, I see.

> you want it sent as a complete standalone patch (will make merging Zi's series
> slightly more complicated :) ).

I think sending as a separated patch based on Zi Yan's patch is fine, since the
purpose of this patch is a little different from Zi's one.

Note that: ("f2fs: stop using PG_private") has been merged in
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test,

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
