Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441C8CD4851
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2026 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6J5CEiLuv/iZKKVt2IbKXbLm1ihNbRIZ8nV3HM0ftV8=; b=T9dHdSMBwcQs2fsx59NshOfpug
	/TT130oO4ahoIKj5lwu3Lhp33mGhLVxcASUSQ2HJXF6M4hszb+8cCEhqysHWJvHVF3w4bKniZ+IIM
	ftvI8R1AZD6oOOX4n+j3U4A7G44j9hvgpttJ/B1yl2yFLW5EblCvGpba36LS7Z/y7ppY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wN3W8-0000BX-ON;
	Wed, 13 May 2026 06:56:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wN3W7-0000BR-RN
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 06:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dbax/n2PuXSr1L7VYwyXeeuH0mEbfBGTLmPkem6T8y0=; b=bNbWcgP79awLn1scQjma4x+BVP
 DBi5EIO31GplzWDzkwtiJvuwgyic0SGyd5nhINsBchdVd8I4JhSy2dNl8eblWrUQSH+Xz+lfypPnG
 43LB70nsmuI+GRjGc2q5cJwnGHSGbVK0KuaYQXAu45mFW6j+sKUWJXyXlXnBlH/aq6Cc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Dbax/n2PuXSr1L7VYwyXeeuH0mEbfBGTLmPkem6T8y0=; b=IUe4CtrLdQj70oRdHSs7MHG40h
 u3q5VaVh696rR2us6OrLI8I7Dx/sgN9M7weOk1ypS3xInAtc/7sHHvTSOZHLhDr1Gucon6RH3KFsz
 AW1WEUHzg7EU7uEA1FjQk3Flk61PS58YmE/TDveaep6+hnUpxQjYuR8AlcO4ADYRbV2k=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN3W3-0008F1-D0 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 06:56:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 82B0768B05; Wed, 13 May 2026 08:56:08 +0200 (CEST)
Date: Wed, 13 May 2026 08:56:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260513065608.GA2250@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-9-hch@lst.de> <20260512170204.GI9555@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512170204.GI9555@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wN3W3-0008F1-D0
Subject: Re: [f2fs-dev] [PATCH 08/12] swap,
 iomap: simplify iomap_swapfile_iter
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
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 Chris Li <chrisl@kernel.org>, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Kairui Song <kasong@tencent.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-cifs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>, linux-btrfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 12, 2026 at 10:02:04AM -0700, Darrick J. Wong wrote:
> OH.  Now I remember why -- it's to handle contiguous mixed mappings
> better.
> 
> Let's say that you have a 1k fsblock filesystem and 4k base pages.  You
> fallocate an 8G swap file and then mkswap it.  The first mapping is a 1k
> written mapping at offset 0 for the swap header, followed by an 8388607k
> unwritten mapping at offset 3k.
> 
> The PAGE_SIZE rounding code in iomap_swapfile_add_extent will round the
> end of that first mapping down to zero and ignore it.  The second
> mapping will be treated as if it were a 8388604k mapping starting at
> offset 4096.  Now the page counts are wrong and the swapon fails.

Do we care about this use case?  I guess you did as you implemented
his, but still?

> 
> A more generic solution to this would be to change add_swap_extent to
> take sector_t addr and length values and use them to construct a bitmap
> representing contiguous physical space on the bdev, accounting of course
> for PAGE_SIZE alignment.  Except for the swap header page, every other
> contiguously set page-aligned region in the bitmap gets added to the
> swap extent map.

You don't even need a bitmap, just do basically the same checks as
the iomap code when moving to a new swap extent after moving to use
the sector_t.  And it really should anyway, as the current abuse of
sector_t to store a disk offset in PAGE_SIZE units is pretty gross.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
