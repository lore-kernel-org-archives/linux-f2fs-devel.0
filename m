Return-Path: <SRS0=A69Z=MX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B49C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Jul 2021 01:06:10 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900DB6054E
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Jul 2021 01:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 900DB6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m9dS5-0003gw-GI; Sat, 31 Jul 2021 01:06:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1m9dS4-0003gq-Bc
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Jul 2021 01:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iCmhAePYBETjJz116aYLZynENQ56NgR4omKZLlkutNA=; b=YvXQ1YjH16Sh9PRKtV96fRaNLT
 uIMUFYEgmMcxNqqDoZsz63UQiFukOoKi2PH7QwH5NQCNjG2gY5cVaLWwM4Akul7DHrqlRJ6YZKHBy
 DPL9K7SIhktjNotnOXEdMzTK/jY2e63Kn+J8SLYDLhGkWHNzFWhj0xhHr7ip7QYRS5/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iCmhAePYBETjJz116aYLZynENQ56NgR4omKZLlkutNA=; b=cXbV4KPL6uuF8WOW3zh7BWNRr1
 3ZunRIlmkc/OF3uMfNAEZWZ2gHyOpojqq0/GFIvPS4HHxQtC7erVMDMY/a4KbdPWGR5pe8KxPStAB
 OmHHSMa3pmlR+zgkmx1UUFdFiNMx6Og9ZVeLuA+DppDxG8n1oefOVto01q5kY8P1TXQE=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m9dS2-008EIb-PL
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Jul 2021 01:06:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F09A60295;
 Sat, 31 Jul 2021 01:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627693561;
 bh=0X9jHrsOU43z9tGeEAL322dqf3ZHE2S9QVnPefF+wwQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Sq4e9/j5X+/BIhXxpzSyXp5xyn0BeBnB6H2XlTRHdd9V/KpxJdTNOmGoM0/bju81L
 1V2KXECo2ORvb/rTi+sZ451TX/DgY07wKNl4MsjSjKFrZaGc3iBF+oYHbJhfUPj7GN
 AfKLCoj5o4+0BKMS+AxOZSlXLO9pDJMWjm/yHdIjXBxQe9LRbQjyOz052C8T/xPADH
 gJRG2EDjNYR1eVR26DZwCRjlHTFP9zNTtUeuieTMgArAuXFbOCdp7G9zXEvAJjqwbq
 90CKIYIMq+N+jZHy4l1uEreJYNUJbQX6hWSnHFrRF5qil1jKyswPnFlqtMrz8ecMab
 cj3ZEqg4KbcMA==
Date: Fri, 30 Jul 2021 18:05:59 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YQSh95wKJB+ax1VC@google.com>
References: <20210728015154.171507-1-ebiggers@kernel.org>
 <YQRQRh1zUHSIzcC/@gmail.com> <YQR5P6aMxhOL+6os@google.com>
 <YQR69fzcv2vkgtfT@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YQR69fzcv2vkgtfT@gmail.com>
X-Headers-End: 1m9dS2-008EIb-PL
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
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/30, Eric Biggers wrote:
> On Fri, Jul 30, 2021 at 03:12:15PM -0700, Jaegeuk Kim wrote:
> > On 07/30, Eric Biggers wrote:
> > > On Tue, Jul 27, 2021 at 06:51:54PM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Currently, non-overwrite DIO writes are fundamentally unsafe on f2fs as
> > > > they require preallocating blocks, but f2fs doesn't support unwritten
> > > > blocks and therefore has to preallocate the blocks as regular blocks.
> > > > f2fs has no way to reliably roll back such preallocations, so as a
> > 
> > Hmm, I'm still wondering why this becomes a problem. And, do we really need
> > to roll back the preallocated blocks?
> > 
> > > > result, f2fs will leak uninitialized blocks to users if a DIO write
> > > > doesn't fully complete.  This can be easily reproduced by issuing a DIO
> > > > write that will fail due to misalignment, e.g.:
> > 
> > If there's any error, truncating blocks having NEW_ADDR could address this?
> > 
> 
> My understanding is that the "NEW_ADDR" block address in f2fs means that space
> was reserved for the block, but not allocated in any particular place yet.
> Buffered writes reserve blocks in this way, but DIO writes cannot because DIO by
> definition has to directly write to a specific on-disk location.  Therefore DIO
> writes require that the blocks be preallocated for real.

Sorry, checking back the DIO flow, we do allocate real block addresses if DIO
has holes.

f2fs_preallocate_blocks
 -> f2fs_map_blocks(F2FS_GET_BLOCK_PRE_DIO)
  -> __allocate_data_block()
   -> f2fs_allocate_data_block() gets a free LBA

Then, back to your concern, do we need to truncate blocks beyond i_size, if we
meet any failure?

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
