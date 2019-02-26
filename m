From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] generic: test i_mode recovery after power failure
Date: Tue, 26 Feb 2019 15:03:02 +0800
Message-ID: <20190226070302.17756-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gyWm2-0008Lm-4L
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Feb 2019 07:03:30 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gyWlz-00GbWA-RH
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Feb 2019 07:03:30 +0000
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

After fsync, filesystem should guarantee inode metadata including
permission info being persisted, so even after sudden power-cut,
during mount, we should recover i_mode fields correctly, in order
to not loss those meta info.

So adding this testcase to check whether generic filesystem can
guarantee that.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 tests/generic/532     | 106 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/532.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 109 insertions(+)
 create mode 100755 tests/generic/532
 create mode 100644 tests/generic/532.out

diff --git a/tests/generic/532 b/tests/generic/532
new file mode 100755
index 000000000000..d89f7ab09fcf
--- /dev/null
+++ b/tests/generic/532
@@ -0,0 +1,106 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei.  All Rights Reserved.
+#
+# FS QA Test 532
+#
+# This testcase is trying to test recovery flow of generic filesystem,
+# w/ below steps, once i_mode changes, after we fsync that file, we can
+# expect that i_mode can be recovered after sudden power-cuts.
+# 1. touch testfile or mkdir testdir
+# 2. chmod 777 testfile/testdir
+# 3. sync
+# 4. chmod 755 testfile/testdir
+# 5. fsync testfile/testdir
+# 6. record last i_mode
+# 7. godown
+# 8. umount
+# 9. mount
+# 10. check i_mode
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
+_require_scratch
+_require_scratch_shutdown
+
+_scratch_mkfs >/dev/null 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+
+testfile=$SCRATCH_MNT/testfile
+testdir=$SCRATCH_MNT/testdir
+
+do_check()
+{
+	target=$1
+	is_dir=$2
+
+	_scratch_mount
+
+	if [ $is_dir = 1 ]; then
+		mkdir $target
+	else
+		touch $target
+	fi
+
+	echo "Test chmod $target" >> $seqres.full
+
+	chmod 777 $target
+	sync
+
+	chmod 755 $target
+	$XFS_IO_PROG $target -c "fsync" | _filter_xfs_io
+
+	before=`stat -c %a $target`
+
+	_scratch_shutdown | tee -a $seqres.full
+	_scratch_cycle_mount
+
+	after=`stat -c %a $target`
+
+	# check inode's i_mode
+	if [ "$before" != "$after" ]; then
+		echo "Before: $before"
+		echo "After : $after"
+	fi
+	echo "Before: $before" >> $seqres.full
+	echo "After : $after" >> $seqres.full
+
+	if [ $is_dir = 1 ]; then
+		rmdir $target
+	else
+		rm -f $target
+	fi
+	_scratch_unmount
+}
+
+echo "Silence is golden"
+
+do_check $testfile 0
+do_check $testdir 1
+
+status=0
+exit
diff --git a/tests/generic/532.out b/tests/generic/532.out
new file mode 100644
index 000000000000..1f7d4677c3be
--- /dev/null
+++ b/tests/generic/532.out
@@ -0,0 +1,2 @@
+QA output created by 532
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 31011ac872c2..2fc50fbbfb5c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -534,3 +534,4 @@
 529 auto quick attr
 530 auto quick unlink
 531 auto quick unlink
+532 shutdown auto quick metadata
-- 
2.18.0.rc1
