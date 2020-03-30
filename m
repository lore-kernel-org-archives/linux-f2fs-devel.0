Return-Path: <SRS0=OWUn=5P=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB2C2D0F1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CBB20784;
	Mon, 30 Mar 2020 20:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Z558td8C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KBA4tP8r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYB4THHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CBB20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jJ1AW-0006JF-0M; Mon, 30 Mar 2020 20:38:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jJ1AV-0006J5-2Y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Mar 2020 20:37:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yYC1Bf2Xmdry4FyupwGMIj4NtOJcHCa10lLYanykPSA=; b=Z558td8CzCtmrLavvTMgl1uxR6
 BnYoCN8emcGUiDBUIyIfTWGLrhaO0KDT3r8VC7SrOCZ6MazFrwYj4ZtLDD84N5LBFSsSj3d7Nm0vl
 h0v85wXz/DPX3ye46ZmpGfhRAAvE/6pn5BOVJVeGudo/Q7KH56KAfEq9oDiwDOUZJkdw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yYC1Bf2Xmdry4FyupwGMIj4NtOJcHCa10lLYanykPSA=; b=KBA4tP8rCJk9ljLCR2u6N1GkT8
 TF6BLH5eyst/m4rnCiZt3YEu9gyPo1bzYIS778Oeogsi6bZ4udbJ9B+DpXsdsuQfc3kKOahpYiYuN
 kGyLtsJOelB6EP5oi992dotTdh8sernQumToPNHmbs49bR5GeGX7VYPAOtvSVI1piWO4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jJ1AS-001rmA-P7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Mar 2020 20:37:59 +0000
Received: from gmail.com (unknown [104.132.1.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2704720757;
 Mon, 30 Mar 2020 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585600671;
 bh=+mbjkt2M3Cet+7VuNGQYRyAAZeqN0FtaQWEfj5HYfPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jYB4THHRXmw7XF2gcB3t+hMeDJw48gTiEOvPjtNic8yRpGxQ3LxuF0YZGbpBW+01b
 li0opREoaGyTbJ9BNZ1ZhIVGKzYCWr4MJ1V98BVLf5h5ApoXMIej1Cbs5S0589VeJy
 k4NRUY9xbWbPpYPdLOWCKPUbIv6UnU4DxxUUCIDs=
Date: Mon, 30 Mar 2020 13:37:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20200330203749.GC108564@gmail.com>
References: <20200330192524.8931-1-jaegeuk@kernel.org>
 <20200330195143.GB108564@gmail.com>
 <20200330201846.GA212732@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200330201846.GA212732@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Headers-End: 1jJ1AS-001rmA-P7
Subject: Re: [f2fs-dev] [PATCH] f2fscrypt: show more information of policy
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Mar 30, 2020 at 01:18:46PM -0700, Jaegeuk Kim wrote:
> On 03/30, Eric Biggers wrote:
> > On Mon, Mar 30, 2020 at 12:25:24PM -0700, Jaegeuk Kim wrote:
> > > From: Jaegeuk Kim <jaegeuk@google.com>
> > > 
> > > This patch gives more information of encryption policy.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
> > > Change-Id: I04a6826aa4497554ce79d884d495b3dda1b64fac
> > > ---
> > >  tools/f2fscrypt.c | 34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > > 
> > > diff --git a/tools/f2fscrypt.c b/tools/f2fscrypt.c
> > > index fe3e0ff..bb3e70f 100644
> > > --- a/tools/f2fscrypt.c
> > > +++ b/tools/f2fscrypt.c
> > 
> > I'm a little confused why the f2fscrypt tool even exists?  Who is using it?  It
> > looks like this code was all copied from e4crypt, which is no longer being
> > maintained either as there are now better filesystem-independent tools:
> > 
> > - https://github.com/google/fscrypt
> > - https://github.com/google/fscryptctl
> > - https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/tree/io/encrypt.c
> > 
> > Would one of those work for you instead?
> 
> I'm using it occasionally in Android. I think it'd be great to add it in f2fs_io
> likewise xfs_io tho, it'd be also okay to add one of projects in AOSP, if you
> have some bandwidth. If you have any plan, I'd okay to remove f2fscrypt in
> f2fs-tools.
> 

Does it actually need to be part of the Android source tree, or would it suffice
to build it locally?

Either way, building xfs_io for Android might be difficult, so fscryptctl might
be the best option.

Note that fscryptctl doesn't yet support v2 encryption policies, but I'll
probably add it eventually.  I don't have any plans to update e4crypt and
f2fscrypt too.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
