Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504DBCA9ED1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8qfyoSPyPfjE0jCCqLhRQvm/sqiAGHIjfAWqfboNlU=; b=PIP4cluoyAMx5ETUR/ObkEY2qL
	uEHfvm7zbycfpfHq9v44Mu4+Xoxu1kvb5nTYYzAoXn8AgYuJGsF8cxEDVf3v2zA4QdKcinzjxzxyR
	FqrPdghBMKmikLnsQ/FFuMwJ3OI1WGR8sMeWtv+BZcf0YMuEwJ3Lmi17QS8D4dx7rJ3Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGFEB-0008P4-SX;
	Mon, 12 Oct 2026 12:34:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+d28fe39275f265348780+8450+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1xGFE9-0008Ol-Mo for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 12:33:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=H579YX4W+RZnwx5eL+Be5scAWk
 gBdpGb7E+mnMErLlkTgeEb1UUzz9sIYOpZDm5ILUzwrkuXxJGRgk94y1ibeIeVoOt8Yg7gYthH9Xm
 IwFEWv+88rRZddYV4snMN2pSQ9utGIE398gWFjEOx5W53mmQ9HQ6/oSXAwBizFR2MWuk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iYXzvO0Sn2/8DF/dACCqNf+ahm
 cs0P4J3MnP31LZo7Sh2SZr/6voPxRgbGoHn80nhRep5FvTTxk7ViWfO5q4t8ElXSfJZvmccfXpsUI
 JixAF96gx/Zabu9Vm96QuHain//24lNDeyc0qSU1uxjuz8aGJxnL37Bd3qalqUItYR7k=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGFE0-0003SS-V4 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 12:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aSSwnFEscTp+TeLHHzoiqEeZ5o
 24qRo0EB50XUqg7KHn1Ohbk2ZS1JezjCSGcikB3RVVmycqHhKtDZky5Efap65d9h6ppEtpuIVkumH
 mekhi5BusSEqsm/YmJSXgvEz4lQ5QVmxfWjJZgwEIBPPruH4nRy3Q0fXZp1Kq0clYu4GoscOehIgm
 woew97L0VJ1yI3ZI6m/8rA93pQTwopXVVAwDTBjeFHJiroKKHfNTIAS5ZWT+H2+TOuYtR7cMIG6tS
 SqAxjs//ghhTPfu7TKGlpowcCSNHWrr6zhhxpnKPL0XUuzXhsKen7mx6uMJT6UXn+hh2FpAFZzRdI
 p42LbEiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1xGFDv-0000000ASpp-0VWX;
 Mon, 12 Oct 2026 12:33:47 +0000
Date: Mon, 12 Oct 2026 05:33:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Message-ID: <aszTqzApi84puqT0@infradead.org>
References: <20261009085544.2450966-1-jprusakowski@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261009085544.2450966-1-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1xGFE0-0003SS-V4
Subject: Re: [f2fs-dev] [PATCH v2] generic/622: increase sleep time for
 lazytime expiration
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
