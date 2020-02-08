Return-Path: <SRS0=x8RO=34=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4196C2BA83
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  8 Feb 2020 01:34:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E7320661
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  8 Feb 2020 01:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="OURaXFTb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UXvVUA0k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="IgAvGbS+";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="ZzptqxUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E7320661
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NBWIsAh/OBq1qDGaKRtusIWwkKtuMwsZTsbde98bKpQ=; b=OURaXFTb65PZx/BUKlH5ndLuhI
	T1ifILVhY/WcBPxb7WwPZko/e6gqyFViZxesvdJHvv23XgHT/8uM9hmfIGkGsPqUA5F+I5dVXsMJL
	wV1hZT9jryKbGV1d+9YJEWASgBY4mjjhL3elFRCmhDb5RPpo4XGNoEA5zgc8CgED2Uo8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j0F1M-0007q8-44; Sat, 08 Feb 2020 01:34:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3NBA-XgYKAEUkyvzlunvvnsl.jvt@flex--drosen.bounces.google.com>)
 id 1j0F1L-0007q1-9k
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Feb 2020 01:34:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GmdJt27134kNRYXiKp4wrB+O4TXMZQXM52BZBGOfEtM=; b=UXvVUA0kMy2ufLBNWWhaCYPbmU
 x2vR8fhplFgeP8aYCSU333p0yIrH29hdKe6mdj4QuiheU6JV/Wdx2tXLf6HpSKw4AxmXBELoWCcF6
 ZUs8mXkXB98troFpxjecKDeDmhLs6PlTYe5rP1iXVDmqu9Lu1k6zsUs03ZieX1hfFJbE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GmdJt27134kNRYXiKp4wrB+O4TXMZQXM52BZBGOfEtM=; b=I
 gAvGbS+3Rsq7ZvW3JnxLcY4aRq3kwgzQWOxGqWIJ02E4NhT1rZE4+qRFwmr4aO/WCGdSJXW7/UhkF
 89mgsKQ6rd9cR/ExDXgPydM6OeR8VykEbblP9nvy1albHXoc7VmpBU41Lr06eC2JQRg/vBAwNYukp
 WO45+vib7bs/doRE=;
Received: from mail-pj1-f74.google.com ([209.85.216.74])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1j0F1G-00DrGc-F5
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Feb 2020 01:34:55 +0000
Received: by mail-pj1-f74.google.com with SMTP id c67so2344602pje.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 07 Feb 2020 17:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=GmdJt27134kNRYXiKp4wrB+O4TXMZQXM52BZBGOfEtM=;
 b=ZzptqxUsermKYJMyiUDjvBiGxUIdwqTzJfy+wNJraQ/fqxPgGbS6BGRKrTpYZT99NP
 LQVDbxgl6rqVunRCW0ICPGiKpNThIj+TdvQ5TjjeSLkpDlJtuWqpEnxBlBrS2HEtG+RW
 9z2HN6g50wLJeFY9fmYqHHVVeKmyWOB0q7ii4xnMViegdwpFM70+FfqSZe7YAxDz9qPz
 rQI68XvesZcSELHJhYuD8Anx5KlcByOodivzB6VfODhyuo8qsoR7iOlqkI0zS2IW8J1A
 G74nrd0ARErEc3uP+liYKFfxifqkv4AUuLVaYmPTGE7ECQxADA+maD2kLEzIxEDZMkLy
 HKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=GmdJt27134kNRYXiKp4wrB+O4TXMZQXM52BZBGOfEtM=;
 b=B1iHFOR0M3iAEy9unOvgOhewLX7FZWX0vo5ELhf5WMz9P2yQSd4Yd79nya10MpcnRD
 UvkujSHI8RzE9/SorA3+vaOiziCv6Xb86hFMerbyZjMangvH/06cmcQfJVQp+kaSQieI
 KmDk716N3+hZ1enCFa8hnLm2oQtNJoPl0NJtFDnr8/IRuIeH256m+h8GQAbJMlvp7hu8
 wV/wpx2L1HSg382lZXhlmAXnYvQj2YTUbN6HSFMExhNLJVMJ0VZp5Ezi+OAZqdoAeGgY
 d7rQ4HrPnIKMeDUQEtQ9dYnTdso8Fcl+qvLzsqOROavGpHjfH3F18wIgl28wnjWvgubW
 655g==
X-Gm-Message-State: APjAAAXKVULv2UAdTl4qHnzZVtBD6WDfZLbKKO03CisjYNVfPYcc0r4C
 0rlMSmBPLQ5zZAXwJmtGbbODWijUJ3E=
X-Google-Smtp-Source: APXvYqxT2SICJR0/scVLMtmD7Drj2JGcZpB0cicjSWB5iCPIziOWFDKhaM/J3laVncF61b47rtO91OtcfaA=
X-Received: by 2002:a63:1c1d:: with SMTP id c29mr2121466pgc.14.1581125684457; 
 Fri, 07 Feb 2020 17:34:44 -0800 (PST)
Date: Fri,  7 Feb 2020 17:34:30 -0800
Message-Id: <20200208013438.240137-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
To: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>, 
 linux-fscrypt@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Richard Weinberger <richard@nod.at>
X-Headers-End: 1j0F1G-00DrGc-F5
Subject: [f2fs-dev] [PATCH v7 0/8] Support fof Casefolding and Encryption
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: Daniel Rosenberg <drosen@google.com>, linux-doc@vger.kernel.org,
 kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

These patches are all on top of torvalds/master

Ext4 and F2FS currently both support casefolding and encryption, but not at
the same time. These patches aim to rectify that.

I moved the identical casefolding dcache operations for ext4 and f2fs into
fs/libfs.c, as all filesystems using casefolded names will want them.

I've also adjust fscrypt to not set it's d_revalidate operation during it's
prepare lookup, instead having the calling filesystem set it up. This is
done to that the filesystem may have it's own dentry_operations. Also added
a helper function in libfs.c that will work for filesystems supporting both
casefolding and fscrypt.

For Ext4, since the hash for encrypted casefolded directory names cannot be
computed without the key, we need to store the hash on disk. We only do so
for encrypted and casefolded directories to avoid on disk format changes.
Previously encryption and casefolding could not be on the same filesystem,
and we're relaxing that requirement. F2fs is a bit more straightforward
since it already stores hashes on disk.

I've updated the related tools with just enough to enable the feature. I
still need to adjust ext4's fsck's, although without access to the keys,
neither fsck will be able to verify the hashes of casefolded and encrypted
names.

v7 chances:
Moved dentry operations from unicode to libfs, added new iterator function
to unicode to allow this.
Added libfs function for setting dentries to remove code duplication between
ext4 and f2fs.

v6 changes:
Went back to using dentry_operations for casefolding. Provided standard
implementations in fs/unicode, avoiding extra allocation in d_hash op.
Moved fscrypt d_ops setting to be filesystem's responsibility to maintain
compatibility with casefolding and overlayfs if casefolding is not used
fixes some f2fs error handling

v4-5: patches submitted on fscrypt

v3 changes:
fscrypt patch only creates hash key if it will be needed.
Rebased on top of fscrypt branch, reconstified match functions in ext4/f2fs

v2 changes:
fscrypt moved to separate thread to rebase on fscrypt dev branch
addressed feedback, plus some minor fixes


Daniel Rosenberg (8):
  unicode: Add utf8_casefold_iter
  fs: Add standard casefolding support
  f2fs: Use generic casefolding support
  ext4: Use generic casefolding support
  fscrypt: Have filesystems handle their d_ops
  f2fs: Handle casefolding with Encryption
  ext4: Hande casefolding with encryption
  ext4: Optimize match for casefolded encrypted dirs

 Documentation/filesystems/ext4/directory.rst |  27 ++
 fs/crypto/fname.c                            |   7 +-
 fs/crypto/fscrypt_private.h                  |   1 -
 fs/crypto/hooks.c                            |   1 -
 fs/ext4/dir.c                                |  78 +----
 fs/ext4/ext4.h                               |  93 ++++--
 fs/ext4/hash.c                               |  26 +-
 fs/ext4/ialloc.c                             |   5 +-
 fs/ext4/inline.c                             |  41 ++-
 fs/ext4/namei.c                              | 325 ++++++++++++-------
 fs/ext4/super.c                              |  21 +-
 fs/f2fs/dir.c                                | 127 +++-----
 fs/f2fs/f2fs.h                               |  15 +-
 fs/f2fs/hash.c                               |  25 +-
 fs/f2fs/inline.c                             |   9 +-
 fs/f2fs/namei.c                              |   1 +
 fs/f2fs/super.c                              |  17 +-
 fs/f2fs/sysfs.c                              |  10 +-
 fs/libfs.c                                   | 127 ++++++++
 fs/ubifs/dir.c                               |  18 +
 fs/unicode/utf8-core.c                       |  25 +-
 include/linux/f2fs_fs.h                      |   3 -
 include/linux/fs.h                           |  24 ++
 include/linux/fscrypt.h                      |   6 +-
 include/linux/unicode.h                      |  10 +
 25 files changed, 671 insertions(+), 371 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
