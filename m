Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D446AC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Jan 2022 23:40:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nDaqo-0000fc-DD; Fri, 28 Jan 2022 23:40:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nDaqn-0000fU-AO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jan 2022 23:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZAsAKoOPhvCZcu+P2R5tfDf2FODNgmx7Hd5jiXOgXJc=; b=U5ZrtiHFM27rmugyLB8pHC9DHu
 7mF21Cc9PdKtEkteS1dKOHhYumhJnKW6p3llW4ylAWAVKNsEXPz+JPcTy0cERor37Gd2Z5Y+hW4id
 yHB0uwUfBpyYWPLBW6t69k+9QqhN8hiL0qmRBo816hM/tSCZD9X3jYj+uHu5HDonXkRY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZAsAKoOPhvCZcu+P2R5tfDf2FODNgmx7Hd5jiXOgXJc=; b=Lqc6jvBHfuDuMaptzNCfHcLsNS
 gz5cqRAti4RXy68p0+fkyooXJTmZDdhyVG477S3PsUaYsmppHttNXAECbgdjNy4mxuw1QGzQoL5H0
 XrqpswWKNQShZN7K97lpkmqO9OxRC7iIsESKPC8mPzHgi5JvVXMQzs0dRf0QJyn6ud44=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nDaql-001YnK-1V
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jan 2022 23:40:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE0F61F40;
 Fri, 28 Jan 2022 23:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1C5C340E8;
 Fri, 28 Jan 2022 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643413204;
 bh=spfZ0C7Zzj01hpeB+SKGd/oodc1v3r1noyh70XVyPBY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r2Pk9YJCttEO3LXCWN96An7pNpeozJNfzD23KRTrHMV4ZDMWkGzZptp9dr+An7tHk
 AT7joZu6qGP3AlKNTtjhVXZr6d7kRRqTTijWcyXgYlXw2Kbj+gwNfWj6etyiOvYyXO
 zXvVSwby5N6+/nPPzvCxS4JqAHAI7z9cpk1jfcRsypsUtvpr4sAothr5bYJRXrsR9l
 cJ618VQ3o8Bt2meiuZCADNKl8Vv+EaHKGCNETgm7GqFQL2Oams+5KMQ+J9eLQG3+2c
 1AZRvJA6RVW0wa5BwmjzWu9JSsc3QH1lUEBg9IB25aqfT1p0uOuuJ757Oso4Yk7te2
 ZtCemJbi/UbuA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Fri, 28 Jan 2022 15:39:40 -0800
Message-Id: <20220128233940.79464-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128233940.79464-1-ebiggers@kernel.org>
References: <20220128233940.79464-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1nDaql-001YnK-1V
Subject: [f2fs-dev] [PATCH v11 5/5] fscrypt: update documentation for direct
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
Cc: Theodore Ts'o <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
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
2.35.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
