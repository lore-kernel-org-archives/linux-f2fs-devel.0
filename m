Return-Path: <SRS0=Hk9E=45=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1609C10DCE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:39:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E64A20716;
	Thu, 12 Mar 2020 22:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="H7+aHBhN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hTy7HUZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E64A20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jCWUA-0005kR-KS; Thu, 12 Mar 2020 22:39:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1jCWU9-0005kE-JV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Mar 2020 22:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AHlozIV4YVz+yy8jCC0VJSqMnvdRCcAfkqaEhgrUmvI=; b=H7+aHBhNdKaBXg+Wcg3+cR3tPr
 YbThYH+Fd6//TUOYuixjV9zF0Br9sqHio2Ud87lWfUaHlPS/3mJMMHLvQBxl9Bf+YkDvyo+4bdBZ8
 l9PTXa6DNWNXjTpGkKt2BpucaRDHxVhwF9ZsIwIq5tfUnhsXXL5A3qdbXKMtKl3y2y5A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AHlozIV4YVz+yy8jCC0VJSqMnvdRCcAfkqaEhgrUmvI=; b=hTy7HUZfyyrU7U+tjsdsJeyydN
 XhJ4eLYEk7v/9aXwZ7cKKkTCf7rcTVCjpBMoyTNNY5p0VjTxcDzJqwHVejnTwye9gzRnpsvRJNnbn
 O9KkJjylIR+ndfJ4Ggd1mEItb4ZP1W1PBBOXk5rLjRfTSrZeBTV+xYWt+u1asQrhpFqA=;
Received: from mail105.syd.optusnet.com.au ([211.29.132.249])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtp (Exim 4.92.2)
 id 1jCWU6-009oF8-9j
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Mar 2020 22:39:25 +0000
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au
 [49.195.202.68])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5C5E13A451F;
 Fri, 13 Mar 2020 09:39:14 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1jCWTx-00050P-3Y; Fri, 13 Mar 2020 09:39:13 +1100
Date: Fri, 13 Mar 2020 09:39:13 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20200312223913.GL10776@dread.disaster.area>
References: <20200306004555.GB225345@gmail.com>
 <20200307020043.60118-1-tytso@mit.edu>
 <20200311032009.GC46757@gmail.com> <20200311125749.GA7159@mit.edu>
 <20200312000716.GY10737@dread.disaster.area>
 <20200312143445.GA19160@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200312143445.GA19160@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
 a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
 a=7-415B0cAAAA:8 a=Q8GS4823LYj-8jRK8AkA:9 a=CjuIK1q_8ugA:10
 a=biEYGPWJfzWAr4FL6Ov7:22
X-Headers-End: 1jCWU6-009oF8-9j
Subject: Re: [f2fs-dev] [PATCH] writeback: avoid double-writing the inode on
 a lazytime expiration
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
Cc: linux-xfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 12, 2020 at 07:34:45AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 12, 2020 at 11:07:17AM +1100, Dave Chinner wrote:
> > > That's true, but when the timestamps were originally modified,
> > > dirty_inode() will be called with flag == I_DIRTY_TIME, which will
> > > *not* be a no-op; which is to say, XFS will force the timestamps to be
> > > updated on disk when the timestamps are first dirtied, because it
> > > doesn't support I_DIRTY_TIME.
> > 
> > We log the initial timestamp change, and then ignore timestamp
> > updates until the dirty time expires and the inode is set
> > I_DIRTY_SYNC via __mark_inode_dirty_sync(). IOWs, on expiry, we have
> > time stamps that may be 24 hours out of date in memory, and they
> > still need to be flushed to the journal.
> > 
> > However, your change does not mark the inode dirtying on expiry
> > anymore, so...
> > 
> > > So I think we're fine.
> > 
> > ... we're not fine. This breaks XFS and any other filesystem that
> > relies on a I_DIRTY_SYNC notification to handle dirty time expiry
> > correctly.
> 
> I haven't seen the original mail this replies to,

The original problem was calling mark_inode_dirty_sync() on expiry
during inode writeback was causing the inode to be put back on the
dirty inode list and so ext4 was flushing it twice - once on expiry
and once 5 seconds later on the next background writeback pass.

This is a problem that XFS does not have because it does not
implement ->write_inode...

> but if we could
> get the lazytime expirty by some other means (e.g. an explicit
> callback), XFS could opt out of all the VFS inode tracking again,
> which would simplify a few things.

Yes, that would definitely make things simpler for XFS, and it would
also solve the problem that the generic lazytime expiry code has....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
