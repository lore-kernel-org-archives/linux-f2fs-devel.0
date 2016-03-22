From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: release 1.6.1
Date: Tue, 22 Mar 2016 14:09:03 -0700
Message-ID: <1458680943-15183-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aiTYP-0001pc-Ec
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Mar 2016 21:09:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aiTYO-00070M-At
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Mar 2016 21:09:29 +0000
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

This version mostly fixes the bugs in fsck.f2fs.
Especially, this fixes a segfault bug when executing "fsck.f2fs -a".

Note that, some body codes (not interfaces) in libf2fs_format.la and libf2fs.la
were changed.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 VERSION      | 4 ++--
 configure.ac | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/VERSION b/VERSION
index 8848f96..459e4f6 100644
--- a/VERSION
+++ b/VERSION
@@ -1,2 +1,2 @@
-1.6.0
-2015-12-21
+1.6.1
+2016-03-22
diff --git a/configure.ac b/configure.ac
index 280a0d3..1f6ff5a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -92,12 +92,12 @@ AC_CONFIG_FILES([
 
 # export library version info for mkfs/libf2fs_format_la
 AC_SUBST(FMT_CURRENT, 0)
-AC_SUBST(FMT_REVISION, 0)
+AC_SUBST(FMT_REVISION, 1)
 AC_SUBST(FMT_AGE, 0)
 
 # export library version info for lib/libf2fs_la
 AC_SUBST(LIBF2FS_CURRENT, 0)
-AC_SUBST(LIBF2FS_REVISION, 0)
+AC_SUBST(LIBF2FS_REVISION, 1)
 AC_SUBST(LIBF2FS_AGE, 0)
 
 AC_OUTPUT
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
