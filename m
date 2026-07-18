Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC52C4450A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xsX9lOOratmsAxXJBvX4x6TwHQpVfl8Dxf5Z3x/9boU=; b=UCjO2NPTUs3dlTE0e3DiLYOuoF
	SreA+CGyj40VrQpKOZN4cv7a5Q3cf4jvx/puPqd+008tJdt2ioIBcg+Vd8RWioZ68M67LfPB+5LHm
	tSdsLr12UyiqnxfMlIdAOCgHP4Sgk6V1Nvvxb/0ndmzZ7yGOV56Udci7tQkIDnU03Wi4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlCuN-00042V-2E;
	Sat, 18 Jul 2026 21:49:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wlCuL-00042D-Gz
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7tUng5UB5zoDVf4llbeDN6q8xct/811JqmccCtQmV/Y=; b=XW5i2pru7xsLvfXUm8p9Tfk1KE
 0HafXqGQWE6PNxAvYK0NnKrz/nERDrr9vVO8XmFEDqZadEXYaFIAmhHgBzax4fl1StZmm44caA7eH
 A5uY6sk308XmDupY2ypnpXljQYQ0UjS9nFOyuGjd50K7j9zOQbWtkJ2IH8kNR0jCD+98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7tUng5UB5zoDVf4llbeDN6q8xct/811JqmccCtQmV/Y=; b=IK10+u6ojrXZ8p6YA46/tGiyvM
 lRm16hdj/2CfQz1uRbtjYdOnNRB2jitBDTkMriK62julhRh2TxfLIzhd9+wKqRowlLIZFr3LmCRCF
 2Oa+ETGGhZ0T0yKwmaZU1afUZ3a6ZLOP6rtm+JDV4UVcwmgDhQAqZkMKz4zG2SATsrfk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlCuL-0003W3-Mw for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 201B660204
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 18 Jul 2026 21:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D6D1F00A3D;
 Sat, 18 Jul 2026 21:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784411346;
 bh=7tUng5UB5zoDVf4llbeDN6q8xct/811JqmccCtQmV/Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W5Lkvhv8aQFtdZGWjUNgTCoILUgcG1j2EQfsokz9t02DPWinakrlBkvJoeFWO31TR
 WG8h3XbFcvyDKF3YglZz4gH4af+Sf4Ax/I7dep/f8srOeoRwu8RhETVjLC7FHpjI+P
 gRTpv4zpZpQFAaShH1yQKZ6fL+5+qKLy/zidfO/RaUrCFUHuPmYIOxLr+vhZMqrLFh
 Ws4dmbJyti9lD8QGwXdwNkiTpnxuYhK6HVDBVDJVLYDp7vG06rvjWT5RfS09XT0nd+
 eNxJbOHssU/fF0MaEoPfL8E6kpOFSmFcsvvGlEZVml64X1GkjF7jQ0mjGAFozKckQq
 xmT6/NAfBQ2Kw==
To: linux-fscrypt@vger.kernel.org
Date: Sat, 18 Jul 2026 14:46:53 -0700
Message-ID: <20260718214655.63186-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718214655.63186-1-ebiggers@kernel.org>
References: <20260718214655.63186-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wlCuL-0003W3-Mw
Subject: [f2fs-dev] [PATCH 4/6] fscrypt: Update docs for data path
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Update the "Data path changes" section to accurately document and
elaborate on the current implementation of file contents en/decryption.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/filesystems/fscrypt.rst | 56 ++++++++++++++++++---------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 5f1b5b53aa16..ef0925f78fa1 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1475,25 +1475,43 @@ keys`_ and `DIRECT_KEY policies`_.
 Data path changes
 -----------------
 
-When inline encryption is used, filesystems just need to associate
-encryption contexts with bios to specify how the block layer or the
-inline encryption hardware will encrypt/decrypt the file contents.
-
-When inline encryption isn't used, filesystems must encrypt/decrypt
-the file contents themselves, as described below:
-
-For the read path (->read_folio()) of regular files, filesystems can
-read the ciphertext into the page cache and decrypt it in-place.  The
-folio lock must be held until decryption has finished, to prevent the
-folio from becoming visible to userspace prematurely.
-
-For the write path (->writepages()) of regular files, filesystems
-cannot encrypt data in-place in the page cache, since the cached
-plaintext must be preserved.  Instead, filesystems must encrypt into a
-temporary buffer or "bounce page", then write out the temporary
-buffer.  Some filesystems, such as UBIFS, already use temporary
-buffers regardless of encryption.  Other filesystems, such as ext4 and
-F2FS, have to allocate bounce pages specially for encryption.
+The block-based filesystems that support fscrypt, such as ext4 and
+f2fs, use blk-crypto (:ref:`inline_encryption`) to implement file
+contents encryption and decryption.  With blk-crypto, the filesystem
+assigns an encryption context to each I/O request it issues to the
+contents of an encrypted file.  The encryption (for writes) or
+decryption (for reads) is handled by the block layer transparently to
+the filesystem, using either the CPU or inline encryption hardware.
+
+Non-block-based filesystems can't use blk-crypto, so they make the
+calls to the cryptographic algorithms at the filesystem layer instead.
+
+Regardless of the layer in which they occur (blk-crypto-fallback or the
+filesystem), for CPU-based encryption and decryption of file contents:
+
+- For reads, the ciphertext data is read from the storage backend
+  (block device, network, UBI device, etc.) into the destination
+  buffers, then decrypted in-place.  The destination buffers are
+  pagecache folios for buffered reads, or application-provided buffers
+  for direct reads.  In either case, the filesystem reports success
+  only after decryption has successfully completed.
+
+- For writes, the plaintext data is encrypted from the source buffers
+  (which cannot be modified) into bounce buffers.  Then, the
+  ciphertext in the bounce buffers is written to the storage backend.
+
+  The source buffers are usually pagecache folios for buffered writes,
+  or application-provided buffers for direct writes.  There are also
+  some cases (all files on UBIFS, and compressed files on f2fs) where
+  the filesystem already uses bounce buffers for writes for other
+  reasons; in these cases the source plaintext data is already in
+  bounce buffers.  UBIFS optimizes this case by encrypting the data
+  in-place in its existing bounce buffers.
+
+When inline encryption hardware is used instead of the CPU, reads from
+the storage backend logically return plaintext data, and writes accept
+plaintext data.  In that case the flow is simplified: there's no
+scheduling of decryption work, and no bounce buffers are used.
 
 Filename hashing and encoding
 -----------------------------
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
