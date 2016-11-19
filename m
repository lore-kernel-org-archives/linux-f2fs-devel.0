From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2] fsck.f2fs add a simple check orphan inodes
	in -p 1 mode
Date: Sat, 19 Nov 2016 21:24:40 +0800
Message-ID: <20161119132441.417-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1c85X3-0006gg-Sp
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Nov 2016 13:18:13 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c85X1-0001Kz-0n
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Nov 2016 13:18:13 +0000
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

This patch add a simple check orphan inodes in -p 1 mode

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/fsck.c | 21 +++++++++++++++++++--
 fsck/fsck.h |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 0009ea4..fd28d94 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1494,7 +1494,7 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	return 0;
 }
 
-void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
+int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 {
 	u32 blk_cnt = 0;
 	block_t start_blk, orphan_blkaddr, i, j;
@@ -1503,7 +1503,7 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 	u32 entry_count;
 
 	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
-		return;
+		return 0;
 
 	start_blk = __start_cp_addr(sbi) + 1 + get_sb(cp_payload);
 	orphan_blkaddr = __start_sum_addr(sbi) - 1 - get_sb(cp_payload);
@@ -1524,7 +1524,18 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 		for (j = 0; j < entry_count; j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
 			DBG(1, "[%3d] ino [0x%x]\n", i, ino);
+			struct node_info ni;
 			blk_cnt = 1;
+
+			if (c.preen_mode == PREEN_MODE_1 && !c.fix_on) {
+				get_node_info(sbi, ino, &ni);
+				if (!IS_VALID_NID(sbi, ino) ||
+						!IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
+					return -EINVAL;
+
+				continue;
+			}
+
 			ret = fsck_chk_node_blk(sbi, NULL, ino, NULL,
 					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt,
 					NULL);
@@ -1547,6 +1558,8 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 	}
 	free(orphan_blk);
 	free(new_blk);
+
+	return 0;
 }
 
 int fsck_chk_meta(struct f2fs_sb_info *sbi)
@@ -1605,6 +1618,10 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
 		return -EINVAL;
 	}
 
+	/* 4. check orphan inode simply */
+	if (fsck_chk_orphan_node(sbi))
+		return -EINVAL;
+
 	if (fsck->nat_valid_inode_cnt != le32_to_cpu(cp->valid_inode_count)) {
 		ASSERT_MSG("valid inode does not match: nat_valid_inode_cnt %u,"
 				" valid_inode_count %u",
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 412e7b7..8785de8 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -109,7 +109,7 @@ enum seg_type {
 
 struct selabel_handle;
 
-extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
+extern int fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
 		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *,
 		struct child_info *);
-- 
2.10.1


------------------------------------------------------------------------------
