From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: monitor zombie_tree count
Date: Thu, 31 Dec 2015 15:49:53 -0800
Message-ID: <1451605794-5636-4-git-send-email-jaegeuk@kernel.org>
References: <1451605794-5636-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aEmyx-0005nf-4G
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aEmyw-0003Y1-Dg for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:11 +0000
In-Reply-To: <1451605794-5636-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds an entry to show the number of zombie extent_tree.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 5 +++--
 fs/f2fs/f2fs.h  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ed5dfcc..b73e8e1 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -39,6 +39,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->hit_total = si->hit_largest + si->hit_cached + si->hit_rbtree;
 	si->total_ext = atomic64_read(&sbi->total_hit_ext);
 	si->ext_tree = atomic_read(&sbi->total_ext_tree);
+	si->zombie_tree = atomic_read(&sbi->total_zombie_tree);
 	si->ext_node = atomic_read(&sbi->total_ext_node);
 	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
 	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
@@ -292,8 +293,8 @@ static int stat_show(struct seq_file *s, void *v)
 				!si->total_ext ? 0 :
 				div64_u64(si->hit_total * 100, si->total_ext),
 				si->hit_total, si->total_ext);
-		seq_printf(s, "  - Inner Struct Count: tree: %d, node: %d\n",
-				si->ext_tree, si->ext_node);
+		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
+				si->ext_tree, si->zombie_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
 		seq_printf(s, "  - inmem: %4d, wb: %4d\n",
 			   si->inmem_pages, si->wb_pages);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a339508..d81bf5a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1890,7 +1890,7 @@ struct f2fs_stat_info {
 	int main_area_segs, main_area_sections, main_area_zones;
 	unsigned long long hit_largest, hit_cached, hit_rbtree;
 	unsigned long long hit_total, total_ext;
-	int ext_tree, ext_node;
+	int ext_tree, zombie_tree, ext_node;
 	int ndirty_node, ndirty_meta;
 	int ndirty_dent, ndirty_dirs, ndirty_data, ndirty_files;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
-- 
2.6.3


------------------------------------------------------------------------------
