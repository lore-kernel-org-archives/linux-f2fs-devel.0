Return-Path: <SRS0=MwkT=MZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE3EC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Aug 2021 04:40:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D75B60EC0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Aug 2021 04:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D75B60EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mAPkK-0007dy-Kg; Mon, 02 Aug 2021 04:40:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ebiggers@kernel.org>) id 1mAPkI-0007dq-T1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Aug 2021 04:40:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XwLuKiErWn2KdaWbwbC80PGy5lvTA7lFx/p8qVP37Aw=; b=MYzopFjMdtvbXXp8gCapgwM/iB
 3VKqJVSGT2XRABiHh9YqsQOZyopd+OYWeA7SJYrYkOkFavgs6/2gAYssXtIzFA7TjnL02TqM+xguF
 6TnXYhktrwuGa3hE6gC+JxdMBsFaPlyAGN5YrOFdPOQ/dgBl4JE2W0GevwPjst3+9auo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XwLuKiErWn2KdaWbwbC80PGy5lvTA7lFx/p8qVP37Aw=; b=RhMeuIaefnb9vY+MbHz1AAY9J3
 hli21mAsxmXaKBNDe2seu8F0wW6rctc3GHUEnV9CvckTmaJ+L90S+MK49xT2UD95rJhkkGThPLhEY
 2I+LAJFjGUGzoK/H2S/x4CtQAMdXJdcISegP+u9c09ZrqWtkhqppzoYGMYoBbqWnf3HA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mAPkH-0008RM-NV
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Aug 2021 04:40:10 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 166BE60FC1;
 Mon,  2 Aug 2021 04:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627879199;
 bh=qmobRmA+yWKnNrYpDsC8VuTL9aCRxBaKljY1RtdSS/M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d6itMxKmjJac1CWHBdeojjaRGCFdZTHcTaeXudtPUJuPOe1No/durs9ba5gFKlXLF
 68b1wjODd1YzpJqC9imT3YoyVJRAGlfw4JPmUfI0j8ONGdBkTEvCBZ0MsIPgumdEYL
 qIIzns4n0gmeffxEWK/5o0wrwp2BppnVXiyctW56fKI2LD9m+F7lwWaT2GkqfS3VA1
 cSaSLpL4Qk5co/QM66eQ0t+gl+g/Fq1noylZXLV2hNajRKKpzdATegXYACzWTWUZq6
 WCZvrIlzePRxV2kCdufa2eJrcI5UZytwIs8gQejBXYfo+yvW5QO4tK525W2tJ0t3Oo
 muAOf1B4L1EiQ==
Date: Sun, 1 Aug 2021 21:39:57 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Message-ID: <YQd3Hbid/mFm0o24@sol.localdomain>
References: <20210728015154.171507-1-ebiggers@kernel.org>
 <YQRQRh1zUHSIzcC/@gmail.com> <YQS5eBljtztWwOFE@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YQS5eBljtztWwOFE@mit.edu>
X-Headers-End: 1mAPkH-0008RM-NV
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove broken support for allocating
 DIO writes
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
Cc: linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 30, 2021 at 10:46:16PM -0400, Theodore Ts'o wrote:
> On Fri, Jul 30, 2021 at 12:17:26PM -0700, Eric Biggers wrote:
> > > Currently, non-overwrite DIO writes are fundamentally unsafe on f2fs as
> > > they require preallocating blocks, but f2fs doesn't support unwritten
> > > blocks and therefore has to preallocate the blocks as regular blocks.
> > > f2fs has no way to reliably roll back such preallocations, so as a
> > > result, f2fs will leak uninitialized blocks to users if a DIO write
> > > doesn't fully complete.
> 
> There's another way of solving this problem which doesn't require
> supporting unwritten blocks.  What a file system *could* do is to
> allocate the blocks, but *not* update the on-disk data structures ---
> so the allocation happens in memory only, so you know that the
> physical blocks won't get used for another files, and then issue the
> data block writes.  On the block I/O completion, trigger a workqueue
> function which updates the on-disk metadata to assign physical blocks
> to the inode.
> 
> That way if you crash before the data I/O has a chance to complete,
> the on-disk logical block -> physical block map hasn't been updated
> yet, and so you don't need to worry about leaking uninitialized blocks.
> 
> Cheers,
> 
> 					- Ted

Jaegeuk and Chao, any idea how feasible it would be for f2fs to do this?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
