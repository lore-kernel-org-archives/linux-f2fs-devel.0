Return-Path: <SRS0=fy8N=XZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88506C32792
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Sep 2019 21:19:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57621215EA;
	Mon, 30 Sep 2019 21:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="P44qSY1P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="IJeDhlfk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH/Djm4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57621215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iF353-0007BP-0u; Mon, 30 Sep 2019 21:19:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iF351-0007BD-Ll
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Sep 2019 21:19:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lIUlcQg88IaRQ5e6BDbfySuR6sxnhbydasx3qgxlRkw=; b=P44qSY1PYyJIgbP6aMmjLojaKl
 43yZX56P9HAdWRdbQtStdrFnKE0N9YHMqsgRG9e7AthEZuuI70nidSo7Dv90Luc1k4+S/z04Of78a
 jsEM5LzySSi8YDRaLtL/ayjUaGIrUi8D1QTE2YZxG43Ex2GcjBRsK0fyZaiIRqxY9EqY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lIUlcQg88IaRQ5e6BDbfySuR6sxnhbydasx3qgxlRkw=; b=I
 JeDhlfkSBfbSNEc3AkHsOPLtiAFqGJ+kqvbJDUlM5bKtkGY4h7wrIqYsCNg29WZayOMq9v0kpmSRx
 NUAOHDh8x7yhxjs2JMjS3Iq/TMSv5ff1eXflMsedyqXePsT8AmcBPJl94pBtWq/yQ3LDbZGv7MAri
 JZFRJy34ohVf41P0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iF34x-00Bx6Z-UO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Sep 2019 21:19:39 +0000
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3CFBE20815;
 Mon, 30 Sep 2019 21:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569878365;
 bh=N/TprzOxAigJeHUbeoC5sDTujOY4691iZuzSOaznIiw=;
 h=From:To:Cc:Subject:Date:From;
 b=FH/Djm4rvJWYoH6uP0N9cFbRyM+jNW3pnMk1UsAYtjcACtNUatLKdYteYTd94JsBG
 zGFffIWJNCTH7QDzhdA9QqUFNXiBBc3F36+VjrrWXfXJCZ7NIA8S8tTuCDegg7CE+j
 C6W3VOtK1fmBFUQpm3C+eu4K9QW8ZnJPcRd55tjI=
From: Eric Biggers <ebiggers@kernel.org>
To: fstests@vger.kernel.org
Date: Mon, 30 Sep 2019 14:15:45 -0700
Message-Id: <20190930211553.64208-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
X-Headers-End: 1iF34x-00Bx6Z-UO
Subject: [f2fs-dev] [PATCH v4 0/8] xfstests: add fs-verity tests
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add tests for fs-verity.  fs-verity is an ext4 and f2fs filesystem
feature which provides Merkle tree based hashing (similar to dm-verity)
for individual read-only files, mainly for the purpose of efficient
authenticity verification.  Other filesystems may add fs-verity support
later, using the same API.

Running these tests requires:

- Kernel v5.4-rc1 or later configured with CONFIG_FS_VERITY=y,
  and optionally CONFIG_FS_ENCRYPTION=y (for generic/904),
  CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y (for generic/905), and
  CONFIG_CRYPTO_SHA512=y (for generic/903 to cover SHA-512).

- The 'fsverity' utility program from
  https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git

- e2fsprogs v1.45.2 or later for ext4 tests, or f2fs-tools v1.11.0 or
  later for f2fs tests

- generic/905 also requires the 'openssl' program.

Example with kvm-xfstests:

    $ kvm-xfstests -c ext4,f2fs -g verity

For more information about fs-verity, see
https://www.kernel.org/doc/html/latest/filesystems/fsverity.html

This patchset can also be retrieved from tag "fsverity_2019-09-30" of
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git

Note: my other pending xfstests patchset
"xfstests: add tests for fscrypt key management improvements"
renames the function _generate_encryption_key(), which is used by
generic/904 in this patchset.  This will need to be fixed up when the
second of these two patchsets is merged.

Changed since v3:

  - Update generic/900 to also test executing FS_IOC_ENABLE_VERITY while
    another process is already executing it on the same file.

Changed since v2:

  - Updated the signature verification test (generic/905) to match the
    latest kernel and fsverity-utils changes.

  - Added _fsv_sign() utility function.

  - Correctly skip the fs-verity tests on ext3-style filesystems.

Changed since v1:

  - Updated all tests to use the new fs-verity kernel API.

  - Many cleanups, additional checks in the tests, and other improvements.

  - Addressed review comments from Eryu Guan.

  - Added a test for the built-in signature verification feature.

  - Removed the fs-verity descriptor validation test, since the on-disk
    format of this part was greatly simplified and made fs-specific.

Eric Biggers (8):
  common/filter: add _filter_xfs_io_fiemap()
  common/verity: add common functions for testing fs-verity
  generic: test general behavior of verity files
  generic: test access controls on the fs-verity ioctls
  generic: test corrupting verity files
  generic: test that fs-verity is using the correct measurement values
  generic: test using fs-verity and fscrypt simultaneously
  generic: test the fs-verity built-in signature verification support

 common/config         |   2 +
 common/filter         |  24 +++++
 common/verity         | 215 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/900     | 199 ++++++++++++++++++++++++++++++++++++++
 tests/generic/900.out |  74 +++++++++++++++
 tests/generic/901     |  73 ++++++++++++++
 tests/generic/901.out |  14 +++
 tests/generic/902     | 154 ++++++++++++++++++++++++++++++
 tests/generic/902.out |  91 ++++++++++++++++++
 tests/generic/903     | 112 ++++++++++++++++++++++
 tests/generic/903.out |   5 +
 tests/generic/904     |  80 ++++++++++++++++
 tests/generic/904.out |  12 +++
 tests/generic/905     | 150 +++++++++++++++++++++++++++++
 tests/generic/905.out |  42 +++++++++
 tests/generic/group   |   6 ++
 16 files changed, 1253 insertions(+)
 create mode 100644 common/verity
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out
 create mode 100755 tests/generic/901
 create mode 100644 tests/generic/901.out
 create mode 100755 tests/generic/902
 create mode 100644 tests/generic/902.out
 create mode 100755 tests/generic/903
 create mode 100644 tests/generic/903.out
 create mode 100755 tests/generic/904
 create mode 100644 tests/generic/904.out
 create mode 100755 tests/generic/905
 create mode 100644 tests/generic/905.out

-- 
2.23.0.444.g18eeb5a265-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
