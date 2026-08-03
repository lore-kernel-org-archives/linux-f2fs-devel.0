Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A78FC55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7BaGn4WZVlrf8cpww+PgKk/ytPSE++Yw38wPFaNzuY4=; b=L3KkV15QoDtzHlziVr4fN3wCiI
	VYGx9lEnLQoDmyBF4S4k/29xM2cHwTq+jxcsdQVTiUZcQtLOo90ezff+/wcIXlZ8QGtexq7KKig87
	rvNyNGwsi7qLdbXPYy+Ut8k0KKQ2oe9QM+Irr0Wdp4tDUfdKBzYP9+uy8r1hcf3Y/wgU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr6b6-00071O-Dr;
	Tue, 04 Aug 2026 04:17:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <usama.arif@linux.dev>) id 1wr6b4-00071H-Vj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 04:17:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=64J9NQ8wINxMWeOp2Yatp476UcvWi6dCmOU/qEHakuw=; b=DH1ZwkoQY91Wxg6huNjyCqUH8g
 TbrsfW8+nS4nT4l0tED5DsF4MYGi8cHk1uyCVz0vAKqJRYjE7SxIyrToYR5XyErvf01n9pSiRQoNU
 HrtiHf+83p/BNMzeU0+1U8FFqZLeyYZ8MAeQDx4rEKbEAjSSvChI2u+WVHvpDEduVoo4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=64J9NQ8wINxMWeOp2Yatp476UcvWi6dCmOU/qEHakuw=; b=iTsHNKh2JTCNbbV2GCjjqmEcuV
 YF3G7Z4vIQ7dJfSaKd+P31wsifuPBDzRinihbXoXorYvApDzZJRA8FKG1sClZ60hb6iyX2Ehxf5RM
 5gVU+eNwCT8L1KpdFQy0pMFlfZxszMNatSSkrKbD6XWA6yd9MeImmk8MFaspovXw2vF4=;
Received: from out-181.mta0.migadu.com ([91.218.175.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr6b1-000097-TI for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 04:17:44 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785772104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64J9NQ8wINxMWeOp2Yatp476UcvWi6dCmOU/qEHakuw=;
 b=Hc/REYrJ28ABa30xrZ1S2G43zd3wYxS73exkn7ftrzeE6o48WnpuEbf10dM7FlgtRX0zIu
 WAbiZSO2Oti/9AmQcDnzXRIizlL4Q75woxE1p5gOjf8tcfILoGLFnqI6oK1iOwaONhC7UM
 olzNTFCByzZQd4kxyfr5PJN95Cd6BME=
From: Usama Arif <usama.arif@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Date: Mon,  3 Aug 2026 08:48:16 -0700
Message-ID: <20260803154817.3112697-1-usama.arif@linux.dev>
In-Reply-To: <20260731-remove-pg_private-v1-6-142c97ba3562@nvidia.com>
References: 
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1wr6b1-000097-TI
Subject: Re: [f2fs-dev] [PATCH RFC 06/14] fs/f2fs: stop using PG_private
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
 Vlastimil Babka <vbabka@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Dev Jain <dev.jain@arm.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
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

On Fri, 31 Jul 2026 22:13:29 -0400 Zi Yan <ziy@nvidia.com> wrote:

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
> No funtional change intended.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/f2fs/f2fs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Usama Arif <usama.arif@linux.dev>

> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8f3e632f315cc..edf01eb4b3b30 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2643,7 +2643,7 @@ static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
>  }									\
>  static inline bool page_private_##name(struct page *page) \
>  { \
> -	return PagePrivate(page) && \
> +	return page_private(page) && \
>  		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
>  		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>  }
> @@ -2662,9 +2662,9 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
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
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
