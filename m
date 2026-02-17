Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC993E83857
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Feb 2026 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pK7QDVMXFkEm9fdEqAYqUAhrUj6LhwjDjxcONyyTt3U=; b=l9RdGSIKF1CFeHpVzk1A61YKg7
	+vtvjw83EgekUawTbiqMdwRqjYc2ti6S3j2rmk/FHMnhypY1EdNa3P+Alf0GhxLNlN9gw7mMU7pcq
	y4QHwh10NvUQ9r3dNjrTUZJCJiRHk+rfV3UNBd+SN5YksclSF46++OiVDjRW2r/xDUQo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsEaB-0005GV-Is;
	Tue, 17 Feb 2026 06:29:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+52c31190631f5c163bb1+8213+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vsEa9-0005GL-LP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 06:29:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WyAIcLIv591hmrCnNshjx/uIcz10rfxE5sQqt9EdVlc=; b=kow33bnoj/hmk4OFAiLaf7P70E
 bARdjXU9GBQ7wVnN+Vxw1LHICilHYGU4ufmSmbdf+egxFgBHObhFHbb5o7gcL0DrerUQCE6H6frJq
 e6EJACm0jxfKCEVqqYRYQCty8mMQEAwGGkWBFE106n5TEqwMt1PlL7zde00tLpbTv/Ho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WyAIcLIv591hmrCnNshjx/uIcz10rfxE5sQqt9EdVlc=; b=FHuFIbHcBsggTMeARbglfPtDU5
 sl1eIP4awTHK6BIE+WU0Xh2TONd0Ba1rtzPO6htTqOZhIm2NL26HTwB+t0xdv2RuWXvAw/z+iNO8W
 x0Jy4u6Q1UqXmoRTITtcWNlpjn5gi0w4Mx/L0AvGfAj4j4ihX8bzn8EpXmLpsETNfUeE=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsEa9-00009p-2B for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 06:29:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WyAIcLIv591hmrCnNshjx/uIcz10rfxE5sQqt9EdVlc=; b=M00YFvKXrh4rOKik0+lHpzZ8if
 FA/zuidbNWaBqmRS7jg9mLSzMNqVM3O35q7nPgWKzkV9Z319PSbTGnDv0IsKu0IkC1McUPcYvzpo6
 VtX+L4r9QwxnBhiLV7bqrqcbjDrhKcQl8+rqIcmlxVDi11Ixl4B8iZ6nYgYKsNuxkggU7BOHmYflY
 MyQf9YMSGeQymKBKFj6V5Vq/TBqULhansGQ2tXxaY788QqdPCixiHEyBxsgT3zKzqghUiawsZv/8E
 W6uSmV6R2TLv7jpHw4XjXhYinaqttsC/ZiWL/NOorIy8V2q3YpRML6ii8WhTl7PceG/ZElowlqNJV
 5xycsmkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vsEZy-00000007huO-3Wc9;
 Tue, 17 Feb 2026 06:29:02 +0000
Date: Mon, 16 Feb 2026 22:29:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <aZQKrpBZdRNkGGcF@infradead.org>
References: <20260215042806.13348-1-ebiggers@kernel.org>
 <20260215042806.13348-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260215042806.13348-3-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vsEa9-00009p-2B
Subject: Re: [f2fs-dev] [PATCH v3 2/2] fsverity: remove
 fsverity_verify_page()
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
Cc: fsverity@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Feb 14, 2026 at 08:28:06PM -0800, Eric Biggers wrote:
> Now that fsverity_verify_page() has no callers, remove it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
