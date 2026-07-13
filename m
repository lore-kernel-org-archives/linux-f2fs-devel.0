Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF9EC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zaUkDiomsihZF5k+P3Qam0GjdT6xbA8yeNckbldn5M4=; b=K9EQc2oxx1DCPDfH6OEf4GHE/3
	KP5lLUJstxgw00aYM4H1i5tQa+hJm747UuzGg+RaIjSls4TM5iaxkyKuwxy5JttQyFmTICZeT4DqZ
	01x0HOTRXyjAJw+b+9rCr8WPzjK1cHYo5a+Iq/tRL7D637hA69MLKyaH1lYpiWNBhUzc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjDgu-00078m-Ot;
	Mon, 13 Jul 2026 10:15:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+55c33cd1421391a2a6eb+8359+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wjDgr-00078f-Sq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 10:15:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wd5EK7fPsbF7saDZnaT6E+GdQJ31yQMyVH33vqfFEE0=; b=BIrNo4bbZndJYWDBx7E8audyRR
 SGwNbiJ2WNOe790/naM/4PeQKVc7lmrPXXfowdIRrp5JJKzNd5UM6BkNlcYl8gNLJXxrrMckEv2aL
 rKK76NVMcjFlKWgUVfVcDpiYWdq9+2YJZzjjwwEcWYuPNnIRevDQC6Ub3mSDtnkQVKH8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wd5EK7fPsbF7saDZnaT6E+GdQJ31yQMyVH33vqfFEE0=; b=mCuqjCPqdotTvGdwD62YQhKOtO
 5QTs0YSTwZJuAz/WWywvZswAT4V6PNeKdMpgbhaOpuwx2IYLtXik//BPkJJsvZuEMLIM1cUynRr0J
 QWps5KCpPtDtoJJf0VinpvLD1M6kdqbhj6WsyxVlxWqGSGOdGYIVz4e4rBcvWIzA2Hvw=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjDgr-0004Kf-8Z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 10:15:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Wd5EK7fPsbF7saDZnaT6E+GdQJ31yQMyVH33vqfFEE0=; b=RTcCxrP5jqIPlAGrqZzkl/m4f0
 1wHzKniwlyX1iyIjAXbeRP9tWGjek9AIG3mHwI3AZ70C8QYsVzGDLpqiKG+HninpPngZnDolKsQPZ
 p5w6xJdPUkhzJHNb2tWmaOC8yZ7G48qqKrzekbvFmGeMvvj5SgkGUbH210vW20BLWbT8q2ZpnW4dW
 /7zjeCYb1vM0m6zVPW9IQMZscAZAz/XmgD+0wVL4ij0HMDKO0XLDZcD9jCGpGNRYxzyz3heGoL5LT
 p8AOqZcyyds1fCy9614PTG4SyLzI3QNxroQX8j98Z9M8ANmKT/DR+3plgB77riqSHcLO3pDGa6Yyy
 /qD0nbHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wjDgg-00000008r8e-1gc4;
 Mon, 13 Jul 2026 10:14:58 +0000
Date: Mon, 13 Jul 2026 03:14:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Message-ID: <alS6oonYUoawuxBy@infradead.org>
References: <20260710210646.3576365-1-kbusch@meta.com>
 <20260710210646.3576365-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710210646.3576365-2-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wjDgr-0004Kf-8Z
Subject: Re: [f2fs-dev] [PATCHv2 1/5] fs: add direct io attributes to
 file_getattr
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
Cc: axboe@kernel.dk, linux-xfs@vger.kernel.org, brauner@kernel.org,
 jack@suse.cz, cem@kernel.org, aalbersh@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, tytso@mit.edu, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 10, 2026 at 02:06:42PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Direct I/O imposes alignment and layout constraints that come from both
> the filesystem and its backing storage. statx() reports some of these,
> but not all, and it can no longer be extended.

Well, it could be extended.  Although it would require a new flag,
and there's been a lot of pushback to adding non-fastpath attributes
to it.   So maybe update this blurb ad bit and also mention which
attributes are duplicated?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
