Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C1BCA9EC7
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 07:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DcNndgj06IeXkA8dHuT6tHodY0/HUWXgQFRUAWMdLbA=; b=nOABpsj7xLHq5Vy/EeNp2bXE0s
	1u/NfxaJciJ0CSh+OqgC9P9aEJx2IIvhlm002jAtaj6MukeQKRZw8Mvo/f+lv7ZocBtsUAFYlewpe
	GvWFTfQ3PyU3LkzLP3SKRjRqzN+JZqZ+EiJcVmA7EtX0jgsryGNdImijbC+E2j5NwCmM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFnjk-0007bO-H1;
	Sun, 11 Oct 2026 07:12:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFnjY-0007aI-8y
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 07:12:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Q3x3Mf48yf/z+Pl8/DxTpFVbkK9gz1N9GTRxAQWZYA=; b=aVYoUPxFjBprMbz5flYpTVDlV6
 45JF3HfmCN7YxO3CLLrJ9Tc+KBcbyuP+m+LG8WzELStfXMIZOWgGGjJD5xxrI0PJEYhHh4KSAZgfY
 emSRYRVbVQEES9sixY5E//wHiL9/92rfuCNGYC3+ovBVYUmx41RTqCBPxpx9i8YQvY6w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9Q3x3Mf48yf/z+Pl8/DxTpFVbkK9gz1N9GTRxAQWZYA=; b=HZqYgYrlXHqLRQldvhywTtk2zm
 fGr/jtiphLWDv3XjYQLHUKaVigquphL0K38UM67vfrMdRpZFeSWiegdOvJCqx0wOYEo3tMGn/IoJT
 zj2LZ3mxEqfEzlqlGKs1CT0XvB+tjxyn2O+sffTbCLOUGSEtBZd6424kB9TKSgAJLnLs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFnjY-0003lA-Ce for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 07:12:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 88137600AA;
 Sun, 11 Oct 2026 07:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C421F0089B;
 Sun, 11 Oct 2026 07:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791702750;
 bh=9Q3x3Mf48yf/z+Pl8/DxTpFVbkK9gz1N9GTRxAQWZYA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=gB8VNHt0hqOqDf+KphZB1k6+N95+y36bXPyGxJJmaGOZfb5jF2ah6NPEoV5Qfccnu
 8xi3+Lp3vsgF5icpHxTDnSMJNtYYBZEddPHkffBvRxDxmleZkWVepzsGWWzfJT4Fcr
 dagmOlpcqKwFlUDPK1c3QG+83rjSZTNquJlTWr03E+XlzyS8Iyerv5038+tmgpHxaP
 dJY6hzses81q53lkyjZMnBBqLs9/M6fi4fp7GcAatl4uve0L80tgvZrm86vJad6Hw0
 1TaxcwsMfDgv3Hw15hl8Z/RATO7nPQkzjB1OW2+/T45W1cgmNjJAyO3OT90Vm/m11E
 CQ41Ot2t3OgIg==
Message-ID: <97c38f99-76ca-4e2d-8f2a-a47047d78ab2@kernel.org>
Date: Sun, 11 Oct 2026 15:12:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xFnjY-0003lA-Ce
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: remove mappedtodisk flag usage in
 mmap write path
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
Cc: Barry Song <baohua@kernel.org>, stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/11/26 12:02, Nanzhe Zhao wrote:
> PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
> f2fs has no buffer heads and the flag is no longer meaningful.  The only
> user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
> which makes mmap write faults skip marking the folio dirty.  Chao Yu
> pointed out that this is not only a cleanup: it causes the following
> race condition with filesystem freezing:
> 
>   CPU0 (write fault)     CPU1 (freeze_super)
>   ----                   ----
>   f2fs_vm_page_mkwrite()
>   sb_start_pagefault()
>   /* shortcut: no dirty */
>   sb_end_pagefault()
> 
>                          sb_wait_write(SB_FREEZE_PAGEFAULT)
>                          /* no waiter, passes */
>                          sync_filesystem()
>                          /* folio not dirty, skipped */
> 
>   finish_fault()
>   /* PTE writable */
>   fault_dirty_shared_page()
>   folio_mark_dirty()
>   /* dirty folio on a frozen fs */
> 
> It will also skip APP_MAPPED_IO iostat/REQ_TIME updates and post-EOF
> folio zeroing.
> 
> Remove this shortcut in f2fs_vm_page_mkwrite() and stop setting it in
> f2fs_read_single_page().
> 
> Reported-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/linux-f2fs-devel/496b913c-eb81-4fa8-be72-c6a06a10aba2@kernel.org/
> Fixes: fbfa2cc58d53 ("f2fs: add file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
