Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ACDCCD184
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 Oct 2025 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9MMIbsL2gCXXP8K6UgYy8AEYp/r0Nk+ojO3+2mLyzzk=; b=OFRWwiC+vj4rjosMygEqi4VIPf
	r79yEEzEaCX38T83qQhrJC7VKMZP72X21HlV065ypccCxbx4w7N+zJuNf0uRlwSXXYGFohAS7h31K
	yxYbB4H/Z0N+A2DzjrYt7EC0sXpxEBZVOoH/zYfwy3rzfT22l6cVjosQkTs9nVxdv33A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v7VGf-0006Mc-N3;
	Sat, 11 Oct 2025 08:47:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1v7VGe-0006MS-HL
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 Oct 2025 08:47:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gLGFjcuO5oDx852zRgJd1m/pS2B2aiPCiijm6JiaC7c=; b=e2bWT+7LGxa8f7XiikKPH9Nzcs
 4QIOApnbf0fnYouUNVuk92BOtnuN7DE0vEQO2oJYaQFG+hmKbAg4o9AaDXetOfzKvkQ+bbTD+ilFf
 rhLVVsY7Z5g0Co4BSzUIxGGvEJqSo0EJb0l6nSVykBcdAa0uubbdiaMfGNxPhd/aWIdQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gLGFjcuO5oDx852zRgJd1m/pS2B2aiPCiijm6JiaC7c=; b=Y
 kWtunjfaWmZ2R4BOgA51NIgRni79m0b8ceO/1KwdcIUqt37G4hcMRF6FKxj4kCDx0kRokcpz01ttw
 F0Escrxqk4dzj1lm30qNzNoN2Pi6FWTWjbcKa+MBKYHbcfc3b1Foe0bCtUtKZovDcRXsfzkeqKN5P
 Pmm0mxDWqEGspGso=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v7VGe-0004oU-4A for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 Oct 2025 08:47:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C115D43E86;
 Sat, 11 Oct 2025 08:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C42EC4CEF4;
 Sat, 11 Oct 2025 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760172465;
 bh=aRNDBJua0KIErd1NGeJk/Hz4Ic8lmnWSBxatZx+CVco=;
 h=From:To:Cc:Subject:Date:From;
 b=a1W8CEDxoycZgvWvdBImT6QszjDnFEYM0bZoSPAy32np1+HAovV03vcKHJgyiF9BH
 C+ioMgpMz4GZUI/sMeK/NEn05AUT53SpZLEYU9+NAEN0te7gU0Enstj2ffOl13B+FW
 aO52CJVtVE3Gfk3hGB/+GcANmxT8/AxtZ13/8Q3tFgUAn9+sACeYEsknkdmpDWTfV3
 HIq4cTDcaIVUXv6iKIAfu+EKd6CQpZpfAHCU9Ukdn2ZFJcHOMkCgXIjpGxlw6h82Tr
 Wlh+lhStK8hhiffNj1JvOkXAesmt6Hzdct8m6gZk0BL+wETcRz6SfvixVxiR/vBMM2
 HLdcUAMAhxjZw==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Sat, 11 Oct 2025 16:47:14 +0800
Message-ID: <20251011084715.608562-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
MIME-Version: 1.0
X-Headers-End: 1v7VGe-0004oU-4A
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs/021: test quota mount option
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This testcase tries to check whether f2fs can handle "usrjquota="
during remount correctly, it expects kernel will encounter NULL
pointer dereference bug w/o the fix ("f2fs: fix to avoid NULL pointer
dereference in f2fs_check_quota_consistency()").

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- update commit id in _fixed_by_kernel_commit line
 tests/f2fs/021     | 30 ++++++++++++++++++++++++++++++
 tests/f2fs/021.out |  2 ++
 2 files changed, 32 insertions(+)
 create mode 100755 tests/f2fs/021
 create mode 100644 tests/f2fs/021.out

diff --git a/tests/f2fs/021 b/tests/f2fs/021
new file mode 100755
index 00000000..0cacb138
--- /dev/null
+++ b/tests/f2fs/021
@@ -0,0 +1,30 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/021
+#
+# This testcase tries to check whether f2fs can handle "usrjquota="
+# during remount correctly
+#
+. ./common/preamble
+_begin_fstest auto quick mount quota remount
+
+_fixed_by_kernel_commit 930a9a6ee8e7 \
+	"f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()"
+
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount "-o usrquota"
+quotacheck -uc $SCRATCH_MNT
+_scratch_unmount
+
+_scratch_mount "-o usrjquota=aquota.user,jqfmt=vfsold"
+_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
+_scratch_unmount
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/021.out b/tests/f2fs/021.out
new file mode 100644
index 00000000..09f4062d
--- /dev/null
+++ b/tests/f2fs/021.out
@@ -0,0 +1,2 @@
+QA output created by 021
+Silence is golden
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
