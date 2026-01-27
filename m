Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1992D25944
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A3duc7hbOXLpMGDxmQXzYI5OdlGW3ZG9eaGssv/svXQ=; b=Iw1hh7MY036FaYXKameP3I3C09
	htBaGJF2HBhqnmpd05lcKY5rYF2/4EYjLfAFWwSLgmoaAIxEGvZ4lPoo5h72Xez1kLxABhsn2U3Cf
	PRaQyqBaAXDXdxRTUrHGBhEFwmmaxXYPf62EZAj1xfnT/I+eryszyHREYx+h6ChvQoOo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkcN1-0007o2-EX;
	Tue, 27 Jan 2026 06:16:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkcMw-0007ns-FQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 06:16:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NJN1laCjfRD0eNeMidqh3OTLLU/QBKHms3bDZYOjD/E=; b=GCXn7W8qg45R9+9bd9NBRHw9pE
 ShyrqTt8lHNTDOKoiOu1pQDWyCrYeSXyyCKg41cMPfgrAGgOCASNyizyYa3oM00dcXMyZj0A3akLy
 arqrCT0SPtSc5dfaOIonbUwX4Trxhm2pg7OTcaYp6Hwv9SvFTlfEjE9BCh+D7oHqK3kk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NJN1laCjfRD0eNeMidqh3OTLLU/QBKHms3bDZYOjD/E=; b=GaVXFPYbMTr9xKGU2sihfLyZn2
 1Gjfvk1hlTwhkDShkWaejRGl613RT+ThBh7A0twhnNclIUAmBlh16v/eT2HyFx7xQ0pVT+J+H1NgW
 a0CGXWX0ludyexdtOgn6Vhr+m5o15HasPZHiCGYOIBwTrmc5/sQ7LLjvuidySJBF1pBM=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkcMv-0001hd-Ug for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 06:16:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2F41D227AAE; Tue, 27 Jan 2026 07:15:52 +0100 (CET)
Date: Tue, 27 Jan 2026 07:15:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260127061551.GA25522@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-17-hch@lst.de> <20260126204030.GC30838@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126204030.GC30838@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkcMv-0001hd-Ug
Subject: Re: [f2fs-dev] [PATCH 16/16] fsverity: use a hashtable to find the
 fsverity_info
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
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 12:40:30PM -0800, Eric Biggers wrote:
> On Mon, Jan 26, 2026 at 05:51:02AM +0100, Christoph Hellwig wrote:
> > The file open path uses rhashtable_lookup_get_insert_fast,
> > which can either find an existing object for the hash key or insert a
> > new one in a single atomic operation, so that concurrent opens never
> > allocate duplicate fsverity_info structure.
> 
> They still do, though.  But that's unchanged from before.
> ensure_verity_info() frees the one it allocated if it finds that one got
> set concurrently.

You're right.  We allocate them, but never register them.  I'll fix
that up.

> 
> > Because insertion into the hash table now happens before S_VERITY is set,
> > fsverity just becomes a barrier and a flag check and doesn't have to look
> > up the fsverity_info at all, so there is only a single lookup per
> > ->read_folio or ->readahead invocation.  For btrfs there is an additional
> > one for each bio completion, while for ext4 and f2fs the fsverity_info
> > is stored in the per-I/O context and reused for the completion workqueue.
> 
> btrfs actually still looks up the verity info once per folio.  See:
> 
>     btrfs_readahead()
>         -> btrfs_do_readpage()
>             -> fsverity_get_info()

True.  I've fixed up btrfs to avoid extra lookups.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
