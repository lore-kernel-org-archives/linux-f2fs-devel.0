Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B8C6377B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 01:15:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5658E6124C;
	Thu, 22 Jul 2021 01:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5658E6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6NJK-0007TN-SE; Thu, 22 Jul 2021 01:15:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1m6NJJ-0007TD-Uk
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 01:15:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i+fmLgAdx81DNtRq7DKd/O+qOacw2cMLni/qqOzuDas=; b=jwGX41DbjUJ6KjrQf06ysiLc3A
 TPbdkelv5c95p538Eo/FObtMasiKyBwBlKSbqI1+TO2QjCY3oAEsohPx3z9jgsCvpLXatT8ubiczm
 G1jdF6LyMnVwD/4GATqSPscENiNozwBn25L/CeYciV5wn3cXKzVtk2+xdv6rlbj/4NTM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i+fmLgAdx81DNtRq7DKd/O+qOacw2cMLni/qqOzuDas=; b=VRc/chZE42icBI4QXn30XI6YPJ
 tuYlPWWA41U4M2DDaPlx4Uh1soFegrPMfV+fMtlNX0HHCD2fpM24thOOttEgYNnth6IpaaiXbQGF0
 Q376e3DJWYrSvARj3bdJDemkc4/Vb0E++eNzvlRYQnG6XUpByjKIHpZ0RrCzhashbn5U=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6NJI-0007DD-Oe
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 01:15:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E9CE6124C;
 Thu, 22 Jul 2021 01:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626916531;
 bh=GaVQicUhjkmQkYHkwrmTNCTCP0y+Fr+V1Mf5yu+VXkw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tApb709Q14Yitul7dsgDlUlIxQrQ9rI3sdZhYS+mxUSMHp8xNA/07eEa64xJjqhF0
 IDBk897tj4Ffb6u6vILM5Hz103KZgXPjukxS80z5vfk78y38Q7zd4z3OIK+jfERPER
 uOf1zxkIq7ltmlgxF+QqUoC0eSbXfL5wbSqLd7EG6IRDco9tbbycBOhmhhNYxeAceH
 NiHlfVVhhYWV8LVMvorh3cNLXxyYhCGvLMspi8iqbcq1lpB0gYlQP8eIaptJiabIGr
 GcWUXBGMBQkL0Shr/RD0kzR6mPT/b4G2euqO/iz4ROTZEPieDhYvHf0QVS1JGKxNhQ
 jehc8kmRtF2qw==
Date: Wed, 21 Jul 2021 18:15:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <YPjGsSEdsoSsCJlB@sol.localdomain>
References: <20210721072048.3035928-1-daeho43@gmail.com>
 <YPiTLwB3d8BWSKje@gmail.com>
 <CACOAw_xq3_ccqzh8dnomFXBOK_iN9LOTsOBYSBzDJHSSDrRxVw@mail.gmail.com>
 <YPi4rRg2ZPFBWaTZ@sol.localdomain>
 <CACOAw_xeTSa8J_9=+6thXvFT75u734D5asNRogUxt+DC-tPhxg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACOAw_xeTSa8J_9=+6thXvFT75u734D5asNRogUxt+DC-tPhxg@mail.gmail.com>
X-Headers-End: 1m6NJI-0007DD-Oe
Subject: Re: [f2fs-dev] [PATCH] f2fs: change fiemap way in printing
 compression chunk
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 21, 2021 at 06:04:22PM -0700, Daeho Jeong wrote:
> >
> > How f2fs stores the mapping information doesn't matter.  That's an
> > implementation detail that shouldn't be exposed to userspace.  The only thing
> > that should be exposed is the actual mapping, and for that it seems natural to
> > report the physical blocks first.
> >
> > There is no perfect solution for how to handle the remaining logical blocks,
> > given that the fiemap API was not designed for compressed files, but I think we
> > should just go with extending the length of the last compressed extent in the
> > cluster to cover the remaining logical blocks, i.e.:
> >
> >   [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
> >
> > That's what btrfs does on compressed files.
> >
> > - Eric
> 
> I also agree that that's an implementation detail that shouldn't be
> exposed to userspace.
> 
> I want to make it more clear for better appearance.
> 
> Do you think we have to remove "unwritten" information below? I also
> think it might be unnecessary information for the user.
> [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
> (unwritten?)

FIEMAP_EXTENT_UNWRITTEN already has a specific meaning; see
Documentation/filesystems/fiemap.rst.  It means that the data is all zeroes, and
the disk space is preallocated but the data hasn't been written to disk yet.

In this case, the data is *not* necessarily all zeroes.  So I think
FIEMAP_EXTENT_UNWRITTEN shouldn't be used here.

> Do you want f2fs to print out the info on a cluster basis, even when
> the user asks for one block information?
> Like
> If the user asks for the info of [8..15], f2fs will return the info of [0..31]?

Yes, since that's how FS_IOC_FIEMAP is supposed to work; see
Documentation/filesystems/fiemap.rst:

	All offsets and lengths are in bytes and mirror those on disk.  It is
	valid for an extents logical offset to start before the request or its
	logical length to extend past the request.

(That being said, the f2fs compression+encryption tests I've written don't
exercise this case; they only map the whole file at once.)

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
