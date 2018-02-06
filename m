From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 1/2] f2fs: clean up f2fs_sb_has_xxx functions
Date: Tue, 6 Feb 2018 12:31:17 +0800
Message-ID: <20180206043118.134137-2-shengyong1@huawei.com>
References: <20180206043118.134137-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eiuv4-00009U-LN
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 04:31:46 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eiuv3-0005JB-4p
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 04:31:46 +0000
In-Reply-To: <20180206043118.134137-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, miaoxie@huawei.com, shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch introduces F2FS_FEATURE_FUNCS to clean up the definitions of
different f2fs_sb_has_xxx functions.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/data.c    |  2 +-
 fs/f2fs/f2fs.h    | 51 +++++++++++++--------------------------------------
 fs/f2fs/file.c    |  6 +++---
 fs/f2fs/segment.c |  4 ++--
 fs/f2fs/super.c   | 14 +++++++-------
 fs/f2fs/sysfs.c   |  4 ++--
 6 files changed, 28 insertions(+), 53 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6cba74eb09a7..4eec9ad9493d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -196,7 +196,7 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 	if (!is_read_io(bio_op(bio))) {
 		unsigned int start;
 
-		if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
+		if (f2fs_sb_has_blkzoned(sbi->sb) &&
 			current->plug && (type == DATA || type == NODE))
 			blk_finish_plug(current->plug);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6300ac5bcbe4..a60d56a96f9b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3172,45 +3172,20 @@ static inline bool f2fs_bio_encrypted(struct bio *bio)
 	return bio->bi_private != NULL;
 }
 
-static inline int f2fs_sb_has_crypto(struct super_block *sb)
-{
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_ENCRYPT);
-}
-
-static inline int f2fs_sb_mounted_blkzoned(struct super_block *sb)
-{
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_BLKZONED);
+#define F2FS_FEATURE_FUNCS(name, flagname) \
+static inline int f2fs_sb_has_##name(struct super_block *sb) \
+{ \
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_##flagname); \
 }
 
-static inline int f2fs_sb_has_extra_attr(struct super_block *sb)
-{
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_EXTRA_ATTR);
-}
-
-static inline int f2fs_sb_has_project_quota(struct super_block *sb)
-{
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_PRJQUOTA);
-}
-
-static inline int f2fs_sb_has_inode_chksum(struct super_block *sb)
-{
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_INODE_CHKSUM);
-}
-
-static inline int f2fs_sb_has_flexible_inline_xattr(struct super_block *sb)
-{
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
-}
-
-static inline int f2fs_sb_has_quota_ino(struct super_block *sb)
-{
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_QUOTA_INO);
-}
-
-static inline int f2fs_sb_has_inode_crtime(struct super_block *sb)
-{
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_INODE_CRTIME);
-}
+F2FS_FEATURE_FUNCS(encrypt, ENCRYPT);
+F2FS_FEATURE_FUNCS(blkzoned, BLKZONED);
+F2FS_FEATURE_FUNCS(extra_attr, EXTRA_ATTR);
+F2FS_FEATURE_FUNCS(project_quota, PRJQUOTA);
+F2FS_FEATURE_FUNCS(inode_chksum, INODE_CHKSUM);
+F2FS_FEATURE_FUNCS(flexible_inline_xattr, FLEXIBLE_INLINE_XATTR);
+F2FS_FEATURE_FUNCS(quota_ino, QUOTA_INO);
+F2FS_FEATURE_FUNCS(inode_crtime, INODE_CRTIME);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
@@ -3230,7 +3205,7 @@ static inline bool f2fs_discard_en(struct f2fs_sb_info *sbi)
 {
 	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
 
-	return blk_queue_discard(q) || f2fs_sb_mounted_blkzoned(sbi->sb);
+	return blk_queue_discard(q) || f2fs_sb_has_blkzoned(sbi->sb);
 }
 
 static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 672a542e5464..29956e16c58c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1938,7 +1938,7 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 
-	if (!f2fs_sb_has_crypto(inode->i_sb))
+	if (!f2fs_sb_has_encrypt(inode->i_sb))
 		return -EOPNOTSUPP;
 
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
@@ -1948,7 +1948,7 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 
 static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
 {
-	if (!f2fs_sb_has_crypto(file_inode(filp)->i_sb))
+	if (!f2fs_sb_has_encrypt(file_inode(filp)->i_sb))
 		return -EOPNOTSUPP;
 	return fscrypt_ioctl_get_policy(filp, (void __user *)arg);
 }
@@ -1959,7 +1959,7 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
-	if (!f2fs_sb_has_crypto(inode->i_sb))
+	if (!f2fs_sb_has_encrypt(inode->i_sb))
 		return -EOPNOTSUPP;
 
 	if (uuid_is_nonzero(sbi->raw_super->encrypt_pw_salt))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b16a8e6625aa..860d0cfd624a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1485,7 +1485,7 @@ static int __issue_discard_async(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
 #ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
+	if (f2fs_sb_has_blkzoned(sbi->sb) &&
 				bdev_zoned_model(bdev) != BLK_ZONED_NONE)
 		return __f2fs_issue_discard_zone(sbi, bdev, blkstart, blklen);
 #endif
@@ -1683,7 +1683,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 					sbi->blocks_per_seg, cur_pos);
 			len = next_pos - cur_pos;
 
-			if (f2fs_sb_mounted_blkzoned(sbi->sb) ||
+			if (f2fs_sb_has_blkzoned(sbi->sb) ||
 			    (force && len < cpc->trim_minlen))
 				goto skip;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8173ae688814..b39ab55ab1b5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -403,14 +403,14 @@ static int parse_options(struct super_block *sb, char *options)
 			q = bdev_get_queue(sb->s_bdev);
 			if (blk_queue_discard(q)) {
 				set_opt(sbi, DISCARD);
-			} else if (!f2fs_sb_mounted_blkzoned(sb)) {
+			} else if (!f2fs_sb_has_blkzoned(sb)) {
 				f2fs_msg(sb, KERN_WARNING,
 					"mounting with \"discard\" option, but "
 					"the device does not support discard");
 			}
 			break;
 		case Opt_nodiscard:
-			if (f2fs_sb_mounted_blkzoned(sb)) {
+			if (f2fs_sb_has_blkzoned(sb)) {
 				f2fs_msg(sb, KERN_WARNING,
 					"discard is required for zoned block devices");
 				return -EINVAL;
@@ -559,7 +559,7 @@ static int parse_options(struct super_block *sb, char *options)
 				return -ENOMEM;
 			if (strlen(name) == 8 &&
 					!strncmp(name, "adaptive", 8)) {
-				if (f2fs_sb_mounted_blkzoned(sb)) {
+				if (f2fs_sb_has_blkzoned(sb)) {
 					f2fs_msg(sb, KERN_WARNING,
 						 "adaptive mode is not allowed with "
 						 "zoned block device feature");
@@ -1243,7 +1243,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, NOHEAP);
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-	if (f2fs_sb_mounted_blkzoned(sbi->sb)) {
+	if (f2fs_sb_has_blkzoned(sbi->sb)) {
 		set_opt_mode(sbi, F2FS_MOUNT_LFS);
 		set_opt(sbi, DISCARD);
 	} else {
@@ -2206,7 +2206,7 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	unsigned int n = 0;
 	int err = -EIO;
 
-	if (!f2fs_sb_mounted_blkzoned(sbi->sb))
+	if (!f2fs_sb_has_blkzoned(sbi->sb))
 		return 0;
 
 	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
@@ -2413,7 +2413,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 		if (bdev_zoned_model(FDEV(i).bdev) == BLK_ZONED_HM &&
-				!f2fs_sb_mounted_blkzoned(sbi->sb)) {
+				!f2fs_sb_has_blkzoned(sbi->sb)) {
 			f2fs_msg(sbi->sb, KERN_ERR,
 				"Zoned block device feature not enabled\n");
 			return -EINVAL;
@@ -2508,7 +2508,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * devices, but mandatory for host-managed zoned block devices.
 	 */
 #ifndef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_mounted_blkzoned(sb)) {
+	if (f2fs_sb_has_blkzoned(sb)) {
 		f2fs_msg(sb, KERN_ERR,
 			 "Zoned block device support is not enabled\n");
 		err = -EOPNOTSUPP;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index d978c7b6ea04..374ee5c82f94 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -92,10 +92,10 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (!sb->s_bdev->bd_part)
 		return snprintf(buf, PAGE_SIZE, "0\n");
 
-	if (f2fs_sb_has_crypto(sb))
+	if (f2fs_sb_has_encrypt(sb))
 		len += snprintf(buf, PAGE_SIZE - len, "%s",
 						"encryption");
-	if (f2fs_sb_mounted_blkzoned(sb))
+	if (f2fs_sb_has_blkzoned(sb))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "blkzoned");
 	if (f2fs_sb_has_extra_attr(sb))
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
