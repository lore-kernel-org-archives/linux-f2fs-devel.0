Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61A9C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 08:39:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6ohY-0007QL-1p;
	Wed, 07 Jun 2023 08:39:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6ohX-0007QB-93
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:39:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pkgYdGDWuK0wmgKS4U/70ySedsr0U5XZ+57P7WD4+Gk=; b=c56m61Zkw8TGtsHO6PwZlRBkEU
 6giFknj0hhjXmXm8LFaCTvJIkNTykFYmOyJJO2cJVKyNz+r7eIclLi5jfUJrmW5HXGgI5+gtpgZ2K
 d1eYGgQy7qRAUnlrDRo41HOSDUr4k+qR8noW7aSOuZGuAE5hxHGh23xMmk/6eSPMmL9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pkgYdGDWuK0wmgKS4U/70ySedsr0U5XZ+57P7WD4+Gk=; b=UTPo7fXKlik8cxED9dAac4TWqP
 WFBdpyxz7jQFaNmPXaz1m0QkjFsyRNDd86gHzkiqEneupsbmCTizKViYixUe+5hw31Tf4d++LjLbz
 l8/6TgeJpSl+kodMA3vS978np5D/AoH1OE8En3nD3QrFPEk+Y3tJkp98pALzRZkwTQDA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6ohV-0003nY-OO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:39:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA2963090;
 Wed,  7 Jun 2023 08:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3A1C433EF;
 Wed,  7 Jun 2023 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686127163;
 bh=KpWcSBDck/xwxFkd8Vk7fAgf7Ve8mFKgiGPrEW6K2Q0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uA7EJ9P/L5+3z/cwnQO3ez6heNBOh2ztm0tByBVVVWSG+Ty9bViARmYghliiiTOjF
 zfyDKZ/WVZKnKqb27eoLFNy9Gp4VWJLbdFkpxtUdjTW1ihovnzx9mCqpvHlcVKl0Th
 Rf10QupAAvqzcAYZp+8tXsnFlejznxrDCiS1fwCDYebGVZXivhfNLwt2PfA+VtSam8
 pCcZzAUeaQGLwZNEeJwBUOIWm8QeGe+wPLl1Arn+PXC4T9/q84iyVBg8Og8sHsu9AC
 ymPxr4yq3cRtmcaUpMPCw2/GSyLHKDd4l8T1R7oWgm4TKIqgSNoA6xqMxcENCVvjqq
 jYZClevsYWR4w==
Date: Wed, 7 Jun 2023 10:39:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-deckname-gewettert-cf7a2bce127f@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-15-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-15-hch@lst.de>
X-Headers-End: 1q6ohV-0003nY-OO
Subject: Re: [f2fs-dev] [PATCH 14/31] rnbd-srv: don't pass a holder for
 non-exclusive blkdev_get_by_path
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
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-nvme@lists.infradead.org,
 Phillip Potter <phil@philpotter.co.uk>, Chris Mason <clm@fb.com>,
 dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Pavel Machek <pavel@ucw.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Jack Wang <jinpu.wang@ionos.com>, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 linux-pm@vger.kernel.org, linux-um@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 06, 2023 at 09:39:33AM +0200, Christoph Hellwig wrote:
> Passing a holder to blkdev_get_by_path when FMODE_EXCL isn't set doesn't
> make sense, so pass NULL instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
