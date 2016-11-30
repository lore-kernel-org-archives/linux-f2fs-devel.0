From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH v2] resize.f2fs: fix the number of moved ssa
	blocks in migrate_ssa
Date: Wed, 30 Nov 2016 11:23:42 +0800
Message-ID: <1480476222-16523-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1cBviH-0000Jt-EB
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Nov 2016 03:37:41 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cBviE-0002cn-W6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Nov 2016 03:37:41 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com

If the offset passed in migrate_ssa is not zero, it means that there're
offset segments of old main will disappear after migrating, then there're
offset blocks of old ssa should be invalidated and removed accordingly.
So, the number of moved ssa blocks should be: TOTAL_SEGS(sbi) - offset,
and the expanded summary, which is filled with zero_blocks, should start
from: new_sum_blkaddr + TOTAL_SEGS(sbi) - offset.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/resize.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index ba7bb88..3e8fdd8 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -207,30 +207,33 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
 	block_t old_sum_blkaddr = get_sb(ssa_blkaddr);
 	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
 	block_t end_sum_blkaddr = get_newsb(main_blkaddr);
+	block_t expand_sum_blkaddr = new_sum_blkaddr +
+					TOTAL_SEGS(sbi) - offset;
 	block_t blkaddr;
+	int ret;
 	void *zero_block = calloc(BLOCK_SZ, 1);
-
 	ASSERT(zero_block);
 
 	if (offset && new_sum_blkaddr < old_sum_blkaddr + offset) {
 		blkaddr = new_sum_blkaddr;
 		while (blkaddr < end_sum_blkaddr) {
-			if (blkaddr - new_sum_blkaddr < TOTAL_SEGS(sbi))
-				move_ssa(sbi, offset, blkaddr);
-			else
-				dev_write_block(zero_block, blkaddr);
-			offset++;
-			blkaddr++;
+			if (blkaddr < expand_sum_blkaddr)
+				move_ssa(sbi, offset++, blkaddr++);
+			else {
+				ret = dev_write_block(zero_block, blkaddr++);
+				ASSERT(ret >=0);
+			}
 		}
 	} else {
 		blkaddr = end_sum_blkaddr - 1;
 		offset = TOTAL_SEGS(sbi) - 1;
 		while (blkaddr >= new_sum_blkaddr) {
-			if (blkaddr >= TOTAL_SEGS(sbi) + new_sum_blkaddr)
-				dev_write_block(zero_block, blkaddr);
+			if (blkaddr >= expand_sum_blkaddr) {
+				ret = dev_write_block(zero_block, blkaddr--);
+				ASSERT(ret >=0);
+			}
 			else
-				move_ssa(sbi, offset--, blkaddr);
-			blkaddr--;
+				move_ssa(sbi, offset--, blkaddr--);
 		}
 	}
 
-- 
2.7.4


------------------------------------------------------------------------------
