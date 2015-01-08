From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] src/godown: support f2fs triggering specific
	ioctl
Date: Thu,  8 Jan 2015 10:31:18 -0800
Message-ID: <1420741879-73691-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y9Hs6-0000LQ-SC
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Jan 2015 18:31:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y9Hs5-0004yF-9X for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Jan 2015 18:31:50 +0000
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

This patch triggers the F2FS-related ioctl for godown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 src/godown.c | 88 ++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 23 deletions(-)

diff --git a/src/godown.c b/src/godown.c
index b140a41..b44790b 100644
--- a/src/godown.c
+++ b/src/godown.c
@@ -19,33 +19,82 @@
 #include <syslog.h>
 #include "global.h"
 
+#define F2FS_IOCTL_MAGIC	0xf5
+#define F2FS_IOC_GOINGDOWN	_IO(F2FS_IOCTL_MAGIC, 6)
+
+enum ftypes {
+	XFS_FS,
+	F2FS_FS,
+};
+
 static char *xprogname;
+static char *mnt_dir;
+static int verbose_opt = 0;
+static int flushlog_opt = 0;
 
+static enum ftypes fs = XFS_FS;
 
 static void
 usage(void)
 {
-	fprintf(stderr, "usage: %s [-f] [-v] mnt-dir\n", xprogname);
+	fprintf(stderr, "usage: %s [-f] [-v] [-s 0/1] mnt-dir\n", xprogname);
+}
+
+static int
+xfs_goingdown(int fd)
+{
+	int flag;
+
+	flag = (flushlog_opt ? XFS_FSOP_GOING_FLAGS_LOGFLUSH
+			    : XFS_FSOP_GOING_FLAGS_NOLOGFLUSH);
+	if (verbose_opt) {
+		printf("Calling XFS_IOC_GOINGDOWN\n");
+	}
+
+	syslog(LOG_WARNING, "xfstests-induced forced shutdown of %s:\n",
+			mnt_dir);
+	if ((xfsctl(mnt_dir, fd, XFS_IOC_GOINGDOWN, &flag)) == -1) {
+		fprintf(stderr, "%s: error on xfsctl(GOINGDOWN) of \"%s\": %s\n",
+				xprogname, mnt_dir, strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+static int
+f2fs_goingdown(int fd)
+{
+	if (verbose_opt) {
+		printf("Calling F2FS_IOC_GOINGDOWN\n");
+	}
+	syslog(LOG_WARNING, "xfstests-induced forced shutdown of %s:\n",
+			mnt_dir);
+	if ((ioctl(fd, F2FS_IOC_GOINGDOWN)) == -1) {
+		fprintf(stderr, "%s: error on ioctl(GOINGDOWN) of \"%s\": %s\n",
+				xprogname, mnt_dir, strerror(errno));
+		return 1;
+	}
+	return 0;
+
 }
 
 int
 main(int argc, char *argv[])
 {
-	int c;
-	int flag;
-	int flushlog_opt = 0;
-	int verbose_opt = 0;
+	int c, fd;
 	struct stat st;
-	char *mnt_dir;
-	int fd;
+	int ret = 0;
 
       	xprogname = argv[0];
 
-	while ((c = getopt(argc, argv, "fv")) != -1) {
+	while ((c = getopt(argc, argv, "fs:v")) != -1) {
 		switch (c) {
 		case 'f':
 			flushlog_opt = 1;
 			break;
+		case 's':
+			fs = atoi(optarg);
+			break;
 		case 'v':
 			verbose_opt = 1;
 			break;
@@ -94,10 +143,6 @@ main(int argc, char *argv[])
 	}
 #endif
 
-
-	flag = (flushlog_opt ? XFS_FSOP_GOING_FLAGS_LOGFLUSH 
-			    : XFS_FSOP_GOING_FLAGS_NOLOGFLUSH);
-
 	if (verbose_opt) {
 		printf("Opening \"%s\"\n", mnt_dir);
 	}
@@ -107,18 +152,15 @@ main(int argc, char *argv[])
 		return 1;
 	}
 
-	if (verbose_opt) {
-		printf("Calling XFS_IOC_GOINGDOWN\n");
+	switch (fs) {
+	case XFS_FS:
+		ret = xfs_goingdown(fd);
+		break;
+	case F2FS_FS:
+		ret = f2fs_goingdown(fd);
+		break;
 	}
-	syslog(LOG_WARNING, "xfstests-induced forced shutdown of %s:\n",
-		mnt_dir);
-	if ((xfsctl(mnt_dir, fd, XFS_IOC_GOINGDOWN, &flag)) == -1) {
-		fprintf(stderr, "%s: error on xfsctl(GOINGDOWN) of \"%s\": %s\n",
-			xprogname, mnt_dir, strerror(errno));
-		return 1;
-	}
-
 	close(fd);
 
-	return 0;
+	return ret;
 }
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
