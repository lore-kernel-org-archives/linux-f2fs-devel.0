Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD5F107636D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BjLOPR3TGwL7pjCEj1bhinMEd1dNmkRg9iYz6e1fvp4=; b=WtxplFqv2OX4wxoZIbZxxTEPaa
	kP3CQ7XGkfdFo71rpfr4jkAOL1ILSoP5SNCvBuWFs7Ewhwc8SC8aPLI1dYy5x4iCpbrL/lmYWLksC
	lA7j9g2J3FYOtuPUbidbEWRhGdQmw/TH4XuizBBslUWGG0/xCjqTdv1bwEznwt1aoFsU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7p47-0007g6-JH;
	Wed, 01 Apr 2026 06:28:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w7p45-0007fo-Th
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X7kqXBDXF+JPX/cT4o98/EYl2Ewhuc2Jfg1srSNvojM=; b=CIBp4rgJrRnJ6KaEVYyrNI8Qr1
 +CuEJzc9imrBJOJTf1Z0Ei1HK7i2F7yAhq+3CJshYoVsaewZ5BgdScGbGjdAmunpbIT32hBg8rk/x
 nR0wY8XRqFCkOfqOu1cbLREw9JP24gJ0IvmxKqNALFXfr67e38G81lUwsZQqnkQNK6Z8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X7kqXBDXF+JPX/cT4o98/EYl2Ewhuc2Jfg1srSNvojM=; b=CfMXVoAOpCVdUosNb1Hvlxn8/B
 oTR/mlUFg/kCKLr2h1aI2l6Y4kyWeLcDR/dRHULbssReY1wTCnmd3JbUnvvjHiXasTlJBJooMZcPC
 izGQhyC6tKWdwAgyI8aOZucQRVgLMVNzWln2YULPp6SC4HOoEbrO07vKjmqy0k/46VWw=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7p46-0000c1-8g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:28:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1E16468AFE; Wed,  1 Apr 2026 08:28:27 +0200 (CEST)
Date: Wed, 1 Apr 2026 08:28:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260401062826.GB24459@lst.de>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-7-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-7-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w7p46-0000c1-8g
Subject: Re: [f2fs-dev] [PATCH v6 06/22] iomap: introduce IOMAP_F_FSVERITY
 and teach writeback to handle fsverity
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
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> +	/*
> +	 * fsverity metadata is stored past i_size, we need to read it instead of

Overly long line.

Otherwise looks good.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
