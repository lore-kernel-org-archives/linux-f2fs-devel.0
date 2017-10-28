From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: export SSR allocation threshold
Date: Sat, 28 Oct 2017 16:52:33 +0800
Message-ID: <20171028085233.34488-5-yuchao0@huawei.com>
References: <20171028085233.34488-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171028085233.34488-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch exports min_ssr_segments threshold in sysfs to let user
control triggering SSR allocation flexibly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/f2fs.h                          | 2 ++
 fs/f2fs/segment.c                       | 3 ++-
 fs/f2fs/sysfs.c                         | 2 ++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index b7160b29b91d..e74e758632e1 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -57,6 +57,12 @@ Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
 		 Controls the dirty page count condition for redefining hot data.
 
+What:		/sys/fs/f2fs/<disk>/min_ssr_sections
+Date:		October 2017
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:
+		 Controls the fee section threshold to trigger SSR allocation.
+
 What:		/sys/fs/f2fs/<disk>/max_small_discards
 Date:		November 2013
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 850457e72002..51e05e8301f0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -839,6 +839,7 @@ struct f2fs_sm_info {
 	unsigned int min_ipu_util;	/* in-place-update threshold */
 	unsigned int min_fsync_blocks;	/* threshold for fsync */
 	unsigned int min_hot_blocks;	/* threshold for hot block allocation */
+	unsigned int min_ssr_sections;	/* threshold to trigger SSR allocation */
 
 	/* for flush command control */
 	struct flush_cmd_control *fcc_info;
@@ -1088,6 +1089,7 @@ struct f2fs_sb_info {
 	int active_logs;			/* # of active logs */
 	int dir_level;				/* directory level */
 	int inline_xattr_size;			/* inline xattr size */
+	unsigned int trigger_ssr_threshold;	/* threshold to trigger ssr */
 
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ab6382ee5111..e3887e11f962 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -181,7 +181,7 @@ bool need_SSR(struct f2fs_sb_info *sbi)
 		return true;
 
 	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
-						2 * reserved_sections(sbi));
+			SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
 }
 
 void register_inmem_page(struct inode *inode, struct page *page)
@@ -3637,6 +3637,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
 	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
 	sm_info->min_hot_blocks = DEF_MIN_HOT_BLOCKS;
+	sm_info->min_ssr_sections = reserved_sections(sbi);
 
 	sm_info->trim_sections = DEF_BATCHED_TRIM_SECTIONS;
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 751964da2bca..889bdc9e1fbf 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -275,6 +275,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_hot_blocks, min_hot_blocks);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ssr_sections, min_ssr_sections);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
@@ -319,6 +320,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(min_ipu_util),
 	ATTR_LIST(min_fsync_blocks),
 	ATTR_LIST(min_hot_blocks),
+	ATTR_LIST(min_ssr_sections),
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
-- 
2.13.1.388.g69e6b9b4f4a9
