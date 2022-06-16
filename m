Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE3FCCA47D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jun 2022 00:05:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1d0c-0002KP-25; Thu, 16 Jun 2022 00:05:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1o1d0a-0002KJ-8C
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 00:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TjrLziy58ZPaAU3v+9B9SU6cvHeqP5a6AK4pBCNtki4=; b=LUnhb2/E4TfsCMoy1dwSsc1+GJ
 V2vzc2ZhMDiSfnecugwdzhEKOuNB5AivrDoSni6SCuCKGFIX158WAs6EW3yoNqN328QcZo6Os5H/0
 OS9kMuxy6F6Am3GxB+HHbsalpulUkpT7q070a7bJZ2I/rH4FUh3kn7C3SHsJS7xTFddY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TjrLziy58ZPaAU3v+9B9SU6cvHeqP5a6AK4pBCNtki4=; b=GVjKuWEbfLN/DOkdqksId7r/vk
 fwnSYVRsyZ6zZ7vZF+bFrc4B6Ut2ECizZXZIiiXGJZ8i65fREuPjIBybXAOD+mdnZkwpPnaibhRFt
 P/er8Hnoxo1s0atp5dN7eq7Y/0yJTWlFM93F7eiewBgH0Lu1nEo6o29tNbkY14gTLXgk=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o1d0W-003SLf-2e
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 00:05:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E5C58B82201;
 Thu, 16 Jun 2022 00:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE0FC3411A;
 Thu, 16 Jun 2022 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655337899;
 bh=twKDf6UE+kS3vngFTnZTxVTzoWdtagr989JXNITgwOw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jgVdLgvp0/JpnSn+TbW+19ECVOHgg2dvTd36K9dJ22dJewyA3ZwH85RLqqQhJ4rwu
 eQRyLfRWbmNBVSY1p7ja1StME1gpGVXoweCk085gvuq5K3fYghi7s3zN8llC5NB4DT
 7wMD56EHiUonIGs1WJIuErOZsdSVBXzjwJossod7XVa/UXSqTAr+0i+J9fC9mSo86u
 MC0so6r8yjPi2hY2EBAN05ziiHSbiTb48hzbZsYl8kqWGa29RP58h+SFfWlo9UOmhj
 mkduUSoEiKc7lQO9oM1+UBROu6epiy9J3JLrz6s5NI0683ClKMWFzU9kyryIEZ0z5n
 RaO3GdDZGXmCw==
Date: Wed, 15 Jun 2022 17:04:57 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <YqpzqZQgu0Zz+vW1@sol.localdomain>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
 <20220520032739.GB1098723@dread.disaster.area>
 <YqgbuDbdH2OLcbC7@sol.localdomain> <YqnapOLvHDmX/3py@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqnapOLvHDmX/3py@infradead.org>
X-Headers-End: 1o1d0W-003SLf-2e
Subject: Re: [f2fs-dev] [RFC PATCH v2 1/7] statx: add I/O alignment
 information
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
Cc: linux-block@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 15, 2022 at 06:12:04AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 13, 2022 at 10:25:12PM -0700, Eric Biggers wrote:
> > While working on the man-pages update, I'm having second thoughts about the
> > stx_offset_align_optimal field.  Does any filesystem other than XFS actually
> > want stx_offset_align_optimal, when st[x]_blksize already exists?  Many network
> > filesystems, as well as tmpfs when hugepages are enabled, already report large
> > (megabytes) sizes in st[x]_blksize.  And all documentation I looked at (man
> > pages for Linux, POSIX, FreeBSD, NetBSD, macOS) documents st_blksize as
> > something like "the preferred blocksize for efficient I/O".  It's never
> > documented as being limited to PAGE_SIZE, which makes sense because it's not.
> 
> Yes.  While st_blksize is utterly misnamed, it has always aways been
> the optimal I/O size.
> 
> > Perhaps for now we should just add STATX_DIOALIGN instead of STATX_IOALIGN,
> > leaving out the stx_offset_align_optimal field?  What do people think?
> 
> Yes, this sounds like a good plan.

One more thing.  I'm trying to add support for STATX_DIOALIGN on block devices.
Unfortunately I don't think it is going to work, at all, since the inode is for
the device node and not the block device itself.  This is true even after the
file is opened (I previously thought that at least that case would work).

Were you expecting that this would work on block devices?  It seems they will
need a different API -- a new BLK* ioctl, or files in /sys/block/$dev/queue.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
