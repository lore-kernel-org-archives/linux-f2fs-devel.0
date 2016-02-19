From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH] fsck.f2fs: remove corrupted nid entry from
	indirect/double-indirect node
Date: Fri, 19 Feb 2016 17:14:58 +0000
Message-ID: <1455902098-10974-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1aWhR5-0002zE-UZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Feb 2016 09:33:15 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aWhR0-0007qZ-AJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Feb 2016 09:33:15 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao2.yu@samsung.com, linux-f2fs-devel@lists.sourceforge.net
Cc: chengyinchao@huawei.com

For indirect/double-indirect node, if the blk_addr in its nat entry is
corrupted, fsck could figure this out and nullify the nat entry. However,
the indirect/double-indirect node still keeps the corrupted nid. As a
result, fsck reports valid blkaddr but fixes nothing each time during
scanning all nodes, like:

=============================
[ASSERT] (sanity_check_nid: 356)  --> blkaddres is not valid. [0x0]
delete in.nid[i] = 0;
[ASSERT] (sanity_check_nid: 356)  --> blkaddres is not valid. [0x0]
delete in.nid[i] = 0;

[FSCK] Unreachable nat entries                        [Ok..] [0x0]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Ok..] [0xa51b]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x98]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x98]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x7b]
[FSCK] free segment_count matched with CP             [Ok..] [0x1a]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Fail]
=============================

So let's clean it.

Reported-by: Chen Yinchao <chengyinchao@huawei.com>
Signed-off-by: Liu Xue <liuxueliu.liu@huawei.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6451595..ca8ea15 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -834,7 +834,7 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt,
 		struct child_info *child, struct extent_info *i_ext)
 {
-	int ret;
+	int need_fix = 0, ret;
 	int i = 0;
 
 	for (i = 0 ; i < NIDS_PER_BLOCK; i++) {
@@ -846,9 +846,26 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 				i_ext);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
-		else if (ret == -EINVAL)
-			printf("delete in.nid[i] = 0;\n");
+		else if (ret == -EINVAL) {
+			if (!config.fix_on)
+				printf("should delete in.nid[i] = 0;\n");
+			else {
+				node_blk->in.nid[i] = 0;
+				need_fix = 1;
+				FIX_MSG("Set indirect node 0x%x -> 0\n", i);
+			}
+		}
+	}
+
+	if (need_fix && !config.ro) {
+		struct node_info ni;
+		nid_t nid = le32_to_cpu(node_blk->footer.nid);
+
+		get_node_info(sbi, nid, &ni);
+		ret = dev_write_block(node_blk, ni.blk_addr);
+		ASSERT(ret >= 0);
 	}
+
 	return 0;
 }
 
@@ -857,7 +874,7 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		struct child_info *child, struct extent_info *i_ext)
 {
 	int i = 0;
-	int ret = 0;
+	int need_fix = 0, ret = 0;
 
 	for (i = 0; i < NIDS_PER_BLOCK; i++) {
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
@@ -868,9 +885,26 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 				i_ext);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
-		else if (ret == -EINVAL)
-			printf("delete in.nid[i] = 0;\n");
+		else if (ret == -EINVAL) {
+			if (!config.fix_on)
+				printf("should delete in.nid[i] = 0;\n");
+			else {
+				node_blk->in.nid[i] = 0;
+				need_fix = 1;
+				FIX_MSG("Set double indirect node 0x%x -> 0\n", i);
+			}
+		}
 	}
+
+	if (need_fix && !config.ro) {
+		struct node_info ni;
+		nid_t nid = le32_to_cpu(node_blk->footer.nid);
+
+		get_node_info(sbi, nid, &ni);
+		ret = dev_write_block(node_blk, ni.blk_addr);
+		ASSERT(ret >= 0);
+	}
+
 	return 0;
 }
 
-- 
2.7.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
