From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] common/rc: support f2fs for _scratch_mkfs_sized
Date: Fri,  4 Dec 2015 14:15:43 -0800
Message-ID: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
Return-path: <fstests-owner@vger.kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The mkfs.f2fs has an option to build a certain sized filesystem by giving
the number of sectors.

So, this patch adds to use that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/rc b/common/rc
index 4c2f42c..ef913b4 100644
--- a/common/rc
+++ b/common/rc
@@ -739,6 +739,10 @@ _scratch_mkfs_sized()
 	$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV \
 			   `expr $fssize / 1024`
 	;;
+    f2fs)
+	# mkfs.f2fs requires # of sectors as an input for the size
+	$MKFS_F2FS_PROG $MKFS_OPTIONS $SCRATCH_DEV `expr $fssize / 512`
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;
-- 
2.4.9 (Apple Git-60)
