Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A593AC3600B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Mar 2025 05:52:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1txgA0-0007WP-1h;
	Thu, 27 Mar 2025 05:52:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1txg9z-0007WJ-5Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Mar 2025 05:52:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SKS+YpvgDo4ZfSWkCZwLwo8UwvVuLqOgA2tP+BQFPbw=; b=fKXY0ziH5sSmLTD8SyEUAX/ud0
 QaIMCybw73Sce6zWihymdr1Mz7AiRgGOhq44Or7KH4ueTvmMHfHl5VDNw0qDTrDGC9IftOVffymSl
 7LPfc4k7Z/sdxsMabli7uoD2Vw6LmjrJwNVVteczKgsV3SqjIvgLXmWm0dk2Pf9AlpcQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SKS+YpvgDo4ZfSWkCZwLwo8UwvVuLqOgA2tP+BQFPbw=; b=b
 10xx5k6cCqO37UopKayi4i08BLG6yE4vcBgL1Q2ZcaAQq9UPsC0FFqKR24cCS5sis0eQKyl9dHwMA
 j2omQlUcNRtk4r1gV9iSRkUkQWZU12oKmmNDFvPM2zlJYbViK+IfZzb2ZJ4IecCtnGy2vuSGCELbT
 iTDiXBC/yYSapDgU=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1txg9o-0005IU-Ax for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Mar 2025 05:52:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B0819A40429
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Mar 2025 05:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD75C4CEDD;
 Thu, 27 Mar 2025 05:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743054708;
 bh=SJIyKCRKFBYowD/M/cJu/HYSC7rzw8jixMT6n76IJts=;
 h=From:To:Cc:Subject:Date:From;
 b=icW0DUIeUcDUPNCt+txYgmrjj68MKU+PGnynOBnMPrzWMh9u+IdyHb1ouNMsYShXe
 Hv0JPJho2HnxL21A3jcV0lhBM+KKPb107Tvvj//tyAIoELBed7teGwdkzMdSFdg97g
 Sps6LxcfrzzHAmeEuS9K8iF/5uT6hjvkouyvzzMvCmeMg4slnrGQt4gk94zkZ6A+8e
 yaXPDTLDqlYOb+eKLOBvY1Q8O9ebPmgJ99SNJ6XtXPg14X/jtNi4c0/L+NMs4+A+Am
 JEUgkQLMCA4NiASmFxf4KnYwoBCx5C73f8lRJzN1YyuSrQLmXzI5xGDV/QNcqtO30b
 n3m205FppsSfg==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Thu, 27 Mar 2025 13:50:51 +0800
Message-ID: <20250327055051.3827735-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
MIME-Version: 1.0
X-Headers-End: 1txg9o-0005IU-Ax
Subject: [f2fs-dev] [PATCH v2] f2fs/011: test to check out-of-space issue
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is a regression testcase to check whether we will handle
out-of-space case correctly during fallocate() on pinned file
once we disable checkpoint.

Testcase:
1. mount f2fs w/ checkpoint=disable option
2. create fragmented file data
3. set flag w/ pinned flag
4. fallocate space for pinned file, expects panic due to running
out of space.

We should apply both commit ("f2fs: fix to avoid panic once
fallocation fails for pinfile") and commit ("f2fs: fix to avoid
running out of free segments") to avoid system panic.
Note that w/ these two commit, we fixed such issue in both
convential and zoned block device.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- clean up codes suggested by Zorro
- change output to expect ENOSPC error if we have applied fixes
 tests/f2fs/011     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/011.out |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100755 tests/f2fs/011
 create mode 100644 tests/f2fs/011.out

diff --git a/tests/f2fs/011 b/tests/f2fs/011
new file mode 100755
index 00000000..ec3d39ec
--- /dev/null
+++ b/tests/f2fs/011
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/011
+#
+# This is a regression testcase to check whether we will handle
+# out-of-space case correctly during fallocate() on pinned file
+# once we disable checkpoint.
+# 1. mount f2fs w/ checkpoint=disable option
+# 2. create fragmented file data
+# 3. set flag w/ pinned flag
+# 4. fallocate space for pinned file, expects panic due to running
+# out of space
+# We should apply both commit ("f2fs: fix to avoid panic once
+# fallocation fails for pinfile") and commit ("f2fs: fix to avoid
+# running out of free segments") to avoid system panic.
+# Note that w/ these two commit, we fixed such issue in both
+# convential and zoned block device.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_kernel_commit 48ea8b200414 \
+	"f2fs: fix to avoid panic once fallocation fails for pinfile"
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix to avoid running out of free segments"
+
+_require_scratch
+_require_command "$F2FS_IO_PROG" f2fs_io
+
+_scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
+_scratch_mount -o checkpoint=disable:10%
+
+pinfile=$SCRATCH_MNT/file
+
+# simulate fragment status in f2fs
+for ((i=0;i<256;i++)) do
+	$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
+done
+sync
+
+for ((i=0;i<256;i+=2)) do
+	rm -f $SCRATCH_MNT/$i
+done
+sync
+
+touch $pinfile
+$F2FS_IO_PROG pinfile set $pinfile >> $seqres.full
+$XFS_IO_PROG -c "falloc 0 $((3*256*1024*1024))" $pinfile
+
+status=0
+exit
diff --git a/tests/f2fs/011.out b/tests/f2fs/011.out
new file mode 100644
index 00000000..559c3fdf
--- /dev/null
+++ b/tests/f2fs/011.out
@@ -0,0 +1,2 @@
+QA output created by 011
+fallocate: No space left on device
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
