From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: avoid wrong IS_VALID_BLK_ADDR
Date: Wed, 27 Dec 2017 18:21:51 -0800
Message-ID: <20171228022151.29522-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eUNpX-0003wu-1k
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Dec 2017 02:21:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eUNpW-0002IP-5B
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Dec 2017 02:21:58 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch avoids to check next free block offset in current segments, since we
are using IS_VALID_BLK_ADDR during fsck which is able to be valid for a while.
Let's just check this at the end of fsck.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 34b2481..b7b6305 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -369,21 +369,12 @@ static inline bool IS_VALID_NID(struct f2fs_sb_info *sbi, u32 nid)
 
 static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
 {
-	int i;
-
 	if (addr >= le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count) ||
 				addr < SM_I(sbi)->main_blkaddr) {
 		DBG(1, "block addr [0x%x]\n", addr);
 		return 0;
 	}
-
-	for (i = 0; i < NO_CHECK_TYPE; i++) {
-		struct curseg_info *curseg = CURSEG_I(sbi, i);
-
-		if (START_BLOCK(sbi, curseg->segno) +
-					curseg->next_blkoff == addr)
-			return 0;
-	}
+	/* next block offset will be checked at the end of fsck. */
 	return 1;
 }
 
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
