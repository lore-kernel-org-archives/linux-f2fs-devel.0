Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A803AC55822
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=racFQeBYbgA4rwLdR/vaJd3f115RWJmSUBIUGgbRQmo=; b=dUpAx4Q9NtUO0yWStqSe1MDCD9
	tuas9t2bl7mVicbvSUU14cbh9n25Ni6JxpWZTdh6uQGmxGipkEoh8IoXJevdTUW5PK/BBjdc7Jg3g
	OmTB1KCPI+YULwudYGL2TpdmHcR1ry1IW5jjKpCwQjrxkqv0FrK3+LpdjARxSRr4ydeo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJ3a-0005o5-Pg;
	Tue, 04 Aug 2026 17:36:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wrJ3Z-0005ny-Dp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JfOVmkg/ZrH7z58PXkmf8A65RgrLyFEreADlZeppjrk=; b=kNe9Ctv1/38m/OzjYWXNZDPwPS
 tpaAfmxtMJrot7glUAnh7HzCowIhlB2lq/dEW7fBImkFFG/CwXoMcCgWnhj0xyXxEdYIPkbXLnjYE
 GPDL7jn9fyoCMB9FRyYI5lrgofLszV1WcOJlSAqaOcjEcCYpwF5ZXW1SFpdNlrdJ59pA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JfOVmkg/ZrH7z58PXkmf8A65RgrLyFEreADlZeppjrk=; b=LdEioaUJzs13p4bN5CbOYX744H
 ZUx2VwxNoyZ3hw+EkJuwro8aqUkYlKA+eeVIPonExzW2AC3NqzB90UQs+YGEaVm4hIyr3VXSG4TCN
 x21gMZzjA+zu92HKh2IK00YD7jFCbI+ftq2pYRwD3/P0ji+HzVe1AyVwikl53b5eUbaU=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJ3W-0000cF-8Y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:35:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6A09E6732A; Tue,  4 Aug 2026 19:35:48 +0200 (CEST)
Date: Tue, 4 Aug 2026 19:35:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260804173548.GA13900@lst.de>
References: <20260803200820.393203-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-1-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wrJ3W-0000cF-8Y
Subject: Re: [f2fs-dev] [PATCH v14 00/21] fs-verity support for XFS with
 post EOF merkle tree
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 03, 2026 at 10:07:50PM +0200, Andrey Albershteyn wrote:
> This series based on v7.2-rc4 + lazy-bounce@hch-misc

Oh, I gave up my hopes to get this into 7.3 and was waiting for
your series to land first.  Right now there is one outstanding issue
I know of with the series, which is that we need to clear REQ_POLL
for bounce buffer I/O, and of course the somewhat complex cross-tree
depenencies.

I can try to get it rposted, although this week I'm travelling for
two conferences, which doesn't help.

If you only need a few patches from that series and they are kinda
localized to xfs, maybe you should just cherry pick those from
my series and include them?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
