From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH] f2fs: fix max orphan inodes calculation
Date: Fri, 27 Feb 2015 15:05:04 +0800
Message-ID: <1425020704-10355-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

cp_payload is introduced for sit bitmap to support large volume, and it is 
just after the block of f2fs_checkpoint + nat bitmap, so the first segment 
should include F2FS_CP_PACKS + NR_CURSEG_TYPE + cp_payload + orphan blocks. 
However, current max orphan inodes calculation don't consider cp_payload, 
this patch fix it by reducing the number of cp_payload from total blocks of 
the first segment when calculate max orphan inodes.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index db82e09..3c9d677 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1109,7 +1109,7 @@ void init_ino_entry_info(struct f2fs_sb_info *sbi)
 	 * for cp pack we can have max 1020*504 orphan entries
 	 */
 	sbi->max_orphans = (sbi->blocks_per_seg - F2FS_CP_PACKS -
-			NR_CURSEG_TYPE) * F2FS_ORPHANS_PER_BLOCK;
+			NR_CURSEG_TYPE - __cp_payload(sbi)) * F2FS_ORPHANS_PER_BLOCK;
 }
 
 int __init create_checkpoint_caches(void)
-- 
1.9.1
