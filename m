From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add reserved blocks for root user
Date: Wed, 27 Dec 2017 18:19:19 -0800
Message-ID: <20171228021919.29397-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eUNnE-0001Wq-1V
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Dec 2017 02:19:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eUNnB-0004Wr-JF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Dec 2017 02:19:35 +0000
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
 fs/f2fs/f2fs.h  | 25 ++++++++++++++++++++-----
 fs/f2fs/super.c | 24 ++++++++++++++++++++++--
 fs/f2fs/sysfs.c |  5 ++++-
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5bcd530dbae0..e2d859672147 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -95,6 +95,7 @@ extern char *fault_name[FAULT_MAX];
 #define F2FS_MOUNT_PRJQUOTA		0x00200000
 #define F2FS_MOUNT_QUOTA		0x00400000
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
+#define F2FS_MOUNT_RESERVE_ROOT		0x01000000
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
@@ -1557,6 +1558,12 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
+static inline block_t reserve_root_limit(struct f2fs_sb_info *sbi)
+{
+	/* limit is 0.2% */
+	return (sbi->user_block_count << 1) / 100;
+}
+
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
@@ -1584,13 +1591,18 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 	sbi->total_valid_block_count += (block_t)(*count);
-	avail_user_block_count = sbi->user_block_count -
-					sbi->current_reserved_blocks;
+	avail_user_block_count = sbi->user_block_count;
+
+	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
+		avail_user_block_count -= sbi->current_reserved_blocks;
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
@@ -1780,8 +1792,11 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->stat_lock);
 
 	valid_block_count = sbi->total_valid_block_count + 1;
-	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
-						sbi->user_block_count)) {
+
+	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
+		valid_block_count += sbi->current_reserved_blocks;
+
+	if (unlikely(valid_block_count > sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cb876d905ca5..a19e9f7bd908 100644
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
@@ -488,6 +490,14 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_data_flush:
 			set_opt(sbi, DATA_FLUSH);
 			break;
+		case Opt_reserve_root:
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+			if (sbi->current_reserved_blocks > arg)
+				return -EINVAL;
+			sbi->current_reserved_blocks = arg;
+			set_opt(sbi, RESERVE_ROOT);
+			break;
 		case Opt_mode:
 			name = match_strdup(&args[0]);
 
@@ -1006,6 +1016,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
+	if (test_opt(sbi, RESERVE_ROOT))
+		buf->f_bfree += sbi->current_reserved_blocks;
 	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
 
@@ -1136,6 +1148,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (test_opt(sbi, LFS))
 		seq_puts(seq, "lfs");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
+	if (test_opt(sbi, RESERVE_ROOT))
+		seq_printf(seq, ",reserve_root=%u",
+				sbi->current_reserved_blocks);
 	if (F2FS_IO_SIZE_BITS(sbi))
 		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -2569,8 +2584,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 				le64_to_cpu(sbi->ckpt->valid_block_count);
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->reserved_blocks = 0;
-	sbi->current_reserved_blocks = 0;
-
+	if (test_opt(sbi, RESERVE_ROOT) &&
+		sbi->current_reserved_blocks > reserve_root_limit(sbi)) {
+		sbi->current_reserved_blocks = reserve_root_limit(sbi);
+		f2fs_msg(sb, KERN_INFO,
+			"Reduce reserved blocks for root = %u\n",
+				sbi->current_reserved_blocks);
+	}
 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
 		spin_lock_init(&sbi->inode_lock[i]);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 987b2736348c..33e159491b48 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -162,7 +162,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
 		spin_lock(&sbi->stat_lock);
-		if (t > (unsigned long)sbi->user_block_count) {
+		if (t > (unsigned long)sbi->user_block_count ||
+			(test_opt(sbi, RESERVE_ROOT) &&
+				(t < sbi->current_reserved_blocks ||
+				t > reserve_root_limit(sbi)))) {
 			spin_unlock(&sbi->stat_lock);
 			return -EINVAL;
 		}
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
