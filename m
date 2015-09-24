From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: check sit types for node or data only
Date: Thu, 24 Sep 2015 09:55:49 -0700
Message-ID: <1443113749-40220-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zf9oN-00018q-9S
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 16:55:59 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zf9oM-0008OL-8m for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 16:55:59 +0000
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

Previously, check_sit_types didn't handle different numbers of active logs and
SSR cases. But, it didn't cause any problem since fixing sit types is harmless.
Nevertheless, we still don't need to change them all.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 70efce6..d3b5dd4 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -18,21 +18,19 @@ static inline int f2fs_set_main_bitmap(struct f2fs_sb_info *sbi, u32 blk,
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct seg_entry *se;
+	int fix = 0;
 
 	se = get_seg_entry(sbi, GET_SEGNO(sbi, blk));
-	if (se->type != type) {
-		if (type == CURSEG_WARM_DATA) {
-			if (se->type != CURSEG_COLD_DATA) {
-				DBG(1, "Wrong segment type [0x%x] %x -> %x",
-						GET_SEGNO(sbi, blk), se->type,
-						CURSEG_WARM_DATA);
-				se->type = CURSEG_WARM_DATA;
-			}
-		} else {
-			DBG(1, "Wrong segment type [0x%x] %x -> %x",
+	if (se->type < 0 || se->type >= NO_CHECK_TYPE)
+		fix = 1;
+	else if (IS_DATASEG(se->type) != IS_DATASEG(type))
+		fix = 1;
+
+	/* just check data and node types */
+	if (fix) {
+		DBG(1, "Wrong segment type [0x%x] %x -> %x",
 				GET_SEGNO(sbi, blk), se->type, type);
-			se->type = type;
-		}
+		se->type = type;
 	}
 	return f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, blk), fsck->main_area_bitmap);
 }
-- 
2.1.1


------------------------------------------------------------------------------
