Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDAAC02198
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:01:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1thZ2I-0005tN-Aw;
	Mon, 10 Feb 2025 19:01:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1thZ2G-0005tH-Ep
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 19:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AKYEWQkutyIx8NgecPuM++CglayPvtajn7pqFgn/xE8=; b=YfLKTW9FBz7KYM1319krQDIgKj
 Y+E9SYSK90dI93PqPxShSpku3X3CBpk+MvF+vvm1PwF1ZP2zJMo9llthNkr/Z5WsR9PGDj/PlvNK/
 6QxBAlTBsLPlhpFhDoynKfXJWP5GIZIjPF0XNOf1dyE8kKUoPSx00CDFEu1qkiKPNaB8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AKYEWQkutyIx8NgecPuM++CglayPvtajn7pqFgn/xE8=; b=kQtAnZbulsRYWkZh2/33/7iB4J
 iIjeFl3uoDamWrlcku6AnYDYnbOtMiIEjGFsLzeMEIgIcbYukuqlSEM2pAGVQ31RQkbX4zZ8LPGYe
 iBU2lyC2FNp1/L71/00rnio8fQhD4SqHYZOK2nW96jP7XIEyMuGTHgAe0MO9v+kphgfk=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1thZ2F-0004D3-Q3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 19:01:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 711E4A42015;
 Mon, 10 Feb 2025 18:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D728C4CED1;
 Mon, 10 Feb 2025 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739214089;
 bh=23KDcD/j65oGW6866Bcw3xXNXwhUPxAoV5GMn7mD+Lo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mZy0IsbLOkV6NzapTbhUN5/hH4zrpbKZKs9GHER1Rnl03HauXaru5+sCjkghd0wMJ
 nisdNuznkuonBfuOF1kGrMXWXOVf3B2h408VTpwbFS67u8A/Sy4rbFUkTAEqTUIAj5
 3kiRYEdG0xTLFRdJutjzMU2uxJiea7jxXaMwLSydaFwEC23dmdhgwHvQYrgV7Xhbjt
 fbSQhW08E7QnQKPKzhhvZqYCjgw9t/7Za1T1rej3ZNOcRrKZPJEyI8LhJAsMB0RsVK
 326tWbIwSqPX1jfWWMKLZYMSk5hWLaLI6iWFMkSw2tx/34YQqZJZDBAs/yVfTeUj2q
 DcBo625c+YT2Q==
Date: Mon, 10 Feb 2025 19:01:27 +0000
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <Z6pNBxgMKHTiHAnv@google.com>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
 <Z4qmF2n2pzuHqad_@google.com>
 <Z4qpurL9YeCHk5v2@casper.infradead.org>
 <Z4q_cd5qNRjqSG8i@google.com> <Z6JAcsAOCCWp-y66@google.com>
 <Z6owv7koMsTWH1uM@google.com>
 <Z6o1TcS7mQ2POrc9@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z6o1TcS7mQ2POrc9@casper.infradead.org>
X-Headers-End: 1thZ2F-0004D3-Q3
Subject: Re: [f2fs-dev] [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed
 pages
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 02/10, Matthew Wilcox wrote:
> On Mon, Feb 10, 2025 at 05:00:47PM +0000, Jaegeuk Kim wrote:
> > On 02/04, Jaegeuk Kim wrote:
> > > On 01/17, Jaegeuk Kim wrote:
> > > > On 01/17, Matthew Wilcox wrote:
> > > > > On Fri, Jan 17, 2025 at 06:48:55PM +0000, Jaegeuk Kim wrote:
> > > > > > > I don't understand how this is different from MADV_COLD.  Please
> > > > > > > explain.
> > > > > > 
> > > > > > MADV_COLD is a vma range, while this is a file range. So, it's more close to
> > > > > > fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
> > > > > > at the time when it's called. The idea is to keep the hints only, and try to
> > > > > > reclaim all later when admin expects system memory pressure soon.
> > > > > 
> > > > > So you're saying you want POSIX_FADV_COLD?
> > > > 
> > > > Yeah, the intention looks similar like marking it cold and paging out later.
> > > 
> > > Kindly ping, for the feedback on the direction. If there's demand for something
> > > generalized api, I'm happy to explore.
> > 
> > If there's no objection, let me push the change in f2fs and keep an eye on
> > who more will need this in general.
> 
> I don't know why you're asking for direction.  I gave my direction: use
> fadvise().

Funny, that single question didn't mean like this at all. Will take a look
how the patch looks like.

> 
> Putting this directly in f2fs is a horrible idea.  NAK.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
