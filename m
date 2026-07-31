Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A70C55167
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 Jul 2026 03:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JBnL7QDEe3AoWNAj/kH53HJqPaMJ9NBeywpLehQmu4I=; b=eXFSx95b52AnyzMViwG8Hsat3T
	K8ebfNxLe/KMqt3Zl5nAsjGH6uLDtQEnNxQ3GSnU63jF6rUWwaz3F7GJ0/BXkIuocNTrbLj6jpOa/
	EwO5Bfm2lpzg3fMcU5Ch+uH2XMFYBTFfF4Ybek7cDEyYq6DbwyGGBhxn9aDxegzqeLPQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpeFf-0000dx-2f;
	Fri, 31 Jul 2026 03:49:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wpeFd-0000dr-J1
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 03:49:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8q+CEcjT0/iBfHUwPXNhK8ziLF4oFgSoOjKvD4YWaGY=; b=lU+KFUmCeYWLAx2Ekvr+GiDSbm
 MnUQudJROi8twFPaArByZZpjNqP25G13BnKbb8iYkuVdY0r4G91bvnF+wasu/hfK1ajCzWbReQMFp
 MP8ttwfqZh4UsQjIlrqokKPKn8qbt00BcooqA9F7glvfTYIL3MMEYOjOEU5ihbPNclq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8q+CEcjT0/iBfHUwPXNhK8ziLF4oFgSoOjKvD4YWaGY=; b=GOsfjirL8VrFPTkDmkNqDn5HdV
 gutKluUmYrkoWwdMN2BvEniCFx+TIvMUtHcCRbvM0/yLbOt9tc50SDRq4LAj7q+emFUiDEWrRbcUq
 FSmvpO5RT9uCD98CQu3hGNZFHyLsch2DPaeLwB0/AyqLXcllqwlrkSLZ22LQvHcfY0qA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpeFd-0000WV-Oc for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 03:49:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 41A32419E8;
 Fri, 31 Jul 2026 03:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 166521F000E9;
 Fri, 31 Jul 2026 03:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785469772;
 bh=8q+CEcjT0/iBfHUwPXNhK8ziLF4oFgSoOjKvD4YWaGY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FwTJNs5Vumh3CUVcguBi+5yKoJxMTtilqRiJuDvone6PZJcbDbmMEHpl1Z7iq9rsE
 6k6RiSo6KxwvDvHKmoW45fM/wgMISyE14ExPq+sNfEPbTgtRwLqz4JlSImEA2+JbQ+
 bB5t4T1gzwpajNR6w86Iy2wFmC20uaYQ3YAkkU5fR7ofK+oT+ZiO4N+dUCrW1pq2Bd
 /EFi7S3O+giNTmCitLkwkXsMZiJeIiWcY+IxIZETcT+vzTTtYB+1qtNHpgZ0HiZnKd
 RaWTtZIRvcAJWa1M24ky031D9SxNY31Y3NYwjtESZz8wkqq05zS8S2YE1ChAUZ7YqS
 sN7F0nocCgRLg==
Date: Thu, 30 Jul 2026 20:49:31 -0700
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260731034931.GA3560112@frogsfrogsfrogs>
References: <20260730184853.48347-1-ebiggers@kernel.org>
 <20260730125327.11fc9227d04f659a59136cdd@linux-foundation.org>
 <20260730203003.GA2459987@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730203003.GA2459987@google.com>
X-Headers-End: 1wpeFd-0000WV-Oc
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
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

On Thu, Jul 30, 2026 at 08:30:03PM +0000, Eric Biggers wrote:
> On Thu, Jul 30, 2026 at 12:53:27PM -0700, Andrew Morton wrote:
> > On Thu, 30 Jul 2026 11:48:53 -0700 Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > > ext4 and f2fs don't prevent filesystem-level encrypted files from being
> > > set up directly as swap files.  In this case, encryption is bypassed.
> > > 
> > > No one should be doing this, vs. the methods of encrypted swap that
> > > actually do work (such as swapping to a dm-crypt device, or swapping to
> > > a loopback device on top of a filesystem-level encrypted file).
> > > 
> > > Nevertheless, to prevent user error, make swapon() explicitly reject
> > > this case.  Document this behavior in fscrypt.rst as well.
> > > 
> > > Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
> > > Fixes: f424f664f0e8 ("f2fs crypto: add encryption policy and password salt support")
> > 
> > Ouch.  We are going to break ten year old setups?  I don't think we can
> > do this!
> 
> That assumes anyone is actually depending on this bug, which they
> probably aren't.  Encrypted swap is done in other ways.

Hmm.  swapon() seems to read the swapfile header via read_mapping_folio,
which means that fscrypt will read the encrypted block 0, decrypt it,
and hand the mm a valid swapfile header, right?

For blockdev filesystem, the setup_swap_extents code will set up a file
range -> LBA mapping, and the swap code issues bios directly to the
bdev.  Ondisk contents aren't encrypted, and read()ing the swapfile will
produce garbage because we're decrypting something that isn't encrypted.

So I guess the bug here is that the ondisk swapfile contents aren't
encrypted?  Can we fix the swap code to call fscrypt_set_bio_crypt_ctx?

Though, you probably don't want anyone to read the non-header swapfile
contents, so can one create an ephemeral encryption key for the swap
code?  Or do you not want crypto engines in the swap path?

(Apologies for my unfiltered idiot thoughts :P)

--D

> 
> > I think the best we can do is to emit loud warnings which point the
> > operator to some Documentation/ which tells operator that this
> > deprecated configuration will be disallowed in, umm, 2029.
> 
> ... and if they are, they'll want to fix it right away anyway, not in
> 2029.
> 
> Other fixes to explicitly disallow swapfile activation in various cases
> have been merged without a deprecation period, e.g. 36e4d95891ed,
> 377eeaa8e11f, 51cc3a6620a6, d15cab975459.
> 
> I think we should try just doing this instead of dragging it out over
> several years.
> 
> - Eric
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
