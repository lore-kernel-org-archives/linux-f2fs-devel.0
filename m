Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82569CD4F3C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 May 2026 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lxElgcOjXIYmg4VGWSQAWjydv9FBZ60CBc019otPZQ0=; b=XU5ULVbd8w4LOd/a8HjQ5ZjbfL
	icAQtEsThVksRPwS1gXBJFNZ6cEG97jJC1PO3YG3dEpFYdPD7232h3B/zXAq5PgGN0TG377Pm7tHM
	XzvUX+usNufwD35UIOaE05eJZr8UUXOpcR4JgVGeeQcoVcPhaljFFL6kD6WqsspxjDFY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wOuyP-00081h-MF;
	Mon, 18 May 2026 10:13:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wOuyO-00081Q-3i
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 May 2026 10:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lXI37cs1cl+OZkg+XjxUWn6ae+f43phBCI2sLbjJeyI=; b=lWeNuepIJ+CBLhaORlPUaf8SZC
 GAWaRzCHp+RAvZ6slsVTgvK6wJxEp+QMRLo13/AakSI+xfX9z8jIIgzeh23WZvFhKL4/7VX5p2bKF
 bDlp1/5X6sN6OtNUoJm1kIyYgWp5sLO0gUhrIthn+p041JvN25QKeRGOS4E4VoUfIyOo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lXI37cs1cl+OZkg+XjxUWn6ae+f43phBCI2sLbjJeyI=; b=S
 PNpPvEtQ7cbgMk/ToEJTOragpquDDYqexoMhhF+vbnAa0i038OQxdjpTck6AK/2Urdn0zYNlRkEP+
 CVgOFrCQujABtzNMKHXhMTS2cFkigCMofBfBGgvBJTDeGDAHe2dFyXLFdBq4JOfqnctE7ZDyoaD12
 KWGzjK0FWnkLpt98=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOuyN-0006CJ-Kv for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 May 2026 10:13:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BB5243D54;
 Mon, 18 May 2026 10:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD28FC2BCF5;
 Mon, 18 May 2026 10:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779099194;
 bh=4X1McEd5eVxfLzKIoES+zNc8qiIg/c8YVdL/tToqksQ=;
 h=From:To:Cc:Subject:Date:From;
 b=lK6oGDezHjX3WJBBMTcITOmeiR39nGhQxrP8y6+Vxx88LUetKTYQYb36M5wY1P/LX
 sQCOQtDv7lbcMBuvHOn0cBrietvJYMXjVPnoU62Eg88OqbL24pFYqC5tvm0BkIJ1HO
 xyqx4ERqBHWFzTyVmuxY6y+XfXQSmuBx6wvZkmOjWwSiQq16k5AMK9vAF+e3fZalR5
 Jza8ZnslqISlF9sxEujRrIYvtiZOxyixnvjLvRhoO+fC8LPzyy12p723/yyvNVo2lo
 zZwba6KAmmVCSFvKhyfnIg4Cg0N6lwyoP9R/LvAnintv7Mzaly70l0LIT9dx011Ffz
 cHUEn1cEYKZlw==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Mon, 18 May 2026 18:12:52 +0800
Message-ID: <20260518101252.445214-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
MIME-Version: 1.0
X-Headers-End: 1wOuyN-0006CJ-Kv
Subject: [f2fs-dev] [PATCH] f2fs/025: test to do sanity check section type
 correctly in f2fs GC
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
Cc: joannechien@google.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Without commit 520760b9f915 ("f2fs: optimize representative type determination
in GC"), f2fs GC will report inconsistent segment type in large section issue,
and then it will force to shutdown filesystem.

[  768.190903] F2FS-fs (loop51): Inconsistent segment (3) type [1, 0] in SIT and SSA

The reason is f2fs kernel will assume all segment type inside large section is
the same, during GC it loads type from one segment and compare it to other
segments' type, however due to recovery flow, the chosen segment may has zero
valid blocks w/ different segment type, since the segment is invalid(free) one,
it will never be migrated, so that we should not treat such state as abnormal
condition.

This testcase is created to simulate above condition to see whether f2fs kernel
module can handle it correctly

Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/025     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/025.out |  2 ++
 2 files changed, 90 insertions(+)
 create mode 100644 tests/f2fs/025
 create mode 100644 tests/f2fs/025.out

diff --git a/tests/f2fs/025 b/tests/f2fs/025
new file mode 100644
index 00000000..1eba7158
--- /dev/null
+++ b/tests/f2fs/025
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Chao Yu <chao@kernel.org>
+#
+# FS QA Test No. f2fs/025
+#
+# Check whether f2fs will encounter cp_error (Inconsistent segment type)
+# when doing sanity check on type of segments inside large section during
+# garbage collection.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_kernel_commit 520760b9f915 \
+	"f2fs: optimize representative type determination in GC"
+
+. ./common/filter
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+_require_scratch
+_require_xfs_io_command "pwrite"
+_require_xfs_io_command "truncate"
+_require_command "$F2FS_IO_PROG" f2fs_io
+_require_check_dmesg
+
+# Format with 96MB size and 2 segments per section
+_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
+
+# Mount with mode=lfs
+_scratch_mount -o mode=lfs >> $seqres.full 2>&1
+
+# Create files to fill whole filesystem, then segment type will be changed to node type
+for ((i=0;i<5120;i++)) do
+	touch $SCRATCH_MNT/$i >> $seqres.full 2>&1
+done
+sync
+
+# Remove all files to create free(empty) node segments
+rm -f $SCRATCH_MNT/*
+sync
+
+# Allocate free space so that we have chance to reuse free(empty) node segments
+$XFS_IO_PROG -f -c "pwrite -b 4k 0 1928k" $SCRATCH_MNT/file >> $seqres.full 2>&1
+sync
+
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+sync
+
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 8M" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 32K" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 2M" -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1
+
+# Shutdown the filesystem without checkpoint
+$F2FS_IO_PROG shutdown 2 $SCRATCH_MNT >> $seqres.full 2>&1
+
+_scratch_unmount >> $seqres.full 2>&1
+
+_scratch_mount -o mode=lfs >> $seqres.full 2>&1
+
+# Run urgent_gc mode to trigger garbage collection
+dev_name=$(_short_dev $SCRATCH_DEV)
+if [ -f /sys/fs/f2fs/$dev_name/gc_urgent ]; then
+	echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
+fi
+
+# Wait background GC thread to wake up to run and potentially encounter the inconsistency
+sleep 5
+
+_scratch_unmount >> $seqres.full 2>&1
+
+# Check whether the dmesg has the warning indicating the bug
+_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
+	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
new file mode 100644
index 00000000..3d70951e
--- /dev/null
+++ b/tests/f2fs/025.out
@@ -0,0 +1,2 @@
+QA output created by 025
+Silence is golden
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
