Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C84D72340
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q6wN28uRjk3lNb6CO3QckFWqpzZg9yqE/a056R+7VjY=; b=HYrOuLcciEpxX72FaO23JmWHbI
	qSO8GNM7IJ+bUrAX56kQYTw+pwOaz0o0OSsCGMrtX01wqaCeEwt1T8FijZyhm2I38waK5WL19a3G/
	OOoSfNaXJUXlWoIhilkkbEz1INqDLiRC1ZcYdYe6b/1gljlxNHYhBD8G9OF1DSe/vyIA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjBcv-0002IT-6d;
	Fri, 23 Jan 2026 07:30:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vjBcs-0002I8-Jd
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 07:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4pqbi125ZgoBAyafzZacCHFh7WYA+uNsemwYj4VrUYQ=; b=kHgEmIOutgh8jSsnKzt+pWgUhD
 I2MLcoAZUAH4dyUACNYrWUBmGOB1u6rra3m5SKk9ulWBq/ZD7qJyFOImTvQgNx9bLMeoi1DBy/+3R
 fvJM/uT8Fy94OMnRa1ZFULxtznhwooQ9AicUuznEd8FQnPhW+rzI3EFuXrKQ/kerEDBE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4pqbi125ZgoBAyafzZacCHFh7WYA+uNsemwYj4VrUYQ=; b=Eq23H3bhbzdJ2yJFqf30DrDGZ8
 +yUURjFlY6W7zxFKhx6qL3DvqiJ5IDc7WAGk2rEl+cKBePIBQqiLW8WDZlP0FzhrD68nRVJ38uMbj
 Wsk5sSe0RjXuJHe8VxD0dJgqBShtVG0sFqPT6KhBp/9ru7cZcRQY3qQrBXeDieRqx7n0=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vjBcs-0003UY-T4 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 07:30:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 93D62227AAE; Fri, 23 Jan 2026 08:30:25 +0100 (CET)
Date: Fri, 23 Jan 2026 08:30:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260123073024.GA27731@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-12-hch@lst.de> <20260122220420.GI5910@frogsfrogsfrogs>
 <20260123052723.GE24123@lst.de> <20260123072700.GN5910@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123072700.GN5910@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vjBcs-0003UY-T4
Subject: Re: [f2fs-dev] [PATCH 11/11] fsverity: use a hashtable to find the
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

On Thu, Jan 22, 2026 at 11:27:00PM -0800, Darrick J. Wong wrote:
> > rhashtable_lookup_fast returns the struct containing the rhash_head.
> > The paramters store the rhead_offset for that purpose.  See rht_obj
> > as used by rhashtable_lookup.
> 
> Ahah.  That's right, but (imo) a weird quirk of the rhashtable
> interface.  Though I only say that because *I* keep tripping over that;
> maybe everyone else is ok.

I don't think it's a quirk.  It seems like an explicit design decision.
Not one I would have taken as I think doing a container_of in the caller
would be cleaner, but it is what it is.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
