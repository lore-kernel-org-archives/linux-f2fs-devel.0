Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E66CD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MEbaxkZIRLiICI+15HS3Ler9UrnM0YoTxFcLmg9Sn1k=; b=WhpnPvEL2QmTmBTt6iw5MaMkgE
	E8zxyrIvB/jmpqwb5ni7tqEMLo715s6LKVNiTJK/p1a3TsxsmspgIygHLFIY6mTwzgus3vuvKwhGI
	963yRixZtNAME2qw9SBHaEgRhwCzzn2vsIV59gfuLRT2g9rEZogsyXMKHs1qLsaYyuMU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZOKl-0001KX-O4;
	Tue, 16 Jun 2026 07:35:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZOKk-0001KQ-QP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 07:35:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5OqYq3CVAUbXgmqfvSQEnxITdTEtIh1tw62VVnP96dQ=; b=HYXxYHROaYSmrka9TlYkIrYIGK
 /qchk1LmcIqqXkZ/muhvSRNPQ02b6NgQONvnBc004rfXGekyEKpyx/cS9LKnqz7l3OQ5J7tDIQsX4
 86kOV6bd+aO8u8zNXy4njivuUUOL7S2OaAb43hbgcvYqYaKxN5xQr/TCF0Tfn5nKEuIo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5OqYq3CVAUbXgmqfvSQEnxITdTEtIh1tw62VVnP96dQ=; b=k
 LjFcjOW81UUiU3mfDbHMTwGAyx9tDX9jbu/eALLtwM2YKb85KnqnH9cSPjudgNiSMKfWwTQYKXQag
 sxGcOqeTOOPL5h1TtHGCEoTEtXW7zacheM5DBZ/Te9tWqUjfphzlA0yUe5sFr1M5aax9Wo0qJyj33
 /uzw5vQuOPCyuuN8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZOKi-0007SG-C8 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 07:35:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33C6260132
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 07:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A63C1F000E9;
 Tue, 16 Jun 2026 07:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781595334;
 bh=5OqYq3CVAUbXgmqfvSQEnxITdTEtIh1tw62VVnP96dQ=;
 h=From:To:Cc:Subject:Date;
 b=ROWIjqueRKTV4h2kfEPmCmyeoVPe/iCFmD6Mj/he2cqECD6xqkHSqfh+nDnWaj0FQ
 0Y6D2/d8liNox9Bil0zXBJEKq5lk3WNcg/hOAEuqguk6fIk6qbl6VIvr8JX+5kVtbN
 G7EBHn2A3EBBl15QolVvbSC2ydpXoSCi6Gqewk9DS9jUIZSbpwP0sXksB3i/tae9rg
 AHz0O1fBOgIerEX/rXvvcWbMiiJ0y/tjMiMMZrMFK6bEn4cAmgA5PHsn/ZPNEmRiqW
 U76sXPk0W/Nu4LoUWo84KL/Xl+KEeUUKoBf3jd/dPstFZoK4tN+ms1pjuoTxzjrf8q
 OHgMjsUAp1DIw==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Tue, 16 Jun 2026 07:35:26 +0000
Message-ID: <20260616073526.2967012-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
MIME-Version: 1.0
X-Headers-End: 1wZOKi-0007SG-C8
Subject: [f2fs-dev] [PATCH v4] f2fs/025: test to do sanity check section
 type correctly in f2fs GC
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
v4:
- add missing "_require_fs_sysfs_attr $TEST_DEV gc_urgent"
 tests/f2fs/025     | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/025.out |  2 ++
 2 files changed, 84 insertions(+)
 create mode 100755 tests/f2fs/025
 create mode 100644 tests/f2fs/025.out

diff --git a/tests/f2fs/025 b/tests/f2fs/025
new file mode 100755
index 000000000..807f18f23
--- /dev/null
+++ b/tests/f2fs/025
@@ -0,0 +1,82 @@
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
+_require_scratch
+_require_scratch_shutdown
+_require_xfs_io_command "pwrite"
+_require_xfs_io_command "truncate"
+_require_command "$F2FS_IO_PROG" f2fs_io
+_require_fs_sysfs_attr $TEST_DEV gc_urgent
+_require_check_dmesg
+
+# Clear options to avoid interference from external configurations
+export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
+
+# Format with 96MB size and 2 segments per section
+_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
+
+# Mount with mode=lfs
+_scratch_mount -o mode=lfs
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
+_scratch_shutdown
+
+_scratch_unmount
+
+_scratch_mount -o mode=lfs
+
+# Run urgent_gc mode to trigger garbage collection
+dev_name=$(_short_dev $SCRATCH_DEV)
+$F2FS_IO_PROG gc_urgent $dev_name run 5 >> $seqres.full
+
+_scratch_unmount
+
+# Check whether the dmesg has the warning indicating the bug
+_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
+	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
+
+echo "Silence is golden"
+_exit 0
diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
new file mode 100644
index 000000000..3d70951ef
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
