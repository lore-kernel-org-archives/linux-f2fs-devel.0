Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6315CCA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F4yWB6K17AtdqcXe6l16lJ/bWb3MYqXKnKP45IOO7gg=; b=aVU9rHQNh/gGTrqU/iVIXejaHY
	Apfmkp030vzm/nFhF04Bx6EFoIP226K+Q2GfIUXCibRbgt4MGz/OvJACJbKVKQUsJ0vMYv2k96jz3
	hFxTa5KPsPUS4vsDD6KVp7GVZngpWeI01MbLpdzps7mMJIs/PGfc7Wb3TluRNibfSLxE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF5NF-00010r-7b;
	Fri, 09 Oct 2026 07:50:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF5NE-00010l-25
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 07:50:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AJ+MGPAc0qtvAZ5lMeuZhHsjR9jN2u0XdDB05gWsN10=; b=a5zKdtPP1Q/ZLP4mQ05TIM5Ecw
 n4cDbhcps+eDpS+b+QorT99oqLvY9tsMQ5wWxIcVJ79zrVu6wlOuC0akUA3R9tAKerqvGF3MQTNQv
 YSZxC546S7YU5nfVRYa05+2z1hV4coQlW3Nyo+c7Q2mFPpWYJSqm9/pYcOeJbMOg0nQI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AJ+MGPAc0qtvAZ5lMeuZhHsjR9jN2u0XdDB05gWsN10=; b=VC0rvLHNsQH++EPlc7jYPBmVsh
 VXyz7bZLiy4B1/G3nYPDPLVCkI7xWIxd6IF/qMy0c30U6scO2slJ7/fPdkJ4BAUYrOuGMGlFAb8pw
 Ko5tA16tMPApnpo0fW2uaZrVJ5+BVBRSNRDgPUIPkcwMRpj4FOeJUQ3pDscdk74fsebQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF5NC-0006xy-Rt for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 07:50:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 394E3602CA;
 Fri,  9 Oct 2026 07:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE27D1F000FF;
 Fri,  9 Oct 2026 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791532228;
 bh=AJ+MGPAc0qtvAZ5lMeuZhHsjR9jN2u0XdDB05gWsN10=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=WHUv1/thbY4uf2pqjHi5x8Yq3qKrwCceAXVUgScpiQyS/wfOY/ssa1rUUwXYf2CXj
 ZY5vR61Ri/LfULSOhYXB+EeS3Jlk0FJQ890Tnh4yTDOUBprRs5unQKKxsUj0VijobG
 7vYtJWo+9eX20eVDQP0EmVvDwVoohxCwQ3GisZ015IAC/jXXqWWj2FrXtLQLj+5t7k
 FFhfi5A6U695r0fw35p/k/HcHz38vWC3XLQIvddSod24lcN/zd0euFq12kdFxb2IZ6
 zKCOwoJSJoptSTQZgHb6IskIWKU3cY4TxP9O6ZJS23Ptg1lcIrWJUofijrnez4bELK
 32kiwtu93QLVQ==
Message-ID: <496b913c-eb81-4fa8-be72-c6a06a10aba2@kernel.org>
Date: Fri, 9 Oct 2026 15:50:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260921124439.568654-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260921124439.568654-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xF5NC-0006xy-Rt
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove mappedtodisk flag usage in mmap
 write path
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
Cc: Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/21/26 20:44, Nanzhe Zhao wrote:
> PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
> f2fs has no buffer heads and the flag is no longer meaningful.  The only
> user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
> which makes mmap write faults skip:
> 
> - zeroing the post-EOF part of the faulted folio,
> - marking the folio dirty (mm dirties shared file mappings after
>   ->page_mkwrite() returns, so this one was not noticeable),

Nanzhe,

Oh, this is a bugfix instead of a cleanup?

Because in below race condition, we may dirty folio after frozen, and there is
chance it can write the dirty folio to the frozen filesystem? IIUC.

    CPU0 (write fault)                       CPU1 (freeze_super)
    f2fs_vm_page_mkwrite()
      sb_start_pagefault()
      ... folio NOT dirtied by f2fs ...
      sb_end_pagefault()
                                             sb_wait_write(SB_FREEZE_PAGEFAULT) -> no waiter, passes
                                             sync_filesystem()
                                               finds pages via the DIRTY tag -> folio not dirty, skipped
                                             fs frozen
    finish_mkwrite_fault()
      PTE becomes writable
      fault_dirty_shared_page()
        folio_mark_dirty()   <-- dirty folio, writable PTE, on a FROZEN fs

Thanks,

> - APP_MAPPED_IO iostat and REQ_TIME updates.
> 
> Remove this shortcut in f2fs_vm_page_mkwrite() and stop setting it in
> f2fs_read_single_page().
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  fs/f2fs/data.c | 1 -
>  fs/f2fs/file.c | 6 ------
>  2 files changed, 7 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a3b02c067e89..14cea508ae01 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2264,7 +2264,6 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
>  got_it:
>  	if ((map->m_flags & F2FS_MAP_MAPPED)) {
>  		block_nr = map->m_pblk + block_in_file - map->m_lblk;
> -		folio_set_mappedtodisk(folio);
>  
>  		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
>  						DATA_GENERIC_ENHANCE_READ)) {
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b0bdc7a977b9..5fc491c0a69d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -218,12 +218,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	/* wait for GCed page writeback via META_MAPPING */
>  	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>  
> -	/*
> -	 * check to see if the page is mapped already (no holes)
> -	 */
> -	if (folio_test_mappedtodisk(folio))
> -		goto out_sem;
> -
>  	/* page is wholly or partially inside EOF */
>  	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
>  						i_size_read(inode)) {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
