From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: assign return value in f2fs_gc
Date: Wed, 21 Sep 2016 20:54:55 -0700
Message-ID: <20160922035458.5002-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bmv6y-0006pF-7V
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 03:55:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bmv6x-0005ZC-9q
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 03:55:48 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds a return value of write_checkpoint for f2fs_gc.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 24acbbb..400bc6d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -925,10 +925,14 @@ gc_more:
 		 */
 		if (__get_victim(sbi, &segno, gc_type) ||
 						prefree_segments(sbi)) {
-			write_checkpoint(sbi, &cpc);
+			ret = write_checkpoint(sbi, &cpc);
+			if (ret)
+				goto stop;
 			segno = NULL_SEGNO;
 		} else if (has_not_enough_free_secs(sbi, 0, 0)) {
-			write_checkpoint(sbi, &cpc);
+			ret = write_checkpoint(sbi, &cpc);
+			if (ret)
+				goto stop;
 		}
 	}
 
@@ -948,7 +952,7 @@ gc_more:
 			goto gc_more;
 
 		if (gc_type == FG_GC)
-			write_checkpoint(sbi, &cpc);
+			ret = write_checkpoint(sbi, &cpc);
 	}
 stop:
 	mutex_unlock(&sbi->gc_mutex);
-- 
2.8.3


------------------------------------------------------------------------------
