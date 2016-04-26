From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] script: add simple test script
Date: Mon, 25 Apr 2016 17:28:38 -0700
Message-ID: <1461630518-16944-3-git-send-email-jaegeuk@kernel.org>
References: <1461630518-16944-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1auqs3-0004MM-9m
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:28:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auqs2-0008Qq-4f
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:28:55 +0000
In-Reply-To: <1461630518-16944-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds a script to test sload.f2fs, defrag.f2fs, and resize.f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 scripts/verify.sh | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100755 scripts/verify.sh

diff --git a/scripts/verify.sh b/scripts/verify.sh
new file mode 100755
index 0000000..8a22a2d
--- /dev/null
+++ b/scripts/verify.sh
@@ -0,0 +1,137 @@
+#!/bin/bash
+
+IMG=../test.img
+TMP=/tmp/res
+XFSTESTS=~/xfstests
+TESTS="4 5 8 11 16 25 32 55 64"
+
+TARGET=./testdir
+MNT=/mnt/resize
+
+mkdir $TARGET 2>/dev/null
+mkdir $MNT 2>/dev/null
+
+umount $TARGET
+umount $MNT
+
+_check_out()
+{
+	if [ $1 -ne 0 ]; then
+		grep ASSERT $TMP
+		echo FAIL RETURN $1
+		exit
+	fi
+}
+
+_get_sec()
+{
+	echo $(($1*1024*1024*1024/512))
+}
+
+_mkfs()
+{
+	echo "========== Initialize $1 GB ============"
+	mkfs.f2fs $IMG `_get_sec $1` | grep sectors
+}
+
+_mount()
+{
+	echo "========== mount to $1 ================="
+	mount -t f2fs -o loop,discard,inline_data,inline_xattr $IMG $1 2>&1
+	_check_out $?
+}
+
+_fsck()
+{
+	echo "========== fsck.f2fs ==================="
+	fsck.f2fs $IMG -t 2>&1 >$TMP
+	_check_out $?
+	grep FSCK $TMP
+}
+
+_fsstress()
+{
+	echo "========== fsstress $1 ================="
+	$XFSTESTS/ltp/fsstress -x "echo 3 > /proc/sys/vm/drop_caches && sleep 1" -X 1 -r -f fsync=8 -f sync=0 -f write=8 -f dwrite=2 -f truncate=6 -f allocsp=0 -f bulkstat=0 -f bulkstat1=0 -f freesp=0 -f zero=1 -f collapse=1 -f insert=1 -f resvsp=0 -f unresvsp=0 -S t -p 10 -n $2 -d $1 >/dev/null
+}
+
+_resize()
+{
+	echo "========== resize.f2fs $1 GB ==========="
+	resize.f2fs -t `_get_sec $1` $IMG 2>&1 >$TMP
+	_check_out $?
+	_fsck
+}
+
+_resize_tests()
+{
+	for i in $TESTS
+	do
+		if [ $i -ge $1 ]; then
+			_resize $i
+		fi
+	done
+}
+
+_sload()
+{
+	echo "========== sload $1 ===================="
+	sload.f2fs -f $1 $IMG 2>&1
+	_check_out $?
+}
+
+from_mount()
+{
+	echo ""
+	echo " ****  $1 GB to $2 GB with $3 *** "
+	_mkfs $1
+	_mount $3
+	_fsstress $3 10000
+	umount $3
+	_fsck
+	_resize_tests $2
+}
+
+from_sload()
+{
+	echo ""
+	echo " ****  $1 GB to $2 GB with $3 *** "
+
+	_mkfs $1
+	_sload $3
+	_fsck
+
+	_mount $MNT
+	_fsstress $MNT 10000
+	umount $MNT
+	_fsck
+
+	_resize_tests $2
+
+	_mount $MNT
+	_fsstress $MNT 10000
+	umount $MNT
+	_fsck
+}
+
+test_all()
+{
+	for i in $TESTS
+	do
+		for j in $TESTS
+		do
+			if [ $i -lt $j ]; then
+				$1 $i $j $2
+			fi
+		done
+	done
+}
+
+test_all from_sload ~/grub
+
+rm -rf $TARGET/*
+_fsstress $TARGET 5000
+test_all from_sload $TARGET
+rm -rf $TARGET 2>/dev/null
+
+test_all from_mount $MNT
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
