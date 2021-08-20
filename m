Return-Path: <SRS0=HVTi=NL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FB4C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Aug 2021 18:12:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB92561056
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Aug 2021 18:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB92561056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mH8zz-0005X7-NW; Fri, 20 Aug 2021 18:12:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ebiggers@kernel.org>) id 1mH8zy-0005X0-9m
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Aug 2021 18:12:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TPqUYMy/FIO0gXXDbtep4gWofQeg7iQ19nzO81jGffk=; b=gENb063LO1eFD4uRdhwFBBwZXj
 mKgwSsRzmHHuJgOcjU28c8gRQn9VJH8uIlwXDtJ7aLbS9bOewLDkWOdkhxJR1emRySPW3zXt/P6IW
 JVaVWTYtuArHq3A71V2MbaX59AKUMDt6h3khCS179joPWHbUCWiTJqcByNXAJyg72hPM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TPqUYMy/FIO0gXXDbtep4gWofQeg7iQ19nzO81jGffk=; b=P/opPQRB/65ySt0ABVzqQAaFYa
 2I3c6B6Ve0oGVlmgGbTAynfne5jKVU4S5fbuGK+w5QiQjPlvy87ubLF0f+2qDxhWJWgBYiAllyrli
 VwIvOcy6lDzepg2EAXG4AFwAvH2dvDUE3QqSJJAeek8Yean4TAeAcS4EORXqHu9L6njc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mH8zx-00D1Nn-OG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Aug 2021 18:12:10 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CCD0608FE;
 Fri, 20 Aug 2021 18:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629483119;
 bh=Ug/nWYFe3aKoUQ5ituPguHYC0Y4myQql1SYX/rV6X0I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Iw/pdnyA1ONdK54eU3zepv0FOEWjZfqHh/RkIXhlPBxtuC4OmDr9Kk2O1pfyJ4C9M
 3h6MZ9qQYAKU97s+TaFb/HaVE95J5ceCxEz7ZqHZhuSHC7CoQauuvQxrufQMZ34JSd
 jYcc9/nS1IX0yUszV5lG4L8UPYx2BXAgGucNqeQ00P6YdkNfKs9eJOYpoKMW2ARgoN
 m2ClveBPVxKXayI/GIMjgKYm/m4hn4rxgWaiMDX726PO1vZJunLmoEGljqXGzTbWaq
 fEqJHXaAA1sCy7qpwRTnSPNiUGQ7y5CXZiWIyMWUmW9AQv7IVRz2iRLKoAXZQAWJZS
 nKbPOK5SQHcMA==
Date: Fri, 20 Aug 2021 11:11:57 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YR/wbenc0d3eMAjz@sol.localdomain>
References: <20210728015154.171507-1-ebiggers@kernel.org>
 <YQRQRh1zUHSIzcC/@gmail.com> <YQS5eBljtztWwOFE@mit.edu>
 <YQd3Hbid/mFm0o24@sol.localdomain>
 <a3cdd7cb-50a7-1b37-fe58-dced586712a2@kernel.org>
 <YQg4Lukc2dXX3aJc@google.com>
 <b88328b4-db3e-0097-d8cc-f250ee678e5b@kernel.org>
 <YQidOD/zNB17fd9v@google.com> <YRsY6dyHyaChkQ6n@gmail.com>
 <c4e5c71d-1652-7174-fa36-674fab4e61df@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c4e5c71d-1652-7174-fa36-674fab4e61df@kernel.org>
X-Headers-End: 1mH8zx-00D1Nn-OG
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
Cc: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 20, 2021 at 05:35:21PM +0800, Chao Yu wrote:
> > > > > 
> > > > > Hmm, I'm still trying to deal with this as a corner case where the writes
> > > > > haven't completed due to an error. How about keeping the preallocated block
> > > > > offsets and releasing them if we get an error? Do we need to handle EIO right?
> > > > 
> > > > What about the case that CP + SPO following DIO preallocation? User will
> > > > encounter uninitialized block after recovery.
> > > 
> > > I think buffered writes as a workaround can expose the last unwritten block as
> > > well, if SPO happens right after block allocation. We may need to compromise
> > > at certain level?
> > > 
> > 
> > Freeing preallocated blocks on error would be better than nothing, although note
> > that the preallocated blocks may have filled an arbitrary sequence of holes --
> > so simply truncating past EOF would *not* be sufficient.
> > 
> > But really filesystems need to be designed to never expose uninitialized data,
> > even if I/O errors or a sudden power failure occurs.  It is unfortunate that
> > f2fs apparently wasn't designed with that goal in mind.
> > 
> > In any case, I don't think we can proceed with any other f2fs direct I/O
> > improvements until this data leakage bug can be solved one way or another.  If
> > my patch to remove support for allocating writes isn't acceptable and the
> > desired solution is going to require some more invasive f2fs surgery, are you or
> > Chao going to work on it?  I'm not sure there's much I can do here.
> 
> I may have time to take look into the implementation as I proposed above, maybe
> just enabling this in FSYNC_MODE_STRICT mode if user concerns unwritten data?
> thoughts?
> 

What does this have to do with fsync?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
