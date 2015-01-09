From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2 v2] xfs/087: test f2fs selectively
Date: Thu,  8 Jan 2015 18:08:37 -0800
Message-ID: <1420769318-81382-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y9P0N-0001p8-W7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Jan 2015 02:08:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y9P0M-0003Md-73 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Jan 2015 02:08:51 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dave Chinner <david@fromorbit.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch add the f2fs support for xfs/087 with goingdown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/xfs/087 | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tests/xfs/087 b/tests/xfs/087
index 3a3fb49..9dc81c7 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -54,13 +54,16 @@ _do_meta()
 }
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs xfs f2fs
 _supported_os IRIX Linux
 
 rm -f $seqres.full $tmp.*
 _require_scratch
-_require_v2log 
-_require_xfs_quota
+
+if [ "$FSTYP" == "xfs" ]; then
+    _require_v2log
+    _require_xfs_quota
+fi
 
 echo "*** init FS"
 umount $SCRATCH_DEV >/dev/null 2>&1
@@ -87,12 +90,15 @@ do
     fi
 
     echo "--- mkfs=$mkfs, mnt=$mnt ---"
-    export MKFS_OPTIONS="-l $mkfs"
-    export MOUNT_OPTIONS="-o $mnt"
+
+    if [ "$FSTYP" == "xfs" ]; then
+        export MKFS_OPTIONS="-l $mkfs"
+        export MOUNT_OPTIONS="-o $mnt"
+    fi
 
     # mkfs the FS
     _echofull "mkfs"
-    _scratch_mkfs_xfs >>$seqres.full 2>&1
+    _scratch_mkfs >>$seqres.full 2>&1
     if [ $? -ne 0 ] ; then 
 	_echofull "mkfs failed: $MKFS_OPTIONS"
 	continue
@@ -100,7 +106,7 @@ do
 
     # mount the FS
     _echofull "mount"
-    if ! _scratch_mount -o uquota >>$seqres.full 2>&1; then
+    if ! _scratch_mount >>$seqres.full 2>&1; then
 	_echofull "mount failed: $MOUNT_OPTIONS"
 	continue
     fi
@@ -120,13 +126,19 @@ do
 	|| _fail "umount failed"
 
     _echofull "logprint after going down..."
-    _print_logstate
+    if [ "$FSTYP" == "xfs" ]; then
+        _print_logstate
+    else
+	echo "dirty log"
+    fi
 
     _full "logprint headers"
-    _scratch_xfs_logprint -n >>$seqres.full 2>&1
+    if [ "$FSTYP" == "xfs" ]; then
+        _scratch_xfs_logprint -n >>$seqres.full 2>&1
+    fi
 
     _echofull "mount with replay"
-    _scratch_mount -o uquota >>$seqres.full 2>&1 \
+    _scratch_mount >>$seqres.full 2>&1 \
 	|| _fail "mount failed: $MOUNT_OPTIONS"
 
     # check on what FS looks like after log recovery
@@ -140,7 +152,11 @@ do
     umount $SCRATCH_MNT
 
     _echofull "logprint after mount and replay..."
-    _print_logstate
+    if [ "$FSTYP" == "xfs" ]; then
+        _print_logstate
+    else
+	echo "clean log"
+    fi
 
     if _check_scratch_fs; then
 	_echofull "filesystem is checked ok"
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
