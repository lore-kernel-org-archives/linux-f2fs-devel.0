From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH] f2fs: fix recover orphan inodes
Date: Wed, 25 Feb 2015 12:53:37 +0800
Message-ID: <1424840017-97604-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

recover_orphan_inodes is used to recover orphan inodes, the meta pages 
which readahead should be orphan_blkaddr - start_blk instead of orphan_blkaddr.
This patch fix it.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/checkpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index e6c271f..0f42ff3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -468,9 +468,9 @@ void recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
 	orphan_blkaddr = __start_sum_addr(sbi) - 1;
 
-	ra_meta_pages(sbi, start_blk, orphan_blkaddr, META_CP);
+	ra_meta_pages(sbi, start_blk, orphan_blkaddr - start_blk, META_CP);
 
-	for (i = 0; i < orphan_blkaddr; i++) {
+	for (i = 0; i < orphan_blkaddr - start_blk; i++) {
 		struct page *page = get_meta_page(sbi, start_blk + i);
 		struct f2fs_orphan_block *orphan_blk;
 
-- 
1.9.1
