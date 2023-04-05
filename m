Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C962C7619A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 15:50:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pk5PB-000106-CV;
	Wed, 05 Apr 2023 15:50:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+46b8a92f13ae362fdcdf+7164+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1pk5P7-0000zz-2d for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 15:50:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L2Oxdk6Soo+QR4xtEQGW5VILqYT7VRJvcfzUGwIeljQ=; b=mNbl84NhQY0QS75TL6briuy4ZK
 C6ACWTlJ+0cJKyQ+w4iJionLn7r4FMag6CX9jLVn2K30cQYr7FCuxuq1zkzcEoRgXR1If0LmtAfCq
 4JUXcgBCSrTHLBqbyISNQjJsJHU7LB4WYLuldsN7S8dBJonuiJ9nzEaokXu1sF5Ek95Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L2Oxdk6Soo+QR4xtEQGW5VILqYT7VRJvcfzUGwIeljQ=; b=P2Z0vmqBhQ+QLv2HnukW9kJgQE
 AQUlJYvbD2AtmjmcjIuJ7XksUQJ0unO8qYgj0mqBTvLN2UDSuN14r2v1yxU85PIIIyVjOAP0Uetq7
 +zx1roL2LlSZCZ9HdOHt7tuJfEvlUpTa2qNo4/+3KzJ8OQi649Wybthmpn/GkSEKtYh4=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pk5P5-00G7HP-4T for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 15:50:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=L2Oxdk6Soo+QR4xtEQGW5VILqYT7VRJvcfzUGwIeljQ=; b=nhp8jPH1vFH/iElJAx8aqwqR7U
 g+xNujT+vjE4bWfEwqW3BKCVZa4Mt0/Os0v8HNGaILCF8OxUyB5wOqjJRRpRA4EdpvAVUmjmNpbUS
 xkkVJUA0KsaMSSkpRr0JlE4M1+DBZDaIQxvYn//4LCcIK59VgiSAZSjv0vYFxMXkpvfRkqksNjcIh
 y51QOMTrJAHIz0LcXkH9uZr7QtDhk9rdjErAs88IgJs0sz2xDsOZzPZLp0udpmqvU1b1ygELVNTYI
 iSiGvjkivARv/BdG0FSgDDxaGZQyG6ztn11VMyNGMNQ9EBNfqxUReAe+RWRMOy2AHxViuHKIoXkUf
 RV7SaN/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pk5Ok-0050qZ-1c; Wed, 05 Apr 2023 15:50:10 +0000
Date: Wed, 5 Apr 2023 08:50:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <ZC2YsgYRsvBejGYY@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
 <20230404161047.GA109974@frogsfrogsfrogs>
 <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
 <20230405150927.GD303486@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230405150927.GD303486@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1pk5P5-00G7HP-4T
Subject: Re: [f2fs-dev] [PATCH v2 19/23] xfs: disable direct read path for
 fs-verity sealed files
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
Cc: fsverity@lists.linux.dev, hch@infradead.org, jth@kernel.org,
 agruenba@redhat.com, linux-ext4@vger.kernel.org,
 Andrey Albershteyn <aalbersh@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com,
 xiang@kernel.org, damien.lemoal@opensource.wdc.com,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 05, 2023 at 08:09:27AM -0700, Darrick J. Wong wrote:
> Thinking about this a little more -- I suppose we shouldn't just go
> breaking directio reads from a verity file if we can help it.  Is there
> a way to ask fsverity to perform its validation against some arbitrary
> memory buffer that happens to be fs-block aligned?

That would be my preference as well.  But maybe Eric know a good reason
why this hasn't been done yet.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
