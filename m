Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD879C5518F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LEhIklsyRbEcCDSFS/622lIVODiMLx5yhZj1tQt1YTI=; b=iC5wAdxg5Be3ps8mmH26YQD5gP
	y2/71K2980ZD+QEtV9QvUU7E8XiKswb8MapyhAkoocL0NMx5hCe1oGDzondHOh1j/j2ZmNjwqlrxf
	hYu3JBX1cOVp3crOHkN51X110DPJqYE9XB8uLxG3ErbaYssTt5qHXGkQ2YjbVDxkiBXI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJJD-00031U-DT;
	Tue, 04 Aug 2026 17:52:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wrJJB-00031N-Uf
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:52:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=avxqCNYtm+eOL6Mr+rgt7P8GoIvTAe509I5ayZLVOCA=; b=AwHLdZg9WNOU9vjKyT4CGHyy3R
 uaEn4Na3zB92bMkgwHzoTK9oQWrCIquysCtZu+rFkeSudsCg7i9T2o/iAiRcQAnsSnRUwOMLB6fpi
 sX6KAqdiLyMNOdSwwq0JAj5CutDqTrrWoavk90uOo9jX3c+WFjQbwNCKT29mPIwdHX5E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=avxqCNYtm+eOL6Mr+rgt7P8GoIvTAe509I5ayZLVOCA=; b=lUE0j3t574SxHEc+6rq0/bcs3R
 5AtDP4MECqK5dJ+eZyHMtY7Twg53F31q0xouEy7Uh5sXosp/yDCEDBGBEpimSvaPjYQSDYyeZ1p4U
 w0kcziXG9uTIg2xNCZdbh9UgbQrG14OodIs4BL+zRZgZrDee4tuIaQpdYSGrMEM8qT78=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJJF-000893-2w for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:52:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id DA8B2413C1;
 Tue,  4 Aug 2026 17:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AF8AD1F00A3D;
 Tue,  4 Aug 2026 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785865923;
 bh=avxqCNYtm+eOL6Mr+rgt7P8GoIvTAe509I5ayZLVOCA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=c04pzg1pshkwDPnup5ADRor9nH/H4Sey1uDj7sr9rIwD7mNMsJGmezGliGFwNrWM1
 0sXHG+D0Gqe5StJJgwwf6QIWaFImr4WopHTmsAjd3yRwYnbiI86juqODB/g34HaEVh
 Owxj9w0d0hLQPORWDxQwrQixBDmK8dju0P0+erPyufRCDexjw4BtO+GJUoT08kBLN1
 MT5G62iNguAfVtV8CuO3IqEfNbl/lwfDN7Gi8zWk6i4+XfFE4Q+qru0PpnzCx8Hedq
 aphNQMhc9IWXRPS6ZqYGWKLc2hMbM3P/U1pkDwg5gg8aiWm5FFBqno059IkCT1hrXU
 iFg4azLgsZEQQ==
Date: Tue, 4 Aug 2026 10:52:03 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260804175203.GI3556460@frogsfrogsfrogs>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260804173548.GA13900@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804173548.GA13900@lst.de>
X-Headers-End: 1wrJJF-000893-2w
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Aug 04, 2026 at 07:35:48PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 03, 2026 at 10:07:50PM +0200, Andrey Albershteyn wrote:
> > This series based on v7.2-rc4 + lazy-bounce@hch-misc
> 
> Oh, I gave up my hopes to get this into 7.3 and was waiting for
> your series to land first.  Right now there is one outstanding issue
> I know of with the series, which is that we need to clear REQ_POLL
> for bounce buffer I/O, and of course the somewhat complex cross-tree
> depenencies.
> 
> I can try to get it rposted, although this week I'm travelling for
> two conferences, which doesn't help.
> 
> If you only need a few patches from that series and they are kinda
> localized to xfs, maybe you should just cherry pick those from
> my series and include them?

I hadn't noticed that this patchset had added even more patches and were
waiting for review, but cem told me this morning that he thinks it's too
late to put this into for-next for 7.3. :(

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
