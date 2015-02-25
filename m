From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH 2/2] f2fs: fix the number of orphan inode blocks
Date: Thu, 26 Feb 2015 07:57:21 +0800
Message-ID: <1424908641-76409-2-git-send-email-wanpeng.li@linux.intel.com>
References: <1424908641-76409-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424908641-76409-1-git-send-email-wanpeng.li@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

cp_pack_start_sum is calculated in do_checkpoint and is equal to 
cpu_to_le32(1 + cp_payload_blks + orphan_blocks). The number of 
orphan inode blocks is take advantage of by recover_orphan_inodes 
to readahead meta pages and recovery inodes. However, current codes 
forget to reduce the number of cp payload blocks when calculate 
the number of orphan inode blocks. This patch fix it.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/checkpoint.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4dbcc81..db82e09 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -464,7 +464,7 @@ static void recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 
 void recover_orphan_inodes(struct f2fs_sb_info *sbi)
 {
-	block_t start_blk, orphan_blkaddr, i, j;
+	block_t start_blk, orphan_blocks, i, j;
 
 	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
 		return;
@@ -472,11 +472,11 @@ void recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_POR_DOING);
 
 	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
-	orphan_blkaddr = __start_sum_addr(sbi) - 1;
+	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
 
-	ra_meta_pages(sbi, start_blk, orphan_blkaddr, META_CP);
+	ra_meta_pages(sbi, start_blk, orphan_blocks, META_CP);
 
-	for (i = 0; i < orphan_blkaddr; i++) {
+	for (i = 0; i < orphan_blocks; i++) {
 		struct page *page = get_meta_page(sbi, start_blk + i);
 		struct f2fs_orphan_block *orphan_blk;
 
-- 
1.9.1
