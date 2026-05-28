Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6613CD5BD5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 May 2026 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GuNiHPsRUgdfUw5UHBTSEAjSV52e2hKJhwoRx561fIY=; b=WAOJbiF7Ge2GiJmVw15WrtXUCn
	NjP9tcca+4SCkykFJGlGnRQAZJ2F5Jg1LU076lLs/CoRPglObd+C6eNmElWqiN4t7irgNOJFpmuNc
	9qJvG54ztDYFpEXlubGI+4M8kdVI+QXAz/LDsss2BcX411Qox2jUCuhZyDu5PQvF50uw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSgXY-00050d-AA;
	Thu, 28 May 2026 19:37:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wSgXE-000506-NZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 19:36:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8F0pWvXpBQ9tDTtRSJ6URm6g4dHDcnjjGX6VQLGXPyU=; b=EcOfV8JEla0Xv5yzdS9rU90ZuT
 zuCKAf01+RFT4qA2J7cQ2rLdu7OSkHa+EeKMJ9gNgDSTIidM8caOVBCqRCqcMgVE7vrDaO+vOtGXD
 R9/jeO0ygLp/2AaOKuzsCpZEzPpDjDs9aah3lfwzHa2t4i8tpsSG4fi0swZ4KpVDUFtw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8F0pWvXpBQ9tDTtRSJ6URm6g4dHDcnjjGX6VQLGXPyU=; b=GWyFqyXIeInsE8/2KsV8V0asF+
 B+xywONBK3aibncXhUCPJXHbRlQsGgw155fIgrGa8M+PnlevJ1i85+/a2YBF7ZgTuBwqdPFGAX/g1
 QkRP59FG+FWyABm5+wStw5cBsn0CeWYcZwgnsz/xH584aeFFocBkkUEwSXFig9JB6dPY=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSgXE-0004YK-67 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 19:36:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8F0pWvXpBQ9tDTtRSJ6URm6g4dHDcnjjGX6VQLGXPyU=; b=JRYMFMMUmIt+Ltyl9sQbvX97s0
 VD5j57l9FIq6bZcWQ1EA8YYtzEb8jUOSu/8fH/b3sQlj1QaB0x44GaBPtu54kC9Av3dPePcxl3D4A
 43FDUmdVszYklFreqEVlN0De8B1nujQTrH5y2ar8ZqhIAvN2glKhvMyMprIAhMZARkir6P/qjsSzQ
 kaolzBR1PT40+KzPSjEVD/X9dbuyi+JafqY19ukDe1QGkC4hrzlV9jG3iwc5T+1dn+z853w+1JN+o
 /5pkqxjkyy7sTDODIoKT/ekB1z/gUnyq3u1QWM2ZulCTjl3jenUMU9GTVLV/xfn5shjyAsEQBBx4l
 iwYCMWxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wSgX0-00000004mIh-1Q3T;
 Thu, 28 May 2026 19:36:38 +0000
Date: Thu, 28 May 2026 20:36:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ahiZRpE593n4blxn@casper.infradead.org>
References: <ad30g9xMs9wNJhFb@infradead.org> <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahTzHyHBL8t0iNBR@google.com>
X-Headers-End: 1wSgXE-0004YK-67
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
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 26, 2026 at 01:10:55AM +0000, Jaegeuk Kim wrote:
> Background
> ----------
> The primary use case is accelerating AI model loading, which demands
> exceptionally high sequential read speeds. In our benchmarks on embedded
> systems:
>  - Using high-order page allocations allows the system to saturate the
>    Universal Flash Storage (UFS) bandwidth, reaching 4 GB/s even at
>    medium-to-low CPU frequencies.
>  - In contrast, standard small folios cap performance at 2 GB/s.
> 
> The performance doubling stems directly from reducing CPU cycle overhead during
> memory allocation.

When you say "AI model loading", are you mmap()ing the file of weights,
or are you calling read() to load the file into anonymous memory?

This matters because for the first operation, you need to allocate folios
of PMD size in order to make best use of TLB entries.  For the second
operation, it's more important to iterate through the file quickly,
freeing folios behind you after you access them so they're available
for the next batch.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
