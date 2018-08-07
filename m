From: Junling Zheng <zhengjunling@huawei.com>
Subject: [RFC PATCH v2 1/3] f2fs: support superblock checksum
Date: Tue, 7 Aug 2018 17:39:53 +0800
Message-ID: <20180807093953.210487-1-zhengjunling@huawei.com>
References: <20180807091718.192688-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fmyTN-0005GT-1H
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 09:40:13 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fmyTK-00CCar-12
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 09:40:12 +0000
In-Reply-To: <20180807091718.192688-1-zhengjunling@huawei.com>
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

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
v1 -> v1:
 - fix to switch endian of crc.
 fs/f2fs/f2fs.h          |  1 +
 fs/f2fs/super.c         | 28 ++++++++++++++++++++++++++++
 include/linux/f2fs_fs.h |  3 ++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4525f4f82af0..d404ede01fcd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -147,6 +147,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
 #define F2FS_FEATURE_LOST_FOUND		0x0200
 #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
+#define F2FS_FEATURE_SB_CHKSUM		0x0800
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bd57be470e23..c782fab52a12 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2149,6 +2149,8 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 					(bh->b_data + F2FS_SUPER_OFFSET);
 	struct super_block *sb = sbi->sb;
 	unsigned int blocksize;
+	size_t crc_offset = 0;
+	__u32 crc = 0;
 
 	if (F2FS_SUPER_MAGIC != le32_to_cpu(raw_super->magic)) {
 		f2fs_msg(sb, KERN_INFO,
@@ -2283,6 +2285,23 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	if (sanity_check_area_boundary(sbi, bh))
 		return 1;
 
+	if (F2FS_HAS_FEATURE(sbi->sb, F2FS_FEATURE_SB_CHKSUM)) {
+		crc_offset = le32_to_cpu(raw_super->checksum_offset);
+		if (crc_offset !=
+			offsetof(struct f2fs_super_block, crc)) {
+			f2fs_msg(sb, KERN_INFO,
+				"Invalid SB checksum offset: %lu",
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
+
 	return 0;
 }
 
@@ -2568,6 +2587,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
 	struct buffer_head *bh;
+	__u32 crc = 0;
 	int err;
 
 	if ((recover && f2fs_readonly(sbi->sb)) ||
@@ -2576,6 +2596,14 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 		return -EROFS;
 	}
 
+	/* we should update superblock crc here */
+	if (!recover &&
+		F2FS_HAS_FEATURE(sbi->sb, F2FS_FEATURE_SB_CHKSUM)) {
+		crc = f2fs_crc32(sbi, F2FS_RAW_SUPER(sbi),
+				offsetof(struct f2fs_super_block, crc));
+		F2FS_RAW_SUPER(sbi)->crc = cpu_to_le32(crc);
+	}
+
 	/* write back-up superblock first */
 	bh = sb_bread(sbi->sb, sbi->valid_super_block ? 0 : 1);
 	if (!bh)
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
