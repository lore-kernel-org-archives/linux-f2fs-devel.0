Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B7FF433D0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kLwGc5RD9on33ITpCZlMuHJ2ddMma5ySFFBw7Wxdqf0=; b=crw8omiMmgOCikqXDqCD0dt4/C
	JiquwZ5OzrpZaOEtMeNePzAoconuaR4TWKei4xgZO9GdHIH7BjPfIl2lsgYV+xVSdJFjLGPZFWPZR
	5vS9XCDJg+JU1Waggu8s9Z/M9gcBFkPOMA1QY261zDh4zFT/bkQ30mgAF4rDweCaX3YE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDBO1-0004R4-A8;
	Thu, 16 Apr 2026 01:19:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wDBO0-0004Qx-30
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Apr 2026 01:19:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=17TjlCZCIXEN+7lApT284XqATffQCeo9XWg2qxpzwI0=; b=T+gRH6hK8lnl9oWOdvZSNCjexE
 AZ3vGXU2dOXpI7/J9tOaGmsvji/U3O9z5Sa42PGerA9ZpptQJUVvOV8E8Dj6YzgIi9PB1uDB6xLrH
 qLrohwqe1rC7pGf6D5zyWHJWPBXq1YbU2S2GWgF2fUgskW9LeHTPk5qGfJUBqcr+aev4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=17TjlCZCIXEN+7lApT284XqATffQCeo9XWg2qxpzwI0=; b=Z+sCEASB5b03PFzcIPNUiDj7JG
 BAFYbDM0XnzOsygLFV1W8aBq97DKaYAfc7DC0nJYmBGKi+1xwCXTesF9+TJqXG0dAFpXFkOx/oyv0
 4GaIXCZ9Wf7POhKHh1b2/F/sVCjPpFQNc4yflv1G7sPDv87Qvr9mvSYXrBHkHeY/C1W8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wDBNz-0007Eu-Hu for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Apr 2026 01:19:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E78960123;
 Thu, 16 Apr 2026 01:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CC3C19424;
 Thu, 16 Apr 2026 01:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776302349;
 bh=sGPVhh1PMoxtSRZpRrI3iao9xw5DxpR7NnDEs0o9Kgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h4B7BqzBdmwkiQP3eic2DNPc5SfwzxkiQTs6gPXXav+LObOeFH7nkioxT7SaepznJ
 tKeHtP/Q/R1rN+IYoojyUMD/9KImNkUeDlEZ5WlslsOlCvQ2KqZlW3coZcdxlw3RNz
 3mCV7tjMjQ2OqsxWlPvw1ydH4/JIGVkdDmVKz1KpUuDTB5O8MyYUvD27sG0B+C9qgU
 8jolvhM0TULMdqnl/LgRNrTYwCl5WgyWumi8qCF1q67v2K/cuqrhQNUhqaIazzxjtC
 Apa5NTA7awDPIth5oapqjqZwGGydEyX8hC8yE+ut1WrXAhm2X/Ni0qm5cQBQ819JSR
 jrW0S6CU0yzgQ==
Date: Thu, 16 Apr 2026 01:19:07 +0000
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <aeA5C8byIpXWla7f@google.com>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <aeAK8mFxzgMOepmZ@google.com>
 <20260415234950.GC114184@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260415234950.GC114184@frogsfrogsfrogs>
X-Headers-End: 1wDBNz-0007Eu-Hu
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/15, Darrick J. Wong wrote:
> On Wed, Apr 15, 2026 at 10:02:26PM +0000, Jaegeuk Kim wrote:
> > On 04/15, Matthew Wilcox wrote:
> > > On Wed, Apr 15, 2026 at 04:44:04PM +0000, Jaegeuk Kim wrote:
> > > > On 04/14, Christoph Hellwig wrote:
> > > > > Please add the relevant mailing lists when adding new user interfaces.
> > > > > 
> > > > > And I'm not sure hacks working around the proper large folio
> > > > > implementation are something that should be merged upstream.
> > > > 
> > > > Cc'ed linux-api and linux-fsdevel onto the patch thread with a proposal that
> > > > I'm not sure it's acceptable or not. 
> > > 
> > > You haven't sent a proposal.  This is a reply to a reply to a reply of a
> > > patch.  There's no justification for why f2fs is so special that it
> > > needs this.  What the hell is going on?  You know this is not the way to
> > > get code merged into Linux.
> > 
> > I added two ideas in that email. Have you even tried to understand?
> 
> You want to establish "user.fadvise" as an extended attribute containing
> a bitmask.  The sole bit defined in that attribute means "use large
> folios", but you also have to change the file mode and set the IMMUTABLE
> bit for it to actually do anything.

Partly yes. This path has nothing to do with IMMUTABLE bit, since I used to
activate the large folio with that bit, but hit a big pain which requires
clearing the bit whenever just deleting the file.

So, this gives a new way to activate the large folio by chmod(0400) and
setxattr("user.fadvise") only while providing quick inode eviction in order
to set mapping by iget, and allowing file deletion easily.

I feel the arguable points would be 1) the path to evict inode by calling
d_drop in release_file and returning 1 in drop_inode, 2) how to give the
hint between fadvise(FADV_LARGE_FOLIO) or setxattr(user.fadvise) by individual
file system.

> 
> Meanwhile, you can't actually persist any of the fadvise(2) advice
> flags, so the xattr name doesn't even make sense.  Maybe you meant to
> call it "user.madvise" since the closest thing I can think of is
> MADV_HUGEPAGE?
> 
> I've understood enough.  YUCK.

Thank you for taking the time to take a look.

> 
> --D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
