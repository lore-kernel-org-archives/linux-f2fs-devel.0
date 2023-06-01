Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18973C77B7E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Jun 2023 15:25:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4kAf-0006Nz-AE;
	Thu, 01 Jun 2023 15:25:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1q4kAc-0006Nh-DW
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 15:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NMMC3ehgaWslWeASfjcmQ+SuyyB+zQPCwx9GtXbqe3Y=; b=m3TqboXxe2m5UVFlHqQmVqLTVW
 eRA8OnL0Fcrsnf+WgZnoKLy6reHxDUlFPG93juPSNZB272gzwt+YU3Udl57sKo74T/xVBfonW0dbI
 bWyXsEujBak2sGHgPMUMNnKMbmWrOZ3T5F5ZSgsT2RcUPrXb2YV/gtr6fXV79PNwwBkM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NMMC3ehgaWslWeASfjcmQ+SuyyB+zQPCwx9GtXbqe3Y=; b=easxQe5geB8JpnqK2HIVxD/N8l
 Zkho9vHOoXJFr+EDtpqCtCxNZZ/MbhTiv8CqMLS6KFtMujdZ4PyGtrRZP0LA7+E/09McWcsBPvzBP
 h6F37zQ2sDqDdtcWsN6BGsFOJxU0qP9SiMtNo80gQY7mhlJ9t/XpDBZ2BBOiSFNqczq4=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1q4kAa-008TmV-Fn for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 15:24:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 439421FDAF;
 Thu,  1 Jun 2023 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685633090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NMMC3ehgaWslWeASfjcmQ+SuyyB+zQPCwx9GtXbqe3Y=;
 b=WjHviSuQYqQL5ww/WGZrxQ9IaSK+faKZeFG2YF8j1TneF9hscLLx1tqg0Bx8EgldewEIHi
 PBEV92dYJc9WiX/PL/Fl3kvtNUHQ7iVPTlmwqgOKI3ucMytqhW2aWsSuZSvUhP7hf/zFKn
 KNnBc370aTHSrj3tbsurPTnkkfqoXmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685633090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NMMC3ehgaWslWeASfjcmQ+SuyyB+zQPCwx9GtXbqe3Y=;
 b=9kcmzqr/0hZ1iA49qNNzf1cUeGB4/rjsaKBaQ3EqCfnWgDiqMRyj80AFflpKW9e0YgPeZl
 nKRmR487X7h99zBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3109D139B7;
 Thu,  1 Jun 2023 15:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7FLvC0K4eGQuawAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 15:24:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 91EB1A0754; Thu,  1 Jun 2023 17:24:49 +0200 (CEST)
Date: Thu, 1 Jun 2023 17:24:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20230601152449.h4ur5zrfqjqygujd@quack3>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-4-jack@suse.cz>
 <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
X-Headers-End: 1q4kAa-008TmV-Fn
Subject: Re: [f2fs-dev] [PATCH v2 4/6] fs: Establish locking order for
 unrelated directories
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
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
 "Darrick J. Wong" <djwong@kernel.org>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Al Viro <viro@ZenIV.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-fsdevel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu 01-06-23 15:58:58, Christian Brauner wrote:
> On Thu, Jun 01, 2023 at 12:58:24PM +0200, Jan Kara wrote:
> > Currently the locking order of inode locks for directories that are not
> > in ancestor relationship is not defined because all operations that
> > needed to lock two directories like this were serialized by
> > sb->s_vfs_rename_mutex. However some filesystems need to lock two
> > subdirectories for RENAME_EXCHANGE operations and for this we need the
> > locking order established even for two tree-unrelated directories.
> > Provide a helper function lock_two_inodes() that establishes lock
> > ordering for any two inodes and use it in lock_two_directories().
> > 
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/inode.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  fs/internal.h |  2 ++
> >  fs/namei.c    |  4 ++--
> >  3 files changed, 46 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 577799b7855f..4000ab08bbc0 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1103,6 +1103,48 @@ void discard_new_inode(struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(discard_new_inode);
> >  
> > +/**
> > + * lock_two_inodes - lock two inodes (may be regular files but also dirs)
> > + *
> > + * Lock any non-NULL argument. The caller must make sure that if he is passing
> > + * in two directories, one is not ancestor of the other.  Zero, one or two
> > + * objects may be locked by this function.
> > + *
> > + * @inode1: first inode to lock
> > + * @inode2: second inode to lock
> > + * @subclass1: inode lock subclass for the first lock obtained
> > + * @subclass2: inode lock subclass for the second lock obtained
> > + */
> > +void lock_two_inodes(struct inode *inode1, struct inode *inode2,
> > +		     unsigned subclass1, unsigned subclass2)
> > +{
> > +	if (!inode1 || !inode2)
> 
> I think you forgot the opening bracket...
> I can just fix this up for you though.

Oh, yes. Apparently I forgot to rerun git-format-patch after fixing up this
bit. I'm sorry for that. The patch series has survived full ext4 fstests
run on my end.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
