Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83785E8B375
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GId2io22jNQATOadutWGBpYLCJOtkOUiP195oKwm4Ak=; b=RmUBwmuFxiOjHOKFEP6ASNX6j9
	71Yf0xeHodrNhj1eP2ngExFCQWCA2CGxwM21L1lVPDMJI5Qb31IoMiNYtFgoD2xAbU/1O2WRX2CNH
	r9lUOXpUkjl92BlIszfQWH3BamRVuxwD0+AHUOHpelX2ONxfguFN2XP6xLjOQ8I+N79U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vnPOt-0001XU-BP;
	Tue, 03 Feb 2026 23:01:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vnPOs-0001XO-D8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 23:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kte147V4yHmLnX7PSerPack63O9JN9FG1nzBfVGN0QU=; b=SPt6HuYlijrszPszLpqM2gyAfQ
 JAKsME2r7rZ778BlsuzLSr6mH+ff/54B3GHOkITCnMLHvuLcOupq4j/oyTOqXOZ4NItgChI1HyIki
 EB5udX/iufnGiydv6zfp39v4XNY0NzIwfwYGUikdjwm/796E2cBjZ0celO+8klrjZs1k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Kte147V4yHmLnX7PSerPack63O9JN9FG1nzBfVGN0QU=; b=lNuTtJTgsZR6km2+krJnApEN9L
 fZM8Yqv7RqJAQXALqb11J1NcCttb8BYAAPenolkK3Kei+Fz37Je8LH64w8doxAjkiKJ98dxhn7Wcz
 If3eBuaFeXf/vH45eA9ZFAR5dbwKeFWszgXeyn9/syYC1kbpb4zkYTfTfnD6Xltx8aVE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vnPOr-00045D-PD for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 23:01:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E81176012A;
 Tue,  3 Feb 2026 23:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03C7C2BC86;
 Tue,  3 Feb 2026 23:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770159686;
 bh=6+OC8xqFJ8Ra/JiM0dVaFvJDlj+ZOH9NPyD2sp5CHvc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L5yZ+41Lkhu4k67GeeWfmbzf7Bese7xS9DR+H7NtUWfk91m1eJVADLP2RVyzrG+Ct
 rgh1e0VvKFsqLRGyjoYNtTZFT7YqajHJ0wSLMJcfhM5ZPrSHdzGFxnyc4B0PaU6kW9
 rJy05Vubc9PFZSKul5Xp55uXRpbD2FSJXhZEnL2RCcqWCSURqndssF/HGVX2B1XJmf
 8U17Twn+xWoR4ftCuLkx+aEvjAjfWHNPaYD6hPOXSpPwVfs+QwPXjiwrxEHVhfHe1Y
 kaG1r7vgEzvrEjWXW1Lm8XwAsdwwRTcPpbQMVWvxRWMYfQFuHmjXOpJjPj9wpxjX/l
 EMOw47C5+xn5Q==
Date: Tue, 3 Feb 2026 23:01:24 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <20260203230124.GA1161785@google.com>
References: <CAHPqNmwK9TY5THsXWkJuYCdt7x+mZHPq65AUOLZJeMp-FdAMvA@mail.gmail.com>
 <aYBiza9L1hmhmXbb@hyeyoo>
 <fwutwpejyptpo6gqv75zanqciv3fmxvillomwcjvtz4auebbc2@vazub2ct7pa2>
 <aYHFZ5OxfL4j-_ze@hyeyoo> <aYIh1wPm7BrId9dk@infradead.org>
 <6f5881df-0e0b-4278-808b-7c0cffa12a30@suse.cz>
 <aYIpVq-jTKyTQE8G@infradead.org>
 <d9dc2ee1-283d-4467-ad36-a6a4aa557589@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9dc2ee1-283d-4467-ad36-a6a4aa557589@suse.cz>
X-Headers-End: 1vnPOr-00045D-PD
Subject: Re: [f2fs-dev] [Kernel Bug] WARNING in mempool_alloc_noprof
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
Cc: Vernon Yang <vernon2gm@gmail.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 roman.gushchin@linux.dev, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, linux-fscrypt@vger.kernel.org, syzkaller@googlegroups.com,
 Harry Yoo <harry.yoo@oracle.com>, cl@gentwo.org, rientjes@google.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, akpm@linux-foundation.org,
 =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Feb 03, 2026 at 07:30:07PM +0100, Vlastimil Babka wrote:
> On 2/3/26 17:59, Christoph Hellwig wrote:
> > On Tue, Feb 03, 2026 at 05:55:27PM +0100, Vlastimil Babka wrote:
> >> On 2/3/26 17:27, Christoph Hellwig wrote:
> >> > On Tue, Feb 03, 2026 at 06:52:39PM +0900, Harry Yoo wrote:
> >> >> Maybe the changelog could be rephrased a bit,
> >> >> but overall LGTM, thanks!
> >> > 
> >> > 
> >> > No, that does not make sense.  If mempool is used with __GFP_RECLAIM in
> >> > the flags it won't fail, and if it isn't, GFP_NOFAIL can't work.
> >> 
> >> So that means as long as there's __GFP_RECLAIM, __GFP_NOFAIL isn't wrong,
> >> just redundant.
> > 
> > Given how picky the rest of the mm is about __GFP_NOFAIL, silently
> > accepting it where it has no (or a weird and unexpected) effect
> > seems like a disservice to the users.
> 
> OK then. But I don't think we need to add checks to the mempool hot paths.
> If somebody uses __GFP_NOFAIL, eventually it will trickle to the existing
> warning that triggered here. If it's using slab then eventually that will
> reach the page allocator too. Maybe not with some custom alloc functions,
> but meh.
> 
> This f2fs_encrypt_one_page() case is weird though (and the relevant parts
> seem to be identical in current mainline).
> It uses GFP_NOFS, so __GFP_RECLAIM is there. It only adds __GFP_NOFAIL in
> case fscrypt_encrypt_pagecache_blocks() already failed with -ENOMEM.
> 
> That means fscrypt_alloc_bounce_page() returns NULL, which is either the
> WARN_ON_ONCE(!fscrypt_bounce_page_pool) case (but the report doesn't include
> such a warning), or mempool_alloc() failed - but that shouldn't happen with
> GFP_NOFS?
> 
> (Also the !fscrypt_bounce_page_pool is therefore an infinite retry loop,
> isn't it? Which would be truly a bug, unless I'm missing something.)
> 
> Ah but fscrypt_encrypt_pagecache_blocks() can also return -ENOMEM due to
> fscrypt_crypt_data_unit() returning it.
> 
> And there theoretically in v6.12.11 skcipher_request_alloc() could return
> -ENOMEM. In practice I assume this report was achieved by fault injection.
> But that possibility is gone with mainline commit 52e7e0d88933 ("fscrypt:
> Switch to sync_skcipher and on-stack requests") anyway.
> 
> I think the whole "goto retry_encrypt;" loop in f2fs_encrypt_one_page()
> should just be removed.

Indeed, fscrypt_encrypt_pagecache_blocks() (or the older code it was
derived from) used to do multiple memory allocations.  Now it only
allocates the bounce page itself.

Also, the intended usage is what ext4 does: use GFP_NOFS for the first
page in the bio for a guaranteed allocation from the mempool, then
GFP_NOWAIT for any subsequent pages.  If any of the subsequent
allocations fails, ext4 submits the bio early and starts a new one.

f2fs does it differently and just always uses GFP_NOFS.  Yes, that
doesn't make sense.  I guess ideally it would be changed to properly do
opportunistic allocations in the same way as ext4.  But until then, just
removing the retry loop sounds good.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
