Return-Path: <SRS0=oA2u=UF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A847FC28EB3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:43:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAF4206BB;
	Thu,  6 Jun 2019 19:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cQmJIDJ1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ex8Jz4H2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgJAtXXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAF4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hYyIj-0002ZS-Oy; Thu, 06 Jun 2019 19:43:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hYyIj-0002ZM-8B
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Jun 2019 19:43:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XNKQ3wZCML3KsIcJhQ4TQeljDty6iS4ysutaWt+0N4I=; b=cQmJIDJ1jb1fU9kNAiJzSzC0Ft
 +OIQQ8ca1o/EuopYcteyAzeqr6fdwXJFbSikZuAvyiFH6/D2CEpzcq/x4xfFvJiB05uVHMj4+k/9u
 S/wsmAM5sP/as6wIHrMO4fDfDqHKIa/f8/PxzRkGJtGSucNXArk76pP3xuIpMGf/YJhA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XNKQ3wZCML3KsIcJhQ4TQeljDty6iS4ysutaWt+0N4I=; b=ex8Jz4H2GvNI75efJG7CMRTb/j
 M2c05Wf1QuVhy+BuXxWQeGV/e7XZXIgdRUPRy1EeXhmhK7g1k2duHQu9Qq417Wgsc9KSm+II46HAt
 GR5TGnFjEK5f6FMP9MQ1exrGPUm9a98iugftjDt/TKmk5kfB0wzvHNy2g7kRdt2TW6gI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hYyIh-0068IK-UL
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Jun 2019 19:43:53 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CBD36206BB;
 Thu,  6 Jun 2019 19:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559850226;
 bh=Fege0efxE/bsHjarKcgO1NRvY4phBlvmuwpR58JTZgk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HgJAtXXa+H7X3BCggX8tzS8k3dpOhCm7dRBrPabKkhiRglFoiu/8HtgJPlN9xmnyy
 Gp2M1DQt0DA1J57r+n0aOjWprz5ItKFbCPegohLbpQoEr+QpGd1CCtY6w6aBC2nbsx
 rEupwgxDdkpH8akd0Ifm9wSECTgZZq2LBh8a8N1M=
Date: Thu, 6 Jun 2019 12:43:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190606194343.GA84833@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hYyIh-0068IK-UL
Subject: Re: [f2fs-dev] [PATCH v4 00/16] fs-verity: read-only file-based
 authenticity protection
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Linux API <linux-api@vger.kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-integrity@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190606194344.mrxEy1-3Msy3YUUE-OwAHa9ofeB0fwn3gF7Wrwbl3uc@z>

On Thu, Jun 06, 2019 at 10:21:12AM -0700, Linus Torvalds wrote:
> On Thu, Jun 6, 2019 at 8:54 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > This is a redesigned version of the fs-verity patchset, implementing
> > Ted's suggestion to build the Merkle tree in the kernel
> > (https://lore.kernel.org/linux-fsdevel/20190207031101.GA7387@mit.edu/).
> > This greatly simplifies the UAPI, since the verity metadata no longer
> > needs to be transferred to the kernel.
> 
> Interfaces look sane to me. My only real concern is whether it would
> make sense to make the FS_IOC_ENABLE_VERITY ioctl be something that
> could be done incrementally, since the way it is done now it looks
> like any random user could create a big file and then do the
> FS_IOC_ENABLE_VERITY to make the kernel do a _very_ expensive
> operation.
> 
> Yes, I see the
> 
> +               if (fatal_signal_pending(current))
> +                       return -EINTR;
> +               cond_resched();
> 
> in there, so it's not like it's some entirely unkillable thing, and
> maybe we don't care as a result. But maybe the ioctl interface could
> be fundamentally restartable?
> 
> If that was already considered and people just went "too complex", never mind.
> 
>                Linus

Making it incremental would be complex.  We could make FS_IOC_ENABLE_VERITY
write checkpoints periodically, and make it resume from the checkpoint if
present.  But then we'd have to worry about sync'ing the Merkle tree before
writing each checkpoint, and storing the Merkle tree parameters in each
checkpoint so that if the second call to FS_IOC_ENABLE_VERITY is made with
different parameters it knows to delete everything and restart from scratch.

Or we could make it explicit in the UAPI, where userspace calls ioctls to build
blocks 0 through 9999, then 10000 through 19999, etc.  But that would make the
UAPI much more complex, and the kernel would need to do lots of extra validation
of the parameters passed in.  This approach would also not be crash-safe unless
userspace did its own checkpointing, whereas the all-or-nothing API naturally
avoids inconsistent states.

And either way of making it incremental, the "partial Merkle tree" would also
become a valid on-disk state.  Conceptually that adds a lot of complexity, and
probably people would want fsck to support removing all the partial trees,
similar to how e2fsck supports optimizing directories and extent trees.

So in the end, it's not something I decided to add.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
