Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59FDC43334
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jun 2022 06:07:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1ifJ-0002bm-My; Thu, 16 Jun 2022 06:07:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+c9d26d7972d0db0217a7+6871+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1o1ifG-0002bf-S7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 06:07:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lQ1idLnL2UCMJjEJnkwsAGfziMzzcuwKz3HZqhqoSgY=; b=GN5W1i1It0N2f6fpyM5YWiIIvH
 sLqkoJA5GxHz0AKoI8iqulj40lvyvxN56TJkp8hFGOxewQDXjDBd6jxyCxr6W8oFWcD6MgyLLK4yj
 a55W8WgIoph8NoyHgaoutBnbRaRCBOdD+W7HV6t7ErBItlRI4eBxePXKp9Bc2ZzymUjk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lQ1idLnL2UCMJjEJnkwsAGfziMzzcuwKz3HZqhqoSgY=; b=Q1p6AalsP9x6jA3uxAkuS//R1a
 e5kLHJzd/Q2Evb0146wLUUWd1D/bJXWq+e3oTlocDB2CRz3YuIWvuE9hJcQINPNLKsd3nWOuq1Zl1
 fwMNBEU/Txw66FqMNRd2h6UgrcegsJA20Dj4vZfYtXbyh34yfB0fdjLZjiOYG7phTnEk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o1if9-0006yR-Vn
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 06:07:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lQ1idLnL2UCMJjEJnkwsAGfziMzzcuwKz3HZqhqoSgY=; b=YpAt3w8FxJkqvgT9iUxi24xofx
 8+MvlP+t2PLJClmbzMh18BN6ZwDbMmncgLTl17zD+v64zcQMphUoIRaaPqzZ9Kcpf+7tyKKylosSd
 OBn0bXQZGwNn1yI7B/kUkJqGiMJWwXuRRwgQUA3cJpfiVH00RtuJeKBV1dYTiGYoxczXS8RI9iqPE
 IKx0AVVX9KzBGe6L7/GrOI+YrFxVeLneipAWwETP8dgETplOiFEcQKIPl+aG6wgIFJdwWuEWPkEWf
 I0c4yVCYAk3jbyZnzK9cGmY24O5LW7GYL7W6PZ6EU+ypD46A/EQ820J0qw64K/4/XVRxXZkCVCaTN
 vOIrX+fA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o1iez-000gG0-HX; Thu, 16 Jun 2022 06:07:17 +0000
Date: Wed, 15 Jun 2022 23:07:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YqrIlVtI85zF9qyO@infradead.org>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
 <20220520032739.GB1098723@dread.disaster.area>
 <YqgbuDbdH2OLcbC7@sol.localdomain> <YqnapOLvHDmX/3py@infradead.org>
 <YqpzqZQgu0Zz+vW1@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqpzqZQgu0Zz+vW1@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1o1if9-0006yR-Vn
Subject: Re: [f2fs-dev] [RFC PATCH v2 1/7] statx: add I/O alignment
 information
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
Cc: linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 15, 2022 at 05:04:57PM -0700, Eric Biggers wrote:
> One more thing.  I'm trying to add support for STATX_DIOALIGN on block devices.
> Unfortunately I don't think it is going to work, at all, since the inode is for
> the device node and not the block device itself.  This is true even after the
> file is opened (I previously thought that at least that case would work).

For an open file the block device inode is pointed to by
file->f_mapping->host.

> Were you expecting that this would work on block devices?  It seems they will
> need a different API -- a new BLK* ioctl, or files in /sys/block/$dev/queue.

blkdev_get_no_open on inode->i_rdev gets you the block device, which
then has bdev->bd_inode point to the underlying block device, although
for a block device those limit probably would be retrieved not from
the inode but the gendisk / request_queue anyway.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
