From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck: use free segments if free segments is
 enough
Date: Mon, 18 Dec 2017 20:17:24 +0800
Message-ID: <1513599444-14694-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eQuZV-0004D7-1B
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Dec 2017 12:31:05 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eQuZT-0005aP-MS
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Dec 2017 12:31:04 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com

Use free segments if free segments is enough

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/mount.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 678eeae..3e25165 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1890,23 +1890,14 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 			continue;
 		}
 
-		if (se->valid_blocks == 0 && not_enough) {
-			*to = left ? START_BLOCK(sbi, segno) - 1:
+		if (se->valid_blocks == 0) {
+			if (not_enough) {
+				*to = left ? START_BLOCK(sbi, segno) - 1:
 						START_BLOCK(sbi, segno + 1);
-			continue;
-		}
-
-		if (se->valid_blocks == 0 && !(segno % sbi->segs_per_sec)) {
-			struct seg_entry *se2;
-			unsigned int i;
-
-			for (i = 1; i < sbi->segs_per_sec; i++) {
-				se2 = get_seg_entry(sbi, segno + i);
-				if (se2->valid_blocks)
-					break;
-			}
-			if (i == sbi->segs_per_sec)
+				continue;
+			} else {
 				return 0;
+			}
 		}
 
 		if (se->type == type &&
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
