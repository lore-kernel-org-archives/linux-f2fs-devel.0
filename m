Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A189C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Dec 2022 01:02:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p5ce3-0006db-4y;
	Thu, 15 Dec 2022 01:02:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1p5ce2-0006dV-SE
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Dec 2022 01:02:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2hZEsN13y/8bZnrB9jYA5D4ySgxVLW/aBm8arKbj4gU=; b=CnNd0yGoEWtL52w6IU3Fcq7+2y
 68qPJjwHQEnVnu4z62vCdXDLsZciJvvrFit1QPLFq/1hHFO4RmlI14k04VMW1GZmBeVb1/QzCbidU
 FMC/Vh3+RLBjfCBEfhKMcgaMgs8v9ICLRCw9XvtCDsUGTyijQFwE6UBrUKdGSvkBYOkU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2hZEsN13y/8bZnrB9jYA5D4ySgxVLW/aBm8arKbj4gU=; b=gbd7moMVsPbUp6Ru+biRnmUZdm
 qN1KA6cYbQDm61VYfIF818i4F8GFNb3i8Ax6sEvD14cd020Rqjehe4WZDbLYL/fgZDuyYS7CaGIU0
 2wMzLyBfqTT3u9BAn9VSz6MHER5yXBv3nDAcnctn7F9pzVq34QqYf1SB1p881k8qlvZ0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p5cdy-0006SN-GC for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Dec 2022 01:02:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3592DB81A1D;
 Thu, 15 Dec 2022 01:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E8BC433D2;
 Thu, 15 Dec 2022 01:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671066150;
 bh=ivrb94vYVS+gIfedha8sVevcej0s4lDEau1h5sMruYE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AR96G7KitmMA5vn+pK0jWRb0vbPx/l/2nrc2Ai1cq9kSWAY5m6yV3QeM63klcPv8z
 NT6VjPoPNNGtc5+WejLZewgJul8OMOSAHrKt69nuxqnR6gGN8QC96Sys7JA0oJDvPk
 84PkLuWTVCrAZuaXHO9K3KV+SND6fLrkG21WlpCPzXH2pmXz577TG8Kah9N5rWYFyg
 FA3RxnsQifP3yKLXHaFpK/WCtlZyZOkwj4B0hC1Z4kl1vGCeKC489PY7j/FSwPiQXw
 zRj70NyzgNAm2WTIjZLo8NDgHaLGcK2vKkaYGMPQ1BAUkqjyk4SmB+BN1FTDyKtGlg
 WG/ekipvfnjrQ==
Date: Wed, 14 Dec 2022 17:02:29 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <Y5pyJQE9Vq1ylhXn@google.com>
References: <20221128091523.1242584-1-hch@lst.de>
 <20221128091523.1242584-13-hch@lst.de>
 <Y5fT4SQ9/vuZeWWB@google.com> <20221213055759.GC882@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221213055759.GC882@lst.de>
X-Headers-End: 1p5cdy-0006SN-GC
Subject: Re: [f2fs-dev] [PATCH 12/15] f2fs: remove the create argument to
 f2fs_map_blocks
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/13, Christoph Hellwig wrote:
> On Mon, Dec 12, 2022 at 05:22:41PM -0800, Jaegeuk Kim wrote:
> > >  	struct dnode_of_data dn;
> > > @@ -1484,11 +1483,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> > >  	pgofs =	(pgoff_t)map->m_lblk;
> > >  	end = pgofs + maxblocks;
> > >  
> > > -	if (!create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
> > > -		if (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
> > 
> > Any reason to remove this condition?
> > 
> > Thanks,
> > 
> > > -							map->m_may_create)
> 
> With "this condition" I guess you mean the:
> 
> 		if (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
> 							map->m_may_create)
> 			goto next_dnode;
> 
> ?
> 
> Now that the !create check above is replaced with !map->m_may_create
> above, it is dead code, as the map->m_may_create part of the conditions
> must be false.

Ah, I missed it. Thanks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
