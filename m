Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87957F43848
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmU2SvRUy/JvsPOy5APE9iz4/0kQuGXGO8YP8IJzF7E=; b=kCldBIIhSuaW0z2aVrv4DU7RYA
	ATLJhSuFO+boo6bEDQKswrk+/BZ8uWNbxMjfCT9JtPZKx+ukDn0ybVI96UZWdSlqNaB9FG/W0U0Sf
	ySsCo8s064L6mX19zWNrgB04GbGdiQgOAVZorN4TRgdjFf5jzJbhmSi8NwAi+cGc/59g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wD3qR-0002aZ-Rs;
	Wed, 15 Apr 2026 17:16:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wD3qO-0002aQ-Ac
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 17:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ISsLIKP4bjUxgr4BYttgZs8l+uxApeegxanE10R4kzc=; b=iRaw2LjtlulN/9hl9CMf/Ad5gh
 spWj1mvYWbk3L39G9SiydNB71XbiOd+qg5M6OOfir/Kk0pFtGuSkGEXyZ+8ft8L/mhalU5Ier/oSL
 PZ6cktGTPFW+2KWBWTFuG92r8evyQdhefH2h0Z4plcYb+yh5ExhDBu5vuPYu2gnxYTvU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ISsLIKP4bjUxgr4BYttgZs8l+uxApeegxanE10R4kzc=; b=QuQM0ej84F4s4XApvAEgKehMdH
 +euYIakY5qZ4CiQRILVnn9FU9r0K7bLvEOIL21P1cbq5/Sx/rHxhKZuJBTNK5YgwkSEAVqnptR9pE
 fxTQT4PbrVuFaippgMppf1uK6JqoWLf3GTpZlGvJlqFGx3zpylYWR33exAX6lxiNTGaM=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wD3qK-0003Bz-Ie for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 17:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ISsLIKP4bjUxgr4BYttgZs8l+uxApeegxanE10R4kzc=; b=Y/qzKwPC6h8YPlkBZrqWGNfOS9
 5WTrl/NWtmNx2pAqg9rGoNGsdTZbyEoa/UdSYzqUEldGyhWm8V4whdF3OLQUdwLt1eP0fAqmfrL65
 l7Q9dYGb5zIuRdxB3tfwHPxFpEPav9jk3SBFyrVHZsZThn+Lqx9KMem0N9hpLf2rGAPTEH0wvPUNi
 ZqKitex3Q//ilsBhw/U9xr7IxjJotzWolQkSg5uCdBphNeGYZqWaegBkJggGzOJsoSMz0hnvCY4wB
 6cxYIv8YOCP6BT8rt/FLq2pRni5qxu/xDz8E6P7NMiDThQbpryw/4ujK93ThvoueCSWF0CapbVOu5
 49KLzwaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1wD3q6-00000000CP7-1hCw;
 Wed, 15 Apr 2026 17:15:46 +0000
Date: Wed, 15 Apr 2026 18:15:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ad_HwhzlNPUEKQi6@casper.infradead.org>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad_AVHe7RMnGrGTb@google.com>
X-Headers-End: 1wD3qK-0003Bz-Ie
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Akilesh Kailash <akailash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 15, 2026 at 04:44:04PM +0000, Jaegeuk Kim wrote:
> On 04/14, Christoph Hellwig wrote:
> > Please add the relevant mailing lists when adding new user interfaces.
> > 
> > And I'm not sure hacks working around the proper large folio
> > implementation are something that should be merged upstream.
> 
> Cc'ed linux-api and linux-fsdevel onto the patch thread with a proposal that
> I'm not sure it's acceptable or not. 

You haven't sent a proposal.  This is a reply to a reply to a reply of a
patch.  There's no justification for why f2fs is so special that it
needs this.  What the hell is going on?  You know this is not the way to
get code merged into Linux.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
