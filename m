From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add F2FS_GOING_DOWN_METAFLUSH to
 test power-failure
Date: Mon, 12 Oct 2015 13:37:11 -0700
Message-ID: <20151012203711.GA55804@jaegeuk-mac02.mot.com>
References: <1444350566-37795-1-git-send-email-jaegeuk@kernel.org>
 <020e01d104cc$af078480$0d168d80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <020e01d104cc$af078480$0d168d80$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Oct 12, 2015 at 05:01:29PM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Friday, October 09, 2015 8:29 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 1/2] f2fs: add F2FS_GOING_DOWN_METAFLUSH to test power-failure
> > 
> > This patch introduces F2FS_GOING_DOWN_METAFLUSH which flushes meta pages like
> > SSA blocks and then blocks all the writes.
> > This can be used by power-failure tests.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Good idea! I test power-failure case by changing src/godown to use new
> macro, until now, I didn't catch any consistent problem. :)
> 
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>

Yeah, I could reproduce the original issue with xfstests like below too.
(Added "-n" to issue METAFLUSH in godown.)

---
 tests/f2fs/002     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/002.out |  5 ++++
 tests/f2fs/group   |  1 +
 3 files changed, 91 insertions(+)
 create mode 100755 tests/f2fs/002
 create mode 100644 tests/f2fs/002.out

diff --git a/tests/f2fs/002 b/tests/f2fs/002
new file mode 100755
index 0000000..f3decbd
--- /dev/null
+++ b/tests/f2fs/002
@@ -0,0 +1,85 @@
+#! /bin/bash
+# FS QA Test No. f2fs/002
+#
+# This test detects a f2fs-specific issue which is resolved by:
+#    f2fs: fix SSA updates resulting in corruption
+# The purpose is to check whether filesystem metadata becomes inconsistent
+# after fcollapse was called.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Jaegeuk Kim.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/log
+. ./common/punch
+
+# real QA test starts here
+_supported_fs f2fs
+_supported_os Linux
+
+rm -f $seqres.full
+rm -f $tmp.log
+
+_require_scratch
+_require_scratch_shutdown
+_require_xfs_io_command "fcollapse"
+
+_scratch_mkfs > /dev/null 2>&1
+
+# collapse without sync
+_run_test()
+{
+	testfile=$SCRATCH_MNT/$1.$seq.$$
+
+	_scratch_mount
+
+	$XFS_IO_PROG -f -c "pwrite 0 5m" -c fsync $testfile > /dev/null
+	[ $1 -eq 1 ] && sync
+	$XFS_IO_PROG -c "fcollapse 64k 2m" $testfile > /dev/null
+
+	echo "godown"
+	src/godown -v -n $SCRATCH_MNT >> $seqres.full
+
+	echo "unmount"
+	umount $SCRATCH_MNT
+
+	# curious if FS consistent at start
+	_check_scratch_fs $SCRATCH_DEV
+	[ $? -ne 0 ] && _fatal "fsck failed"
+}
+
+# run without sync
+_run_test 0
+
+# run with sync
+_run_test 1
+
+status=0
+exit
diff --git a/tests/f2fs/002.out b/tests/f2fs/002.out
new file mode 100644
index 0000000..bbbf710
--- /dev/null
+++ b/tests/f2fs/002.out
@@ -0,0 +1,5 @@
+QA output created by 002
+godown
+unmount
+godown
+unmount
diff --git a/tests/f2fs/group b/tests/f2fs/group
index daba9a3..ff2305b 100644
--- a/tests/f2fs/group
+++ b/tests/f2fs/group
@@ -4,3 +4,4 @@
 # - comment line before each group is "new" description
 #
 001 auto quick rw
+002 auto quick rw
-- 
2.1.1
