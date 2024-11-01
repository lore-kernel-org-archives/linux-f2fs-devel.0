Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99616E6F062
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Nov 2024 21:06:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t6yqs-0005I4-OT;
	Fri, 01 Nov 2024 21:06:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1t6yqn-0005Ht-7X
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Nov 2024 21:06:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iaciUbOy8Rob9F1D5vlQ/KPnw+oMAYNTqUYT/ABfBmE=; b=Xt02xX5+Se6nbXVcixDX3jYY9Y
 VT3Ybxj/f6SfUGaBMBiF6XWzv/A+yQaTEVfYi4Pci8cLMXyc2KzN7SxSFQ3RHBDQDnWiilbPzrssj
 mcyCc1lYynvOPMG267Q9MGPovNoXCuF+fDWBz9VXB/esP++pVf1ThDnpoPEiQdkp5QW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iaciUbOy8Rob9F1D5vlQ/KPnw+oMAYNTqUYT/ABfBmE=; b=LBazJyMROZVgdYacaI5/xMbM4R
 sMZhu2L9ICTivEVQ1WOege2JNbJYODQUzF+OL2ls8TGRvmIDCAid2fqZa55H34RRAjYipwYGvxiqL
 dGxcK1i7DsvHr6YJ1VTJZiZfQHsqEYUB9mymtm8wbQxEik7Vgk9t8wT83C9KrG2BzucM=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t6yqn-0003to-8t for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Nov 2024 21:06:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 164EAA44DCF;
 Fri,  1 Nov 2024 21:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CDEC4CECD;
 Fri,  1 Nov 2024 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730495187;
 bh=6r0kSGz22uyB0SBpH5zjJIdf6qncKwiekp9O4rAUAUA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EOLbFIMGNUKs72gZPgmR4wOxbn3G0A+8h2r/vLQzpb1TtSkfi9g9mFvv2Zc7SDk44
 q/NbICTH+a5uSel23gTHJA6FZ/dAcNHgbjS/WGXS2k/kEAXLBORtIB4KjMsxOtEkD/
 04QbSjBcUJSfbWgQyOo1GQRJltodhEzf27AJCEYz1soebWko8dktEV6xk07c8tk4ND
 W7RmEqm2gDOieEmtVosjPbO85LX/LFgZpZBdZtpJLNcPoB8M1T0wQ3KPegAFFjE3iX
 CtqPkML/7kZr5oyAdVIEUAx9Pj33EzGLV9CWtGRA3zLR2SWfOHMJ4gIbiIW7Gx6ocJ
 RRoXjubbrlURA==
Date: Fri, 1 Nov 2024 21:06:25 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <ZyVC0R8JYwMZXM9u@google.com>
References: <20241031102200.440407-1-chao@kernel.org>
 <ZyQtcbtzpixFd6Zs@google.com>
 <fede8a9b-8532-4d63-a4db-b52ed088d6f8@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fede8a9b-8532-4d63-a4db-b52ed088d6f8@kernel.org>
X-Headers-End: 1t6yqn-0003to-8t
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to map blocks correctly for direct
 read
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
Cc: kernel test robot <oliver.sang@intel.com>, linux-kernel@vger.kernel.org,
 Cyril Hrubis <chrubis@suse.cz>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/01, Chao Yu wrote:
> On 2024/11/1 9:22, Jaegeuk Kim wrote:
> > On 10/31, Chao Yu wrote:
> > > f2fs_map_blocks() supports to map continuous holes or preallocated
> > > address, we should avoid setting F2FS_MAP_MAPPED for these cases
> > > only, otherwise, it may fail f2fs_iomap_begin(), and make direct
> > > write fallbacking to use buffered IO and flush, result in performance
> > > regression.
> > 
> > Is this fixing direct write or read?
> 
> Direct write.

I was confising the patch subject is saying direct read.

> 
> > 
> > > 
> > > Fixes: 9f0f6bf42714 ("f2fs: support to map continuous holes or preallocated address")
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202409122103.e45aa13b-oliver.sang@intel.com
> > > Cc: Cyril Hrubis <chrubis@suse.cz>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/data.c | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 306b86b0595d..38b85160c6bd 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -1676,7 +1676,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
> > >   		/* reserved delalloc block should be mapped for fiemap. */
> > >   		if (blkaddr == NEW_ADDR)
> > >   			map->m_flags |= F2FS_MAP_DELALLOC;
> > > -		if (flag != F2FS_GET_BLOCK_DIO || !is_hole)
> > > +		/*
> > > +		 * f2fs_map_blocks() supports to map continuous holes or
> > > +		 * preallocated address, don't set F2FS_MAP_MAPPED for these
> > > +		 * cases only.
> > > +		 */
> > > +		if (flag != F2FS_GET_BLOCK_DIO || map->m_may_create || !is_hole)
> > 
> > So, this is adding map->m_may_create, which is for writes?
> 
> map->m_may_create is added for write path, w/o this condition, f2fs_map_blocks()
> may missed to tag F2FS_MAP_MAPPED, result in that f2fs_iomap_begin() will return
> -ENOTBLK.

Is that something like this?

/* DIO READ and hole case, should not map the blocks. */
if (!(flag == F2FS_GET_BLOCK_DIO && is_hole && !map->m_may_create))

> 
> Am I missing someting?
> 
> Thanks,
> 
> > 
> > >   			map->m_flags |= F2FS_MAP_MAPPED;
> > >   		map->m_pblk = blkaddr;
> > > -- 
> > > 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
