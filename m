Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1E1C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7salsjy6fFR1IdprTTiBWemtDT0NblJDqcpCFx3q3Sc=; b=iUVeEc6wavm0ZmBfiIfuSUFyUd
	ciJczzbH7q0pxkI0AylfdXsuBL3iPJM1VbH/JbtBwj3C1m9EvE2ip/q7C6PaQLJNqFoQj63AlbG1M
	i8rBbEnYkeWO2Z30pVHhp6jT2CGT+h3/ywqeP/YgMes4KTmVm0MNpZJH8gBnbYq077xM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnI1a-0002Dp-Bz;
	Fri, 24 Jul 2026 15:41:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wnI1Z-0002Dh-6c
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ulYgcPH4KCD1Nt9v5XEq1cRiuB72GnC/7rI9njxX6xw=; b=CPaJ5SE5IE78SLbDNnxqhxBBPw
 mGgkj4Pi9eIKfaCFu3OtdUnC4Pnu2crVCYmQeOsiJO7NmIq8K/1u6Unyfha/uvJTUxIZOZPreX5Zt
 Y+JgsH5Pa+t1deuHMmCdsIF08k5P8WCqqYSc2XsQiD1nH6v4QGXmrvktB7yZS/HQKWCw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ulYgcPH4KCD1Nt9v5XEq1cRiuB72GnC/7rI9njxX6xw=; b=jDqSOcS7xze2I+OcwRwkqnQnjs
 yhrBw98D+C2wc1sVvzzefmuMfMk4mM2E2LFAwjPY9NUyIVYmo/9cK6vyx0xUwoTfOFtS1drSmlZ2G
 WdtIyZX1QZci5DxCTYrEsSE3mTbblB9E9lw5Gbqbl1Doz1EGDIXJxhBm5wSz+3yYuRpo=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnI1b-0004kk-9G for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9823968BEB; Fri, 24 Jul 2026 15:13:53 +0200 (CEST)
Date: Fri, 24 Jul 2026 15:13:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260724131353.GB27878@lst.de>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-7-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721184346.416657-7-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wnI1b-0004kk-9G
Subject: Re: [f2fs-dev] [PATCH v13 06/23] fsverity: don't allow setting DAX
 file attribute on fsverity files
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Shouldn't this have a fixes tag and go into -stable as well as it already
affects ext4?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
