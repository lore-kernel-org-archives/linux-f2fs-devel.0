Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE6CC83F11
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 27 Aug 2023 20:52:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qaMkI-0004SI-Eg;
	Sun, 27 Aug 2023 20:52:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1qaMkG-0004SC-RT
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Aug 2023 20:52:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=64WGA8VV9Ar6eu59jwKakipB5IQeiUdKnhF4bZRyjJg=; b=gKHg1OdCleTRXb4gj1UIPGuNkK
 +2LrKc2cuh7Lqo9k6KQMt854w1v0LtmJwcMhnKRw1cM5rcWNx5ywr7L4DPBIXIP9beE7XYwM4E4wF
 8rYTq37Cl5PQwz4j1/WXe8GbQEkUwThQbMKOZcYXLV9hNpoNE5YlBq3IQv01DYPcmw50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=64WGA8VV9Ar6eu59jwKakipB5IQeiUdKnhF4bZRyjJg=; b=kwOXxfUgjnoGaW76BvuLOeEPhz
 k61EbBX6yPNcCr2yfYInNWkzNqdEXozHts6150z5zMJefY33wq8UB/wi6/3Pq0SxeRgKA284oO0Xm
 tk40AFfzaiGuVJ5HUoHcEfZiqFRGh+qOzhlZ7gmkR3lehqfWDBp6Y01ZvGpAbHvvbCOU=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qaMkG-0003jQ-Aj for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Aug 2023 20:52:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=64WGA8VV9Ar6eu59jwKakipB5IQeiUdKnhF4bZRyjJg=; b=f4Amt/s2VPJBfpbA4kwhdXTdVg
 /pn5N3WZwWFuLeNUpjeDraYY4nQbaO2UYvFIaQahuWJpv6yWj9SJhm3438dxwJSqQjroyoc9F0SYv
 XAWPI0/B2+Jwn7WLlLOC7qTdz3pp+yI4mEjVaLz0qln0W2Hlp6Bqseo3n3BK6S7q8PWF2QR7jDDR5
 5QOB+otXNut9VVTlFGgE9OB8fNY4Zqee0Fvn6lAYSC0XLvrtBqaDQzjA8XPvUV/U40DN9P1BUUcT+
 KJAEsVOCJlXQA4wp82KhD9XmJfIxAUdOp4MXoPkTY5GoW5ML77D0bFxP371EeaBKUbiVosNZkp33g
 ozZ78lYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1qaMjj-00DkxQ-7a; Sun, 27 Aug 2023 20:51:55 +0000
Date: Sun, 27 Aug 2023 21:51:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hao Xu <hao.xu@linux.dev>
Message-ID: <ZOu3a/24YJrtpIy1@casper.infradead.org>
References: <20230827132835.1373581-1-hao.xu@linux.dev>
 <20230827132835.1373581-10-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230827132835.1373581-10-hao.xu@linux.dev>
X-Headers-End: 1qaMkG-0003jQ-Aj
Subject: Re: [f2fs-dev] [PATCH 09/11] vfs: error out -EAGAIN if atime needs
 to be updated
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
Cc: Wanpeng Li <wanpengli@tencent.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-cachefs@redhat.com,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 netdev@vger.kernel.org, samba-technical@lists.samba.org,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, bpf@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Aug 27, 2023 at 09:28:33PM +0800, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> To enforce nowait semantics, error out -EAGAIN if atime needs to be
> updated.

Squash this into patch 6.  Otherwise patch 6 makes no sense.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
