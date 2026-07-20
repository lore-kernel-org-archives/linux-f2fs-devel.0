Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CEAC44520
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XEcgkr2T6xyXCZh7XbO/9xHdzlwb/IVkx9KswNamufI=; b=kn7aD7R7ZBfPjS/TgDVQ1mNSJl
	zrIGIYzrMP4JcufLpvuVyum8B+pYzeFai8NRBepLdpcBgZ1dFBvchUBsKY5DidZwQJqqRosC1kv7a
	gvsGKq4xPi4gfXI/JgXQOMHoW96XTOjUlzzBtgoFRPE77x+j3Z87QR3qDjWuUqbY1w00=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wls46-0006Gt-5p;
	Mon, 20 Jul 2026 17:46:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wls45-0006Gm-LK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 17:46:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Z7qNrG0KSkprPREAOZB1jiU9uYS06edPPc9UNtP1bw=; b=U5Bx2MfdkOIC3RRS3BNfXYTVXS
 nnGx18wdIADRCYGRbKZqeZ1DQ29R4Raj+u9soS5uEvh7EK3Bej3CyIRmQq72MkBybpFKLAAjg/Pm4
 MXq6yelhxaLsSnhlA9ihM98mDLWCyWl79MXdbz5J4ZLNnEBR+F/zJp/a7v5TLjKqTIDM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8Z7qNrG0KSkprPREAOZB1jiU9uYS06edPPc9UNtP1bw=; b=FsCg2FDYIZzRm2StjgoAoZbR4t
 XoF1CprJVmGC7lv3AnF6gZeohLFy6TKImiIumu/nldV57od8RJTjIJO23gFBfO8i747HTnspzD2dO
 NYPhicDULdO80czDXSYaOBukko9m59bcGqWu08tBXnKk7Jgjhz6/JX6KszjeJ8ksgbBw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wls45-0006pG-4n for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 17:46:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BABF2436FD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 17:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4821F00A3A;
 Mon, 20 Jul 2026 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784569559;
 bh=8Z7qNrG0KSkprPREAOZB1jiU9uYS06edPPc9UNtP1bw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MABqk60cV6yATXr0Ti5BqMdlfI2ZlHwHV8ww+qU5UTdaM3faehGsMI10u1H+aO9ed
 iVcfF/HvjX/dWF8Tyanrx11HNohPv/pSVMFov9mSsAf8fkGi4ef6MhiSfBcyoDxlSh
 KHOLJSiMtCm2XsZrNAQqbqAnSvvijK/C3VhPIuP18b+JW9Vbrd3HBMmCr8Mkf+bjG0
 sXVAJkWzcKr80G4vtj/d+qgI03U9UgAxh28fQ3icc+P2YOblN7STRFfZVAHG5CJKrz
 QA6eSkvBC34g0CZoblNS7ep2Nx6DEv3ZFLIuQ5lXaPsWO0mbe2xuU8GqAHioynWOVO
 uNA2HhR0IJvhQ==
Date: Mon, 20 Jul 2026 10:45:58 -0700
To: linux-fscrypt@vger.kernel.org
Message-ID: <20260720174558.GC1865@quark>
References: <20260719055602.78828-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260719055602.78828-1-ebiggers@kernel.org>
X-Headers-End: 1wls45-0006pG-4n
Subject: Re: [f2fs-dev] [PATCH] fscrypt: Avoid dynamic allocation in
 fscrypt_get_devices()
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jul 18, 2026 at 10:56:02PM -0700, Eric Biggers wrote:
> When a blk_crypto_key starts being used or is evicted, fs/crypto/ calls
> fscrypt_get_devices() to get the filesystem's list of block devices,
> then iterates over them and calls blk_crypto_config_supported(),
> blk_crypto_start_using_key(), or blk_crypto_evict_key() on each one.
> 
> Currently, the block device pointers are placed in a dynamically
> allocated array.  This dynamic allocation is problematic because:
> 
> - It can fail, especially at the fscrypt_destroy_inline_crypt_key() call
>   site when it's invoked for inode eviction under direct reclaim.
> 
> - fscrypt_destroy_inline_crypt_key() doesn't handle the failure.  It
>   just zeroizes and frees the blk_crypto_key without calling
>   blk_crypto_evict_key().  That causes a use-after-free.
> 
> For now, let's fix this in the straightforward and easily-backportable
> way by switching to an on-stack array.  Currently the fscrypt
> multi-device functionality is used only by f2fs, which has a hardcoded
> limit of 8 block devices.  An on-stack array works fine for that.
> 
> (Of course, this solution won't scale up to large number of block
> devices.  For that we'd need a different solution, like moving the block
> device iteration into the filesystem.  Or in the case of btrfs, which
> will only support blk-crypto-fallback, we should make it just call
> blk-crypto-fallback directly, so the block devices won't be needed.)
> 
> Fixes: 22e9947a4b2b ("fscrypt: stop holding extra request_queue references")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Applied to https://git.kernel.org/pub/scm/fs/fscrypt/linux.git/log/?h=for-current

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
