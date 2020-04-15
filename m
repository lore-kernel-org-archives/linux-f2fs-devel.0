Return-Path: <SRS0=cknU=57=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA14C3815B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:22:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93D920575;
	Wed, 15 Apr 2020 11:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GHICeHF8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Y3u9mdLU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ClQLKHw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93D920575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jOg7o-0000hY-T4; Wed, 15 Apr 2020 11:22:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1jOg7n-0000hI-T4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Apr 2020 11:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p5k96MLyrJ0Kc/9UM6Xw8FfLDEnTX/dVH39aK5qAXAA=; b=GHICeHF8a6vCDoIuAK+LK9wyjH
 OJZo7t5tNWJh7hCTdB0ii9skpofvrz9p4WWe74Jyxt2mAPzUhlVtMkdaULUmfSVdUCJlhP6Z4eBRL
 PtsDNFL5FLBRUXrR6m4oC9RXSw+uVlp9Vm+x5xi4flVMfT2Op0V2tMu91tiTEhprSF+w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p5k96MLyrJ0Kc/9UM6Xw8FfLDEnTX/dVH39aK5qAXAA=; b=Y3u9mdLU/sc+Hp+eSX2pKsQDuV
 QT3ZPfIATsbw840M1lCKW+Ubtv6F7o/ixBTeIyxxGk8oamBd2G0vFkjTGuEeCXdu69hkK4rrjAaHi
 CMRgc0VPQNrxPRNCOEbs9aGyuMlExrNo4B3avgkYLcNcHQxC9ZzfwcfXxpeifqooE3v0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jOg7j-000CkL-Dr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Apr 2020 11:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=p5k96MLyrJ0Kc/9UM6Xw8FfLDEnTX/dVH39aK5qAXAA=; b=ClQLKHw92puBJhU2nimC3BH8wA
 355osRMfVxhDQVssm7Zm9jE6v3E3dRGs+Oc5jFRy3/jQbyNAsfVORzBRmGEfW7/HIf4gbDH2d4DT2
 gL3rNu+X2XBNBJ3NpW/Bx0FlYJMdgdadGJM/y2cHwCtDUUl9b+KcgcTHyz2DkqV52KYqOQaeHmfVH
 s2D+J2WiHScmuPaZ+HVg8gSTWAFyV0P0cKjdmyQFi/TapX8CRjBU8aFB/npLmiZAvjPQMvj6Rpgij
 Vy0bfVHN0vosqBiQDXjyzG7mDrHdrpJGmw7wYW8mNvb2TBTAiSuOkc9Tu/G2eouAmkldMad/NLN38
 jgC7ixKA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jOg7U-0004jU-L2; Wed, 15 Apr 2020 11:22:16 +0000
Date: Wed, 15 Apr 2020 04:22:16 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20200415112216.GC5820@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-6-willy@infradead.org>
 <20200414181705.bfc4c0087092051a9475141e@linux-foundation.org>
 <20200415021808.GA5820@bombadil.infradead.org>
 <20200414215616.f665d12f8549f52606784d1e@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200414215616.f665d12f8549f52606784d1e@linux-foundation.org>
X-Headers-End: 1jOg7j-000CkL-Dr
Subject: Re: [f2fs-dev] [PATCH v11 05/25] mm: Add new readahead_control API
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
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 14, 2020 at 09:56:16PM -0700, Andrew Morton wrote:
> On Tue, 14 Apr 2020 19:18:08 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > Hmm.  They don't seem that big to me.
> 
> They're really big!

v5.7-rc1:	11636	    636	    224	  12496	   30d0	fs/iomap/buffered-io.o
readahead_v11:	11528	    636	    224	  12388	   3064	fs/iomap/buffered-io.o

> > __readahead_batch is much bigger, but it's only used by btrfs and fuse,
> > and it seemed unfair to make everybody pay the cost for a function only
> > used by two filesystems.
> 
> Do we expect more filesystems to use these in the future?

I'm honestly not sure.  I think it'd be nice to be able to fill a bvec
from the page cache directly, but I haven't tried to write that function
yet.  If so, then it'd be appropriate to move that functionality into
the core.

> > > The code adds quite a few (inlined!) VM_BUG_ONs.  Can we plan to remove
> > > them at some stage?  Such as, before Linus shouts at us :)
> > 
> > I'd be happy to remove them.  Various reviewers said things like "are you
> > sure this can't happen?"
> 
> Yeah, these things tend to live for ever.  Please add a todo to remove
> them after the code has matured?

Sure!  I'm touching this code some more in the large pages patch set, so
I can get rid of it there.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
