Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40EBC624A4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l4TwCv01SrLRUXFmaKo6O+TCNT414pO38yPpOBONgFY=; b=FrRqJ2lefZEmss3mZ+em50abH3
	VMCxBxDbZsjFjY2s3fvg3EQpNrTlPmUVGQSBHlfJ6dBMXmCj8rfbJ0fXPVNHdueXpI6hl8I8pd+DV
	gWQhSkS4mHgHuD5qJpjcimZBooe4+Iks5Zx0SBOhBiIMdhi6F/+c8fK/U23EF8vioSSQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x29VZ-0002cF-JK;
	Thu, 03 Sep 2026 15:37:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1x29VY-0002c8-B6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 15:37:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SAaGuiuwmKSEyoiV8Zah8K/3km4skoA5hchj++a6j6E=; b=YbAK6YqYxYr8ks3FWq0/FVvGk0
 oN620Fc++Vr5fqaYbzLwbxDvKg3IqZCxKcPz+u25hDr+Meeugc9TMNrELSkI147OxWhAzWCpiEUNd
 gzYOUhpU9+2MZ2sdJu0PROdPjYbnuuWhGJrcHk0aLBzuWFthyWZK7Q75KLe/u61MRzxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SAaGuiuwmKSEyoiV8Zah8K/3km4skoA5hchj++a6j6E=; b=TgrGCil8zKp9kQK48x7wNBb+Ij
 HI8Gq93Gq7n35x9BPnUhtd18fsOlX+dimAU24U2B/Wwb6/xVNNjxWSdvVJe4TOCJVnf2roNE070/T
 K8g/tTNOdneWbRs/B8YHllxB525TLkUx9XcewawU6/TMgtohF1uP0xpfrmRdMUU7TJ0Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x29VX-0000Ea-Nd for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 15:37:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5001441193;
 Thu,  3 Sep 2026 15:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1A21F00A3A;
 Thu,  3 Sep 2026 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788449858;
 bh=SAaGuiuwmKSEyoiV8Zah8K/3km4skoA5hchj++a6j6E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XwbiNMYlFIe5noAKSrlUGhYbLna2L+uP8lSXziXkAW62TAf8hQPWn9u+lWp6iYyo4
 2406vNU8X6hwJGPli4Z0q2ege3NMjGMxsocs4c0PQ+1U/F7zAodiC1YypWAr0O5cy4
 JvFisieON+V/L86uWXU8vC5wKcx8Q6Qq/rjmneZl4FpCLZj/CgxrhuDEI0TmUN61y9
 jlbnpKu3/KYACkoWnURxOuutOBHRIFQ+cB9Qf1djpVCrt86thiQG0Qgm/le+dZBfqH
 JTXDJXvobCVYMvtofNtJ6HRcgwWaVWeQ/J7GSBdP4bQ81ERzGbrHQfpvFQcV0FeHCi
 uM0wXamhjq7Sw==
Date: Thu, 3 Sep 2026 15:37:35 +0000
To: Zi Yan <ziy@nvidia.com>
Message-ID: <apmUP1p1TPDOaBe_@google.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
 <20260831-remove-pg_private-v2-6-3668159cd9e8@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831-remove-pg_private-v2-6-3668159cd9e8@nvidia.com>
X-Headers-End: 1x29VX-0000Ea-Nd
Subject: Re: [f2fs-dev] [PATCH v2 06/14] f2fs: stop using PG_private
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, "Liam R. Howlett" <liam@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Ying Huang <ying.huang@linux.alibaba.com>, Qi Zheng <qi.zheng@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>, Alistair Popple <apopple@nvidia.com>,
 Dev Jain <dev.jain@arm.com>, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Gregory Price <gourry@gourry.net>, Ryan Roberts <ryan.roberts@arm.com>,
 Usama Arif <usama.arif@linux.dev>, linux-f2fs-devel@lists.sourceforge.net,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
 Nico Pache <nico.pache@linux.dev>, Lance Yang <lance.yang@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let me take this patch in f2fs tree, which looks like a clean up.

On 08/31, Zi Yan wrote:
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
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Acked-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  fs/f2fs/f2fs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9940a6cecf1a2..2f7ab5888b078 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2691,7 +2691,7 @@ static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
>  }									\
>  static inline bool page_private_##name(struct page *page) \
>  { \
> -	return PagePrivate(page) && \
> +	return page_private(page) && \
>  		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
>  		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>  }
> @@ -2710,9 +2710,9 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
>  }									\
>  static inline void set_page_private_##name(struct page *page) \
>  { \
> -	if (!PagePrivate(page)) \
> -		attach_page_private(page, (void *)0); \
> -	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
> +	if (!page_private(page)) \
> +		attach_page_private(page, \
> +				(void *)BIT(PAGE_PRIVATE_NOT_POINTER)); \
>  	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>  }
>  
> 
> -- 
> 2.53.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
