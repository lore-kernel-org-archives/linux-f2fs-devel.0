From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] f2fs: no need to check return value of
 debugfs_create functions
Date: Fri, 4 Jan 2019 14:26:18 +0100
Message-ID: <20190104132618.GA1789@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <SRS0=9mL5=PM=linuxfoundation.org=gregkh@kernel.org>)
 id 1gfPUc-0008Op-L6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 13:26:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gfPUZ-00GXfO-29
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 13:26:30 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/debug.c | 20 +++-----------------
 fs/f2fs/f2fs.h  |  4 ++--
 fs/f2fs/super.c |  5 +----
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ebcc121920ba..fd7f170e2f2d 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -506,30 +506,16 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
 	kvfree(si);
 }
 
-int __init f2fs_create_root_stats(void)
+void __init f2fs_create_root_stats(void)
 {
-	struct dentry *file;
-
 	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
-	if (!f2fs_debugfs_root)
-		return -ENOMEM;
 
-	file = debugfs_create_file("status", S_IRUGO, f2fs_debugfs_root,
-			NULL, &stat_fops);
-	if (!file) {
-		debugfs_remove(f2fs_debugfs_root);
-		f2fs_debugfs_root = NULL;
-		return -ENOMEM;
-	}
-
-	return 0;
+	debugfs_create_file("status", S_IRUGO, f2fs_debugfs_root, NULL,
+			    &stat_fops);
 }
 
 void f2fs_destroy_root_stats(void)
 {
-	if (!f2fs_debugfs_root)
-		return;
-
 	debugfs_remove_recursive(f2fs_debugfs_root);
 	f2fs_debugfs_root = NULL;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 12fabd6735dd..8f23ee6e8eb9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3328,7 +3328,7 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 
 int f2fs_build_stats(struct f2fs_sb_info *sbi);
 void f2fs_destroy_stats(struct f2fs_sb_info *sbi);
-int __init f2fs_create_root_stats(void);
+void __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 #else
 #define stat_inc_cp_count(si)				do { } while (0)
@@ -3366,7 +3366,7 @@ void f2fs_destroy_root_stats(void);
 
 static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
-static inline int __init f2fs_create_root_stats(void) { return 0; }
+static inline void __init f2fs_create_root_stats(void) { }
 static inline void f2fs_destroy_root_stats(void) { }
 #endif
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c46a1d4318d4..3d3ce9eb6d13 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3545,9 +3545,7 @@ static int __init init_f2fs_fs(void)
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto free_shrinker;
-	err = f2fs_create_root_stats();
-	if (err)
-		goto free_filesystem;
+	f2fs_create_root_stats();
 	err = f2fs_init_post_read_processing();
 	if (err)
 		goto free_root_stats;
@@ -3555,7 +3553,6 @@ static int __init init_f2fs_fs(void)
 
 free_root_stats:
 	f2fs_destroy_root_stats();
-free_filesystem:
 	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
-- 
2.20.1
