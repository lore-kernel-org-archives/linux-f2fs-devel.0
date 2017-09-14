From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: show flush list status in sysfs
Date: Thu, 14 Sep 2017 10:18:01 +0800
Message-ID: <20170914021801.4234-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dsJjW-0000cl-Mz
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Sep 2017 02:18:26 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dsJjU-0006u6-FK
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Sep 2017 02:18:26 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds to show flush list status in sysfs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c | 5 ++++-
 fs/f2fs/f2fs.h  | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 87f449845f5f..00c1d4a9f356 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -61,6 +61,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 			atomic_read(&SM_I(sbi)->fcc_info->issued_flush);
 		si->nr_flushing =
 			atomic_read(&SM_I(sbi)->fcc_info->issing_flush);
+		si->flush_list_empty =
+			llist_empty(&SM_I(sbi)->fcc_info->issue_list);
 	}
 	if (SM_I(sbi) && SM_I(sbi)->dcc_info) {
 		si->nr_discarded =
@@ -349,10 +351,11 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
 				si->ext_tree, si->zombie_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
-		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: (%4d %4d), "
+		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: (%4d %4d %4d), "
 			"Discard: (%4d %4d)) cmd: %4d undiscard:%4u\n",
 			   si->nr_wb_cp_data, si->nr_wb_data,
 			   si->nr_flushing, si->nr_flushed,
+			   si->flush_list_empty,
 			   si->nr_discarding, si->nr_discarded,
 			   si->nr_discard_cmd, si->undiscard_blks);
 		seq_printf(s, "  - inmem: %4d, atomic IO: %4d (Max. %4d), "
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5d33d5a84b07..c5d3d15b57c9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2704,7 +2704,8 @@ struct f2fs_stat_info {
 	int free_nids, avail_nids, alloc_nids;
 	int total_count, utilization;
 	int bg_gc, nr_wb_cp_data, nr_wb_data;
-	int nr_flushing, nr_flushed, nr_discarding, nr_discarded;
+	int nr_flushing, nr_flushed, flush_list_empty;
+	int nr_discarding, nr_discarded;
 	int nr_discard_cmd;
 	unsigned int undiscard_blks;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
