Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6452CC44515
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eVywo9MTJgCElGmUgnjfRzZSBFdtQnXrlnpsnWOy/Gw=; b=nKOQBnGnFz6Ic8kqr+qdee9q1f
	MOcrbnQ4d8jxqCvxJxqAjMqBqhE9UfF3PNPNhF2bHsMK6T6KrGzoYWLRzo41cFtE8UprVP1MgvRmy
	zhE1Px2WSa5/c+c2NY/butatUXyJjwpMyo7lFkHExhIv/9mbCQPz4WXGHwhuLO8KIiC0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wls1k-0003QB-LL;
	Mon, 20 Jul 2026 17:43:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wls1i-0003Q4-SE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 17:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gv/bAqWCLcsD/jMzuWjvkLnXVdOL0UvRkm+6ngUws4U=; b=YPwBVvEwS/1HxFIGlvrs8x5KFe
 IBz16Au/GpihscpP1C+N2Dri26rAlyf6vdKOIUyTx7BYhPbRrKYNqWT0lTm2ZOP7lTCSFd3pxTye7
 CkS0HGv7604O6h1GEUo0LwsP2MG9jo9HL6EjW4Ek72OZG77BZOYxCEqlQr8NzqGT4In4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gv/bAqWCLcsD/jMzuWjvkLnXVdOL0UvRkm+6ngUws4U=; b=XPg8EU565+f+8Giz6j+eVQHlGk
 37HyB3f9bEn0vRuhio0/obsHAKs6JVgDNOu8DgHZK0swnjDzJP99Coj9NrnZKZLPy35DKaH9cGsKG
 95PIIW3BhLw2GHepcOthucx22FmlYLZ1Vi7liNFoYqUO3XNWzNnjOWmFcFl36HjFkiAY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wls1f-0006h7-R2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 17:43:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FFC260052;
 Mon, 20 Jul 2026 17:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D3F1F00A3E;
 Mon, 20 Jul 2026 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784569404;
 bh=gv/bAqWCLcsD/jMzuWjvkLnXVdOL0UvRkm+6ngUws4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VKsLGqjr93FnM1O6Fx0Z1vNlnHsdf/BfXYf+9rGNcR5ZbyRgcmSNVyAwO3X7GJovI
 wqra/SVk6au46c0KCIThp5QagmDh/pXxReXmqtaJvsMQmkYOfjRKRxDiwkElGlhqeV
 yNiJ4xFw7ZFjc3e/9a8a10bfPLlMJ8h/bOMZIRomhczYQsidbevD/b22uHAISk9l2I
 bi+ILf4TmAL+pAxn4x2FIck3Ln0YCN4nl0sMuo/86RQDAXyyLw9GjDUfsI1kjJ+wkL
 zKfJGy/BXy5Ha9dZxy6VOmjzTEgDjF+558yT6skJzNrRM4Wxhft0ZjeWe5bpFI+2ms
 00v5eDbnj+gnA==
Date: Mon, 20 Jul 2026 10:43:23 -0700
To: linux-fscrypt@vger.kernel.org
Message-ID: <20260720174323.GA1865@quark>
References: <20260713023708.9245-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260713023708.9245-1-ebiggers@kernel.org>
X-Headers-End: 1wls1f-0006h7-R2
Subject: Re: [f2fs-dev] [PATCH v3 00/17] fscrypt: Standardize on blk-crypto
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jul 12, 2026 at 10:36:51PM -0400, Eric Biggers wrote:
> Eric Biggers (17):
>   blk-crypto: Simplify check for fallback support
>   blk-crypto: Fold __blk_crypto_cfg_supported() into its caller
>   blk-crypto: Allow control over whether hardware is used
>   fscrypt: Fully disallow IV_INO_LBLK_32 with s_blocksize != PAGE_SIZE
>   fscrypt: Always use blk-crypto for contents on block-based filesystems
>   Documentation: fscrypt: Update docs for inlinecrypt
>   ext4: Remove fs-layer file contents en/decryption code
>   ext4: Make ext4_bio_write_folio() return void
>   ext4: Further de-generalize the bio postprocessing code
>   f2fs: Remove fs-layer file contents en/decryption code
>   fs/buffer: Remove fs-layer decryption code
>   fscrypt: Replace calls to fscrypt_inode_uses_inline_crypto()
>   fscrypt: Remove fscrypt_dio_supported()
>   fscrypt: Remove fs-layer zeroout code
>   fscrypt: Remove unused functions and workqueue
>   fscrypt: Merge bio.c and inline_crypt.c into block.c
>   fscrypt: Add safety checks to non-block-based en/decryption

Applied to https://git.kernel.org/pub/scm/fs/fscrypt/linux.git/log/?h=for-next

But I'd still like acks on the ext4 and f2fs patches.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
