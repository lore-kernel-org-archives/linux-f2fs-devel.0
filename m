From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: write small sized IO to hot log
Date: Sat, 25 Mar 2017 00:59:30 -0700
Message-ID: <20170325075933.21072-2-jaegeuk@kernel.org>
References: <20170325075933.21072-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1crgc0-00032x-Vw
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 07:59:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1crgc0-0001L8-0a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 07:59:48 +0000
In-Reply-To: <20170325075933.21072-1-jaegeuk@kernel.org>
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

It would better split small and large IOs separately in order to get more
consecutive big writes.

The default threshold is set to 64KB, but configurable by sysfs/min_hot_blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  5 +++++
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c | 13 ++++++-------
 fs/f2fs/segment.h |  1 +
 fs/f2fs/super.c   |  2 ++
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 090413236b27..7275697bc940 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1511,6 +1511,11 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 
 	pagevec_init(&pvec, 0);
 
+	if (get_dirty_pages(mapping->host) <= SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
+		set_inode_flag(mapping->host, FI_HOT_DATA);
+	else
+		clear_inode_flag(mapping->host, FI_HOT_DATA);
+
 	if (wbc->range_cyclic) {
 		writeback_index = mapping->writeback_index; /* prev offset */
 		index = writeback_index;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6fbdcac01d9a..19e28127a725 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -674,6 +674,7 @@ struct f2fs_sm_info {
 	unsigned int ipu_policy;	/* in-place-update policy */
 	unsigned int min_ipu_util;	/* in-place-update threshold */
 	unsigned int min_fsync_blocks;	/* threshold for fsync */
+	unsigned int min_hot_blocks;	/* threshold for hot block allocation */
 
 	/* for flush command control */
 	struct flush_cmd_control *fcc_info;
@@ -1713,6 +1714,7 @@ enum {
 	FI_DO_DEFRAG,		/* indicate defragment is running */
 	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
 	FI_NO_PREALLOC,		/* indicate skipped preallocated blocks */
+	FI_HOT_DATA,		/* indicate file is hot */
 };
 
 static inline void __mark_inode_dirty_flag(struct inode *inode,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c5a5258f71c5..0cba28f95bb8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1797,18 +1797,16 @@ static int __get_segment_type_6(struct page *page, enum page_type p_type)
 	if (p_type == DATA) {
 		struct inode *inode = page->mapping->host;
 
-		if (S_ISDIR(inode->i_mode))
-			return CURSEG_HOT_DATA;
-		else if (is_cold_data(page) || file_is_cold(inode))
+		if (is_cold_data(page) || file_is_cold(inode))
 			return CURSEG_COLD_DATA;
-		else
-			return CURSEG_WARM_DATA;
+		if (is_inode_flag_set(inode, FI_HOT_DATA))
+			return CURSEG_HOT_DATA;
+		return CURSEG_WARM_DATA;
 	} else {
 		if (IS_DNODE(page))
 			return is_cold_node(page) ? CURSEG_WARM_NODE :
 						CURSEG_HOT_NODE;
-		else
-			return CURSEG_COLD_NODE;
+		return CURSEG_COLD_NODE;
 	}
 }
 
@@ -2915,6 +2913,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 		sm_info->ipu_policy = 1 << F2FS_IPU_FSYNC;
 	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
 	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
+	sm_info->min_hot_blocks = DEF_MIN_HOT_BLOCKS;
 
 	sm_info->trim_sections = DEF_BATCHED_TRIM_SECTIONS;
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5e8ad4280a50..4d0dd9f7f4ed 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -540,6 +540,7 @@ static inline int utilization(struct f2fs_sb_info *sbi)
  */
 #define DEF_MIN_IPU_UTIL	70
 #define DEF_MIN_FSYNC_BLOCKS	8
+#define DEF_MIN_HOT_BLOCKS	16
 
 enum {
 	F2FS_IPU_FORCE,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 49434f951ace..c4fa1ace8e55 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -294,6 +294,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_hot_blocks, min_hot_blocks);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
@@ -319,6 +320,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
 	ATTR_LIST(min_fsync_blocks),
+	ATTR_LIST(min_hot_blocks),
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
