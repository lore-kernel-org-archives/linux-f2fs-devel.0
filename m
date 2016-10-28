From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/9] f2fs: Use generic zoned block device terminology
Date: Fri, 28 Oct 2016 16:55:30 +0900
Message-ID: <1477641337-12321-3-git-send-email-damien.lemoal@wdc.com>
References: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

SMR stands for "Shingled Magnetic Recording" which makes sense
only for hard disk drives (spinning rust). The ZBC/ZAC standards
enable management of SMR disks, but solid state drives may also
support those standards. So rename the HMSMR feature to BLKZONED
to avoid a HDD centric terminology. For the same reason, rename
f2fs_sb_mounted_hmsmr to f2fs_sb_mounted_blkzoned.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/data.c  | 2 +-
 fs/f2fs/f2fs.h  | 6 +++---
 fs/f2fs/super.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ae194f..803f30f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -110,7 +110,7 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 {
 	if (!is_read_io(bio_op(bio))) {
 		atomic_inc(&sbi->nr_wb_bios);
-		if (f2fs_sb_mounted_hmsmr(sbi->sb) &&
+		if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
 			current->plug && (type == DATA || type == NODE))
 			blk_finish_plug(current->plug);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9e8de18..2fc771a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -103,7 +103,7 @@ struct f2fs_mount_info {
 };
 
 #define F2FS_FEATURE_ENCRYPT	0x0001
-#define F2FS_FEATURE_HMSMR	0x0002
+#define F2FS_FEATURE_BLKZONED	0x0002
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -2412,9 +2412,9 @@ static inline int f2fs_sb_has_crypto(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_ENCRYPT);
 }
 
-static inline int f2fs_sb_mounted_hmsmr(struct super_block *sb)
+static inline int f2fs_sb_mounted_blkzoned(struct super_block *sb)
 {
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_HMSMR);
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_BLKZONED);
 }
 
 static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f6379f5..a83df29 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -975,7 +975,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, EXTENT_CACHE);
 	sbi->sb->s_flags |= MS_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-	if (f2fs_sb_mounted_hmsmr(sbi->sb)) {
+	if (f2fs_sb_mounted_blkzoned(sbi->sb)) {
 		set_opt_mode(sbi, F2FS_MOUNT_LFS);
 		set_opt(sbi, DISCARD);
 	} else {
-- 
2.7.4

