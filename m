Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B79C02183
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:49:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tYrOy-0001RW-HX;
	Fri, 17 Jan 2025 18:49:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tYrOw-0001RO-Qk
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jan 2025 18:49:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d4/k6vrAXM+j+2jFUhG9E7nZW8j8cZF4mk1aGrQI0qI=; b=JZUaHppdSmtxG0175g7xQtz8ZR
 8pC201461UXxnWN8g5iFXptan8mrdRtoSZ/nhMZVMDmX623Xdlak/nBCFL9uPnJrb+gq9ehBDi2ve
 e+fGyWepsJgJOmwsE1Bis8b2OwSs0A54UfTXQ8W1wYdxYM+VE4pO8fFTzFoGkSa91qoM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d4/k6vrAXM+j+2jFUhG9E7nZW8j8cZF4mk1aGrQI0qI=; b=hwrDblqq0iySmrmy96Wh4YwYSu
 Q7IhrLmq6NENR44pb99ekWHVxy9wIAbvnoRNdMtRku0uBjn+dosGklSP7UcVnvwL1nJrnhdr7IaFH
 85BpaarofZNUvKPcY8s0LmDm6ybqjBTO2ZaoNw0RYzt96VOy5h2tFcK9NvUbrJIe5a0Y=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tYrOw-0006VC-Tl for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jan 2025 18:49:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4B906A4337C;
 Fri, 17 Jan 2025 18:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20AEC4CEDD;
 Fri, 17 Jan 2025 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737139736;
 bh=uSFr7uPxilQbgYq0+zdRZr9nXpg4EleYwwocnWKeN/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=geQjXpnkhLCLWNLZMlbB0uJh57q6izf7cWViOO2F3QNL/ezvbGLWlZ6EfPWvlc2My
 rHe05QmuTuqLIidP4pipPlO48mWH7ktnfqpKLeeojkdVldgxvD7AaTKnc6uKPaXwIS
 ga3EUvvp6X7PGXDi+/0ClVy9SKTfFIrn4XXbPiPPy5b7Ktwd2JKbsetGBzUa3xElwx
 dd+7LrfnacEwWzKg9sfLTrUx2oHYSLZQJ1q/Tbb+sf7Kmt9ZGhbTzsUIslJc40j3zC
 f0bWxHKeluIzDMEMuQUUD5l7BGPRYAg3ihn1LbR3xYyrdCik1B+gSzMB+629x65BkD
 LE4h18DRFoGEw==
Date: Fri, 17 Jan 2025 18:48:55 +0000
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <Z4qmF2n2pzuHqad_@google.com>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
X-Headers-End: 1tYrOw-0006VC-Tl
Subject: Re: [f2fs-dev] [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed
 pages
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/17, Matthew Wilcox wrote:
> On Fri, Jan 17, 2025 at 04:41:16PM +0000, Jaegeuk Kim wrote:
> > If users clearly know which file-backed pages to reclaim in system view, they
> > can use this ioctl() to register in advance and reclaim all at once later.
> > 
> > To MM and others,
> > 
> > I'd like to propose this API in F2FS only, since
> > 1) the use-case is quite limited in Android at the moment. Once it's generall
> > accepted with more use-cases, happy to propose a generic API such as fadvise.
> > Please chime in, if there's any needs.
> > 
> > 2) it's file-backed pages which requires to maintain the list of inode objects.
> > I'm not sure this fits in MM tho, also happy to listen to any feedback.
> 
> You didn't cc the patches to linux-mm, so that's a bad start.

Because #1.

> 
> I don't understand how this is different from MADV_COLD.  Please
> explain.

MADV_COLD is a vma range, while this is a file range. So, it's more close to
fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
at the time when it's called. The idea is to keep the hints only, and try to
reclaim all later when admin expects system memory pressure soon.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
