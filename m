Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C498CA5FC4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6IxW1KJr+83u4Z+E/qrArx62KlcHeshqJM3AITnRVs=; b=LR8Vw95omjMItyIrh18XX5G8+C
	kM/Pc5WlywMAKJIUev+yZlCkebnQywiHcjACuuX4l/bWpYcv2F0lor1BKU7KWj2kg8Kgt1IEeOv7P
	2gWwZDNFGoQoSHviumxdhXDxVTvRJuzZoATHkIRRjSfPvLJTgS6SstZG2wWluBkrr20Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBxnl-00064R-LT;
	Wed, 30 Sep 2026 17:09:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1xBxnk-00064L-HK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 17:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jSjqplrgiCHFH8A0JtVNipwXww+bF6YjcE6zbN6wZVk=; b=UxaOvX+e536bI0PQtaORnxPYIc
 gHbmOQ0aIRfE1ZGZ2RG3M7slXAAHzDvGGbsJYsE04RgqedTO7s2KQ7oFZzv9IZNb2u3JIdZtOy4dS
 G91Lz/ZSOwQUySKOjvgaDXEuBBEcSJDtEkDeio3rFxTCATSjZAxJX9YeXwEtGkLA5shQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jSjqplrgiCHFH8A0JtVNipwXww+bF6YjcE6zbN6wZVk=; b=nVG+znapIoPYutzsHSfFnn/JZo
 EFDvlFEPsi3pu6AhsTLWyHQNpKFcfVAyn73fIZpwaO57vfabAiLgBF/tZMFKPWu7vuWcIIWwXHNJP
 jD++LCBWrskTxgZ5hzDSPRZIE0dxutMYliadQs3u7WIEzAobpMqwXskR0oVcVVQNqEGo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBxnf-0001mR-VG for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 17:09:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95D104139E;
 Wed, 30 Sep 2026 17:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7721F000FF;
 Wed, 30 Sep 2026 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790788134;
 bh=jSjqplrgiCHFH8A0JtVNipwXww+bF6YjcE6zbN6wZVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JmjO9ohhyftJ89qzAloluBgpiACFtYFR5m5CaJdPxFAKeQDVrKxfTZivE7U7EYseS
 L8CPR/+os9sU+2T4m5aPEHZmGyE1MayJ+XmB2HqxnsJrzcPMxr/wtCE/hkg3SKCqtA
 s3AHQ8WFbRE9C1rVTn8K02Z2X2WcaKwJ0GAmRMMNKhaoyZ1PyPJR6Q8uzuV7duuZUT
 LGRde49EpH7at6f/iKFF5b7TvR19uLQv/FwG/FiI8rPADn9jZ15VR60JV+0P3+Z2NU
 qjfd68/O9J8sYjJnMHJuxgclOVG43wt7M6fwsCT+3ny7F0pGIASI6cfcDqPqoFkPgS
 hmZ58kXPql/Bg==
Date: Wed, 30 Sep 2026 17:08:52 +0000
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Message-ID: <ar1CJBRumJ0hcNdB@google.com>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xBxnf-0001mR-VG
Subject: Re: [f2fs-dev] [PATCH v2 00/14] f2fs: support & optimize large
 folios for writable files
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Nanzhe, are you going to submit v3 soon?

Thanks,

On 09/15, Nanzhe Zhao via Linux-f2fs-devel wrote:
> This series supports large folios for most readable/writable files
> in buffered I/O paths, including normal files, block-layer encrypted
> files, and atomic files except for inline-data files, compressed files,
> and quota files.
> 
> It also extends f2fs_folio_state to coexist with f2fs page-private
> flags and to handle large folio write path and partial truncate of
> large folios correctly.
> 
> Benchmark details can be found in the RFC v2 cover letter [1].
> 
> [1] https://lore.kernel.org/r/20260622160830.324455-1-zhaonanzhe@xiaomi.com
> 
> Changes in v2:
> - Addressed most of Chao's and Daeho's review comments.
> - Updated docs for compress policy with large folios.
> - Link to v1: https://lore.kernel.org/r/20260826082641.2007658-1-zhaonanzhe@xiaomi.com
> 
> Many thanks to Chao and Daeho for your extensive reviews and valuable
> suggestions!
> 
> Nanzhe Zhao (14):
>   f2fs: extend folio state for large folio write path
>   f2fs: carry subpage offset and count in write IO
>   f2fs: support regular file buffered writes on large folios
>   f2fs: support atomic file large folios buffered write
>   f2fs: support large folio writeback
>   f2fs: prepare mmap write faults for large folios
>   f2fs: make GC migration large-folio aware
>   f2fs: optimize small block size large folio read
>   f2fs: support partial uptodate large folio read
>   f2fs: handle partial truncate of large folio dirty subpages
>   f2fs: fix zeroing paths for large folios
>   f2fs: handle block cloning within the same large folio
>   f2fs: allow large folio support to writeable files
>   f2fs: make compressed files compatible with large folio
> 
>  Documentation/filesystems/f2fs.rst |   10 +
>  fs/f2fs/checkpoint.c               |    2 +
>  fs/f2fs/compress.c                 |    3 +
>  fs/f2fs/data.c                     | 1221 +++++++++++++++++++++++++---
>  fs/f2fs/f2fs.h                     |  105 ++-
>  fs/f2fs/file.c                     |  229 ++++--
>  fs/f2fs/gc.c                       |   32 +-
>  fs/f2fs/inline.c                   |    7 +
>  fs/f2fs/inode.c                    |    4 +-
>  fs/f2fs/namei.c                    |    1 +
>  fs/f2fs/node.c                     |    2 +
>  fs/f2fs/segment.c                  |    6 +-
>  12 files changed, 1404 insertions(+), 218 deletions(-)
> 
> -- 
> 2.43.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
