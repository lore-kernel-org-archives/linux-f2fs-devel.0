Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753C5E98FAF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4EIbfDZcJUgXoyW6VMij1j1mZZWwu7DOG8hHi8KrYOo=; b=Lfa02IVGAGRs8F9kfYUUYg7pLz
	az0Z6CZspipY2IuhRbVMKGnhKxApuyJ3+PCR1C6JSUs7sU4jPop1L7UH0xkJO+7CJy8NgvjwScEAR
	u6xRW6TRL5NV6I3oir2bO5beUzDTNmKKPrQS7fq4Dw10QxEjkwF2sjx+Ee8680XH3qYA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wAi87-00073a-Hy;
	Thu, 09 Apr 2026 05:40:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+a4de8e1a1e27f13a2878+8264+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wAi85-00073S-LG for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 05:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o0ScfNlJGSA2uAJMI4ulU1pLyWdBug8Lf8guz+qT7sY=; b=SDkr7S1VYbu64f16vmUojRTjla
 uJ/0wh9UpWKalPyt3NyfEUCY6/qkh8pCpvqvEnNNyjSrd7pFsl0T4DHEngmw7HDjhGXQVJ7onK4sS
 H8QMJo1cQxn1F9akKybFzJtOOdal+398b0uFi1IBI8cUfl9O6kboyQyvcdpX39ZJ6wfE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o0ScfNlJGSA2uAJMI4ulU1pLyWdBug8Lf8guz+qT7sY=; b=j5JLl7IhYI9CELMp49+XwBkpeZ
 ofcaaU31I6t++WuwNN5XZf3HgTsE6EZQZFtuUdCTxTjT6GBeVubpHZYvUX0zrlD3lmY0yXWK61B/l
 S/Zy9eqBuOTWJVbVshfGjz/Z6avnjBIqj3J8GhQBzY+ZiLz5HwAFBCMZ1I7wNTxMkolE=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wAi84-0007li-Ip for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 05:40:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=o0ScfNlJGSA2uAJMI4ulU1pLyWdBug8Lf8guz+qT7sY=; b=4edJFwxsbyJkPqyn1XaMjCDdSC
 FlJdc1layEXP+v7Bc2DUT78tlL2tMpEQhzr+g6u7TDB1lpdV4g2ptYtaNmR0IxILvz7kv4ix348K1
 uNyP3t9DRWiyviPTTydvWMvAMXtodrCA9szonPWUyLmrJTF2zQ/O6koGmwppKavXVt0HE5ZsWy91N
 vqSKoWtyS0HwFYqXcu345tgJGIeqvR0MlM9eOUGlttvMcq9nnZ8c7LmlKHquJloOJMU7S4CIoNFPg
 cxwyYH4tgGgBWNt8y9CmG1B2vkuN98d9XXsUKAnLFzbvg8I9PwHtYf0gNE0QXt4LUi7Nui/3cTqwq
 WmfrJCWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1wAi7u-00000009jBY-0Up6;
 Thu, 09 Apr 2026 05:40:26 +0000
Date: Wed, 8 Apr 2026 22:40:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <adc7yo1_sr_eeV33@infradead.org>
References: <20260406154940.2407853-1-jaegeuk@kernel.org>
 <adaasm42rLxRY2GN@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adaasm42rLxRY2GN@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wAi84-0007li-Ip
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: do not support mmap write for large
 folio
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

[adding back fsdevel and mm to the discussion]

On Wed, Apr 08, 2026 at 06:13:06PM +0000, Jaegeuk Kim wrote:
> Let's check mmap writes onto the large folio, since we don't support writing
> large folios.

What does this fix?  As state in the previous round of discussion f2fs
only support large folios for immutable files, how do you get ->mkwrite
called for them.

The only way I can think of that is when clearing the immutable flag,
but simply rejecting writes with SIGBUS after that seems like it's
breaking the expected API, and I don't see handling for normal writes
after that either.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
