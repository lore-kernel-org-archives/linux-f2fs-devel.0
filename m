From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] dump.f2fs: check block is valid or not before
 dump block info
Date: Tue, 22 Aug 2017 18:51:49 +0800
Message-ID: <1503399109-32255-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <heyunlei@huawei.com>) id 1dk6zx-0004Ea-BW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Aug 2017 11:05:29 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dk6zt-0006yH-0b
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Aug 2017 11:05:29 +0000
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
Cc: heyunlei@huawei.com, morgan.wang@huawei.com

This patch add a block validate check in dump.f2fs

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/dump.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 22e2265..a33969c 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -507,6 +507,9 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 	int type;
 	struct f2fs_summary sum_entry;
 	struct node_info ni, ino_ni;
+	struct seg_entry * seg;
+	unsigned int segno;
+	u32 offset;
 	int ret = 0;
 
 	MSG(0, "\n== Dump data from block address ==\n\n");
@@ -538,6 +541,16 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 		return ret;
 	}
 
+	segno = GET_SEGNO(sbi, blk_addr);
+	offset = OFFSET_IN_SEG(sbi, blk_addr);
+	seg = get_seg_entry(sbi, segno);
+	if (f2fs_test_bit(offset, (const char *)seg->cur_valid_map)) {
+		MSG(0, "\nblk_addr: 0x%x is valid block\n", blk_addr);
+	} else {
+		MSG(0, "\nblk_addr: 0x%x is not valid block\n", blk_addr);
+		return ret;
+	}
+
 	type = get_sum_entry(sbi, blk_addr, &sum_entry);
 	nid = le32_to_cpu(sum_entry.nid);
 
@@ -545,8 +558,8 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 
 	DBG(1, "Note: blkaddr = main_blkaddr + segno * 512 + offset\n");
 	DBG(1, "Block_addr            [0x%x]\n", blk_addr);
-	DBG(1, " - Segno              [0x%x]\n", GET_SEGNO(sbi, blk_addr));
-	DBG(1, " - Offset             [0x%x]\n", OFFSET_IN_SEG(sbi, blk_addr));
+	DBG(1, " - Segno              [0x%x]\n", segno);
+	DBG(1, " - Offset             [0x%x]\n", offset);
 	DBG(1, "SUM.nid               [0x%x]\n", nid);
 	DBG(1, "SUM.type              [%s]\n", type >= 0 ?
 						seg_type_name[type] :
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
