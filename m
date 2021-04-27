Return-Path: <SRS0=jqEA=JY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6F0C433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Apr 2021 22:12:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E89661027;
	Tue, 27 Apr 2021 22:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E89661027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lbVvy-0001Gy-OO; Tue, 27 Apr 2021 22:11:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rdunlap@infradead.org>)
 id 1lbVvx-0001Gn-3g; Tue, 27 Apr 2021 22:11:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8S51hkxlGcSMjLm7YwZm1jMdNJla3qEcWOkEj52n5Mg=; b=U2awJr9R+s8gigIRxfKmirGA2P
 reHrSA4LHIJE/OrteCyHj9ReEnYXLkh7IyubvZdNahcpxciXJhogXZUDkk+U4q79bt2XdoW1rkfUr
 CNFy1lw0hNIHhGjcrUGHoYugX05oRE4iyyMxShTrRK1W5muPREeCch6f8KYZlQG38MUE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8S51hkxlGcSMjLm7YwZm1jMdNJla3qEcWOkEj52n5Mg=; b=kttWJQkaEBQzS9oGTBHXXTAmiH
 lyyWle1KOsGJazHtXubO7exZ1PPN1mLwGw/OsBmHmy55RhI2yPb1H6VPoLJK2brzDQrin288XTT4/
 ImOfvUAS0r2xWZMCjI7RnRJxWJ4kcTBfVuZm5LYaP4O+WIw/qiQA1X+uHpi+GrvrDTas=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lbVvn-001DkQ-G7; Tue, 27 Apr 2021 22:11:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=8S51hkxlGcSMjLm7YwZm1jMdNJla3qEcWOkEj52n5Mg=; b=TJ3lx1bhRLgSaWyeCUnhNQzcHi
 trKFahM2pKL7Twf30KHwsodJCQDar8WQxdynQbhOUI/zcj26Muje6vDEMC45KyxDkXHb4v9Oj7S3x
 /YNuiThGs0H8I5dcCEFLjD8SLCLh7+2dBbxEuGg7yqRdU3DwYVZ7EnqJ/E7MO5dMW0X+GoivUK1HV
 bF70x1WWyQDkLSOib+IbR+KCXi+I5gtqIyfAsn4pTgpKCEiwZNtLyExaQIs8PipmE85oG7Rafgt2g
 8hDWfAjT9W0z00dUDJQ0ne+g1yYp8AjDK39UZl2KiHMDxJd8Rh6Md7RgKkoA4MKJ8W6jRhFFGAov3
 H/fAyK3w==;
Received: from [2601:1c0:6280:3f0::df68]
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lbVuA-007Tyw-P8; Tue, 27 Apr 2021 22:10:13 +0000
To: Nick Terrell <nickrterrell@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20210426234621.870684-1-nickrterrell@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <10397ef2-119d-b065-2e82-cac1d800dfd0@infradead.org>
Date: Tue, 27 Apr 2021 15:09:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210426234621.870684-1-nickrterrell@gmail.com>
Content-Language: en-US
X-Headers-End: 1lbVvn-001DkQ-G7
Subject: Re: [f2fs-dev] [GIT PULL][PATCH v10 0/4] Update to zstd-1.4.10
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
Cc: squashfs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 Johannes Weiner <jweiner@fb.com>, Christoph Hellwig <hch@infradead.org>,
 Yann Collet <cyan@fb.com>, David Sterba <dsterba@suse.cz>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Petr Malat <oss@malat.biz>, Chris Mason <clm@fb.com>,
 Nick Terrell <terrelln@fb.com>, linux-crypto@vger.kernel.org,
 Felix Handte <felixh@fb.com>, Oleksandr Natalenko <oleksandr@natalenko.name>,
 Kernel Team <Kernel-team@fb.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Niket Agarwal <niketa@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/26/21 4:46 PM, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Please pull from
> 
>   git@github.com:terrelln/linux.git tags/v10-zstd-1.4.10
> 
> to get these changes. Alternatively the patchset is included.
> 
> This patchset lists me as the maintainer for zstd and upgrades the zstd library
> to the latest upstream release. The current zstd version in the kernel is a
> modified version of upstream zstd-1.3.1. At the time it was integrated, zstd
> wasn't ready to be used in the kernel as-is. But, it is now possible to use
> upstream zstd directly in the kernel.

Hi Nick,

Several of the source (.c, .h) files use comments blocks that
begin with "/**", which means "this is the beginning of a kernel-doc
comment" when in the kernel source tree. However, they are not in
kernel-doc format.

During the automatic generation from upstream zstd, please find a way
to change /** to /*.

This does need to slow down the acceptance of this patch series IMO.


thanks.
-- 
~Randy



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
