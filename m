From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 5/6] f2fs: add the number of inline_data files to
	status info
Date: Fri, 27 Dec 2013 13:00:19 +0900
Message-ID: <1388116820-15038-5-git-send-email-jaegeuk.kim@samsung.com>
References: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VwOcQ-0007kQ-RP
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:50 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VwOcO-0001CU-PN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:50 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYG004AS5UMDID0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 13:01:34 +0900 (KST)
In-reply-to: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds the number of inline_data files into the status information.
Note that the number is reset whenever the filesystem is newly mounted.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/debug.c  |  3 +++
 fs/f2fs/f2fs.h   | 16 +++++++++++++++-
 fs/f2fs/inline.c |  2 ++
 fs/f2fs/inode.c  |  1 +
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 61adbcb..711a0d4 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -45,6 +45,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->valid_count = valid_user_blocks(sbi);
 	si->valid_node_count = valid_node_count(sbi);
 	si->valid_inode_count = valid_inode_count(sbi);
+	si->inline_inode = sbi->inline_inode;
 	si->utilization = utilization(sbi);
 
 	si->free_segs = free_segments(sbi);
@@ -200,6 +201,8 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "Other: %u)\n  - Data: %u\n",
 			   si->valid_node_count - si->valid_inode_count,
 			   si->valid_count - si->valid_node_count);
+		seq_printf(s, "  - Inline_data Inode: %u\n",
+			   si->inline_inode);
 		seq_printf(s, "\nMain area: %d segs, %d secs %d zones\n",
 			   si->main_area_segs, si->main_area_sections,
 			   si->main_area_zones);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index af35039..ef4073f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -460,6 +460,7 @@ struct f2fs_sb_info {
 	unsigned int segment_count[2];		/* # of allocated segments */
 	unsigned int block_count[2];		/* # of allocated blocks */
 	int total_hit_ext, read_hit_ext;	/* extent cache hit ratio */
+	int inline_inode;			/* # of inline_data inodes */
 	int bg_gc;				/* background gc calls */
 	unsigned int n_dirty_dirs;		/* # of dir inodes */
 #endif
@@ -1201,7 +1202,7 @@ struct f2fs_stat_info {
 	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
 	int nats, sits, fnids;
 	int total_count, utilization;
-	int bg_gc;
+	int bg_gc, inline_inode;
 	unsigned int valid_count, valid_node_count, valid_inode_count;
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
@@ -1230,6 +1231,17 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_dec_dirty_dir(sbi)		((sbi)->n_dirty_dirs--)
 #define stat_inc_total_hit(sb)		((F2FS_SB(sb))->total_hit_ext++)
 #define stat_inc_read_hit(sb)		((F2FS_SB(sb))->read_hit_ext++)
+#define stat_inc_inline_inode(inode)					\
+	do {								\
+		if (f2fs_has_inline_data(inode))			\
+			((F2FS_SB(inode->i_sb))->inline_inode++);	\
+	} while (0)
+#define stat_dec_inline_inode(inode)					\
+	do {								\
+		if (f2fs_has_inline_data(inode))			\
+			((F2FS_SB(inode->i_sb))->inline_inode--);	\
+	} while (0)
+
 #define stat_inc_seg_type(sbi, curseg)					\
 		((sbi)->segment_count[(curseg)->alloc_type]++)
 #define stat_inc_block_count(sbi, curseg)				\
@@ -1273,6 +1285,8 @@ void f2fs_destroy_root_stats(void);
 #define stat_dec_dirty_dir(sbi)
 #define stat_inc_total_hit(sb)
 #define stat_inc_read_hit(sb)
+#define stat_inc_inline_inode(inode)
+#define stat_dec_inline_inode(inode)
 #define stat_inc_seg_type(sbi, curseg)
 #define stat_inc_block_count(sbi, curseg)
 #define stat_inc_seg_count(si, type)
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 1843bc7..048f601 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -113,6 +113,7 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 	zero_user_segment(ipage, INLINE_DATA_OFFSET,
 				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
 	clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
+	stat_dec_inline_inode(inode);
 
 	sync_inode_page(&dn);
 	f2fs_put_page(ipage, 1);
@@ -165,6 +166,7 @@ int f2fs_write_inline_data(struct inode *inode,
 	if (!f2fs_has_inline_data(inode)) {
 		truncate_data_blocks_range(&dn, 1);
 		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
+		stat_inc_inline_inode(inode);
 	}
 
 	sync_inode_page(&dn);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index a91f451..915f9a8 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -277,6 +277,7 @@ void f2fs_evict_inode(struct inode *inode)
 
 	f2fs_lock_op(sbi);
 	remove_inode_page(inode);
+	stat_dec_inline_inode(inode);
 	f2fs_unlock_op(sbi);
 
 	sb_end_intwrite(inode->i_sb);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
