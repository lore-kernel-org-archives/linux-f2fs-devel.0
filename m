From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: should get a victim from retrials
Date: Mon, 21 Sep 2015 12:12:57 -0700
Message-ID: <1442862777-22537-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Ze6WI-0007vN-GH
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 19:12:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ze6WH-0007g6-Ld for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 19:12:58 +0000
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

If we do not call get_victim first, we cannot get a new victim for retrial
path.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 782b8e7..e932740 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -823,7 +823,8 @@ gc_more:
 			write_checkpoint(sbi, &cpc);
 	}
 
-	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
+	/* should call __get_victim first to get a victim from retrial path */
+	if (!__get_victim(sbi, &segno, gc_type) && segno == NULL_SEGNO)
 		goto stop;
 	ret = 0;
 
-- 
2.1.1


------------------------------------------------------------------------------
