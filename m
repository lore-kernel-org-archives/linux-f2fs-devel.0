From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: support inode creation time
Date: Thu, 25 Jan 2018 14:54:42 +0800
Message-ID: <20180125065442.18274-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds creation time field in inode layout to support showing
kstat.btime in ->statx.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- fix address alignment isue.
 fs/f2fs/f2fs.h          |  7 +++++++
 fs/f2fs/file.c          |  9 +++++++++
 fs/f2fs/inode.c         | 16 ++++++++++++++++
 fs/f2fs/namei.c         |  3 ++-
 fs/f2fs/sysfs.c         |  7 +++++++
 include/linux/f2fs_fs.h |  4 +++-
 6 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b7ba496af28f..6300ac5bcbe4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -124,6 +124,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_INODE_CHKSUM	0x0020
 #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
 #define F2FS_FEATURE_QUOTA_INO		0x0080
+#define F2FS_FEATURE_INODE_CRTIME	0x0100
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -635,6 +636,7 @@ struct f2fs_inode_info {
 	int i_extra_isize;		/* size of extra space located in i_addr */
 	kprojid_t i_projid;		/* id for project quota */
 	int i_inline_xattr_size;	/* inline xattr size */
+	struct timespec i_crtime;	/* inode creation time */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -3205,6 +3207,11 @@ static inline int f2fs_sb_has_quota_ino(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_QUOTA_INO);
 }
 
+static inline int f2fs_sb_has_inode_crtime(struct super_block *sb)
+{
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_INODE_CRTIME);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
 			struct block_device *bdev, block_t blkaddr)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 84306c718e68..672a542e5464 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -672,8 +672,17 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_inode *ri;
 	unsigned int flags;
 
+	if (f2fs_has_extra_attr(inode) &&
+			f2fs_sb_has_inode_crtime(inode->i_sb) &&
+			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_crtime)) {
+		stat->result_mask |= STATX_BTIME;
+		stat->btime.tv_sec = fi->i_crtime.tv_sec;
+		stat->btime.tv_nsec = fi->i_crtime.tv_nsec;
+	}
+
 	flags = fi->i_flags & (FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL);
 	if (flags & FS_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1dc77a40d0ad..99ee72bff628 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -278,6 +278,13 @@ static int do_read_inode(struct inode *inode)
 		i_projid = F2FS_DEF_PROJID;
 	fi->i_projid = make_kprojid(&init_user_ns, i_projid);
 
+	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_inode_crtime(sbi->sb) &&
+			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_crtime)) {
+		fi->i_crtime.tv_sec = le64_to_cpu(ri->i_crtime);
+		fi->i_crtime.tv_nsec = le32_to_cpu(ri->i_crtime_nsec);
+	}
+
+
 	f2fs_put_page(node_page, 1);
 
 	stat_inc_inline_xattr(inode);
@@ -421,6 +428,15 @@ void update_inode(struct inode *inode, struct page *node_page)
 						F2FS_I(inode)->i_projid);
 			ri->i_projid = cpu_to_le32(i_projid);
 		}
+
+		if (f2fs_sb_has_inode_crtime(F2FS_I_SB(inode)->sb) &&
+			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
+								i_crtime)) {
+			ri->i_crtime =
+				cpu_to_le64(F2FS_I(inode)->i_crtime.tv_sec);
+			ri->i_crtime_nsec =
+				cpu_to_le32(F2FS_I(inode)->i_crtime.tv_nsec);
+		}
 	}
 
 	__set_inode_rdev(inode, ri);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3ee97ba9d2d7..c4c94c7e9f4f 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -50,7 +50,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime =
+			F2FS_I(inode)->i_crtime = current_time(inode);
 	inode->i_generation = sbi->s_next_generation++;
 
 	err = insert_inode_locked(inode);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 41887e6ec1b3..d978c7b6ea04 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -113,6 +113,9 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (f2fs_sb_has_quota_ino(sb))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "quota_ino");
+	if (f2fs_sb_has_inode_crtime(sb))
+		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
+				len ? ", " : "", "inode_crtime");
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 	return len;
 }
@@ -232,6 +235,7 @@ enum feat_id {
 	FEAT_INODE_CHECKSUM,
 	FEAT_FLEXIBLE_INLINE_XATTR,
 	FEAT_QUOTA_INO,
+	FEAT_INODE_CRTIME,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
@@ -246,6 +250,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_INODE_CHECKSUM:
 	case FEAT_FLEXIBLE_INLINE_XATTR:
 	case FEAT_QUOTA_INO:
+	case FEAT_INODE_CRTIME:
 		return snprintf(buf, PAGE_SIZE, "supported\n");
 	}
 	return 0;
@@ -323,6 +328,7 @@ F2FS_FEATURE_RO_ATTR(project_quota, FEAT_PROJECT_QUOTA);
 F2FS_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);
 F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
+F2FS_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -376,6 +382,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(inode_checksum),
 	ATTR_LIST(flexible_inline_xattr),
 	ATTR_LIST(quota_ino),
+	ATTR_LIST(inode_crtime),
 	NULL,
 };
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 6eed677b6d9a..58aecb60ea51 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -253,8 +253,10 @@ struct f2fs_inode {
 			__le16 i_inline_xattr_size;	/* inline xattr size, unit: 4 bytes */
 			__le32 i_projid;	/* project id */
 			__le32 i_inode_checksum;/* inode meta checksum */
+			__le64 i_crtime;	/* creation time */
+			__le32 i_crtime_nsec;	/* creation time in nano scale */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
-		};
+		} __packed;
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
 	};
 	__le32 i_nid[DEF_NIDS_PER_INODE];	/* direct(2), indirect(2),
-- 
2.15.0.55.gc2ece9dc4de6
