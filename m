Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BF1C61D99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Nov 2023 22:39:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r5ZPK-0007c5-8n;
	Tue, 21 Nov 2023 22:39:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1r5ZPH-0007bn-1b
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Nov 2023 22:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mqLFPZR1LPtWg/nVwC6DAX3Nhoma2+TW04u1JpDE9lQ=; b=HMqWFoVreerVx2g0h7qvErF1Q7
 v5HTEx42Il2O4uWJkMelF87nwJQ4f8dYIt8R4VrBAeZYNhrQ4TG1LE9RrPfN5V8PsEnICpjIYsyhG
 BDw3W60sIdhnhidMK/QacsLFPNgWASQYei/Kg6ACuVi5zddyxqEJK2FD5bKZ48Sq8kCg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mqLFPZR1LPtWg/nVwC6DAX3Nhoma2+TW04u1JpDE9lQ=; b=ASVaYWT0QRUhz4Fbxoyz/Q8dep
 0rh7KbThD7NdntZQ822O557mvpBHD2Qr8ZAaoSDZUsTd38ILu7FZFs+YEE6aU/WB0x1dMOrJpL24b
 lLNTS1LQ+p9Ig1i6ryt/HVk8DjTBNlQb+xC/aSMF71JUZlicTaObbY0TRoYRTI5FN+I4=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r5ZPE-00CIt4-Gr for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Nov 2023 22:39:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0910BCE1E60;
 Tue, 21 Nov 2023 22:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE78CC4339A;
 Tue, 21 Nov 2023 22:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700606377;
 bh=umCuFGN2fvdZ+2kf5o7EsnbD7X97WCaVkuR4lIaN3mI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OZWBWzwcrEm26xDQ8TxD0Pk8ybINPhnrBWu3ilH4q/c+4hP8SkZv/XzEMw3pTYdj8
 PGIeuI/gcG5SMi85/TUma9ccqq/teob0v8p9dfIfP8a4UgUKXDdtdJmWcZUPmFjFGS
 UGGYugXbAhTRLnxpo/Tf/rj/f1K+oc2B6DBm7WykpaSFfnwobc9MGTyAOuZGkSF3nF
 JSe26wy0TrSB9f0lRIr6JjfuZO5h8sSi7DCxF42QpoC9I0EzshGrsUUrqTaIizjq0E
 hJMiCf9Mh9v0Sq0AGbkDWH10rosJt8ZPyqgnCOaoTLmJB6BSGfK0ftt2vuuaIui76T
 P9myy1fNhtYXA==
From: Eric Biggers <ebiggers@kernel.org>
To: fstests@vger.kernel.org
Date: Tue, 21 Nov 2023 14:39:09 -0800
Message-ID: <20231121223909.4617-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121223909.4617-1-ebiggers@kernel.org>
References: <20231121223909.4617-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1r5ZPE-00CIt4-Gr
Subject: [f2fs-dev] [PATCH v2 4/4] generic: add test for custom crypto data
 unit size
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
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 Daniel Rosenberg <drosen@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Add a test that verifies the on-disk format of encrypted files that use
a crypto data unit size that differs from the filesystem block size.
This tests the functionality that was introduced in Linux 6.7 by kernel
commit 5b1188847180 ("fscrypt: support crypto data unit size less than
filesystem block size").

This depends on the xfsprogs patch
"xfs_io/encrypt: support specifying crypto data unit size"
(https://lore.kernel.org/r/20231013062639.141468-1-ebiggers@kernel.org)
which adds the '-s' option to the set_encpolicy command of xfs_io.

As usual, the test skips itself when any prerequisite isn't met.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/900     | 29 +++++++++++++++++++++++++++++
 tests/generic/900.out | 11 +++++++++++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..8d1b5766
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,29 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2023 Google LLC
+#
+# FS QA Test No. generic/900
+#
+# Verify the on-disk format of encrypted files that use a crypto data unit size
+# that differs from the filesystem block size.  This tests the functionality
+# that was introduced in Linux 6.7 by kernel commit 5b1188847180
+# ("fscrypt: support crypto data unit size less than filesystem block size").
+#
+. ./common/preamble
+_begin_fstest auto quick encrypt
+
+. ./common/filter
+. ./common/encrypt
+
+_supported_fs generic
+
+# For now, just test 512-byte and 1024-byte data units.  Filesystems accept
+# power-of-2 sizes between 512 and the filesystem block size, inclusively.
+# Testing 512 and 1024 ensures this test will run for any FS block size >= 1024
+# (provided that the filesystem supports sub-block data units at all).
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-CTS-CBC v2 log2_dusize=9
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-CTS-CBC v2 log2_dusize=10
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/900.out b/tests/generic/900.out
new file mode 100644
index 00000000..3259f08c
--- /dev/null
+++ b/tests/generic/900.out
@@ -0,0 +1,11 @@
+QA output created by 900
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-CTS-CBC
+	options: v2 log2_dusize=9
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-CTS-CBC
+	options: v2 log2_dusize=10
-- 
2.42.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
