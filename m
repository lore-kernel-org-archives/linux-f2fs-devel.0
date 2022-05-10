Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA08C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 May 2022 23:23:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1noZCc-0005fS-TV; Tue, 10 May 2022 23:23:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1noZCb-0005fM-PW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 May 2022 23:23:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cp70BUpCCE4RFwC+nEreumrpoMpQlU4/sdMRucnYpP0=; b=LnPpF8Ys3S/HlV4+0aXv4DVxMp
 l4UQmpNynhRQXi7Sfmaf5H8l4TDgGJKGYKz5p1c7PVZf+uEmJ2bFOVlnEu2s0L91tPJoMW/leMO7/
 sjiUgXBfGAPtZLBxhQqIIn8FHD6OFcipn0S0pVN/RxY/6N7M1ohJo0MwiQFBs2T7UarI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Cp70BUpCCE4RFwC+nEreumrpoMpQlU4/sdMRucnYpP0=; b=fJLAmCHtVjhSU38FsymlSDMzY8
 D3pLg19coKBzmg6NpvYq7viGOvERCRH/2szC4NIy1GIvyk+bDN3KaEKZN+5hv5LMxIuHu6yDXjx8I
 UBgDmjn6Rm1uxxE1p++lnN6pyHoj112tNkdy7bJp8Y5CDGRk8kQBrd3xu/vBx+djljc4=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1noZCW-0001C5-Pu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 May 2022 23:23:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E1A84B81FCF;
 Tue, 10 May 2022 23:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F481C385CE;
 Tue, 10 May 2022 23:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652225003;
 bh=e59r18xSxhijBVYd8jpKjsz2cx3igw6HBJgjPaVJtDY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Sv0ubqWbpdeqLbwbUaUTEs6+W/fnUGWHrFuHBYr82WMm9aR4ymhqifd0jvcmpBNb0
 LoS+NHYvGR2oXcO+EyUYfftGyD4gvMCNThE4IO0UgIEFihoFphP8kpd8IFl1mCdkuV
 pr9JuYpOJdljpQn0eU+yVswhajqRkAVdHvq+5ZmnW1cBcVNFiq0UH0WPDttPtQtrPH
 ZPt6sF1xd68swqRfy53yRl2OwrzTzV9o2h20dSy4rScODkm04zjr+Iej3Hh5y8sPPi
 eZTh8rWM7WxXXEB2wNEZAprzcwVyArX3NRLNSYmFh3tV5BVUA1cxnndvq1Vkn4L+8J
 U8ep19b3ySU9Q==
Date: Tue, 10 May 2022 16:23:21 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <Ynrz6foNrUwivT94@google.com>
References: <20220501050857.538984-1-ebiggers@kernel.org>
 <YnmlZ15YPS1cy4aV@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YnmlZ15YPS1cy4aV@sol.localdomain>
X-Headers-End: 1noZCW-0001C5-Pu
Subject: Re: [f2fs-dev] [PATCH v2 0/7] test_dummy_encryption fixes and
 cleanups
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
Cc: Theodore Ts'o <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/09, Eric Biggers wrote:
> On Sat, Apr 30, 2022 at 10:08:50PM -0700, Eric Biggers wrote:
> > This series cleans up and fixes the way that ext4 and f2fs handle the
> > test_dummy_encryption mount option:
> > 
> > - Patches 1-2 make test_dummy_encryption consistently require that the
> >   'encrypt' feature flag already be enabled and that
> >   CONFIG_FS_ENCRYPTION be enabled.  Note, this will cause xfstest
> >   ext4/053 to start failing; my xfstests patch "ext4/053: update the
> >   test_dummy_encryption tests" will fix that.
> > 
> > - Patches 3-7 replace the fscrypt_set_test_dummy_encryption() helper
> >   function with new functions that work properly with the new mount API,
> >   by splitting up the parsing, checking, and applying steps.  These fix
> >   bugs that were introduced when ext4 started using the new mount API.
> > 
> > We can either take all these patches through the fscrypt tree, or we can
> > take them in multiple cycles as follows:
> > 
> >     1. patch 1 via ext4, patch 2 via f2fs, patch 3-4 via fscrypt
> >     2. patch 5 via ext4, patch 6 via f2fs
> >     3. patch 7 via fscrypt
> > 
> > Ted and Jaegeuk, let me know what you prefer.
> > 
> > Changed v1 => v2:
> >     - Added patches 2-7
> >     - Also reject test_dummy_encryption when !CONFIG_FS_ENCRYPTION
> > 
> > Eric Biggers (7):
> >   ext4: only allow test_dummy_encryption when supported
> >   f2fs: reject test_dummy_encryption when !CONFIG_FS_ENCRYPTION
> >   fscrypt: factor out fscrypt_policy_to_key_spec()
> >   fscrypt: add new helper functions for test_dummy_encryption
> >   ext4: fix up test_dummy_encryption handling for new mount API
> >   f2fs: use the updated test_dummy_encryption helper functions
> >   fscrypt: remove fscrypt_set_test_dummy_encryption()
> 
> Since I haven't heard from anyone, I've gone ahead and applied patches 3-4 to
> fscrypt#master for 5.19, so that the filesystem-specific patches can be taken in
> 5.20.  But patches 1-2 could still be applied now.

Hi Eric,

Let me apply #2 in the f2fs tree first.
You can put "Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>" in #6.

Thanks,

> 
> Any feedback on this series would be greatly appreciated!
> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
