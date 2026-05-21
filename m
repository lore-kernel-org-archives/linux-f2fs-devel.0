Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FD9CD5BAA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AWRMtxbT+Iogd5IY3B9/OkHBrisx82jROqKBAs++nQA=; b=QgUpqr1nreGREPx6xZfEYizB0G
	NYuHa0JgwZ0a4OEk1da/P8J8WmbvCtvyFZeigi2Xx6d5EkbZLOcs6hrfPGu+DPpaXd9gAkuCX0/wC
	7bLPe6JmWIItG90UNnZ6yVM7FFsuAXmdVquB/+pFgNjWpeqFpddp0FoHTr34qmH6foxs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPz7j-0003Z5-Ae;
	Thu, 21 May 2026 08:51:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e9ec8ca064152542cb28+8306+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wPz7g-0003Yw-V5 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:51:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=adkD1i4uWAA/O/XCvNqvQRIx38qTQ9cyPCt8+vT2S5o=; b=jNPSGiFKfFGl2OD6r5HibEoF9q
 w6P4kCb/zv1z+leL3+mGKlzWP8bWxQdgexIbPaOty4Z5PJoazuk7UiyI+plFvlhcx3GmZJA++DI/x
 L+DbpSLJ/+rR/MzYOz2VD+GGLnpZT8EbLF2np+Zjw8xpkESQ5OpTt/KKUHh357KrfhFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=adkD1i4uWAA/O/XCvNqvQRIx38qTQ9cyPCt8+vT2S5o=; b=TeF4rY614gWFgMJsMRvK5dz490
 G3qTUEMSAViBh3A8/l+Z/qTW+5a7IWAZuEAJcVGQLen1Xg1c6ihVspl31aQKYQZQh049GOZkaeg0m
 tF1qAMslKZO6Uqg0+ozSNXCrWXwe5dik2BsfFv3PGqzlIi3ysW9yo205ch3y8Cih7Sto=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPz7e-0007JZ-Qw for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=adkD1i4uWAA/O/XCvNqvQRIx38qTQ9cyPCt8+vT2S5o=; b=iTWlcAFV0bGroYj100cYzExpuz
 rsveboyudTm6JgzWG1IVCmUuLa8zzLxpbanYD8qxdzQYq8YiIeY2EruMxenhS8o1y4SfVtSpiGm6n
 XeSobI/z+GxYgJibYVSNh+LgT8nXyz2pe/NPNc62zXD7/tOAyWssVVQ2VUuwo96KR9jxicA3j1zE1
 6pPN4zVjPNKcXi+0GGucZo34eSB2hLyo53j4PKeNPV/FS6FHUbY6SH3ALTtS0KJtJaZCAb9HYgI6C
 eYOoMQNzCszV/wK+x2FRtUvCP4CA1j6cH6KjxIQZqYY9WNvnHgXL0K9rbYpRJxuBGRaIbOjIrpStg
 HiphiGQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wPz7V-00000007D7o-04Ty;
 Thu, 21 May 2026 08:51:09 +0000
Date: Thu, 21 May 2026 01:51:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <ag7HfNryTmQ-bVIS@infradead.org>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad_HwhzlNPUEKQi6@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wPz7e-0007JZ-Qw
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

On Wed, Apr 15, 2026 at 06:15:46PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 15, 2026 at 04:44:04PM +0000, Jaegeuk Kim wrote:
> > On 04/14, Christoph Hellwig wrote:
> > > Please add the relevant mailing lists when adding new user interfaces.
> > > 
> > > And I'm not sure hacks working around the proper large folio
> > > implementation are something that should be merged upstream.
> > 
> > Cc'ed linux-api and linux-fsdevel onto the patch thread with a proposal that
> > I'm not sure it's acceptable or not. 
> 
> You haven't sent a proposal.  This is a reply to a reply to a reply of a
> patch.  There's no justification for why f2fs is so special that it
> needs this.  What the hell is going on?  You know this is not the way to
> get code merged into Linux.

None of this got properly answers, and this broken interface now landed
in linux-next. IT is offloading a user.* xattr which is free-form
user data with semantics that are weird to say it very nicely.

All this was done against the advice in the mailing list discussion.

I think at some point we just need to stop taking f2fs updates likes
this.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
