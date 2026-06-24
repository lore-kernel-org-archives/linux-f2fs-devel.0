Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E39CCDE003
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3l8vSN2GnaJvWZQxPi26xeKagvW7Jfu/QALR4zxiNmQ=; b=WBfZQCTQ4luMaMS0khYsEaPJ8q
	a28o6JjrMhSz7O/JAvxpX1DOD+c1b0ukO8h0WF/wV8bMqIdIuBr0/U5o8jFykb6hs/mBp4BBqgi70
	ubhhc6mbD/LBYnM+OAD3TMhZkLBautZzYPc6C6SkNEqp6iMHkW/1rt5xE+VM6kGAWY0E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcFoS-0006rO-Ks;
	Wed, 24 Jun 2026 05:06:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wcFoQ-0006rD-VD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5YUFiQzd3x6NdgG13Jlp3OxISfEg5s3ydgP/rBYymgE=; b=bnP9sHd6TtIGcy4XZSOHOS3iRF
 EIPKhI/LY2RU45IqiOqr6a175J/02+h+rpv0BpyInhDlIXFIjoM6k9qXrmZxOgCBWJcIaeGTRLIZ9
 QTHnmk5rVbeU/Q47ZPJvKghhEF9TugqQN6eXx3XdC/c+iiW9oQZx6aJYYEAZQFQyj8wo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5YUFiQzd3x6NdgG13Jlp3OxISfEg5s3ydgP/rBYymgE=; b=h
 Z7XhPP8da+bbYRc4MYgEJoGZY+mzZRMrCbx5gvqeQAskPgcexjm3udf/Z/12TGHQaJRtVh7IBdffq
 ujHX4Lmq51SXfUvEeoLd9Yplo2Ms7oqwFsaieL/yDlzj19GFKQuubeGT86IMbH9lqEEFJvCFxB7ec
 Gv4/XIiG0WZW4Xgo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcFoO-0004mO-Fd for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8861C400C4;
 Wed, 24 Jun 2026 05:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D671F000E9;
 Wed, 24 Jun 2026 05:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782277558;
 bh=5YUFiQzd3x6NdgG13Jlp3OxISfEg5s3ydgP/rBYymgE=;
 h=From:To:Cc:Subject:Date;
 b=NOuLezmi2eOEpFm/ujP3KKp7Mf/QYbSot3vazQzNUfFL4RdsoccRpH1Nc3YEL9sap
 8ifvgBWM0Wj0i2A8GvP1F/AlmhReHt7cWNBMUZEciigC+zE6dLFGJGVzDMxyPjyFba
 ioi8E31xFczqydIbYqsSPXVX+P20m01Zk5kB7EPZQPerF/25+qEUF4ChpZaX/nELmm
 nAxLs8w5kJx8iIz7wkFCOcjtRDc8o3d1nlqjtmG8rQogXn0A9+p/LGEKU+EbzdBzQM
 f865DBkEvtdQ2zLYpLICfem6GaarfyIsSjAIMyEGZr/TjWaCC52QIFTsu5BJpWpJRQ
 3KBYNue/QasHw==
To: linux-fscrypt@vger.kernel.org
Date: Tue, 23 Jun 2026 22:03:18 -0700
Message-ID: <20260624050334.124606-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Headers-End: 1wcFoO-0004mO-Fd
Subject: [f2fs-dev] [PATCH 00/16] fscrypt: Standardize on blk-crypto
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
 Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series can also be retrieved from:

    git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/ fscrypt-blk-crypto-v1

Currently, ext4 and f2fs (i.e., the block-based filesystems with fscrypt
support) have two file contents encryption implementations:

 - Filesystem-layer, where code in fs/crypto/ directly invokes
   crypto_skcipher to en/decrypt data using the CPU.  This
   implementation requires the management of bounce pages at the
   filesystem level.  It doesn't support direct I/O or large folios.

 - blk-crypto (also known as inline encryption), where the filesystem
   assigns bio_crypt_ctxs to bios, which are then processed either by
   the CPU using blk-crypto-fallback.c or by inline encryption hardware.
   This supports direct I/O and is compatible with large folios.

Currently, the latter implementation is enabled only when the
"inlinecrypt" mount option is given.

The persistence of the fs-layer implementation is mainly for historical
reasons, as it came first.  It's becoming increasingly hard to maintain,
especially as the filesystems get refactored to use iomap, large folios,
etc.  It's time to remove it and just rely on the similar code in
blk-crypto-fallback.  This series does that.

Some fs-layer encryption support remains in fs/crypto/ for non-block
based filesystems (UBIFS and CephFS), as well as directories and
symlinks.  So it's not entirely gone, but it's reduced.

To be clear, this just changes an internal implementation detail.  ext4
and f2fs continue to fully support encryption (fscrypt), regardless of
the presence of inline encryption hardware on the system.

Eric Biggers (16):
  blk-crypto: Simplify check for fallback support
  blk-crypto: Fold __blk_crypto_cfg_supported() into its caller
  blk-crypto: Allow control over whether hardware is used
  fscrypt: Fully disallow IV_INO_LBLK_32 with s_blocksize != PAGE_SIZE
  fscrypt: Always use blk-crypto for contents on block-based filesystems
  ext4: Remove fs-layer file contents en/decryption code
  ext4: Make ext4_bio_write_folio() return void
  ext4: Further de-generalize the bio postprocessing code
  f2fs: Remove fs-layer file contents en/decryption code
  fs/buffer: Remove fs-layer decryption code
  fscrypt: Replace calls to fscrypt_inode_uses_inline_crypto()
  fscrypt: Remove fscrypt_dio_supported()
  fscrypt: Remove fs-layer zeroout code
  fscrypt: Remove unused functions and workqueue
  fscrypt: Merge bio.c and inline_crypt.c into block.c
  fscrypt: Add safety checks to non-block-based en/decryption

 Documentation/filesystems/fscrypt.rst       |  39 ++-
 arch/loongarch/configs/loongson32_defconfig |   1 -
 arch/loongarch/configs/loongson64_defconfig |   1 -
 block/blk-crypto-fallback.c                 |   3 +-
 block/blk-crypto-profile.c                  |  22 --
 block/blk-crypto.c                          |  31 ++-
 drivers/md/dm-inlinecrypt.c                 |   2 +-
 fs/buffer.c                                 |  45 +---
 fs/crypto/Kconfig                           |   8 +-
 fs/crypto/Makefile                          |   3 +-
 fs/crypto/bio.c                             | 216 ---------------
 fs/crypto/{inline_crypt.c => block.c}       | 283 +++++++++-----------
 fs/crypto/crypto.c                          | 140 ++++------
 fs/crypto/fscrypt_private.h                 |  28 +-
 fs/crypto/keysetup.c                        |  31 +--
 fs/crypto/policy.c                          |  17 ++
 fs/ext4/crypto.c                            |   2 +-
 fs/ext4/ext4.h                              |   6 +-
 fs/ext4/inode.c                             |  64 +----
 fs/ext4/page-io.c                           |  74 +----
 fs/ext4/readpage.c                          | 140 +++-------
 fs/ext4/super.c                             |   6 +-
 fs/f2fs/compress.c                          |  28 +-
 fs/f2fs/data.c                              |  93 +------
 fs/f2fs/f2fs.h                              |   2 -
 fs/f2fs/file.c                              |   2 -
 fs/f2fs/segment.c                           |   2 -
 fs/f2fs/super.c                             |   2 +-
 include/linux/blk-crypto.h                  |   6 +-
 include/linux/fscrypt.h                     |  96 ++-----
 30 files changed, 357 insertions(+), 1036 deletions(-)
 delete mode 100644 fs/crypto/bio.c
 rename fs/crypto/{inline_crypt.c => block.c} (61%)


base-commit: 1dc18801be29bc54709aa355b8acd80e183b03cd
prerequisite-patch-id: 319d2891e88c7df1ebb5ebf434d18b68f770399f
prerequisite-patch-id: f6157c86deab0ff5ec953ae3ed6b0e84f37741bf
prerequisite-patch-id: 5330c9e4b65644baae81bd177a46be6223d2b494
prerequisite-patch-id: 073cb85332cc58e4b5066bf8f7ac948c0d9a2bac
prerequisite-patch-id: 4b1b7521df7ce7157156dbbc373c699060b21e3f
prerequisite-patch-id: edfd2a34a97697517828f233e478e5b7f8cf85c2
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
