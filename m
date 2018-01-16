From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v4] f2fs: add an ioctl to disable GC for
 specific file
Date: Tue, 16 Jan 2018 15:57:19 -0800
Message-ID: <20180116235719.GA22470@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171208051555.76998-1-jaegeuk@kernel.org>
 <20171208193723.GA87676@jaegeuk-macbookpro.roam.corp.google.com>
 <20171228034020.GF13490@jaegeuk-macbookpro.roam.corp.google.com>
 <20180103032151.GC3995@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ebb6d-0005Yn-6n
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Jan 2018 23:57:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ebb6b-0000V6-Qg
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Jan 2018 23:57:27 +0000
Content-Disposition: inline
In-Reply-To: <20180103032151.GC3995@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch gives a flag to disable GC on given file, which would be useful, when
user wants to keep its block map. It also conducts in-place-update for dontmove
file.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v3:
 - add F2FS_IOC_GET_PIN_FILE
 - fix to reset i_gc_failures as 1, not 0

 fs/f2fs/data.c          |  2 ++
 fs/f2fs/f2fs.h          | 29 ++++++++++++++++-
 fs/f2fs/file.c          | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/gc.c            | 11 +++++++
 fs/f2fs/gc.h            |  2 ++
 fs/f2fs/sysfs.c         |  2 ++
 include/linux/f2fs_fs.h |  9 +++++-
 7 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cde2a3264b4c..945f15607484 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1479,6 +1479,8 @@ static inline bool need_inplace_update(struct f2fs_io_info *fio)
 {
 	struct inode *inode = fio->page->mapping->host;
 
+	if (f2fs_is_pinned_file(inode))
+		return true;
 	if (S_ISDIR(inode->i_mode) || f2fs_is_atomic_file(inode))
 		return false;
 	if (is_cold_data(fio->page))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2da378c9d7d7..fa36a445ceda 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -356,6 +356,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
 						struct f2fs_gc_range)
 #define F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, 12, __u32)
+#define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
+#define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
@@ -593,7 +595,10 @@ struct f2fs_inode_info {
 	unsigned long i_flags;		/* keep an inode flags for ioctl */
 	unsigned char i_advise;		/* use to give file attribute hints */
 	unsigned char i_dir_level;	/* use for dentry level for large dir */
-	unsigned int i_current_depth;	/* use only in directory structure */
+	union {
+		unsigned int i_current_depth;	/* only for directory depth */
+		unsigned short i_gc_failures;	/* only for regular file */
+	};
 	unsigned int i_pino;		/* parent inode number */
 	umode_t i_acl_mode;		/* keep file acl mode temporarily */
 
@@ -1142,6 +1147,9 @@ struct f2fs_sb_info {
 	/* threshold for converting bg victims for fg */
 	u64 fggc_threshold;
 
+	/* threshold for gc trials on pinned files */
+	u64 gc_pin_file_threshold;
+
 	/* maximum # of trials to find a victim segment for SSR and GC */
 	unsigned int max_victim_search;
 
@@ -2144,6 +2152,7 @@ enum {
 	FI_HOT_DATA,		/* indicate file is hot */
 	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
 	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
+	FI_PIN_FILE,		/* indicate file should not be gced */
 };
 
 static inline void __mark_inode_dirty_flag(struct inode *inode,
@@ -2158,6 +2167,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 			return;
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
+	case FI_PIN_FILE:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
@@ -2238,6 +2248,13 @@ static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
+static inline void f2fs_i_gc_failures_write(struct inode *inode,
+					unsigned int count)
+{
+	F2FS_I(inode)->i_gc_failures = count;
+	f2fs_mark_inode_dirty_sync(inode, true);
+}
+
 static inline void f2fs_i_xnid_write(struct inode *inode, nid_t xnid)
 {
 	F2FS_I(inode)->i_xattr_nid = xnid;
@@ -2266,6 +2283,8 @@ static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 		set_bit(FI_INLINE_DOTS, &fi->flags);
 	if (ri->i_inline & F2FS_EXTRA_ATTR)
 		set_bit(FI_EXTRA_ATTR, &fi->flags);
+	if (ri->i_inline & F2FS_PIN_FILE)
+		set_bit(FI_PIN_FILE, &fi->flags);
 }
 
 static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
@@ -2284,6 +2303,8 @@ static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
 		ri->i_inline |= F2FS_INLINE_DOTS;
 	if (is_inode_flag_set(inode, FI_EXTRA_ATTR))
 		ri->i_inline |= F2FS_EXTRA_ATTR;
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		ri->i_inline |= F2FS_PIN_FILE;
 }
 
 static inline int f2fs_has_extra_attr(struct inode *inode)
@@ -2329,6 +2350,11 @@ static inline int f2fs_has_inline_dots(struct inode *inode)
 	return is_inode_flag_set(inode, FI_INLINE_DOTS);
 }
 
+static inline bool f2fs_is_pinned_file(struct inode *inode)
+{
+	return is_inode_flag_set(inode, FI_PIN_FILE);
+}
+
 static inline bool f2fs_is_atomic_file(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_ATOMIC_FILE);
@@ -2543,6 +2569,7 @@ int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int f2fs_pin_file_control(struct inode *inode, bool inc);
 
 /*
  * inode.c
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05779077cbf2..7a50cffe34b9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2672,6 +2672,82 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 	return 0;
 }
 
+int f2fs_pin_file_control(struct inode *inode, bool inc)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	/* Use i_gc_failures for normal file as a risk signal. */
+	if (inc)
+		f2fs_i_gc_failures_write(inode, fi->i_gc_failures + 1);
+
+	if (fi->i_gc_failures > sbi->gc_pin_file_threshold) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"%s: Enable GC = ino %lx after %x GC trials\n",
+			__func__, inode->i_ino, fi->i_gc_failures);
+		return -EAGAIN;
+	}
+	return 0;
+}
+
+static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	__u32 pin;
+	int ret = 0;
+
+	if (!inode_owner_or_capable(inode))
+		return -EACCES;
+
+	if (get_user(pin, (__u32 __user *)arg))
+		return -EFAULT;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+		return -EROFS;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	inode_lock(inode);
+
+	if (!pin) {
+		clear_inode_flag(inode, FI_PIN_FILE);
+		F2FS_I(inode)->i_gc_failures = 1;
+		goto done;
+	}
+
+	if (f2fs_pin_file_control(inode, false)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		goto out;
+
+	set_inode_flag(inode, FI_PIN_FILE);
+	ret = F2FS_I(inode)->i_gc_failures;
+done:
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+out:
+	inode_unlock(inode);
+	mnt_drop_write_file(filp);
+	return ret;
+}
+
+static int f2fs_ioc_get_pin_file(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	__u32 pin = 0;
+
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		pin = F2FS_I(inode)->i_gc_failures;
+	return put_user(pin, (u32 __user *)arg);
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -2722,6 +2798,10 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_fsgetxattr(filp, arg);
 	case F2FS_IOC_FSSETXATTR:
 		return f2fs_ioc_fssetxattr(filp, arg);
+	case F2FS_IOC_GET_PIN_FILE:
+		return f2fs_ioc_get_pin_file(filp, arg);
+	case F2FS_IOC_SET_PIN_FILE:
+		return f2fs_ioc_set_pin_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -2797,6 +2877,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_FEATURES:
 	case F2FS_IOC_FSGETXATTR:
 	case F2FS_IOC_FSSETXATTR:
+	case F2FS_IOC_GET_PIN_FILE:
+	case F2FS_IOC_SET_PIN_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d844dcb80570..33e79697e41c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -624,6 +624,11 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (f2fs_is_atomic_file(inode))
 		goto out;
 
+	if (f2fs_is_pinned_file(inode)) {
+		f2fs_pin_file_control(inode, true);
+		goto out;
+	}
+
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
 	if (err)
@@ -720,6 +725,11 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 
 	if (f2fs_is_atomic_file(inode))
 		goto out;
+	if (f2fs_is_pinned_file(inode)) {
+		if (gc_type == FG_GC)
+			f2fs_pin_file_control(inode, true);
+		goto out;
+	}
 
 	if (gc_type == BG_GC) {
 		if (PageWriteback(page))
@@ -1091,6 +1101,7 @@ void build_gc_manager(struct f2fs_sb_info *sbi)
 
 	sbi->fggc_threshold = div64_u64((main_count - ovp_count) *
 				BLKS_PER_SEC(sbi), (main_count - resv_count));
+	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
 
 	/* give warm/cold data area from slower device */
 	if (sbi->s_ndevs && sbi->segs_per_sec == 1)
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 9325191fab2d..33310165cb78 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -20,6 +20,8 @@
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
+#define DEF_GC_FAILED_PINNED_FILES	1024
+
 /* Search max. number of dirty segments to select a victim segment */
 #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ab6028c332aa..41887e6ec1b3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -301,6 +301,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
 F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
@@ -349,6 +350,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(idle_interval),
 	ATTR_LIST(iostat_enable),
 	ATTR_LIST(readdir_ra),
+	ATTR_LIST(gc_pin_file_thresh),
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	ATTR_LIST(inject_rate),
 	ATTR_LIST(inject_type),
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 43e98d30d2df..cfb522e6affc 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -212,6 +212,7 @@ struct f2fs_extent {
 #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
 #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
 #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
+#define F2FS_PIN_FILE		0x40	/* file should not be gced */
 
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
@@ -229,7 +230,13 @@ struct f2fs_inode {
 	__le32 i_ctime_nsec;		/* change time in nano scale */
 	__le32 i_mtime_nsec;		/* modification time in nano scale */
 	__le32 i_generation;		/* file version (for NFS) */
-	__le32 i_current_depth;		/* only for directory depth */
+	union {
+		__le32 i_current_depth;	/* only for directory depth */
+		__le16 i_gc_failures;	/*
+					 * # of gc failures on pinned file.
+					 * only for regular files.
+					 */
+	};
 	__le32 i_xattr_nid;		/* nid to save xattr */
 	__le32 i_flags;			/* file attributes */
 	__le32 i_pino;			/* parent inode number */
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
