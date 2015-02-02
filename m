From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: show the number of writeback pages in
	stat
Date: Mon,  2 Feb 2015 14:51:19 -0800
Message-ID: <1422917479-36393-2-git-send-email-jaegeuk@kernel.org>
References: <1422917479-36393-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YIPq7-0003ho-7i
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Feb 2015 22:51:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YIPq6-00037T-G6 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Feb 2015 22:51:31 +0000
In-Reply-To: <1422917479-36393-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds the # of writeback pages in stat info.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 5 +++--
 fs/f2fs/f2fs.h  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 0f721f6..ac2bd8e 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -40,6 +40,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_dirs = sbi->n_dirty_dirs;
 	si->ndirty_meta = get_pages(sbi, F2FS_DIRTY_META);
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
+	si->wb_pages = get_pages(sbi, F2FS_WRITEBACK);
 	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
 	si->rsvd_segs = reserved_segments(sbi);
 	si->overp_segs = overprovision_segments(sbi);
@@ -266,8 +267,8 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "\nExtent Hit Ratio: %d / %d\n",
 			   si->hit_ext, si->total_ext);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
-		seq_printf(s, "  - inmem: %4d\n",
-			   si->inmem_pages);
+		seq_printf(s, "  - inmem: %4d, wb: %4d\n",
+			   si->inmem_pages, si->wb_pages);
 		seq_printf(s, "  - nodes: %4d in %4d\n",
 			   si->ndirty_node, si->node_pages);
 		seq_printf(s, "  - dents: %4d in dirs:%4d\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d89dc5d0..d005939c3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1550,7 +1550,7 @@ struct f2fs_stat_info {
 	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
-	int bg_gc, inline_inode, inline_dir, inmem_pages;
+	int bg_gc, inline_inode, inline_dir, inmem_pages, wb_pages;
 	unsigned int valid_count, valid_node_count, valid_inode_count;
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
