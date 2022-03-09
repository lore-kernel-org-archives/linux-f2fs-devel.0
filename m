Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FECDC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Mar 2022 06:22:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nRpiY-0008FX-Kk; Wed, 09 Mar 2022 06:22:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <david@fromorbit.com>) id 1nRpiX-0008FR-Dt
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Mar 2022 06:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uOhUrcZ9hUTr3Kre94tZrg2dfj2RuZ1mz27Yk6Lu5AM=; b=c6cDYmUIfhiUDN467AjSpfEnKT
 FuTQ+V69svh0NYGlviZPYm96ozi0VtWVscZMiN7PEkfVryipiQRq9OtyNVcjTye8eIZRgr6KU2sze
 Ba24aWXsZbDPMLRnfltEy7p+vAvq8wA/SQCXj7AftoLbKHNOSQJkCMHi/Hm1+AiBjvvg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uOhUrcZ9hUTr3Kre94tZrg2dfj2RuZ1mz27Yk6Lu5AM=; b=Ktpt4vPxUb9eBdQ56/oBl1kyYe
 Gs+gdz9Uz8beiYNYuGSRzBio3y4VunTTQarxTrQVqpshvHCh1jkmDLfFBQzOllVNCUlx9nSMeL2Cu
 n7tCg5zIYX7rPZMkJ2HgxKEdNMUz6DvjWk1hpRG2suAGTvOgK1ye+j+zI7F0SQpHq21w=;
Received: from mail105.syd.optusnet.com.au ([211.29.132.249])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.94.2)
 id 1nRpiS-009QWR-5R
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Mar 2022 06:22:35 +0000
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au
 [49.186.17.0])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7451410E2642;
 Wed,  9 Mar 2022 17:22:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1nRpiJ-003Hra-EV; Wed, 09 Mar 2022 17:22:23 +1100
Date: Wed, 9 Mar 2022 17:22:23 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chao Yu <chao.yu@oppo.com>
Message-ID: <20220309062223.GY3927073@dread.disaster.area>
References: <20220228035719.4102745-1-sunke32@huawei.com>
 <cd2a245e-b9d2-c09c-0f8c-a7ca9157ca9f@oppo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd2a245e-b9d2-c09c-0f8c-a7ca9157ca9f@oppo.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=622847a1
 a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
 a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=i0EeH86SAAAA:8 a=7-415B0cAAAA:8
 a=9GbEHPOvS_M6fQiB5JEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Headers-End: 1nRpiS-009QWR-5R
Subject: Re: [f2fs-dev] [PATCH] generic/066: attr1 is still there after log
 replay on f2fs
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
Cc: jaegeuk@kernel.org, Sun Ke <sunke32@huawei.com>, guan@eryu.me,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 09, 2022 at 12:31:17PM +0800, Chao Yu wrote:
> On 2022/2/28 11:57, Sun Ke via Linux-f2fs-devel wrote:
> > The test fail on f2fs:
> >       xattr names and values after second fsync log replay:
> >       # file: SCRATCH_MNT/foobar
> >      +user.attr1="val1"
> >       user.attr3="val3"
> > 
> > attr1 is still there after log replay.
> > I guess it is f2fs's special feature to improve the performance.
> > 
> > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > ---
> > 
> > Is it a BUG on f2fs?
> 
> I don't think so, it fails due to f2fs doesn't follow recovery rule which
> btrfs/ext4/xfs does, but it doesn't mean f2fs has break posix semantics of
> fsync().

I disagree.  A failure in this test is indicative of non-conformance
with the Linux definition of fsync() behaviour.

You are right in that it does not break POSIX fsync semantics, but
POSIX allows "do nothing" as a valid implementation. However,
because of this loophole, the POSIX definition is complete garbage
and we do not use it.

That behaviour that Linux filesytsems are supposed to implement is
defined in the Linux fsync() man page, and it goes way beyond what
POSIX requires:

$ man fsync
....
DESCRIPTION
    fsync() transfers ("flushes") all modified in-core data of
    (i.e., modified buffer cache pages for) the file referred to by
    the file descriptor fd to the disk device (or other permanent
    storage device) so that all changed information can be retrieved
    even if the  system  crashes  or  is rebooted.  This includes
    writing through or flushing a disk cache if present.  The call
    blocks until the device reports that the transfer has
    completed.

    As well as flushing the file data, fsync() also flushes the
    metadata information associated with the file (see inode(7)).
....

IOWs, fsync() on Linux is supposed to persist all data and
metadata associated with the inode to stable storage such that it
can be retreived after a crash or reboot. "metadata information"
includes xattrs attached to the inode that is being fsync()d.

*fdatasync()* does not require xattrs to be persisted unless
they are needed to retreive data, but that's not what g/066 is
exercising.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
