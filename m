From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 2/3] f2fs: simplify __allocate_data_blocks
Date: Tue, 26 Jan 2016 15:38:29 +0800
Message-ID: <009301d1580c$ae03ee00$0a0bca00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch uses existing function f2fs_map_block to simplify implementation
of __allocate_data_blocks.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---

 V2:
 - rebase on last dev-test.

 fs/f2fs/data.c | 60 ++++------------------------------------------------------
 1 file changed, 4 insertions(+), 56 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f570d37..2f8ecfe 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -537,64 +537,12 @@ alloc:
 static int __allocate_data_blocks(struct inode *inode, loff_t offset,
 							size_t count)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct dnode_of_data dn;
-	u64 start = F2FS_BYTES_TO_BLK(offset);
-	u64 len = F2FS_BYTES_TO_BLK(count);
-	bool allocated = false;
-	u64 end_offset;
-	int err = 0;
-
-	while (len) {
-		f2fs_lock_op(sbi);
-
-		/* When reading holes, we need its node page */
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = get_dnode_of_data(&dn, start, ALLOC_NODE);
-		if (err)
-			goto out;
-
-		allocated = false;
-		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
-
-		while (dn.ofs_in_node < end_offset && len) {
-			block_t blkaddr;
-
-			if (unlikely(f2fs_cp_error(sbi))) {
-				err = -EIO;
-				goto sync_out;
-			}
-
-			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
-			if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR) {
-				err = __allocate_data_block(&dn);
-				if (err)
-					goto sync_out;
-				allocated = true;
-			}
-			len--;
-			start++;
-			dn.ofs_in_node++;
-		}
-
-		if (allocated)
-			sync_inode_page(&dn);
-
-		f2fs_put_dnode(&dn);
-		f2fs_unlock_op(sbi);
+	struct f2fs_map_blocks map;
 
-		f2fs_balance_fs(sbi, allocated);
-	}
-	return err;
+	map.m_lblk = F2FS_BYTES_TO_BLK(offset);
+	map.m_len = F2FS_BYTES_TO_BLK(count);
 
-sync_out:
-	if (allocated)
-		sync_inode_page(&dn);
-	f2fs_put_dnode(&dn);
-out:
-	f2fs_unlock_op(sbi);
-	f2fs_balance_fs(sbi, allocated);
-	return err;
+	return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_DIO);
 }
 
 /*
-- 
2.7.0.2.g1b0b6dd
