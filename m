From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: recover superblock at RW remounts
Date: Wed, 23 Mar 2016 18:31:26 -0700
Message-ID: <1458783087-32233-3-git-send-email-jaegeuk@kernel.org>
References: <1458783087-32233-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aiu7h-0004Yn-4A
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Mar 2016 01:31:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aiu7g-0005g9-30
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Mar 2016 01:31:41 +0000
In-Reply-To: <1458783087-32233-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds a sbi flag, SBI_NEED_SB_WRITE, which indicates it needs to
recover superblock when (re)mounting as RW. This is set only when f2fs is
mounted as RO.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 36 +++++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bbe2cd1..286e917 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -672,6 +672,7 @@ enum {
 	SBI_IS_CLOSE,				/* specify unmounting */
 	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
 	SBI_POR_DOING,				/* recovery is doing or not */
+	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 };
 
 enum {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 742fc48..5718187 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -796,6 +796,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 	}
 
+	/* recover superblocks we couldn't write due to previous RO mount */
+	if (!(*flags & MS_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
+		err = f2fs_commit_super(sbi, false);
+		f2fs_msg(sb, KERN_INFO,
+			"Try to recover all the superblocks, ret: %d", err);
+		if (!err)
+			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
+	}
+
 	sync_filesystem(sb);
 
 	sbi->mount_opt.opt = 0;
@@ -852,8 +861,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	}
 skip:
 	/* Update the POSIXACL Flag */
-	 sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
+	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? MS_POSIXACL : 0);
+
 	return 0;
 restore_gc:
 	if (need_restart_gc) {
@@ -998,11 +1008,12 @@ static int __f2fs_commit_super(struct buffer_head *bh,
 	return __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
 }
 
-static inline bool sanity_check_area_boundary(struct super_block *sb,
+static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 					struct buffer_head *bh)
 {
 	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
 					(bh->b_data + F2FS_SUPER_OFFSET);
+	struct super_block *sb = sbi->sb;
 	u32 segment0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
 	u32 cp_blkaddr = le32_to_cpu(raw_super->cp_blkaddr);
 	u32 sit_blkaddr = le32_to_cpu(raw_super->sit_blkaddr);
@@ -1081,6 +1092,7 @@ static inline bool sanity_check_area_boundary(struct super_block *sb,
 				segment0_blkaddr) >> log_blocks_per_seg);
 
 		if (f2fs_readonly(sb) || bdev_read_only(sb->s_bdev)) {
+			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 			res = "internally";
 		} else {
 			err = __f2fs_commit_super(bh, NULL);
@@ -1098,11 +1110,12 @@ static inline bool sanity_check_area_boundary(struct super_block *sb,
 	return false;
 }
 
-static int sanity_check_raw_super(struct super_block *sb,
+static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 				struct buffer_head *bh)
 {
 	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
 					(bh->b_data + F2FS_SUPER_OFFSET);
+	struct super_block *sb = sbi->sb;
 	unsigned int blocksize;
 
 	if (F2FS_SUPER_MAGIC != le32_to_cpu(raw_super->magic)) {
@@ -1169,7 +1182,7 @@ static int sanity_check_raw_super(struct super_block *sb,
 	}
 
 	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
-	if (sanity_check_area_boundary(sb, bh))
+	if (sanity_check_area_boundary(sbi, bh))
 		return 1;
 
 	return 0;
@@ -1239,10 +1252,11 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
  * to get the first valid one. If any one of them is broken, we pass
  * them recovery flag back to the caller.
  */
-static int read_raw_super_block(struct super_block *sb,
+static int read_raw_super_block(struct f2fs_sb_info *sbi,
 			struct f2fs_super_block **raw_super,
 			int *valid_super_block, int *recovery)
 {
+	struct super_block *sb = sbi->sb;
 	int block;
 	struct buffer_head *bh;
 	struct f2fs_super_block *super;
@@ -1262,7 +1276,7 @@ static int read_raw_super_block(struct super_block *sb,
 		}
 
 		/* sanity checking of raw super */
-		if (sanity_check_raw_super(sb, bh)) {
+		if (sanity_check_raw_super(sbi, bh)) {
 			f2fs_msg(sb, KERN_ERR,
 				"Can't find valid F2FS filesystem in %dth superblock",
 				block + 1);
@@ -1298,8 +1312,11 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	struct buffer_head *bh;
 	int err;
 
-	if (f2fs_readonly(sbi->sb) || bdev_read_only(sbi->sb->s_bdev))
+	if ((recover && f2fs_readonly(sbi->sb)) ||
+				bdev_read_only(sbi->sb->s_bdev)) {
+		set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 		return -EROFS;
+	}
 
 	/* write back-up superblock first */
 	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0: 1);
@@ -1343,6 +1360,8 @@ try_onemore:
 	if (!sbi)
 		return -ENOMEM;
 
+	sbi->sb = sb;
+
 	/* Load the checksum driver */
 	sbi->s_chksum_driver = crypto_alloc_shash("crc32", 0, 0);
 	if (IS_ERR(sbi->s_chksum_driver)) {
@@ -1358,7 +1377,7 @@ try_onemore:
 		goto free_sbi;
 	}
 
-	err = read_raw_super_block(sb, &raw_super, &valid_super_block,
+	err = read_raw_super_block(sbi, &raw_super, &valid_super_block,
 								&recovery);
 	if (err)
 		goto free_sbi;
@@ -1393,7 +1412,6 @@ try_onemore:
 	memcpy(sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
 
 	/* init f2fs-specific super block info */
-	sbi->sb = sb;
 	sbi->raw_super = raw_super;
 	sbi->valid_super_block = valid_super_block;
 	mutex_init(&sbi->gc_mutex);
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
