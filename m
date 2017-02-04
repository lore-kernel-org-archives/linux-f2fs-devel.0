From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: release 1.8.0
Date: Fri,  3 Feb 2017 16:15:52 -0800
Message-ID: <20170204001552.13489-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cZo1O-0005mA-Dq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Feb 2017 00:16:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cZo1L-0000k4-So
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Feb 2017 00:16:06 +0000
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

This release includes:
 - enhance fsck.f2fs mostly.
 - retrieve lost files from dump.f2fs.
 - support zoned device and multiple devices.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 VERSION      | 4 ++--
 configure.ac | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/VERSION b/VERSION
index 9376c2d..c520af0 100644
--- a/VERSION
+++ b/VERSION
@@ -1,2 +1,2 @@
-1.7.0
-2016-07-28
+1.8.0
+2017-02-03
diff --git a/configure.ac b/configure.ac
index b855afe..6a3f7c4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -110,12 +110,12 @@ AC_CONFIG_FILES([
 ])
 
 # export library version info for mkfs/libf2fs_format_la
-AC_SUBST(FMT_CURRENT, 0)
-AC_SUBST(FMT_REVISION, 2)
+AC_SUBST(FMT_CURRENT, 1)
+AC_SUBST(FMT_REVISION, 0)
 AC_SUBST(FMT_AGE, 0)
 
 # export library version info for lib/libf2fs_la
-AC_SUBST(LIBF2FS_CURRENT, 1)
+AC_SUBST(LIBF2FS_CURRENT, 2)
 AC_SUBST(LIBF2FS_REVISION, 0)
 AC_SUBST(LIBF2FS_AGE, 0)
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
