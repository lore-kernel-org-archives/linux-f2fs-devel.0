Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC715C3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Aug 2024 04:37:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1seoi6-0007ug-C9;
	Fri, 16 Aug 2024 04:37:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e28816062944b636f5b1+7663+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1seohz-0007uV-Hx for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 04:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ibDQ1rVjfHGw/RnvN70yiErIZY
 /FObRpa+FuAHNihlnzo2QgW2ds9NN/A5iH5/hl0OftSDFxF8vysWKwaPK8vLyMJFYnG1UNl6Mmswe
 lOvGInoKZDcX/F/F/bqHkSzPM4rmrpD1Tt0HlgVon5wRzLBxkCKv8FP1C3ogj5gCXZCs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=N+0gz8k63i8QFQ8pQL5gwu9tBR
 HzfOczd3+4hnqFDj8tHk0INInVaMHkHtVzF3ieHa0q/pAhqmQBL6RqBQqOBWeibHTOYcjeWcLY7WI
 q79hlxV4HYa3XHTfm1zZvTvNiLf6XTK8t9tmXYIyuX5/NWtcUtRJfQzRSbTTCctHAH3c=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1seohy-0000XQ-Cr for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 04:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=paX6q5qqg9wcQ4CQy6sGb3UsE4
 wRq8bgDj6NIKYS5QojMDdVeV9JgmtBVYKX5SidRybriylLRktUj95TF9hcnJO9rdUW+Y9Y7QdV6Yk
 ORmtHo8gHHVyuTtpkfRW4W2u4t0wyPDOl6CmNta9E1AwvwG9F5RbHRrIQOdt+fdsUoexEGpd9jFir
 MpnTxNatWUdWbUWLoBokFMutSP1qQd1mZRb+vODs/zQnDZoXCVxezEkXYawNXUjyIZXMlR9hWQHgQ
 G7/QYx10XNvWkZg2m1jEw876rII9QydQ43iaoJkmaHDD2lhpd+3cxMwQ/q+pTfukg8ujsDPNiiij6
 hj26f+Ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1seohs-0000000Bmlp-2Rb0;
 Fri, 16 Aug 2024 04:36:56 +0000
Date: Thu, 15 Aug 2024 21:36:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Message-ID: <Zr7XaCM4WstvTrTz@infradead.org>
References: <20240816040703.736887-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240816040703.736887-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1seohy-0000XQ-Cr
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: check discard support for
 conventional zones
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
Cc: Christoph Hellwig <hch@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
