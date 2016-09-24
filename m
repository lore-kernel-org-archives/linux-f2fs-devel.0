From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck: porting avoid unneeded loop in
	build_sit_entries to fsck
Date: Sat, 24 Sep 2016 12:29:17 +0800
Message-ID: <1474691358-17191-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1bneVh-0006hW-B6
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 04:24:21 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bneVd-0008Oz-HD
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 04:24:21 +0000
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
Cc: heyunlei@huwei.com

This patch porting avoid unneeded loop in build_sit_entries to fsck

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/mount.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 3be60bb..f69a7af 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1277,24 +1277,27 @@ void build_sit_entries(struct f2fs_sb_info *sbi)
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct f2fs_journal *journal = &curseg->sum_blk->journal;
-	unsigned int segno;
+	struct seg_entry *se;
+	struct f2fs_sit_entry sit;
+	unsigned int i, segno;
 
 	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
-		struct seg_entry *se = &sit_i->sentries[segno];
+		se = &sit_i->sentries[segno];
 		struct f2fs_sit_block *sit_blk;
-		struct f2fs_sit_entry sit;
-		int i;
 
-		for (i = 0; i < sits_in_cursum(journal); i++) {
-			if (le32_to_cpu(segno_in_journal(journal, i)) == segno) {
-				sit = sit_in_journal(journal, i);
-				goto got_it;
-			}
-		}
 		sit_blk = get_current_sit_page(sbi, segno);
 		sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno)];
 		free(sit_blk);
-got_it:
+
+		check_block_count(sbi, segno, &sit);
+		seg_info_from_raw_sit(se, &sit);
+	}
+
+	for (i = 0; i < sits_in_cursum(journal); i++) {
+		segno = le32_to_cpu(segno_in_journal(journal, i));
+		se = &sit_i->sentries[segno];
+		sit = sit_in_journal(journal, i);
+
 		check_block_count(sbi, segno, &sit);
 		seg_info_from_raw_sit(se, &sit);
 	}
-- 
1.9.1


------------------------------------------------------------------------------
