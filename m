Return-Path: <SRS0=hT/8=4M=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF79C38BFA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:32:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285AE218AC;
	Mon, 24 Feb 2020 21:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WMz2Lqa/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="VjiLOG3i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="faavxfwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285AE218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j6LLH-0000Ph-Ml; Mon, 24 Feb 2020 21:32:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+fd4c774fa746ae91f5d1+6028+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j6LLF-0000PU-VL
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Feb 2020 21:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=emtDgV24Eo0XKJNO3XWaY50cgCvPe4AajCupipZ+mFM=; b=WMz2Lqa/lghmFFwEHvDq2aCvW9
 j/ecITQ4wL0zw/PrEoahWTyrwZl2itUR8AsM85AwkJUSokKTkTjzzbIvCVChi/WRzCWQj1c/7jQne
 ukbn2PCN5Mro03b2eSlY19RXhJ6mj3EhNlyd8vqhpDt6CFtrBkX0aGebc/kG/j65B6fQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=emtDgV24Eo0XKJNO3XWaY50cgCvPe4AajCupipZ+mFM=; b=VjiLOG3iFdISecOBYBzlyR5SrF
 qUPrggvKpBwyQX1/q9BXL4WqtM2UshaXRUbQ6OIjEH/Vm0mkO8cJVEYXNr5LBvMsCSeomH9MWYwBD
 Uarrym1ORzc4f5jkybfEqFqyIBvxd8UPs4mx3tpi+5WKWJYI6NgUrNb4Ol5IYndP6TxE=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j6LLC-008yJ3-Ll
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Feb 2020 21:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=emtDgV24Eo0XKJNO3XWaY50cgCvPe4AajCupipZ+mFM=; b=faavxfwYgJ6BV4aMG0yBGMTdvs
 FIHOEugMta99lUrJ1bnzTZ/FRNYp6SPEABIaJ5EtGCi+eQP8a0kjK0ZbLdgXYa/37U/swNDVC13km
 Va5rLvps0hefygpoSkbchuXiH08P6MV/rAg7EcSCaaM7QZSEw0JsM/CNamhza4du/dvIO9YVBTlnB
 RoHdf0GoNG+qOIjDajjFjogi72piGjB1CilX1d9marpYm2pZ/fzynRHB+WFG63bofIN3ZLXSOH6JY
 ttUElXB1HnhGmHknkGtgPrvb11HJuWiiU/SslxTdDxTUKWpXvJpAQegm1IrAR6sPxW+YVNdZRQbOd
 Gj+d14cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6LKu-0003kl-Dd; Mon, 24 Feb 2020 21:32:20 +0000
Date: Mon, 24 Feb 2020 13:32:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200224213220.GA13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j6LLC-008yJ3-Ll
Subject: Re: [f2fs-dev] [PATCH v7 01/24] mm: Move readahead prototypes from
 mm.h
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

On Wed, Feb 19, 2020 at 01:00:40PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The readahead code is part of the page cache so should be found in the
> pagemap.h file.  force_page_cache_readahead is only used within mm,
> so move it to mm/internal.h instead.  Remove the parameter names where
> they add no value, and rename the ones which were actively misleading.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
