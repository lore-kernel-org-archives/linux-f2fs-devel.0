From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: introduce {create,
 destroy}_discard_caches for cleanup
Date: Wed, 25 Apr 2018 17:38:30 +0800
Message-ID: <20180425093831.124591-2-yuchao0@huawei.com>
References: <20180425093831.124591-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fBGt9-0003Yw-Lt
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 09:38:59 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBGt7-006gQe-4t
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 09:38:59 +0000
In-Reply-To: <20180425093831.124591-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Split discard slab cache related initial/release codes into separated
function {create,destroy}_discard_caches, later we can maintain those
independent functions in separated discard.c

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c | 24 ++++++++++++++++--------
 fs/f2fs/super.c   |  8 +++++++-
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9416669b7105..c8d6d27384f1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2856,6 +2856,8 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int build_segment_manager(struct f2fs_sb_info *sbi);
 void destroy_segment_manager(struct f2fs_sb_info *sbi);
+int __init create_discard_caches(void);
+void destroy_discard_caches(void);
 int __init create_segment_manager_caches(void);
 void destroy_segment_manager_caches(void);
 int rw_hint_to_seg_type(enum rw_hint hint);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d5627195aa8e..187f957747be 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3993,7 +3993,7 @@ void destroy_segment_manager(struct f2fs_sb_info *sbi)
 	kfree(sm_info);
 }
 
-int __init create_segment_manager_caches(void)
+int __init create_discard_caches(void)
 {
 	discard_entry_slab = f2fs_kmem_cache_create("discard_entry",
 			sizeof(struct discard_entry));
@@ -4004,11 +4004,25 @@ int __init create_segment_manager_caches(void)
 			sizeof(struct discard_cmd));
 	if (!discard_cmd_slab)
 		goto destroy_discard_entry;
+	return 0;
+destroy_discard_entry:
+	kmem_cache_destroy(discard_entry_slab);
+fail:
+	return -ENOMEM;
+}
+
+void destroy_discard_caches(void)
+{
+	kmem_cache_destroy(discard_cmd_slab);
+	kmem_cache_destroy(discard_entry_slab);
+}
 
+int __init create_segment_manager_caches(void)
+{
 	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
 			sizeof(struct sit_entry_set));
 	if (!sit_entry_set_slab)
-		goto destroy_discard_cmd;
+		goto fail;
 
 	inmem_entry_slab = f2fs_kmem_cache_create("inmem_page_entry",
 			sizeof(struct inmem_pages));
@@ -4018,10 +4032,6 @@ int __init create_segment_manager_caches(void)
 
 destroy_sit_entry_set:
 	kmem_cache_destroy(sit_entry_set_slab);
-destroy_discard_cmd:
-	kmem_cache_destroy(discard_cmd_slab);
-destroy_discard_entry:
-	kmem_cache_destroy(discard_entry_slab);
 fail:
 	return -ENOMEM;
 }
@@ -4029,7 +4039,5 @@ int __init create_segment_manager_caches(void)
 void destroy_segment_manager_caches(void)
 {
 	kmem_cache_destroy(sit_entry_set_slab);
-	kmem_cache_destroy(discard_cmd_slab);
-	kmem_cache_destroy(discard_entry_slab);
 	kmem_cache_destroy(inmem_entry_slab);
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7e6fab673073..252133f5d110 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3084,9 +3084,12 @@ static int __init init_f2fs_fs(void)
 	err = create_segment_manager_caches();
 	if (err)
 		goto free_node_manager_caches;
-	err = create_checkpoint_caches();
+	err = create_discard_caches();
 	if (err)
 		goto free_segment_manager_caches;
+	err = create_checkpoint_caches();
+	if (err)
+		goto free_discard_caches;
 	err = create_extent_cache();
 	if (err)
 		goto free_checkpoint_caches;
@@ -3119,6 +3122,8 @@ static int __init init_f2fs_fs(void)
 	destroy_extent_cache();
 free_checkpoint_caches:
 	destroy_checkpoint_caches();
+free_discard_caches:
+	destroy_discard_caches();
 free_segment_manager_caches:
 	destroy_segment_manager_caches();
 free_node_manager_caches:
@@ -3138,6 +3143,7 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_exit_sysfs();
 	destroy_extent_cache();
 	destroy_checkpoint_caches();
+	destroy_discard_caches();
 	destroy_segment_manager_caches();
 	destroy_node_manager_caches();
 	destroy_inodecache();
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
