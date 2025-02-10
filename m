Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4F3C02198
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:20:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1thXSQ-0003i9-9I;
	Mon, 10 Feb 2025 17:20:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1thXSO-0003i1-CO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 17:20:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pklYGgzM6xnfX5CyE/d340+EA7VudroV6w5u0YV+5jk=; b=ABwk/c1Y0RW8NhA8fmutYLjBwL
 DsuMX2r9cLA1i/xVxbSje+YBjzkev6x/15rH7Wmj0RJ+13JODMdUztPes3mKo1TehSVgz2UvjwKwa
 JekAuPKBs+yp5zB15BTbT8n0TTfv/nOqvTRWfU39k4cA5au/bJ489hMlosDAPRged2h8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pklYGgzM6xnfX5CyE/d340+EA7VudroV6w5u0YV+5jk=; b=ATYK3TVIqvlhTZHZTbUporF8z+
 RDQWULdpPE361SpaNB6uuWFD5WpDri/vBwLTGe8SCV+hErAgoVQRmSmhNb5Kusf6gZG1JiOleeOXi
 pXWM+jcRBUA4dpaGLJL8egsqpyqwNmYcliAor3wT+km3pLEjQGxQzD4kPpIKZvdROD7w=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1thXSN-0004kn-71 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 17:20:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=pklYGgzM6xnfX5CyE/d340+EA7VudroV6w5u0YV+5jk=; b=TV/IkCyS8FG7w8lnDCKRHnBTg5
 sZpJxCbY/q96exXJhUmIHL4RS1tiwKMIypxRT/uioC3OGrL+XYcyb76DkCDSRiBMrlGhZjZfEtFni
 d/fywoBGGYZneRBF7HOIVkp5DAmWikdoc3LQUW8xT5Jimm6ZRrmcTj6X2Cc8mYi2vmsQmggW5AfA4
 f2iqX6SH47GRcMc2TO+xXeeIjVq4H86cHHvPVtAHYQODuezfzHbfT0Oo2GxwQ7EGEZifhFyN0Z4EI
 wfJ7MzmtYiQriocPX3FDSUULfeMKH3Juh4WH+qqRm2A/2lVTaY08t65WKzFUn0UVFhJP0rmTWAWQU
 ZFDK2R8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1thXS9-0000000GL8w-3XD9; Mon, 10 Feb 2025 17:20:13 +0000
Date: Mon, 10 Feb 2025 17:20:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <Z6o1TcS7mQ2POrc9@casper.infradead.org>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
 <Z4qmF2n2pzuHqad_@google.com>
 <Z4qpurL9YeCHk5v2@casper.infradead.org>
 <Z4q_cd5qNRjqSG8i@google.com> <Z6JAcsAOCCWp-y66@google.com>
 <Z6owv7koMsTWH1uM@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z6owv7koMsTWH1uM@google.com>
X-Headers-End: 1thXSN-0004kn-71
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Feb 10, 2025 at 05:00:47PM +0000, Jaegeuk Kim wrote:
> On 02/04, Jaegeuk Kim wrote:
> > On 01/17, Jaegeuk Kim wrote:
> > > On 01/17, Matthew Wilcox wrote:
> > > > On Fri, Jan 17, 2025 at 06:48:55PM +0000, Jaegeuk Kim wrote:
> > > > > > I don't understand how this is different from MADV_COLD.  Please
> > > > > > explain.
> > > > > 
> > > > > MADV_COLD is a vma range, while this is a file range. So, it's more close to
> > > > > fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
> > > > > at the time when it's called. The idea is to keep the hints only, and try to
> > > > > reclaim all later when admin expects system memory pressure soon.
> > > > 
> > > > So you're saying you want POSIX_FADV_COLD?
> > > 
> > > Yeah, the intention looks similar like marking it cold and paging out later.
> > 
> > Kindly ping, for the feedback on the direction. If there's demand for something
> > generalized api, I'm happy to explore.
> 
> If there's no objection, let me push the change in f2fs and keep an eye on
> who more will need this in general.

I don't know why you're asking for direction.  I gave my direction: use
fadvise().

Putting this directly in f2fs is a horrible idea.  NAK.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
