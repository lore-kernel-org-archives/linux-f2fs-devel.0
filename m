From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: support configuring fault injection per
	superblock
Date: Fri, 23 Sep 2016 21:30:09 +0800
Message-ID: <1474637409-25258-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bnQaw-0002y6-AW
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Sep 2016 13:32:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bnQas-0007mC-62
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Sep 2016 13:32:50 +0000
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

From: Chao Yu <yuchao0@huawei.com>

Previously, we only support global fault injection configuration, so that
when we configure type/rate of fault injection through sysfs, mount
option, it will influence all f2fs partition which is being used.

It is not make sence, since it will be not convenient if developer want
to test separated partitions with different fault injection rate/type
simultaneously, also it's not possible to enable fault injection in one
partition and disable fault injection in other one.

>From now on, we move global configuration of fault injection in module
into per-superblock, hence injection testing can be more flexible.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/acl.c        | 12 ++++----
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       |  2 +-
 fs/f2fs/dir.c        |  2 +-
 fs/f2fs/f2fs.h       | 78 ++++++++++++++++++++++++----------------------------
 fs/f2fs/gc.c         |  2 +-
 fs/f2fs/inline.c     |  4 +--
 fs/f2fs/inode.c      |  2 +-
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/super.c      | 57 ++++++++++----------------------------
 10 files changed, 66 insertions(+), 97 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 4dcc9e2..1e29630 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -109,14 +109,16 @@ fail:
 	return ERR_PTR(-EINVAL);
 }
 
-static void *f2fs_acl_to_disk(const struct posix_acl *acl, size_t *size)
+static void *f2fs_acl_to_disk(struct f2fs_sb_info *sbi,
+				const struct posix_acl *acl, size_t *size)
 {
 	struct f2fs_acl_header *f2fs_acl;
 	struct f2fs_acl_entry *entry;
 	int i;
 
-	f2fs_acl = f2fs_kmalloc(sizeof(struct f2fs_acl_header) + acl->a_count *
-			sizeof(struct f2fs_acl_entry), GFP_NOFS);
+	f2fs_acl = f2fs_kmalloc(sbi, sizeof(struct f2fs_acl_header) +
+			acl->a_count * sizeof(struct f2fs_acl_entry),
+			GFP_NOFS);
 	if (!f2fs_acl)
 		return ERR_PTR(-ENOMEM);
 
@@ -175,7 +177,7 @@ static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
 
 	retval = f2fs_getxattr(inode, name_index, "", NULL, 0, dpage);
 	if (retval > 0) {
-		value = f2fs_kmalloc(retval, GFP_F2FS_ZERO);
+		value = f2fs_kmalloc(F2FS_I_SB(inode), retval, GFP_F2FS_ZERO);
 		if (!value)
 			return ERR_PTR(-ENOMEM);
 		retval = f2fs_getxattr(inode, name_index, "", value,
@@ -230,7 +232,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	}
 
 	if (acl) {
-		value = f2fs_acl_to_disk(acl, &size);
+		value = f2fs_acl_to_disk(F2FS_I_SB(inode), acl, &size);
 		if (IS_ERR(value)) {
 			clear_inode_flag(inode, FI_ACL_MODE);
 			return (int)PTR_ERR(value);
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d1560bb..a655d75 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -494,7 +494,7 @@ int acquire_orphan_inode(struct f2fs_sb_info *sbi)
 	spin_lock(&im->ino_lock);
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(FAULT_ORPHAN)) {
+	if (time_to_inject(sbi, FAULT_ORPHAN)) {
 		spin_unlock(&im->ino_lock);
 		return -ENOSPC;
 	}
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a9f7436..0eb7bee 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -35,7 +35,7 @@ static void f2fs_read_end_io(struct bio *bio)
 	int i;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(FAULT_IO))
+	if (time_to_inject(F2FS_P_SB(bio->bi_io_vec->bv_page), FAULT_IO))
 		bio->bi_error = -EIO;
 #endif
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 39a850b..cbf85f6 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -545,7 +545,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 
 start:
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(FAULT_DIR_DEPTH))
+	if (time_to_inject(F2FS_I_SB(dir), FAULT_DIR_DEPTH))
 		return -ENOSPC;
 #endif
 	if (unlikely(current_depth == MAX_DIR_HASH_DEPTH))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3c513fe..0d7b649 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -57,44 +57,8 @@ struct f2fs_fault_info {
 	unsigned int inject_type;
 };
 
-extern struct f2fs_fault_info f2fs_fault;
 extern char *fault_name[FAULT_MAX];
-#define IS_FAULT_SET(type) (f2fs_fault.inject_type & (1 << (type)))
-
-static inline bool time_to_inject(int type)
-{
-	if (!f2fs_fault.inject_rate)
-		return false;
-	if (type == FAULT_KMALLOC && !IS_FAULT_SET(type))
-		return false;
-	else if (type == FAULT_PAGE_ALLOC && !IS_FAULT_SET(type))
-		return false;
-	else if (type == FAULT_ALLOC_NID && !IS_FAULT_SET(type))
-		return false;
-	else if (type == FAULT_ORPHAN && !IS_FAULT_SET(type))
-		return false;
-	else if (type == FAULT_BLOCK && !IS_FAULT_SET(type))
-		return false;
-	else if (type == FAULT_DIR_DEPTH && !IS_FAULT_SET(type))
-		return false;
-	else if (type == FAULT_EVICT_INODE && !IS_FAULT_SET(type))
-		return false;
-	else if (type == FAULT_IO && !IS_FAULT_SET(type))
-		return false;
-	else if (type == FAULT_CHECKPOINT && !IS_FAULT_SET(type))
-		return false;
-
-	atomic_inc(&f2fs_fault.inject_ops);
-	if (atomic_read(&f2fs_fault.inject_ops) >= f2fs_fault.inject_rate) {
-		atomic_set(&f2fs_fault.inject_ops, 0);
-		printk("%sF2FS-fs : inject %s in %pF\n",
-				KERN_INFO,
-				fault_name[type],
-				__builtin_return_address(0));
-		return true;
-	}
-	return false;
-}
+#define IS_FAULT_SET(fi, type) (fi->inject_type & (1 << (type)))
 #endif
 
 /*
@@ -928,8 +892,37 @@ struct f2fs_sb_info {
 
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
+
+	/* For fault injection */
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	struct f2fs_fault_info fault_info;
+#endif
 };
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
+{
+	struct f2fs_fault_info *ffi = &sbi->fault_info;
+
+	if (!ffi->inject_rate)
+		return false;
+
+	if (!IS_FAULT_SET(ffi, type))
+		return false;
+
+	atomic_inc(&ffi->inject_ops);
+	if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
+		atomic_set(&ffi->inject_ops, 0);
+		printk("%sF2FS-fs : inject %s in %pF\n",
+				KERN_INFO,
+				fault_name[type],
+				__builtin_return_address(0));
+		return true;
+	}
+	return false;
+}
+#endif
+
 /* For write statistics. Suppose sector size is 512 bytes,
  * and the return value is in kbytes. s is of struct f2fs_sb_info.
  */
@@ -1214,7 +1207,7 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 	blkcnt_t diff;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(FAULT_BLOCK))
+	if (time_to_inject(sbi, FAULT_BLOCK))
 		return false;
 #endif
 	/*
@@ -1448,7 +1441,7 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 	if (page)
 		return page;
 
-	if (time_to_inject(FAULT_PAGE_ALLOC))
+	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC))
 		return NULL;
 #endif
 	if (!for_write)
@@ -1877,7 +1870,7 @@ static inline int f2fs_readonly(struct super_block *sb)
 static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
 {
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(FAULT_CHECKPOINT))
+	if (time_to_inject(sbi, FAULT_CHECKPOINT))
 		return true;
 #endif
 	return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
@@ -1903,10 +1896,11 @@ static inline bool f2fs_may_extent_tree(struct inode *inode)
 	return S_ISREG(inode->i_mode);
 }
 
-static inline void *f2fs_kmalloc(size_t size, gfp_t flags)
+static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
+					size_t size, gfp_t flags)
 {
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(FAULT_KMALLOC))
+	if (time_to_inject(sbi, FAULT_KMALLOC))
 		return NULL;
 #endif
 	return kmalloc(size, flags);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b9d6c42..a5c4175 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -96,7 +96,7 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	int err = 0;
 
-	gc_th = f2fs_kmalloc(sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
+	gc_th = f2fs_kmalloc(sbi, sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
 	if (!gc_th) {
 		err = -ENOMEM;
 		goto out;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4d526f3..34234d8 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -445,8 +445,8 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	struct f2fs_inline_dentry *backup_dentry;
 	int err;
 
-	backup_dentry = f2fs_kmalloc(sizeof(struct f2fs_inline_dentry),
-							GFP_F2FS_ZERO);
+	backup_dentry = f2fs_kmalloc(F2FS_I_SB(dir),
+			sizeof(struct f2fs_inline_dentry), GFP_F2FS_ZERO);
 	if (!backup_dentry) {
 		f2fs_put_page(ipage, 1);
 		return -ENOMEM;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ac4daa5..d736989 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -369,7 +369,7 @@ void f2fs_evict_inode(struct inode *inode)
 		goto no_delete;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(FAULT_EVICT_INODE))
+	if (time_to_inject(sbi, FAULT_EVICT_INODE))
 		goto no_delete;
 #endif
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c2d953e..11a8f9b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1846,7 +1846,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	struct free_nid *i = NULL;
 retry:
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(FAULT_ALLOC_NID))
+	if (time_to_inject(sbi, FAULT_ALLOC_NID))
 		return false;
 #endif
 	if (unlikely(sbi->total_valid_node_count + 1 > nm_i->available_nids))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3c49419..8f1e3a3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -40,7 +40,6 @@ static struct kmem_cache *f2fs_inode_cachep;
 static struct kset *f2fs_kset;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-struct f2fs_fault_info f2fs_fault;
 
 char *fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
@@ -54,14 +53,17 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_CHECKPOINT]	= "checkpoint error",
 };
 
-static void f2fs_build_fault_attr(unsigned int rate)
+static void f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
+						unsigned int rate)
 {
+	struct f2fs_fault_info *ffi = &sbi->fault_info;
+
 	if (rate) {
-		atomic_set(&f2fs_fault.inject_ops, 0);
-		f2fs_fault.inject_rate = rate;
-		f2fs_fault.inject_type = (1 << FAULT_MAX) - 1;
+		atomic_set(&ffi->inject_ops, 0);
+		ffi->inject_rate = rate;
+		ffi->inject_type = (1 << FAULT_MAX) - 1;
 	} else {
-		memset(&f2fs_fault, 0, sizeof(struct f2fs_fault_info));
+		memset(ffi, 0, sizeof(struct f2fs_fault_info));
 	}
 }
 #endif
@@ -171,7 +173,7 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	else if (struct_type == FAULT_INFO_RATE ||
 					struct_type == FAULT_INFO_TYPE)
-		return (unsigned char *)&f2fs_fault;
+		return (unsigned char *)&sbi->fault_info;
 #endif
 	return NULL;
 }
@@ -316,6 +318,10 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(dirty_nats_ratio),
 	ATTR_LIST(cp_interval),
 	ATTR_LIST(idle_interval),
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	ATTR_LIST(inject_rate),
+	ATTR_LIST(inject_type),
+#endif
 	ATTR_LIST(lifetime_write_kbytes),
 	NULL,
 };
@@ -331,22 +337,6 @@ static struct kobj_type f2fs_ktype = {
 	.release	= f2fs_sb_release,
 };
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-/* sysfs for f2fs fault injection */
-static struct kobject f2fs_fault_inject;
-
-static struct attribute *f2fs_fault_attrs[] = {
-	ATTR_LIST(inject_rate),
-	ATTR_LIST(inject_type),
-	NULL
-};
-
-static struct kobj_type f2fs_fault_ktype = {
-	.default_attrs	= f2fs_fault_attrs,
-	.sysfs_ops	= &f2fs_attr_ops,
-};
-#endif
-
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -375,7 +365,7 @@ static int parse_options(struct super_block *sb, char *options)
 	int arg = 0;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	f2fs_build_fault_attr(0);
+	f2fs_build_fault_attr(sbi, 0);
 #endif
 
 	if (!options)
@@ -540,7 +530,7 @@ static int parse_options(struct super_block *sb, char *options)
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-			f2fs_build_fault_attr(arg);
+			f2fs_build_fault_attr(sbi, arg);
 #else
 			f2fs_msg(sb, KERN_INFO,
 				"FAULT_INJECTION was not selected");
@@ -1993,16 +1983,6 @@ static int __init init_f2fs_fs(void)
 		err = -ENOMEM;
 		goto free_extent_cache;
 	}
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	f2fs_fault_inject.kset = f2fs_kset;
-	f2fs_build_fault_attr(0);
-	err = kobject_init_and_add(&f2fs_fault_inject, &f2fs_fault_ktype,
-				NULL, "fault_injection");
-	if (err) {
-		f2fs_fault_inject.kset = NULL;
-		goto free_kset;
-	}
-#endif
 	err = register_shrinker(&f2fs_shrinker_info);
 	if (err)
 		goto free_kset;
@@ -2021,10 +2001,6 @@ free_filesystem:
 free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
 free_kset:
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (f2fs_fault_inject.kset)
-		kobject_put(&f2fs_fault_inject);
-#endif
 	kset_unregister(f2fs_kset);
 free_extent_cache:
 	destroy_extent_cache();
@@ -2046,9 +2022,6 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 	unregister_shrinker(&f2fs_shrinker_info);
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	kobject_put(&f2fs_fault_inject);
-#endif
 	kset_unregister(f2fs_kset);
 	destroy_extent_cache();
 	destroy_checkpoint_caches();
-- 
2.7.2


------------------------------------------------------------------------------
