From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 5/5] f2fs: export ra_nid_pages to sysfs
Date: Mon, 12 Oct 2015 17:08:48 +0800
Message-ID: <021301d104cd$b26fc050$174f40f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

After finishing building free nid cache, we will try to readahead
asynchronously 4 more pages for the next reloading, the count of
readahead nid pages is fixed.

In some case, like SMR drive, read less sectors with fixed count
each time we trigger RA may be low efficient, since we will face
high seeking overhead, so we'd better let user to configure this
parameter from sysfs in specific workload.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/f2fs.h                          | 1 +
 fs/f2fs/node.c                          | 3 ++-
 fs/f2fs/node.h                          | 4 +++-
 fs/f2fs/super.c                         | 2 ++
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index e066281d..0345f2d 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -86,3 +86,9 @@ Date:		October 2015
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
 		 Controls the checkpoint timing.
+
+What:		/sys/fs/f2fs/<disk>/ra_nid_pages
+Date:		October 2015
+Contact:	"Chao Yu" <chao2.yu@samsung.com>
+Description:
+		 Controls the count of nid pages to be readaheaded.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5f372c0..94cf6bc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -510,6 +510,7 @@ struct f2fs_nm_info {
 	nid_t available_nids;		/* maximum available node ids */
 	nid_t next_scan_nid;		/* the next nid to be scanned */
 	unsigned int ram_thresh;	/* control the memory footprint */
+	unsigned int ra_nid_pages;	/* # of nid pages to be readaheaded */
 
 	/* NAT cache management */
 	struct radix_tree_root nat_root;/* root of the nat entry cache */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 14f4606..7bcbc6e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1562,7 +1562,7 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 	mutex_unlock(&curseg->curseg_mutex);
 
 	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
-					FREE_NID_PAGES, META_NAT, false);
+					nm_i->ra_nid_pages, META_NAT, false);
 }
 
 /*
@@ -2005,6 +2005,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	nm_i->fcnt = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
+	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
 
 	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
 	INIT_LIST_HEAD(&nm_i->free_nid_list);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 7427e95..e4fffd2 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -14,9 +14,11 @@
 /* node block offset on the NAT area dedicated to the given start node id */
 #define	NAT_BLOCK_OFFSET(start_nid) (start_nid / NAT_ENTRY_PER_BLOCK)
 
-/* # of pages to perform readahead before building free nids */
+/* # of pages to perform synchronous readahead before building free nids */
 #define FREE_NID_PAGES 4
 
+#define DEF_RA_NID_PAGES	4	/* # of nid pages to be readaheaded */
+
 /* maximum readahead size for node during getting data blocks */
 #define MAX_RA_NODE		128
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cb23d85..3a65e01 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -213,6 +213,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
+F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, cp_interval);
@@ -232,6 +233,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
+	ATTR_LIST(ra_nid_pages),
 	ATTR_LIST(cp_interval),
 	NULL,
 };
-- 
2.5.2
