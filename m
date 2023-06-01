Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7748C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Jun 2023 06:34:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4btL-0002oT-Gi;
	Thu, 01 Jun 2023 06:34:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1q4btJ-0002oN-Mq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 06:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9rClrKphZplTVtYFMuxLiTJcrcPs3PK+tO7sbVzoQZU=; b=f9TXfXlzuZ/7nEkjdCA0BI2Wv4
 4Pyyf6Hwo4FQmJddV1G6e0gnBRcbCZSy+GP3v+aK2AudnoLN+pXRxcM8KeKyqydJ1Y5BHKKljPBJK
 McKFyB1LfWNBFrLscgmBrKO0kiMhpLNJBUqbkHpBEjvQTs4Fxb2cyotFfHKEhe0N0Afs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9rClrKphZplTVtYFMuxLiTJcrcPs3PK+tO7sbVzoQZU=; b=E31HcYVc2VZpbnyw243ZfGFmcP
 cdO+/nOgBfNSaabOhxVIkEtJBdDkctdnrYTcyotWIH4u9gzLloudIQLOWMMZfBus3bt8J4d9I29zj
 Sq3ugcZkOg+rkhCc5Xp8Cn5XAiGEtZvhmnQyFM7F9ywAuncCTpC1b6sORFBYV3Gpn1UU=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q4btH-0004WX-AA for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 06:34:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 82D0F67373; Thu,  1 Jun 2023 08:34:14 +0200 (CEST)
Date: Thu, 1 Jun 2023 08:34:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Message-ID: <20230601063413.GB24071@lst.de>
References: <20230531075026.480237-1-hch@lst.de>
 <20230531075026.480237-11-hch@lst.de>
 <CAJfpegth2z06pAH5K5vxRsy1PqygBD=ShiQxoYGqjmJPvk1-aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJfpegth2z06pAH5K5vxRsy1PqygBD=ShiQxoYGqjmJPvk1-aQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1q4btH-0004WX-AA
Subject: Re: [f2fs-dev] [PATCH 10/12] fuse: update ki_pos in
 fuse_perform_write
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>, Andreas Gruenbacher <agruenba@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 31, 2023 at 11:11:13AM +0200, Miklos Szeredi wrote:
> Why remove generic_write_sync()?  Definitely doesn't belong in this
> patch even if there's a good reason.

Yes, this shouldn't have happened.  I think this was a bad merge
resolution after the current->backing_dev removal.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
