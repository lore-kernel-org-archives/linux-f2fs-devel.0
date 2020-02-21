Return-Path: <SRS0=zARH=4J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A445C11D00
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Feb 2020 02:43:46 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA0C208C4;
	Fri, 21 Feb 2020 02:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="b+IhcJgf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JakL7ke8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PTZvZBMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA0C208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j4yI5-0000As-L2; Fri, 21 Feb 2020 02:43:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jhubbard@nvidia.com>) id 1j4yI4-0000Ae-5m
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 02:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FupvP/7fBUSXeaHkpIPB/6auVkQxSnSk5TKtwtzmqZs=; b=b+IhcJgfxU88y0lwOtNas1uqrm
 h1jIrTR02NNJK7iCig3TnxJ60pjqEzNIbjOWB/sw0ybd2bqdkTKBa/yyzOxFQzQ15EzZJQSGmf9fz
 Regl8Q17KAtSDIfQ+7q8qDG/IKhMrtzlzGtDoJqd2LeM+yT01JQYcbLl2GwGU3Y6u23U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FupvP/7fBUSXeaHkpIPB/6auVkQxSnSk5TKtwtzmqZs=; b=JakL7ke8CPutVt3jHWFl/x98gi
 0hfIy6ysMfzNiu+hKxMEvvGjH6Z6MRp1nVFaAhQTVItwhqqOr9pxAyiBlDl5IC4MwBHldzrp23JoQ
 LtcLqVFJ/59HMaZtTKifrkQ5QKtq3LswdhL87IIZybg/R8nvRvPvu6jTLVYDFu3T85Tc=;
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j4yI0-0032vh-Aw
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 02:43:44 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4f43b30000>; Thu, 20 Feb 2020 18:42:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Feb 2020 18:43:32 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 18:43:32 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 02:43:32 +0000
To: Matthew Wilcox <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-2-willy@infradead.org>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <e065679e-222f-7323-9782-0c4471bb9233@nvidia.com>
Date: Thu, 20 Feb 2020 18:43:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219210103.32400-2-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582252979; bh=FupvP/7fBUSXeaHkpIPB/6auVkQxSnSk5TKtwtzmqZs=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=PTZvZBMqGka5juXI/K7VSjqGZuA2OQhrqobKWw47A6aYHII6j1MhFAvbELI3dGadM
 PrgKfenh6ZhddOY03XwMVWxrJdpVuH9XaaraajiQH62Xt5kO01Jn6Qq64S3BQBsQnu
 FX+2chIKaTlsU4YvxA1ANZxAzhOAPicsBXho8Xa1oRypUcTkxEzLnDv0caGzVLZrPo
 FwY554vv2RX9xx1O6PYXsc2ug3Oc5f7qahsBWhrzIuj6pupPO0et9/uor0PLX1V8Yf
 Sgy5K80isbnmNaNcnOFvHQt/nevDdWbyhIlyy/b+G7tAh95wVP/qHY4GiW4ZIyVq2q
 Oo9GNFt84iUNA==
X-Headers-End: 1j4yI0-0032vh-Aw
Subject: Re: [f2fs-dev] [PATCH v7 01/24] mm: Move readahead prototypes from
 mm.h
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/19/20 1:00 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The readahead code is part of the page cache so should be found in the
> pagemap.h file.  force_page_cache_readahead is only used within mm,
> so move it to mm/internal.h instead.  Remove the parameter names where
> they add no value, and rename the ones which were actively misleading.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/blk-core.c        |  1 +
>  include/linux/mm.h      | 19 -------------------
>  include/linux/pagemap.h |  8 ++++++++
>  mm/fadvise.c            |  2 ++
>  mm/internal.h           |  2 ++
>  5 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 089e890ab208..41417bb93634 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -20,6 +20,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/highmem.h>
>  #include <linux/mm.h>
> +#include <linux/pagemap.h>

Yes. But I think these files also need a similar change:

    fs/btrfs/disk-io.c
    fs/nfs/super.c
    

...because they also use VM_READAHEAD_PAGES, and do not directly include
pagemap.h yet.


>  #include <linux/kernel_stat.h>
>  #include <linux/string.h>
>  #include <linux/init.h>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52269e56c514..68dcda9a2112 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2401,25 +2401,6 @@ extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
>  int __must_check write_one_page(struct page *page);
>  void task_dirty_inc(struct task_struct *tsk);
>  
> -/* readahead.c */
> -#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
> -
> -int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
> -			pgoff_t offset, unsigned long nr_to_read);
> -
> -void page_cache_sync_readahead(struct address_space *mapping,
> -			       struct file_ra_state *ra,
> -			       struct file *filp,
> -			       pgoff_t offset,
> -			       unsigned long size);
> -
> -void page_cache_async_readahead(struct address_space *mapping,
> -				struct file_ra_state *ra,
> -				struct file *filp,
> -				struct page *pg,
> -				pgoff_t offset,
> -				unsigned long size);
> -
>  extern unsigned long stack_guard_gap;
>  /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
>  extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ccb14b6a16b5..24894b9b90c9 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -614,6 +614,14 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
>  void delete_from_page_cache_batch(struct address_space *mapping,
>  				  struct pagevec *pvec);
>  
> +#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
> +
> +void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
> +		struct file *, pgoff_t index, unsigned long req_count);


Yes, "struct address_space *mapping" is weird, but I don't know if it's
"misleading", given that it's actually one of the things you have to learn
right from the beginning, with linux-mm, right? Or is that about to change?

I'm not asking to restore this to "struct address_space *mapping", but I thought
it's worth mentioning out loud, especially if you or others are planning on
changing those names or something. Just curious.



thanks,
-- 
John Hubbard
NVIDIA


> +void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
> +		struct file *, struct page *, pgoff_t index,
> +		unsigned long req_count);
> +
>  /*
>   * Like add_to_page_cache_locked, but used to add newly allocated pages:
>   * the page is new, so we can just run __SetPageLocked() against it.
> diff --git a/mm/fadvise.c b/mm/fadvise.c
> index 4f17c83db575..3efebfb9952c 100644
> --- a/mm/fadvise.c
> +++ b/mm/fadvise.c
> @@ -22,6 +22,8 @@
>  
>  #include <asm/unistd.h>
>  
> +#include "internal.h"
> +
>  /*
>   * POSIX_FADV_WILLNEED could set PG_Referenced, and POSIX_FADV_NOREUSE could
>   * deactivate the pages and clear PG_Referenced.
> diff --git a/mm/internal.h b/mm/internal.h
> index 3cf20ab3ca01..83f353e74654 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -49,6 +49,8 @@ void unmap_page_range(struct mmu_gather *tlb,
>  			     unsigned long addr, unsigned long end,
>  			     struct zap_details *details);
>  
> +int force_page_cache_readahead(struct address_space *, struct file *,
> +		pgoff_t index, unsigned long nr_to_read);
>  extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
>  		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
>  		unsigned long lookahead_size);
> 





_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
