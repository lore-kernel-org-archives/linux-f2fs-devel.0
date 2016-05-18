From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: make exit_f2fs_fs more clear
Date: Wed, 18 May 2016 08:02:25 +0800 (CST)
Message-ID: <1ce95e82.eb2.154c12bad60.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1b2owm-0000il-Lz
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 May 2016 00:02:44 +0000
Received: from m15-63.126.com ([220.181.15.63])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1b2owk-0001wW-R2 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 May 2016 00:02:44 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

init_f2fs_fs does:
    1) f2fs_build_trace_ios
    2) init_inodecache
    3) create_node_manager_caches
    4) create_segment_manager_caches
    5) create_checkpoint_caches
    6) create_extent_cache
    7) kset_create_and_add
    8) kobject_init_and_add
    9) register_shrinker
    10) register_filesystem
    11) f2fs_create_root_stats
    12) proc_mkdir

exit_f2fs_fs should do cleanup in the reverse order
to make the code more clear.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbfeb6a..741fba1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1928,17 +1928,17 @@ static void __exit exit_f2fs_fs(void)
 {
 	remove_proc_entry("fs/f2fs", NULL);
 	f2fs_destroy_root_stats();
-	unregister_shrinker(&f2fs_shrinker_info);
 	unregister_filesystem(&f2fs_fs_type);
+	unregister_shrinker(&f2fs_shrinker_info);
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	kobject_put(&f2fs_fault_inject);
+#endif
+	kset_unregister(f2fs_kset);
 	destroy_extent_cache();
 	destroy_checkpoint_caches();
 	destroy_segment_manager_caches();
 	destroy_node_manager_caches();
 	destroy_inodecache();
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	kobject_put(&f2fs_fault_inject);
-#endif
-	kset_unregister(f2fs_kset);
 	f2fs_destroy_trace_ios();
 }
 
-- 
1.8.3.1
------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
