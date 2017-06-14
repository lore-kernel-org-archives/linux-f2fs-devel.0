From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: clean up sysfs codes
Date: Wed, 14 Jun 2017 17:39:46 +0800
Message-ID: <20170614093947.12265-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dL4ml-00025L-2O
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Jun 2017 09:40:23 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dL4mj-0004zH-5x
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Jun 2017 09:40:23 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Just cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 121 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 47 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 227498064a8f..6c04a5af455a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -349,6 +349,22 @@ static struct kobj_type f2fs_ktype = {
 	.release	= f2fs_sb_release,
 };
 
+int __init f2fs_register_sysfs(void)
+{
+	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
+
+	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
+	if (!f2fs_kset)
+		return -ENOMEM;
+	return 0;
+}
+
+void f2fs_unregister_sysfs(void)
+{
+	kset_unregister(f2fs_kset);
+	remove_proc_entry("fs/f2fs", NULL);
+}
+
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -766,17 +782,23 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	kfree(sbi->devs);
 }
 
-static void f2fs_put_super(struct super_block *sb)
+void f2fs_exit_sysfs(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	int i;
+	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
 
 	if (sbi->s_proc) {
 		remove_proc_entry("segment_info", sbi->s_proc);
 		remove_proc_entry("segment_bits", sbi->s_proc);
-		remove_proc_entry(sb->s_id, f2fs_proc_root);
+		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
-	kobject_del(&sbi->s_kobj);
+}
+
+static void f2fs_put_super(struct super_block *sb)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int i;
 
 	stop_gc_thread(sbi);
 
@@ -829,8 +851,8 @@ static void f2fs_put_super(struct super_block *sb)
 	destroy_segment_manager(sbi);
 
 	kfree(sbi->ckpt);
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
+
+	f2fs_exit_sysfs(sbi);
 
 	sb->s_fs_info = NULL;
 	if (sbi->s_chksum_driver)
@@ -1058,6 +1080,37 @@ static const struct file_operations f2fs_seq_##_name##_fops = {		\
 F2FS_PROC_FILE_DEF(segment_info);
 F2FS_PROC_FILE_DEF(segment_bits);
 
+int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
+{
+	struct super_block *sb = sbi->sb;
+	int err;
+
+	if (f2fs_proc_root)
+		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
+
+	if (sbi->s_proc) {
+		proc_create_data("segment_info", S_IRUGO, sbi->s_proc,
+				 &f2fs_seq_segment_info_fops, sb);
+		proc_create_data("segment_bits", S_IRUGO, sbi->s_proc,
+				 &f2fs_seq_segment_bits_fops, sb);
+	}
+
+	sbi->s_kobj.kset = f2fs_kset;
+	init_completion(&sbi->s_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_ktype, NULL,
+							"%s", sb->s_id);
+	if (err)
+		goto err_out;
+	return 0;
+err_out:
+	if (sbi->s_proc) {
+		remove_proc_entry("segment_info", sbi->s_proc);
+		remove_proc_entry("segment_bits", sbi->s_proc);
+		remove_proc_entry(sb->s_id, f2fs_proc_root);
+	}
+	return err;
+}
+
 static void default_options(struct f2fs_sb_info *sbi)
 {
 	/* init some FS parameters */
@@ -2114,22 +2167,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_root_inode;
 	}
 
-	if (f2fs_proc_root)
-		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
-
-	if (sbi->s_proc) {
-		proc_create_data("segment_info", S_IRUGO, sbi->s_proc,
-				 &f2fs_seq_segment_info_fops, sb);
-		proc_create_data("segment_bits", S_IRUGO, sbi->s_proc,
-				 &f2fs_seq_segment_bits_fops, sb);
-	}
-
-	sbi->s_kobj.kset = f2fs_kset;
-	init_completion(&sbi->s_kobj_unregister);
-	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_ktype, NULL,
-							"%s", sb->s_id);
+	err = f2fs_init_sysfs(sbi);
 	if (err)
-		goto free_proc;
+		goto free_root_inode;
 
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
@@ -2140,7 +2180,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (bdev_read_only(sb->s_bdev) &&
 				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
 			err = -EROFS;
-			goto free_kobj;
+			goto free_sysfs;
 		}
 
 		if (need_fsck)
@@ -2154,7 +2194,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			need_fsck = true;
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot recover all fsync data errno=%d", err);
-			goto free_kobj;
+			goto free_sysfs;
 		}
 	} else {
 		err = recover_fsync_data(sbi, true);
@@ -2163,7 +2203,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			err = -EINVAL;
 			f2fs_msg(sb, KERN_ERR,
 				"Need to recover fsync data");
-			goto free_kobj;
+			goto free_sysfs;
 		}
 	}
 skip_recovery:
@@ -2178,7 +2218,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		/* After POR, we can run background GC thread.*/
 		err = start_gc_thread(sbi);
 		if (err)
-			goto free_kobj;
+			goto free_sysfs;
 	}
 	kfree(options);
 
@@ -2196,17 +2236,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
 
-free_kobj:
+free_sysfs:
 	f2fs_sync_inode_meta(sbi);
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
-free_proc:
-	if (sbi->s_proc) {
-		remove_proc_entry("segment_info", sbi->s_proc);
-		remove_proc_entry("segment_bits", sbi->s_proc);
-		remove_proc_entry(sb->s_id, f2fs_proc_root);
-	}
+	f2fs_exit_sysfs(sbi);
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
@@ -2321,30 +2353,26 @@ static int __init init_f2fs_fs(void)
 	err = create_extent_cache();
 	if (err)
 		goto free_checkpoint_caches;
-	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
-	if (!f2fs_kset) {
-		err = -ENOMEM;
+	err = f2fs_register_sysfs();
+	if (err)
 		goto free_extent_cache;
-	}
 	err = register_shrinker(&f2fs_shrinker_info);
 	if (err)
-		goto free_kset;
-
+		goto free_sysfs;
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto free_shrinker;
 	err = f2fs_create_root_stats();
 	if (err)
 		goto free_filesystem;
-	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	return 0;
 
 free_filesystem:
 	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
-free_kset:
-	kset_unregister(f2fs_kset);
+free_sysfs:
+	f2fs_unregister_sysfs();
 free_extent_cache:
 	destroy_extent_cache();
 free_checkpoint_caches:
@@ -2361,11 +2389,10 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
-	remove_proc_entry("fs/f2fs", NULL);
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 	unregister_shrinker(&f2fs_shrinker_info);
-	kset_unregister(f2fs_kset);
+	f2fs_unregister_sysfs();
 	destroy_extent_cache();
 	destroy_checkpoint_caches();
 	destroy_segment_manager_caches();
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
