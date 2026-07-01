Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E45C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bJPGSTSBRv7HPtkjSPi9JcB11FvtH3qayB90RczEUS4=; b=RcAu41V4lDiNW+CDh7YqU+HcUv
	Gv5aRQ/n/9UJ4wLyv1W0acbDsDztF5KYKXDctFvmsFvNur9C1jrYQ6nH/Dt7x6gQdWgxrwBK1zY3H
	z80G9m1vwtTtArF/IzKoZ5NvsCs9n+OQ97PtSAUEQlMG8jgME1gLx5NspxkPuGEp7B8o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weloN-0002S3-Ob;
	Wed, 01 Jul 2026 03:40:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1weloA-0002Rq-EI
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 03:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+kGc6vKYF0ISymtZWZiHcjnaf8azXLVbKrSZM1fXWnA=; b=mPmZq4J65rRHdYt26gDO15i3Ls
 hi3oO1RRcamN4Otu1nwaLfwiZEXfXi+cI72t7tjamjk3FU+2/nctdXgREJ3n2srfQicIW76xO+MqH
 7vnvWBq7s5+cO6uWIW8I54iTcxAYQlNKF9Z6LP3syBnPquOaD7JE2krxpqEMfdR8k3ZA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+kGc6vKYF0ISymtZWZiHcjnaf8azXLVbKrSZM1fXWnA=; b=QYEriCRHM3oRUZ5fKEdYboCgWl
 8GSxPh9xftsPSR61Q5mxYKpvoRkQVojQGijhnHFQZbUoaRfm4DoaNWxqFmRLEoWoeB+rDh0w2naZJ
 6KsYCJ5kRaEJLSfQMvqVN5mXmiTRYuL4Cl6jsZLq9BNHlPQRLI+ico7g49XvmuZwJ0Ew=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1welo0-00023m-EU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 03:40:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EFF26001D;
 Wed,  1 Jul 2026 02:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9461F000E9;
 Wed,  1 Jul 2026 02:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782874308;
 bh=+kGc6vKYF0ISymtZWZiHcjnaf8azXLVbKrSZM1fXWnA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=iWz+1L6gw073hlnfPn+8XwuVsznY2q73WrSN37jNB7575ko2hBOQ7mN+uHOeJkYJ0
 PihogaKsAQ5JZ6hE3E6nTJjkaAG+YRFm8Ex6xcFxX1FxiGxhL9rDuEr9cHwE7/aQPW
 V97Da6ah4rPXn2dsz8ATbcfNOsSA1YJljyVT0tT+RIifjKj6v8YlSW3dByOlfYAReM
 Zk3ldizOJ55vktuRFAV1dkavmM8ZNoVWYp6iVPtbd3vgrdF2Ct+8n946psKbopsQRv
 gpIVdMRnt7mHyyJoQr7TZ8n9/DbEbusBpTwe1WZojdw0+t9biEaxo4yQu6RAkvyCrA
 TmceloRuX0rSA==
Message-ID: <4f42a63f-3b96-4928-aaf8-70e3c1abfad2@kernel.org>
Date: Wed, 1 Jul 2026 10:51:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1welo0-00023m-EU
Subject: Re: [f2fs-dev] [RFC PATCH v2 00/10] f2fs: support & optimize large
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <nzzhao@126.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Nanzhe,

I can see a lots of testcases failure in xfstests, can you please address all
of them?

On 6/23/26 00:08, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <nzzhao@126.com>
> 
> Make some clean up based on v1, and support minimum folio orders 
> beyond zero.
> 
> This RFC series supports large folios for most readable/writable files in
> buffered I/O paths, including normal files, block-layer encrypted files,
> and atomic files. Compressed files are still excluded.
> 
> Atomic files need explicit support here because Android enables atomic
> writes through ioctls, which mark the inode as an atomic file
> (FI_ATOMIC_FILE). Once large-folio mapping is enabled for such a file,
> the atomic buffered write path also needs to handle large folios
> correctly.
> 
> In the write path, allocating f2fs_folio_state for large folios starts
> to conflict with f2fs page-private flags. This RFC series extends
> f2fs_folio_state so that it can also store f2fs private flags, and
> updates the existing PAGE_PRIVATE helpers to work correctly with
> f2fs_folio_state.
> 
> In addition, fio results with max large-folio order set to 2 showed
> that 4K read/write performance did not improve much.
> Analysis showed that one important reason was the extra spinlock traffic
> from incrementing read_pages_pending once per 4K subpage.
> This RFC series therefore adds two optimizations to
> f2fs_read_data_large_folio:
> 
> 1. batch read_pages_pending updates by the mapped block count instead of
>    incrementing it once per 4K subpage;
> 
> 2. skip f2fs_folio_state allocation when a single block mapping / BIO
>    covers the whole folio, because folio_end_read() can complete such a
>    folio without extra per-folio state.
> 
> In the benchmark tables below, "skip=1" means enabling the second
> optimization above, i.e. skipping f2fs_folio_state allocation for the
> whole-folio-in-one-bio case.
> The "batch" optimization refers to updating read_pages_pending in
> and add to bio in larger chunks instead of once per subpage.
> 
> Test environment:
> - Device: Pixel 6 (device1A, 1A071FDF600053)
> - Filesystem: f2fs on dm-49, inlinecrypt enabled
> - File size: 256MB
> - Repetitions: 10
> - Prepare: end_fsync + sync + drop_caches
> - Fio: psync, direct=0, iodepth=1
> - Max folio order: 2
> 
> Table 1: HOLE_READ (10 repeats)
> ------------------------------------------------------------
> All bandwidth numbers are in MiB/s. Non-baseline entries show the
> absolute value followed by the percentage delta relative to the
> order=0 baseline in parentheses.
> 
> | bs  | order=0 | order=2 |
> |-----|---------|---------|
> | 4k  | 469.6   | 521.9 (+11.1%) |
> | 64k | 668.1   | 852.4 (+27.6%) |
> | 1M  | 653.0   | 867.2 (+32.8%) |
> 
> Table 2: DATA_READ (10 repeats)
> ----------------------------------------
> | bs  | order=0 | batch=0 | batch=1,skip=0 | batch=1,skip=1 |
> |-----|---------|---------|----------------|----------------|
> | 4k  | 441.6   | 456.5 (+3.4%) | 499.7 (+13.2%) | 544.4 (+23.3%) |
> | 64k | 632.8   | 697.0 (+10.1%) | 837.8 (+32.4%) | 990.9 (+56.6%) |
> | 1M  | 601.5   | 733.0 (+21.9%) | 927.5 (+54.2%) | 963.4 (+60.2%) |
> 
> Table 3: WRITE (10 reps)
> ----------------------------------------------------------
> O = overwrite (N = new write, Y = overwrite)
> S = sync / fsync (Y = fsync enabled, N = no fsync)
> W = writeback (Y = background writeback, N = no writeback)
> 
> | O,S,W | bs  | order=0 | order=2 |
> |-------|-----|---------|---------|
> | N,N,Y | 4k  | 263.4   | 286.3 (+8.7%) |
> | N,N,Y | 64k | 683.5   | 1199.6 (+75.5%) |
> | N,N,Y | 1M  | 767.4   | 1383.8 (+80.3%) |
> | N,Y,N | 4k  | 10.8    | 9.1 (-15.7%) |
> | N,Y,N | 64k | 69.3    | 50.3 (-27.4%) |
> | N,Y,N | 1M  | 103.5   | 157.8 (+52.5%) |
> | Y,N,Y | 4k  | 301.6   | 344.1 (+14.1%) |
> | Y,N,Y | 64k | 691.3   | 865.9 (+25.3%) |
> | Y,N,Y | 1M  | 742.3   | 969.2 (+30.6%) |
> | Y,Y,N | 4k  | 9.5     | 17.1 (+80.0%) |
> | Y,Y,N | 64k | 43.5    | 108.2 (+148.7%) |
> | Y,Y,N | 1M  | 140.9   | 146.6 (+4.0%) |
> 
> Nanzhe (9):
>   f2fs: extend folio state for large folio write path
>   f2fs: carry subpage offset and count in write IO
>   f2fs: support regular file buffered writes on large folios
>   f2fs: support atomic file large folios buffered write
>   f2fs: support large folio writeback
>   f2fs: prepare mmap write faults for large folios
>   f2fs: make GC migration large-folio aware
>   f2fs: allow large folio support to writeable files
>   f2fs: optimize small block size large folio read
> 
>  fs/f2fs/compress.c |    2 +
>  fs/f2fs/data.c     | 1015 +++++++++++++++++++++++++++++++++++++++-----
>  fs/f2fs/f2fs.h     |   75 +++-
>  fs/f2fs/file.c     |   81 ++--
>  fs/f2fs/gc.c       |   30 +-
>  fs/f2fs/inode.c    |    6 +-
>  fs/f2fs/segment.c  |    4 +-
>  7 files changed, 1064 insertions(+), 149 deletions(-)
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
