Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F070AC2A09B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FL3ROniK9rWzQMcoPN+FptlzGHDWCBSY0+ibxxmEC6Q=; b=PVdiyc2ZtojlmZg3YmE4Q/VoK1
	FCOrDHPbYXsnxKKskxvae8TveaqPlTjTXCAMubZJl3RNCthPT7S7qHLD7pkMk6rD6TULLGz0+2RDB
	1d2vj+OY8VlJWMOGu3K0vm50U8lWP7EgugNUDbyqjfTUIHQcRWV5cj4ebcryiyZJIJBA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wsMMK-0002Qz-LH;
	Fri, 07 Aug 2026 15:19:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wsMLw-0002Qe-4y
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:19:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H9XKfy6+pFtdCncWq+6zsw9ueT3VoFKNoejpZHvXfFc=; b=CMjCePCS5sKw1ugDkgx7ERzXjO
 w4/b6DZjbBCtj9J7+W6mdeDRy/GQYFIusRzz65TBMXVqr0bXvihqjMuA5c5NDFtAuDwub/oMjdY4Z
 nkmPB7yAqWDC2kDKLEltF/r6nIsmSrNDtAb9hHr3DFOpNxhHTZ13qZbG+sPc+DssHD5s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H9XKfy6+pFtdCncWq+6zsw9ueT3VoFKNoejpZHvXfFc=; b=myXsw+cFXfaghrPwBODFPy0tpB
 JbKdfC/i4Sc6vksbTLY9K9gHoavnavA+VmeKUBVj/DoyoVqn6tmu4f6+JE2+I+IOaHK4ky1yVYxjY
 JUBIXDohFKgAls6njoIzZodAwjiZwOAyQL/3QLQtgoXb63tPoQwObVokLarO9elKvMhU=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsMLz-0002Jd-Ou for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:19:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=H9XKfy6+pFtdCncWq+6zsw9ueT3VoFKNoejpZHvXfFc=; b=izKcaAZ2gxytqFBY9YbEu9VZ2i
 I36MK2oBRJXsQ7d5nYIxtMPU8dPgG5tcoKahg1wsn52S4Oc9pXmRiS200wPjC84NFxCfnBRduvdFZ
 JG6Cnave0uFWtSjrfkFoXv4LAdmJCUktQq19FCUjJY43jl8XbpGTOUUIgbNw/tBXdZBZ6KBexQGXo
 t+NpjPWS6LUk9Bsi9Nk8vpN7eR1BZ5LZvkJ2YF/QO9P1O+oDXfUbGNYju7oqtyUIgY1QnUW5TR5Nk
 GQbVKYcJqJF+hBr2wv7H7MT25neb+3mx+NG4IMXvFUWuH6GHfgofnM/EISXD1+89NRZnVhu12d3Aq
 /eZWh+BQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wsL9C-000000097f9-30i6;
 Fri, 07 Aug 2026 14:02:06 +0000
Date: Fri, 7 Aug 2026 15:02:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wenjie Qi <qwjhust@gmail.com>
Message-ID: <anXlXntN14GKvY58@casper.infradead.org>
References: <20260807130445.465203-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260807130445.465203-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wsMLz-0002Jd-Ou
Subject: Re: [f2fs-dev] [PATCH] f2fs: return symlink writeback errors
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 07, 2026 at 09:04:45PM +0800, Wenjie Qi wrote:
> F2FS writes long symlink data with page_symlink() and then flushes the
> symlink mapping to reduce the chance of exposing a broken symlink.
> 
> That flush result is currently ignored. If the writeback fails, symlink()
> still returns success even though the symlink is not durable and the same
> operation can already surface -EIO through syncfs().
> 
> Return the writeback error to userspace and skip the dirsync flush once the
> symlink data flush has failed.
> 
> Fixes: 424fd5d831e1 ("f2fs: Remove f2fs_get_node_page()")

That commit did not touch this code.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
