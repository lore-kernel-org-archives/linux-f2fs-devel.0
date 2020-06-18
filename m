Return-Path: <SRS0=lp92=77=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4E8C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:19:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF25A21655;
	Thu, 18 Jun 2020 03:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="RCpNoMGn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="abSVc0Ry";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5nCURSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF25A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jll5h-0001hg-Gh; Thu, 18 Jun 2020 03:19:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jll5g-0001ha-HZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 03:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Www09a6bFx38w4GfVPRKKs55jTJaVd2JT+jKpc98YOg=; b=RCpNoMGnK9GHn4s+lWiriGQKHE
 EanSmBx51MxwElrf7FtCdZMVAgxMoMtE4xv/BNK07cnom3OCbclIEkRAGgNF/UfEBYLc2mJqCpVzf
 /0Ecc2jq97+isc69N5dltDOJvPpulZyJFA5lQ9rOSTDfaA9hW55S623bAST6Qm82BhVE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Www09a6bFx38w4GfVPRKKs55jTJaVd2JT+jKpc98YOg=; b=abSVc0Ry3fecno3sXXXo8wncob
 ONGhUs1Mtf9DF16v+OXqggoa2jLo9c/gPxCAMM65o8QgrjhUc7yU0GrIC8h6QsMmHiNNGwrQfFamH
 AB0+QdRMxUAT5kdUO1kTicKPM/jQSTEUu4b8DbYadT0LuokxQCtxkfzG9h38zTyJXChA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jll5f-0076SI-7b
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 03:19:48 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CA20121655;
 Thu, 18 Jun 2020 03:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592450377;
 bh=tb8eihrC/QSLy1DAOwhuACWDwQVJ7zu3gsQrF0KN6W8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a5nCURSUqqX0UUIMT3I1h+OR1Z2Lak9E0lXPKq4jwQjzuth5mpakN9gMWOWgW28le
 iBadBT/YYRVhbmROBTA8eyC4fXxTYGMBV6FXAkaHv0RPZTWMbFzIkffZxMoC7MZbDp
 pHdoOal6ViKvmNvO1MAYr0rTmaoWUMSAjjssWUlE=
Date: Wed, 17 Jun 2020 20:19:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Message-ID: <20200618031935.GE1138@sol.localdomain>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-2-satyat@google.com>
 <20200618011912.GA2040@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618011912.GA2040@dread.disaster.area>
X-Headers-End: 1jll5f-0076SI-7b
Subject: Re: [f2fs-dev] [PATCH 1/4] fs: introduce SB_INLINECRYPT
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 18, 2020 at 11:19:12AM +1000, Dave Chinner wrote:
> On Wed, Jun 17, 2020 at 07:57:29AM +0000, Satya Tangirala wrote:
> > Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
> > blk-crypto for file content en/decryption. This flag maps to the
> > '-o inlinecrypt' mount option which multiple filesystems will implement,
> > and code in fs/crypto/ needs to be able to check for this mount option
> > in a filesystem-independent way.
> > 
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> > ---
> >  fs/proc_namespace.c | 1 +
> >  include/linux/fs.h  | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> > index 3059a9394c2d..e0ff1f6ac8f1 100644
> > --- a/fs/proc_namespace.c
> > +++ b/fs/proc_namespace.c
> > @@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
> >  		{ SB_DIRSYNC, ",dirsync" },
> >  		{ SB_MANDLOCK, ",mand" },
> >  		{ SB_LAZYTIME, ",lazytime" },
> > +		{ SB_INLINECRYPT, ",inlinecrypt" },
> >  		{ 0, NULL }
> >  	};
> >  	const struct proc_fs_opts *fs_infop;
> 
> NACK.
> 
> SB_* flgs are for functionality enabled on the superblock, not for
> indicating mount options that have been set by the user.

That's an interesting claim, given that most SB_* flags are for mount options.
E.g.:

	ro => SB_RDONLY
	nosuid => SB_NOSUID
	nodev => SB_NODEV
	noexec => SB_NOEXEC
	sync => SB_SYNCHRONOUS
	mand => SB_MANDLOCK
	noatime => SB_NOATIME
	nodiratime => SB_NODIRATIME
	lazytime => SB_LAZYTIME

> 
> If the mount options are directly parsed by the filesystem option
> parser (as is done later in this patchset), then the mount option
> setting should be emitted by the filesystem's ->show_options
> function, not a generic function.
> 
> The option string must match what the filesystem defines, not
> require separate per-filesystem and VFS definitions of the same
> option that people could potentially get wrong (*cough* i_version vs
> iversion *cough*)....

Are you objecting to the use of a SB_* flag, or just to showing the flag in
show_sb_opts() instead of in the individual filesystems?  Note that the SB_*
flag was requested by Christoph
(https://lkml.kernel.org/r/20191031183217.GF23601@infradead.org/,
https://lkml.kernel.org/r/20191031212103.GA6244@infradead.org/).  We originally
used a function fscrypt_operations::inline_crypt_enabled() instead.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
