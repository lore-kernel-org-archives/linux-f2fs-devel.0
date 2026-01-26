Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48B4D19519
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 20:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BeHzyyL4Nezm8sM3VySwEK0UZYjose23wgleKrjl8Ww=; b=W6lr+Tu+TB90u0R+CDhSM3/0kj
	t0z+RpfCDGB1pBCwRO9BstMgX2FDemN8Axn9sdmElu5MhFLw/7ZRudapCYyqwIIMiJprSKjptFWeh
	tNGhswXCxy6NGW3epxdEGcT33NMOdvOBVZlzvDypgET7RnnJqeT1YlPE5FcClOr4OajY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkTKw-0007E6-MP;
	Mon, 26 Jan 2026 20:37:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vkTKw-0007Dw-14
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 20:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3saKjm2Eld4tqy+JW1UOpamLz3ewptR/Jwut4MX+44I=; b=TMqoDLVMnPD0BDhxgHQBPT9w9+
 KONeaSkjPeKTUmgAB5C5Sa5kUgmQqb51UPXd8VJjIOUMGoNF08dAvzAF9/LH26v8geek03bzFJ9Um
 2i+hyvZDM8Hcu81qt15T47Scou7hhThcqtQ5caCE/FiZm9nvIOtav84riFJqnKNeEEQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3saKjm2Eld4tqy+JW1UOpamLz3ewptR/Jwut4MX+44I=; b=Sn2IJHPrOzById4NiyaNt0ThRy
 gPVf9Dmj7OpsPlMHdbnU92Wb47zLJdigEoKuEol3ViiyIZYyvcg6TTuQGTPrrYBwngQtYB7lAx+L2
 OT91cHQY2hhELNlQSj5IEBtmxZCacC7fwvFmhEcIIp7Q4yjA9JGkPwErKAVRfAT9GJI8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkTKw-0001J0-D9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 20:37:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C5D8260129;
 Mon, 26 Jan 2026 20:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D79C116C6;
 Mon, 26 Jan 2026 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769459835;
 bh=Vi4Xz7fQzexF/Gc4dDWOqmZz3iRT/ILc3hdzXJ0Me+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eg5YvHs3EZveAc2fR+o4fsx/gIND0/Kb1Wtc2K2cc5EclCuFQJ8P8+TUfhzZH7LXf
 q92uZ6rWr4uJfFmo7UiTiUaJkM4Y+GFzxHaGXdodeWQfsJk2hKmZ5DqAghx8iY1YvB
 DSAz/N8Z6fHx6akeFxkfWFCXRGPzfTFgmhhyZKCt/2/wuSJ1tnulAGPbaF2mSOQw2k
 gGuPRbRWfQci+bRobOMZR3wgwwBnVGsBLanijKuaI5N2Y4X36PbTq+odJEddmFGVzh
 LDOISU3iveR0gaiZJOzpIHn8o0z9w0X+V21EHIboDC1xcCGP3Rwa/59fS3UUKAeO81
 TneEpalt0ph2Q==
Date: Mon, 26 Jan 2026 12:37:12 -0800
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260126203712.GB30838@quark>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-9-hch@lst.de>
 <20260126192655.GS5910@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126192655.GS5910@frogsfrogsfrogs>
X-Headers-End: 1vkTKw-0001J0-D9
Subject: Re: [f2fs-dev] [PATCH 08/16] fsverity: kick off hash readahead at
 data I/O submission time
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 11:26:55AM -0800, Darrick J. Wong wrote:
> > +/**
> > + * generic_readahead_merkle_tree() - generic ->readahead_merkle_tree helper
> > + * @inode:	inode containing the Merkle tree
> > + * @index:	0-based index of the first page to read ahead in the inode
> > + * @nr_pages:	number of data pages to read ahead
> 
> On second examination: *data* pages?  I thought @index/@index are the
> range of merkle tree pages to read into the pagecache?
> 
> I'd have thought the kerneldoc would read "number of merkle tree pages
> to read ahead".

Agreed, please make it clear that this function is working on Merkle
tree pages.

> > +	for (level = 0; level < params->num_levels; level++) {
> > +		unsigned long level_start = params->level_start[level];
> > +		unsigned long next_start_hidx = start_hidx >> params->log_arity;
> > +		unsigned long next_end_hidx = end_hidx >> params->log_arity;
> > +		pgoff_t long start_idx = (level_start + next_start_hidx) >>
> > +				params->log_blocks_per_page;
> > +		pgoff_t end_idx = (level_start + next_end_hidx) >>
> > +				params->log_blocks_per_page;
> 
> The pgoff_t usage here makes the unit analysis a bit easier, thanks.

"pgoff_t long" should be just "pgoff_t".

(It compiles anyway because it expands to "unsigned long long"...)

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
