From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2] f2fs: add discard info to sys entry of f2fs
	status
Date: Thu, 18 Aug 2016 21:01:18 +0800
Message-ID: <1471525279-12354-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1baMsI-00052w-LI
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Aug 2016 12:56:46 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1baMsC-00036N-Au
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Aug 2016 12:56:46 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

This patch add discard block count to sys entry of f2fs status

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/debug.c | 10 ++++++++--
 fs/f2fs/f2fs.h  |  7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index badd407..07bee48 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -54,6 +54,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->rsvd_segs = reserved_segments(sbi);
 	si->overp_segs = overprovision_segments(sbi);
 	si->valid_count = valid_user_blocks(sbi);
+	si->discard_blks = discard_blocks(sbi);
 	si->valid_node_count = valid_node_count(sbi);
 	si->valid_inode_count = valid_inode_count(sbi);
 	si->inline_xattr = atomic_read(&sbi->inline_xattr);
@@ -228,8 +229,13 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ssa_area_segs, si->main_area_segs);
 		seq_printf(s, "(OverProv:%d Resv:%d)]\n\n",
 			   si->overp_segs, si->rsvd_segs);
-		seq_printf(s, "Utilization: %d%% (%d valid blocks)\n",
-			   si->utilization, si->valid_count);
+		if (test_opt(si->sbi, DISCARD))
+			seq_printf(s, "Utilization: %u%% (%u valid blocks, %u discard blocks)\n",
+				si->utilization, si->valid_count, si->discard_blks);
+		else
+			seq_printf(s, "Utilization: %u%% (%u valid blocks)\n",
+				si->utilization, si->valid_count);
+
 		seq_printf(s, "  - Node: %u (Inode: %u, ",
 			   si->valid_node_count, si->valid_inode_count);
 		seq_printf(s, "Other: %u)\n  - Data: %u\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3098109..e691ff0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1242,6 +1242,11 @@ static inline block_t valid_user_blocks(struct f2fs_sb_info *sbi)
 	return sbi->total_valid_block_count;
 }
 
+static inline block_t discard_blocks(struct f2fs_sb_info *sbi)
+{
+	return sbi->discard_blks;
+}
+
 static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -2128,7 +2133,7 @@ struct f2fs_stat_info {
 	int total_count, utilization;
 	int bg_gc, wb_bios;
 	int inline_xattr, inline_inode, inline_dir, orphans;
-	unsigned int valid_count, valid_node_count, valid_inode_count;
+	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
 	int rsvd_segs, overp_segs;
-- 
1.9.1


------------------------------------------------------------------------------
