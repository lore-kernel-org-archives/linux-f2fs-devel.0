Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB41C19F28
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 31 Jul 2022 03:08:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oHzJt-0005st-52; Sun, 31 Jul 2022 03:08:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1oHzJr-0005sm-La
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 31 Jul 2022 03:08:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fPMMuhQS2mTvxaxxGhkKChzM2+Z43DxDxcdg+VLxe3c=; b=SrFS1ldnwmxNQp4NB3Odr1PFqh
 hihtIQ2AqZYwjehDoEJY49f4FurHdS6WSGtqaX31j7SBESeRPIuKVtBHoNhSb7jlBeLuqmPCwyowj
 0YRTqEcAIwGlM9a5zUPUhU0Bm6NLEGbq0F3xLbaNbidUUJ9WCfpFQjOoCIp8BNfkmQ4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fPMMuhQS2mTvxaxxGhkKChzM2+Z43DxDxcdg+VLxe3c=; b=EWTIMj1RyD3eKLs5PIK1wIuxq2
 9FSrh6/7ZWoBDQ4WcY9EwQLlT+5Bjwig/60n/vwSYipr8dfTq/1I0D+3Uud0u7uMN3h2xy/nVjAzl
 u/247OPqzTvAuEH/+P8EOo8ezwE6jvl8KMrfcIwPrN/ahayy+qnpE2oCXS90i43G9JAQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oHzJo-0001pb-4Z
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 31 Jul 2022 03:08:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C9E260BA3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 31 Jul 2022 03:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38810C433D6;
 Sun, 31 Jul 2022 03:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659236908;
 bh=tawPftnF94jyXfV2ZmURRfIrH7cFklH6ixzelkdY6vM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q3PgaArNxgaBWU0TwQ7i9JXcghaMQBe+njO4dt2ETXSDmDPQdoUc7kkKPAs6gs3ir
 dKRoNbPddLaqkyzJBf/s73FN4CsT+anw/YXvcsyO97vODzyrgtyheOGsSBeR/KmFd3
 l0HBiL65yvRvJLakDLqAzgOSgRFqnAguq3ahykb2UuWx2Br0IJXjZSINU5XUHTnJvy
 09CG02eD4Vi3eq0o/LgIqRCQhVi6MPDIfHxhjxTBZud5EIqVn9XiZ8CCn4JlzUMk9Q
 cf87fjR7QKSKs8lTSQfBgORJxJjeLdihqWOr19SaKyrdWDL76pz/FbUB7a0sV6LfFe
 l8+AbGlYl20tw==
Date: Sat, 30 Jul 2022 20:08:26 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YuXyKh8Zvr56rR4R@google.com>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org>
 <YtyoF89iOg8gs7hj@google.com> <Yt7dCcG0ns85QqJe@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yt7dCcG0ns85QqJe@sol.localdomain>
X-Headers-End: 1oHzJo-0001pb-4Z
Subject: Re: [f2fs-dev] [PATCH v4 6/9] f2fs: don't allow DIO reads but not
 DIO writes
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/25, Eric Biggers wrote:
> On Sat, Jul 23, 2022 at 07:01:59PM -0700, Jaegeuk Kim wrote:
> > On 07/22, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Currently, if an f2fs filesystem is mounted with the mode=lfs and
> > > io_bits mount options, DIO reads are allowed but DIO writes are not.
> > > Allowing DIO reads but not DIO writes is an unusual restriction, which
> > > is likely to be surprising to applications, namely any application that
> > > both reads and writes from a file (using O_DIRECT).  This behavior is
> > > also incompatible with the proposed STATX_DIOALIGN extension to statx.
> > > Given this, let's drop the support for DIO reads in this configuration.
> > 
> > IIRC, we allowed DIO reads since applications complained a lower performance.
> > So, I'm afraid this change will make another confusion to users. Could
> > you please apply the new bahavior only for STATX_DIOALIGN?
> > 
> 
> Well, the issue is that the proposed STATX_DIOALIGN fields cannot represent this
> weird case where DIO reads are allowed but not DIO writes.  So the question is
> whether this case actually matters, in which case we should make STATX_DIOALIGN
> distinguish between DIO reads and DIO writes, or whether it's some odd edge case
> that doesn't really matter, in which case we could just fix it or make
> STATX_DIOALIGN report that DIO is unsupported.  I was hoping that you had some
> insight here.  What sort of applications want DIO reads but not DIO writes?
> Is this common at all?

I think there's no specific application to use the LFS mode at this
moment, but I'd like to allow DIO read for zoned device which will be
used for Android devices.

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
