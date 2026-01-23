Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C525D6CFC6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 05:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/TTp0TbTWXo1Kbkn0vL4rYXkoStIzIa59pvk76797s=; b=bBJ+YJ/xvDDLiHO4x2nojJNCV9
	CNlNPXca7bgdWe/5tEa7hBpsKi+0JmZ9ri2Y9Ua2B92yfZ3WxAFP2yyhSWdPo8E6ZlIj2aTlkwnb5
	LCwN9bEdqHd9LntNJKfpslIQP3ZZ5oROI9Qs3YteQJgi0bWy/15hLsanU6fclc/o+Ev8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vj9ZE-0005jn-Tm;
	Fri, 23 Jan 2026 05:18:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vj9ZD-0005jX-HT
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 05:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pVC4ByG0gv9RCagfv3ZvZ4y0W9AucNP8pWnt5GYJWZM=; b=UjAiUEs8kBo/lI2CCkTccuHu7P
 mjkzCknTUGpQQ855/NP8SlcFbyMj4qhQX8Nej7Yr5JatGZDri5BJyfiMpfSIkLegi+cgc/Zq+S8Sp
 AKoB8cZHk3PO6b+L/YgsAOXV6XkFko2pyHGsiXsLVo5m+ingkhKYqJx/nNeJZP7XnAbI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pVC4ByG0gv9RCagfv3ZvZ4y0W9AucNP8pWnt5GYJWZM=; b=VfITLlF0g7dMa5QhZ5HQYFnesp
 kwX82uwKMZ9xxKmQahW/pYXda1vAVZOo4BpNFtxPwpFcj/iFWxyrDDvEBTmj14YVswmIoGs34eBKr
 hMY4OWX3Zell7qidCuod+VWHHh2tznxSl/Lb+sTcUwvhwXbfu1riU6Kk8ZA8n98YGPy0=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vj9ZD-0006UQ-Qv for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 05:18:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 56C74227AAE; Fri, 23 Jan 2026 06:18:36 +0100 (CET)
Date: Fri, 23 Jan 2026 06:18:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260123051836.GD24123@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-9-hch@lst.de> <20260122215457.GH5910@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122215457.GH5910@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vj9ZD-0006UQ-Qv
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jan 22, 2026 at 01:54:57PM -0800, Darrick J. Wong wrote:
> > +			if (folio->index <
> > +			    DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> 
> I keep seeing this predicate, maybe it should go into fsverity.h as a
> helper function with the comment about mmap that I was muttering about
> in the previous patch?

Right now it is not generic.  Nothing in the generic fsverity code
known about the offset, ext4 and f2fs just happened to chose the
same constant (and the ext4 one leak to buffer.c), while btrfs stores
the verity hashed totally differently.  I hope the xfs works ends up
with a consolidated way of doing this, at which point such a helper
would be useful.

> Or maybe a "get verity info for given folio index" helper?

How would that make sense?

> /*
>  * Grab the fsverity context needed to verify the contents of the folio.
>  *
>  * <Big fat comment from before, about mmap and whatnot>
>  */
> static inline struct fsverity_info *vi
> fsverity_folio_info(const struct folio *folio)
> {
> 	struct inode *inode = folio->mapping->host;
> 
> 	if (folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> 		return fsverity_get_info(inode);
> 	return NULL;
> }

Tthe offset right now is entirely file system specific,
so we can't do this.  Maybe that'll change with further consolidation.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
