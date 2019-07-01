Return-Path: <SRS0=+7CQ=U6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D34C0650E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:34:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D18020881;
	Mon,  1 Jul 2019 15:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="E91HI/rC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PfUaRumH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD3SKZ4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D18020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hhyK5-0008LO-Ja; Mon, 01 Jul 2019 15:34:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hhyJs-0008JJ-L3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 15:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u61H/gwgjyULQ1rm03+rt15Bdb16dsB5g68vkpZtJ1o=; b=E91HI/rCf+RFZpGLq0OUocTqqV
 JfWMh+HB7Yq2I6SpA0gvshd9zPcmV+swadMAxjEvM9K5/8ajpC5CnxToPQS/gmjRiDL/guMM85iKG
 SpdbvwgUnK/wbwpanbhyqp9CdyzXobGKvcz3kkvxzBJJ/1LZ5uxiShhVsz01f2JagJBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u61H/gwgjyULQ1rm03+rt15Bdb16dsB5g68vkpZtJ1o=; b=PfUaRumHasvvF5PkAqF2aslMNh
 fH/8a1cbw32DUDqUIIEMNDWBlIkyF29Db/lNTbWCIh6p5tnp+g50gP1YmdcgN16byS2j6II2OJR0u
 KGhMOxiabuG8Sx3Fu2sRB2hkwGXa0I722cwK1wNR+4ZXeB69cP284ebN4fX93a1smRs8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hhyJz-000lNx-QD
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 15:34:25 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6CBEF21851;
 Mon,  1 Jul 2019 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561995250;
 bh=A41vt4jGxIjxms6taEMGdqC+r7hlRcG0OlJSTNYg6+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iD3SKZ4NuFdVsvtTwHp67q1eLCgKv2yQih/QpjUim8OmpZnbzQ7oZYjMXY6u0gEAF
 k4Z4Btr2h50/1QSnvfvHDqxAUosnpP3S4X9u6kVl1RL7GZnMGJX6lq/nnHFBQ2r4Rl
 TN6KX7sDkc7P2+SgJ6zcV67wWlDIRxUtX3jf9tyo=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Mon,  1 Jul 2019 08:32:36 -0700
Message-Id: <20190701153237.1777-17-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190701153237.1777-1-ebiggers@kernel.org>
References: <20190701153237.1777-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1hhyJz-000lNx-QD
Subject: [f2fs-dev] [PATCH v6 16/17] ext4: update on-disk format
 documentation for fs-verity
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-integrity@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Document the format of verity files on ext4, and the corresponding inode
and superblock flags.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/ext4/inodes.rst   |  6 ++-
 Documentation/filesystems/ext4/overview.rst |  1 +
 Documentation/filesystems/ext4/super.rst    |  2 +
 Documentation/filesystems/ext4/verity.rst   | 41 +++++++++++++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/verity.rst

diff --git a/Documentation/filesystems/ext4/inodes.rst b/Documentation/filesystems/ext4/inodes.rst
index 6bd35e506b6f..e851e6ca31fa 100644
--- a/Documentation/filesystems/ext4/inodes.rst
+++ b/Documentation/filesystems/ext4/inodes.rst
@@ -277,6 +277,8 @@ The ``i_flags`` field is a combination of these values:
      - This is a huge file (EXT4\_HUGE\_FILE\_FL).
    * - 0x80000
      - Inode uses extents (EXT4\_EXTENTS\_FL).
+   * - 0x100000
+     - Verity protected file (EXT4\_VERITY\_FL).
    * - 0x200000
      - Inode stores a large extended attribute value in its data blocks
        (EXT4\_EA\_INODE\_FL).
@@ -299,9 +301,9 @@ The ``i_flags`` field is a combination of these values:
      - Reserved for ext4 library (EXT4\_RESERVED\_FL).
    * -
      - Aggregate flags:
-   * - 0x4BDFFF
+   * - 0x705BDFFF
      - User-visible flags.
-   * - 0x4B80FF
+   * - 0x604BC0FF
      - User-modifiable flags. Note that while EXT4\_JOURNAL\_DATA\_FL and
        EXT4\_EXTENTS\_FL can be set with setattr, they are not in the kernel's
        EXT4\_FL\_USER\_MODIFIABLE mask, since it needs to handle the setting of
diff --git a/Documentation/filesystems/ext4/overview.rst b/Documentation/filesystems/ext4/overview.rst
index cbab18baba12..123ebfde47ee 100644
--- a/Documentation/filesystems/ext4/overview.rst
+++ b/Documentation/filesystems/ext4/overview.rst
@@ -24,3 +24,4 @@ order.
 .. include:: bigalloc.rst
 .. include:: inlinedata.rst
 .. include:: eainode.rst
+.. include:: verity.rst
diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 04ff079a2acf..6eae92054827 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -696,6 +696,8 @@ the following:
        (RO\_COMPAT\_READONLY)
    * - 0x2000
      - Filesystem tracks project quotas. (RO\_COMPAT\_PROJECT)
+   * - 0x8000
+     - Verity inodes may be present on the filesystem. (RO\_COMPAT\_VERITY)
 
 .. _super_def_hash:
 
diff --git a/Documentation/filesystems/ext4/verity.rst b/Documentation/filesystems/ext4/verity.rst
new file mode 100644
index 000000000000..3e4c0ee0e068
--- /dev/null
+++ b/Documentation/filesystems/ext4/verity.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Verity files
+------------
+
+ext4 supports fs-verity, which is a filesystem feature that provides
+Merkle tree based hashing for individual readonly files.  Most of
+fs-verity is common to all filesystems that support it; see
+:ref:`Documentation/filesystems/fsverity.rst <fsverity>` for the
+fs-verity documentation.  However, the on-disk layout of the verity
+metadata is filesystem-specific.  On ext4, the verity metadata is
+stored after the end of the file data itself, in the following format:
+
+- Zero-padding to the next 65536-byte boundary.  This padding need not
+  actually be allocated on-disk, i.e. it may be a hole.
+
+- The Merkle tree, as documented in
+  :ref:`Documentation/filesystems/fsverity.rst
+  <fsverity_merkle_tree>`, with the tree levels stored in order from
+  root to leaf, and the tree blocks within each level stored in their
+  natural order.
+
+- Zero-padding to the next filesystem block boundary.
+
+- The verity descriptor, as documented in
+  :ref:`Documentation/filesystems/fsverity.rst <fsverity_descriptor>`,
+  with optionally appended signature blob.
+
+- Zero-padding to the next offset that is 4 bytes before a filesystem
+  block boundary.
+
+- The size of the verity descriptor in bytes, as a 4-byte little
+  endian integer.
+
+Verity inodes have EXT4_VERITY_FL set, and they must use extents, i.e.
+EXT4_EXTENTS_FL must be set and EXT4_INLINE_DATA_FL must be clear.
+They can have EXT4_ENCRYPT_FL set, in which case the verity metadata
+is encrypted as well as the data itself.
+
+Verity files cannot have blocks allocated past the end of the verity
+metadata.
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
