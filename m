Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8EAC7EE24
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Jun 2023 06:44:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6QQF-0004NF-Gs;
	Tue, 06 Jun 2023 06:44:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1q6QQ9-0004Mx-Jk
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jun 2023 06:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+rhFMcHe3rPQMZLGfmZYoovNgG6jY6X2NeFShgojO/g=; b=PXQryTB0tVWqBaGqSPrSuDAxZt
 tmujaptHSfh3FMZ0Qu+5C0JVFIvUY7sYgnOzGpm/nmRdnRXRHl+JoOHSUBdgxrQEOXyoWKIXoUrxO
 gBqnp111IYWMthLos42/DUKuzapqUe2cZwCckhhALevwXmSWLzukVKX8yawwiVuLNJR0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+rhFMcHe3rPQMZLGfmZYoovNgG6jY6X2NeFShgojO/g=; b=O+bidfEORoZyxXDmXPPDlp2OdB
 vDgB1C/W8naQ40LHg0DUybJBhu862f1NyrNWm6EyatXRiv8q0ugC5vp8l62bK27ngn/0w3j22WGY6
 fufvalb/v9qY81dXqXRrwxAgoIZeSyafg5ZfXp7NtFsgCU3WZ/qNjR+6wIfEzK3AY9uo=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6QQ8-00CT5Z-OH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jun 2023 06:43:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 294C46732D; Tue,  6 Jun 2023 08:43:44 +0200 (CEST)
Date: Tue, 6 Jun 2023 08:43:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20230606064343.GA27497@lst.de>
References: <20230601145904.1385409-1-hch@lst.de>
 <20230601145904.1385409-10-hch@lst.de>
 <20230606000414.GJ1325469@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606000414.GJ1325469@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1q6QQ8-00CT5Z-OH
Subject: Re: [f2fs-dev] [PATCH 09/12] fs: factor out a direct_write_fallback
 helper
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
Cc: linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 Miklos Szeredi <mszeredi@redhat.com>, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 05, 2023 at 05:04:14PM -0700, Darrick J. Wong wrote:
> On Thu, Jun 01, 2023 at 04:59:01PM +0200, Christoph Hellwig wrote:
> > Add a helper dealing with handling the syncing of a buffered write fallback
> > for direct I/O.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> Looks good to me; whose tree do you want this to go through?

Andrew has already picked them up.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
