From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: missing kmem_cache_destroy for discard_entry
Date: Wed, 11 Dec 2013 14:32:13 +0900
Message-ID: <1386739933-20466-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

insmod f2fs.ko is failed after insmod and rmmod firstly.

$ sudo insmod fs/f2fs/f2fs.ko
insmod: error inserting 'fs/f2fs/f2fs.ko': -1 Cannot allocate memory

-- dmesg --
kmem_cache_sanity_check (free_nid): Cache name already exists.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/super.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dd55074..b35f371 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1135,6 +1135,7 @@ static void __exit exit_f2fs_fs(void)
 	unregister_filesystem(&f2fs_fs_type);
 	destroy_checkpoint_caches();
 	destroy_gc_caches();
+	destroy_segment_manager_caches();
 	destroy_node_manager_caches();
 	destroy_inodecache();
 	kset_unregister(f2fs_kset);
-- 
1.7.9.5

