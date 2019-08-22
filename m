Return-Path: <SRS0=GuC1=WS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A294C3A5A1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:49:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0015233FD;
	Thu, 22 Aug 2019 19:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="h270XPM/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CnyFjlou";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y1yENqlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0015233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i0t5K-000223-5w; Thu, 22 Aug 2019 19:49:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1i0t5I-00021w-Ux
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Aug 2019 19:49:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xx8LXOaOwHlbVchOyRa3W5phjow6bxdD90jfmnUTzRY=; b=h270XPM/yW9LTzP3hFVisuL+P1
 +4wEzLB6fc8Wu2QcwOa4hXMMs2Pxu4+31zPimlKe8EWzTrk5xmvnTPCHlHYKPn2LHmIdidRgt2LS/
 hIoO9EABEuuIyk3MvPJcuMHwHWQkH85so1zuw99+3c7tGlOHv5pLYxfUQs+495nk7TNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xx8LXOaOwHlbVchOyRa3W5phjow6bxdD90jfmnUTzRY=; b=CnyFjlouyvO2tKxl5Vn6E1Ixmn
 j4JFH2LFlRO5l+Xk92O6W5whAtIYD35jhqdbelNVx+vUDshPlb1lhT4sJp0nprLuOqiww2HnAfs61
 ok6H73st9uO/fthV34DEqjnR+cryn7tEXYO54WiisDzNJViAp3cNSEoKoMY4IM9MsH/k=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i0t5G-00Cfkj-RR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Aug 2019 19:49:24 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 30A69233FD;
 Thu, 22 Aug 2019 19:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566503356;
 bh=8dIXIP4SU6uUX5Ba/b87BxihB3pQIWm9xl3nYbo76eo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=y1yENqlhF8aVXnJYBrT/E5DBt+b8KMn6cYtRaWoG9MHsy2VzxFwWmQwGA43IoN9c2
 Xql3t4WWverN/HSEX08winPM7461cE3w5XdSepfFRLAFHQWb8cYV1GsToYCDGMYqEE
 /rPbunkTZ606TBe2Oavu/HQ37iOadnF2ICyH/hU4=
Date: Thu, 22 Aug 2019 12:49:15 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20190822194915.GB99916@jaegeuk-macbookpro.roam.corp.google.com>
References: <3bc8584e-651c-9578-c25a-40c60b5cfbdb@huawei.com>
 <dfd847fe-0c6d-f2a1-db50-d637a685d13b@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dfd847fe-0c6d-f2a1-db50-d637a685d13b@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1i0t5G-00Cfkj-RR
Subject: Re: [f2fs-dev] f2fs_symlink bug
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
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/21, Chao Yu wrote:
> Ping,
> 
> On 2019/8/12 20:01, Chao Yu wrote:
> > Hi Jaegeuk,
> > 
> > In por_fsstress testcase, fsck reports below inconsistent status, I found one
> > path can cause this case.
> > 
> > [FIX] (fsck_chk_inode_blk:1002)  --> Symlink: recover 0x1425 with i_size=4096
> > [ASSERT] (fsck_chk_inode_blk:1030)  --> ino: 0x1425 chksum:0x6983d47, but
> > calculated one is: 0xdb284b35
> > [FIX] (fsck_chk_inode_blk:1036)  --> ino: 0x1425 recover, i_inode_checksum=
> > 0x6983d47 -> 0xdb284b35
> > 
> > - f2fs_symlink
> >  - page_symlink failed -> f2fs_write_failed() will truncate size to zero
> >   - f2fs_unlink failed -> symlink inode w/o data will remain in fs
> > 
> > Not sure, but one choice of fix is to treat symlink as fs meta like we did for
> > directory, so that checkpoint can take care of all data/node of symlink, any
> > thoughts?

Hmm, how's the possible to get very long path name requiring another data block?
If it's fitted in inline_data, it's more easy to guarantee that, right?

> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
