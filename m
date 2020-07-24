Return-Path: <SRS0=sdIt=BD=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC699C4345B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:45:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8531A2065E;
	Fri, 24 Jul 2020 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="frpzwCi9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="T6/uJcT5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fVXrG86h";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="Qg0up90J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8531A2065E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pJePQ9ZqVGQr7CmWWuoAnZQYff1ck5LgJr0VAiPuxB8=; b=frpzwCi9s1MH4dnIk4YHDCbUBN
	zbt6Zx32YG+TV0DQb2lyAsdj4kyvL8Y14ZwmY8GnB/49rtASRRBI0Edlwx8s+nJDWNg50fvtYGJzQ
	nJzjCZiVdd7YZyfi3NSS29wQuMJL7bd1tn9WTN7pGt3aeA+zxasmWQXfhGHTURQ0ufl0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jz2h8-0007kM-88; Fri, 24 Jul 2020 18:45:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3MiwbXwYKAPUpXqvXqdlldib.Zlj@flex--satyat.bounces.google.com>)
 id 1jz2h6-0007k1-Gp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 18:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lsSlCMXcrL561eOWGmFFIuL3TkBKEtn1RBBptVeIF5U=; b=T6/uJcT5W6uF85WUIc0JwZ1O0p
 RpAYqNRGORe9DJL2ogLOrI3sqhSm/2RCRVkNN6gT9ZFJNWD4deYdr/l39AAOmNKPUfENR2XzdiaSR
 5+r/W5Y23LVOBPYGGB4xDmssiSD5tjLXmxkqOWdA2KZjqTyPkcEyIfDseWDqxrsFleQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lsSlCMXcrL561eOWGmFFIuL3TkBKEtn1RBBptVeIF5U=; b=f
 VXrG86hN94Zm+0cZwcaR6rIrZqTqrK7sFmKDMarKsJHuP+TVRjlpHRVzN0ZYdYlefa2eZQT90FI2M
 ciozH67dc55Uc4Jd4G8xvRs9TGvg9WIf67aD3ih4gvNODNn/VdJMValRW0DY59Grg51R5ah1myr7m
 Lc3/iyIh61Agfd3I=;
Received: from mail-pf1-f202.google.com ([209.85.210.202])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jz2h5-007qiZ-1H
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 18:45:20 +0000
Received: by mail-pf1-f202.google.com with SMTP id y73so6927028pfb.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2020 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=lsSlCMXcrL561eOWGmFFIuL3TkBKEtn1RBBptVeIF5U=;
 b=Qg0up90J4SnyNR+ZP3m8Qvg7/DArL5ftn8TN8LfRiwq168u1P5eKlX77F5+Cf8umeo
 x8NQkxIEgNQAiroGdaws5+VVMVyLph4zgaNnQhL6kv1AFTlBMi21N3/gNQWtSC4t6wka
 XeDdlpKADSg2TLkM2w1VN66GgDqgab1oYrOk8ecyhdNovpeF0bdOQGMjsIETLwCEwXsj
 BdVNJpNiBmbiPCBsEoEu510sgysnga5/Ri/ss20QWq5Lcs3fZGGuFYvfidXQ+2tCE7Gg
 0FIvf5Efxgc/blFLi0/a0k0n0xPH9QYiNH39/nAD38DlF43ICn5uHyQ5gAJKLyb5v2g1
 5PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=lsSlCMXcrL561eOWGmFFIuL3TkBKEtn1RBBptVeIF5U=;
 b=ZHP7CVdOZA+sWeC5spXVhFHQVW2pHorV3Ercxhq1KIpeIVZLVsSqFcrAdtFJP0rIFZ
 wCBNoBPaDDAQSd/f/2ODR6+NX3/Jx2V4B2YiO2psdnoeK23AR2+VC1uLeqiAMVJwdGZV
 2rmdYL6gyiozi8HSTY2sgNHakEy0/LZ8kYzuN77xMslXrj7YKpVi110+66yGmyKy3eB9
 Aj5dGNq2KxmoKjIvRVcKXnR39YnYDLpXz76OFH9GOWnrsPDWM+Elaiq0zyoCaPsQoGEd
 yx9ftaZWQQwGP514c+GHx7GKQpBiPZimZd1onW71Ldolb1TfcpKIS6B/9ju9yDU4G9vJ
 Qlyg==
X-Gm-Message-State: AOAM532FJA0YmOywTS/HvAcCgem9ockgW4nToiIxmVo8P0xbZnQhWwd+
 C+cyR0v3+ERtbDXtk4R9ALoPnkZl2lk=
X-Google-Smtp-Source: ABdhPJyGXJ1seF6nCvIFHEXKfsy1coxsncYfx+wOXBYkTBimaK5lPWApmoEQlte7Ys/66ppi4YAUPIe/CbY=
X-Received: by 2002:a17:90a:5208:: with SMTP id
 v8mr7061294pjh.29.1595616306258; 
 Fri, 24 Jul 2020 11:45:06 -0700 (PDT)
Date: Fri, 24 Jul 2020 18:44:54 +0000
Message-Id: <20200724184501.1651378-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jz2h5-007qiZ-1H
Subject: [f2fs-dev] [PATCH v6 0/7] add support for direct I/O with fscrypt
 using blk-crypto
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
From: Satya Tangirala via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Satya Tangirala <satyat@google.com>
Cc: linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch series adds support for direct I/O with fscrypt using
blk-crypto. It has been rebased on fscrypt/master (i.e. the "master"
branch of the fscrypt tree at
https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git)

Patch 1 adds two functions to fscrypt that need to be called to determine
if direct I/O is supported for a request.

Patches 2 and 3 modify direct-io and iomap respectively to set bio crypt
contexts on bios when appropriate by calling into fscrypt.

Patches 4 and 5 allow ext4 and f2fs direct I/O to support fscrypt without
falling back to buffered I/O.

Patches 6 and 7 update the fscrypt documentation for inline encryption
support and direct I/O. The documentation now notes the required conditions
for inline encryption and direct I/O on encrypted files.

This patch series was tested by running xfstests with test_dummy_encryption
with and without the 'inlinecrypt' mount option, and there were no
meaningful regressions. One regression was for generic/587 on ext4,
but that test isn't compatible with test_dummy_encryption in the first
place, and the test "incorrectly" passes without the 'inlinecrypt' mount
option - a patch will be sent out to exclude that test when
test_dummy_encryption is turned on with ext4 (like the other quota related
tests that use user visible quota files). The other regression was for
generic/252 on ext4, which does direct I/O with a buffer aligned to the
block device's blocksize, but not necessarily aligned to the filesystem's
block size, which direct I/O with fscrypt requires.

Changes v5 => v6:
 - fix bug with fscrypt_limit_io_blocks() and make it ready for 64 bit
   block numbers.
 - remove Reviewed-by for Patch 1 due to significant changes from when
   the Reviewed-by was given.

Changes v4 => v5:
 - replace fscrypt_limit_io_pages() with fscrypt_limit_io_block(), which
   is now called by individual filesystems (currently only ext4) instead
   of the iomap code. This new function serves the same end purpose as
   the one it replaces (ensuring that DUNs within a bio are contiguous)
   but operates purely with blocks instead of with pages.
 - make iomap_dio_zero() set bio_crypt_ctx's again, instead of just a
   WARN_ON() since some folks prefer that instead.
 - add Reviewed-by's

Changes v3 => v4:
 - Fix bug in iomap_dio_bio_actor() where fscrypt_limit_io_pages() was
   being called too early (thanks Eric!)
 - Improve comments and fix formatting in documentation
 - iomap_dio_zero() is only called to zero out partial blocks, but
   direct I/O is only supported on encrypted files when I/O is
   blocksize aligned, so it doesn't need to set encryption contexts on
   bios. Replace setting the encryption context with a WARN_ON(). (Eric)

Changes v2 => v3:
 - add changelog to coverletter

Changes v1 => v2:
 - Fix bug in f2fs caused by replacing f2fs_post_read_required() with
   !fscrypt_dio_supported() since the latter doesn't check for
   compressed inodes unlike the former.
 - Add patches 6 and 7 for fscrypt documentation
 - cleanups and comments

Eric Biggers (5):
  fscrypt: Add functions for direct I/O support
  direct-io: add support for fscrypt using blk-crypto
  iomap: support direct I/O with fscrypt using blk-crypto
  ext4: support direct I/O with fscrypt using blk-crypto
  f2fs: support direct I/O with fscrypt using blk-crypto

Satya Tangirala (2):
  fscrypt: document inline encryption support
  fscrypt: update documentation for direct I/O support

 Documentation/filesystems/fscrypt.rst | 36 +++++++++++--
 fs/crypto/crypto.c                    |  8 +++
 fs/crypto/inline_crypt.c              | 74 +++++++++++++++++++++++++++
 fs/direct-io.c                        | 15 +++++-
 fs/ext4/file.c                        | 10 ++--
 fs/ext4/inode.c                       |  7 +++
 fs/f2fs/f2fs.h                        |  6 ++-
 fs/iomap/direct-io.c                  |  6 +++
 include/linux/fscrypt.h               | 18 +++++++
 9 files changed, 171 insertions(+), 9 deletions(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
