Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A045DCC6B19
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/5PL7PXE2VPWf0M3KEbLgvEJBydTNGOqMDQb4J6NT74=; b=AJ51VtVr1NJWXJYuTH0Yppfm3V
	h3322HfWRm+xqVu9Y6N+9AWiy8o3ppNv66mOk9+MRzlNr9/55S/W0b3Gf1RV2Zsrr6YfAX2UImvh6
	emJA4TcRV3YCg1uln1gW+oA4SjXRAUJVQxDvAyOEA9RjTuu/4eJoS7DvfzKcCkTESN8s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGo1y-0000hO-8x;
	Wed, 14 Oct 2026 01:43:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1xGo1R-0000Nf-I9
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 01:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tnB1R60CVpPwZn+HnZfst5yiiD+KHeL0wsgAMHC34QQ=; b=aimWCccyA0vHdzdABGN/HoriO0
 +eo9S6JxRU1xrLGDsBRaSMBmFVjBESl/cfGiGi29aI7h0v15m9y5r7ex6kAYInOWslzdYKw1a2bId
 Okui2j8Q7I5ObI3Q0nXRYTpjM0hbfCFdvuVilcKfpsKnAqmLHIC2IKvFP+bnrT9hL5wA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tnB1R60CVpPwZn+HnZfst5yiiD+KHeL0wsgAMHC34QQ=; b=Pnq60uDQFom6u0G/AsdJkCCXsf
 PIGFxKwjesDk/l+2jBl00m1xAptPtxyWQy6yR7HhK0VVEbGgNhvmMub9tKfK9JZzVgG2yWuYX2GTK
 nP0g5PaCztQdgyLSrzOm8G3XXINkNtYrcv7RhuBYHxn2Iuu935guwUPrX7lHLRUdNYb0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGo1N-0003mA-HC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 01:43:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDAEC600CB;
 Wed, 14 Oct 2026 01:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F721F000FF;
 Wed, 14 Oct 2026 01:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791942183;
 bh=tnB1R60CVpPwZn+HnZfst5yiiD+KHeL0wsgAMHC34QQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TqQNQgrToLbt3B/o2WllcvRFtKcxRiSlMPc9J+h/rsW/4sYIFhgNapemmzNvtMNgR
 b/PS1IoLU/jcrOCPaVLQhPR6R1YCpdHZjwRmltKUNLcZXtuLPmg5rgeKDA6Qxs3P/j
 Iwxz3zS1NXdVAV7VG0YTRCyayo72xslSXVU8xRm256oJy3ZIjj6VA/BXBNAPpJkgBs
 q5A8b6W80vYw2WjX7cNEbW/nV0oznutqzzxgZ49fxh+JOhKkcqbhQTLNTjn5p4Biuq
 fp/jMd4rO3hJmRaqwhRpeaFNyuE5iM/b1eFWPx4JDliqdYaRf0f6Gf9JI0MaRidqek
 8PXj3sMfEmVqg==
Date: Wed, 14 Oct 2026 01:43:00 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <as7eJJRyJk61kuf1@google.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
 <as58gCX6mzaExhxs@google.com>
 <0392781c-0ef7-4cd8-b48c-cde83e09abb4@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0392781c-0ef7-4cd8-b48c-cde83e09abb4@kernel.org>
X-Headers-End: 1xGo1N-0003mA-HC
Subject: Re: [f2fs-dev] [PATCH v4 00/18] f2fs: support & optimize large
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
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/14, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 10/14/26 02:46, Jaegeuk Kim wrote:
> > Hi Nanzhe,
> > 
> > Could you please rebase your patches on top of dev-test?
> 
> Nanzhe rebased the patchset to linux-next, so sashiko can apply & review
> the patchset as expected.
> 
> The gap here is two missing cleanup patches from Zi Yan, please apply them
> into dev-test before applying Nanzhe's one, since it's dev-test, it won't
> cause any conflict w/ linux-next.
> 
> "f2fs: stop using PG_private"
> "f2fs: reject device aliasing without a multi-device configuration"
> 
> See https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=feature/large_folio

Per offline sync, they're going to go through MM tree. Please rebase on f2fs tree.

> 
> Thanks,
> 
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test
> > 
> > Note, I applied [0] and [1] already.
> > 
> > On 10/13, Nanzhe Zhao wrote:
> >> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> >>
> >> This series supports large folios for most readable/writable files
> >> in buffered I/O paths, including normal files, block-layer encrypted
> >> files, and atomic files except for inline-data files, compressed files,
> >> and quota files.
> >>
> >> It also extends f2fs_folio_state to coexist with f2fs page-private
> >> flags and to handle large folio write path and partial truncate of
> >> large folios correctly.
> >>
> >> Benchmark details can be found in the RFC v2 cover letter [1].
> >>
> >> Changes in v4:
> >> - Rebased onto linux-next next-20261012 (4eb2586bd40d); its f2fs part
> >>   is the f2fs dev branch.
> >> - Added "f2fs: read i_size once in f2fs_vm_page_mkwrite" as a
> >>   prerequisite (also sent separately).
> >> - "f2fs: remove mappedtodisk flag usage in mmap write path" is kept as
> >>   a prerequisite.
> >> - Link to v3: [2]
> >>
> >> Patches 1 and 2 are prerequisites for the large folio work. They are
> >> also posted independently as bug fixes, and are kept in this series to
> >> make it self-contained for the sashiko review.
> >>
> >> Many thanks to Chao and Daeho for your extensive reviews and valuable
> >> suggestions!
> >>
> >> [1] https://lore.kernel.org/r/20260622160830.324455-1-zhaonanzhe@xiaomi.com
> >> [2] https://lore.kernel.org/linux-f2fs-devel/20261009161224.4163796-1-zhaonanzhe@xiaomi.com/
> >>
> >> Nanzhe Zhao (18):
> >>   f2fs: read i_size once in f2fs_vm_page_mkwrite
> >>   f2fs: remove mappedtodisk flag usage in mmap write path
> >>   f2fs: extend folio state for large folio write path
> >>   f2fs: carry subpage offset and count in write IO
> >>   f2fs: support regular file buffered writes on large folios
> >>   f2fs: support atomic file large folios buffered write
> >>   f2fs: support large folio writeback
> >>   f2fs: account large folio dirty data at block granularity
> >>   f2fs: prepare mmap write faults for large folios
> >>   f2fs: make GC migration large-folio aware
> >>   f2fs: optimize small block size large folio read
> >>   f2fs: support partial uptodate large folio read
> >>   f2fs: handle partial truncate of large folio dirty subpages
> >>   f2fs: wait for folio writeback before ffs_detach_free
> >>   f2fs: fix zeroing paths for large folios
> >>   f2fs: handle block cloning within the same large folio
> >>   f2fs: allow large folio support to writeable files
> >>   f2fs: make compressed files compatible with large folio
> >>
> >>  Documentation/filesystems/f2fs.rst |   10 +
> >>  fs/f2fs/checkpoint.c               |   40 +-
> >>  fs/f2fs/compress.c                 |    7 +-
> >>  fs/f2fs/data.c                     | 1425 +++++++++++++++++++++++++---
> >>  fs/f2fs/dir.c                      |    2 +-
> >>  fs/f2fs/f2fs.h                     |  173 +++-
> >>  fs/f2fs/file.c                     |  252 +++--
> >>  fs/f2fs/gc.c                       |   38 +-
> >>  fs/f2fs/inline.c                   |    9 +-
> >>  fs/f2fs/inode.c                    |    4 +-
> >>  fs/f2fs/namei.c                    |    1 +
> >>  fs/f2fs/node.c                     |    2 +-
> >>  fs/f2fs/segment.c                  |    3 +-
> >>  13 files changed, 1706 insertions(+), 260 deletions(-)
> >>
> >> -- 
> >> 2.43.0
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
