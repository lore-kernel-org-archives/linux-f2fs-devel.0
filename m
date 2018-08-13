From: Junling Zheng <zhengjunling@huawei.com>
Subject: [RFC PATCH RESEND 1/4] f2fs: support superblock checksum
Date: Mon, 13 Aug 2018 21:32:08 +0800
Message-ID: <20180813133211.243529-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fpCxT-0000fI-AO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Aug 2018 13:32:31 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fpCxR-00GsXa-7R
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Aug 2018 13:32:31 +0000
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Now we support crc32 checksum for superblock.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fs/f2fs/f2fs.h          |  2 ++
 fs/f2fs/super.c         | 29 +++++++++++++++++++++++++++++
 fs/f2fs/sysfs.c         |  7 +++++++
 include/linux/f2fs_fs.h |  3 ++-
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4525f4f82af0..d50d6efda96b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -147,6 +147,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
 #define F2FS_FEATURE_LOST_FOUND		0x0200
 #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
+#define F2FS_FEATURE_SB_CHKSUM		0x0800
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -3376,6 +3377,7 @@ F2FS_FEATURE_FUNCS(flexible_inline_xattr, FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_FUNCS(quota_ino, QUOTA_INO);
 F2FS_FEATURE_FUNCS(inode_crtime, INODE_CRTIME);
 F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
+F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bd57be470e23..3ffc336caea8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2149,6 +2149,26 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 					(bh->b_data + F2FS_SUPER_OFFSET);
 	struct super_block *sb = sbi->sb;
 	unsigned int blocksize;
+	size_t crc_offset = 0;
+	__u32 crc = 0;
+
+	/* Check checksum_offset and crc in superblock */
+	if (le32_to_cpu(raw_super->feature) & F2FS_FEATURE_SB_CHKSUM) {
+		crc_offset = le32_to_cpu(raw_super->checksum_offset);
+		if (crc_offset !=
+			offsetof(struct f2fs_super_block, crc)) {
+			f2fs_msg(sb, KERN_INFO,
+				"Invalid SB checksum offset: %zu",
+				crc_offset);
+			return 1;
+		}
+		crc = le32_to_cpu(raw_super->crc);
+		if (!f2fs_crc_valid(sbi, crc, raw_super, crc_offset)) {
+			f2fs_msg(sb, KERN_INFO,
+				"Invalid SB checksum value: %u", crc);
+			return 1;
+		}
+	}
 
 	if (F2FS_SUPER_MAGIC != le32_to_cpu(raw_super->magic)) {
 		f2fs_msg(sb, KERN_INFO,
@@ -2568,6 +2588,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
 	struct buffer_head *bh;
+	__u32 crc = 0;
 	int err;
 
 	if ((recover && f2fs_readonly(sbi->sb)) ||
@@ -2576,6 +2597,13 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 		return -EROFS;
 	}
 
+	/* we should update superblock crc here */
+	if (!recover && f2fs_sb_has_sb_chksum(sbi->sb)) {
+		crc = f2fs_crc32(sbi, F2FS_RAW_SUPER(sbi),
+				offsetof(struct f2fs_super_block, crc));
+		F2FS_RAW_SUPER(sbi)->crc = cpu_to_le32(crc);
+	}
+
 	/* write back-up superblock first */
 	bh = sb_bread(sbi->sb, sbi->valid_super_block ? 0 : 1);
 	if (!bh)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index cd2e030e47b8..c86d91be6c48 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -120,6 +120,9 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (f2fs_sb_has_lost_found(sb))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "lost_found");
+	if (f2fs_sb_has_sb_chksum(sb))
+		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
+				len ? ", " : "", "sb_checksum");
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 	return len;
 }
@@ -337,6 +340,7 @@ enum feat_id {
 	FEAT_QUOTA_INO,
 	FEAT_INODE_CRTIME,
 	FEAT_LOST_FOUND,
+	FEAT_SB_CHECKSUM,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
@@ -353,6 +357,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_QUOTA_INO:
 	case FEAT_INODE_CRTIME:
 	case FEAT_LOST_FOUND:
+	case FEAT_SB_CHECKSUM:
 		return snprintf(buf, PAGE_SIZE, "supported\n");
 	}
 	return 0;
@@ -433,6 +438,7 @@ F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
 F2FS_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
 F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
+F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -489,6 +495,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(quota_ino),
 	ATTR_LIST(inode_crtime),
 	ATTR_LIST(lost_found),
+	ATTR_LIST(sb_checksum),
 	NULL,
 };
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f70f8ac9c4f4..aa4b586569c1 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -112,7 +112,8 @@ struct f2fs_super_block {
 	struct f2fs_device devs[MAX_DEVICES];	/* device list */
 	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
 	__u8 hot_ext_count;		/* # of hot file extension */
-	__u8 reserved[314];		/* valid reserved region */
+	__u8 reserved[310];		/* valid reserved region */
+	__le32 crc;			/* checksum of superblock */
 } __packed;
 
 /*
-- 
2.18.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
