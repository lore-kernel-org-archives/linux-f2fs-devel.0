From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] man: add missing man pages
Date: Tue, 22 Dec 2015 17:00:28 -0800
Message-ID: <1450832429-29211-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBXnM-0007HC-Be
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 01:00:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBXnC-0005cq-9g for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 01:00:39 +0000
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

This patch adds missing man pages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 man/Makefile.am   |  2 +-
 man/defrag.f2fs.8 | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 man/dump.f2fs.8   | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 man/fsck.f2fs.8   | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 man/mkfs.f2fs.8   |  5 +++-
 5 files changed, 214 insertions(+), 2 deletions(-)
 create mode 100644 man/defrag.f2fs.8
 create mode 100644 man/dump.f2fs.8
 create mode 100644 man/fsck.f2fs.8

diff --git a/man/Makefile.am b/man/Makefile.am
index 477d654..256f3c3 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,3 +1,3 @@
 ## Makefile.am
 
-dist_man_MANS = mkfs.f2fs.8
+dist_man_MANS = mkfs.f2fs.8 fsck.f2fs.8 dump.f2fs.8 defrag.f2fs.8
diff --git a/man/defrag.f2fs.8 b/man/defrag.f2fs.8
new file mode 100644
index 0000000..e18e69f
--- /dev/null
+++ b/man/defrag.f2fs.8
@@ -0,0 +1,74 @@
+.\" Copyright (c) 2015 Jaegeuk Kim <jaegeuk@kernel.org>
+.\"
+.TH DEFRAG.F2FS 8
+.SH NAME
+defrag.f2fs \- relocate blocks in a given area to the specified region
+.SH SYNOPSIS
+.B defrag.f2fs
+[
+.B \-s
+.I start block address
+]
+[
+.B \-l
+.I number of blocks
+]
+[
+.B \-t
+.I target block address
+]
+[
+.B \-i
+.I direction
+]
+[
+.B \-d
+.I debugging-level
+]
+.I device
+.SH DESCRIPTION
+.B defrag.f2fs
+is used to move specified number of blocks starting from a given block address
+to the target block address with a direction.
+\fIdevice\fP is the special file corresponding to the device (e.g.
+\fI/dev/sdXX\fP).
+
+For example,
+# defrag.f2fs -s 0x4000 -l 0x100 -t 0x10000 -i /dev/sdb1
+
+This moves blocks between 0x4000 and 0x4100 to the left-hand area of 0x10000.
+
+.PP
+The exit code returned by
+.B defrag.f2fs
+is 0 on success and -1 on failure.
+.SH OPTIONS
+.TP
+.BI \-s " start block address"
+Specify the starting block address.
+.TP
+.BI \-l " number of blocks"
+Specifiy the number of blocks to move.
+.TP
+.BI \-t " target block address"
+Specify the destination block address.
+.TP
+.BI \-i " direction"
+Set the direction to left. If it is not set, the direction becomes right
+by default.
+.TP
+.BI \-d " debug-level"
+Specify the level of debugging options.
+The default number is 0, which shows basic debugging messages.
+.TP
+.SH AUTHOR
+This version of
+.B defrag.f2fs
+has been written by Jaegeuk Kim <jaegeuk@kernel.org>.
+.SH AVAILABILITY
+.B defrag.f2fs
+is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
+.SH SEE ALSO
+.BR mkfs.f2fs(8),
+.BR dump.f2fs(8),
+.BR fsck.f2fs(8).
diff --git a/man/dump.f2fs.8 b/man/dump.f2fs.8
new file mode 100644
index 0000000..ca5f511
--- /dev/null
+++ b/man/dump.f2fs.8
@@ -0,0 +1,68 @@
+.\" Copyright (c) 2013 Samsung Electronics Co., Ltd.
+.\"
+.TH DUMP.F2FS 8
+.SH NAME
+dump.f2fs \- retrieve directory and file entries from an F2FS-formated image
+.SH SYNOPSIS
+.B dump.f2fs
+[
+.B \-i
+.I inode number
+]
+[
+.B \-s
+.I SIT range
+]
+[
+.B \-a
+.I SSA range
+]
+[
+.B \-b
+.I block address
+]
+[
+.B \-d
+.I debugging-level
+]
+.I device
+.SH DESCRIPTION
+.B dump.f2fs
+is used to retrieve f2fs metadata (usually in a disk partition).
+\fIdevice\fP is the special file corresponding to the device (e.g.
+\fI/dev/sdXX\fP).
+
+Currently, it can retrieve 1) a file given its inode number, 2) SIT entries into
+a file, 3) SSA entries into a file, 4) reverse information from the given block
+address.
+.PP
+The exit code returned by
+.B dump.f2fs
+is 0 on success and -1 on failure.
+.SH OPTIONS
+.TP
+.BI \-i " inode number"
+Specify an inode number to dump out.
+.TP
+.BI \-s " SIT range"
+Specify a range presented by segment numbers to dump SIT entries.
+.TP
+.BI \-a " SSA range"
+Specify a range presented by segment numbers to dump SSA entries.
+.TP
+.BI \-b " block address"
+Specify a block address to retrieve its metadata information.
+.TP
+.BI \-d " debug-level"
+Specify the level of debugging options.
+The default number is 0, which shows basic debugging messages.
+.TP
+.SH AUTHOR
+Initial checking code was written by Byoung Geun Kim <bgbg.kim@samsung.com>.
+.SH AVAILABILITY
+.B dump.f2fs
+is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
+.SH SEE ALSO
+.BR mkfs.f2fs(8),
+.BR fsck.f2fs(8),
+.BR defrag.f2fs(8).
diff --git a/man/fsck.f2fs.8 b/man/fsck.f2fs.8
new file mode 100644
index 0000000..0ffe6e1
--- /dev/null
+++ b/man/fsck.f2fs.8
@@ -0,0 +1,67 @@
+.\" Copyright (c) 2013 Samsung Electronics Co., Ltd.
+.\"
+.TH FSCK.F2FS 8
+.SH NAME
+fsck.f2fs \- check a Linux F2FS file system
+.SH SYNOPSIS
+.B fsck.f2fs
+[
+.B \-a
+.I enable auto fix
+]
+[
+.B \-f
+.I enable force fix
+]
+[
+.B \-p
+.I enable preen mode
+]
+[
+.B \-t
+.I show stored directory tree
+]
+[
+.B \-d
+.I debugging-level
+]
+.I device
+.SH DESCRIPTION
+.B fsck.f2fs
+is used to check an f2fs file system (usually in a disk partition).
+\fIdevice\fP is the special file corresponding to the device (e.g.
+\fI/dev/sdXX\fP).
+.PP
+The exit code returned by
+.B fsck.f2fs
+is 0 on success and -1 on failure.
+.SH OPTIONS
+.TP
+.BI \-a " enable auto fix"
+Enable to run file system check only if a bug was reported by the F2FS kernel
+module. It is disabled by default.
+.TP
+.BI \-f " enable force fix"
+Enable to fix all the inconsistency in the partition.
+.TP
+.BI \-p " enable preen mode"
+Same as "-a" to support general fsck convention.
+.TP
+.BI \-t " show stored directory tree"
+Enable to show every directory entries in the partition.
+.TP
+.BI \-d " debug-level"
+Specify the level of debugging options.
+The default number is 0, which shows basic debugging messages.
+.TP
+.SH AUTHOR
+Initial checking code was written by Byoung Geun Kim <bgbg.kim@samsung.com>.
+Jaegeuk Kim <jaegeuk@kernel.org> reworked most parts of the codes to support
+fixing any corrupted images.
+.SH AVAILABILITY
+.B fsck.f2fs
+is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
+.SH SEE ALSO
+.BR mkfs.f2fs(8),
+.BR dump.f2fs(8),
+.BR defrag.f2fs(8).
diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index 29e0173..068c4c1 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -89,4 +89,7 @@ has been written by Jaegeuk Kim <jaegeuk.kim@samsung.com>.
 .B mkfs.f2fs
 is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
 .SH SEE ALSO
-.BR mkfs (8).
+.BR mkfs (8),
+.BR fsck.f2fs(8),
+.BR dump.f2fs(8),
+.BR defrag.f2fs(8).
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
