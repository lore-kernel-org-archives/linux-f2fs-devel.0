From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/7] f2fs: introduce force_lfs mount option
Date: Wed,  8 Jun 2016 10:24:42 -0700
Message-ID: <20160608172444.60371-5-jaegeuk@kernel.org>
References: <20160608172444.60371-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bAhDw-0007jE-8k
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:25:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bAhDv-0005NN-83
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:25:00 +0000
In-Reply-To: <20160608172444.60371-1-jaegeuk@kernel.org>
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

This mount option is to enable original log-structured filesystem forcefully.
So, there should be no random writes for main area.

Especially, this supports host-managed SMR device.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.txt |  3 +++
 fs/f2fs/data.c                     |  2 ++
 fs/f2fs/f2fs.h                     |  2 ++
 fs/f2fs/file.c                     |  8 +++++++-
 fs/f2fs/segment.c                  | 20 +++++++++++++++++++-
 fs/f2fs/segment.h                  |  7 +++++++
 fs/f2fs/super.c                    | 28 ++++++++++++++++++++++++++++
 7 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index e1c9f08..3a5ce24 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -151,6 +151,9 @@ noinline_data          Disable the inline data feature, inline data feature is
                        enabled by default.
 data_flush             Enable data flushing before checkpoint in order to
                        persist data of regular and symlink.
+mode=%s                Control block allocation mode which supports "adaptive"
+                       and "lfs". In "lfs" mode, there should be no random
+                       writes towards main area.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5f655d0..607ef43 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1710,6 +1710,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 		return 0;
+	if (test_opt(F2FS_I_SB(inode), LFS))
+		return 0;
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35b68b..d919294 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -111,6 +111,8 @@ static inline bool time_to_inject(int type)
 #define F2FS_MOUNT_FORCE_FG_GC		0x00004000
 #define F2FS_MOUNT_DATA_FLUSH		0x00008000
 #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
+#define F2FS_MOUNT_ADAPTIVE		0x00020000
+#define F2FS_MOUNT_LFS			0x00040000
 
 #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e66d223..f1f78fb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -917,9 +917,15 @@ static int __exchange_data_block(struct inode *inode, pgoff_t src,
 		return full ? truncate_hole(inode, dst, dst + 1) : 0;
 
 	if (do_replace) {
-		struct page *ipage = get_node_page(sbi, inode->i_ino);
+		struct page *ipage;
 		struct node_info ni;
 
+		if (test_opt(sbi, LFS)) {
+			ret = -ENOTSUPP;
+			goto err_out;
+		}
+
+		ipage = get_node_page(sbi, inode->i_ino);
 		if (IS_ERR(ipage)) {
 			ret = PTR_ERR(ipage);
 			goto err_out;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index eff046a..9ff4e30 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -594,6 +594,9 @@ bool discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	int err = -EOPNOTSUPP;
 
+	if (test_opt(sbi, LFS))
+		return false;
+
 	if (test_opt(sbi, DISCARD)) {
 		struct seg_entry *se = get_seg_entry(sbi,
 				GET_SEGNO(sbi, blkaddr));
@@ -707,6 +710,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
 	unsigned int start = 0, end = -1;
+	unsigned int secno, start_segno;
 
 	mutex_lock(&dirty_i->seglist_lock);
 
@@ -726,8 +730,22 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (!test_opt(sbi, DISCARD))
 			continue;
 
-		f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
+		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
+			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
 				(end - start) << sbi->log_blocks_per_seg);
+			continue;
+		}
+next:
+		secno = GET_SECNO(sbi, start);
+		start_segno = secno * sbi->segs_per_sec;
+		if (!IS_CURSEC(sbi, secno) &&
+			!get_valid_blocks(sbi, start, sbi->segs_per_sec))
+			f2fs_issue_discard(sbi, START_BLOCK(sbi, start_segno),
+				sbi->segs_per_sec << sbi->log_blocks_per_seg);
+
+		start = start_segno + sbi->segs_per_sec;
+		if (start < end)
+			goto next;
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 890bb28d..d74cc33 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -470,6 +470,10 @@ static inline bool need_SSR(struct f2fs_sb_info *sbi)
 {
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
+
+	if (test_opt(sbi, LFS))
+		return false;
+
 	return free_sections(sbi) <= (node_secs + 2 * dent_secs +
 						reserved_sections(sbi) + 1);
 }
@@ -533,6 +537,9 @@ static inline bool need_inplace_update(struct inode *inode)
 	if (S_ISDIR(inode->i_mode) || f2fs_is_atomic_file(inode))
 		return false;
 
+	if (test_opt(sbi, LFS))
+		return false;
+
 	if (policy & (0x1 << F2FS_IPU_FORCE))
 		return true;
 	if (policy & (0x1 << F2FS_IPU_SSR) && need_SSR(sbi))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dc66f16..edc736d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -94,6 +94,7 @@ enum {
 	Opt_noextent_cache,
 	Opt_noinline_data,
 	Opt_data_flush,
+	Opt_mode,
 	Opt_fault_injection,
 	Opt_lazytime,
 	Opt_nolazytime,
@@ -123,6 +124,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_noextent_cache, "noextent_cache"},
 	{Opt_noinline_data, "noinline_data"},
 	{Opt_data_flush, "data_flush"},
+	{Opt_mode, "mode=%s"},
 	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_lazytime, "lazytime"},
 	{Opt_nolazytime, "nolazytime"},
@@ -506,6 +508,25 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_data_flush:
 			set_opt(sbi, DATA_FLUSH);
 			break;
+		case Opt_mode:
+			name = match_strdup(&args[0]);
+
+			if (!name)
+				return -ENOMEM;
+			if (strlen(name) == 8 &&
+					!strncmp(name, "adaptive", 8)) {
+				set_opt(sbi, ADAPTIVE);
+				clear_opt(sbi, LFS);
+			} else if (strlen(name) == 3 &&
+					!strncmp(name, "lfs", 3)) {
+				clear_opt(sbi, ADAPTIVE);
+				set_opt(sbi, LFS);
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		case Opt_fault_injection:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
@@ -870,6 +891,12 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",noextent_cache");
 	if (test_opt(sbi, DATA_FLUSH))
 		seq_puts(seq, ",data_flush");
+
+	seq_puts(seq, ",mode=");
+	if (test_opt(sbi, ADAPTIVE))
+		seq_puts(seq, "adaptive");
+	else if (test_opt(sbi, LFS))
+		seq_puts(seq, "lfs");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
 
 	return 0;
@@ -953,6 +980,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, EXTENT_CACHE);
 	sbi->sb->s_flags |= MS_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
+	set_opt(sbi, ADAPTIVE);
 
 #ifdef CONFIG_F2FS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
