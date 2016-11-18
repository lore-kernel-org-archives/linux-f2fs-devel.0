From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3] generic/392: add a testcase to check some
 inline truncation behaviors
Date: Fri, 18 Nov 2016 11:36:51 -0800
Message-ID: <20161118193651.GC31226@jaegeuk>
References: <20161117034715.71966-1-jaegeuk@kernel.org>
	<20161117180436.GB74211@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c7oyB-0007ym-Ce
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Nov 2016 19:37:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c7oy6-0008Sy-0F
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Nov 2016 19:37:07 +0000
Content-Disposition: inline
In-Reply-To: <20161117180436.GB74211@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces a new testcase to test some small truncations to check
inline_data and its cached data are truncated correctly at the same time.

The inline_data feature was introduced in ext4 and f2fs as follows.
 ext4 : http://lwn.net/Articles/468678/
 f2fs : http://lwn.net/Articles/573408/

The basic idea is embedding small-sized file's data into relatively large
inode space.
In ext4, up to 132 bytes of data can be stored in 256 bytes-sized inode.
In f2fs, up to 3.4KB of data can be embedded into 4KB-sized inode block.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/generic/392     | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/392.out |  45 ++++++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 174 insertions(+)
 create mode 100644 tests/generic/392
 create mode 100644 tests/generic/392.out

diff --git a/tests/generic/392 b/tests/generic/392
new file mode 100644
index 0000000..3920076
--- /dev/null
+++ b/tests/generic/392
@@ -0,0 +1,128 @@
+#! /bin/bash
+# FS QA Test No. generic/392
+#
+# Test some small truncations to check inline_data and its cached data are
+# truncated correctly at the same time.
+#
+# The inline_data feature was introduced in ext4 and f2fs as follows.
+#  ext4 : http://lwn.net/Articles/468678/
+#  f2fs : http://lwn.net/Articles/573408/
+#
+# The basic idea is embedding small-sized file's data into relatively large
+# inode space.
+# In ext4, up to 132 bytes of data can be stored in 256 bytes-sized inode.
+# In f2fs, up to 3.4KB of data can be embedded into 4KB-sized inode block.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Jaegeuk Kim.  All Rights Reserved.
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
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_MNT/testfile
+OD_CMD="od -A x -t x1z"
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+# 1. make a file containing inline_data.
+# 2. "truncated 0"  is to check cached page #0 was truncated entirely.
+# 3. "truncated 50" is to check inline_data was truncated within its inode.
+$XFS_IO_PROG -t -f \
+	-c "pwrite -S 0x58 0 40" `# write    |XXXXXXXXXXXXXXXXXXXXXXXX|` \
+	-c "fsync"							 \
+	-c "truncate 0"          `# truncate |                        |` \
+	-c "truncate 50"         `# truncate |                        |` \
+$testfile | _filter_xfs_io
+
+echo "= truncate inline_data after #0 page was truncated entirely ="
+$OD_CMD $testfile
+_scratch_cycle_mount
+$OD_CMD $testfile
+rm $testfile
+
+# 1. make a file containing inline_data.
+# 2. "truncated 0"     is to check cached page #0 was truncated entirely.
+# 3. "truncated 4096"  is to check inline_data was dismissed and truncated.
+$XFS_IO_PROG -t -f \
+	-c "pwrite -S 0x58 0 40" `# write    |XXXXXXXXXXXXXXXXXXXXXXXX|` \
+	-c "fsync"							 \
+	-c "truncate 0"          `# truncate |                        |` \
+	-c "truncate 4096"       `# truncate |                        |` \
+$testfile | _filter_xfs_io
+
+echo "= truncate dismissed inline_data after #0 page was truncated entirely ="
+$OD_CMD $testfile
+_scratch_cycle_mount
+$OD_CMD $testfile
+rm $testfile
+
+# 1. make a file containing inline_data.
+# 2. "truncated 4"   is to check cached page #0 was truncated partially.
+# 3. "truncated 50"  is to check inline_data was truncated within its inode.
+$XFS_IO_PROG -t -f \
+	-c "pwrite -S 0x58 0 40" `# write    |XXXXXXXXXXXXXXXXXXXXXXXX|` \
+	-c "fsync"							 \
+	-c "truncate 4"          `# truncate |XXXX                    |` \
+	-c "truncate 50"         `# truncate |XXXX                    |` \
+$testfile | _filter_xfs_io
+
+echo "= truncate inline_data after #0 page was truncated partially ="
+$OD_CMD $testfile
+_scratch_cycle_mount
+$OD_CMD $testfile
+rm $testfile
+
+# 1. make a file containing inline_data.
+# 2. "truncated 4"     is to check cached page #0 was truncated partially.
+# 3. "truncated 4096"  is to check inline_data was dismissed and truncated.
+$XFS_IO_PROG -t -f \
+	-c "pwrite -S 0x58 0 40" `# write    |XXXXXXXXXXXXXXXXXXXXXXXX|` \
+	-c "fsync"							 \
+	-c "truncate 4"          `# truncate |XXXX                    |` \
+	-c "truncate 4096"       `# truncate |XXXX                    |` \
+$testfile | _filter_xfs_io
+
+echo "= truncate dismissed inline_data after #0 page was truncated partially ="
+$OD_CMD $testfile
+_scratch_cycle_mount
+$OD_CMD $testfile
+rm $testfile
+
+status=0
+exit
diff --git a/tests/generic/392.out b/tests/generic/392.out
new file mode 100644
index 0000000..2050cb5
--- /dev/null
+++ b/tests/generic/392.out
@@ -0,0 +1,45 @@
+QA output created by 392
+wrote 40/40 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+= truncate inline_data after #0 page was truncated entirely =
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+000030 00 00                                            >..<
+000032
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+000030 00 00                                            >..<
+000032
+wrote 40/40 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+= truncate dismissed inline_data after #0 page was truncated entirely =
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+001000
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+001000
+wrote 40/40 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+= truncate inline_data after #0 page was truncated partially =
+000000 58 58 58 58 00 00 00 00 00 00 00 00 00 00 00 00  >XXXX............<
+000010 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+000030 00 00                                            >..<
+000032
+000000 58 58 58 58 00 00 00 00 00 00 00 00 00 00 00 00  >XXXX............<
+000010 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+000030 00 00                                            >..<
+000032
+wrote 40/40 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+= truncate dismissed inline_data after #0 page was truncated partially =
+000000 58 58 58 58 00 00 00 00 00 00 00 00 00 00 00 00  >XXXX............<
+000010 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+001000
+000000 58 58 58 58 00 00 00 00 00 00 00 00 00 00 00 00  >XXXX............<
+000010 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+001000
diff --git a/tests/generic/group b/tests/generic/group
index 9de3415..1b19010 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -393,3 +393,4 @@
 388 auto log metadata
 389 auto quick acl
 391 auto quick metadata
+392 auto quick rw
-- 
2.8.3


------------------------------------------------------------------------------
