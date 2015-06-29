From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/12] f2fs: introduce a shrinker for mounted fs
Date: Mon, 29 Jun 2015 11:39:32 -0700
Message-ID: <1435603176-63219-8-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dyi-0000hc-Ln
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:24 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dyh-0005I2-HY for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:24 +0000
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch introduces a shrinker targeting to reduce memory footprint consumed
by a number of in-memory f2fs data structures.

In addition, it newly adds:
 - sbi->umount_mutex to avoid data races on shrinker and put_super
 - sbi->shruinker_run_no to not revisit objects

Noteh that the basic implementation was copied from fs/btrfs/shrinker.c

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Makefile   |   1 +
 fs/f2fs/f2fs.h     |  13 +++++++
 fs/f2fs/shrinker.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/super.c    |  24 +++++++++++++
 4 files changed, 142 insertions(+)
 create mode 100644 fs/f2fs/shrinker.c

diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 396be1a..005251b 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_F2FS_FS) += f2fs.o
 
 f2fs-y		:= dir.o file.o inode.o namei.o hash.o super.o inline.o
 f2fs-y		+= checkpoint.o gc.o data.o node.o segment.o recovery.o
+f2fs-y		+= shrinker.o
 f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3aaa4b9..e82af8c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -791,6 +791,11 @@ struct f2fs_sb_info {
 	/* For sysfs suppport */
 	struct kobject s_kobj;
 	struct completion s_kobj_unregister;
+
+	/* For shrinker support */
+	struct list_head s_list;
+	struct mutex umount_mutex;
+	unsigned int shrinker_run_no;
 };
 
 /*
@@ -1952,6 +1957,14 @@ int f2fs_read_inline_dir(struct file *, struct dir_context *,
 						struct f2fs_str *);
 
 /*
+ * shrinker.c
+ */
+unsigned long f2fs_shrink_count(struct shrinker *, struct shrink_control *);
+unsigned long f2fs_shrink_scan(struct shrinker *, struct shrink_control *);
+void f2fs_join_shrinker(struct f2fs_sb_info *);
+void f2fs_leave_shrinker(struct f2fs_sb_info *);
+
+/*
  * crypto support
  */
 static inline int f2fs_encrypted_inode(struct inode *inode)
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
new file mode 100644
index 0000000..a680145
--- /dev/null
+++ b/fs/f2fs/shrinker.c
@@ -0,0 +1,104 @@
+/*
+ * f2fs shrinker support
+ *   the basic infra was copied from fs/btrfs/shrinker.c
+ *
+ * Copyright (c) 2015 Motorola Mobility
+ * Copyright (c) 2015 Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/fs.h>
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+
+static LIST_HEAD(f2fs_list);
+static DEFINE_SPINLOCK(f2fs_list_lock);
+static unsigned int shrinker_run_no;
+
+unsigned long f2fs_shrink_count(struct shrinker *shrink,
+				struct shrink_control *sc)
+{
+	struct f2fs_sb_info *sbi;
+	struct list_head *p;
+	unsigned long count = 0;
+
+	spin_lock(&f2fs_list_lock);
+	p = f2fs_list.next;
+	while (p != &f2fs_list) {
+		sbi = list_entry(p, struct f2fs_sb_info, s_list);
+
+		/* stop f2fs_put_super */
+		if (!mutex_trylock(&sbi->umount_mutex)) {
+			p = p->next;
+			continue;
+		}
+		spin_unlock(&f2fs_list_lock);
+
+		/* TODO: count # of objects */
+
+		spin_lock(&f2fs_list_lock);
+		p = p->next;
+		mutex_unlock(&sbi->umount_mutex);
+	}
+	spin_unlock(&f2fs_list_lock);
+	return count;
+}
+
+unsigned long f2fs_shrink_scan(struct shrinker *shrink,
+				struct shrink_control *sc)
+{
+	unsigned long nr = sc->nr_to_scan;
+	struct f2fs_sb_info *sbi;
+	struct list_head *p;
+	unsigned int run_no;
+	unsigned long freed = 0;
+
+	spin_lock(&f2fs_list_lock);
+	do {
+		run_no = ++shrinker_run_no;
+	} while (run_no == 0);
+	p = f2fs_list.next;
+	while (p != &f2fs_list) {
+		sbi = list_entry(p, struct f2fs_sb_info, s_list);
+
+		if (sbi->shrinker_run_no == run_no)
+			break;
+
+		/* stop f2fs_put_super */
+		if (!mutex_trylock(&sbi->umount_mutex)) {
+			p = p->next;
+			continue;
+		}
+		spin_unlock(&f2fs_list_lock);
+
+		sbi->shrinker_run_no = run_no;
+
+		/* TODO: shrink caches */
+
+		spin_lock(&f2fs_list_lock);
+		p = p->next;
+		list_move_tail(&sbi->s_list, &f2fs_list);
+		mutex_unlock(&sbi->umount_mutex);
+		if (freed >= nr)
+			break;
+	}
+	spin_unlock(&f2fs_list_lock);
+	return freed;
+}
+
+void f2fs_join_shrinker(struct f2fs_sb_info *sbi)
+{
+	spin_lock(&f2fs_list_lock);
+	list_add_tail(&sbi->s_list, &f2fs_list);
+	spin_unlock(&f2fs_list_lock);
+}
+
+void f2fs_leave_shrinker(struct f2fs_sb_info *sbi)
+{
+	spin_lock(&f2fs_list_lock);
+	list_del(&sbi->s_list);
+	spin_unlock(&f2fs_list_lock);
+}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index da27710..2e8645e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -39,6 +39,13 @@ static struct proc_dir_entry *f2fs_proc_root;
 static struct kmem_cache *f2fs_inode_cachep;
 static struct kset *f2fs_kset;
 
+/* f2fs-wide shrinker description */
+static struct shrinker f2fs_shrinker_info = {
+	.scan_objects = f2fs_shrink_scan,
+	.count_objects = f2fs_shrink_count,
+	.seeks = DEFAULT_SEEKS,
+};
+
 enum {
 	Opt_gc_background,
 	Opt_disable_roll_forward,
@@ -500,6 +507,9 @@ static void f2fs_put_super(struct super_block *sb)
 
 	stop_gc_thread(sbi);
 
+	/* prevent remaining shrinker jobs */
+	mutex_lock(&sbi->umount_mutex);
+
 	/*
 	 * We don't need to do checkpoint when superblock is clean.
 	 * But, the previous checkpoint was not done by umount, it needs to do
@@ -523,6 +533,9 @@ static void f2fs_put_super(struct super_block *sb)
 	release_dirty_inode(sbi);
 	release_discard_addrs(sbi);
 
+	f2fs_leave_shrinker(sbi);
+	mutex_unlock(&sbi->umount_mutex);
+
 	iput(sbi->node_inode);
 	iput(sbi->meta_inode);
 
@@ -972,6 +985,9 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
+
+	INIT_LIST_HEAD(&sbi->s_list);
+	mutex_init(&sbi->umount_mutex);
 }
 
 /*
@@ -1214,6 +1230,8 @@ try_onemore:
 		goto free_nm;
 	}
 
+	f2fs_join_shrinker(sbi);
+
 	/* if there are nt orphan nodes free them */
 	recover_orphan_inodes(sbi);
 
@@ -1310,6 +1328,7 @@ free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
 free_node_inode:
+	f2fs_leave_shrinker(sbi);
 	iput(sbi->node_inode);
 free_nm:
 	destroy_node_manager(sbi);
@@ -1406,6 +1425,9 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_crypto();
 	if (err)
 		goto free_kset;
+
+	register_shrinker(&f2fs_shrinker_info);
+
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto free_crypto;
@@ -1414,6 +1436,7 @@ static int __init init_f2fs_fs(void)
 	return 0;
 
 free_crypto:
+	unregister_shrinker(&f2fs_shrinker_info);
 	f2fs_exit_crypto();
 free_kset:
 	kset_unregister(f2fs_kset);
@@ -1435,6 +1458,7 @@ static void __exit exit_f2fs_fs(void)
 {
 	remove_proc_entry("fs/f2fs", NULL);
 	f2fs_destroy_root_stats();
+	unregister_shrinker(&f2fs_shrinker_info);
 	unregister_filesystem(&f2fs_fs_type);
 	f2fs_exit_crypto();
 	destroy_extent_cache();
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
