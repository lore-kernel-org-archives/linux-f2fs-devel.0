Return-Path: <SRS0=dVfM=V3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ACBC433FF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jul 2019 18:05:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D829D206A2;
	Tue, 30 Jul 2019 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="M8mZIwUW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="W7t1HoQ2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7s8xYEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D829D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hsWVY-0005dz-F5; Tue, 30 Jul 2019 18:05:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hsWVX-0005do-94
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jul 2019 18:05:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KMz9UZfY5NrVye3vYuGh37L5iEyCDY9riDXZ47Y5pSw=; b=M8mZIwUWHCjXNoKrfv9pw0UQNY
 SOatuSM2jGmTLS4KWrF6nLKSDCAmd0K+0cPtKMUxkmeYvWJrNkxU5J/PPhhCVbBLZ+j5nkkRUx0q6
 olQ7PNcmIsnKbnPoxkiBKppv/lI/8E60wPpOf2hG+JJAkPgtzdCxPg++/FvdxVJxoa+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KMz9UZfY5NrVye3vYuGh37L5iEyCDY9riDXZ47Y5pSw=; b=W7t1HoQ2w1x/Ihb2xTgyNKXKsZ
 TSvCVDbkGsZZSG3D0a29K+SkgbKAKhYXjDyanScDUOLvxwkdXliC5nEu/HQlit7shUmTbJzJ9jpqv
 DlEEF1LgSgt9P7ynQSUV9DRJROfCzhM9+TmvkWwIMcjFyT7JJILbsu2ZLWIATskc1Ev8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hsWVU-004ZbQ-W5
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jul 2019 18:05:55 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21E23206A2;
 Tue, 30 Jul 2019 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564509947;
 bh=JiPzFNptGZecEI72AnXbmIRhLTfjmexxpWzCIrWo9KA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q7s8xYEuWjMsuH0Cpk+qeVqq/jG+9bBqHCCxZ/YECHcBKSM5bRzoN0NTWeUyLBwrp
 L34fRL0sFjMwH0zXw2VvGtjjIQc83/xbKx1Xdyumg0X2wcUiYli9t81Xyp7MkuN52V
 nkR3shtIxTgZl4sJDyczAdEhP5zcyS1wqmiNbjW4=
Date: Tue, 30 Jul 2019 11:05:46 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Ju Hyung Park <qkrwngud825@gmail.com>
Message-ID: <20190730180546.GC76478@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190711150617.124660-1-qkrwngud825@gmail.com>
 <CAD14+f3pxEqC-Kqt0-9+Xb_+Jwr_=NjQmsVoLXz9YTAZJo12zg@mail.gmail.com>
 <20190711170647.GA65508@jaegeuk-macbookpro.roam.corp.google.com>
 <24f7940d-325c-c2b3-608e-ce311db2dc7d@huawei.com>
 <CAD14+f3ZGaY5jM+A5Bv=cSZNUeYaY=hywaG44SsotMNVz=D09g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD14+f3ZGaY5jM+A5Bv=cSZNUeYaY=hywaG44SsotMNVz=D09g@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1hsWVU-004ZbQ-W5
Subject: Re: [f2fs-dev] [PATCH] f2fs: use kmem_cache pool during xattr
 lookups
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

On 07/29, Ju Hyung Park wrote:
> Hi Chao and Jaegeuk,
> 
> I have no idea how that patch got merged.
> 
> We(me and Yaro) were supposed to work on doing some finishing touches
> to the patch before sending it to upstream.
> 
> I'll personally check with Yaro.
> 
> Jaegeuk, please remove the patch.
> That patch has numerous issues, biggest one being hardcoded size(SZ_256).

That branch is for testing purpose and kinda TODO list for me. :)
Anyway, I'll remove it, so please post it later with better shape.

Thanks,

> 
> Also, I need to figure out how to allocate kmem cache per mounts.
> 
> Thanks.
> 
> On Mon, Jul 29, 2019 at 4:28 PM Chao Yu <yuchao0@huawei.com> wrote:
> >
> > Hi Jaegeuk, Ju Hyung, Yaroslav,
> >
> > I can see "f2fs: xattr: reserve cache for xattr allocations" has been merged in
> > dev-test branch, however, it doesn't exist in f2fs mailing list, so I can not
> > comment on it.... Can anyone send it to the list?
> >
> > Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
