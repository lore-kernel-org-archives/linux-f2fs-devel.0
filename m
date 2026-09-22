Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FD5C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZV7k6Q+BC3uoDncDuQDSB7stAX+0dwlbuAwVe/trhU=; b=Ge5U4sD8kh+RCGCk+WiFFi58Ll
	aVHQBtNWoOTYrT1O3uZrg9xM3deBZPSWX59+1vzQiXgjjkndKHQSwcCtwf7RGH5Y7JwF/V2/652WD
	gtSGLrF0xT3ACsf84wMyaT4u/yhbbUbMWf0pyTJ5H/c7qv0H7XiFArAr6MqvvO2U8OUM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8ujY-0006sU-EO;
	Tue, 22 Sep 2026 07:16:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+a4e1fe537d2c1e8d4400+8430+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1x8ujE-0006rF-Ax for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 07:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PLrBUdYaBS0OotZ3Q1WVCL0MGnoMFhhmmfO07iCfEQM=; b=SRtciBtZIZYNCul5MBMFr3Q4ie
 XvZEnJSV7g8QPXuH+loeXkx1rN/u4qGl5I3Ef3oQNgTtttp8ZFAUas2XSBpq0cpib/AiCQgabMCZj
 dzMoD9Or+kcdXVrdLt5jxY+mAdmH4DPfPURE04nyBgKoKMpnTgv9K6vKdwnjSzRgpU9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PLrBUdYaBS0OotZ3Q1WVCL0MGnoMFhhmmfO07iCfEQM=; b=AGhTHDUIi3eKdZm3YGLMfTmKOj
 PI30emZlmDlI6VAV9rqLB9husfL0onc1eZxigceNDB3naegIpD7ICVwGDJY/E7J8ShfqeutHQ8mZH
 T3r2patAHydgvLtmN9TtCZEekwBc4FChpGxj3N6YO9A8JTN3OKT2Xa5aFK437VWUahxU=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8ujD-0003H3-5q for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 07:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PLrBUdYaBS0OotZ3Q1WVCL0MGnoMFhhmmfO07iCfEQM=; b=yzYmUF4lTr7WORXAoGiIFoEZh3
 aV4JtMaY9XStjqr3jAExeKtko7blJ7VLCfXbIQboEGtnpowxV2fUyrbI3Q/Uc5Ro1+rT2WMkhHoim
 pPakcuUs2aurFN65Ezf9KS/yNpfrpL0/w6sC4dyhlHCkqKkxGuwANcmuQCJcW4/0+RhxcoYPf87Y/
 MmEMQRD9iyK0O68i/LbUKfmL9urNLnDN5STIEv6O3fQSjY3/3gjZGic/Q/sw73KGnILqbEdw7N2Jy
 WdZ3ozGiUkj4X9nltkrSHPNUv7oYyhM0QcoqTrXPfgDpLrckjyTp4Ig7fJqoYc8aU3c7SVXONuLPU
 tr4nhJ8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1x8uj7-00000004Tuk-1iOI;
 Tue, 22 Sep 2026 07:15:41 +0000
Date: Tue, 22 Sep 2026 00:15:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <arIrHUj9SMUW6WSD@infradead.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-12-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918111539.1003439-12-aalbersh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1x8ujD-0003H3-5q
Subject: Re: [f2fs-dev] [PATCH v16 11/21] xfs: handle fsverity I/O in
 write/read path
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
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 18, 2026 at 01:15:23PM +0200, Andrey Albershteyn wrote:
> For write/writeback set IOMAP_F_FSVERITY flag telling iomap to not
> update inode size and to not skip folios beyond EOF.
> 
> Initiate fsverity writeback with IOMAP_F_FSVERITY set to tell iomap
> should not skip folio that is dirty beyond EOF.
> 
> In read path let iomap know that we are reading fsverity metadata. So,
> treat holes in the tree as request to synthesize tree blocks and hole
> after descriptor as end of the fsverity region.
> 
> Introduce a new inode flag meaning that merkle tree is being build on
> the inode.

Sashiko had some comments on this that did not sound entirely stupid
to me.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
