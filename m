Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DE9C3DA59
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 20 Jul 2024 07:43:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sV4kh-00083E-6Q;
	Sat, 20 Jul 2024 07:43:34 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sV4kf-000835-6c
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Jul 2024 07:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0TXDpwqr7waFP6q6XjPvlKSLDK5e8HXeltuX6pqcWKg=; b=b3VW9bOLnL8WmTP0UmhoVfaDZP
 GzS607gFfdpWuoG79n7rvX3U8oOU9os/dhQ4rsyS8CygJduJnov/Irm21hHJpkHmeFsQPh4Fg1EZK
 5CX/QumyY1KrzLtt1SXtkJ1BTw8aE86rnKygUHmmj/a//ZfM9TLvu5OJVR4LUxVtUuZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0TXDpwqr7waFP6q6XjPvlKSLDK5e8HXeltuX6pqcWKg=; b=P
 OZdiMooBhd0qtVPa/X53Y470AK7zOvXfImUvZuN6e0Thda437I9pV2kWpq9eD2NCGCEdPPfw0+fWJ
 A51tJRdIGy8Y5B56+sGfZ6WgU9TFyGVMYpMxG9BwsYyuUiPOqyht6nGgLCXsvEUJxJpNIR9IKLyrd
 /l7ZS8/bD6TTIF+Q=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sV4kc-0007jU-Rq for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Jul 2024 07:43:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CB3DCCE1B53;
 Sat, 20 Jul 2024 07:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFAAC2BD10;
 Sat, 20 Jul 2024 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721461403;
 bh=SXN+gBJcErBmdJHeulGYWX8/O+1JBPPNS2SRTZEpCgI=;
 h=From:To:Cc:Subject:Date:From;
 b=cPLgDzP1xDCVd2Wy/UdRsW7Xlq3BYU/Y/CALW15l82YVagp2mEqc/c6O/WIWwEmNO
 99kQvhnIii771O/efwiWgrk9riv788Xx34eV1HFQkUKzkYezn7DbBg/6eg1DtQE+8q
 28g/M3m9bPT7VhxDmqwumezttGi1BCU0xWCMOHwJw8wGpS7EK7u5cZ3AsaabwdOMbS
 jrelTeBtv6X20V4tjTiEbnFITpn+G2iTrIi9YQB0xr/bt8n9wLY+qEWgXwpwHFUhWO
 6+5MU5wHmBGGtonVqRbbNQEtbWlSUJmuLEsv8MYmmLnqdVDzahCj0pvNsSMAQBF8Yp
 K7Gf7ItFaRy3Q==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Date: Sat, 20 Jul 2024 15:43:16 +0800
Message-Id: <20240720074316.3302470-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sV4kc-0007jU-Rq
Subject: [f2fs-dev] [PATCH v2] f2fs: test for race condition in between
 atomic_write and gc
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Test that we will simulate sqlite atomic write logic w/ below steps:
1. create a regular file, and initialize it w/ 0xff data
2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
3. write transaction data
4. trigger foreground GC to migrate data block of the file
5. commit and end the transaction
6. check consistency of transaction
This is a regression test to check handling of race condition in
between atomic_write and GC.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add kill&wait in _clean() to avoid umount failure
- some cleanups
- use exported helpler
 tests/f2fs/003     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/003.out | 11 ++++++++
 2 files changed, 76 insertions(+)
 create mode 100755 tests/f2fs/003
 create mode 100644 tests/f2fs/003.out

diff --git a/tests/f2fs/003 b/tests/f2fs/003
new file mode 100755
index 00000000..c30e874a
--- /dev/null
+++ b/tests/f2fs/003
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/003
+#
+# Test that we will simulate sqlite atomic write logic w/ below steps:
+# 1. create a regular file, and initialize it w/ 0xff data
+# 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
+# 3. write transaction data
+# 4. trigger foreground GC to migrate data block of the file
+# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
+# 6. check consistency of transaction w/ in-memory and on-disk data
+# This is a regression test to check handling of race condition in
+# between atomic_write and GC.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/filter
+
+_cleanup()
+{
+	kill -9 $atomic_write_pid > /dev/null 2>&1
+	wait > /dev/null 2>&1
+}
+
+_require_scratch
+_require_xfs_io_command "fpunch"
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+dbfile=$SCRATCH_MNT/dbfile
+foo=$SCRATCH_MNT/foo
+bar=$SCRATCH_MNT/bar
+
+$XFS_IO_PROG -c "pwrite 0 512k -S 0xff" -c "fsync" -f $dbfile >> $seqres.full
+$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $foo >> $seqres.full
+sync
+
+# start atomic_write on dbfile & write data to dbfile
+$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
+atomic_write_pid=$!
+
+$XFS_IO_PROG -c "fpunch 0 2m" $foo >> $seqres.full
+$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $bar >> $seqres.full
+
+# persist all dirty data
+sync
+echo 3 > /proc/sys/vm/drop_caches
+
+# trigger foreground GC to migrate data block of atomic_file
+$F2FS_IO_PROG gc 1 $SCRATCH_MNT > /dev/null 2>&1
+
+# wait for atomic_write commit completion
+sleep 5
+# print in-memory data
+_hexdump $dbfile
+echo 3 > /proc/sys/vm/drop_caches
+# print on-disk data
+_hexdump $dbfile
+
+status=0
+exit
diff --git a/tests/f2fs/003.out b/tests/f2fs/003.out
new file mode 100644
index 00000000..64698d84
--- /dev/null
+++ b/tests/f2fs/003.out
@@ -0,0 +1,11 @@
+QA output created by 003
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+020000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
+*
+080000
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+020000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
+*
+080000
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
