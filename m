Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11418CD5BAF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t5f9r1CboFj80aB4Z81oPd2HOogxyWbHKJY1ypSqjGE=; b=Heh1/+roCvwrjj+NhQHtW7nHn/
	KGgsjVdrjtxedZ7359a7pjZYVYznZiTpbpOMkLVpD+CVUExBB8JnXdpeI+4tIF6T09qk2eftAs98g
	ua/XcBDgyw+r3Aqi+EyXG9esVH8rQW8r4/+bh5WnarXhSESR0Uh5ZiHYbnAetol7Vzp4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQ7PV-0004rC-Ns;
	Thu, 21 May 2026 17:42:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wQ7PU-0004r6-Jy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 17:42:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mocVZk7k0i4LfDz16F/hYo5gMZPJrjHL7ge9GFVHtqI=; b=PSx9fjCuj/i6VYG4fe8/OUtm7j
 8LIdKHBjiCpS2QXe9Y+e0hBAZZf2amzP6Zq9QKoHNosNbsUPqp+wu0A4eVASo1xMLkxMuwuL0bV/h
 qz1Y1yLRDoZ+iYgjV8kAong9q3qZ2eSwKWRVlwYrHdlzHc3gnkeoNYYFKgVzLzU6fYQM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mocVZk7k0i4LfDz16F/hYo5gMZPJrjHL7ge9GFVHtqI=; b=JPJg5EYaPN/t3+ByKfDfRwdKmh
 rdEMCOmMEYjJtSx/tasLF4z1Z1h22OUav/Dr3jtXxYdrcGl+tdb26LbXDlNwB1wrZt5DTXDYYdvsk
 Vv9dRxSJso4UFgy5NXzdS4P5EQjptPPCG4rjdb0fT2TPFzygQnA62Mc5/aOqv+RICzHg=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQ7PT-0005RU-Rl for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 17:42:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mocVZk7k0i4LfDz16F/hYo5gMZPJrjHL7ge9GFVHtqI=; b=ejOrg5mgxSsn7RT/IqWLJYzFmy
 NjacPOHPPk39x+u3OOyZlw/ZOZDCW0fQ5+j7kEh4ns0cWOZDIgh2/xgyxFhO42LNiJuYqfWu14Qyq
 INqflfS2Q5C56RXca4CONSNgXzpsQvC40q9brHTV6cOwrRANsEllx6AZK4PQKsjB7PlcIhsF5CpqN
 QhpXfxqg147N4BeXy5Bv0k94qY/07fYp+a8FjqSGRQh7dVRzAyyXuO3zAztmvK6mhXUPh9EOTJgTP
 fnUKz1TMjfkyI6WIwVEHZ5v3AqVavAwv4Eq7ga7uPWwJfxGJoWW6Y1JZanIeGHyZdizhe1S6ukMYn
 C1VY/WxA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wQ7PH-00000008pYv-3GzO;
 Thu, 21 May 2026 17:42:04 +0000
Date: Thu, 21 May 2026 18:42:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Message-ID: <ag9D6_7dttbDGHZ6@casper.infradead.org>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260521155748.GA79343@macsyma-wired.lan>
X-Headers-End: 1wQ7PT-0005RU-Rl
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, Akilesh Kailash <akailash@google.com>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, May 21, 2026 at 11:57:48AM -0400, Theodore Tso wrote:
> So let me get this straight.  This is a magic xattr interface which is
> not even persisted in the file system, but instead sets a 32-bit
> bitmask in the struct inode which disappears once the inode gets
> flushed from the inode stack.  And it uses a generic xattr name,
> "user.fadvise".
> 
> There's no way in *hell* any other file system is likely to adopt such
> a broken interface, so why didn't you just use an ioctl to set this
> magic f2fs-specific flag?

I mean, yes, this API is horrendous.  But it's just another example of
f2fs thinking it's somehow special and not just enabling large folios
like other filesystems do.  This hurts everyone, not just people who use
f2fs.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
