From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/3] generic: test creation time recovery
 after power failure
Date: Sun,  7 Oct 2018 20:25:48 +0800
Message-ID: <20181007122548.21876-3-chao@kernel.org>
References: <20181007122548.21876-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1g9AUF-0006Ip-E8
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Oct 2018 14:56:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g9AUB-00DuAq-N4
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Oct 2018 14:56:51 +0000
In-Reply-To: <20181007122548.21876-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

After fsync, filesystem should guarantee inode metadata including
creation time being persisted, so even after sudden power-cut, during
mount, we should recover i_crtime_{,nsec} fields correctly, in order
to not loss those meta info.

So adding this testcase to check whether generic filesystem can
guarantee that.

Note that, it needs inode creation time support on specified filesystem.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- remove unneeded './common/quota"
- add missing _require_statx
- add a helper _require_btime to check inode creation time support.
- fix wrong comments
- use -f parameter for rm
 common/rc             | 11 +++++
 tests/generic/508     | 96 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/508.out |  2 +
 tests/generic/group   |  1 +
 4 files changed, 110 insertions(+)
 create mode 100755 tests/generic/508
 create mode 100644 tests/generic/508.out

diff --git a/common/rc b/common/rc
index c8cccb38..6ab5b066 100644
--- a/common/rc
+++ b/common/rc
@@ -3835,6 +3835,17 @@ _dmsetup_create()
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
 }
 
+_require_btime()
+{
+	local mnt_point=${!#}
+	_get_mount $*
+	$XFS_IO_PROG -f $mnt_point/test_creation_time -c "statx -v" \
+		| grep btime >>$seqres.full 2>&1 || \
+		_notrun "inode creation time not supported by this filesystem"
+	rm -f $mnt_point/test_creation_time
+	_put_mount
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/508 b/tests/generic/508
new file mode 100755
index 00000000..9d6ec9f6
--- /dev/null
+++ b/tests/generic/508
@@ -0,0 +1,96 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Huawei.  All Rights Reserved.
+#
+# FS QA Test 508
+#
+# This testcase is trying to test recovery flow of generic filesystem, it needs
+# creation time support on specified filesystem.
+# With below steps, once the file is created, creation time attribute should be
+# valid on the file, after we fsync that file, it expects creation time can be
+# recovered after sudden power-cuts.
+# 1. touch testfile;
+# 1.1 sync (optional)
+# 2. xfs_io -f testfile -c "fsync";
+# 3. godown;
+# 4. umount;
+# 5. mount;
+# 6. check creation time
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_test_lsattr
+_require_statx
+_require_xfs_io_command "statx" "-v"
+
+_require_scratch
+_require_scratch_shutdown
+_require_btime $SCRATCH_DEV $SCRATCH_MNT
+
+_scratch_mkfs >/dev/null 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+
+testfile=$SCRATCH_MNT/testfile
+
+do_check()
+{
+	_scratch_mount
+
+	touch $testfile
+
+	if [ "$1" == "sync" ]; then
+		sync
+	fi
+
+	before=`$XFS_IO_PROG -f $testfile -c "statx -v" | grep btime`
+
+	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
+
+	_scratch_shutdown | tee -a $seqres.full
+	_scratch_cycle_mount
+
+	after=`$XFS_IO_PROG -f $testfile -c "statx -v" | grep btime`
+
+	# check inode's creation time
+	if [ "$before" != "$after" ]; then
+		echo "Before: $before"
+		echo "After : $after"
+	fi
+	echo "Before: $before" >> $seqres.full
+	echo "After : $after" >> $seqres.full
+
+	rm -f $testfile
+	_scratch_unmount
+}
+
+echo "Silence is golden"
+
+do_check
+do_check sync
+
+status=0
+exit
diff --git a/tests/generic/508.out b/tests/generic/508.out
new file mode 100644
index 00000000..a5ceec05
--- /dev/null
+++ b/tests/generic/508.out
@@ -0,0 +1,2 @@
+QA output created by 508
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index e94253dc..8f26ee6a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -510,3 +510,4 @@
 505 shutdown auto quick metadata
 506 shutdown auto quick metadata quota
 507 shutdown auto quick metadata
+508 shutdown auto quick metadata
-- 
2.18.0
