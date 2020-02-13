Return-Path: <SRS0=jEq4=4B=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696C2C352A3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Feb 2020 04:39:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36027206D7;
	Thu, 13 Feb 2020 04:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="XK4pIJJn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="VXZRG2pO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbYlCnFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36027206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j26HM-00041O-7n; Thu, 13 Feb 2020 04:39:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <akpm@linux-foundation.org>) id 1j26HK-000419-N9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Feb 2020 04:39:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iyo9Dk0mJYM2A+6IJL4/OVB0v3ghHa04hjU4w070rCg=; b=XK4pIJJnfmB0+8HR+002RcfHEJ
 4XU6HIEdJX+ogdoqex3icBpIBJWO5pDEa1ACqYwJR6MYZC6kDTYt7s8hLZgIpdqIBsXxMWvyRazzm
 f174SqG5vzC2t6rOil4x4YnSze9ngrEcQPecTMU4aX+t5oryAAbhrcv90sr6Pt7bTK0Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Iyo9Dk0mJYM2A+6IJL4/OVB0v3ghHa04hjU4w070rCg=; b=VXZRG2pOV/LCKxtdwEoOJWQwOU
 182nVwNc8fsMtgIQuOylysLvBGDzayAZ0ZgPiDK+lPD0X4jWzLsht0iOfeHCdxUuuDidCJ7xxp31e
 0dHir0Ngsd5hD1Gm4nPQbZr4IJWKuyIf0dMrsGXjtms7SnyMvbgxrM5fpExG8QNV31VY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j26HD-002cqn-4Z
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Feb 2020 04:39:06 +0000
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 18ED8206D7;
 Thu, 13 Feb 2020 04:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581568733;
 bh=bv+0VtaMuMuDtzLYPkieCdmd5QR4JDDM6y220mrx378=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tbYlCnFj7ggSwK4cyg70rWxQrzUahCW2yOeoE3sZ/LlJjzcrzNUchpk3R5qfHHiaz
 SHB7larZ7765fztRfvP4xU4fKtp8W2fvEWd3ELQPm1bzbJvc27CPLFeH48zYRK25QU
 yPUch6WEdYHhO2730Z2ntH6BUkthDgGeRFY+B2E4=
Date: Wed, 12 Feb 2020 20:38:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Message-Id: <20200212203852.8b7e0b28974e41227bd97329@linux-foundation.org>
In-Reply-To: <20200125013553.24899-1-willy@infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Headers-End: 1j26HD-002cqn-4Z
Subject: Re: [f2fs-dev] [PATCH 00/12] Change readahead API
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
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, 24 Jan 2020 17:35:41 -0800 Matthew Wilcox <willy@infradead.org> wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This series adds a readahead address_space operation to eventually
> replace the readpages operation.  The key difference is that
> pages are added to the page cache as they are allocated (and
> then looked up by the filesystem) instead of passing them on a
> list to the readpages operation and having the filesystem add
> them to the page cache.  It's a net reduction in code for each
> implementation, more efficient than walking a list, and solves
> the direct-write vs buffered-read problem reported by yu kuai at
> https://lore.kernel.org/linux-fsdevel/20200116063601.39201-1-yukuai3@huawei.com/

Unclear which patch fixes this and how it did it?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
