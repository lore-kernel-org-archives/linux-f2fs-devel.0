Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBCEC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jun 2022 08:02:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nyqeA-0001Mw-Dt; Wed, 08 Jun 2022 08:02:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+ba9ae8ab3d8ecaf97ba4+6863+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nyqe8-0001Mf-GW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jun 2022 08:02:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SX9n5EnTUOKOzk0atnH01/6aCdLXi/kHksLRZ+/slrg=; b=Bb4UwXowKA3xbvKhip0bsToXdD
 S5/H5eYpcfn0V+FlnEFgVOcsyoIHiN/esWpjLEsd9epxo7AfJ9mMIszI6umXbi5dQy0ZvZ9T1sTXH
 1J0QOlh3BdcNbW9q/HpFajFhTJAr98kxr2F6NMcLj7k6ckTiB48IcPlQ1uwGka3vpoYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SX9n5EnTUOKOzk0atnH01/6aCdLXi/kHksLRZ+/slrg=; b=FABiMhGi3hntPlS3gKb+da0zJu
 mm2ntVkG77SeMbyAPIhfDZHfI351O4rCDTdpTDsSzzIvEKbU/0hOXWWDcYGHih+aQe342Crdik8lb
 /2MrZlEbJtM97kxqEYLUhzuiwYghQy2hMmObknc2PX4vP8IptAxmtrcLo1g1iSw3h6w8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nyqe5-009ZsU-E4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jun 2022 08:02:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SX9n5EnTUOKOzk0atnH01/6aCdLXi/kHksLRZ+/slrg=; b=jysUfxHITvm5qME5kby7gEknda
 NniSqrjlYB/5FZ0sOB9SGdPN609Xc7Tio/met/HczsNX9IUlMHrvgiUDv4mHlaFTvBucMZTcxWuFM
 aGqA9GeGAxtC3R6lF2w/B87y6Wk6GgZNyLeH3AxjbiUcPe9vcD+G8iLkjHXT78FVtD6XmTe1cYmlt
 ngowBhuCCZ4lWWbh04Jl3QN6dGjrZt3zoJA55lgwd6zmbPrMu2DmXkzmdU0CAIYcq9FAdHR+U6sjS
 kvj5dDbrm/lmbPQZoKx97x7Y9QNcHlDLf2o8pDHQXCZgt2fdrKxTBoK/16KCB/EAF4EZ/7y1pxpfD
 Fds+rOEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyqdy-00Bnx0-Jl; Wed, 08 Jun 2022 08:02:22 +0000
Date: Wed, 8 Jun 2022 01:02:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-ID: <YqBXjjkRZsP8K8fO@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
 <20220605193854.2371230-4-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220605193854.2371230-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nyqe5-009ZsU-E4
Subject: Re: [f2fs-dev] [PATCH 03/10] ext4: Convert
 mpage_release_unused_pages() to use filemap_get_folios()
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
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jun 05, 2022 at 08:38:47PM +0100, Matthew Wilcox (Oracle) wrote:
> If the folio is large, it may overlap the beginning or end of the
> unused range.  If it does, we need to avoid invalidating it.

It's never going to be larger for ext4, is it?  But either way,
those precautions looks fine.

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
