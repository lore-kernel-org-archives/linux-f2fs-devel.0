Return-Path: <SRS0=vkGI=N7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4CEC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Sep 2021 05:33:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8F660C3E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Sep 2021 05:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A8F660C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mOCgG-0007KA-3t; Thu, 09 Sep 2021 05:33:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gregkh@linuxfoundation.org>) id 1mOCgE-0007G4-2W
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Sep 2021 05:32:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nmPm0Q40UvQUtbSg4rCYYNdNTeJO0SUZOTGbD0i4XGM=; b=kc680g+8zQxTqJKD9wOZfWdeiO
 lKKL4NzD8wATSKCJvBtink6dXyrtC5nQnMqSuMffoJFxulh56y9x7wY4ToKk3ruJOFrXHZiIvCkPk
 8W2yx29vywG2kEdH16sism7tsQ6e9qIJQsLfb25rft8GfQIYTF1i538V7RxE6VSDVeDk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nmPm0Q40UvQUtbSg4rCYYNdNTeJO0SUZOTGbD0i4XGM=; b=i7VLFlgMq5fdL5U9B4VwV+TU+o
 cOEx6cLOgrOvPlcCrOftA6pDB3+Kjo2h8DMXrYCQKN3uG6M+flMch4YIFiB69c1dNEgTu1EU6fCvX
 rI/Ax2pB82vm+O7J01GVBb5+CDSmoo9mzeZOVTmicOX5/LGI98FPg/cSanIMA6Z4bdu8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mOCgB-0005zq-Og
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Sep 2021 05:32:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C21D76113E;
 Thu,  9 Sep 2021 05:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1631165570;
 bh=U+9DSTqD6oqnJ5uxcIMbcwT8e7VY5QffCcdVRlWwhKw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B1uDLzNG3TTuNVi76zH1sEFFmER+SOXas7aWKXN/YOSirw/E+pTEgP/92C9bnEEbE
 jD6paTh0/v4KriP2ArHxbTQnff4+I78jwbucvJwmSMElgTiRwh7wrpCOsveKKA/CPR
 MSaOB/4uSOkEVhMaolvOSrwha/zuMpbjHy6EpZMA=
Date: Thu, 9 Sep 2021 07:32:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <YTmcbNMRaPzQRqmf@kroah.com>
References: <20210908220020.599899-1-jaegeuk@google.com>
 <YTmaPCd3/cpMyNEe@kroah.com> <YTmbhc7J5ZdVp3vI@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YTmbhc7J5ZdVp3vI@google.com>
X-Headers-End: 1mOCgB-0005zq-Og
Subject: Re: [f2fs-dev] [PATCH] f2fs: guarantee to write dirty data when
 enabling checkpoint back
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
Cc: stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Sep 08, 2021 at 10:28:37PM -0700, Jaegeuk Kim wrote:
> On 09/09, Greg KH wrote:
> > On Wed, Sep 08, 2021 at 03:00:20PM -0700, Jaegeuk Kim wrote:
> > > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > > 
> > > commit dddd3d65293a52c2c3850c19b1e5115712e534d8 upstream.
> > > 
> > > We must flush all the dirty data when enabling checkpoint back. Let's guarantee
> > > that first by adding a retry logic on sync_inodes_sb(). In addition to that,
> > > this patch adds to flush data in fsync when checkpoint is disabled, which can
> > > mitigate the sync_inodes_sb() failures in advance.
> > > 
> > > Reviewed-by: Chao Yu <chao@kernel.org>
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/file.c  |  5 ++---
> > >  fs/f2fs/super.c | 11 ++++++++++-
> > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > 
> > What stable kernel(s) are you wanting to have this backported to?
> 
> 5.10 please.

Why would you want to skip 5.14.y and 5.13.y?  You never want anyone to
upgrade stable kernel releases and have a regression.

thanks,

greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
