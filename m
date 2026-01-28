Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0F2D35668
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jan 2026 03:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12LHkcq3CYgIb/si6i9W9N3caGvXw3U5Q5sUZrjsPPI=; b=iMsAyLcM5z+WFQD+x+hqDoK1Vf
	nBhcpJimEpT9Hq32Zbc+WYKnGs3C1HKKsocEnbq4IclI44C8pjT53RZBBnjSyhJHZnuMYdJIx9yMx
	PD3/wehSO3GH5/zzbHxBDUgEDKAIWV95C3hGIRQ7+ohrZ0jSYqAYl/Ujh5skDvcxK52A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkwIV-0007cX-IL;
	Wed, 28 Jan 2026 03:32:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkwIU-0007cJ-9v
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:32:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gkdjiW1DONcLXhHe6bY5n0jl/iHYPkluhXvekQ9QlKo=; b=gkZGyASTtvFgBONkDSUPzdj502
 9wHizhoj2V1FPnY0y7csoLcAHYjstarJn60S1OeeRMUqV1OrFqUKaWDqABpz4YnJf7M4yP7miZ6u9
 zT7o68cC6mrjHrC3VRLQZw6enzgYAv14wOMRyZzCip9Pirdzfv3wft6eaJChcSF/zV2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gkdjiW1DONcLXhHe6bY5n0jl/iHYPkluhXvekQ9QlKo=; b=fWU/LeW6nmgaKTK+LbC2/5Bf20
 nIjlDc31rgVJIXJAIDd0asLAC1JeftmWXlZ5Ve6YKWi56aTSuDBTHmVUkHtExEBIDLJesa2SXMxK2
 FTgAh3tnbknNTZUw2vhkxs4zlpcQoI5nZWNrGRbgmiNJTBzsMmOFpWQMSIsUUDshbFpg=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkwIU-0000e2-9o for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:32:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9FFA4227A8E; Wed, 28 Jan 2026 04:32:42 +0100 (CET)
Date: Wed, 28 Jan 2026 04:32:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260128033242.GA30830@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-10-hch@lst.de> <20260128032203.GA2718@sol>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260128032203.GA2718@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkwIU-0000e2-9o
Subject: Re: [f2fs-dev] [PATCH 09/16] fsverity: constify the vi pointer in
 fsverity_verification_context
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jan 27, 2026 at 07:22:03PM -0800, Eric Biggers wrote:
> On Mon, Jan 26, 2026 at 05:50:55AM +0100, Christoph Hellwig wrote:
> > struct fsverity_info contains information that is only read in the
> > verification path.  Apply the const qualifier to match various explicitly
> > passed arguments.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/verity/verify.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Did you consider that fsverity_info::hash_block_verified is written to?
> It's a pointer to an array, so the 'const' doesn't apply to its
> contents.  But logically it's still part of the fsverity information.

Well, it doesn't apply by the type rules.  But if you don't like the
const here just let me know and I'll drop it.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
