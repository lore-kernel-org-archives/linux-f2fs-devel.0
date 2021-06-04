Return-Path: <SRS0=ofO9=K6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5391CC4743C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Jun 2021 18:59:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229166140F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Jun 2021 18:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229166140F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lpF27-0007kJ-Q7; Fri, 04 Jun 2021 18:59:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <tytso@mit.edu>) id 1lpF26-0007k7-Cd
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 18:59:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sjfvetY1TUJxcPuN5wzsikwPuIV4i1xTgbZGrhOCjgQ=; b=ZSuXl0Des3oN9KnGMwnK7iyfic
 OIL8H6JhFW7vBgda2jIcxfdjHvGJCSuicZo9DVv+0FxmmNgal0azWu2ipEskUWXBOHQ0pdTIv5SRE
 mGE+RFKQxfpt48c+R1/0N20FGmlM/4QbpNBojtz1ewIf8LigSwwgjFQkMo0jsEJLnxvM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sjfvetY1TUJxcPuN5wzsikwPuIV4i1xTgbZGrhOCjgQ=; b=R89FIGHhdnlBUy/NcHXIJ2KaY4
 mzRM5Hiu7v4mkp4gGK36E2/ch2kCvqwZFVOoU/dBSL4gIbwD0Q9slep+mzQFGwEGj9Ym3unqh9W5A
 wlfejeBCIWGcS6I9NhAZl4GnOf/pMJ7FCAj2lQ7slkLqVhgRh8GQViw0gr5/J92lSMdo=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lpF24-00AjRB-LT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 18:59:03 +0000
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net
 [72.74.133.215]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 154Iwj1m006548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 4 Jun 2021 14:58:46 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id ADDD215C39C3; Fri,  4 Jun 2021 14:58:45 -0400 (EDT)
Date: Fri, 4 Jun 2021 14:58:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <YLp35XvlTuuZrcYf@mit.edu>
References: <20210603095038.314949-1-drosen@google.com>
 <20210603095038.314949-3-drosen@google.com>
 <YLlj+h4RiT6FvyK6@sol.localdomain> <YLmv5Ykb3QUzDOlL@google.com>
 <YLmzkzPZwBVYf5LO@sol.localdomain> <YLm8aOs6Sc/CLaAv@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLm8aOs6Sc/CLaAv@google.com>
X-Headers-End: 1lpF24-00AjRB-LT
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: Advertise encrypted casefolding
 in sysfs
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
Cc: Daniel Rosenberg <drosen@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 03, 2021 at 10:38:48PM -0700, Jaegeuk Kim wrote:
 > > Yes, but in the on-disk case, encrypted_casefold is redundant because it simply
> > means encrypt && casefold.  There is no encrypted_casefold flag on-disk.
> 
> I prefer to keep encrypted_casefold likewise kernel feature, which is more
> intuitive to users.

At least for ext4, there are kernel vesions which support encryption
and casefold *separetely*, but which do not support the file systems
that have encryption and casefold enabled simultaneously.  This is why
I had added /sys/fs/ext4/features/encrypted_casefold.  It was
originally not to indicate whether the on-disk file system supported
those features, but to indicate that the kernel in question supported
both features being enabled simultaneously.

					- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
