Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156CCE7718D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Dec 2024 14:35:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tPjWN-0006OC-Uv;
	Mon, 23 Dec 2024 14:35:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tPjWM-0006O4-HX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Dec 2024 14:34:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kMjqOKZfjU/FwjdUZWH3ppVmqw2y3LqXHesR/QzeTQU=; b=XDsTA3gFSP3FYhA/u2rX6CAYUN
 SnHSWziE8VEArWYTVpsCTzJNdZDeY9jZ8RMaSI+j3934fRld/LlhlmvUXH4LKm7naPPj/KmRuA9GR
 GjbhlRqOEACeTaQNKQAZF7kYNoktqN8+ECecen2heAzuxpdEVF49OcmgEQ2MljK5sdy0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kMjqOKZfjU/FwjdUZWH3ppVmqw2y3LqXHesR/QzeTQU=; b=V1gvGki0iG5sSJbxJOIg0kQlgC
 HeIssq8s+MT8tUhuVS9JDWVHPUsseDvK5Ty1vTCXXxHXlPBpj/mzK/0lumKZGNHEihbS85GpJK2sq
 wK3UZTpgWne49ZcNSM5OalPZTup9WJrYNfeuOYO8SZ8/7oezkPMuNJNhMostOHT7oOzE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tPjWM-0004CZ-IG for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Dec 2024 14:34:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6736C5C5938
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Dec 2024 14:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06BDC4CED6;
 Mon, 23 Dec 2024 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734964487;
 bh=VoExVT7XSETeqfLPoMzHOXZlM95/se/ZF/joAL/Vt28=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S1KYSWARLYFHMwTOj65ClztiCVzvCWL4Q+ugeAs0BK6ctDb28XWtHErG9rOgJ2wVT
 Wh5TCfVjIyMrqfHmSXJPApWhA5vQ7ZErYS9C1CyEgHQNjRx7gmRA82GLfeMPcD67nM
 XyqWg3T4rN/2e5z0K9Lgp8BOZOXW6ENIB3dEHiHl2DPCNTmsx3iTbYmDcwJJLpygSn
 w1kONiZUU8rc3goNVf0YgumE2Vi3wWoMwDmiawH4dqKQ9if5n4DblaLN47N5zieGH5
 3m7z8aE3yjNlUY9y34jlCHFdwXVWpvmdwT9daztsPJWAc1bh+cRgOylc6z4C1G2ar5
 O6Gg9s2RPGdhQ==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Sat, 21 Dec 2024 16:23:45 +0800
Message-Id: <20241221082345.196029-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241221082345.196029-1-chao@kernel.org>
References: <20241221082345.196029-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tPjWM-0004CZ-IG
Subject: [f2fs-dev] [PATCH v3 2/2] f2fs/008: test snapshot creation/deletion
 on lvm device
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

This patch introduce a regression testcase to check whether
f2fs can handle discard correctly once underlying lvm device
changes to not support discard after user creates snapshot
on it.

Related bug was fixed by commit bc8aeb04fd80 ("f2fs: fix to
drop all discards after creating snapshot on lvm device")

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- rebase to last for-next branch
- update according to Zorro's comments.
 tests/f2fs/008     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/008.out |  2 ++
 2 files changed, 59 insertions(+)
 create mode 100755 tests/f2fs/008
 create mode 100644 tests/f2fs/008.out

diff --git a/tests/f2fs/008 b/tests/f2fs/008
new file mode 100755
index 00000000..b85e321c
--- /dev/null
+++ b/tests/f2fs/008
@@ -0,0 +1,57 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/008
+#
+# This is a regression test to check whether f2fs can handle
+# discard correctly once underlying lvm device changes to not
+# support discard after user creates snapshot on it.
+#
+
+. ./common/preamble
+_begin_fstest auto quick rw
+
+_fixed_by_kernel_commit bc8aeb04fd80 \
+        "f2fs: fix to drop all discards after creating snapshot on lvm device"
+
+_require_scratch_nolvm
+_require_block_device $SCRATCH_DEV
+_require_command "$LVM_PROG" lvm
+
+lvname=lv_$seq
+vgname=vg_$seq
+testfile=$SCRATCH_MNT/testfile
+
+_cleanup()
+{
+	_unmount $SCRATCH_MNT >>$seqres.full 2>&1
+	$LVM_PROG lvremove -ff /dev/mapper/$lvname-snapshot $vgname >>$seqres.full 2>&1
+	$LVM_PROG lvremove -ff /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
+	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
+	_udev_wait --removed /dev/mapper/$vgname-$lvname
+	cd /
+	rm -f $tmp.*
+}
+
+$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
+$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
+$LVM_PROG lvcreate -L 1024m -n $lvname $vgname >>$seqres.full 2>&1
+_udev_wait /dev/mapper/$vgname-$lvname
+
+_mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+_mount -o discard /dev/mapper/$vgname-$lvname $SCRATCH_MNT >>$seqres.full 2>&1
+
+dd if=/dev/zero of=$testfile bs=1M count=20 >>$seqres.full 2>&1
+sync
+rm -f $testfile
+sync
+
+# create a snapshot on lvm device
+$LVM_PROG lvcreate -L 1024m -s -n $lvname-snapshot /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/008.out b/tests/f2fs/008.out
new file mode 100644
index 00000000..dd68d5a4
--- /dev/null
+++ b/tests/f2fs/008.out
@@ -0,0 +1,2 @@
+QA output created by 008
+Silence is golden
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
