Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C41C6377D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:49:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601CE60720
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601CE60720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6a0V-0006B9-Ul; Thu, 22 Jul 2021 14:49:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1m6a0U-0006B3-JY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 14:49:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UeyLxburzQMOV0Rih22wKF11n2JrFgZV7R5XUj1S7Vg=; b=Tj/M/D3DYoayil5x7yu0GTGR6A
 ncjZ5kcMq/r+ZvIPyAI1xnryno5erjd7/NZjXVcICVNaVijKm/5EpFq86GIaFEjWkI9tFkKhQitJA
 8IMg28Bc758X8LITkeyQujdDuTlSJIcHPk76p8j/hkXrBdDnty/9qjjzjYT0JnlT/q2k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UeyLxburzQMOV0Rih22wKF11n2JrFgZV7R5XUj1S7Vg=; b=CZAttmrTyQ2lVvGmxHUi4VIOz5
 XyAWkk1sueMoiUozjiWd9wFfcTSIDHwaTIjCTJVMkNzleCIL/Dl1bLkiyZPHvoWUo/w8vIa6MkxE3
 K9zzJIKn5ne2gD6v4czRkbZRfDnCcw6mxVETdBbj82M0oFG8YTdnChkIOlPcfex0UuDg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6a0I-0004iz-RQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 14:49:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F21360FEE;
 Thu, 22 Jul 2021 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626965325;
 bh=kjIiN475TqYty0z7PIG+/pMDUBt+OSnFGGmVVgMKoNs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tc+SdqxggbbqbTwN0onZFGwh5ZmEywzzNR89LpVLby39UCAWx4h4yqlPURhVbOncf
 KO6YdbeB4zmYYs42oENDY/fKUz+QoAIV4OnlbOnGxvVvgR2wJ6x43sdIHiIF9dLVfG
 g7ILJbQio/iTJkibMqB7mJ0xtUe17Fva3M2NRpP5Tdgn73LqOJgshreiHi490eXmP0
 50PjB4kG+vNuP/UHXTJSqknemuwEn8dw7XKd8S10eR1NRH+Oqy1g0k9EMo+iZXzKea
 1TuenfuARM8NDdS38D33/4/2W8QGWzkHysasB3zq2IeE6c311F0/CwDQLQKIPRPh0w
 Khg5eR81VTn5Q==
Date: Thu, 22 Jul 2021 07:48:43 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Message-ID: <YPmFSw4JbWnIozSZ@gmail.com>
References: <20210604210908.2105870-1-satyat@google.com>
 <CAF2Aj3h-Gt3bOxH4wXB7aeQ3jVzR3TEqd3uLsh4T9Q=e6W6iqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF2Aj3h-Gt3bOxH4wXB7aeQ3jVzR3TEqd3uLsh4T9Q=e6W6iqQ@mail.gmail.com>
X-Headers-End: 1m6a0I-0004iz-RQ
Subject: Re: [f2fs-dev] [PATCH v9 0/9] add support for direct I/O with
 fscrypt using blk-crypto
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 open list <linux-kernel@vger.kernel.org>, Satya Tangirala <satyat@google.com>,
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Lee,

On Thu, Jul 22, 2021 at 12:23:47PM +0100, Lee Jones wrote:
> 
> No review after 7 weeks on the list.
> 
> Is there anything Satya can do to help expedite this please?
> 

This series is basically ready, but I can't apply it because it depends on the
other patch series
"[PATCH v4 0/9] ensure bios aren't split in middle of crypto data unit"
(https://lkml.kernel.org/linux-block/20210707052943.3960-1-satyaprateek2357@gmail.com/T/#u).
I will be re-reviewing that other patch series soon, but it primary needs review
by the people who work more regularly with the block layer, and it will have to
go in through the block tree (I can't apply it to the fscrypt tree).

The original version of this series didn't require so many block layer changes,
but it would have only allowed direct I/O with user buffer pointers aligned to
the filesystem block size, which was too controversial with other filesystem
developers; see the long discussion at
https://lkml.kernel.org/linux-fscrypt/20200720233739.824943-1-satyat@google.com/T/#u.

In addition, it was requested that we not add features to the "legacy" direct
I/O implementation (fs/direct-io.c), so I have a patch series in progress
"[PATCH 0/9] f2fs: use iomap for direct I/O"
(https://lkml.kernel.org/linux-f2fs-devel/20210716143919.44373-1-ebiggers@kernel.org/T/#u)
which will change f2fs to use iomap.

Also please understand that Satya has left Google, so any further work from him
on this is happening on a personal capacity in his free time.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
