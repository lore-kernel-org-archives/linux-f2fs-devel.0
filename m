From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] dump.f2fs: fix a wrong report for dump an {d, id,
 did}node
Date: Wed, 7 Mar 2018 10:41:20 +0800
Message-ID: <1520390480-20367-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1etPEE-001CYJ-NR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Mar 2018 02:54:54 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1etPEC-002iX3-4p
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Mar 2018 02:54:54 +0000
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
Cc: heyunlei@huawei.com

fix a wrong report for dump an {d,id,did}node like this:

[print_node_info: 283] Node ID [0x6820:26656] is direct node or indirect node.
[0]                     [0x 16b6684 : 23815812]
[1]                     [0x 16b6685 : 23815813]
[2]                     [0x 16b6686 : 23815814]
[3]                     [0x 16b6687 : 23815815]
[4]                     [0x 16b6688 : 23815816]
[5]                     [0x 16b6689 : 23815817]
[6]                     [0x 16b668a : 23815818]
[7]                     [0x 16b668b : 23815819]
[8]                     [0x 16b668c : 23815820]
[9]                     [0x 16b668d : 23815821]
[10]                    [0x 16b668e : 23815822]
Invalid (i)node block

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/dump.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 23e4f47..5abdd6d 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -475,6 +475,18 @@ dump:
 	}
 }
 
+static bool is_sit_bitmap_set(struct f2fs_sb_info *sbi, u32 blk_addr)
+{
+	struct seg_entry *se;
+	u32 offset;
+
+	se = get_seg_entry(sbi, GET_SEGNO(sbi, blk_addr));
+	offset = OFFSET_IN_SEG(sbi, blk_addr);
+
+	return f2fs_test_bit(offset,
+			(const char *)se->cur_valid_map) != 0;
+}
+
 void dump_node(struct f2fs_sb_info *sbi, nid_t nid, int force)
 {
 	struct node_info ni;
@@ -492,13 +504,14 @@ void dump_node(struct f2fs_sb_info *sbi, nid_t nid, int force)
 
 	if (ni.blk_addr == 0x0)
 		MSG(force, "Invalid nat entry\n\n");
+	else if (!is_sit_bitmap_set(sbi, ni.blk_addr))
+		MSG(force, "Invalid node blk addr\n\n");
 
 	DBG(1, "node_blk.footer.ino [0x%x]\n", le32_to_cpu(node_blk->footer.ino));
 	DBG(1, "node_blk.footer.nid [0x%x]\n", le32_to_cpu(node_blk->footer.nid));
 
 	if (le32_to_cpu(node_blk->footer.ino) == ni.ino &&
-			le32_to_cpu(node_blk->footer.nid) == ni.nid &&
-			ni.ino == ni.nid) {
+			le32_to_cpu(node_blk->footer.nid) == ni.nid) {
 		print_node_info(sbi, node_blk, force);
 		dump_file(sbi, &ni, node_blk, force);
 	} else {
@@ -678,8 +691,6 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 	int type;
 	struct f2fs_summary sum_entry;
 	struct node_info ni, ino_ni;
-	struct seg_entry *se;
-	u32 offset;
 	int enc_name;
 	int ret = 0;
 
@@ -712,12 +723,8 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 		return ret;
 	}
 
-	se = get_seg_entry(sbi, GET_SEGNO(sbi, blk_addr));
-	offset = OFFSET_IN_SEG(sbi, blk_addr);
-
-	if (f2fs_test_bit(offset, (const char *)se->cur_valid_map) == 0) {
+	if (!is_sit_bitmap_set(sbi, blk_addr))
 		MSG(0, "\nblkaddr is not valid\n");
-	}
 
 	type = get_sum_entry(sbi, blk_addr, &sum_entry);
 	nid = le32_to_cpu(sum_entry.nid);
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
