Return-Path: <SRS0=6Xs1=NI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE7C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 21:33:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5D86102A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 21:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D5D86102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mG6i0-0001fF-Oe; Tue, 17 Aug 2021 21:33:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1mG6hx-0001en-Ay
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 21:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/p1HqFDiRn9Y9O0iasTV2zjQZXBX8ho1ZrJLeT4bg3Y=; b=kxP6pz3jKXbbb//MEXaM8bA/gI
 QNcxWb2C2Pho0i8m35CKyldIJ1oOv35RtWfQFWwMKIYV1zSYnBNAWWmwTZaBgNmDKOaMxGxSKnxv6
 SD7y97dJNHgKUCVAY0vkAn/3Bq8WhhiiBhL6O7VQKAc4+GSI8eB7VhxZ/f5+xxz3euDM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/p1HqFDiRn9Y9O0iasTV2zjQZXBX8ho1ZrJLeT4bg3Y=; b=Fg8KVrd1HnCtjR0Zpda8AqHDYd
 6gNW9q8JVC4MKBAfp73NtQyF45RDL52USRjZugFfmSr/4fbvyJRp8gKmoJTWnYpfcgdJ4M39mLvqt
 5t4YrYJH/05DZwjEh8YxpA2qnMiMiFBtRIpdJeXIH0iiw/ohvd2SOe9VPzyufJg0pdwo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mG6hw-009jhS-MQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 21:33:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFF856102A;
 Tue, 17 Aug 2021 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629235983;
 bh=xVqqusANjWjiZJj04FExq0+u8p7nTpL/OI9T5B6Tlj8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=trQmfnQijnQe6/I02OLm807AgvwU5sMGOpNyBIqFYAN9jBHcWKDNHFoS7CHja8xPU
 QiYAdpkCjAu0R+XVlvNhKX7rA++IwwQCJ6oKhyoz0iV1FvOy8rUDx2R6mpBbyI33qn
 nRxWqzgsCpCYmQEyonuBf7YdkDQdjSwiJvZjMVEchkyH2pI/wov672N2C+eJ9SAszj
 EkIaP/92BLOXXd+wXSXT03nXg3+9giewloES4Rwi4eHye+XKB4Nz6wK09RY6SYHNIa
 JHOHNpx3zqSN0140xAT4GwSvR0FVvMytl9jPstJDlVzKaNAZGdIGgZp8Pfy1ItkFI/
 UNWG/Mt4xLo/w==
Date: Tue, 17 Aug 2021 14:33:01 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YRwrDdcryfTH4Vwi@google.com>
References: <YQS5eBljtztWwOFE@mit.edu> <YQd3Hbid/mFm0o24@sol.localdomain>
 <a3cdd7cb-50a7-1b37-fe58-dced586712a2@kernel.org>
 <YQg4Lukc2dXX3aJc@google.com>
 <b88328b4-db3e-0097-d8cc-f250ee678e5b@kernel.org>
 <YQidOD/zNB17fd9v@google.com> <YRsY6dyHyaChkQ6n@gmail.com>
 <YRtMOqzZU4c1Vjje@infradead.org> <YRwGqsLgyKqdbkGX@google.com>
 <YRwblEj2b/tIBh8b@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YRwblEj2b/tIBh8b@gmail.com>
X-Headers-End: 1mG6hw-009jhS-MQ
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove broken support for allocating
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
Cc: Theodore Ts'o <tytso@mit.edu>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/17, Eric Biggers wrote:
> On Tue, Aug 17, 2021 at 11:57:46AM -0700, Jaegeuk Kim wrote:
> > On 08/17, Christoph Hellwig wrote:
> > > On Mon, Aug 16, 2021 at 07:03:21PM -0700, Eric Biggers wrote:
> > > > Freeing preallocated blocks on error would be better than nothing, although note
> > > > that the preallocated blocks may have filled an arbitrary sequence of holes --
> > > > so simply truncating past EOF would *not* be sufficient.
> > > > 
> > > > But really filesystems need to be designed to never expose uninitialized data,
> > > > even if I/O errors or a sudden power failure occurs.  It is unfortunate that
> > > > f2fs apparently wasn't designed with that goal in mind.
> > > > 
> > > > In any case, I don't think we can proceed with any other f2fs direct I/O
> > > > improvements until this data leakage bug can be solved one way or another.  If
> > > > my patch to remove support for allocating writes isn't acceptable and the
> > > > desired solution is going to require some more invasive f2fs surgery, are you or
> > > > Chao going to work on it?  I'm not sure there's much I can do here.
> > > 
> > > Btw, this is generally a problem for buffered I/O as well, although the
> > > window for exposing uninitialized blocks on a crash tends to be smaller.
> > 
> > How about adding a warning message when we meet an error with preallocated
> > unwritten blocks? In the meantime, can we get the Eric's patches for iomap
> > support? I feel that we only need to modify the preallocation and error
> > handling parts?
> 
> A warning message would do nothing to prevent uninitialized blocks from being
> leaked to userspace.

To give a signal that it's a known issue that we'll fix later.

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
