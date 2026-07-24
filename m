Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA05C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0br3WpHphIXM/6XdcUc+udsKjwl1JENwF6gqF1VDiME=; b=OHX+QhIZ7xY/+fMYrwd9xrsZJr
	VL0WQoy/7i2CRyBjZmxPCIzPHSyYrgdTs8IQg5em2Kuv2dcXVBdaq8zwd0Mpah9GfYoPN+NU+A7j3
	NURpmQeQFWakzE4LAB3A0YJPLvbHXHzXRzmrjRI+mZQyXjRfRlKFyn0RsvjU3XVjZ068=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnI1Z-0006ej-Fc;
	Fri, 24 Jul 2026 15:41:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wnI1Y-0006eb-FZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xiBePRu5pAxh3mf+wgKwHiXWgeATkzN4gVVwbCFjwOw=; b=K9Smmkzvr/dFdO8RXbeJdKRHSh
 KXir8DC0xl+f/bqrXXLaaLIUzFAo80kXdr50E0wOp/mgnWI5xIogiiJe+V9LvV9iQsjxVf0k+k+w0
 W+XXjw2A+4IsTEAYeZRTvg08q/piCwt+Z38+s4cPqpl03NIAiCab6GssoBTxy/PygaK4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xiBePRu5pAxh3mf+wgKwHiXWgeATkzN4gVVwbCFjwOw=; b=HhzCmmE/DnLTk88szn0O3IgWkv
 yNtEV8XdJ3Aw7XfRfBqhnrt1BOgjAjXusF0C605JHzUnS0K7fUjKfX1NMrhBHSNFvqZ6XbMocXzbq
 Vb3cU1h8GTa+9yj8VdGjnHl/M9QzvpvjnpjNErwPghzkV6BDvBDKkZYuRL1rCnkOL2jg=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnI1X-00081V-Ha for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5216C68AFE; Fri, 24 Jul 2026 15:13:10 +0200 (CEST)
Date: Fri, 24 Jul 2026 15:13:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260724131309.GA27878@lst.de>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-6-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721184346.416657-6-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wnI1X-00081V-Ha
Subject: Re: [f2fs-dev] [PATCH v13 05/23] fsverity: improve flushing
 performance of fsverity_fill_zerohash
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

On Tue, Jul 21, 2026 at 08:40:42PM +0200, Andrey Albershteyn wrote:
> The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
> flush whole folio on every digest (which is 128 for 4k). Open code folio
> mapping and flushing to copy all digests at once.

What is the point of this?  flush_dcache_folio is a no-op on sane
architectures, and this should not be a performance path, so
avoiding all the kmap logic does seem benefitial.  Or at least only
opencode it for !highmem to avoid the worst part.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
