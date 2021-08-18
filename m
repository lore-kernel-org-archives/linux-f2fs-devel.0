Return-Path: <SRS0=J76h=NJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCDFC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Aug 2021 14:08:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19B2610A1;
	Wed, 18 Aug 2021 14:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D19B2610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mGMFN-00085c-0k; Wed, 18 Aug 2021 14:08:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from
 <BATV+c26a8f31a710de91e748+6569+infradead.org+hch@casper.srs.infradead.org>)
 id 1mGMFL-00085V-Eu
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Aug 2021 14:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yEmhhB1jvlMk+IflLK9WtV0XYHIRBCbvIeJT+MHfw7Q=; b=eytDBdP1xNqUNFOPogz3BiR79J
 g6RwWZru+qg0B02If3Kbtp3qiMy25JKExhEC7Btmw7jD6irOiy33PTPPQKciBlXlTNgLdF/obB6OU
 GaRveQyaJVSOo3EtZHqvX/rSF8HET2mE39TZfPaCe1diovpklb+CXaG6mi0NhrvbIOqs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yEmhhB1jvlMk+IflLK9WtV0XYHIRBCbvIeJT+MHfw7Q=; b=G
 KIFxLmkrm6sHFXqCNqxevoELTNi+Go/tB4dJ4+6UhdSurnXQmPUPupr4APcq0yK+R1ylq9e2LBekN
 UNwEraGBZSnJp5XGpFx+WjupgT0JzCkhchZAVPxLNCChGnEIcfNLQLv/qh0v82Q5+wap9do6WI7O3
 wDJzCZ7gh32n/h3w=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mGMFJ-00AXGF-LC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Aug 2021 14:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=yEmhhB1jvlMk+IflLK9WtV0XYHIRBCbvIeJT+MHfw7Q=; b=kHUyFU9CA0Xl6U+YsBAlotnqUJ
 1yiunrwv7cuTCljhB7Ve416gZI2Yhc/e4tPtQ2XfRtrhFbE3AbBGiuotCFcz5W6nPAOjJP8Lo1lcg
 8gp+Z9zlPuxhrdTatJB+EAdXYDxqUKO+ORemikDZqnTO42gqXk8xovg0jDnhV35iJGagPJKw1S91j
 d84dOB7ZvekX156f0v+Tr2KhX24uOFbP0NErrYKfxktyuA5fRD9jCVuj1/Jqw+SADEnXv57Lcl55F
 BDtwpmzdAzYJ85ti4buBG6OYxiCiJuG/6VL/CmzFIiKt82kzEEP/EZcd4JLr4Dh2u+FUeEG38vJsx
 UUe8js9w==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGMDU-003uDx-SF; Wed, 18 Aug 2021 14:07:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Wed, 18 Aug 2021 16:06:40 +0200
Message-Id: <20210818140651.17181-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1mGMFJ-00AXGF-LC
Subject: [f2fs-dev] unicode cleanups,
 and split the data table into a separate module
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Shreeya Patel <shreeya.patel@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi all,

this series is an alternate idea to split the utf8 table into a separate
module.  It comes with a whole lot of cleanups preloaded.

Diffstat:
 fs/ext4/super.c               |   31 +---
 fs/f2fs/super.c               |   30 +---
 fs/f2fs/sysfs.c               |    3 
 fs/unicode/Kconfig            |   13 +-
 fs/unicode/Makefile           |   13 +-
 fs/unicode/mkutf8data.c       |   24 +++
 fs/unicode/utf8-core.c        |  105 ++++++----------
 fs/unicode/utf8-norm.c        |  262 +++++-------------------------------------
 fs/unicode/utf8-selftest.c    |   94 +++++++--------
 fs/unicode/utf8data.c_shipped |   22 ++-
 fs/unicode/utf8n.h            |   81 ++++--------
 include/linux/unicode.h       |   35 +++++
 12 files changed, 260 insertions(+), 453 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
