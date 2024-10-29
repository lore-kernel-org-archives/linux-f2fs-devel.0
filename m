Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6DED2AB1C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Oct 2024 10:27:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5jRG-0001Cc-AO;
	Tue, 29 Oct 2024 10:27:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t5jRF-0001CJ-6l
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 10:27:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yewd8wXq58iJx0xMLe9YD8PwVDfb+OZEPMxsGMVi5Pw=; b=CfdtvCyFtUgeiQOOKgK4+9geh1
 BbBQ4oJlVowgQT8yKH1PaY9iHcTjnErr/QB/r2wuqEzJZ4+7Ewc6O/u6OTzR043/ke58preaKbKOw
 Ry+ZPziKi/5mUSRg3ANaheUPzOoUBGochYo1dw48Z1bj1Zi+GGBJvDjQLhQFcpqgjI6w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Yewd8wXq58iJx0xMLe9YD8PwVDfb+OZEPMxsGMVi5Pw=; b=J
 ZgJpBjqhs7BzvabEs2ZGEBxYNXv+jXWyNMg0T40H/VW6CGJ83VpD8EOhzekBB3yw5gjCKBXvAT3Wu
 gZIEs7psO+9n1h3eSZ3R5Al3+cYxvsao6zdf1ZkbMD1vdUn/AHeroYMjy4A/kSsNxXkejz+C39dAX
 /noiO6mvuaDTf2X0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t5jRF-0005zK-5x for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 10:27:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CABBF5C5C60;
 Tue, 29 Oct 2024 10:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2558BC4CECD;
 Tue, 29 Oct 2024 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730197610;
 bh=S2dJa1XpxHgGda35JR6CQ12ebtFG53YRSXoa6le1mmU=;
 h=From:To:Cc:Subject:Date:From;
 b=OpKUUPbA6uQD2ogIjxU17JqDUmIkBvK3gTK0dW1c2uzEQ1hH72mtcl+BMjUlrP7tR
 NzWL/GUHsQ/GFFmwEIOmsRQT3WBGVpxABW8159quxbuC1Zi0RFzOLd4X1yz6dXcF4j
 nJrUt6zyJnOFQra0e6yoogAIKj4Qma5jcKgYpJV4dizyjseSbuO7w9lSlp3Dwh14al
 oXE6i7B1dkYk6FHMbAj30JlOolT4sos4MKJgluuolQof5B29cT58Zf9fOJP59Awgh8
 dAxo6qWvDyPv22NcTslRyt2BNVPVl+LP5oGImPmQaPSDiiIWsjWkTtGKE2ikZY54Pk
 JKboIfjb44V0Q==
To: Zorro Lang <zlang@redhat.com>
Date: Tue, 29 Oct 2024 18:26:43 +0800
Message-Id: <20241029102644.4027606-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1t5jRF-0005zK-5x
Subject: [f2fs-dev] [PATCH v4 1/2] f2fs/006: add testcase to check
 out-of-space case
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is a regression test to check whether f2fs handles dirty
data correctly when checkpoint is disabled, if lfs mode is on,
it will trigger OPU for all overwritten data, this will cost
free segments, so f2fs must account overwritten data as OPU
data when calculating free space, otherwise, it may run out
of free segments in f2fs' allocation function. If kernel config
CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
dd may encounter I/O error.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- check dmesg instead of unstable output from dd
 tests/f2fs/006     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/006.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/f2fs/006
 create mode 100644 tests/f2fs/006.out

diff --git a/tests/f2fs/006 b/tests/f2fs/006
new file mode 100755
index 00000000..a9c823c1
--- /dev/null
+++ b/tests/f2fs/006
@@ -0,0 +1,42 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/006
+#
+# This is a regression test to check whether f2fs handles dirty
+# data correctly when checkpoint is disabled, if lfs mode is on,
+# it will trigger OPU for all overwritten data, this will cost
+# free segments, so f2fs must account overwritten data as OPU
+# data when calculating free space, otherwise, it may run out
+# of free segments in f2fs' allocation function. If kernel config
+# CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
+# dd may encounter I/O error.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix to account dirty data in __get_secs_required()"
+
+_require_scratch
+_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
+
+# use mode=lfs to let f2fs always triggers OPU
+_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
+
+testfile=$SCRATCH_MNT/testfile
+
+dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
+
+# The 2nd dd might run out of space, and trigger a kernel warning or
+# hang on unfixed kernel
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full 2>&1
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full 2>&1
+
+_scratch_remount checkpoint=enable
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
new file mode 100644
index 00000000..675c1b7c
--- /dev/null
+++ b/tests/f2fs/006.out
@@ -0,0 +1,2 @@
+QA output created by 006
+Silence is golden
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
