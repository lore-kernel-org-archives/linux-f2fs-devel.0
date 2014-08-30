From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 17/17] fsck.f2fs: remove list.h
Date: Fri, 29 Aug 2014 17:29:04 -0700
Message-ID: <1409358544-54740-17-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWYT-0007Nh-IC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:30:09 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWYS-0001mI-QM for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:30:09 +0000
In-Reply-To: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
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

Just use list_head only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index f674ede..edb1480 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -26,7 +26,6 @@
 #include <sys/mount.h>
 #include <assert.h>
 
-#include <list.h>
 #include <f2fs_fs.h>
 
 #define EXIT_ERR_CODE		(-1)
@@ -34,6 +33,10 @@
 		typecheck(unsigned long long, b) &&                     \
 		((long long)((a) - (b)) > 0))
 
+struct list_head {
+	struct list_head *next, *prev;
+};
+
 enum {
 	NAT_BITMAP,
 	SIT_BITMAP
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
