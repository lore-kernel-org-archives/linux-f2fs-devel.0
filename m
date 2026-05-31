Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B014BCD4F54
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 31 May 2026 00:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dl0YYp4w441i+ZoxKgukVKr3nYUReNIvZrBbSvQS0aM=; b=GA4hudaspH9BA+JTUTGkCfMNtg
	OAeeb4DN+tpsUF/WM9rwk7SJLoNgIIZok6+rjzt0fagPhiNvDW5uu2ZBYbKfTSXXi0kS6vYNKq9st
	4ZEnKUy2naoGOahN8PTynn4AveNVT8+RPNkcw5FFBVpEPmTFj35rkvZSBqxJRUiWVx1k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wTU9h-0000rm-QQ;
	Sun, 31 May 2026 00:35:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wTU9X-0000rY-Jj
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 31 May 2026 00:35:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c8RBaPvCP6ZMekNwxeunAIbpIE5CulD2vhb0civMEuc=; b=aYrI6m+qVujpNGykR8ztM3F/HA
 eG3V7ekMZYFKAKcHXPAVtFJKHpz6iHNkazntwY5x8wABimvxXgolwNILWJa+b5UVKDdqxHyZwYSiC
 Zvpkefx8jtOb5QKmZCRPfAJvr32rEu1nye5UVPkyVw9NBqnOcBzTZCfHxmqFsnlfDmGY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c8RBaPvCP6ZMekNwxeunAIbpIE5CulD2vhb0civMEuc=; b=YFupoQckyPwRRH1IpGIDMKQE5b
 ae1cLct0++eknL29HqED0P5CRcjnhuqfdi8Is4KfkWEjIXsGmS0aGsX1AzhapAqpLoyBGV8enXHA1
 4p2ywyizel1Jn4ZgXXg6MfHcLIjjtezDuqlddolcgXgx7uC3ZzClimkwpS4Kz0OhzX90=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wTU9T-0007hG-UF for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 31 May 2026 00:35:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD8356001A;
 Sun, 31 May 2026 00:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0179E1F00893;
 Sun, 31 May 2026 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780187729;
 bh=c8RBaPvCP6ZMekNwxeunAIbpIE5CulD2vhb0civMEuc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=d53H0TLHSiX4+p2qwlrpbYNSkQr89x9B3WOu78Q9gI0I8WEUkK4/F0Zh3HERksKXa
 hg3haxL1FnZcxondubwZwSNMfqkYHFUlb1pVtumAOLYPxzg9iYQ0pDorDrMaBgKOD/
 19SMFIXoJdy9v1FI3zZfF9v/cgA9sSj7H7cQk2XdS8zrPotiR+MuiE0Uv2MC7VN0Oj
 D9qPYvBnffngDkemA2x1OvI+zzU9n1afjMGdGZN9X7wZzeaN3mSqLcp9+AZOQIZICx
 RomPOo2yIKZt95Ctpt1mPpJrInk8xy5K7p3NidJmIZRd+riM76W06RmR+UlHx97mfR
 4qsbhgJyW6jMA==
Date: Sun, 31 May 2026 00:35:27 +0000
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <ahuCTzdbvhCBJzcl@google.com>
References: <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ahiZRpE593n4blxn@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahiZRpE593n4blxn@casper.infradead.org>
X-Headers-End: 1wTU9T-0007hG-UF
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/28, Matthew Wilcox wrote:
> On Tue, May 26, 2026 at 01:10:55AM +0000, Jaegeuk Kim wrote:
> > Background
> > ----------
> > The primary use case is accelerating AI model loading, which demands
> > exceptionally high sequential read speeds. In our benchmarks on embedded
> > systems:
> >  - Using high-order page allocations allows the system to saturate the
> >    Universal Flash Storage (UFS) bandwidth, reaching 4 GB/s even at
> >    medium-to-low CPU frequencies.
> >  - In contrast, standard small folios cap performance at 2 GB/s.
> > 
> > The performance doubling stems directly from reducing CPU cycle overhead during
> > memory allocation.
> 
> When you say "AI model loading", are you mmap()ing the file of weights,
> or are you calling read() to load the file into anonymous memory?
> 
> This matters because for the first operation, you need to allocate folios
> of PMD size in order to make best use of TLB entries.  For the second
> operation, it's more important to iterate through the file quickly,
> freeing folios behind you after you access them so they're available
> for the next batch.

We deal with multiple options tho, what I'm looking at is mostly a preloading
models by mmap(MAP_POPULATE) which takes the readahead path bumping up the order
by 2. Previously I also looked at fadvise(WILLNEED), but gave up due to the
broken interface. OTOH, we use RWF_DONTCACHE for read() case, but I don't
think it's ideal for the best loading performance.

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
