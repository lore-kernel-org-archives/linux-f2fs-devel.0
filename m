Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41597C021B8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:05:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tpNGz-0003I9-VU;
	Tue, 04 Mar 2025 08:05:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tpNGy-0003Hx-Hc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Mar 2025 08:05:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HBF+ozxUryAusz7o0VQZu9Bhmt77IPQRTNIUciqZ6hI=; b=mjB2cYOF7qQysPp0jAYDn0HYdu
 V5aZLkXRM0vlyppmEmegTQdFeyPXZChgCeXUNsXFm/OoSxLj3iTDAC4zIFhXiiMx/6TBLM+zNat3b
 tHp2PoEOmJX7IOu4+DSY2bQuqlceehjdeLebiAm1RvxAqlabSmPHQS46JJD4nb4dBjLc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HBF+ozxUryAusz7o0VQZu9Bhmt77IPQRTNIUciqZ6hI=; b=IVsHyO1/4kNHr6/rOfERTYcuPs
 swbKS0T+klzdXenSyYqNO3a0ua+/a85mjpQhRvQVnlcINT47S3J/U8zGe0vmv6UIPkoRMpyJbnvFK
 x2Cpqklmhc9M9Q48RJJr2orlWiCHXLOiP4F4lFxwqfdxGOKFpo4X66gTLELW6zUqF1zk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tpNGt-0008CK-JP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Mar 2025 08:05:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 603965C5611;
 Tue,  4 Mar 2025 08:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5078C4CEE5;
 Tue,  4 Mar 2025 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741075488;
 bh=jxzf9EMu80D/xw6wMny6zC+ffLHTA+eDbzGVqYf9o7E=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=NeErzgGelshQwygHqkAEWZ1D16syUHsOm2+EQfSFYYRSrprvFZ2GrIzxDp/V1weHf
 4luPhTxsNb3FPr0J3AUX6Nj6G+WWSFkX1hSKIxPHzV7BHWEnbvZOW2nUTjKeUO/YEi
 nm1wrK6DLDLRGpxSBB9Ne6uWjZ+Q9rXsQAIqNSmcx4IouWvg0M6mMgG/9g7XUa5qO6
 aftzda6renm4px4yuhhltl2uQrV765hAxOHkN9JFANw014Zp2IqWPr6tCrqsPY6NjV
 QoD9EXEtXkRdFhs9VkejsWEvUcrghvPKu5Jq/fij60Jqwy9wEifcJwTsDdzDv/ZK/w
 RoCUeePKFXt/Q==
Message-ID: <57e98b92-56db-4217-b11c-b9b716f54de1@kernel.org>
Date: Tue, 4 Mar 2025 16:04:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250218055203.591403-1-willy@infradead.org>
Content-Language: en-US
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
X-Headers-End: 1tpNGt-0008CK-JP
Subject: Re: [f2fs-dev] [PATCH 00/27] f2fs folio conversions for v6.15
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
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/18/25 13:51, Matthew Wilcox (Oracle) wrote:
> More f2fs folio conversions.  This time I'm focusing on removing
> accesses to page->mapping as well as getting rid of accesses to
> old APIs.  f2fs was the last user of wait_for_stable_page(),
> grab_cache_page_write_begin() and wait_on_page_locked(), so
> I've included those removals in this series too.

After fixing f2fs_put_page(), whole patchset looks good to me.

Jaegeuk, feel free to add:

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Matthew Wilcox (Oracle) (27):
>   f2fs: Add f2fs_folio_wait_writeback()
>   mm: Remove wait_for_stable_page()
>   f2fs: Add f2fs_folio_put()
>   f2fs: Convert f2fs_flush_inline_data() to use a folio
>   f2fs: Convert f2fs_sync_node_pages() to use a folio
>   f2fs: Pass a folio to flush_dirty_inode()
>   f2fs: Convert f2fs_fsync_node_pages() to use a folio
>   f2fs: Convert last_fsync_dnode() to use a folio
>   f2fs: Return a folio from last_fsync_dnode()
>   f2fs: Add f2fs_grab_cache_folio()
>   mm: Remove grab_cache_page_write_begin()
>   f2fs: Use a folio in __get_node_page()
>   f2fs: Use a folio in do_write_page()
>   f2fs: Convert f2fs_write_end_io() to use a folio_iter
>   f2fs: Mark some functions as taking a const page pointer
>   f2fs: Convert f2fs_in_warm_node_list() to take a folio
>   f2fs: Add f2fs_get_node_folio()
>   f2fs: Use a folio throughout f2fs_truncate_inode_blocks()
>   f2fs: Use a folio throughout __get_meta_page()
>   f2fs: Hoist the page_folio() call to the start of
>     f2fs_merge_page_bio()
>   f2fs: Add f2fs_get_read_data_folio()
>   f2fs: Add f2fs_get_lock_data_folio()
>   f2fs: Convert move_data_page() to use a folio
>   f2fs: Convert truncate_partial_data_page() to use a folio
>   f2fs: Convert gc_data_segment() to use a folio
>   f2fs: Add f2fs_find_data_folio()
>   mm: Remove wait_on_page_locked()
> 
>  fs/f2fs/checkpoint.c    |  26 ++--
>  fs/f2fs/data.c          | 130 ++++++++++---------
>  fs/f2fs/f2fs.h          |  90 +++++++++----
>  fs/f2fs/file.c          |  24 ++--
>  fs/f2fs/gc.c            |  42 +++---
>  fs/f2fs/node.c          | 279 ++++++++++++++++++++--------------------
>  fs/f2fs/node.h          |   6 +-
>  fs/f2fs/segment.c       |  26 ++--
>  include/linux/pagemap.h |   9 --
>  mm/filemap.c            |   2 +-
>  mm/folio-compat.c       |  14 --
>  11 files changed, 338 insertions(+), 310 deletions(-)
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
