Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD6C432BE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 21:57:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463A960EB6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 21:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 463A960EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6ghN-0002rq-Dg; Thu, 22 Jul 2021 21:57:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1m6ghM-0002rf-1A
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 21:57:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vwu702L/vGuhePJ10WF1bRl5EqKg96AjcKJnd2proeg=; b=hMAmUJ9O/pOpMEzjggmNZNn9NJ
 ERIgHT/PA4BopRZHOf5e+rwrgJkVmQ/JXASAwIxWirxh1+jWXAHDKRN1esJ3nBAwrVA3Ne6zJpzhH
 4sEPQUk5x42UFzhSZt/eN4dGniLMd670IxnOi2tm2/IJK/BS7L6kAc2G2AgCjgRY3yFg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vwu702L/vGuhePJ10WF1bRl5EqKg96AjcKJnd2proeg=; b=k/awLGworMkhOx/pLYa3IPc2sN
 7fTOoyv5xsFL/ydyFWjFUcBTI+Xs11pxt2icc7SYcxEyRu7J1kYAIZL03JKn97IC+1GmzuN0/czg0
 Dhf7OJFVJVmdNg3UD4Zdn58tXsMrlU5x6iexa4DwbCWZ9TgU2eb6FXjBA1YM71SbKtAs=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6ghA-0005PX-OC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 21:57:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 321BC60EB4;
 Thu, 22 Jul 2021 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626991042;
 bh=5g5ShrOoIYKikipfuUXnnoiQsbYhHG2rp7X6k6EdnhI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BqaM3hbQgwUYnCx/SvpMuT9G1hXZgT5wkSbHkaOT0M3cwaZGVKd8PRjhIZCVkqUPA
 NXaZZJhSnOa3ow6tcp5EZFo4Ex3iRMV+QMoef0C4v47cUCCp5g2YYpuY7Yg068IeRd
 gF49+tGRp1zTdcycEMghjO7jHKSI8hS6nAtgXXWI6FXa+HEH56agW+QgGSjcbj0SKk
 anSc6JT4HvNuUQwXNSWErS2+bj81QUNsV6Muj8FQyPEP/m5x7F32Go+yVADzj8KWbn
 4KDt5O7OCqmLyS4uIuOATr06k/uJ1k2Y+NuLhPjASJ62xYD5f54HBJIJXwWY0aCgKp
 1h2jixLboMlIg==
Date: Thu, 22 Jul 2021 14:57:20 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YPnpwOUIRJbSNAV/@google.com>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-7-ebiggers@kernel.org>
 <YPU+3inGclUtcSpJ@infradead.org> <YPnZa5dFVP7vtB9q@google.com>
 <YPnbEdVxClWwatKz@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YPnbEdVxClWwatKz@gmail.com>
X-Headers-End: 1m6ghA-0005PX-OC
Subject: Re: [f2fs-dev] [PATCH 6/9] f2fs: implement iomap operations
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
Cc: Satya Tangirala <satyaprateek2357@gmail.com>, linux-xfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 Changheun Lee <nanich.lee@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/22, Eric Biggers wrote:
> On Thu, Jul 22, 2021 at 01:47:39PM -0700, Jaegeuk Kim wrote:
> > On 07/19, Christoph Hellwig wrote:
> > > On Fri, Jul 16, 2021 at 09:39:16AM -0500, Eric Biggers wrote:
> > > > +static blk_qc_t f2fs_dio_submit_bio(struct inode *inode, struct iomap *iomap,
> > > > +				    struct bio *bio, loff_t file_offset)
> > > > +{
> > > > +	struct f2fs_private_dio *dio;
> > > > +	bool write = (bio_op(bio) == REQ_OP_WRITE);
> > > > +
> > > > +	dio = f2fs_kzalloc(F2FS_I_SB(inode),
> > > > +			sizeof(struct f2fs_private_dio), GFP_NOFS);
> > > > +	if (!dio)
> > > > +		goto out;
> > > > +
> > > > +	dio->inode = inode;
> > > > +	dio->orig_end_io = bio->bi_end_io;
> > > > +	dio->orig_private = bio->bi_private;
> > > > +	dio->write = write;
> > > > +
> > > > +	bio->bi_end_io = f2fs_dio_end_io;
> > > > +	bio->bi_private = dio;
> > > > +
> > > > +	inc_page_count(F2FS_I_SB(inode),
> > > > +			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> > > > +
> > > > +	return submit_bio(bio);
> > > 
> > > I don't think there is any need for this mess.  The F2FS_DIO_WRITE /
> > > F2FS_DIO_READ counts are only used to check if there is any inflight
> > > I/O at all.  So instead we can increment them once before calling
> > > iomap_dio_rw, and decrement them in ->end_io or for a failure/noop
> > > exit from iomap_dio_rw.  Untested patch below.  Note that all this
> > > would be much simpler to review if the last three patches were folded
> > > into a single one.
> > 
> > Eric, wdyt?
> > 
> > I've merged v1 to v5, including Christoph's comment in v2.
> > 
> 
> I am planning to do this, but I got caught up by the patch
> "f2fs: fix wrong inflight page stats for directIO" that was recently added to
> f2fs.git#dev, which makes this suggestion no longer viable.  Hence my review
> comment on that patch
> (https://lkml.kernel.org/r/YPjNGoFzQojO5Amr@sol.localdomain)
> and Chao's new version of that patch
> (https://lkml.kernel.org/r/20210722131617.749204-1-chao@kernel.org),
> although the new version has some issues too as I commented.
> 
> If you could just revert "f2fs: fix wrong inflight page stats for directIO"
> for now, that would be helpful, as I don't think we want it.

Yup, I dropped it in dev branch, and wait for Chao's next patch on top of
iomap.

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
