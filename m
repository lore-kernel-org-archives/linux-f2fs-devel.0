Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F7DCD5BDE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 06:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=26QTzVprqzrdFJlRu8PeLDPBKKmPbpr6IFtkztMzRtU=; b=Qqa0cQ/xCq7j9SjSvk22uGAZGI
	icPA0yCEfZt5VCYtYiYngGQivzMKN343BeJ4M1XzEAZlISiYeBsx7uzPK81HXLRyZ6e+3hbB2KXd/
	+oTUBX5l1T2meknVtz3uxFXswYKC04Xc0D2QTXEwJVpyXEDD/+U4rSbgUmNo8ZeqNXuE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wS7po-00067o-RE;
	Wed, 27 May 2026 06:33:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e9735a96feccf8b5d28d+8312+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wS7ph-00067d-47 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 06:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eEdEkrkWD4PUlydL5ruu4HP9SQ8xgA8dkqdrg8+Pz5w=; b=CCFbimQrAHq7VKEBF+uQuQ2RvA
 /zOnuLqr1mJZs+VOP4kE7uSkHp04S8vw8OxcJed/DKN/sb0hZNEV7vhFTCty+aas+NCDO7oHDDo+Z
 MDNXzqqmYR6IatV/vAKz5e/ebmIIaTTBs9CI1OYkgB5q12npj2ZGQaOHYXHmSLx3IQ5o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eEdEkrkWD4PUlydL5ruu4HP9SQ8xgA8dkqdrg8+Pz5w=; b=PedjHoWn+3Vww72AhApF4ErBVb
 O2EIgUuchULz/pGiKx4V8UNjZsQLduDxhSnhlU1Ggy80nq0q1Pa1r00EEzIXHOqtY1quVfwuJS4Xf
 vFWhZTx0D88z/v+iZNGYtIL81eqRkRhFxIwT8KyhLnIhX4O6rt639TdwAyunJUPv4qiY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS7pb-0005OG-Ju for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 06:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=eEdEkrkWD4PUlydL5ruu4HP9SQ8xgA8dkqdrg8+Pz5w=; b=L292o9BdhdzRX7dwCnyh8lXw/Q
 aInv3spzoL36ml6byXQJAIP6c9rHzdAI5XAEMaBYcWQ5td2NKk7V0VE8JKmrjzq8K62svpG9FXk+c
 TFZvUtfQPoTtDUuw2y7XIsGGA/r5AtmGWBqsmyTKCqbeS3wZjw+Ih11M0mxzTfHQRUa+vlwVSIcUc
 wbRyatrxwjWJ6C/55O3pN/OePsPXDeFlSRao18JdofJn3iJZRz7Rr3oLIEmwxK6SU/Fsbruyfp+YJ
 BUdSW/zV0p8QL1lTXQMNKb89ugT8wK+V4ePi1SkXf/I6ET/GgcXt4J5GTQ0YYHd1Igil+9vMYCg0t
 eLerb5vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wS7pQ-00000003PH6-0KFC;
 Wed, 27 May 2026 06:33:20 +0000
Date: Tue, 26 May 2026 23:33:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ahaQMKe7qf63wqni@infradead.org>
References: <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com> <ahPffhaOi2CBtWof@infradead.org>
 <ahT1nT3xsMGkyJab@google.com>
 <ahUF7HqSKFJ422bU@casper.infradead.org>
 <ahUX4tBeLykdQNxY@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahUX4tBeLykdQNxY@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wS7pb-0005OG-Ju
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
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 26, 2026 at 03:47:46AM +0000, Jaegeuk Kim wrote:
> Thanks for the feedback. Actually, I tried to do compact_memory before doing
> read() for AI loading, but I got complaints where it took hundreds milliseconds
> to run that compact_memory. Is there a good way to secure high-order pages before
> that read()? It was quite hard to project when it will happen.

Make sure that all files use large folios as much as possible so that
you have a lot of clean pagecache to reclaim..   Same for any other
easily reclaimable memory through shrinkers.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
