Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F9606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NMby8+QE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FsqDGR4k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dC5cF73o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=T8jrnQ1M5SqHg/U5zD+/tm108Sjw2JHNAANDxPVUcOA=; b=NMby8+QELbfh5kKMTwSj3UQ8kp
	jGxqNmUP4xz3zSO/HQUnsNBtxgKHOJSSwMLy7GCOfcH4OPmSqBBUH21OrBMogpN0h+Tuex1oKVnfO
	epmvyT8gMaWcGKd5B5xhqjaDJVkCIVVP7m5leUaS3j3yUoCcYd2/xx84WlUwba8X+LB4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVQOo-000000007Ue-3PwQ;
	Mon, 23 Nov 2026 09:31:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <hch@lst.de>) id 1xVQOn-000000007UT-3vnX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:31:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qTfZwRq4CVPyDhqahNCbHKrfBgzSh0zQAJnCCnO1BqA=; b=FsqDGR4k2ApSeaw+MoiWSSt1vc
 lr4V2DD0iEqdwYXEu0Gz6BWGUZMA3XSqOR0yxhxuz9Wm3YVi7yDERdEqijO2TXQfWBYh9G4pJ3iii
 vd3CH2E43voxaFvYu9FycEM8rqlhSblzz7ZauDmhBn4Okw2azXw/BrEFjDvorwSufl/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qTfZwRq4CVPyDhqahNCbHKrfBgzSh0zQAJnCCnO1BqA=; b=dC5cF73osEpgAsXTEF9W4lZeKP
 7UpUmofNWR6bSe+yGJKOPNv/CYZzdRmWQPrLyixZQXKvbWhRLdj1itKCpEyTROOxu1W1/84ongzxX
 Jx4xqiLMj3P5o6IPiTsR+jPYdUyVUWWDa7ohYXQFZg6GNFFqMqleHOSv46AjmFAR43z4=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVQOm-000000002Pz-1zNl
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:31:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B75C368B05; Mon, 23 Nov 2026 10:31:34 +0100 (CET)
Date: Mon, 23 Nov 2026 10:31:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Message-ID: <20261123093134.GA23224@lst.de>
References: <20261122213120.20974-1-laveeshb@laveeshbansal.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261122213120.20974-1-laveeshb@laveeshbansal.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVQOm-000000002Pz-1zNl
Subject: Re: [f2fs-dev] [PATCH] blk-crypto: avoid fs reclaim under
 profile->lock in the fallback
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-crypto@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@lst.de>,
 syzbot+20d60aafd9a0d1f2a380@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 01:31:20PM -0800, Laveesh Bansal wrote:
> Setting a key in blk-crypto-fallback can deadlock on profile->lock.
> blk_crypto_get_keyslot() holds it across keyslot_program, whose setkey
> allocates with GFP_KERNEL (Adiantum); direct reclaim can evict an fscrypt
> inode, and blk_crypto_evict_key() then takes profile->lock again. syzbot
> reports it as an fs_reclaim vs profile->lock cycle. Since
> commit 5acc6f649a68 ("fscrypt: Always use blk-crypto for contents on
> block-based filesystems") hitting it no longer needs -o inlinecrypt.
> 
> Use memalloc_noio_save() around both setkey calls (keyslot_program and
> the blank-key clear in evict_keyslot), as blk_crypto_alloc_enc_bio()
> does.

Pleawe move these into blk_crypto_hw_enter/exit so that it is tied
to the lock for which you enforce the NOIO context instead of hacking
around the issue for specific allocations.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
