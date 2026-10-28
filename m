Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEAE606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UzM+M57P;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jEFm5df0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CResOTw/;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guqvCF2/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kNmbeK1q4TwWDihByHDuhQi3Hk6H2aX10TnQPPsqp5c=; b=UzM+M57Prz99x1Q9L2joDCeEKP
	fmwgDE+2l+YODy9X0ROkA1ID0TmBjBD82yFV3cSgPWvvafgAFUK5oyJbbImycjlfES5gBOrG0iJvs
	oUck1hbKuoNBkNIbVWor3O/fVR+C/gb9o1DIXJ+5nikVmgU/FWkbv4jEz9bTzj0NDvTY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5YL-000000002Q9-05Bb;
	Wed, 28 Oct 2026 15:27:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jaegeuk@kernel.org>) id 1xM5YK-000000002Q1-05Jb
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:27:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sirCQZqxefXuHL4irgboS/LvB2QlM6ul3cOLcu7k13Q=; b=jEFm5df0Gph9lX1qkROjnHEoRm
 E4eTJLOqpC0lnsCX99kvvdgScgg92lQIJ9GU0T78n/+80cnEjJS9J2NVdQWPt1f8Y+Ofy7doubJxp
 +qWa17IUfRrqigbhp6N6K9LxHF5w4yWbKDIwK2c677DzBXHHywJRA4m9+TNqYvOXp+c8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sirCQZqxefXuHL4irgboS/LvB2QlM6ul3cOLcu7k13Q=; b=CResOTw/1ElvS84Oj6i7dF6fhJ
 BM/PFXgZrjPsjqH7vQvXHw+oY8SGzW6yJVaprVtBRipLf+jaBC4AL1lzt1lI6h2hj3ALRsofSV/H+
 TEczlomPG/7po7Xci9fpX13jsZijvQA2LPm0QdfeMrYwxdaCtF2w8cWAY/f/8upPazbU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xM5YH-000000002xK-1lhl
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:26:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C585412C5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 15:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD9B1F01828;
 Wed, 28 Oct 2026 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793201211;
 bh=sirCQZqxefXuHL4irgboS/LvB2QlM6ul3cOLcu7k13Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=guqvCF2/p/ybbJZ0RCEKf7JZa886e8hTrp9n9QOsjENzfDTVQYeisqc9v3p+GHu2h
 NU8UmkF2W68lm/46T50nfiD8xtv23pD+mMiPmQGQbGKTPzkqnC+MglDFF735I93Ohu
 KG98TTDLY8T0YeubIjbuRlqplUD6pG97hcApOTMOzfd1/eNdK8M5f7MR334xjGYFB4
 MJmLLI6E66aCPLx62GPg4e/LjsID49KDZh6MV2LsYinC4AEGUI8kW+DY0eZgqJxF/Y
 Mt0CupN27JhaMRK6vPaUzA1msd5TAJHaQXAuWX6QEhDorrS9SxQdXWCe7+aHag2n0c
 uMxx27u+4RRWw==
Date: Wed, 28 Oct 2026 15:26:50 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <auIUOuuiz3rbwSuZ@google.com>
References: <20261028050615.259268-1-jaegeuk@kernel.org>
 <c87b011c-08fa-4e65-8b22-a6bf5a2efd5a@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c87b011c-08fa-4e65-8b22-a6bf5a2efd5a@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5YH-000000002xK-1lhl
Subject: Re: [f2fs-dev] [PATCH] f2fs: do f2fs_zero_post_eof_page for all the
 time
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28, Chao Yu via Linux-f2fs-devel wrote:
> On 10/28/26 13:06, Jaegeuk Kim via Linux-f2fs-devel wrote:
> > This fixes xfstests/generic/794, since the issue is not related to the
> > posix=strict mode only.
> 
> Jaegeuk,
> 
> Actually, I fixed this only in fsync_mode=strict because I don't see such
> scenario (described in original patch) in Android:
> 
>     Steps of generic/794:
>     1. write 4096 bytes to file w/ 0x5a
>     2. use fiemap to get PBA of first block in file
>     3. truncate file to 4080
>     4. umount; write 4096 bytes to file w/ 0x5a directly via PBA; mount
>     5. extend filesize via
>        a) append 4096 from offset 4096, or
>        b) truncate 8192, or
>        c) fallocate 4096 from offset 4096
>     6. verify the gap is zeroed in memory [4080,4096)
>     7. sync range 4096 from offset 4096; shutdown -f (flush meta before shutdown)
>     8. umount; mount; verify [4080,4096) is zeroed or not.

I saw your comment and I think we should not connect posix=strict to who's
using that. It was supposed to handle the myth of the recovery on rename().
This sequence looks general which seems we should guarantee.

> 
> Maybe we should only enable fsync_mode=strict for 794 to let it pass?
> 
> Thanks,
> 
> > 
> > Cc: stable@kernel.org
> > Fixes: 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending file size")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 8b4a7a9d7dbe..823df06ae0f2 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -74,15 +74,10 @@ static int f2fs_zero_post_eof_page(struct inode *inode,
> >  					loff_t new_size, bool lock, bool writeback)
> >  {
> >  	loff_t old_size = i_size_read(inode);
> > -	bool strict =
> > -		F2FS_OPTION(F2FS_I_SB(inode)).fsync_mode == FSYNC_MODE_STRICT;
> >  
> >  	if (old_size >= new_size)
> >  		return 0;
> >  
> > -	if (!strict && mapping_empty(inode->i_mapping))
> > -		return 0;
> > -
> >  	if (lock)
> >  		filemap_invalidate_lock(inode->i_mapping);
> >  	/* zero or drop pages only in range of [old_size, new_size] */
> > @@ -90,14 +85,9 @@ static int f2fs_zero_post_eof_page(struct inode *inode,
> >  	if (lock)
> >  		filemap_invalidate_unlock(inode->i_mapping);
> >  
> > -	if (!writeback || !strict)
> > +	if (!writeback)
> >  		return 0;
> > -	/*
> > -	 * In fsync_mode=strict, when we expand an unaligned EOF size, we
> > -	 * should zero post EOF data and writeback the data immediately,
> > -	 * so that it can avoid exposing stale data after metadata flush
> > -	 * and POR.
> > -	 */
> > +
> >  	return do_zero_post_eof_page(inode, new_size);
> >  }
> >  
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
