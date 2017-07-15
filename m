From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid cpu lockup
Date: Fri, 14 Jul 2017 18:22:45 -0700
Message-ID: <20170715012245.24640-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Before retrying to flush data or dentry pages, we need to release cpu in order
to prevent watchdog.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 56bbf592e487..c96913c56f6c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -909,8 +909,11 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 		 * wribacking dentry pages in the freeing inode.
 		 */
 		f2fs_submit_merged_write(sbi, DATA);
-		cond_resched();
 	}
+	/* We need to give a chance to get cpu for user file writers. */
+	if (!is_dir)
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
+	cond_resched();
 	goto retry;
 }
 
-- 
2.13.0.rc1.294.g07d810a77f-goog
