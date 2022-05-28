Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DD1C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 28 May 2022 05:12:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nuokv-0006qu-Vr; Sat, 28 May 2022 05:12:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <david@fromorbit.com>) id 1nuoku-0006qo-NT
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 May 2022 05:12:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L/pK0vXgnUIQvH3s5nZwayIWumnFrRGavhp4dU2/4pg=; b=de91o4NizktMG0cmkFA38nxfXN
 alhipYPivTVp84wM/P7ECk2FFX9BC5mP+QhEAUJu/FZ3hy11polteu0oV3ZiSq1H3BDIXP7sKeaGD
 p2Pp9oZjC16CMXSIhy6r/Z/p+5Uv+EoEPYOpNGmTP8od4D0L4Vf3jwS5Zc1Q2ySu9RCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L/pK0vXgnUIQvH3s5nZwayIWumnFrRGavhp4dU2/4pg=; b=ijRHdyzaQ/8OdAIMjd+qxJeLMw
 g3SgceGumkJzE4pS0JwwG0oKkQACqn1A9Vt9BVxBMGwh2C22zTBoajZ4teYVOGUF35r+PS+0R5wmY
 gpIVJd+IXtgOrrJrg3TR5UQuLwcECDvySvBp4vK1+mkaV9XTVeYu7Y8OED8Q+uExO5lc=;
Received: from mail105.syd.optusnet.com.au ([211.29.132.249])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.94.2)
 id 1nuoko-007FpE-Sb
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 May 2022 05:12:51 +0000
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au
 [49.181.2.147])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EE07A10C8B4E;
 Sat, 28 May 2022 15:12:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1nuokg-00HIOO-Pz; Sat, 28 May 2022 15:12:38 +1000
Date: Sat, 28 May 2022 15:12:38 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20220528051238.GX1098723@dread.disaster.area>
References: <20220527205955.3251982-1-jaegeuk@kernel.org>
 <YpFDw3mQjN1LBd2j@gmail.com>
 <20220527235509.GW1098723@dread.disaster.area>
 <YpFsOLz/GScXvhkb@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YpFsOLz/GScXvhkb@google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6291af49
 a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
 a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
 a=8RavHqeXKao-3GyEar0A:9 a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Headers-End: 1nuoko-007FpE-Sb
Subject: Re: [f2fs-dev] [PATCH] f2fs: add sysfs entry to avoid FUA
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 27, 2022 at 05:26:32PM -0700, Jaegeuk Kim wrote:
> On 05/28, Dave Chinner wrote:
> > On Fri, May 27, 2022 at 09:33:55PM +0000, Eric Biggers wrote:
> > > [+Cc linux-block for FUA, and linux-xfs for iomap]
> > 
> > linux-fsdevel should really be used for iomap stuff...
> > 
> > > 
> > > On Fri, May 27, 2022 at 01:59:55PM -0700, Jaegeuk Kim wrote:
> > > > Some UFS storage gives slower performance on FUA than write+cache_flush.
> > > > Let's give a way to manage it.
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > 
> > > Should the driver even be saying that it has FUA support in this case?  If the
> > > driver didn't claim FUA support, that would also solve this problem.
> > 
> > Agreed, this is a hardware problem that need to addressed with a
> > driver quirk to stop it advertising FUA support. The high level
> > fs/iomap code should always issue FUA writes where possible and
> > the lower layers tell the block layer whether to issue the FUA as
> > a FUA or write+cache flush pair.
> 
> I was thinking to turn off FUA in driver side quickly tho, one concern
> was the bandwidth vs. latency. What if the device can support FUA having
> short latency while giving low bandwidth?

Seriously, how is a user supposed to know this sort of thing about
the hardware they are using? They don't, and to expect them to not
only know about the existing of a weird sysfs knob, let alone how it
applies to their hardware and their workload is totally
unreasonable.

If the hardware has non-deterministic FUA write performance, or
requires very careful switch over between cache flushes and FUA to
get the most out of the hardware, then that's not something we can
tune or optimise for - that's just broken hardware and the drive
should quirk the brokeness away so nobody has to care about it. Tell
the hardware manufacturer to fix their hardware, don't try to hack
around it in software and then expect the user to know how to tune
for that broken hardware.

> In that case, we still have
> a room to utilize FUA for small-sized  writes such as filesystem metadata
> writes, but avoid DIO w/ FUA for sequential write stream.

Strawman.

We don't use FUA for normal DIO writes - they only get used for
O_DSYNC writes, in which case we either use FUA if the device
supports it, or we do a normal write followed by a cache flush.
If there are metadata updates that the O_DSYNC needs to also flush,
we don't use FUA by let the fileystem issue a cache flush in the
most optimal possible after the write completes.

Either way, using O_DSYNC DIO writes for streaming, sequential data
is a really poor choice for an application to make. Normal DIO
writes followed by fdatasync() to flush the metadata and caches once
will be much faster and far more efficient than a metadata and cache
flush after every single data write, FUA or not.

-Dave.
-- 
Dave Chinner
david@fromorbit.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
