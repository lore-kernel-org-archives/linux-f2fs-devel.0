Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7FCCD5BD0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 02:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKUOGmZWH9kVrPe1GxrgkCZJsXh/Fim1UlxcSUgSxxs=; b=JhQypYFGQ7eYxOwOSx1ZAyz4/2
	l0iMNZENo0hG8B7D5GU8UkmoqRRISSEnEvb7xc6vBLrDanW5+VMIEiI/sDpjOgrUR37wYkxjb8Mnh
	XAfz9DXNO8/NGNhWpaQYRdQVAnN14Q1bWB2O/XnmgiWqq3s8Q/siO7YXDqfM1TQJ4BKo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRhaD-0004Yi-JU;
	Tue, 26 May 2026 02:31:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wRhZk-0004YH-P4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 02:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7WoZ2cyGDEh4C+rPTk20iaEyGOoLnozfqobsmxrDxEA=; b=LCp+O1jYIBlAKcfkvcZIylKN7M
 CMiuWcEZXS8ChGuXBAv2lSvApugl2QopuANJPyEeNlK79jUOxj8ZJpKVViffCjmGbObE8d7lWI1iE
 iA2z0yXDwBmQBpMVAK2JGHcLPBNT/mhJBVUU7bQW4tawqzPaoQ3LVfF2O6DvPnSLqNH8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7WoZ2cyGDEh4C+rPTk20iaEyGOoLnozfqobsmxrDxEA=; b=egZUdzGKBbZxixLHGNCAwiH00b
 OWTLTiOit1mh7plO/tEsLju42D3vVxvf9cUFC2eo88n3OtSaV8CmdxTr191SsdKFhx1qHu+iZwTZN
 5dhjVNgzPS6JNVor2pgQ/i0NazvH/jW1uEnoiSGISWz7u5dMFyeiLb01I09oTpUJBEaQ=;
Received: from [90.155.50.34] (helo=casper.infradead.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRhZi-0003am-Fv for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 02:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7WoZ2cyGDEh4C+rPTk20iaEyGOoLnozfqobsmxrDxEA=; b=KBdxftb+8CA/+k7KI5B/ScG2FL
 8ZvUhLI8xh1fqvDOdwK7pqbj7GlR8B0Epltbqi/c8aHTTUdjjYvFO1IjvIz6lMv7ZuED+UYQINCDu
 0MQdSnPS1GR3HJoJKoEAqGsxqXAGvYPovq9sV775oqHUxcE3U2bvfpC0ji6vcJeZvD0XvkjpXLilN
 yhVAgOzUf2dBZiAXSZSqzgjzyS+G4b1UXYiJys28F80FUehltLcRfxN7xUwVwPlNY0BIkaFppmKjs
 dEiVT6To83P6+jogDRT/MRw47QYIngN/6Fvc2IfBzCc+jHJD8doYNZFYylfiMHC/js3Iu60jiFQX2
 aCNpCStg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wRhZU-00000000WP9-2Sjw;
 Tue, 26 May 2026 02:31:08 +0000
Date: Tue, 26 May 2026 03:31:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ahUF7HqSKFJ422bU@casper.infradead.org>
References: <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com> <ahPffhaOi2CBtWof@infradead.org>
 <ahT1nT3xsMGkyJab@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahT1nT3xsMGkyJab@google.com>
X-Headers-End: 1wRhZi-0003am-Fv
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

On Tue, May 26, 2026 at 01:21:33AM +0000, Jaegeuk Kim wrote:
> On 05/24, Christoph Hellwig wrote:
> > On Fri, May 22, 2026 at 02:04:59PM +0000, Jaegeuk Kim wrote:
> > > This was a quick buddyinfo right after booting the device.
> > > 
> > > Before:
> > > Node 0, zone   Normal  22684  42284  28704  16901   9515   4566   1854    673    181     36    758
> > > 
> > > After disabling EROFS large folio:
> > > Node 0, zone   Normal   8486   4732   2175   1161    697    272     82     19      3      1    856
> > 
> > And what are you trying to say us with that?
> 
> This means, high-order pages were used up by EROFS which sets large folio by
> default. So, I wanted to say the concern was based on actual data which was what
> Mattew asked.

This isn't that though.  What you actually need is to show that high order
allocations are _failing_.  The MM is far more complicated than you seem
to understand.  There isn't a fixed number of large folios available;
when we try to allocate memory, we do reclaim.  And if there's large
folios on the LRU list, you'll get them.

If what you want is large folios readily available, then what you want
is large folios used _everywhere_ because then they're easy to get!
If there's small folios in use, you need to reclaim a lot of memory in
order to reassemble large folios (it's the birthday paradox, similar to
the hash collision problem).


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
