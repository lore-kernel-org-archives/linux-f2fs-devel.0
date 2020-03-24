Return-Path: <SRS0=nR8U=5J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BD1C4332B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:41:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5251B20724;
	Tue, 24 Mar 2020 08:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ivTKfwRz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="IpA12S7r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FvZ8B03F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5251B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jGf7O-0005fj-TP; Tue, 24 Mar 2020 08:41:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+5af6361f56b5afa65be5+6057+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jGf7L-0005fP-Qr
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 08:40:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yann1UJ6E2VSa2Ey9do+WcXl7l36OBhp3PfHyqllino=; b=ivTKfwRzWgObOU0Xke7+tYrlT7
 pBtELjPtRlTMJqUO8QoK5iOi5EdnZft060rxBnsbc1DNilLj0UFlmr4As5Q0tutN+8O8rEna0NyHG
 yOrkeruL2+xaaKAfiWbVKhAnGpyaEPnx9UNasHlkAavy/mpd2uf6v1um1J/NDSL1GbOM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yann1UJ6E2VSa2Ey9do+WcXl7l36OBhp3PfHyqllino=; b=IpA12S7rDec+CVlgUl9b11w7BK
 LqNYaBkbvzwiw663nq+MltnoingeSfzRM+4+M8/Mo8XG4n8LW90vyuIZMWupU6qNfHeXKy6B8yz0t
 UQveKEQ4bgS2TVL8XgRapxsW5meIrHSWw5ryTXcmUKjIiqbnx5Wh7/3DrrTT9xDDVaLk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jGf7J-005TpB-Cg
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 08:40:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yann1UJ6E2VSa2Ey9do+WcXl7l36OBhp3PfHyqllino=; b=FvZ8B03FLHuCWauhakrJWvuqXJ
 IAzx6qcf0+KoM/Z+p0yevvoMHHcWXQd9G+DAEZNcSZ1PohZsfWqg7Rw8JYFMdxVa2hk3Aua7cWVy9
 bj2fR+gtIJvIcSYNs5397dHwzgh2FBbNb56PWa6jkU1Iw3oKPx/J3WQxg55XrNsblo0PVJ12GyJSa
 BmA06eJTfdo1vrvDdR2Og9lyQs8H2LUK6mI6Q4WkVyMDVlKZCnd7wev6oDgUbb9yMva78kGzeBNfN
 c1CvGrF4NltPJwnVGtyzRY9Rzval5a35nIeyFwo3yMb4VctCeyII/9pxOThd+SaREhiuXiK4wmjej
 8zONTRrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jGf7B-0003Xw-12; Tue, 24 Mar 2020 08:40:49 +0000
Date: Tue, 24 Mar 2020 01:40:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200324084049.GB32036@infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-13-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200323202259.13363-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1jGf7J-005TpB-Cg
Subject: Re: [f2fs-dev] [PATCH v10 12/25] mm: Move end_index check out of
 readahead loop
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
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Mar 23, 2020 at 01:22:46PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By reducing nr_to_read, we can eliminate this check from inside the loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
