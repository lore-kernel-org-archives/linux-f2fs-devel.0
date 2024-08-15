Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D172C3DA7F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Aug 2024 15:29:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1secQG-0007Rh-Pl;
	Thu, 15 Aug 2024 15:29:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1secQF-0007RY-Vy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Aug 2024 15:29:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1mZiZFbZ8AVayKwgNBvTWTGW1BcKgt8tOYnNG5pEUgs=; b=H1OOkHWeez+6iRKaF17xEuuJoA
 +uClL4Pi1WEtZW6IZIfjGocIWz4VZun2jRdUBhD/koJn4QIyxtAJQRKheB7IT48vUKRw9csxFB63z
 NQWCZU+01YhsSYtq7PN7IbCtOSef7A+qGdx628edBpr0zodkXhnyFWtmjhw62Goxcqf8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1mZiZFbZ8AVayKwgNBvTWTGW1BcKgt8tOYnNG5pEUgs=; b=My8o45jQD4vRcHj31M9x7725iX
 MPKQe6X1E6WsW3baN9kVR30wNyaZxKejyuk55Jdv+LbRGdf5nc+jnDQ7wfjpQeP/b1aUg9rnmZjva
 CgsyQfnT3gz1DnA38VwR2QC2Z/4VqbBMO2AA1NXQDgjgTZpcplhJniqUTSqVAOvsZTbM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1secQF-0008Tj-7J for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Aug 2024 15:29:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D319C61E65;
 Thu, 15 Aug 2024 15:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7A8C32786;
 Thu, 15 Aug 2024 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723735789;
 bh=pI8L/RvDGnryLxS0LDdr60wqC3uvj+nWgBAUoDUazXI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JdKjJPlf7v2Y1Lj7NmPGxBj4PKcneKao15DLyuq6cyuN/6U7Xw+DMnG6coeXyvVOx
 IX2LuVvHV3fUM45Q6Oy5+OuoEs/KJ0aR1mMKQYy9B2X/mJqGfqib+coF3Zcannz+VR
 RL0X4mUr9Df55fKbkhSy/UBfZZ9Qulf0jziRZDyRmcZmUMTqyNHD5//RGOcSNfrP7S
 qnuXLJG+aRKj5SupigskfsktTuIVvoKGo2KcXs7sLdBZndPlUlooJsps4XpTjKeco+
 Tm+RLWbsKx4K1MGzXBGNSoEUJDO2VAb/uP1mwJxjxj+hM9ghfR43KqktxnSQIQhKho
 yqHyCFPBSMJIQ==
Date: Thu, 15 Aug 2024 15:29:47 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Message-ID: <Zr4e6zsKOotTLVTp@google.com>
References: <20240814211640.167728-1-djahchankoike@gmail.com>
 <efcc15bf-0248-4690-b4d4-11022d12cffd@kernel.org>
 <CAJwTMzrXOBrZ2XSG4GykDhjeTAztO8j1h8zoAFGZeZBqZF5brQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJwTMzrXOBrZ2XSG4GykDhjeTAztO8j1h8zoAFGZeZBqZF5brQ@mail.gmail.com>
X-Headers-End: 1secQF-0008Tj-7J
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix unreleased reader lock on return
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
Cc: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/15, Diogo Jahchan Koike wrote:
> No problem whatsoever.

Thanks. I removed the original patch from -next. Chao, please post a fixed
version.

> 
> Thanks,
> 
> Em qua., 14 de ago. de 2024, 21:51, Chao Yu <chao@kernel.org> escreveu:
> 
> > On 2024/8/15 5:16, Diogo Jahchan Koike wrote:
> > > fix reader lock unreleased in error path.
> >
> > Thank you for catching this, if you don't mind, I'd like to merge it to
> > original patch, since it is still in dev-test branch.
> >
> > Thanks,
> >
> > >
> > > Fixes: 374a8881ce4c ("f2fs: atomic: fix to forbid dio in atomic_file")
> > > Reported-by: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=733300ca0a9baca7e245
> > > Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> > > ---
> > >   fs/f2fs/file.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 51f6ffd5f4e2..c9eda5dbd11f 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -2172,6 +2172,7 @@ static int f2fs_ioc_start_atomic_write(struct file
> > *filp, bool truncate)
> > >       ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> > >       if (ret) {
> > >               f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > +             f2fs_up_write(&fi->i_gc_rwsem[READ]);
> > >               goto out;
> > >       }
> > >
> > > @@ -2181,6 +2182,7 @@ static int f2fs_ioc_start_atomic_write(struct file
> > *filp, bool truncate)
> > >               pinode = f2fs_iget(inode->i_sb, fi->i_pino);
> > >               if (IS_ERR(pinode)) {
> > >                       f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > +                     f2fs_up_write(&fi->i_gc_rwsem[READ]);
> > >                       ret = PTR_ERR(pinode);
> > >                       goto out;
> > >               }
> > > @@ -2189,6 +2191,7 @@ static int f2fs_ioc_start_atomic_write(struct file
> > *filp, bool truncate)
> > >               iput(pinode);
> > >               if (ret) {
> > >                       f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > +                     f2fs_up_write(&fi->i_gc_rwsem[READ]);
> > >                       goto out;
> > >               }
> > >
> > > @@ -2202,6 +2205,7 @@ static int f2fs_ioc_start_atomic_write(struct file
> > *filp, bool truncate)
> > >               ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> > >               if (ret) {
> > >                       f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > +                     f2fs_up_write(&fi->i_gc_rwsem[READ]);
> > >                       goto out;
> > >               }
> > >       }
> >
> >


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
