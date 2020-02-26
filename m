Return-Path: <SRS0=pqVX=4O=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B21C4BA18
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:01:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43892467F;
	Wed, 26 Feb 2020 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VdExyUeN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NkdSZv8l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b4gRu9Om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43892467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j703y-00089T-4X; Wed, 26 Feb 2020 17:01:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+7931773228f1d9803703+6030+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j703x-00089I-7j
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Feb 2020 17:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hhQ9YBl81zQvhfWadY0dEbDydMLxnfW9YM0h14jX4a0=; b=VdExyUeN486OwmVwUVbLEk8iHs
 7pQOzoBH4zD2/SeklmQLZ7+o5HG0Gzn8PtiFhcDts7Vwv4g6m7E0iLOQ0ytm0sfdni339WQapSiNZ
 ePZeanayNiKg9t3bAHEpYp69jIfSpVR841o7yOCdGqLKH93HurEvddOztMmXQid4zEhY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hhQ9YBl81zQvhfWadY0dEbDydMLxnfW9YM0h14jX4a0=; b=NkdSZv8liclA5R5tZZkBMm0y3R
 ErzIiAlS6McFJw9Sb469a8uCfYzBPDlcnNFOOf22M+kYEXb1Va7jfKimpGzIum0PIwxOnt+iO2KYM
 BDbPy+XuNTPFCcpByzsdgGQORgiTllSU5Y8bg7LPEM9pGhXo99Fd4n+al/8DshqMW0dY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j703s-00HDPE-Sx
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Feb 2020 17:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hhQ9YBl81zQvhfWadY0dEbDydMLxnfW9YM0h14jX4a0=; b=b4gRu9OmDpOpG4+91cUD2P0Fvx
 rwIA1FZxWgyqg54ixZ2mlE7je+4s02JEfApEECCDtBJZOsOCCCQypvdX4wlnpTzyq3GzniYslygSp
 0JLM3hJczJhHf6sPZnzEVoXaF0BjXMr7Sau/bOjj78BwbTBoLYT0As4XBg3LZA4cCSraqX2yl635x
 P0GeGjaSAjr/yoe31Xsg5u1v6aDOjH3+k/QDvhsXylJIuy7m6nJ0VChbG4oj9ux1VoZSn++eE6CLS
 nvwJVc8B+ap1PhLLk3dgexnb7LCihqx+unp7n6RFCEuxFFJLK99PLd8EgLQxWjGh2LTvEZCdFHFm2
 mjT6Qmyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j703j-0006LS-7W; Wed, 26 Feb 2020 17:01:19 +0000
Date: Wed, 26 Feb 2020 09:01:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200226170119.GA22837@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200225214838.30017-6-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200225214838.30017-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j703s-00HDPE-Sx
Subject: Re: [f2fs-dev] [PATCH v8 05/25] mm: Add new readahead_control API
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

On Tue, Feb 25, 2020 at 01:48:18PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Filesystems which implement the upcoming ->readahead method will get
> their pages by calling readahead_page() or readahead_page_batch().
> These functions support large pages, even though none of the filesystems
> to be converted do yet.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
