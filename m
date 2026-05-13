Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD37CD4F24
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2026 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uuzOG3wmMVe5bMcikLwyYPbOqq9ZuREKUY0aZ9tF3mc=; b=HD1O19tFT+UxgaDS3bJDy/i5Sw
	HbJCF2sAlhNwOob0ENGCfg/1Rtj5uE1HasFSu8KKzGcLXw/G6AuPkwl0p5akFQehWuKGuEfD+OdFt
	Q/BWi7noN6OBSx/10GQhg6N03zr+yUnAgUBcHRNn88MXxh6dCtPDov6BTQ5SNNhzXxNc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wNB3b-0002v3-CI;
	Wed, 13 May 2026 14:59:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wNB3Z-0002uu-ND
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 14:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7C1ah9JccRCi6ntT71qsUZVG/Z79mw1kuhsp9RZIJi0=; b=IJfR+nguUZdmp6EnWs82pjEM0M
 HPWIYxpJ1lmd+dxcMJn7CqAdlblcoyVX/WNK6BaiYS5Ie3RE0zB3y+9q/lr6blrDmYfRlDG/YqE5t
 eZC2uZ7ORZYgKj7jg5aVMDrLCWJ2trzXrixhhiO0pguMbvOX0DEMrdlm3r9YuAo4sJgY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7C1ah9JccRCi6ntT71qsUZVG/Z79mw1kuhsp9RZIJi0=; b=JnMfqTNOK0tT4N+hAIHV1C4rBv
 7/3iE2nZm9EA1rtk9PWlwm66zOhz/XBQlg23iO/CP/NdvMHbFweyaAGoaojojT4OXQMAKkgocOBIc
 OyWtVfG+kAQgT4nNXw6BVa6T0EjFknh00X9UHjSErR2prrETymRPQrnPZEXvYcG2xR0M=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNB3V-00064V-5g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 14:59:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 57C5F44179;
 Wed, 13 May 2026 14:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D47CC2BCB3;
 Wed, 13 May 2026 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778684360;
 bh=zbNHyyDRYAeGo6U86F5ea4LHa32zJh59lyteWOe4KGw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iIhYEKx51XcVXCXizSytP4ZvhZtiBJmIPf+6O8Mktq3AJeEzUzkfq9zJFMxWWOQN/
 aoWFZ5To1myUEqEdw7VallkySu/iGPAldgKZg0gl6xnLSnuloIhSu3lBTLqysfs1I0
 Skg4f9BktAuE18yvvQRJ70VrpwY5SAV36hi26w0P9GMsQkbf7JD+SNU9HxSde3AnHu
 bo3a4ZV9/09phwV+AioQvcuqmfuB2eTSN/4uxVBmpiaTeWdd95EFcAzHk3DTbz/8je
 v+mVMmUJ6OM8tMNlaOTQXwFxTd7uJskcOql+wcSZWQ2REyC0QM0b5EqoBwpRfC7ETk
 FtuJsAzYKU1jA==
Date: Wed, 13 May 2026 07:59:19 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260513145919.GP9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-9-hch@lst.de>
 <20260512170204.GI9555@frogsfrogsfrogs>
 <20260513065608.GA2250@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260513065608.GA2250@lst.de>
X-Headers-End: 1wNB3V-00064V-5g
Subject: Re: [f2fs-dev] [PATCH 08/12] swap,
 iomap: simplify iomap_swapfile_iter
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 linux-mm@kvack.org, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Chris Li <chrisl@kernel.org>,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Kairui Song <kasong@tencent.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-cifs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-btrfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 13, 2026 at 08:56:08AM +0200, Christoph Hellwig wrote:
> On Tue, May 12, 2026 at 10:02:04AM -0700, Darrick J. Wong wrote:
> > OH.  Now I remember why -- it's to handle contiguous mixed mappings
> > better.
> > 
> > Let's say that you have a 1k fsblock filesystem and 4k base pages.  You
> > fallocate an 8G swap file and then mkswap it.  The first mapping is a 1k
> > written mapping at offset 0 for the swap header, followed by an 8388607k
> > unwritten mapping at offset 3k.
> > 
> > The PAGE_SIZE rounding code in iomap_swapfile_add_extent will round the
> > end of that first mapping down to zero and ignore it.  The second
> > mapping will be treated as if it were a 8388604k mapping starting at
> > offset 4096.  Now the page counts are wrong and the swapon fails.
> 
> Do we care about this use case?  I guess you did as you implemented
> his, but still?

We do, because mkswap -F uses fallocate nowadays:

$ mkswap -s 4194304 -F a
Setting up swapspace version 1, size = 4 MiB (4190208 bytes)
no label, UUID=bc9746bf-e200-4944-927c-80d83872f1cb
$ filefrag -v a
Filesystem type is: 58465342
File size of a is 4194304 (1024 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:  411383552.. 411383552:      1:            
   1:        1..    1023:  411383553.. 411384575:   1023:             last,unwritten,eof
a: 1 extent found

> > A more generic solution to this would be to change add_swap_extent to
> > take sector_t addr and length values and use them to construct a bitmap
> > representing contiguous physical space on the bdev, accounting of course
> > for PAGE_SIZE alignment.  Except for the swap header page, every other
> > contiguously set page-aligned region in the bitmap gets added to the
> > swap extent map.
> 
> You don't even need a bitmap, just do basically the same checks as
> the iomap code when moving to a new swap extent after moving to use
> the sector_t.  And it really should anyway, as the current abuse of
> sector_t to store a disk offset in PAGE_SIZE units is pretty gross.

Oh, I meant this to handle the particularly gross case where the fsblock
size is smaller than a base page, but there are a very large number of
file mappings that point to a physically contiguous extent but are not
in logical order:

{.offset=0, .length=1k, .addr=7},
{.offset=1, .length=1k, .addr=6},
{.offset=2, .length=1k, .addr=5},
{.offset=3, .length=1k, .addr=4},
{.offset=4, .length=1k, .addr=3},
{.offset=5, .length=1k, .addr=2},
{.offset=6, .length=1k, .addr=1},
{.offset=7, .length=1k, .addr=0},

That's two pages of swapfile, but with the current layout accumulation
code we "cannot" find either.

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
