Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892B1C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Mar 2022 22:02:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nS4OT-0004Ou-S0; Wed, 09 Mar 2022 22:02:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nS4OS-0004Oo-HI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Mar 2022 22:02:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fiUIUUKXZYtgpqNQt7vaQxAVfaCeizGaisGY2Gk42U0=; b=MCPlqqF350p8eUgxLSVXmEUusX
 GYDg7XWOeCz3YRtjLCiiUCgbgHITY+/lCZVcSumtR0l4f1OOAB/NKHsDdXVpcxCXEUTthzwgk4Ubi
 FCxHtCzja5PVZtUvbX89h1cKZN6I0X9KQslafueoXbXDdYPfWD0y8gCWHbFawY7e7aec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fiUIUUKXZYtgpqNQt7vaQxAVfaCeizGaisGY2Gk42U0=; b=FBuRE4ZWkLtvnVWbM+ZONbQ4gK
 kIOthZV51Lzux9/XZvTE7zrQCXz8N4eDoHXEkYrGLcJsXz2DbKcXLgxTepbvANYFj9i5wGo9H4KnB
 uSGcLuxIbEOB1gHKWb3K0c9FobHHWdWjKhs8dRRUtjUQRjizRGjj7q0FkjePXxtfFjJE=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nS4OM-0002ZI-Sp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Mar 2022 22:02:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 99AD9B823DD;
 Wed,  9 Mar 2022 22:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1F4C340F9;
 Wed,  9 Mar 2022 22:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646863360;
 bh=54nrL5lVac8LjdxWYEk3XM1hS8aXwfsY4Gwc979sn2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LKxn4zeRbr8UReEWIs2MYfw36rLOgozvWXOp+NyjCvgHv+6MgLd1YGuSBvie5u8n9
 8UFrc1/Yr4WuhBQw65VLb0k0trc19wx7IDDU7x8i1W9RBtPJ5mSpIM7k5ZqX8FpK9L
 SSPKSJtG7oU06ExTFuxO3mvuZ8z8K/XsmypaqOy9TJDNhRdCD3km82TXlM0cn68M43
 aQuPnms6ZQFLs6qA4DkK8XTLIK3pIP3cCAlF5fmBAjuc2S5HQvfL4iirvKkljeWEr3
 MUX1ip+SySLMxSrrou31D1w7JEP1A9YYB9Wmv5Edi3zGx+O73hHAefG95eEerCAuxp
 C2Fn768+zpwrw==
Date: Wed, 9 Mar 2022 14:02:38 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Yikj/k/59no8yyLQ@google.com>
References: <20220228124123.856027-1-hch@lst.de>
 <20220228124123.856027-3-hch@lst.de>
 <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
X-Headers-End: 1nS4OM-0002ZI-Sp
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: pass the bio operation to
 bio_alloc_bioset
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/01, Chao Yu wrote:
> On 2022/2/28 20:41, Christoph Hellwig wrote:
> > Refactor block I/O code so that the bio operation and known flags are set
> > at bio allocation time.  Only the later updated flags are updated on the
> > fly.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
