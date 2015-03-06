From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH 1/2] f2fs: fix extent cache memory leak
Date: Fri,  6 Mar 2015 15:00:54 +0800
Message-ID: <1425625255-4204-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

extent tree/node slab cache is created during f2fs insmod,
how, it isn't destroyed during f2fs rmmod, this patch fix 
it by destroy extent tree/node slab cache once rmmod f2fs.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e649f21..0b8a2d8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1323,6 +1323,7 @@ static void __exit exit_f2fs_fs(void)
 	remove_proc_entry("fs/f2fs", NULL);
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
+	destroy_extent_cache();
 	destroy_checkpoint_caches();
 	destroy_segment_manager_caches();
 	destroy_node_manager_caches();
-- 
1.9.1
