Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617E5D2AB1B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Oct 2024 10:27:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5jRJ-0001gm-Ul;
	Tue, 29 Oct 2024 10:27:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t5jRI-0001gf-4e
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 10:27:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sTA4xpv4vJB1xbyz+G5aCWI0ViRS/VyPu6J6v34nvxw=; b=fYuD6cYPWPPlilsqiG6DUmAoxY
 lT7jW1cPhlZpwYUatdhxzhfANL0edLCWO/40YNzOLHWVq0pCArVKq9fQii+U+zyOSoBTf6CepZWb2
 K/uxriL5W5qIoaqqYjfR9kX9XZeALYhOYLzRJWtwVZkELPJMe42mKBJvYe5HyXDb0SxQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sTA4xpv4vJB1xbyz+G5aCWI0ViRS/VyPu6J6v34nvxw=; b=akGJ3OEdzQHFxsQz5J1ZBQBxp8
 hY+Hc06y3dfHyMAUt5DnUXcjW/3f7V89lfl6GcCrVWqTX4PB3PxIO2WnFrSZplnneb4UBFfp3MRz+
 O914Hiictas40Yd3mmpzdrQyV2GCgb3ghodLgv13l0eDg+87LkO8nfXa4mXGEc+dFMYs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t5jRH-0005zX-Au for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 10:27:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E478E5C5C5B;
 Tue, 29 Oct 2024 10:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12829C4CEE5;
 Tue, 29 Oct 2024 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730197612;
 bh=uhspLuIwFPfx6QENhvvgKhq9bsNMkOhFAw8IZSRMdqk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LDF8uIv149FAGVd5hpoVVtG2HrUGKJ8IYGi85LRMC5y6xn51dNvSTQ7Ih4pQnaHko
 nxfCmHau1T7mM+hFZE4h2t+L8IoyeJT7TO8hKitD8XGz08D00AJrGvarULTay8hyiR
 nSSelkABiKXooXzoBfYoTigFBrSimqqNGGFzT8vYsgRmF8cL2kQasE6ku6S1S9f1Cb
 TgIwo2wKOxwNrdIJBCLoJoNH6uEKdLeX+NTT73Wx3hyHqFRjeCSUBaDVKt+cMR5eoI
 WY6zW8A8iUeB5t1WMrkZDu71XM/A/0RY1bvThaM4CEchvs1VJD5g+sex085AQmLD/h
 4rckYTcz4vZlg==
To: Zorro Lang <zlang@redhat.com>
Date: Tue, 29 Oct 2024 18:26:44 +0800
Message-Id: <20241029102644.4027606-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241029102644.4027606-1-chao@kernel.org>
References: <20241029102644.4027606-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1t5jRH-0005zX-Au
Subject: [f2fs-dev] [PATCH v4 2/2] f2fs/007: add testcase to check
 consistency of compressed inode metadata
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Qi Han <hanqi@vivo.com>,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

metadata of compressed inode should always be consistent after file
compression, reservation, releasement and decompression, let's add
a testcase to check it.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Qi Han <hanqi@vivo.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- fix typo
- add rvb tag from Zorro
 tests/f2fs/007     | 108 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/007.out |  16 +++++++
 2 files changed, 124 insertions(+)
 create mode 100755 tests/f2fs/007
 create mode 100644 tests/f2fs/007.out

diff --git a/tests/f2fs/007 b/tests/f2fs/007
new file mode 100755
index 00000000..6451d4b4
--- /dev/null
+++ b/tests/f2fs/007
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/007
+#
+# This is a regression test to check whether compressed metadata
+# can become inconsistent after file compression, reservation
+# releasement, and decompression.
+#
+. ./common/preamble
+_begin_fstest auto quick rw compress
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+        "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
+
+_require_scratch
+testfile_prefix=$SCRATCH_MNT/testfile
+fio_config=$tmp.fio
+
+cat >$fio_config <<EOF
+[write_compressed_data_30]
+name=mytest
+ioengine=psync
+rw=write
+direct=0
+bs=1M
+filesize=1M
+numjobs=1
+filename=${testfile_prefix}30
+buffer_compress_percentage=30
+
+[write_compressed_data_60]
+name=mytest
+ioengine=psync
+rw=write
+direct=0
+bs=1M
+filesize=1M
+numjobs=1
+filename=${testfile_prefix}60
+buffer_compress_percentage=60
+
+[write_compressed_data_90]
+name=mytest
+ioengine=psync
+rw=write
+direct=0
+bs=1M
+filesize=1M
+numjobs=1
+filename=${testfile_prefix}90
+buffer_compress_percentage=90
+EOF
+
+_require_fio $fio_config
+_scratch_mkfs "-f -O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
+_scratch_mount "-o compress_mode=user,compress_extension=*" >> $seqres.full
+
+echo -e "Run fio to initialize file w/ specified compress ratio" >> $seqres.full
+cat $fio_config >> $seqres.full
+$FIO_PROG $fio_config >> $seqres.full
+_scratch_unmount
+
+# force to repair if filesystem is corrupted
+export FSCK_OPTIONS="-f $FSCK_OPTIONS"
+
+for i in 30 60 90; do
+	testfile=$testfile_prefix$i
+
+	_scratch_mount "-o compress_mode=user" >> $seqres.full
+	$F2FS_IO_PROG compress $testfile >> $seqres.full
+	cblocks=`$F2FS_IO_PROG get_cblocks $testfile`
+	echo "compression ratio is: "$cblocks" / 256"
+
+	_scratch_unmount
+
+	# 1. check after compression
+	echo "check fs after compress"
+	_check_scratch_fs
+
+	_scratch_mount >> $seqres.full
+	$F2FS_IO_PROG release_cblocks $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 2. check after releasement
+	echo "check fs after release_cblocks"
+	_check_scratch_fs
+
+	_scratch_mount >> $seqres.full
+	$F2FS_IO_PROG reserve_cblocks $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 3. check after rservation
+	echo "check fs after reserve_cblocks"
+	_check_scratch_fs
+
+	_scratch_mount "-o compress_mode=user" >> $seqres.full
+	$F2FS_IO_PROG decompress $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 4. check after decompression
+	echo "check fs after decompress"
+	_check_scratch_fs
+done
+
+status=0
+exit
diff --git a/tests/f2fs/007.out b/tests/f2fs/007.out
new file mode 100644
index 00000000..a4b76300
--- /dev/null
+++ b/tests/f2fs/007.out
@@ -0,0 +1,16 @@
+QA output created by 007
+compression ratio is: 64 / 256
+check fs after compress
+check fs after release_cblocks
+check fs after reserve_cblocks
+check fs after decompress
+compression ratio is: 128 / 256
+check fs after compress
+check fs after release_cblocks
+check fs after reserve_cblocks
+check fs after decompress
+compression ratio is: 192 / 256
+check fs after compress
+check fs after release_cblocks
+check fs after reserve_cblocks
+check fs after decompress
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
