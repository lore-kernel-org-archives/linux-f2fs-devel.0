Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731EBC46467
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Jan 2023 06:36:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pIOXb-0005fP-Ec;
	Thu, 19 Jan 2023 06:36:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+d6c99cb0ec1a2cfa7d20+7088+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1pIOXX-0005f9-CZ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Jan 2023 06:36:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kqicywbb2ylDIOysSV+FTdsGBxdEr4BTDs5EW1RRoQI=; b=PK6QdWW/c/6+muHMBLS1qCtiKq
 xr5B90Hn1RU/NRhjXCNRDEv6cQkyRDG2m9ShSUnUYoVxG7jDGHnGrZcXV8crNQUXmETMApgW6aciA
 2wB4pRbRXSq4GyhD7qQys1RU0186+nIn6PYaqsXZsp5v8J7hGl7ug2R06pQbY7deKOqg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Kqicywbb2ylDIOysSV+FTdsGBxdEr4BTDs5EW1RRoQI=; b=P
 x2RJWN03TDaBiDSXjY1dnMNcoS4jdavs1+xZ+U4kfHNl+7LbbKfG+gf8QeJcNNLQeGOZ3xTXV2qt5
 8/DZVbaq152q01RuShOpOJhvMHhf9DaqrJb47IJ487Gbk8M9YXpOIFwtcUwo+diXVu4diyulB/pp0
 EpHQnJLVE1pDZ2x8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pIOXT-0001dP-3z for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Jan 2023 06:36:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=Kqicywbb2ylDIOysSV+FTdsGBxdEr4BTDs5EW1RRoQI=; b=iX8qqZ2Uyy9XhU0iOcEEkoSgiN
 GJqiz2KNPhI2mVNrVgV3lVW4LqW9rM8jcxvv3OlJYq0fXm68IsTIHJWkgV66QGcFGH8AFBm+b5VxC
 I66ZLHYW2JLDGmj7v87ROxgHs0ru4iAGvfpO1imX8ppqoxM4aF6oHlHxklaZEfYkqLwqQSTLccI7o
 eljSWBz8RDS6WdEnpGwRE5desK29UnYcZtRsLHIyCaqUBY7YmFm7jAW1YuUeE1w9kbEaR14ktQmz8
 QlLSFT60qWnRsg72p66kbsg/WM0giQKz093D32dBYFSSQMDNYKM80SMVhsrCtCpsUwpmiZI6foWX4
 pTTdMD/A==;
Received: from [2001:4bb8:19a:2039:96fe:c1ec:dda2:41a3] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pIOXD-003ka9-Tt; Thu, 19 Jan 2023 06:36:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu, 19 Jan 2023 07:36:17 +0100
Message-Id: <20230119063625.466485-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1pIOXT-0001dP-3z
Subject: [f2fs-dev] misc f2fs cleanups
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

Hi all,

a bunch of random cleanups found by code inspection.

Diffstat:
 checkpoint.c |   22 ++++-----
 file.c       |   60 +++++++++++---------------
 segment.c    |  134 +++++++++++++++++++++--------------------------------------
 segment.h    |    6 --
 4 files changed, 84 insertions(+), 138 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
