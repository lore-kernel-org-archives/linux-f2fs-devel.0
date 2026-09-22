Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F588C982FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RdML/sdCCYjD+NgBbIO1jQTkjmTdBz6GcbyYgHsQUz4=; b=Sk3fXTG2ooJiPuO8YXXR3YfpwA
	8ms+0par78v0FrmlOb8Qd1r+T65Ex2wesYIfyWuDakHDh+5bG1YmxaQco1g4RwvnpM4Nb1zCoEkN6
	Cw/W5Od/Gv/UEAPOgH6S2TA7JXqDAsuVnSbk67jpDnnkCs635+cQz0JBGGygdd3vyC/4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8uqV-00022l-KF;
	Tue, 22 Sep 2026 07:23:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+a4e1fe537d2c1e8d4400+8430+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1x8uqC-00022H-79 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 07:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3qq0Y7EkYZQB8hy7/hh9R5IKZgsY5zc1hNog+FB/7qA=; b=VV8mwFnviTJ7Wu5inqHwFqGb0w
 /L5xznHIOVOL9UjoxxaAnS4+hhN787BxCoshunsTwD4e5gFWbSHjPziQq1jEMMF84i4+3Uxygmcq1
 2Zl23dRydp9gdX6WwGGGS6PGanjQqqyyJipJd0NbPfCn4zdwB9MIhoIQRooXQTp4yzQE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3qq0Y7EkYZQB8hy7/hh9R5IKZgsY5zc1hNog+FB/7qA=; b=B511h0N0Sjm+CGrTy7R0fjyVWE
 m7vSLIesfPFWeGToL7u4EWwhh6wivd9PVeA3vq+5J/5Ma/tFf/sJ1/lKge/B830Sg0z60K6zIzuvi
 RTuxupMhqo0APiYlnabMMccwjARl6fFYDzvh3vSYqCTl5r/JrhRi+YXj05iymdEwhnTU=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8uq9-0003WI-MB for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 07:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3qq0Y7EkYZQB8hy7/hh9R5IKZgsY5zc1hNog+FB/7qA=; b=HFw1PEaoKGRVVOHOulcFABvcvD
 qvfOH1H7/NrXCx1ZznRfNai3F1oyiRHGoIfcNQ04KDOfWBgugZIEryXn9ShwYQig1A4ivC4VL/9wl
 IqmFkQzyO4ddOgSJzTpDRVzIauMyZmxEwvOcJ7M4c1UJGKjZINI+ENGwbXlfIoVMxuxsXeZhqDmpj
 VpSU6tXGdTXjQohEss4haQPdrOBtjJqZ8BYvxar14WNAI5o5BTGgw5yPgFJjUGPgG+V5UjD/Oa0s/
 sAgxNvqQTkQgG+n3cAqojrWU9F2FQLnKwtPn/9OrYr3euBvpvXwPaptMfFuIbX/qrZLJhiJmEnRyK
 qshyy8+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1x8uq4-00000004Upg-1yFV;
 Tue, 22 Sep 2026 07:22:52 +0000
Date: Tue, 22 Sep 2026 00:22:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <arIszDCcy0VbRVFp@infradead.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-16-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918111539.1003439-16-aalbersh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1x8uq9-0003WI-MB
Subject: Re: [f2fs-dev] [PATCH v16 15/21] xfs: add fs-verity support
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 18, 2026 at 01:15:27PM +0200, Andrey Albershteyn wrote:
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +	xfs_trans_ijoin(tp, ip, 0);
> +
> +	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));

We can't call truncate_inode_pages with the ilock held.

I also don't see what this is trying to protect to start with.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
