Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3D0C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jan 2022 07:16:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nARgZ-00066q-Tn; Thu, 20 Jan 2022 07:16:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nARgX-00066f-Bn
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 07:16:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=565AAa+ujCCFRy1mVRfRfJm6kzkXKutQvw0HWX06s4o=; b=BfIzFEgPvv1rERENysUlaMAJRD
 jBE2CcW4vYYvFKown0nMcj3WrasoxLtmJbdrNjB1ffvNGRqEUvDygJ0MsjDKFMZbIA5ztOlJOJH07
 f/G7l75wI0pxxhXQYqq2c7Ll5zxS30+JKZ4+aBF82k5Eb0kU8QqtEu9klg/SpZySwfyE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=565AAa+ujCCFRy1mVRfRfJm6kzkXKutQvw0HWX06s4o=; b=cign1+zzTQPrghz3MyRQEhmNF0
 Huu++3xh09gCAXE5BG+g1Q8nHSKw+Uq80ACsKUomLpnra8wcKQZ0IVokrzRZGcCOw4SkEVdI3IoQt
 jYgjDsvcN9QhZ/8cpHTFWFvw4KoazENAjdPfRVSu3C1aiowjvEIG6pPHkCMovM7YNXMM=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1nARgP-004b0v-Ui
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 07:16:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E7BB9CE2004;
 Thu, 20 Jan 2022 07:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A38C340F1;
 Thu, 20 Jan 2022 07:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642662976;
 bh=G1gWsQedwA04fsGDZAwPwBO++Xa6hjRhpWotinFU33I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Qntr6frtkWdoYANiGYBoYFWCngoe1Tqpb4LMgVGZo/VIozOGZKOHGhT0M4tTXfG3R
 MrkewIH3DvjpV50jaBAbSXmFf0ndRZwHrm1GoxjiQ1ZzHGlqLnAm4US6Pqgpfeq951
 3qPMZtuR4kjF01tEPO/Tru3aMlNE3IbFEITQig41CUclxJf+blJMxZdeVXSU60P5+c
 nuDmDiq9jYF40EnNTxGKaHzY/Sbd8rhJEqDsDCTJihfNFX7jOSZrZnoq11YB01mQUe
 l4ZV5UjiuuhWAWIkFF1luMgmtyAabJweWcavoI4NB7xul4jyN1GX0Vce/EwobNQVRO
 d1v0Xef6p+2Yg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Wed, 19 Jan 2022 23:12:15 -0800
Message-Id: <20220120071215.123274-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120071215.123274-1-ebiggers@kernel.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1nARgP-004b0v-Ui
Subject: [f2fs-dev] [PATCH v10 5/5] fscrypt: update documentation for direct
 I/O support
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
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that direct I/O is supported on encrypted files in some cases,
document what these cases are.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 4d5d50dca65c6..6ccd5efb25b77 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1047,8 +1047,8 @@ astute users may notice some differences in behavior:
   may be used to overwrite the source files but isn't guaranteed to be
   effective on all filesystems and storage devices.
 
-- Direct I/O is not supported on encrypted files.  Attempts to use
-  direct I/O on such files will fall back to buffered I/O.
+- Direct I/O is supported on encrypted files only under some
+  circumstances.  For details, see `Direct I/O support`_.
 
 - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
   FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
@@ -1179,6 +1179,27 @@ Inline encryption doesn't affect the ciphertext or other aspects of
 the on-disk format, so users may freely switch back and forth between
 using "inlinecrypt" and not using "inlinecrypt".
 
+Direct I/O support
+==================
+
+For direct I/O on an encrypted file to work, the following conditions
+must be met (in addition to the conditions for direct I/O on an
+unencrypted file):
+
+* The file must be using inline encryption.  Usually this means that
+  the filesystem must be mounted with ``-o inlinecrypt`` and inline
+  encryption hardware must be present.  However, a software fallback
+  is also available.  For details, see `Inline encryption support`_.
+
+* The I/O request must be fully aligned to the filesystem block size.
+  This means that the file position the I/O is targeting, the lengths
+  of all I/O segments, and the memory addresses of all I/O buffers
+  must be multiples of this value.  Note that the filesystem block
+  size may be greater than the logical block size of the block device.
+
+If either of the above conditions is not met, then direct I/O on the
+encrypted file will fall back to buffered I/O.
+
 Implementation details
 ======================
 
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
