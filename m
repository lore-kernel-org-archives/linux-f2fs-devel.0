From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: expose /sys/fs/f2fs/features
Date: Wed, 26 Jul 2017 14:43:26 -0700
Message-ID: <20170726214326.GC66153@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170726012921.53002-1-jaegeuk@kernel.org>
 <765ab60d-b0fc-7233-83b5-86a617e4134f@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <765ab60d-b0fc-7233-83b5-86a617e4134f@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/26, Chao Yu wrote:
> On 2017/7/26 9:29, Jaegeuk Kim wrote:
> > This patch exposes what features are supported by current f2fs build to sysfs
> > entry.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Minor thing, can you exchange below function name to follow ext4:
> f2fs_init_sysfs <-> f2fs_register_sysfs
> f2fs_exit_sysfs <-> f2fs_unregister_sysfs
> 
>From 4cf8a3138f3ee171750ae279fefd4de672a0ee29 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 26 Jul 2017 11:24:13 -0700
Subject: [PATCH] f2fs: avoid naming confusion of sysfs init

This patch changes the function names of sysfs init to follow ext4.

f2fs_init_sysfs <-> f2fs_register_sysfs
f2fs_exit_sysfs <-> f2fs_unregister_sysfs

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |  8 ++++----
 fs/f2fs/super.c | 10 +++++-----
 fs/f2fs/sysfs.c |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d486539086b6..a1bfd0b9be44 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2820,10 +2820,10 @@ void destroy_extent_cache(void);
 /*
  * sysfs.c
  */
-int __init f2fs_register_sysfs(void);
-void f2fs_unregister_sysfs(void);
-int f2fs_init_sysfs(struct f2fs_sb_info *sbi);
-void f2fs_exit_sysfs(struct f2fs_sb_info *sbi);
+int __init f2fs_init_sysfs(void);
+void f2fs_exit_sysfs(void);
+int f2fs_register_sysfs(struct f2fs_sb_info *sbi);
+void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi);
 
 /*
  * crypto support
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1241739f4d54..12513caabe6e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -649,7 +649,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	kfree(sbi->ckpt);
 
-	f2fs_exit_sysfs(sbi);
+	f2fs_unregister_sysfs(sbi);
 
 	sb->s_fs_info = NULL;
 	if (sbi->s_chksum_driver)
@@ -2145,7 +2145,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_root_inode;
 	}
 
-	err = f2fs_init_sysfs(sbi);
+	err = f2fs_register_sysfs(sbi);
 	if (err)
 		goto free_root_inode;
 
@@ -2216,7 +2216,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 free_sysfs:
 	f2fs_sync_inode_meta(sbi);
-	f2fs_exit_sysfs(sbi);
+	f2fs_unregister_sysfs(sbi);
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
@@ -2334,7 +2334,7 @@ static int __init init_f2fs_fs(void)
 	err = create_extent_cache();
 	if (err)
 		goto free_checkpoint_caches;
-	err = f2fs_register_sysfs();
+	err = f2fs_init_sysfs();
 	if (err)
 		goto free_extent_cache;
 	err = register_shrinker(&f2fs_shrinker_info);
@@ -2373,7 +2373,7 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 	unregister_shrinker(&f2fs_shrinker_info);
-	f2fs_unregister_sysfs();
+	f2fs_exit_sysfs();
 	destroy_extent_cache();
 	destroy_checkpoint_caches();
 	destroy_segment_manager_caches();
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 71191d89917d..5a78b9af92ef 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -304,7 +304,7 @@ static const struct file_operations f2fs_seq_##_name##_fops = {		\
 F2FS_PROC_FILE_DEF(segment_info);
 F2FS_PROC_FILE_DEF(segment_bits);
 
-int __init f2fs_register_sysfs(void)
+int __init f2fs_init_sysfs(void)
 {
 	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 
@@ -314,13 +314,13 @@ int __init f2fs_register_sysfs(void)
 	return 0;
 }
 
-void f2fs_unregister_sysfs(void)
+void f2fs_exit_sysfs(void)
 {
 	kset_unregister(f2fs_kset);
 	remove_proc_entry("fs/f2fs", NULL);
 }
 
-int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
+int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 {
 	struct super_block *sb = sbi->sb;
 	int err;
@@ -351,7 +351,7 @@ int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-void f2fs_exit_sysfs(struct f2fs_sb_info *sbi)
+void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 {
 	kobject_del(&sbi->s_kobj);
 	kobject_put(&sbi->s_kobj);
-- 
2.13.0.rc1.294.g07d810a77f-goog
