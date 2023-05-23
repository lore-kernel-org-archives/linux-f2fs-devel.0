Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31D4C7EE29
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 May 2023 01:12:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1GZo-0004ny-Dv;
	Tue, 23 May 2023 01:12:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1q1GZl-0004ns-Cp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 01:12:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9kEBlrM2mXZCJZviNHwocMuJjhBpx9Jd+tPaUpbpJo=; b=A5x+n0lOLLRG7sUAiCq3EOIjye
 O+3aMcxueFbJC7l2R2sC8OqguwqDtJb7PvA+irMw2K+L578hQwmieuSnKi5ka5MOImWTOtdCx/FR1
 PyYxO1Bj2PS3K7Mcb2hl1ezZsyGo2ZIHUmor15W0JZ2b8MXFWuBDaQEV8X1Ssobi7p08=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S9kEBlrM2mXZCJZviNHwocMuJjhBpx9Jd+tPaUpbpJo=; b=KgukTJsrbUYpF1mYuDpA9E5oC2
 YRu4H6qoplY14ifT4C9phEdX0+t3e+q5Wbn/HwoIQj6mfTFSvplHcOVueRxEg8wFqrdT1n+8Xq+zd
 Vo04iMHf8a0TSn0n2FZsrV0J+d6Q0Atdaey/BxlL5tSpbX/RzsRpWLCvl6wHxSVo4PJw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q1GZk-00HUQH-Oh for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 01:12:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6254462D5C;
 Tue, 23 May 2023 01:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4572C433EF;
 Tue, 23 May 2023 01:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684804346;
 bh=ZAzh2JNRCsiTX6v9YnyrLbWHKhYqrabrMaOhNbQDKt0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XA9zKICML07FeJjfGnwZEsKdRfAesSdvaaHFlpSZu8WKwtPS/f0ia/t7cGRGTyNg8
 rT47MwwEolWaHM51ZumONutB3+Qf5F12m8Z1kVmc2gMNJAka7ZrHhQv+ohAfxmjULN
 /2aDsxU2KzjD+vNRj/AiuZQD9F5M3i7Ev7sTWBz1AKeTf5KddszyQ6/YCnwWe/h4U7
 jrL//iKf2/JOVhxfT/Blv1VumtTkmowtNzBwA7CUgcLjxweF6oJXfG2AyYi9pNXgqH
 jP3o/0cJLs+Dt54A0XsaAGrmEVutP7KfJXFX8dB/TIRPNdcNKc2IgCreYwgPmGaNnn
 TdjhaErmpweVA==
Date: Mon, 22 May 2023 18:12:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230523011226.GF11642@frogsfrogsfrogs>
References: <20230519093521.133226-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230519093521.133226-1-hch@lst.de>
X-Headers-End: 1q1GZk-00HUQH-Oh
Subject: Re: [f2fs-dev] cleanup the filemap / direct I/O interaction
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
Cc: linux-mm@kvack.org, Andreas Gruenbacher <agruenba@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>,
 cluster-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 19, 2023 at 11:35:08AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up some of the generic write helper calling
> conventions and the page cache writeback / invalidation for
> direct I/O.  This is a spinoff from the no-bufferhead kernel
> project, for while we'll want to an use iomap based buffered
> write path in the block layer.

Heh.

For patches 3 and 8, I wonder if you could just get rid of
current->backing_dev_info?

For patches 2, 4-6, and 10:
Acked-by: Darrick J. Wong <djwong@kernel.org>

For patches 1, 7, and 9:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

The fuse patches I have no idea about. :/

--D

> diffstat:
>  block/fops.c            |   18 ----
>  fs/ceph/file.c          |    6 -
>  fs/direct-io.c          |   10 --
>  fs/ext4/file.c          |   12 ---
>  fs/f2fs/file.c          |    3 
>  fs/fuse/file.c          |   47 ++----------
>  fs/gfs2/file.c          |    7 -
>  fs/iomap/buffered-io.c  |   12 ++-
>  fs/iomap/direct-io.c    |   88 ++++++++--------------
>  fs/libfs.c              |   36 +++++++++
>  fs/nfs/file.c           |    6 -
>  fs/xfs/xfs_file.c       |    7 -
>  fs/zonefs/file.c        |    4 -
>  include/linux/fs.h      |    7 -
>  include/linux/pagemap.h |    4 +
>  mm/filemap.c            |  184 +++++++++++++++++++++---------------------------
>  16 files changed, 190 insertions(+), 261 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
