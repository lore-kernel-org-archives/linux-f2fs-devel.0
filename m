Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D08CD5BD5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 06:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jwBwnyMZ6oDLoK01nV3oFbhOuOeztu2Dr2XmfPLdh54=; b=aaShwS+0mWybhZGyM/ukDeU7Uz
	nafPA0uO0B9o4wh3OKOpvd1PavEYZKeqE6bQjwjJoLtAR2W8Ts3raDm1n8nIWnmLcJJYu1nxs3Faa
	ERjzDlGsjHSxkoG+N6cN1K+UPibB5+Jf0BYt3ziol38DrIjcJHbTcbWsPbqHrY1/W1gI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wS7kv-0005QA-SN;
	Wed, 27 May 2026 06:28:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e9735a96feccf8b5d28d+8312+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wS7ku-0005Pw-A4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 06:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ka/9L3mGRr/AbgLqT0X1N/LKODg56XkQXKLxkU0UHzU=; b=Uz+6XB7mm9KeVd6vS/MOXIIwMu
 zLZn8q6A+QDKm0voxAFXpHi6j6lndHL2BZmlGvyHihOTYjB9eIzHh3S9HivihViGCtTucz6PYTta4
 zjitJcsohn6roxlvfvJ0shEO2oIJRo5tXrbgisCW/QJgOd84bJMvzXkNtwg0annIg3OU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ka/9L3mGRr/AbgLqT0X1N/LKODg56XkQXKLxkU0UHzU=; b=PWhtoaeNtOB6XNmLbrAvmkTo11
 KYQP9OOdi9FfSymxqu5HWQK1hw5NQ4o5NykTPkIbSDdQ9qF7DMxWl1JJyLBXeAw9mf6hS7nEX/oE9
 rFvzFzZ3w4BdKapZ3FMJYOtW7ijgaK5WS3hHiVFLFjRQQQ92iS3x6ixEC+ilI7Pu7xrI=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS7ku-0003oV-4b for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 06:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Ka/9L3mGRr/AbgLqT0X1N/LKODg56XkQXKLxkU0UHzU=; b=nS7j8vx2eymE0ZSZoDXuT2yyfB
 /S4PFwuANnKUoJp7Giy3+PPZL2gSAx1o/0tYaYdwpEB5m5NxnKmi0la7rA+Kdjp8Tg0DTzC3wbrdb
 p0SdCWxYoxDL4R+uCloO+ntIkscwqjOUheJxRyg6k3URoBMbJg02NwWXHUDRHOhOsoUcznSjqCr7R
 nzTIsYlAv+FvrDCQTadRi0C0ba3pnNgQPJvhBxUeWgi03KEwJcO3vfxYgKtesqiYn6VhwjAlat7Im
 ccYCea5H39rArdAXYTH8KgLSGMAdaGm9wmifOC0WrWvLVA7yRspaKDM4ho8hHu1TqWsRqsxOjMKHA
 XhyVjWPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wS7ki-00000003Ozf-3Lht;
 Wed, 27 May 2026 06:28:28 +0000
Date: Tue, 26 May 2026 23:28:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Message-ID: <ahaPDHiXcJoVShPv@infradead.org>
References: <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wS7ku-0003oV-4b
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
 linux-mm@kvack.org, Akilesh Kailash <akailash@google.com>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 26, 2026 at 09:14:52AM -0700, Bart Van Assche wrote:
> On 5/26/26 6:42 AM, Theodore Tso wrote:
> > It seems... surprising that the additional I/O operations are actually
> > throttloing UFS device bandwidth by 2x (4GB/s vs 2GB/s).  Have you dug
> > into why this is happening, and whether there is anything that can be
> > optimized below the file system?
> The layers below the filesystem (block, SCSI, UFS) is what I'm
> responsible for in the Pixel team and I can assure you that these are
> highly optimized.
> 
> Since the transfer size used in Jaegeuk's tests is much larger than 4
> KiB, how many CPU cycles are used per IO by the layers below the
> filesystem is not limiting the transfer bandwidth.

I'm honestly not sure what discussion we have here.  Larger I/O is
pretty much always more efficient.  If you submit smaller I/O you
need more merging to build it back up larger, and more I/Os.

Which is exaxtly why we need large folio support everywhere, as it
makes a huge difference in I/O performance.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
