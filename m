Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605B1C43219
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jan 2022 07:16:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nARgP-00083c-32; Thu, 20 Jan 2022 07:16:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nARgL-00083P-51
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 07:16:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bnANM2P9Xg2ILtZC/GpHrS3aIDjp3aq4AmWOEGeQ+y8=; b=U/GD63mQyMnZptpdOn4FZFhslL
 zBP1xD2khBDJCkwNtuuMrUu0HgBRF/PfW0xjBDA7SlMFoDHwej3tWAeBj+GhIWpT/PN43Yboa9kpL
 LxFtLvY5XrWaAPGpnigmYIJ+IF0kTVrRCNhfa0vfF+asFZqV0+u+L34fwSTKESZgnt7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bnANM2P9Xg2ILtZC/GpHrS3aIDjp3aq4AmWOEGeQ+y8=; b=i4PtppCI9q8xk+NHVIHeBtS7YS
 yLHitcifdbRj3vv+CF3W6QFT8t+0L1qC32XyrMnpAsRykqAHfX5LZKIwQwA5OIWA9PWZrIoPzYAOa
 USAAAMo+SEI17AeW/3IdebD1IfGMV+W1ael8YtIByLquK5yrfsNlCZk8KAIiXsdY1DIs=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1nARgI-0002k7-Lz
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 07:16:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2E6D8B81CED;
 Thu, 20 Jan 2022 07:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E14C340EF;
 Thu, 20 Jan 2022 07:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642662975;
 bh=uVj1c8LpzrOMIafyi1Y9BE84r5VGaLUz8mtiVeWL7Ww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ad1EEixYJg4EzYsY4I7YdGlRV5zEpaWGSQqpm0KdN+F6YDMbVFJkbugFsizhGp2dV
 6BDVee4niP/qVIr0nS8VL9Jy2QpHO+USAPbFlw+e10QcBeG8ej6sz+lrsuaBJZuNh2
 Zw+nAD1Al7HeGkHWfwKxpZN2mCQKM93n416hqymbZLFPuHGZQ2y1HMBvvPOob1LGyW
 dyeIjma0u8GAjbyIwjd2h/6Vgjuv6EarWKTgW9jxgpO+G+k2u0YbHALPF168qRt++U
 EG60d3grANejWoomnSZNeTCtFCiqe9MPDQ5BsjYI1n3Vy0bdY/AEzCdacgLBPogqgt
 pUiNhJxhXg3ew==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Wed, 19 Jan 2022 23:12:13 -0800
Message-Id: <20220120071215.123274-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120071215.123274-1-ebiggers@kernel.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1nARgI-0002k7-Lz
Subject: [f2fs-dev] [PATCH v10 3/5] ext4: support direct I/O with fscrypt
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
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Satya Tangirala <satyat@google.com>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Encrypted files traditionally haven't supported DIO, due to the need to
encrypt/decrypt the data.  However, when the encryption is implemented
using inline encryption (blk-crypto) instead of the traditional
filesystem-layer encryption, it is straightforward to support DIO.

Therefore, make ext4 support DIO on files that are using inline
encryption.  Since ext4 uses iomap for DIO, and fscrypt support was
already added to iomap DIO, this just requires two small changes:

- Let DIO proceed when supported, by using fscrypt_dio_unsupported()
  instead of assuming that encrypted files never support DIO.

- In ext4_iomap_begin(), use fscrypt_limit_io_blocks() to limit the
  length of the mapping in the rare case where a DUN discontiguity
  occurs in the middle of an extent.  The iomap DIO implementation
  requires this, since it assumes that it can submit a bio covering (up
  to) the whole mapping, without checking fscrypt constraints itself.

Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/file.c  | 10 ++++++----
 fs/ext4/inode.c |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8cc11715518ac..2b520e99bee74 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -36,9 +36,11 @@
 #include "acl.h"
 #include "truncate.h"
 
-static bool ext4_dio_supported(struct inode *inode)
+static bool ext4_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
 {
-	if (IS_ENABLED(CONFIG_FS_ENCRYPTION) && IS_ENCRYPTED(inode))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (fscrypt_dio_unsupported(iocb, iter))
 		return false;
 	if (fsverity_active(inode))
 		return false;
@@ -61,7 +63,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		inode_lock_shared(inode);
 	}
 
-	if (!ext4_dio_supported(inode)) {
+	if (!ext4_dio_supported(iocb, to)) {
 		inode_unlock_shared(inode);
 		/*
 		 * Fallback to buffered I/O if the operation being performed on
@@ -509,7 +511,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/* Fallback to buffered I/O if the inode does not support direct I/O. */
-	if (!ext4_dio_supported(inode)) {
+	if (!ext4_dio_supported(iocb, from)) {
 		if (ilock_shared)
 			inode_unlock_shared(inode);
 		else
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5f79d265d06a0..7af1bba34b8b8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3409,6 +3409,13 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 out:
+	/*
+	 * When inline encryption is enabled, sometimes I/O to an encrypted file
+	 * has to be broken up to guarantee DUN contiguity.  Handle this by
+	 * limiting the length of the mapping returned.
+	 */
+	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
+
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 
 	return 0;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
