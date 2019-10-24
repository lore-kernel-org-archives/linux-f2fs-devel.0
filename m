Return-Path: <SRS0=euTy=YR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55596CA9EAF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:57:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253A920578;
	Thu, 24 Oct 2019 21:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Ft3BTKzS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dcXRyBKX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYsduxAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253A920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iNl6l-0003TH-Po; Thu, 24 Oct 2019 21:57:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iNl6i-0003T9-LZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Oct 2019 21:57:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cGsasWdzPRXrVop5PQEHsG0xb15gbX34dr6VNhAf/4I=; b=Ft3BTKzSv0uwD9CnK8nQ2Ql+/W
 gfLR2URz+w+5NhLnGtVtUQaph6AIgpTkQOAtARO7OPKIivPMYC/t2N2aCSSYlISRh6vgwR5bNxet9
 THtcea+bjWJH9A6grPo5v10qh55BC4tvh3K9o76avrbFyyQVWbUCzf2rP2qRIsM0wUN8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cGsasWdzPRXrVop5PQEHsG0xb15gbX34dr6VNhAf/4I=; b=d
 cXRyBKXxv7DLeTwocT1aIzuA8opAikuNuICut+BjgxPPJ9Xj6hMTvlAh2xJlNH/AZe6eh/ORfjuX8
 61OdHXFgks+5R7fQlc3VETscTuKfJ3u30omWv5TjcOpk/ond6ONGESiutV69sX7I6lm2o/HKvMqyI
 usly0rspbIH6FBkA=;
Received: from [198.145.29.99] (helo=mail.kernel.org)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iNl6h-002UUy-4O
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Oct 2019 21:57:24 +0000
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4995620578;
 Thu, 24 Oct 2019 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571954227;
 bh=HDbyy92ncxjP1dI6FxrpY5/nE4vCNb78sIDmKUaw/oA=;
 h=From:To:Cc:Subject:Date:From;
 b=tYsduxACwWAZcKMN50EsIXij5SWgunEH/IZT5C2so19z1/o5XTkDSDkgsUcfYdjGT
 cYMAHDf8Q8CG1ftEildMrnVdoOBdnctFicyjkPr72LbPTbeOJgZh0wEtry6JZY/j+I
 kCMv9S3xpWh1jvarxrgWjGDKupV8ex7ClSaq4Hg0=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Thu, 24 Oct 2019 14:54:35 -0700
Message-Id: <20191024215438.138489-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
X-Headers-End: 1iNl6h-002UUy-4O
Subject: [f2fs-dev] [PATCH v2 0/3] fscrypt: support for IV_INO_LBLK_64
 policies
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
Cc: linux-f2fs-devel@lists.sourceforge.net, "Theodore Y . Ts'o" <tytso@mit.edu>,
 Satya Tangirala <satyat@google.com>, Paul Lawrence <paullawrence@google.com>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

In preparation for adding inline encryption support to fscrypt, this
patchset adds a new fscrypt policy flag which modifies the encryption to
be optimized for inline encryption hardware compliant with the UFS v2.1
standard or the upcoming version of the eMMC standard.

This means using per-mode keys instead of per-file keys, and in
compensation including the inode number in the IVs.  For ext4, this
precludes filesystem shrinking, so I've also added a compat feature
which will prevent the filesystem from being shrunk.

I've separated this from the full "Inline Encryption Support" patchset
(https://lkml.kernel.org/linux-fsdevel/20190821075714.65140-1-satyat@google.com/)
to avoid conflating an implementation (inline encryption) with a new
on-disk format (IV_INO_LBLK_64).  This patchset purely adds support for
IV_INO_LBLK_64 policies to fscrypt, but implements them using the
existing filesystem layer crypto.

We're planning to make the *implementation* (filesystem layer or inline
crypto) be controlled by a mount option '-o inlinecrypt'.

This patchset applies to fscrypt.git#master and can also be retrieved from
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=inline-crypt-optimized-v2

I've written a ciphertext verification test for this new type of policy:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/log/?h=inline-encryption

Work-in-progress patches for the inline encryption implementation of
both IV_INO_LBLK_64 and regular policies can be found at
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=inline-encryption-wip

Changes v1 => v2:

- Rename the flag from INLINE_CRYPT_OPTIMIZED to IV_INO_LBLK_64.

- Use the same key derivation and IV generation scheme for filenames
  encryption too.

- Improve the documentation and commit messages.

Eric Biggers (3):
  fscrypt: add support for IV_INO_LBLK_64 policies
  ext4: add support for IV_INO_LBLK_64 encryption policies
  f2fs: add support for IV_INO_LBLK_64 encryption policies

 Documentation/filesystems/fscrypt.rst | 63 +++++++++++++++++----------
 fs/crypto/crypto.c                    | 10 ++++-
 fs/crypto/fscrypt_private.h           | 16 +++++--
 fs/crypto/keyring.c                   |  6 ++-
 fs/crypto/keysetup.c                  | 45 ++++++++++++++-----
 fs/crypto/policy.c                    | 41 ++++++++++++++++-
 fs/ext4/ext4.h                        |  2 +
 fs/ext4/super.c                       | 14 ++++++
 fs/f2fs/super.c                       | 26 ++++++++---
 include/linux/fscrypt.h               |  3 ++
 include/uapi/linux/fscrypt.h          |  3 +-
 11 files changed, 182 insertions(+), 47 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
