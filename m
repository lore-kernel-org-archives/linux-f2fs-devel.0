From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] dump.f2fs: Test blkaddr is valid or not in
 option '-b'
Date: Thu, 4 Jan 2018 09:51:03 +0800
Message-ID: <1515030663-21518-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eWuu9-0004Ct-Tu
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 02:05:13 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWuu7-00061A-OS
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 02:05:13 +0000
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

Test blkaddr is valid or not in option '-b'

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/dump.c  | 9 +++++++++
 fsck/mount.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 9f0993e..7ccb03f 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -586,6 +586,8 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 	int type;
 	struct f2fs_summary sum_entry;
 	struct node_info ni, ino_ni;
+	struct seg_entry *se;
+	u32 offset;
 	int ret = 0;
 
 	MSG(0, "\n== Dump data from block address ==\n\n");
@@ -617,6 +619,13 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 		return ret;
 	}
 
+	se = get_seg_entry(sbi, GET_SEGNO(sbi, blk_addr));
+	offset = OFFSET_IN_SEG(sbi, blk_addr);
+
+	if (f2fs_test_bit(offset, (const char *)se->cur_valid_map) == 0) {
+		MSG(0, "\nblkaddr is not valid\n");
+	}
+
 	type = get_sum_entry(sbi, blk_addr, &sum_entry);
 	nid = le32_to_cpu(sum_entry.nid);
 
diff --git a/fsck/mount.c b/fsck/mount.c
index 678eeae..665fa4b 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1869,7 +1869,7 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct seg_entry *se;
 	u32 segno;
-	u64 offset;
+	u32 offset;
 	int not_enough = 0;
 	u64 end_blkaddr = (get_sb(segment_count_main) <<
 			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
