From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: support plain user/group quota
Date: Sun,  9 Jul 2017 00:13:07 +0800
Message-ID: <20170708161307.7477-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch adds to support plain user/group quota.

Change Note by Jaegeuk Kim.

- Use f2fs page cache for quota files in order to consider garbage collection.
  so, quota files are not tolerable for sudden power-cuts, so user needs to do
  quotacheck.

- setattr() calls dquot_transfer which will transfer inode->i_blocks.
  We can't reclaim that during f2fs_evict_inode(). So, we need to count
  node blocks as well in order to match i_blocks with dquot's space.

  Note that, Chao wrote a patch to count inode->i_blocks without inode block.
  (f2fs: don't count inode block in in-memory inode.i_blocks)

- in f2fs_remount, we need to make RW in prior to dquot_resume.

- handle fault_injection case during f2fs_quota_off_umount

- TODO: Project quota

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2:
 - update doc for quota support.
 Documentation/filesystems/f2fs.txt |   2 +
 fs/f2fs/data.c                     |  10 +-
 fs/f2fs/f2fs.h                     |  88 +++++++++---
 fs/f2fs/file.c                     |  34 ++++-
 fs/f2fs/inode.c                    |   5 +
 fs/f2fs/namei.c                    |  66 ++++++++-
 fs/f2fs/node.c                     |   9 +-
 fs/f2fs/super.c                    | 280 +++++++++++++++++++++++++++++++++++++
 8 files changed, 454 insertions(+), 40 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 8b04a6359530..273ccb26885e 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -162,6 +162,8 @@ mode=%s                Control block allocation mode which supports "adaptive"
                        writes towards main area.
 io_bits=%u             Set the bit size of write IO requests. It should be set
                        with "mode=lfs".
+usrquota               Enable plain user disk quota accounting.
+grpquota               Enable plain group disk quota accounting.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7dd5fb647d43..251356859476 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -491,14 +491,15 @@ void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	int err;
 
 	if (!count)
 		return 0;
 
 	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return -EPERM;
-	if (unlikely(!inc_valid_block_count(sbi, dn->inode, &count)))
-		return -ENOSPC;
+	if (unlikely((err = inc_valid_block_count(sbi, dn->inode, &count))))
+		return err;
 
 	trace_f2fs_reserve_new_blocks(dn->inode, dn->nid,
 						dn->ofs_in_node, count);
@@ -749,6 +750,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	struct node_info ni;
 	pgoff_t fofs;
 	blkcnt_t count = 1;
+	int err;
 
 	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return -EPERM;
@@ -757,8 +759,8 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	if (dn->data_blkaddr == NEW_ADDR)
 		goto alloc;
 
-	if (unlikely(!inc_valid_block_count(sbi, dn->inode, &count)))
-		return -ENOSPC;
+	if (unlikely((err = inc_valid_block_count(sbi, dn->inode, &count))))
+		return err;
 
 alloc:
 	get_node_info(sbi, dn->nid, &ni);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ced78035a416..42c39f0bfd88 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/quotaops.h>
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 #include <linux/fscrypt_supp.h>
 #else
@@ -88,6 +89,8 @@ extern char *fault_name[FAULT_MAX];
 #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
 #define F2FS_MOUNT_ADAPTIVE		0x00020000
 #define F2FS_MOUNT_LFS			0x00040000
+#define F2FS_MOUNT_USRQUOTA		0x00080000
+#define F2FS_MOUNT_GRPQUOTA		0x00100000
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
@@ -521,6 +524,12 @@ struct f2fs_inode_info {
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	loff_t	last_disk_size;		/* lastly written file size */
 
+#ifdef CONFIG_QUOTA
+	struct dquot *i_dquot[MAXQUOTAS];
+
+	/* quota space reservation, managed internally by quota code */
+	qsize_t i_reserved_quota;
+#endif
 	struct list_head dirty_list;	/* dirty list for dirs and files */
 	struct list_head gdirty_list;	/* linked in global dirty list */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
@@ -1376,17 +1385,23 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
-static inline void f2fs_i_blocks_write(struct inode *, block_t, bool);
-static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
+static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
+static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
 {
-	blkcnt_t diff;
+	blkcnt_t diff = 0, release = 0;
 	block_t avail_user_block_count;
+	int ret;
+
+	ret = dquot_reserve_block(inode, *count);
+	if (ret)
+		return ret;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_BLOCK)) {
 		f2fs_show_injection_info(FAULT_BLOCK);
-		return false;
+		release = *count;
+		goto enospc;
 	}
 #endif
 	/*
@@ -1401,17 +1416,24 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
 		*count -= diff;
+		release = diff;
 		sbi->total_valid_block_count = avail_user_block_count;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
 			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);
-			return false;
+			goto enospc;
 		}
 	}
 	spin_unlock(&sbi->stat_lock);
 
-	f2fs_i_blocks_write(inode, *count, true);
-	return true;
+	if (release)
+		dquot_release_reservation_block(inode, release);
+	f2fs_i_blocks_write(inode, *count, true, true);
+	return 0;
+
+enospc:
+	dquot_release_reservation_block(inode, release);
+	return -ENOSPC;
 }
 
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
@@ -1425,7 +1447,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, inode->i_blocks < sectors);
 	sbi->total_valid_block_count -= (block_t)count;
 	spin_unlock(&sbi->stat_lock);
-	f2fs_i_blocks_write(inode, count, false);
+	f2fs_i_blocks_write(inode, count, false, true);
 }
 
 static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
@@ -1554,11 +1576,18 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
 }
 
-static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
+static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
 	block_t	valid_block_count;
 	unsigned int valid_node_count;
+	bool quota = inode && !is_inode;
+
+	if (quota) {
+		int ret = dquot_reserve_block(inode, 1);
+		if (ret)
+			return ret;
+	}
 
 	spin_lock(&sbi->stat_lock);
 
@@ -1566,28 +1595,33 @@ static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
 	if (unlikely(valid_block_count + sbi->reserved_blocks >
 						sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
-		return false;
+		goto enospc;
 	}
 
 	valid_node_count = sbi->total_valid_node_count + 1;
 	if (unlikely(valid_node_count > sbi->total_node_count)) {
 		spin_unlock(&sbi->stat_lock);
-		return false;
+		goto enospc;
 	}
 
+	sbi->total_valid_node_count++;
+	sbi->total_valid_block_count++;
+	spin_unlock(&sbi->stat_lock);
+
 	if (inode) {
 		if (is_inode)
 			f2fs_mark_inode_dirty_sync(inode, true);
 		else
-			f2fs_i_blocks_write(inode, 1, true);
+			f2fs_i_blocks_write(inode, 1, true, true);
 	}
 
-	sbi->total_valid_node_count++;
-	sbi->total_valid_block_count++;
-	spin_unlock(&sbi->stat_lock);
-
 	percpu_counter_inc(&sbi->alloc_valid_block_count);
-	return true;
+	return 0;
+
+enospc:
+	if (quota)
+		dquot_release_reservation_block(inode, 1);
+	return -ENOSPC;
 }
 
 static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
@@ -1599,12 +1633,13 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, !sbi->total_valid_node_count);
 	f2fs_bug_on(sbi, !is_inode && !inode->i_blocks);
 
-	if (!is_inode)
-		f2fs_i_blocks_write(inode, 1, false);
 	sbi->total_valid_node_count--;
 	sbi->total_valid_block_count--;
 
 	spin_unlock(&sbi->stat_lock);
+
+	if (!is_inode)
+		f2fs_i_blocks_write(inode, 1, false, true);
 }
 
 static inline unsigned int valid_node_count(struct f2fs_sb_info *sbi)
@@ -1879,14 +1914,21 @@ static inline void f2fs_i_links_write(struct inode *inode, bool inc)
 }
 
 static inline void f2fs_i_blocks_write(struct inode *inode,
-					block_t diff, bool add)
+					block_t diff, bool add, bool claim)
 {
 	bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
 	bool recover = is_inode_flag_set(inode, FI_AUTO_RECOVER);
-	blkcnt_t sectors = diff << F2FS_LOG_SECTORS_PER_BLOCK;
 
-	inode->i_blocks = add ? inode->i_blocks + sectors :
-				inode->i_blocks - sectors;
+	/* add = 1, claim = 1 should be dquot_reserve_block in pair */
+	if (add) {
+		if (claim)
+			dquot_claim_block(inode, diff);
+		else
+			dquot_alloc_block_nofail(inode, diff);
+	} else {
+		dquot_free_block(inode, diff);
+	}
+
 	f2fs_mark_inode_dirty_sync(inode, true);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3f56b27e761b..527c9f36d971 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -442,11 +442,10 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
-	int ret = generic_file_open(inode, filp);
 	struct dentry *dir;
 
-	if (!ret && f2fs_encrypted_inode(inode)) {
-		ret = fscrypt_get_encryption_info(inode);
+	if (f2fs_encrypted_inode(inode)) {
+		int ret = fscrypt_get_encryption_info(inode);
 		if (ret)
 			return -EACCES;
 		if (!fscrypt_has_encryption_key(inode))
@@ -459,7 +458,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 		return -EPERM;
 	}
 	dput(dir);
-	return ret;
+	return dquot_file_open(inode, filp);
 }
 
 int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
@@ -710,6 +709,20 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (err)
 		return err;
 
+	if (is_quota_modification(inode, attr)) {
+		err = dquot_initialize(inode);
+		if (err)
+			return err;
+	}
+	if ((attr->ia_valid & ATTR_UID &&
+		!uid_eq(attr->ia_uid, inode->i_uid)) ||
+		(attr->ia_valid & ATTR_GID &&
+		!gid_eq(attr->ia_gid, inode->i_gid))) {
+		err = dquot_transfer(inode, attr);
+		if (err)
+			return err;
+	}
+
 	if (attr->ia_valid & ATTR_SIZE) {
 		if (f2fs_encrypted_inode(inode)) {
 			err = fscrypt_get_encryption_info(inode);
@@ -996,9 +1009,9 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 
 				if (do_replace[i]) {
 					f2fs_i_blocks_write(src_inode,
-								1, false);
+							1, false, false);
 					f2fs_i_blocks_write(dst_inode,
-								1, true);
+							1, true, false);
 					f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
 					blkaddr[i], ni.version, true, false);
 
@@ -1523,6 +1536,13 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
+	/* Is it quota file? Do not allow user to mess with it */
+	if (IS_NOQUOTA(inode)) {
+		inode_unlock(inode);
+		ret = -EPERM;
+		goto unlock_out;
+	}
+
 	flags = f2fs_mask_flags(inode->i_mode, flags);
 
 	oldflags = fi->i_flags;
@@ -1542,7 +1562,7 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 	inode->i_ctime = current_time(inode);
 	f2fs_set_inode_flags(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
-
+unlock_out:
 	inode_unlock(inode);
 out:
 	mnt_drop_write_file(filp);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e42a7a8805dc..6cd312a17c69 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -373,6 +373,8 @@ void f2fs_evict_inode(struct inode *inode)
 	if (inode->i_nlink || is_bad_inode(inode))
 		goto no_delete;
 
+	dquot_initialize(inode);
+
 	remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
 	remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 
@@ -405,8 +407,11 @@ void f2fs_evict_inode(struct inode *inode)
 
 	if (err)
 		update_inode_page(inode);
+	dquot_free_inode(inode);
 	sb_end_intwrite(inode->i_sb);
 no_delete:
+	dquot_drop(inode);
+
 	stat_dec_inline_xattr(inode);
 	stat_dec_inline_dir(inode);
 	stat_dec_inline_inode(inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b75dc2f4ad57..760d85223c81 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
+#include <linux/quotaops.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -42,6 +43,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	}
 	f2fs_unlock_op(sbi);
 
+	nid_free = true;
+
 	inode_init_owner(inode, dir, mode);
 
 	inode->i_ino = ino;
@@ -52,10 +55,17 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	err = insert_inode_locked(inode);
 	if (err) {
 		err = -EINVAL;
-		nid_free = true;
 		goto fail;
 	}
 
+	err = dquot_initialize(inode);
+	if (err)
+		goto fail_drop;
+
+	err = dquot_alloc_inode(inode);
+	if (err)
+		goto fail_drop;
+
 	/* If the directory encrypted, then we should encrypt the inode. */
 	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
@@ -85,6 +95,16 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 		set_inode_flag(inode, FI_FREE_NID);
 	iput(inode);
 	return ERR_PTR(err);
+fail_drop:
+	trace_f2fs_new_inode(inode, err);
+	dquot_drop(inode);
+	inode->i_flags |= S_NOQUOTA;
+	if (nid_free)
+		set_inode_flag(inode, FI_FREE_NID);
+	clear_nlink(inode);
+	unlock_new_inode(inode);
+	iput(inode);
+	return ERR_PTR(err);
 }
 
 static int is_multimedia_file(const unsigned char *s, const char *sub)
@@ -136,6 +156,10 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	nid_t ino = 0;
 	int err;
 
+	err = dquot_initialize(dir);
+	if (err)
+		return err;
+
 	inode = f2fs_new_inode(dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -180,6 +204,10 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 			!fscrypt_has_permitted_context(dir, inode))
 		return -EPERM;
 
+	err = dquot_initialize(dir);
+	if (err)
+		return err;
+
 	f2fs_balance_fs(sbi, true);
 
 	inode->i_ctime = current_time(inode);
@@ -347,6 +375,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 
 	trace_f2fs_unlink_enter(dir, dentry);
 
+	err = dquot_initialize(dir);
+	if (err)
+		return err;
+
 	de = f2fs_find_entry(dir, &dentry->d_name, &page);
 	if (!de) {
 		if (IS_ERR(page))
@@ -413,6 +445,10 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	if (disk_link.len > dir->i_sb->s_blocksize)
 		return -ENAMETOOLONG;
 
+	err = dquot_initialize(dir);
+	if (err)
+		return err;
+
 	inode = f2fs_new_inode(dir, S_IFLNK | S_IRWXUGO);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -500,6 +536,10 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct inode *inode;
 	int err;
 
+	err = dquot_initialize(dir);
+	if (err)
+		return err;
+
 	inode = f2fs_new_inode(dir, S_IFDIR | mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -548,6 +588,10 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int err = 0;
 
+	err = dquot_initialize(dir);
+	if (err)
+		return err;
+
 	inode = f2fs_new_inode(dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -583,6 +627,10 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int err;
 
+	err = dquot_initialize(dir);
+	if (err)
+		return err;
+
 	inode = f2fs_new_inode(dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -676,6 +724,14 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out;
 	}
 
+	err = dquot_initialize(old_dir);
+	if (err)
+		goto out;
+
+	err = dquot_initialize(new_dir);
+	if (err)
+		goto out;
+
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
@@ -856,6 +912,14 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 !fscrypt_has_permitted_context(old_dir, new_inode)))
 		return -EPERM;
 
+	err = dquot_initialize(old_dir);
+	if (err)
+		goto out;
+
+	err = dquot_initialize(new_dir);
+	if (err)
+		goto out;
+
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b9f14ba6441f..3ed2f947f5da 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1040,10 +1040,9 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
-	if (unlikely(!inc_valid_node_count(sbi, dn->inode, !ofs))) {
-		err = -ENOSPC;
+	if (unlikely((err = inc_valid_node_count(sbi, dn->inode, !ofs))))
 		goto fail;
-	}
+
 #ifdef CONFIG_F2FS_CHECK_FS
 	get_node_info(sbi, dn->nid, &new_ni);
 	f2fs_bug_on(sbi, new_ni.blk_addr != NULL_ADDR);
@@ -2210,7 +2209,7 @@ int recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
 	/* 2: update xattr nid in inode */
 	remove_free_nid(sbi, new_xnid);
 	f2fs_i_xnid_write(inode, new_xnid);
-	if (unlikely(!inc_valid_node_count(sbi, inode, false)))
+	if (unlikely(inc_valid_node_count(sbi, inode, false)))
 		f2fs_bug_on(sbi, 1);
 	update_inode_page(inode);
 
@@ -2268,7 +2267,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	new_ni = old_ni;
 	new_ni.ino = ino;
 
-	if (unlikely(!inc_valid_node_count(sbi, NULL, true)))
+	if (unlikely(inc_valid_node_count(sbi, NULL, true)))
 		WARN_ON(1);
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 	inc_valid_inode_count(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af472f7968d0..dd92170e0d6d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -22,6 +22,7 @@
 #include <linux/random.h>
 #include <linux/exportfs.h>
 #include <linux/blkdev.h>
+#include <linux/quotaops.h>
 #include <linux/f2fs_fs.h>
 #include <linux/sysfs.h>
 
@@ -106,6 +107,8 @@ enum {
 	Opt_fault_injection,
 	Opt_lazytime,
 	Opt_nolazytime,
+	Opt_usrquota,
+	Opt_grpquota,
 	Opt_err,
 };
 
@@ -141,6 +144,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_lazytime, "lazytime"},
 	{Opt_nolazytime, "nolazytime"},
+	{Opt_usrquota, "usrquota"},
+	{Opt_grpquota, "grpquota"},
 	{Opt_err, NULL},
 };
 
@@ -380,6 +385,20 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_nolazytime:
 			sb->s_flags &= ~MS_LAZYTIME;
 			break;
+#ifdef CONFIG_QUOTA
+		case Opt_usrquota:
+			set_opt(sbi, USRQUOTA);
+			break;
+		case Opt_grpquota:
+			set_opt(sbi, GRPQUOTA);
+			break;
+#else
+		case Opt_usrquota:
+		case Opt_grpquota:
+			f2fs_msg(sb, KERN_INFO,
+					"quota operations not supported");
+			break;
+#endif
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -421,6 +440,10 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_rwsem(&fi->dio_rwsem[WRITE]);
 	init_rwsem(&fi->i_mmap_sem);
 
+#ifdef CONFIG_QUOTA
+	memset(&fi->i_dquot, 0, sizeof(fi->i_dquot));
+	fi->i_reserved_quota = 0;
+#endif
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 	return &fi->vfs_inode;
@@ -561,11 +584,14 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	kfree(sbi->devs);
 }
 
+static void f2fs_quota_off_umount(struct super_block *sb);
 static void f2fs_put_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int i;
 
+	f2fs_quota_off_umount(sb);
+
 	/* prevent remaining shrinker jobs */
 	mutex_lock(&sbi->umount_mutex);
 
@@ -782,6 +808,12 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",fault_injection=%u",
 				sbi->fault_info.inject_rate);
 #endif
+#ifdef CONFIG_QUOTA
+	if (test_opt(sbi, USRQUOTA))
+		seq_puts(seq, ",usrquota");
+	if (test_opt(sbi, GRPQUOTA))
+		seq_puts(seq, ",grpquota");
+#endif
 
 	return 0;
 }
@@ -822,6 +854,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct f2fs_mount_info org_mount_opt;
+	unsigned long old_sb_flags;
 	int err, active_logs;
 	bool need_restart_gc = false;
 	bool need_stop_gc = false;
@@ -835,6 +868,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * need to restore them.
 	 */
 	org_mount_opt = sbi->mount_opt;
+	old_sb_flags = sb->s_flags;
 	active_logs = sbi->active_logs;
 
 	/* recover superblocks we couldn't write due to previous RO mount */
@@ -860,6 +894,16 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (f2fs_readonly(sb) && (*flags & MS_RDONLY))
 		goto skip;
 
+	if (!f2fs_readonly(sb) && (*flags & MS_RDONLY)) {
+		err = dquot_suspend(sb, -1);
+		if (err < 0)
+			goto restore_opts;
+	} else {
+		/* dquot_resume needs RW */
+		sb->s_flags &= ~MS_RDONLY;
+		dquot_resume(sb, -1);
+	}
+
 	/* disallow enable/disable extent_cache dynamically */
 	if (no_extent_cache == !!test_opt(sbi, EXTENT_CACHE)) {
 		err = -EINVAL;
@@ -924,12 +968,237 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 restore_opts:
 	sbi->mount_opt = org_mount_opt;
 	sbi->active_logs = active_logs;
+	sb->s_flags = old_sb_flags;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	sbi->fault_info = ffi;
 #endif
 	return err;
 }
 
+#ifdef CONFIG_QUOTA
+/* Read data from quotafile */
+static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
+			       size_t len, loff_t off)
+{
+	struct inode *inode = sb_dqopt(sb)->files[type];
+	struct address_space *mapping = inode->i_mapping;
+	block_t blkidx = F2FS_BYTES_TO_BLK(off);
+	int offset = off & (sb->s_blocksize - 1);
+	int tocopy;
+	size_t toread;
+	loff_t i_size = i_size_read(inode);
+	struct page *page;
+	char *kaddr;
+
+	if (off > i_size)
+		return 0;
+
+	if (off + len > i_size)
+		len = i_size - off;
+	toread = len;
+	while (toread > 0) {
+		tocopy = min_t(unsigned long, sb->s_blocksize - offset, toread);
+repeat:
+		page = read_mapping_page(mapping, blkidx, NULL);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		lock_page(page);
+
+		if (unlikely(page->mapping != mapping)) {
+			f2fs_put_page(page, 1);
+			goto repeat;
+		}
+		if (unlikely(!PageUptodate(page))) {
+			f2fs_put_page(page, 1);
+			return -EIO;
+		}
+
+		kaddr = kmap_atomic(page);
+		memcpy(data, kaddr + offset, tocopy);
+		kunmap_atomic(kaddr);
+		f2fs_put_page(page, 1);
+
+		offset = 0;
+		toread -= tocopy;
+		data += tocopy;
+		blkidx++;
+	}
+	return len;
+}
+
+/* Write to quotafile */
+static ssize_t f2fs_quota_write(struct super_block *sb, int type,
+				const char *data, size_t len, loff_t off)
+{
+	struct inode *inode = sb_dqopt(sb)->files[type];
+	struct address_space *mapping = inode->i_mapping;
+	const struct address_space_operations *a_ops = mapping->a_ops;
+	int offset = off & (sb->s_blocksize - 1);
+	size_t towrite = len;
+	struct page *page;
+	char *kaddr;
+	int err = 0;
+	int tocopy;
+
+	while (towrite > 0) {
+		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
+								towrite);
+
+		err = a_ops->write_begin(NULL, mapping, off, tocopy, 0,
+							&page, NULL);
+		if (unlikely(err))
+			break;
+
+		kaddr = kmap_atomic(page);
+		memcpy(kaddr + offset, data, tocopy);
+		kunmap_atomic(kaddr);
+		flush_dcache_page(page);
+
+		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
+						page, NULL);
+		offset = 0;
+		towrite -= tocopy;
+		off += tocopy;
+		data += tocopy;
+		cond_resched();
+	}
+
+	if (len == towrite)
+		return err;
+	inode->i_version++;
+	inode->i_mtime = inode->i_ctime = current_time(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
+	return len - towrite;
+}
+
+static struct dquot **f2fs_get_dquots(struct inode *inode)
+{
+	return F2FS_I(inode)->i_dquot;
+}
+
+static qsize_t *f2fs_get_reserved_space(struct inode *inode)
+{
+	return &F2FS_I(inode)->i_reserved_quota;
+}
+
+static int f2fs_quota_sync(struct super_block *sb, int type)
+{
+	struct quota_info *dqopt = sb_dqopt(sb);
+	int cnt;
+	int ret;
+
+	ret = dquot_writeback_dquots(sb, type);
+	if (ret)
+		return ret;
+
+	/*
+	 * Now when everything is written we can discard the pagecache so
+	 * that userspace sees the changes.
+	 */
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		if (type != -1 && cnt != type)
+			continue;
+		if (!sb_has_quota_active(sb, cnt))
+			continue;
+
+		ret = filemap_write_and_wait(dqopt->files[cnt]->i_mapping);
+		if (ret)
+			return ret;
+
+		inode_lock(dqopt->files[cnt]);
+		truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
+		inode_unlock(dqopt->files[cnt]);
+	}
+	return 0;
+}
+
+static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
+							const struct path *path)
+{
+	struct inode *inode;
+	int err;
+
+	err = f2fs_quota_sync(sb, -1);
+	if (err)
+		return err;
+
+	err = dquot_quota_on(sb, type, format_id, path);
+	if (err)
+		return err;
+
+	inode = d_inode(path->dentry);
+
+	inode_lock(inode);
+	F2FS_I(inode)->i_flags |= FS_NOATIME_FL | FS_IMMUTABLE_FL;
+	inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
+					S_NOATIME | S_IMMUTABLE);
+	inode_unlock(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
+
+	return 0;
+}
+
+static int f2fs_quota_off(struct super_block *sb, int type)
+{
+	struct inode *inode = sb_dqopt(sb)->files[type];
+	int err;
+
+	if (!inode || !igrab(inode))
+		return dquot_quota_off(sb, type);
+
+	f2fs_quota_sync(sb, -1);
+
+	err = dquot_quota_off(sb, type);
+	if (err)
+		goto out_put;
+
+	inode_lock(inode);
+	F2FS_I(inode)->i_flags &= ~(FS_NOATIME_FL | FS_IMMUTABLE_FL);
+	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
+	inode_unlock(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
+out_put:
+	iput(inode);
+	return err;
+}
+
+static void f2fs_quota_off_umount(struct super_block *sb)
+{
+	int type;
+
+	for (type = 0; type < MAXQUOTAS; type++)
+		f2fs_quota_off(sb, type);
+}
+
+static const struct dquot_operations f2fs_quota_operations = {
+	.get_reserved_space = f2fs_get_reserved_space,
+	.write_dquot	= dquot_commit,
+	.acquire_dquot	= dquot_acquire,
+	.release_dquot	= dquot_release,
+	.mark_dirty	= dquot_mark_dquot_dirty,
+	.write_info	= dquot_commit_info,
+	.alloc_dquot	= dquot_alloc,
+	.destroy_dquot	= dquot_destroy,
+	.get_next_id	= dquot_get_next_id,
+};
+
+static const struct quotactl_ops f2fs_quotactl_ops = {
+	.quota_on	= f2fs_quota_on,
+	.quota_off	= f2fs_quota_off,
+	.quota_sync	= f2fs_quota_sync,
+	.get_state	= dquot_get_state,
+	.set_info	= dquot_set_dqinfo,
+	.get_dqblk	= dquot_get_dqblk,
+	.set_dqblk	= dquot_set_dqblk,
+	.get_nextdqblk	= dquot_get_next_dqblk,
+};
+#else
+static inline void f2fs_quota_off_umount(struct super_block *sb)
+{
+}
+#endif
+
 static struct super_operations f2fs_sops = {
 	.alloc_inode	= f2fs_alloc_inode,
 	.drop_inode	= f2fs_drop_inode,
@@ -937,6 +1206,11 @@ static struct super_operations f2fs_sops = {
 	.write_inode	= f2fs_write_inode,
 	.dirty_inode	= f2fs_dirty_inode,
 	.show_options	= f2fs_show_options,
+#ifdef CONFIG_QUOTA
+	.quota_read	= f2fs_quota_read,
+	.quota_write	= f2fs_quota_write,
+	.get_dquots	= f2fs_get_dquots,
+#endif
 	.evict_inode	= f2fs_evict_inode,
 	.put_super	= f2fs_put_super,
 	.sync_fs	= f2fs_sync_fs,
@@ -1679,6 +1953,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_max_links = F2FS_LINK_MAX;
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 
+#ifdef CONFIG_QUOTA
+	sb->dq_op = &f2fs_quota_operations;
+	sb->s_qcop = &f2fs_quotactl_ops;
+	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
+#endif
+
 	sb->s_op = &f2fs_sops;
 	sb->s_cop = &f2fs_cryptops;
 	sb->s_xattr = f2fs_xattr_handlers;
-- 
2.13.0.90.g1eb437020
