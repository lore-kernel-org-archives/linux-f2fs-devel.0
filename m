From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs: set BLKDISCARD by default
Date: Fri, 13 Jun 2014 17:49:45 +0900
Message-ID: <1402649385-80872-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1WvNBB-0001iq-OZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 08:49:45 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvNBA-0001mQ-0M for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 08:49:45 +0000
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

And let's show some debug info as well.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/Makefile.am         | 2 +-
 mkfs/f2fs_format_utils.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 68cab66..ff136a7 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -1,7 +1,7 @@
 ## Makefile.am
 
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
-AM_CFLAGS = -Wall
+AM_CFLAGS = -Wall -DBLKDISCARD
 sbin_PROGRAMS = mkfs.f2fs
 mkfs_f2fs_SOURCES = f2fs_format_main.c f2fs_format.c f2fs_format_utils.c
 mkfs_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index 5cc2a32..8f7e094 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -36,8 +36,12 @@ int f2fs_trim_device()
 	if (S_ISREG(stat_buf.st_mode))
 		return 0;
 	else if (S_ISBLK(stat_buf.st_mode)) {
-		if (ioctl(config.fd, BLKDISCARD, &range) < 0)
+		if (ioctl(config.fd, BLKDISCARD, &range) < 0) {
 			MSG(0, "Info: This device doesn't support TRIM\n");
+		} else {
+			MSG(0, "Info: Discarded %lu sectors\n",
+						config.total_sectors);
+		}
 	} else
 		return -1;
 #endif
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
