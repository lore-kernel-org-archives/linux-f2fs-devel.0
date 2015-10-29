From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 1/2] f2fs: report error of f2fs_create_root_stats
Date: Thu, 29 Oct 2015 09:13:04 +0800
Message-ID: <01da01d111e7$0e86d510$2b947f30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_create_root_stats can fail due to no memory, report it to user.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 - fix building warning reported by Fengguang.
 fs/f2fs/debug.c | 7 +++++--
 fs/f2fs/f2fs.h  | 4 ++--
 fs/f2fs/super.c | 6 +++++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 478e5d5..b0966f3 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -406,20 +406,23 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
 	kfree(si);
 }
 
-void __init f2fs_create_root_stats(void)
+int __init f2fs_create_root_stats(void)
 {
 	struct dentry *file;
 
 	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
 	if (!f2fs_debugfs_root)
-		return;
+		return -ENOMEM;
 
 	file = debugfs_create_file("status", S_IRUGO, f2fs_debugfs_root,
 			NULL, &stat_fops);
 	if (!file) {
 		debugfs_remove(f2fs_debugfs_root);
 		f2fs_debugfs_root = NULL;
+		return -ENOMEM;
 	}
+
+	return 0;
 }
 
 void f2fs_destroy_root_stats(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 068813c..b01ad51 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1995,7 +1995,7 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 
 int f2fs_build_stats(struct f2fs_sb_info *);
 void f2fs_destroy_stats(struct f2fs_sb_info *);
-void __init f2fs_create_root_stats(void);
+int __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 #else
 #define stat_inc_cp_count(si)
@@ -2023,7 +2023,7 @@ void f2fs_destroy_root_stats(void);
 
 static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
-static inline void __init f2fs_create_root_stats(void) { }
+static inline int __init f2fs_create_root_stats(void) { return 0; }
 static inline void f2fs_destroy_root_stats(void) { }
 #endif
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3a65e01..67864ab 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1478,10 +1478,14 @@ static int __init init_f2fs_fs(void)
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto free_shrinker;
-	f2fs_create_root_stats();
+	err = f2fs_create_root_stats();
+	if (err)
+		goto free_filesystem;
 	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	return 0;
 
+free_filesystem:
+	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
 free_crypto:
-- 
2.6.1
