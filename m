Return-Path: <SRS0=/Zjq=Y5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0D9CA9ED3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Nov 2019 03:12:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1762E206B8;
	Tue,  5 Nov 2019 03:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="m4pWxs4P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mEDm8khI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri2wHRty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1762E206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iRpGk-0005qE-3r; Tue, 05 Nov 2019 03:12:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iRpGi-0005q7-HF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Nov 2019 03:12:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JvpuGunfmRfXer1yXnTgzVjyVHjMvrWz8erj4ChztB0=; b=m4pWxs4PkDOEHkjM/NzB+JvcrC
 VtU4uH+URDAAoQYXV/Sm0Kg/vXDIAsLw5KHNgJo9cNQ3okYisfEr4DeEt9aES3mGDI0g2j+EvK1l8
 tzNAjtqNXtNOoePrqLYGhCTb1yDvqtZHTOixs+f5xYNClcpwWA7gXYsnEZOc570OGi4U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JvpuGunfmRfXer1yXnTgzVjyVHjMvrWz8erj4ChztB0=; b=mEDm8khICCf1wIofJHBKsbbmAx
 2vTouNjur4ndFaOK7K0tYvtzdUhbvoLvspdFZGdUKPdB3ll0df7GD51hNt443C9qJ/4/YJUGBgib1
 ENouzbDIm2TmsasSSRTRaUY7FMXhVJfvbEc+HqzK+KsfdY7To3GOZP1ijvr+o0nHNAb0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iRpGh-000M39-5d
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Nov 2019 03:12:32 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 55C0D206B8;
 Tue,  5 Nov 2019 03:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572923544;
 bh=hCqiCSjlrDhL5SGAV3AMEdP6Wu47sW0wJnkXEfvsLDA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ri2wHRty9kxlKC9gQp5N8RoTQPWUoA55ALYg1PirNxKLDJn3ZgT/m/zKOqgfEIUqm
 Ua2KFn6GvKBaanq+gHvxNHv86uoy/TSVumd9fbUnuZNJrrygfaLQn9RVQTUVh3s+Tu
 TNbhm3BZI6egc58lOzR1Oc8dCl+b9DOCQFLY3J+w=
Date: Mon, 4 Nov 2019 19:12:22 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20191105031222.GE692@sol.localdomain>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
 Satya Tangirala <satyat@google.com>, linux-scsi@vger.kernel.org,
 Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-8-satyat@google.com>
 <20191031183217.GF23601@infradead.org>
 <20191031202125.GA111219@gmail.com>
 <20191031212103.GA6244@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191031212103.GA6244@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Headers-End: 1iRpGh-000M39-5d
Subject: Re: [f2fs-dev] [PATCH v5 7/9] fscrypt: add inline encryption support
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Oct 31, 2019 at 02:21:03PM -0700, Christoph Hellwig wrote:
> > > 
> > > Btw, I'm not happy about the 8-byte IV assumptions everywhere here.
> > > That really should be a parameter, not hardcoded.
> > 
> > To be clear, the 8-byte IV assumption doesn't really come from fs/crypto/, but
> > rather in what the blk-crypto API provides.  If blk-crypto were to provide
> > longer IV support, fs/crypto/ would pretty easily be able to make use of it.
> 
> That's what I meant - we hardcode the value in fscrypt.  Instead we need
> to expose the size from blk-crypt and check for it.
> 
> > 
> > (And if IVs >= 24 bytes were supported and we added AES-128-CBC-ESSIV and
> > Adiantum support to blk-crypto.c, then inline encryption would be able to do
> > everything that the existing filesystem-layer contents encryption can do.)
> > 
> > Do you have anything in mind for how to make the API support longer IVs in a
> > clean way?  Are you thinking of something like:
> > 
> > 	#define BLK_CRYPTO_MAX_DUN_SIZE	24
> > 
> > 	u8 dun[BLK_CRYPTO_MAX_DUN_SIZE];
> > 	int dun_size;
> > 
> > We do have to perform arithmetic operations on it, so a byte array would make it
> > ugly and slower, but it should be possible...
> 
> Well, we could make it an array of u64s, which means we can do all the
> useful arithmetics on components on one of them.  But I see the point,
> this adds significant complexity for no real short term gain, and we
> should probably postponed it until needed.  Maybe just document the
> assumptions a little better.

Just in case it's not obvious to anyone, I should also mention that being
limited to specifying a 64-bit DUN doesn't prevent hardware that accepts a
longer IV (e.g. 128 bits) from being used.  It would just be a matter of
zero-padding the IV in the driver rather than in hardware.

The actual limitation we're talking about here is in the range of IVs that can
be specified.  A 64-bit DUN only allows the first 64 bits of the IV to be
nonzero.  That works for fscrypt in all cases except DIRECT_KEY policies, and it
would work for dm-crypt using the usual dm-crypt IV generator (plain64).

But for inline encryption to be compatible with DIRECT_KEY fscrypt policies or
with certain other dm-crypt IV generators, we'd need the ability to specify more
IV bits.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
