Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DEBC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Nov 2022 15:18:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p0OrP-0002yB-SQ;
	Wed, 30 Nov 2022 15:18:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1p0OrN-0002y4-4p
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Nov 2022 15:18:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N9HXBBW7P/KvVNawmxP/5nCywoMe+jH+9tdbHKm2yx4=; b=GhrBw/Br5lwf5ymTFsfq1qJGgx
 mgGzRgCa5qn4nnVNnHC0m792Pim5UeAl592aCgO200Jc1eHCd4wPjKKMQyWf1aN6Hq5QvvAikFWA/
 dn7vou2v6b0mWlzC40Pg8EyklwYMB7NP/DOGzvIr44ypzpYUlFP5pBQYrYjBk+IDojSU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N9HXBBW7P/KvVNawmxP/5nCywoMe+jH+9tdbHKm2yx4=; b=NhZpC7ICaIn64mons3T5J1beDt
 KbBquK5+HKVYiDBQ7MNBfWwGNMHIC4ZpMJN+uyVV5lETWaoR3RlIAjh0/bIzyPaLzI1LwxhcnUbiQ
 zaHEnOK3RxLUB0e/4kzKljX9C/MVrQzWi6GHThjMlkWjxEclvox8HBnQglGjHLTQi4kA=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p0OrL-001W8f-10 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Nov 2022 15:18:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=N9HXBBW7P/KvVNawmxP/5nCywoMe+jH+9tdbHKm2yx4=; b=lQ1WyiKRrQeHAg4aAhQC4Jx+kF
 RcVZQAoZ2Reaiz5xHiiSxbFcwo041E6tsoUwVaGybmugem8+4hWo4WFjyOX3jFA2HYI7lvXcHKn+6
 h7mmjbxsORZKqCW5OipGo8f/FbZrXYnf/RWm9p8tkML3rwfEiVigFzsrNmSJJQ1twbm2qSDMcttHa
 mDNQgjabRUZkO5EOzzr04YbceD+HjlJSuBFmtrVhLUJba1383ukKb7CKz07LEPOl33OB5gbk05iRz
 EEgraQ++6paX17JPyMs1AiM5aJncrYPcaaPXhlH2OX25db/LYTfnvbHkFmJmGfqPlqbwVDHxbxBnH
 o/9lgL9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1p0OrC-00F5XG-0W; Wed, 30 Nov 2022 15:18:42 +0000
Date: Wed, 30 Nov 2022 15:18:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <Y4d0UReDb+EmUJOz@casper.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
 <20221130124804.79845-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221130124804.79845-1-frank.li@vivo.com>
X-Headers-End: 1p0OrL-001W8f-10
Subject: Re: [f2fs-dev] [PATCH] f2fs: Support enhanced hot/cold data
 separation for f2fs
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 vishal.moola@gmail.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Nov 30, 2022 at 08:48:04PM +0800, Yangtao Li wrote:
> Hi,
> 
> > Thanks for reviewing this.  I think the real solution to this is
> > that f2fs should be using large folios.  That way, the page cache
> > will keep track of dirtiness on a per-folio basis, and if your folios
> > are at least as large as your cluster size, you won't need to do the
> > f2fs_prepare_compress_overwrite() dance.  And you'll get at least fifteen
> > dirty folios per call instead of fifteen dirty pages, so your costs will
> > be much lower.
> >
> > Is anyone interested in doing the work to convert f2fs to support
> > large folios?  I can help, or you can look at the work done for XFS,
> > AFS and a few other filesystems.
> 
> Seems like an interesting job. Not sure if I can be of any help.
> What needs to be done currently to support large folio?
> 
> Are there any roadmaps and reference documents.

From a filesystem point of view, you need to ensure that you handle folios
larger than PAGE_SIZE correctly.  The easiest way is to spread the use
of folios throughout the filesystem.  For example, today the first thing
we do in f2fs_read_data_folio() is convert the folio back into a page.
That works because f2fs hasn't told the kernel that it supports large
folios, so the VFS won't create large folios for it.

It's a lot of subtle things.  Here's an obvious one:
                        zero_user_segment(page, 0, PAGE_SIZE);
There's a folio equivalent that will zero an entire folio.

But then there is code which assumes the number of blocks per page (maybe
not in f2fs?) and so on.  Every filesystem will have its own challenges.

One way to approach this is to just enable large folios (see commit
6795801366da or 8549a26308f9) and see what breaks when you run xfstests
over it.  Probably quite a lot!



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
