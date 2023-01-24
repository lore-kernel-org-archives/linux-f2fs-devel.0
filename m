Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B2DC54E94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Jan 2023 21:23:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pKQla-0007Jt-2l;
	Tue, 24 Jan 2023 21:23:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <akpm@linux-foundation.org>) id 1pKQlZ-0007Jn-BV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jan 2023 21:23:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fXNPgr2sAloxtIAnVNbt4nQCZh1rVHT7ASa+sYKWPoo=; b=Gjo5mBhYxR0h8PrxpmqIsqUCIL
 me/zZeyhI3YuripOEvXbUS32XW4QZZV1P25eUpS74eefrkz0JvMvCC/0Rz4BZJZTC+zmQGR8++FHF
 Iyva+GfrVj/K9gLHarYjZVoc1C63dTDfiA9vWRrT8zBSojYuY8ICzlO0baBc8XacQl8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fXNPgr2sAloxtIAnVNbt4nQCZh1rVHT7ASa+sYKWPoo=; b=VXjnMsdHtARZShjUfW/k1CqcHv
 67FNMGaDi+PcrIcajIE4lhSj9dtECvXSsUJm6hwRnx+iEB4HfzYNYkNpwMPmbnRUmcXoO5jl67K7R
 mMA3m8H4qMNMQQVtpTwKjRV68iejFaGl8VGqOsdbhfz9fFZeAAR38gA9Qo61Imar8BA4=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pKQlU-0007jc-Kj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jan 2023 21:23:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 91C91B811DA;
 Tue, 24 Jan 2023 21:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31C3C433D2;
 Tue, 24 Jan 2023 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1674594242;
 bh=zjcANJE6uGzwSR4wTIiOQxcwFMp4+Yz5YqNXXhvxlZw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FqySnI4K96d799gpZOFbX42GtEloF+F2Qd7fEzmx0GhoOLzs+V1i9DTlrU1UKd/02
 Hjuu/ELjUesERXd5b+wWuorsVm2xPmIA5wtRHvl+GZny+5oN8q9FGbJBg2h57TomCz
 uzDtXADYIc0ipLpnAPanocU0tIlVbA416ABzGw/Y=
Date: Tue, 24 Jan 2023 13:04:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Potapenko <glider@google.com>
Message-Id: <20230124130401.eb5d453213d557cf3b7a8ed6@linux-foundation.org>
In-Reply-To: <CAG_fn=WDjw1MVYhEh7K4HOpGNBWsq6YuyG6Xx7XcP4Xpu+KhZg@mail.gmail.com>
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-4-glider@google.com>
 <CAG_fn=WDjw1MVYhEh7K4HOpGNBWsq6YuyG6Xx7XcP4Xpu+KhZg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Headers-End: 1pKQlU-0007jc-Kj
Subject: Re: [f2fs-dev] [PATCH 4/5] fs: hfs: initialize fsdata in
 hfs_file_truncate()
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
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, 24 Jan 2023 11:51:30 +0100 Alexander Potapenko <glider@google.com> wrote:

> On Mon, Nov 21, 2022 at 12:21 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > an error passing the latter to aops->write_end().
> >
> > Fix this by unconditionally initializing fsdata.
> >
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> 
> Dear FS maintainers,
> 
> HFS/HFSPLUS are orphaned, can someone take this patch to their tree?
> Thanks in advance!
> (same for "fs: hfsplus: initialize fsdata in hfsplus_file_truncate()":
> https://lore.kernel.org/all/20221121112134.407362-5-glider@google.com/)

I grabbed both.

I removed the

	Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

because that might provoke the backport bots to backport this fix
across eight years worth of kernels.  Before KMSAN existed!

If you intended that this be backported then please let's come up with a
more precise Fixes: target and we'll add cc:stable.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
