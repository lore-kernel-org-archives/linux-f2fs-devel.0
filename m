From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: update documents and a MAINTAINERS entry
Date: Thu, 09 Jan 2014 21:03:06 +0900
Message-ID: <1389268986-20014-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds missing some description of sysfs entries in
 - Documentation/ABI/testing/sysfs-fs-f2fs
 - Documentation/filesystems/f2fs.txt.

And it adds a maintained document entry of F2FS in MAINTAINERS.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 31 +++++++++++++++++++++++++++++++
 Documentation/filesystems/f2fs.txt      |  5 +++++
 MAINTAINERS                             |  1 +
 3 files changed, 37 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 31942ef..32b0809 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -24,3 +24,34 @@ Date:		July 2013
 Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
 Description:
 		 Controls the victim selection policy for garbage collection.
+
+What:		/sys/fs/f2fs/<disk>/reclaim_segments
+Date:		October 2013
+Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
+Description:
+		 Controls the issue rate of segment discard commands.
+
+What:		/sys/fs/f2fs/<disk>/ipu_policy
+Date:		November 2013
+Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
+Description:
+		 Controls the in-place-update policy.
+
+What:		/sys/fs/f2fs/<disk>/min_ipu_util
+Date:		November 2013
+Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
+Description:
+		 Controls the FS utilization condition for the in-place-update
+		 policies.
+
+What:		/sys/fs/f2fs/<disk>/max_small_discards
+Date:		November 2013
+Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
+Description:
+		 Controls the issue rate of small discard commands.
+
+What:		/sys/fs/f2fs/<disk>/max_victim_search
+Date:		January 2014
+Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
+Description:
+		 Controls the number of trials to find a victim segment.
diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 998e698..b8d2849 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -190,6 +190,11 @@ Files in /sys/fs/f2fs/<devname>
                               of the filesystem utilization, and used by
                               F2FS_IPU_UTIL and F2FS_IPU_SSR_UTIL policies.
 
+ max_victim_search	      This parameter controls the number of trials to
+			      find a victim segment when conducting SSR and
+			      cleaning operations. The default value is 4096
+			      which covers 8GB block address range.
+
 ================================================================================
 USAGE
 ================================================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index d5e4ff3..bd58e8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3629,6 +3629,7 @@ W:	http://en.wikipedia.org/wiki/F2FS
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 S:	Maintained
 F:	Documentation/filesystems/f2fs.txt
+F:	Documentation/ABI/testing/sysfs-fs-f2fs
 F:	fs/f2fs/
 F:	include/linux/f2fs_fs.h
 
-- 
1.8.4.474.g128a96c

