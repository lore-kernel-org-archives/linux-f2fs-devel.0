From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: update memory footprint information
Date: Tue, 13 Jan 2015 16:33:24 -0800
Message-ID: <1421195604-5256-2-git-send-email-jaegeuk@kernel.org>
References: <1421195604-5256-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YBBtx-00034U-4y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Jan 2015 00:33:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YBBtw-0008HP-2a for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Jan 2015 00:33:37 +0000
In-Reply-To: <1421195604-5256-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds missing memory usages, and splits them in detail.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 24 +++++++++++++++++-------
 fs/f2fs/f2fs.h  |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index b45daab..0f721f6 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -177,13 +177,18 @@ get_cache:
 	/* free nids */
 	si->cache_mem += NM_I(sbi)->fcnt * sizeof(struct free_nid);
 	si->cache_mem += NM_I(sbi)->nat_cnt * sizeof(struct nat_entry);
-	npages = NODE_MAPPING(sbi)->nrpages;
-	si->cache_mem += npages << PAGE_CACHE_SHIFT;
-	npages = META_MAPPING(sbi)->nrpages;
-	si->cache_mem += npages << PAGE_CACHE_SHIFT;
+	si->cache_mem += NM_I(sbi)->dirty_nat_cnt *
+					sizeof(struct nat_entry_set);
+	si->cache_mem += si->inmem_pages * sizeof(struct inmem_pages);
 	si->cache_mem += sbi->n_dirty_dirs * sizeof(struct inode_entry);
 	for (i = 0; i <= UPDATE_INO; i++)
 		si->cache_mem += sbi->im[i].ino_num * sizeof(struct ino_entry);
+
+	si->page_mem = 0;
+	npages = NODE_MAPPING(sbi)->nrpages;
+	si->page_mem += npages << PAGE_CACHE_SHIFT;
+	npages = META_MAPPING(sbi)->nrpages;
+	si->page_mem += npages << PAGE_CACHE_SHIFT;
 }
 
 static int stat_show(struct seq_file *s, void *v)
@@ -301,9 +306,14 @@ static int stat_show(struct seq_file *s, void *v)
 
 		/* memory footprint */
 		update_mem_info(si->sbi);
-		seq_printf(s, "\nMemory: %u KB = static: %u + cached: %u\n",
-				(si->base_mem + si->cache_mem) >> 10,
-				si->base_mem >> 10, si->cache_mem >> 10);
+		seq_printf(s, "\nMemory: %u KB\n",
+			(si->base_mem + si->cache_mem + si->page_mem) >> 10);
+		seq_printf(s, "  - static: %u KB\n",
+				si->base_mem >> 10);
+		seq_printf(s, "  - cached: %u KB\n",
+				si->cache_mem >> 10);
+		seq_printf(s, "  - paged : %u KB\n",
+				si->page_mem >> 10);
 	}
 	mutex_unlock(&f2fs_stat_mutex);
 	return 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 209532c..c2cf040 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1530,7 +1530,7 @@ struct f2fs_stat_info {
 	unsigned int segment_count[2];
 	unsigned int block_count[2];
 	unsigned int inplace_count;
-	unsigned base_mem, cache_mem;
+	unsigned base_mem, cache_mem, page_mem;
 };
 
 static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
-- 
2.1.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
