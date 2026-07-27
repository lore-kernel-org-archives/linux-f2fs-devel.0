Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25DCC531D0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rlXxiBOtbfg/M3z5ZbUvt5pX3VwOBXrr4quG+8KcU0o=; b=j7DBYeBdt+QAFB9UDzfG7BdDK2
	wMYSj/bQ1YXS2MVTV8drW6/paQXsH+RJc4VbVZ6HQUTzIbLqjiXTMjOu2HCAzTOOfVITFTacZ1acv
	oNAHQQ1QlXyXt2a5BEr2ONEfbagmWyakzwLh5oeYz9ys770Bx03okg4BAtkDRbW5ceFs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woPTb-0006mz-PI;
	Mon, 27 Jul 2026 17:50:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1woPT3-0006mc-S9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 17:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n0puckbhg1NjigGkaWkGscbP69VVSG+CBvumzu87bZU=; b=H3gG3oE+4IrU+mhdDnJ0iIp28Y
 jnT0Kc6KQUA69G/+qI9TvLthhj7ZOPDAajn/hEIU9s8YSJhuQjlN+yTWfMH1FU3sOWbVLwFU6M1AS
 bBj9bJ+6vdLWd8MKO7amgArNrSImaxUX+mgm6Tbrhryctp3w1hKiLZ3/i2XMS0GPZ02k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n0puckbhg1NjigGkaWkGscbP69VVSG+CBvumzu87bZU=; b=mAX3mV+sDkcKaPVeHxYsy5Uuoa
 fl9kLAx5vePHUBxZ6nw3hXnK2n5JzPo73BEznVi1Q7Csw1Ztvu7zHFFtaNVO0/jKwal3Dq7Y+Ike6
 DZDMajNMB4Bks93kZWkqxHYXdjGj4zsGA5+s8PfgWI/R+Wa8BoLihamiUn4/Ytbprhx8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woPT6-0007MC-UZ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 17:50:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5F4960A60
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 17:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A9F1F00A3D;
 Mon, 27 Jul 2026 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785174615;
 bh=n0puckbhg1NjigGkaWkGscbP69VVSG+CBvumzu87bZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Tzgz0+/dOF5dRi7APJ3Ao6lVXpvZyRCUxlgBGpz5uTTSkC5Dnrw7I4eBUJ+jzI2Jl
 0TMN51snWt8y8mSgJRJ/brM6LC5yyh0NKwQOO+Oym5iKDsGTroa3ekbReOkFwBCs3X
 IEQ11qxhcGYo2Koea04RlstiYtdernJ6Q2y6hMklOPyNglFqfSZo5nBx4+IKBajmo/
 muxdPA4LcrF5Qw439kRrCmYL7BouJD2thdnsaslt5mjYdgkfuP6uHIT2ZW+iqJKyQq
 8TSiduA2dt7L3QBBpHDdiYPo2xnK5upDD1L54YqBnjpRppyPXlZhFWmjb+W1UaTN7I
 4nUVi2BrxfouQ==
Date: Tue, 28 Jul 2026 01:50:08 +0800
To: Anand Suveer Jain <asj@kernel.org>
Message-ID: <ameWjhJLY41-hWQ4@zlang-mailbox>
Mail-Followup-To: Anand Suveer Jain <asj@kernel.org>, 
 Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org, 
 "Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
 <aloCfjjqesxpzL9z@zlang-mailbox>
 <3d872ecc-6e76-43b6-8b43-adb979cacf79@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d872ecc-6e76-43b6-8b43-adb979cacf79@kernel.org>
X-Headers-End: 1woPT6-0007MC-UZ
Subject: Re: [f2fs-dev] [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 22, 2026 at 07:56:33AM +0800, Anand Suveer Jain wrote:
> 
> > Hi Chao and Anand,
> > 
> > The *_fs_sysfs related helpers were brought in by me in:
> >   commit 2a7b77abcd1dde735186b363da24540706c43b73
> >   Author: Zorro Lang <zlang@redhat.com>
> >   Date:   Tue Jul 5 17:30:24 2016 +0800
> > 
> >     xfs: configurable behavior on errors at unmount time
> > 
> > At that time, I didn't think about the "features/" directory.
> > 
> > Now, let me rethink this set of helpers. I feel that the *_fs_sysfs
> > family of functions shouldn't be restricted to the $dev directory,
> > we should remove this restriction.
> > 
> > Following that, we bring in *_fs_sysfs_device (appending the _device suffix)
> > helpers which call *_fs_sysfs(). Also change the test cases who call these
> > functions.
> > 
> > Finally, we can introduce the *_fs_sysfs_features functions (or simply use
> > *_fs_sysfs directly).
> > 
> > Also, we have both *_fs_sysfs_attr and *_fs_sysfs, and the logic between
> > them is somewhat confusing and easy to mix up.
> > 
> > I need to write a series of patches to clean up these logic. For this current
> > patch, we can start with a small-scale change first. What do you think?
> > 
> I noticed some duplicate code that needs cleanup.
> Essentially, I think we can maintain two sysfs check helpers:
> one that involves mounting the device, and
> another for module-level feature checks.

How about:

- *_fs_sysfs()
|
+--> *_fs_sysfs_device()
|
`--> *_fs_sysfs_feature()

I also need to clean up and unify _fs_sysfs() and _fs_sysfs_attr() .

Thanks,
Zorro

> 
> Thanks for the help, Zorro.
> 
> Anand


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
