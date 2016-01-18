From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 4/4] f2fs: export dirty_nats_ratio in sysfs
Date: Mon, 18 Jan 2016 18:32:58 +0800
Message-ID: <01ae01d151db$b19f4d70$14dde850$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aL787-0004BV-Sy
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Jan 2016 10:33:47 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aL785-0006Sj-PJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Jan 2016 10:33:47 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1502NK39BRC240@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Jan 2016 19:33:38 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch exports a new sysfs entry 'dirty_nat_ratio' to control threshold
of dirty nat entries, if current ratio exceeds configured threshold,
checkpoint will be triggered in f2fs_balance_fs_bg for flushing dirty nats.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
 fs/f2fs/f2fs.h                          | 1 +
 fs/f2fs/node.c                          | 1 +
 fs/f2fs/node.h                          | 2 +-
 fs/f2fs/super.c                         | 2 ++
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index e5200f3..523cb9d 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -98,3 +98,11 @@ Date:		October 2015
 Contact:	"Chao Yu" <chao2.yu@samsung.com>
 Description:
 		 Controls the count of nid pages to be readaheaded.
+
+What:		/sys/fs/f2fs/<disk>/dirty_nats_ratio
+Date:		January 2016
+Contact:	"Chao Yu" <chao2.yu@samsung.com>
+Description:
+		 Controls dirty nat entries ratio threshold, if current
+		 ratio exceeds configured threshold, checkpoint will
+		 be triggered for flushing dirty nat entries.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6c413b1e..2addaee 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -515,6 +515,7 @@ struct f2fs_nm_info {
 	nid_t next_scan_nid;		/* the next nid to be scanned */
 	unsigned int ram_thresh;	/* control the memory footprint */
 	unsigned int ra_nid_pages;	/* # of nid pages to be readaheaded */
+	unsigned int dirty_nats_ratio;	/* control dirty nats ratio threshold */
 
 	/* NAT cache management */
 	struct radix_tree_root nat_root;/* root of the nat entry cache */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 851a80b..f612c09 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2009,6 +2009,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
 	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
+	nm_i->dirty_nats_ratio = DEF_DIRTY_NAT_RATIO_THRESHOLD;
 
 	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
 	INIT_LIST_HEAD(&nm_i->free_nid_list);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index bd119c0..56c4519 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -123,7 +123,7 @@ static inline void raw_nat_from_node_info(struct f2fs_nat_entry *raw_ne,
 static inline bool excess_dirty_nats(struct f2fs_sb_info *sbi)
 {
 	return NM_I(sbi)->dirty_nat_cnt >= NM_I(sbi)->max_nid *
-					DEF_DIRTY_NAT_RATIO_THRESHOLD / 100;
+					NM_I(sbi)->dirty_nats_ratio / 100;
 }
 
 enum mem_type {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3bf990b..be7c403 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -216,6 +216,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
+F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
@@ -237,6 +238,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
 	ATTR_LIST(ra_nid_pages),
+	ATTR_LIST(dirty_nats_ratio),
 	ATTR_LIST(cp_interval),
 	ATTR_LIST(idle_interval),
 	NULL,
-- 
2.6.3



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
