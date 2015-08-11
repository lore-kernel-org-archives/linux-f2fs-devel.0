From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] mkfs.f2fs: fix wrong documentation
Date: Mon, 10 Aug 2015 18:23:46 -0700
Message-ID: <1439256228-8982-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZOyIQ-0001ci-DX
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 01:24:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZOyIP-0003ke-Hg for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 01:24:06 +0000
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

The -s should be the number of segments per a section.

Reported-by: Marc Lehmann <schmorp@schmorp.de>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 man/mkfs.f2fs.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index f386ac6..48654aa 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -21,7 +21,7 @@ mkfs.f2fs \- create an F2FS file system
 ]
 [
 .B \-s
-.I log-based-#-of-segments-per-section
+.I #-of-segments-per-section
 ]
 [
 .B \-z
@@ -60,10 +60,10 @@ Specify the volume label to the partition mounted as F2FS.
 Specify the percentage over the volume size for overprovision area. This area
 is hidden to users, and utilized by F2FS cleaner. The default percentage is 5%.
 .TP
-.BI \-s " log-based-#-of-segments-per-section"
-Specify the log-based number of segments per section. A section consists of
+.BI \-s " #-of-segments-per-section"
+Specify the number of segments per section. A section consists of
 multiple consecutive segments, and is the unit of garbage collection.
-The default number is 0, which means one segment is assigned to a section.
+The default number is 1, which means one segment is assigned to a section.
 .TP
 .BI \-z " #-of-sections-per-zone"
 Specify the number of sections per zone. A zone consists of multiple sections.
-- 
2.1.1


------------------------------------------------------------------------------
