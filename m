From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: add reserved blocks for root user
Date: Wed,  3 Jan 2018 10:58:45 -0800
Message-ID: <20180103185845.29953-2-jaegeuk@kernel.org>
References: <20180103185845.29953-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eWoFb-0004AI-D5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jan 2018 18:58:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWoFZ-0006cY-Cu
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jan 2018 18:58:55 +0000
In-Reply-To: <20180103185845.29953-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch allows root to reserve some blocks via mount option.

"-o reserve_root=N" means N x 4KB-sized blocks for root only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 26 ++++++++++++++++++++++----
 fs/f2fs/super.c | 29 ++++++++++++++++++++++++++---
 fs/f2fs/sysfs.c |  3 ++-
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 369607b1e776..fb98b51f7376 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -95,6 +95,7 @@ extern char *fault_name[FAULT_MAX];
 #define F2FS_MOUNT_PRJQUOTA		0x00200000
 #define F2FS_MOUNT_QUOTA		0x00400000
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
+#define F2FS_MOUNT_RESERVE_ROOT		0x01000000
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
@@ -1109,6 +1110,7 @@ struct f2fs_sb_info {
 	block_t last_valid_block_count;		/* for recovery */
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
+	block_t root_reserved_blocks;		/* root reserved blocks */
 
 	unsigned int nquota_files;		/* # of quota sysfile */
 
@@ -1561,6 +1563,12 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
+static inline block_t reserve_root_limit(struct f2fs_sb_info *sbi)
+{
+	/* limit is 0.2% */
+	return (sbi->user_block_count << 1) / 1000;
+}
+
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
@@ -1590,11 +1598,17 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	sbi->total_valid_block_count += (block_t)(*count);
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
+
+	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
+		avail_user_block_count -= sbi->root_reserved_blocks;
+
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
+		if (diff > *count)
+			diff = *count;
 		*count -= diff;
 		release = diff;
-		sbi->total_valid_block_count = avail_user_block_count;
+		sbi->total_valid_block_count -= diff;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
 			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);
@@ -1783,9 +1797,13 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 
-	valid_block_count = sbi->total_valid_block_count + 1;
-	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
-						sbi->user_block_count)) {
+	valid_block_count = sbi->total_valid_block_count +
+					sbi->current_reserved_blocks + 1;
+
+	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
+		valid_block_count += sbi->root_reserved_blocks;
+
+	if (unlikely(valid_block_count > sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4c1c99cf54ef..56b3caeec1ea 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -107,6 +107,7 @@ enum {
 	Opt_noextent_cache,
 	Opt_noinline_data,
 	Opt_data_flush,
+	Opt_reserve_root,
 	Opt_mode,
 	Opt_io_size_bits,
 	Opt_fault_injection,
@@ -157,6 +158,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_noextent_cache, "noextent_cache"},
 	{Opt_noinline_data, "noinline_data"},
 	{Opt_data_flush, "data_flush"},
+	{Opt_reserve_root, "reserve_root=%u"},
 	{Opt_mode, "mode=%s"},
 	{Opt_io_size_bits, "io_bits=%u"},
 	{Opt_fault_injection, "fault_injection=%u"},
@@ -488,6 +490,18 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_data_flush:
 			set_opt(sbi, DATA_FLUSH);
 			break;
+		case Opt_reserve_root:
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+			if (test_opt(sbi, RESERVE_ROOT)) {
+				f2fs_msg(sb, KERN_INFO,
+					"Preserve previous reserve_root=%u",
+					sbi->root_reserved_blocks);
+			} else {
+				sbi->root_reserved_blocks = arg;
+				set_opt(sbi, RESERVE_ROOT);
+			}
+			break;
 		case Opt_mode:
 			name = match_strdup(&args[0]);
 
@@ -994,20 +1008,19 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct super_block *sb = dentry->d_sb;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
-	block_t total_count, user_block_count, start_count, ovp_count;
+	block_t total_count, user_block_count, start_count;
 	u64 avail_node_count;
 
 	total_count = le64_to_cpu(sbi->raw_super->block_count);
 	user_block_count = sbi->user_block_count;
 	start_count = le32_to_cpu(sbi->raw_super->segment0_blkaddr);
-	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
 	buf->f_type = F2FS_SUPER_MAGIC;
 	buf->f_bsize = sbi->blocksize;
 
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
-	buf->f_bavail = buf->f_bfree;
+	buf->f_bavail = buf->f_bfree - sbi->root_reserved_blocks;
 
 	avail_node_count = sbi->total_node_count - sbi->nquota_files -
 						F2FS_RESERVED_NODE_NUM;
@@ -1136,6 +1149,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (test_opt(sbi, LFS))
 		seq_puts(seq, "lfs");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
+	if (test_opt(sbi, RESERVE_ROOT))
+		seq_printf(seq, ",reserve_root=%u",
+				sbi->root_reserved_blocks);
 	if (F2FS_IO_SIZE_BITS(sbi))
 		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -2571,6 +2587,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->reserved_blocks = 0;
 	sbi->current_reserved_blocks = 0;
 
+	if (test_opt(sbi, RESERVE_ROOT) &&
+		sbi->root_reserved_blocks > reserve_root_limit(sbi)) {
+		sbi->root_reserved_blocks = reserve_root_limit(sbi);
+		f2fs_msg(sb, KERN_INFO,
+			"Reduce reserved blocks for root = %u",
+				sbi->root_reserved_blocks);
+	}
 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
 		spin_lock_init(&sbi->inode_lock[i]);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 7e15cbc5b8e1..41887e6ec1b3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -162,7 +162,8 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
 		spin_lock(&sbi->stat_lock);
-		if (t > (unsigned long)sbi->user_block_count) {
+		if (t > (unsigned long)(sbi->user_block_count -
+					sbi->root_reserved_blocks)) {
 			spin_unlock(&sbi->stat_lock);
 			return -EINVAL;
 		}
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
