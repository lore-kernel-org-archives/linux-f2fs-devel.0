Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773CA606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z+m4FJvZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=A95eTx13;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j9idAexb;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFzUemGl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HnwPOtErDxTzZ0YZuMmfHnGRs4bRb9EJGXgXVI4/4/8=; b=Z+m4FJvZHRrDPo
	daMGUtQ23/Ji9Qanmph5I++wAjtfw/gnn6wGEwwHqNVftru32ViHpv48/mVy1XsTXkhc1P0DHkLfM
	oebgWOoX7JVfZCc6IoVlpbNqnS6e/6H7Zu/A7fF0MYMSdX9O0qQD1POVgz+yFUV4c3jIrCrMao6Ys
	OG8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTH05-000000006No-0hq2;
	Tue, 17 Nov 2026 11:05:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTGzu-000000006Na-38tp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:05:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0aeLPSDDDFeW1BLMOTbObFuLTDcOldTAMyOYwl0JEB8=; b=A95eTx13eXb3GGNP+q0o8JCTvF
 6M5Lxooi1DWA5cWdFdxKkArvtr2IHIcmvpjzvCq/TK2A9zUOm+r4alU4UzdV3BgbCdNRVic1jrz2V
 hrph1ALyyxSJo1KrK3t3gxyy5oCWMSZQs8GtyCU2b0Dm54UX0up0ZlOXf29+u+sxsVFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0aeLPSDDDFeW1BLMOTbObFuLTDcOldTAMyOYwl0JEB8=; b=j9idAexba/0AGCeK+GaUnrybAT
 U/nYocoLnkFR9J7/6SYhFRhgxy/TLNTieyJcKlo7imiPRtY7G7JN8YVzHc3S+0kFWMrHVSxTsVQuW
 G6GVCpYyG65I92cR5NuQTrHWIEaEw3hnTixhKwkfi2Mw/z+1wc3cZcf19iHLmh66swGw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTGzt-000000002tL-1Ryv
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:05:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F3AAC40804;
 Tue, 17 Nov 2026 11:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADC51F000C4;
 Tue, 17 Nov 2026 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794913503;
 bh=0aeLPSDDDFeW1BLMOTbObFuLTDcOldTAMyOYwl0JEB8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=oFzUemGlpJZqX5lszMojpcUV/qvVrTIYEwiEaGIbfRxml3yFEy5bygJ+dfbJU/cct
 SgDwRQNfpiPChQ3dwpZyOrfRQZeKPq78FFMWrqN6DsFZZ4ocwX68GkcOOeB/24s+fn
 EwY6DtUSkAXBkk47b9VqEelBaWVqiPmwseJCS3ejqePFUN7VnerhKNLILGiI5gAzzL
 gQzCqbXU4JFpA7S1ZiwZ67hIHuxD6gFgofEI9Kpwu7EWuvyKg7ltBpqz8iNfd5tE0q
 p5hLa3jO/Cma4sTl90Kl9k640UhHcCCtMgVXSg3BnmsZOL4aMs+NwjaG1g9bKzXUdh
 3CMs2rABRHTpg==
Message-ID: <aefcfd01-62b1-4e03-b1eb-bc46cd4b54fb@kernel.org>
Date: Tue, 17 Nov 2026 19:05:01 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-9-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-9-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTGzt-000000002tL-1Ryv
Subject: Re: [f2fs-dev] [PATCH v2 08/20] f2fs: adapt range operations and
 mmap for subpage blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> - A writable PTE covers the whole folio, so page_mkwrite prepares
>   every block of the folio up to EOF and dirties only those blocks. It
>   reserves them only where it may allocate, i.e. not for a pinned file
>   or a compressed cluster.
> - Align zero range, punch hole, preallocation and truncation to the
>   block size instead of PAGE_SIZE. When i_size grows, write-protect the
>   folio straddling the old EOF so that stores to its new blocks fault
>   into page_mkwrite.
> - Update i_size of an extending direct write in ->end_io(), before
>   iomap invalidates the page cache of the written range, as ext4 does.
>   Otherwise, a read in between zero-fills the blocks beyond the old
>   i_size in the folio straddling it and marks them uptodate, which hides
>   the data just written.
> - Unmap every base page overlapping a punched or zeroed range, and
>   truncate the page cache without truncate_pagecache_range(), whose
>   unmap underflows for a range ending in the first page.
> - For SEEK_DATA, treat a NEW_ADDR block as data only if the block
>   itself is dirty.
> - When truncation zeroes the tail of a page, mark only the block
>   holding the new EOF dirty, not the blocks after it.
> 
> The SEEK_DATA change also applies to large folios when the block size
> equals PAGE_SIZE. The direct write change applies to any block size, so
> i_size is also updated before the sync of an O_DSYNC direct write.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
