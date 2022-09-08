Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967DCECAAD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Sep 2022 02:19:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oW78Y-0002BK-6N;
	Thu, 08 Sep 2022 02:19:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1oW78X-0002BE-8U
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Sep 2022 02:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q0KfRdhg0wOa9MN6gZI8C2maJxNiz451+HI8ULii9eA=; b=guIRA+7bVByM7xuDe7G73bvdjp
 fLQ5lAxqk0EUES/m6JoN3Bp/JI1/Vw+k7XIOxTuCx/wA4tPcXXMx0gb1/Yy8Hd/doZf4kVhAR+CPN
 GTuEz3cfh6ncxanzToMR188yl9UyEe+o9DiGhENfDECGFDN1OSAXpI7q/GGLyVqlcTjQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q0KfRdhg0wOa9MN6gZI8C2maJxNiz451+HI8ULii9eA=; b=VRsnQ3sFfBdK6lfldaecmbrmUQ
 hVqsxjW5/QuorA3j76rog4jcy4ma5t2OtRlA9jaGZw2r8Xcmh3ugwAIflBQyTuvngFYR+CuTdhTuE
 zE6bZ5X1Bl2xv107YpsTHWoHTuPM57jmkmsQETn6Nvd2vY45CqmxsazGQZl5TcsE65AI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oW78i-0007LL-Sq for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Sep 2022 02:19:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 82250618C5;
 Thu,  8 Sep 2022 02:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C764DC433C1;
 Thu,  8 Sep 2022 02:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662603570;
 bh=ZBwM0mEwQaz0h5QIi1KTl30dxYFls2TBzdKQD+f6Yn4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sjF0M7lBOFTgnQ3d6AYWjOtRC5afZxR4mWKHQHF/B9wqpes9tiIppNfLHDDL7MDTJ
 g6WihaeVUW1bs9v3M812lttzimQiFKIJWkgwNKqrbmsUSjgJEr1hpEQd21yh6ehfOy
 g4+5o0LvWCt5IIsCW9Eqh4X0Hg7nGEr30Hgs5LHxyu/vV78M2OdOIbNQFfm+RQYaw7
 dxNs6EZpRx7ZilZI5CHOOq2W6zhcx6KszkXdgdWRuReGJ/bkrQqdRwtaaupmsV+dqb
 YC6hgIwG11ES67kaex8DgaHXiqM/+QyDYnxZGN0tdaGTj8l0AHJb75clHBi7NEV2gQ
 theHHVLZIwJjw==
Date: Wed, 7 Sep 2022 19:19:29 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YxlRMRA7AVIusfav@google.com>
References: <20220830225358.300027-1-chao@kernel.org>
 <YxlNGeh6Sr4isEFf@google.com>
 <0af788ed-8797-22a2-ae0c-433fdd6a2188@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0af788ed-8797-22a2-ae0c-433fdd6a2188@kernel.org>
X-Headers-End: 1oW78i-0007LL-Sq
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to disallow getting inner inode
 via f2fs_iget()
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

On 09/08, Chao Yu wrote:
> On 2022/9/8 10:02, Jaegeuk Kim wrote:
> > On 08/31, Chao Yu wrote:
> > > From: Chao Yu <chao.yu@oppo.com>
> > > 
> > > Introduce f2fs_iget_inner() for f2fs_fill_super() to get inner inode:
> > > meta inode, node inode or compressed inode, and add f2fs_check_nid_range()
> > > in f2fs_iget() to avoid getting inner inode from external interfaces.
> > 
> > So, we don't want to check the range of inner inode numbers? What'd be the
> > way to check it's okay?
> 
> For node_ino, meta_ino, root_ino, we have checked them in sanity_check_raw_super()
> as below:
> 
> 	/* check reserved ino info */
> 	if (le32_to_cpu(raw_super->node_ino) != 1 ||
> 		le32_to_cpu(raw_super->meta_ino) != 2 ||
> 		le32_to_cpu(raw_super->root_ino) != 3) {
> 		f2fs_info(sbi, "Invalid Fs Meta Ino: node(%u) meta(%u) root(%u)",
> 			  le32_to_cpu(raw_super->node_ino),
> 			  le32_to_cpu(raw_super->meta_ino),
> 			  le32_to_cpu(raw_super->root_ino));
> 		return -EFSCORRUPTED;
> 	}
> 
> compressed_ino should always be NM_I(sbi)->max_nid, it can be checked in
> f2fs_init_compress_inode()?

Hmm, I'm not sure whether we really need this patch, since it'd look better
to handle all the iget with single f2fs_iget?

> 
> Thanks,
> 
> > 
> > > 
> > > Signed-off-by: Chao Yu <chao.yu@oppo.com>
> > > ---
> > > v2:
> > > - don't override errno from f2fs_check_nid_range()
> > > - fix compile error
> > >   fs/f2fs/compress.c |  2 +-
> > >   fs/f2fs/f2fs.h     |  1 +
> > >   fs/f2fs/inode.c    | 13 ++++++++++++-
> > >   fs/f2fs/super.c    |  4 ++--
> > >   4 files changed, 16 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > > index 730256732a9e..c38b22bb6432 100644
> > > --- a/fs/f2fs/compress.c
> > > +++ b/fs/f2fs/compress.c
> > > @@ -1947,7 +1947,7 @@ int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
> > >   	if (!test_opt(sbi, COMPRESS_CACHE))
> > >   		return 0;
> > > -	inode = f2fs_iget(sbi->sb, F2FS_COMPRESS_INO(sbi));
> > > +	inode = f2fs_iget_inner(sbi->sb, F2FS_COMPRESS_INO(sbi));
> > >   	if (IS_ERR(inode))
> > >   		return PTR_ERR(inode);
> > >   	sbi->compress_inode = inode;
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 408d8034ed74..35f9e1a6a1bf 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -3467,6 +3467,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc);
> > >   void f2fs_set_inode_flags(struct inode *inode);
> > >   bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
> > >   void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
> > > +struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino);
> > >   struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
> > >   struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
> > >   int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
> > > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > > index 6d11c365d7b4..965f87c1dd63 100644
> > > --- a/fs/f2fs/inode.c
> > > +++ b/fs/f2fs/inode.c
> > > @@ -480,7 +480,7 @@ static int do_read_inode(struct inode *inode)
> > >   	return 0;
> > >   }
> > > -struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> > > +struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino)
> > >   {
> > >   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> > >   	struct inode *inode;
> > > @@ -568,6 +568,17 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> > >   	return ERR_PTR(ret);
> > >   }
> > > +struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = f2fs_check_nid_range(F2FS_SB(sb), ino);
> > > +	if (ret)
> > > +		return ERR_PTR(ret);
> > > +
> > > +	return f2fs_iget_inner(sb, ino);
> > > +}
> > > +
> > >   struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
> > >   {
> > >   	struct inode *inode;
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index b8e5fe244596..a5f5e7483791 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -4157,7 +4157,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> > >   		goto free_xattr_cache;
> > >   	/* get an inode for meta space */
> > > -	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
> > > +	sbi->meta_inode = f2fs_iget_inner(sb, F2FS_META_INO(sbi));
> > >   	if (IS_ERR(sbi->meta_inode)) {
> > >   		f2fs_err(sbi, "Failed to read F2FS meta data inode");
> > >   		err = PTR_ERR(sbi->meta_inode);
> > > @@ -4265,7 +4265,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> > >   		goto free_nm;
> > >   	/* get an inode for node space */
> > > -	sbi->node_inode = f2fs_iget(sb, F2FS_NODE_INO(sbi));
> > > +	sbi->node_inode = f2fs_iget_inner(sb, F2FS_NODE_INO(sbi));
> > >   	if (IS_ERR(sbi->node_inode)) {
> > >   		f2fs_err(sbi, "Failed to read node inode");
> > >   		err = PTR_ERR(sbi->node_inode);
> > > -- 
> > > 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
