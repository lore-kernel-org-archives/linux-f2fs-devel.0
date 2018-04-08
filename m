From: Zhikang Zhang <zhangzhikang1@huawei.com>
Subject: [PATCH] f2fs: check cur_valid_map_mir & raw_sit block
 count when flush sit entries
Date: Mon, 9 Apr 2018 04:28:41 +0800
Message-ID: <1523219321-10895-1-git-send-email-zhangzhikang1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhangzhikang1@huawei.com>) id 1f59bc-0004TH-7E
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 12:39:36 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f59bY-00AOJo-Ua
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 12:39:35 +0000
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

We should check valid_map_mir and block count to ensure
the flushed raw_sit is correct.

Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>
Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5854cc4..c2dc7da 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3380,6 +3380,11 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			int offset, sit_offset;
 
 			se = get_seg_entry(sbi, segno);
+#ifdef CONFIG_F2FS_CHECK_FS
+			if (memcmp(se->cur_valid_map, se->cur_valid_map_mir,
+						SIT_VBLOCK_MAP_SIZE))
+				f2fs_bug_on(sbi, 1);
+#endif
 
 			/* add discard candidates */
 			if (!(cpc->reason & CP_DISCARD)) {
@@ -3395,10 +3400,14 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 							cpu_to_le32(segno);
 				seg_info_to_raw_sit(se,
 					&sit_in_journal(journal, offset));
+				check_block_count(sbi, segno,
+					&sit_in_journal(journal, offset));
 			} else {
 				sit_offset = SIT_ENTRY_OFFSET(sit_i, segno);
 				seg_info_to_raw_sit(se,
 						&raw_sit->entries[sit_offset]);
+				check_block_count(sbi, segno,
+						&raw_sit->entries[sit_offset]);
 			}
 
 			__clear_bit(segno, bitmap);
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
