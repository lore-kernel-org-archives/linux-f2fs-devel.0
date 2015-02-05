From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v3 09/10] f2fs: show extent tree, node stat info in debugfs
Date: Thu, 05 Feb 2015 17:58:28 +0800
Message-ID: <000601d0412a$66b27e30$34177a90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch add and show stat info of total memory footprint for extent tree,node
in debugfs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c | 7 +++++++
 fs/f2fs/f2fs.h  | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ac2bd8e..205e525 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -35,6 +35,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	/* validation check of the segment numbers */
 	si->hit_ext = sbi->read_hit_ext;
 	si->total_ext = sbi->total_hit_ext;
+	si->ext_tree = sbi->total_ext_tree;
+	si->ext_node = atomic_read(&sbi->total_ext_node);
 	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
 	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
 	si->ndirty_dirs = sbi->n_dirty_dirs;
@@ -184,6 +186,9 @@ get_cache:
 	si->cache_mem += sbi->n_dirty_dirs * sizeof(struct inode_entry);
 	for (i = 0; i <= UPDATE_INO; i++)
 		si->cache_mem += sbi->im[i].ino_num * sizeof(struct ino_entry);
+	si->cache_mem += sbi->total_ext_tree * sizeof(struct extent_tree);
+	si->cache_mem += atomic_read(&sbi->total_ext_node) *
+						sizeof(struct extent_node);
 
 	si->page_mem = 0;
 	npages = NODE_MAPPING(sbi)->nrpages;
@@ -266,6 +271,8 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - node blocks : %d\n", si->node_blks);
 		seq_printf(s, "\nExtent Hit Ratio: %d / %d\n",
 			   si->hit_ext, si->total_ext);
+		seq_printf(s, "\nExtent Tree Count: %d\n", si->ext_tree);
+		seq_printf(s, "\nExtent Node Count: %d\n", si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
 		seq_printf(s, "  - inmem: %4d, wb: %4d\n",
 			   si->inmem_pages, si->wb_pages);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 73ca511..9572f7c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1604,7 +1604,7 @@ struct f2fs_stat_info {
 	struct f2fs_sb_info *sbi;
 	int all_area_segs, sit_area_segs, nat_area_segs, ssa_area_segs;
 	int main_area_segs, main_area_sections, main_area_zones;
-	int hit_ext, total_ext;
+	int hit_ext, total_ext, ext_tree, ext_node;
 	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
-- 
2.2.1
