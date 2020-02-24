Return-Path: <SRS0=hT/8=4M=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578ADC38BFF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B1F2176D;
	Mon, 24 Feb 2020 21:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="gfuVX/Xd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dPH3F4SD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="igQ0lGMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B1F2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j6LUB-0000oj-OF; Mon, 24 Feb 2020 21:41:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+fd4c774fa746ae91f5d1+6028+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j6LUA-0000ob-Bj
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Feb 2020 21:41:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NvJp7tTodaVHCZTEDiIj+yawWDduVL3Oct69ajAcLic=; b=gfuVX/XdqMlIa8ShaPcSYzkUSU
 KqBeA36HkMEMgK+ev8Ri7DC4HO9oyKt5k2Q+cmWTsY6jnjd3B0cxtJPuMvyA2HrdijpiYd1Xror2B
 uJdMD6tFGRrQSDhvsGx2SoHTkQ/BKveuN1CRXmfpK1ncI8WSNIJkXG+kU2WvMfMP03Bo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NvJp7tTodaVHCZTEDiIj+yawWDduVL3Oct69ajAcLic=; b=dPH3F4SDMtcEKS0z/Lmt1jxpTk
 mqmRHDA2wS/KnXh6/CDI9MrF5cP21f1A8sopDU2yHN50vUj9Rsr9zd7LrWow/Pk2dp3SYsw2EQbn9
 rTnvW0OhxnXCHlTnFAwyuSxSE0MLWVYp+VwQVZFP4DpIyLncv9i+vNQcMyAZGhj6e/J4=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j6LU8-00FRr7-Bj
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Feb 2020 21:41:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NvJp7tTodaVHCZTEDiIj+yawWDduVL3Oct69ajAcLic=; b=igQ0lGMGn8KdLvHIbVPzsUeKgG
 j10MnNZMuq6fJKQv0MSVMg+Y/0gN9OgLzE7u9neWDTcLC9mCS/LiX246FGoWpmJbXSwegQgcBjLdz
 Nq2o1N+9I6tazK/m7Q+iUOpOFQC5u31Jr4q1tpXtMSrfjarKH1or/of3lwGNKGFGGmfUhoaO/xPni
 DbhCdWHHlwIkwP0z1vHfOioVeL34vwJvtBGTOWey9/IAzoY4g2jfskQNrhQAq5UlyQR6bBY+vr+U7
 eSTr5r0V4JFmSHrHc92QOQOikws4qtL6e6cfeY76efaL2sTg5s8ZwJ7y4F6h4+ALSsJfavSgqAWxq
 YsGLY/Ng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6LU1-0007Zo-K2; Mon, 24 Feb 2020 21:41:45 +0000
Date: Mon, 24 Feb 2020 13:41:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200224214145.GG13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-11-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j6LU8-00FRr7-Bj
Subject: Re: [f2fs-dev] [PATCH v7 10/24] mm: Add readahead address space
 operation
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks fine modulo the little data type issue:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
