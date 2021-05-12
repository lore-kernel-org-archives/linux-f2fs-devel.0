Return-Path: <SRS0=WM5+=KH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE05C433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 May 2021 19:52:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE15B613F7;
	Wed, 12 May 2021 19:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE15B613F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lguu7-0003bE-Aa; Wed, 12 May 2021 19:52:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dsterba@suse.cz>)
 id 1lguu5-0003az-NP; Wed, 12 May 2021 19:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JB9l6qReFLdsHsK92QdKe/F6qjY3MdO6bXxgB7TRwU4=; b=HRWvGS/AcM4PqAaLXkok53KUOb
 Aolkd0e0bRAIT6PrXaBLBtBoab4lIGLIz1YJmez9AUx0ZUbIwwAReZRLxRAy4hzHoJyD+IDZOG+4w
 8UTtSxJbGHOkzTANE4HLCBHrH53yBxIgUZxPjvgmLSrTbFu3wMgfytXu517IO4Nk0wEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JB9l6qReFLdsHsK92QdKe/F6qjY3MdO6bXxgB7TRwU4=; b=eunQ77hggdWQPwf1Rn4zjryYCm
 2mX2zf90BDPrh7r3MVvqYaY9J6Y2ZEkYeZPgXsERJ4tfNoNCsrf7INsy1zwlyb97GUQotrqXuj2x3
 V2AVWswzhoGYaAo2cVoJVm3NSmgOrA0jFEnLn1nEh929oWgQSSNanHHCK7w3Xd3ja5ls=;
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1lguu2-005toY-9h; Wed, 12 May 2021 19:52:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 178B9AC6A;
 Wed, 12 May 2021 19:52:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id D4311DA7B0; Wed, 12 May 2021 21:49:35 +0200 (CEST)
Date: Wed, 12 May 2021 21:49:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Nick Terrell <terrelln@fb.com>
Message-ID: <20210512194935.GY7604@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Nick Terrell <terrelln@fb.com>,
 Nick Terrell <nickrterrell@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 "squashfs-devel@lists.sourceforge.net" <squashfs-devel@lists.sourceforge.net>, 
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, 
 LKML <linux-kernel@vger.kernel.org>,
 Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
 Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
 Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
 Christoph Hellwig <hch@infradead.org>,
 =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Felix Handte <felixh@fb.com>, Eric Biggers <ebiggers@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, torvalds@linux-foundation.org
References: <20210430013157.747152-1-nickrterrell@gmail.com>
 <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Headers-End: 1lguu2-005toY-9h
Subject: Re: [f2fs-dev] [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
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
Reply-To: dsterba@suse.cz
Cc: "squashfs-devel@lists.sourceforge.net"
 <squashfs-devel@lists.sourceforge.net>, Randy Dunlap <rdunlap@infradead.org>,
 Eric Biggers <ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Christoph Hellwig <hch@infradead.org>, Nick Terrell <nickrterrell@gmail.com>,
 Yann Collet <cyan@fb.com>, David Sterba <dsterba@suse.cz>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, Petr Malat <oss@malat.biz>,
 Chris Mason <clm@fb.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Felix Handte <felixh@fb.com>, Oleksandr Natalenko <oleksandr@natalenko.name>,
 Kernel Team <Kernel-team@fb.com>,
 =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 torvalds@linux-foundation.org, Niket Agarwal <niketa@fb.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Johannes Weiner <jweiner@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 11, 2021 at 08:53:41PM +0000, Nick Terrell wrote:
> Pinging this series. Is there anything I should do to help get this
> merged?
> 
> The use of zstd in the kernel is continuously increasing over time,
> both in terms of number of use cases, and number of users that
> actually enable zstd compression in production. E.g. Fedora is
> making btrfs with zstd compression enabled the default.
> 
> I would love to see the zstd code updated to the latest upstream
> and be kept up to date. The latest upstream brings bug fixes, and
> significant performance improvements. Additionally, the latest
> upstream code is continuously fuzzed.

The btrfs community and I in particular have interest to get zstd
updated but also there's the patch 3 that goes against what kernel
requires regarding patch size and logical split of changes.

That the update is so large shouldn't have happened, it covers 3 years
of development, the syncs should have happened more often, but here we
are.

Other points that have been raised in the past:

* new wrappers - there are new wrappers changing users of the API, the
  new names are more conforming, eg ZSTD_decompressDCtx -> zstd_decompress_dctx,
  sounds like an improvement to me

* high stack usage - mentioned in patch 3, slight increase but bounded
  and upstream now monitors that so it does not increase

Other points that are worth mentioning:

* bisectability - the version switch happens in one patch, so the
  effects before/after the patch are only runtime as there's no change
  in format etc, so ok

* will be maintained - no such huge update should happen again

So I suggest to merge in current form. I'm not sure what was the
original plan if it was supposed to go via Herbert's crypto tree, but
that was before Nick added himself as maintainer.

I think that Nick can send the pull request to Linus, perhaps with acks
to all changes that are in the non-zstd code (patch 1).

Cover letter v11: https://lore.kernel.org/linux-btrfs/20210430013157.747152-1-nickrterrell@gmail.com/


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
