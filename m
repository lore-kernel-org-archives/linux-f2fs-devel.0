From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: fix wrong memory footprint statistics in
 debugfs
Date: Tue, 06 Jan 2015 16:40:49 +0800
Message-ID: <009c01d0298c$946435e0$bd2ca1a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Our value of memory footprint statistics showed in debugfs is not calculated
correctly. Fix it in this patch.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index dd7835b..6aeaf46 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -125,7 +125,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	int i;
 
 	if (si->base_mem)
-		goto get_cache;
+		goto get_dynamic_cache;
 
 	si->base_mem = sizeof(struct f2fs_sb_info) + sbi->sb->s_blocksize;
 	si->base_mem += 2 * sizeof(struct f2fs_inode_info);
@@ -161,13 +161,18 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem += sizeof(struct f2fs_nm_info);
 	si->base_mem += __bitmap_size(sbi, NAT_BITMAP);
 
+get_dynamic_cache:
 	/* build gc */
-	si->base_mem += sizeof(struct f2fs_gc_kthread);
+	if (sbi->gc_thread)
+		si->base_mem += sizeof(struct f2fs_gc_kthread);
+
+	/* build merge flush thread */
+	if (SM_I(sbi)->cmd_control_info)
+		si->base_mem += sizeof(struct flush_cmd_control);
 
-get_cache:
 	/* free nids */
-	si->cache_mem = NM_I(sbi)->fcnt;
-	si->cache_mem += NM_I(sbi)->nat_cnt;
+	si->cache_mem = NM_I(sbi)->fcnt * sizeof(struct free_nid);
+	si->cache_mem += NM_I(sbi)->nat_cnt * sizeof(struct nat_entry);
 	npages = NODE_MAPPING(sbi)->nrpages;
 	si->cache_mem += npages << PAGE_CACHE_SHIFT;
 	npages = META_MAPPING(sbi)->nrpages;
-- 
2.2.1
