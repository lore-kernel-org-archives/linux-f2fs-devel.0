Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548FAC77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 May 2023 15:47:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ptVjq-0002LP-1I;
	Mon, 01 May 2023 15:46:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1ptVjg-0002LI-Tu
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 01 May 2023 15:46:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1MUFWRQzN2U7B9NovRPIUdnOItgaF2BM1nA/v8zJpK0=; b=M1yZGZBfSekIRmdjSDy3/ynSle
 lozXjloHhrf92V2ltPdInUL3wYktrXqRvwCwMW9GqPktgootB1POhK7w3QuK70udnULYbiAmZ2h0+
 oJMat4BYo1Znr2BD9+yjWFDGLLrF7773TdPaw/R/sIWYneFcF6p4q1GMJVYAdsbnw6qM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1MUFWRQzN2U7B9NovRPIUdnOItgaF2BM1nA/v8zJpK0=; b=UIDyl5FBGDhdgodp9xMvuy1/A9
 9S86e4d23NfzPqw+XFRINbyu0vEIETY64wWTjT7RZkCBE1OVG2tmhNgRMUqm5ohhElRtd7j6+qlsO
 l2dajuFjTTyyXOPx0uUfvRHST7x6sZmJ5LS1ML24piQtJrFQqlkNNYRw24rZlSSBvSSI=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ptVjf-0004Aw-Ae for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 01 May 2023 15:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1MUFWRQzN2U7B9NovRPIUdnOItgaF2BM1nA/v8zJpK0=; b=ZaYHCOGzMIq2mcPn5wQKmGHwqc
 dEaQSi8ys2wSEWQrqILZhJ2E3A5yM+ZBDgUmG4S1N/wj6Iqje0McnUMuERPO4Cm38WIS/MBxM3rwh
 I8qJ2kkdbPvv/cgRTjGc/qugwfraL2/bDWcH697S80ypbfipuIuTB4vHRmbpbSJ/0h1rlcZ0n6Oga
 f78qWjBf+nRjYL+b87AUjZ88xZZSzlYC+e+nEJYVSzyI3caXusPZt8MNxLpC34ZSXYjRTYEVBiqIH
 yHgXirJrykwoZHkRDNMuK1Q2zhGhTljIDoMOrmEL+wFzEVnpwKbugMpon2NXMzkmZMpdG/f7BkzP2
 DsjSuXIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ptVj9-007SZI-Oz; Mon, 01 May 2023 15:46:11 +0000
Date: Mon, 1 May 2023 16:46:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <ZE/ew1VpU/a1gqQP@casper.infradead.org>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-18-hch@lst.de>
 <ZExgzbBCbdC1y9Wk@bombadil.infradead.org>
 <ZExw0eW52lYj2R1m@casper.infradead.org>
 <ZE8ue9Mx6n2T0yn6@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZE8ue9Mx6n2T0yn6@bombadil.infradead.org>
X-Headers-End: 1ptVjf-0004Aw-Ae
Subject: Re: [f2fs-dev] [PATCH 17/17] fs: add CONFIG_BUFFER_HEAD
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 David Howells <dhowells@redhat.com>, cluster-devel@redhat.com,
 linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 "Darrick J. Wong" <djwong@kernel.org>, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Daniel Gomez <da.gomez@samsung.com>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Apr 30, 2023 at 08:14:03PM -0700, Luis Chamberlain wrote:
> On Sat, Apr 29, 2023 at 02:20:17AM +0100, Matthew Wilcox wrote:
> > > [   11.322212] Call Trace:
> > > [   11.323224]  <TASK>
> > > [   11.324146]  iomap_readpage_iter+0x96/0x300
> > > [   11.325694]  iomap_readahead+0x174/0x2d0
> > > [   11.327129]  read_pages+0x69/0x1f0
> > > [   11.329751]  page_cache_ra_unbounded+0x187/0x1d0
> > 
> > ... that shouldn't be possible.  read_pages() allocates pages, puts them
> > in the page cache and tells the filesystem to fill them in.
> > 
> > In your patches, did you call mapping_set_large_folios() anywhere?
> 
> No but the only place to add that would be in the block cache. Adding
> that alone to the block cache doesn't fix the issue. The below patch
> however does get us by.

That's "working around the error", not fixing it ... probably the same
root cause as your other errors; at least I'm not diving into them until
the obvious one is fixed.

> >From my readings it does't seem like readahead_folio() should always
> return non-NULL, and also I couldn't easily verify the math is right.

readahead_folio() always returns non-NULL.  That's guaranteed by how
page_cache_ra_unbounded() and page_cache_ra_order() work.  It allocates
folios, until it can't (already-present folio, ENOMEM, EOF, max batch
size) and then calls the filesystem to make those folios uptodate,
telling it how many folios it put in the page cache, where they start.

Hm.  The fact that it's coming from page_cache_ra_unbounded() makes
me wonder if you updated this line:

                folio = filemap_alloc_folio(gfp_mask, 0);

without updating this line:

                ractl->_nr_pages++;

This is actually number of pages, not number of folios, so needs to be
		ractl->_nr_pages += 1 << order;

various other parts of page_cache_ra_unbounded() need to be examined
carefully for assumptions of order-0; it's never been used for that
before.  all the large folio work has concentrated on
page_cache_ra_order()


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
