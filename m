Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9FEC3DA61
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 27 Jul 2024 03:27:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sXY5r-0005TN-8L;
	Sat, 27 Jul 2024 03:27:39 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sXY5p-0005T5-E4
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Jul 2024 03:27:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i9LO/Kp21r/c70NqZtUYK/BqTQXs0UQPTA4VjzLgBmM=; b=bubKYAvtODRkY3X4ggJRsfD7r/
 Ztdy24EnXb/OHEzj2DhWSluxqccC0GhL+3OVF3UFPZUVVkY1ZByDYrBsSNTAA8FjqWNd+IP2xHj22
 y4OKgd3zB4j/P4/umnyqPmrSMkm02tKKLu5s9IGI+22pMJHVmipPY/sf2Agp37nV2kfQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i9LO/Kp21r/c70NqZtUYK/BqTQXs0UQPTA4VjzLgBmM=; b=WIcy4CAPBCYqOUcfeI6RjHixOZ
 ubCPLILaL/DxfNf1c2dQowHW4Cwfco+uCJL/MZMG2+h0RJGgNiutrVqfnspXOAZFTIn1fQGs/rfoD
 QE+TYXEISm8JSh8q2PvbX8F0a3wU8Ktgy3piFVgY7SiYfrOXBx0zHPZtI2EUS/kKw6eY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sXY5o-0008Kq-OI for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Jul 2024 03:27:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 678B56126C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 27 Jul 2024 03:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5518C32781;
 Sat, 27 Jul 2024 03:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722050846;
 bh=S+kQb6Aea11p16gcRO1Yz5vgGsQTxv5epZ7ksHNbHfI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GTjo2alEa4C0Y1f7pPT7UaySLATpnYxt2jSDvGPDaK/Z9YB6EwU1UFyLB2Emx1d4M
 O/8KllXJKogsI6JKtQHhfGG5CPAFn+GL+gt/cej4SYXESggZKqAp7izek6wbgwIgMJ
 R7qAKXJkYvp8e5tZ1UVGM7pgD97UzjgX/kFQaEPURGIYWDFYL4o0cBYzdbQyIA3s0+
 Bkb/ZiYCuF18RSsfE0iVFruaw4QOB3uIXy7InOP75Lx4b6NIwuuRTmiFl/N/QyvQfo
 QGQgI1CkPtY/92dqgOnqI3yN0tvF9aDRQLCw2Hq6KKgfcWUlM3uGTFZFKFfb8fYLtG
 mG2L6hYNLhh2g==
Date: Sat, 27 Jul 2024 03:27:24 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZqRpHOJyWU3Sn8Ma@google.com>
References: <20240712073415.227226-1-chao@kernel.org>
 <ZqKDnpzwX85RyGaa@google.com>
 <c2b7d0cd-ea10-4e25-829c-53967927bd03@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c2b7d0cd-ea10-4e25-829c-53967927bd03@kernel.org>
X-Headers-End: 1sXY5o-0008Kq-OI
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't traverse directory blocks after
 EOF
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/26, Chao Yu wrote:
> On 2024/7/26 0:55, Jaegeuk Kim wrote:
> > On 07/12, Chao Yu wrote:
> > > All directory blocks are within the scope of i_size, so let's limit
> > > the end_block to just check valid dirent blocks.
> > 
> > Do we really need this?
> 
> f2fs_readdir() and f2fs_empty_dir() uses dir_blocks() for upper boundary,
> this patch aligns find_in_level() w/ them.
> 
> Also, it can avoid grabbing never used page cache across EOF.
> 
> So, we can consider taking this patch?

I'm wondering whether the current code has a bug or not.

> 
> Thanks,
> 
> > 
> > > 
> > > Meanwhile, it uses dir_blocks() instead of variable for cleanup in
> > > __f2fs_find_entry().
> > > 
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/dir.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > > index 02c9355176d3..d4591c215f07 100644
> > > --- a/fs/f2fs/dir.c
> > > +++ b/fs/f2fs/dir.c
> > > @@ -305,18 +305,21 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
> > >   	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
> > >   	unsigned int nbucket, nblock;
> > >   	unsigned int bidx, end_block;
> > > +	unsigned long last_block;
> > >   	struct page *dentry_page;
> > >   	struct f2fs_dir_entry *de = NULL;
> > >   	pgoff_t next_pgofs;
> > >   	bool room = false;
> > >   	int max_slots;
> > > +	last_block = dir_blocks(dir);
> > >   	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
> > >   	nblock = bucket_blocks(level);
> > >   	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
> > >   			       le32_to_cpu(fname->hash) % nbucket);
> > >   	end_block = bidx + nblock;
> > > +	end_block = min_t(unsigned int, end_block, last_block);
> > >   	while (bidx < end_block) {
> > >   		/* no need to allocate new dentry pages to all the indices */
> > > @@ -361,7 +364,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
> > >   					 const struct f2fs_filename *fname,
> > >   					 struct page **res_page)
> > >   {
> > > -	unsigned long npages = dir_blocks(dir);
> > >   	struct f2fs_dir_entry *de = NULL;
> > >   	unsigned int max_depth;
> > >   	unsigned int level;
> > > @@ -373,7 +375,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
> > >   		goto out;
> > >   	}
> > > -	if (npages == 0)
> > > +	if (dir_blocks(dir) == 0)
> > >   		goto out;
> > >   	max_depth = F2FS_I(dir)->i_current_depth;
> > > -- 
> > > 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
