Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34268C46467
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 05:59:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFU8j-0000Kj-4p;
	Wed, 11 Jan 2023 05:59:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1pFU8g-0000Kc-Qs
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 05:59:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0TfiPLlJhHcGnakaKqS38OffSSKYp8i2a9XUKHzvm/g=; b=XACSNbqDXspXsIxdbCIlNaqAfC
 EX5331fMZvLq+1etL4MzHaHDH1MN13Ys2fzpvLr6aJs8KxtQo5ewuFOQ8lPmjLns9heiuk0BItF4G
 9XZQC2SLJTvAn4L0KJtwTHXuJXZdmfdBPkMWosai1Q4YiIOvCM+HFNniMwbKQzVxFiSE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0TfiPLlJhHcGnakaKqS38OffSSKYp8i2a9XUKHzvm/g=; b=OrPEKFp5JJ2ztlvJNgStlUaCSx
 rnVkY0XCrea7udetiguoGGJlwLY2QOubntcHbicweh4xTJTOWOlDt+D0K3SKrSUVLNe7Escf7Pylr
 mVkZkWu4serHtMHYJiwG0wH4sKJv6LvaXR1mCcf980F29THWB0Iwzb8DRQ1N8vH3Ff90=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFU8e-0007MU-Ij for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 05:59:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 573AF68BEB; Wed, 11 Jan 2023 06:58:56 +0100 (CET)
Date: Wed, 11 Jan 2023 06:58:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20230111055856.GA17545@lst.de>
References: <20221128091523.1242584-1-hch@lst.de> <Y7RkIbB5JAAJ3Rw6@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y7RkIbB5JAAJ3Rw6@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1pFU8e-0007MU-Ij
Subject: Re: [f2fs-dev] a fix and a bunch of cleanups
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
Cc: Christoph Hellwig <hch@lst.de>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jan 03, 2023 at 09:21:37AM -0800, Jaegeuk Kim wrote:
> Hi Christoph,
> 
> I applied the patch set with minor modification to address merge conflict.
> Could you please take a look?

From a quick look this looks good.  I have a nother big batch of patches
that I'll rebase, and as part of that I'll take another deeper look.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
