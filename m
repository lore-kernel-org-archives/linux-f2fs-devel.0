Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11D4C88E43
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 04:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gYe1y4eQjad6OnwzprH4M4psoRREUswMu5QoK65ka9w=; b=KwmUJEeY0JhOEFiieEqMsYEbHJ
	XybiSdI9muFjzRoqSGVhICUl1DU2u0nJygWrZFlVB62WORvrqD8wRa4YkT6HnVwFN2M6dXmWsEUNA
	gOzZIjP2O6e4rq9Rmqr/D0oj85BgFS3ubM53aPvgkhHvZ1swsxfJTksTRRX+JtFmKvhM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkEI1-0003Ch-MW;
	Mon, 26 Jan 2026 04:33:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkEI0-0003Cb-4d
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 04:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KAScXC0xia46gtLJzlrSkqzXTVu6cXYPrxzb2fg1qZI=; b=ihMwMjWk985T9oaV0KqeAbtJ3v
 Z8b8hvVCAmCCr4Vamft3qKHWjd8wOIiEWHsQohtILbyj1LC/Mou4x3keOfwvCPWL3ko5NAbSRC7NV
 /EP8LZScbkfi2yeFJu+mLpQRHQQzDtYWeJsSgi8H3lSXFIvgf4lZZjzHsxpzwzZMWA9k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KAScXC0xia46gtLJzlrSkqzXTVu6cXYPrxzb2fg1qZI=; b=O3U/NOOnMRXVT8E2G1HdBr3W9S
 AfXDEzZoejfRJnCu2mqkvYSJIjtSbuv4lxwMA+K1INcT1dcRLIobeFG8GYLjyPToguO1ql2FdpSKd
 vzk0Jkt9+XEMZ5gSlorBvzSiCl7drM4WeSawM3HW8pnrn0ez51Yi7rZMvbv+XZtZ4sM4=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkEI0-00012r-Cq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 04:33:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D3E6F227A88; Mon, 26 Jan 2026 05:33:11 +0100 (CET)
Date: Mon, 26 Jan 2026 05:33:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260126043311.GC30803@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-7-hch@lst.de> <20260124211956.GF2762@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260124211956.GF2762@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkEI0-00012r-Cq
Subject: Re: [f2fs-dev] [PATCH 06/11] fsverity: push out fsverity_info lookup
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
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jan 24, 2026 at 01:19:56PM -0800, Eric Biggers wrote:
> This patch introduces another bisection hazard by adding calls to
> fsverity_info_addr() when CONFIG_FS_VERITY=n.  fsverity_info_addr() has
> a definition only when CONFIG_FS_VERITY=y.
> 
> Maybe temporarily add a CONFIG_FS_VERITY=n stub for fsverity_info_addr()
> that returns NULL, and also ensure that it's dereferenced only when it's
> known that fsverity verification is needed.  Most of the call sites look
> okay, but the second one in ext4_mpage_readpages() needs to be fixed.

I've added an external declaration for fsverity_info_addr in the
CONFIG_FS_VERITY=n so that the linker catches unguarded references.  It 
caught two, which I fixed by adding IS_ENABLED checks that also reduce
the code size for non-fsverity builds.

> > -	fsverity_init_verification_context(&ctx, inode);
> > +	fsverity_init_verification_context(&ctx, inode, vi);
> 
> Note that fsverity_info has a back-pointer to the inode.  So,
> fsverity_init_verification_context() could just take the vi and set
> ctx->inode to vi->inode.
> 
> Then it wouldn't be necessary to get the inode from
> bio_first_folio_all(bio)->mapping->host (in fsverity_verify_bio()) or
> folio->mapping->host (in fsverity_verify_blocks()).
> Similarly in fsverity_readahead() too.
> 
> (It might make sense to handle this part as a separate patch.)

To be able to nicely used this vi->inode needs to lose the const
qualifier.  I've done that, and also added a const qualifiers
to ctx->vi while at it in prep patches.  With that just using
vi->inode in this patch is easy enough.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
