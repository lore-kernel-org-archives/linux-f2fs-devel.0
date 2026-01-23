Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0E5D72341
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TsF63yKmyd4LNxy5JczfZE7tYoKmih6DrjcIPR/T6eE=; b=KTUZEdbLlHB9lFIie+5DRpCWzy
	sLYdMFr5VJKlTITK01jqDJoF9++oNDeBxuQPqDXZZazDjOq9sDTC4me6iGN/1uIlZABYiPn56yQYj
	NDE2ExXRQOwqD6Hg8LKKmKKEIJf7qzwGq/JAqf+Ro2uqvCPgzWTeabZBbq35DPAmF4fk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjBXw-0005Ot-Vx;
	Fri, 23 Jan 2026 07:25:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1vjBXv-0005Ol-Eu
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 07:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VpqyAXgB+8m1PJhjQtDY+p+DIrZeXlPwfZPw7MBh6dc=; b=bcg3YVWDz/E14WDK4HqK9JajAw
 kqQiyWr51hLjVyN/grDI/e+YkxrmDm5sQvIsUYQd1KZJ4jVyC1OIZPzJqrot3BLtZREQHtW2edtA6
 MHEtllHKBWHyo18BFjZ2/VrB5Njw9wJisD+z7diccS0BBD3c0sENbCkrcrVt+yfMk36w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VpqyAXgB+8m1PJhjQtDY+p+DIrZeXlPwfZPw7MBh6dc=; b=ClXqpq/KiZmDTHmmd38KrOzH7z
 D1hkxTX9+Ok1563HMShkZ+RAeuqc8KfqKAgA8oQVrxeHaNtieRkr/Fm9gTlOEzDqYzsA3lLuCGGk+
 DN1yMZP5eerFycn3H+AXrDT6dLoHOR75XBHZm4KP5Z+jYvqygLCOXO2pZnUhDkxsKjT8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vjBXv-0003Ax-30 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 07:25:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B58F640312;
 Fri, 23 Jan 2026 07:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3EDC4CEF1;
 Fri, 23 Jan 2026 07:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769153120;
 bh=2iQj3NVwRa1h1Br3tJlYAFXoIJ/SDM7T0y4t89MLmxI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CanYp7RLVaLj52wNbtaMcyixECOzLmRczYmz6Pz3O4m44GBUI80gmjY3F1RJjJbC8
 xXIOT2/4gnzvIa0z3JoRZ6TMyRICwWGQMGQnIrl5vlAspDwIv7cxuosKN2iPhQJ5ws
 zF5GflLV/RPpkxcktkMryNxadoSfNZANui+/UaVN1JIvRP9anzihAn0HrC7QAeWa02
 1WWu53Izxqp0btpWC6SqblNX+T6GEww3out8ddiooEJO04jEUGhkgFJ4P7sbFOKTpU
 KEZG8tvO85aCe1TxgOuNRWnsHGku7oidNWFZeVlysEmWWV4MInW2dUytpDrf531mhB
 ZmMKy7F1W0mew==
Date: Thu, 22 Jan 2026 23:25:20 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260123072520.GM5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-9-hch@lst.de>
 <20260122215457.GH5910@frogsfrogsfrogs>
 <20260123051836.GD24123@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123051836.GD24123@lst.de>
X-Headers-End: 1vjBXv-0003Ax-30
Subject: Re: [f2fs-dev] [PATCH 08/11] ext4: consolidate fsverity_info lookup
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 23, 2026 at 06:18:36AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 01:54:57PM -0800, Darrick J. Wong wrote:
> > > +			if (folio->index <
> > > +			    DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> > 
> > I keep seeing this predicate, maybe it should go into fsverity.h as a
> > helper function with the comment about mmap that I was muttering about
> > in the previous patch?
> 
> Right now it is not generic.  Nothing in the generic fsverity code
> known about the offset, ext4 and f2fs just happened to chose the
> same constant (and the ext4 one leak to buffer.c), while btrfs stores
> the verity hashed totally differently.  I hope the xfs works ends up
> with a consolidated way of doing this, at which point such a helper
> would be useful.
> 
> > Or maybe a "get verity info for given folio index" helper?
> 
> How would that make sense?
> 
> > /*
> >  * Grab the fsverity context needed to verify the contents of the folio.
> >  *
> >  * <Big fat comment from before, about mmap and whatnot>
> >  */
> > static inline struct fsverity_info *vi
> > fsverity_folio_info(const struct folio *folio)
> > {
> > 	struct inode *inode = folio->mapping->host;
> > 
> > 	if (folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> > 		return fsverity_get_info(inode);
> > 	return NULL;
> > }
> 
> Tthe offset right now is entirely file system specific,
> so we can't do this.  Maybe that'll change with further consolidation.

<nod> Ok, I think I'll defer all this talk of helpers until whichever
series cleans up all the post-eof pagecache stuff, and then we can make
all four filesystems pick the same offset for the cached merkle trees.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
