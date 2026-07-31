Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87090C55167
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 Jul 2026 04:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DhaRmcrXH5sAHozEGWbmsamz8aJHgUbFSkglG9drgz8=; b=DSd0YsuKAfMGmUGrwkbzARLIqk
	Dv2yDgucnpBcrXdT9a/BhxcEkPCZGAvMAVnCegCu7sQiACyuzznRaXRuZ/Vygmme3QbWSCGdHEyk2
	rlxMa+DvxUthKJjoy+UlaCclVCO3Di0PC0KpHjZnoaibPKkmwCGZzPG1aTfReKm84QAM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpeW9-000128-IX;
	Fri, 31 Jul 2026 04:06:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wpeW8-000122-9T
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 04:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fn6R3CY2DDXWCXfEF8whxcR7qeoOx35W3rFoVjeg1R4=; b=akr7hvQVxw1v6Sq/HNxzZUXfhV
 LuA8UCkEgbhHv5cAZzf/q5sYXP2xONhkqPznhUX8rOBATC+SA5gTi+HGSc3yA2M+EDACN7GJmKwJk
 2EwVRWlcnAXX5nmdUw9E6crwkB3eL644wRR27VB9HtRoz4BDjOI4U+tZ2DvEGB3TqCUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fn6R3CY2DDXWCXfEF8whxcR7qeoOx35W3rFoVjeg1R4=; b=ltoFZOhy1rZRBXDH/04sJ16qV0
 2WABL6pC/eCJlSNnWfS/WacpiZnM7RXjTZwzwu2+Hrm7MSOmaLXzvb1R4Wwwk51D5gA7LTya6jNAc
 +9p0Kv2cBlS9Ouz9Apdzhf+mGMCF7ktNIgbLh79Q6+yZ7TCowEI00NTSpGt1ATJeBC6A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpeWB-0006HU-U3 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 04:06:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B45D5600C8;
 Fri, 31 Jul 2026 04:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F261F000E9;
 Fri, 31 Jul 2026 04:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785470794;
 bh=fn6R3CY2DDXWCXfEF8whxcR7qeoOx35W3rFoVjeg1R4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=m7B+fjjEiGq1rqMarKfoQJQ96mJkrzCxoRde8Udl7TiUxoCJtU/TypNioHp3L+iYu
 hLo2t58MraJappvVMHjnsGitHOqF5W0wjGzk7GOvzfTVFy7Qx/RL5WmtEs2dw0yVW5
 X/5s11pJLiivLCbT8OUo1SalZ9VlVQeIPfI+EK4ZG/7ZWy4FgEtr+iy+6XKA0dMVqS
 n7n+dvfMBWTzi0nHe3BEVxaoZyIjstNS7r4dxs264Ux4cZN5XlFcrk9dHzKSp+HAmI
 0bOQ9TqmESz1rpQ9X9kJm6iIiEPi2jphSt9RnUqN5IxyRQizFDyp6xumXI86Ge8p8+
 hkbJfsHCFokQw==
Date: Thu, 30 Jul 2026 21:04:38 -0700
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260731040438.GA57540@sol>
References: <20260730184853.48347-1-ebiggers@kernel.org>
 <20260730125327.11fc9227d04f659a59136cdd@linux-foundation.org>
 <20260730203003.GA2459987@google.com>
 <20260731034931.GA3560112@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260731034931.GA3560112@frogsfrogsfrogs>
X-Headers-End: 1wpeWB-0006HU-U3
Subject: Re: [f2fs-dev] [PATCH] mm/swap: reject swapon() on filesystem-level
 encrypted files
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Chris Li <chrisl@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, linux-fscrypt@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jul 30, 2026 at 08:49:31PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 30, 2026 at 08:30:03PM +0000, Eric Biggers wrote:
> > On Thu, Jul 30, 2026 at 12:53:27PM -0700, Andrew Morton wrote:
> > > On Thu, 30 Jul 2026 11:48:53 -0700 Eric Biggers <ebiggers@kernel.org> wrote:
> > > 
> > > > ext4 and f2fs don't prevent filesystem-level encrypted files from being
> > > > set up directly as swap files.  In this case, encryption is bypassed.
> > > > 
> > > > No one should be doing this, vs. the methods of encrypted swap that
> > > > actually do work (such as swapping to a dm-crypt device, or swapping to
> > > > a loopback device on top of a filesystem-level encrypted file).
> > > > 
> > > > Nevertheless, to prevent user error, make swapon() explicitly reject
> > > > this case.  Document this behavior in fscrypt.rst as well.
> > > > 
> > > > Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
> > > > Fixes: f424f664f0e8 ("f2fs crypto: add encryption policy and password salt support")
> > > 
> > > Ouch.  We are going to break ten year old setups?  I don't think we can
> > > do this!
> > 
> > That assumes anyone is actually depending on this bug, which they
> > probably aren't.  Encrypted swap is done in other ways.
> 
> Hmm.  swapon() seems to read the swapfile header via read_mapping_folio,
> which means that fscrypt will read the encrypted block 0, decrypt it,
> and hand the mm a valid swapfile header, right?
> 
> For blockdev filesystem, the setup_swap_extents code will set up a file
> range -> LBA mapping, and the swap code issues bios directly to the
> bdev.  Ondisk contents aren't encrypted, and read()ing the swapfile will
> produce garbage because we're decrypting something that isn't encrypted.
> 
> So I guess the bug here is that the ondisk swapfile contents aren't
> encrypted?  Can we fix the swap code to call fscrypt_set_bio_crypt_ctx?
> 
> Though, you probably don't want anyone to read the non-header swapfile
> contents, so can one create an ephemeral encryption key for the swap
> code?  Or do you not want crypto engines in the swap path?
> 
> (Apologies for my unfiltered idiot thoughts :P)

Well, the direct swapfile implementation bypasses the filesystem after
the header has been read and the on-disk blocks have been queried.  That
seems to be very much what it's designed to do.  It seems out of scope
for it to start trying to implement filesystem features like fscrypt
file contents encryption.  (Note that there's more to it than calling
fscrypt_set_bio_crypt_ctx(), especially in current mainline.)  After
all, we also wouldn't expect it to understand and implement the
compression, checksums, etc. features of various filesystems.

Yes, when people encrypt their swap, they of course use an ephemeral
key.  However, they use either dm-crypt, or a loop device on top of an
fscrypt file.  (Note that if they use zram with a backing file, they
*have* to use a block device anyway.)

Fortunately, I've never heard of someone actually using the direct
swapon() with an fscrypt file, which is what this patch pertains to.
This case was just found by an LLM review.  I don't think we need to add
a new feature here; we should just remove the footgun just in case.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
