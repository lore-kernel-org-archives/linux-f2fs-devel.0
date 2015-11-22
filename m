From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] fsck.f2fs: declare static function
Date: Sun, 22 Nov 2015 11:29:20 +0800
Message-ID: <1448162962-24175-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a0LLJ-0003yl-T7
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 03:29:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a0LLI-00048b-UO for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 03:29:33 +0000
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

This avoids the following warning.

mount.c:783:27: warning: SM_I is static but used in inline function
check_seg_range which is not static.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 649940d..ae3065f 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -778,7 +778,7 @@ static void build_curseg(struct f2fs_sb_info *sbi)
 	restore_curseg_summaries(sbi);
 }
 
-inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
+static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	unsigned int end_segno = SM_I(sbi)->segment_count - 1;
 	ASSERT(segno <= end_segno);
-- 
2.4.9 (Apple Git-60)


------------------------------------------------------------------------------
