From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/5] f2fs: avoid small data writes by skipping
	writepages
Date: Wed, 19 Mar 2014 09:24:22 +0900
Message-ID: <1395188665-4175-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1395188665-4175-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WQ4Kt-0005WT-Ee
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:23 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WQ4Kr-0007tB-Cv
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:23 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2N00CCXQJPTG40@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 09:26:13 +0900 (KST)
In-reply-to: <1395188665-4175-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces nr_pages_to_skip(sbi, type) to determine writepages can
be skipped.
The dentry, node, and meta pages can be conrolled by F2FS without breaking the
FS consistency.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       |  4 ++++
 fs/f2fs/node.c       |  8 +-------
 fs/f2fs/segment.h    | 19 +++++++++++++++++++
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4c0e98d..1f52b70 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -187,7 +187,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 				struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(mapping->host->i_sb);
-	int nrpages = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
+	int nrpages = nr_pages_to_skip(sbi, META);
 	long written;
 
 	if (wbc->for_kupdate)
@@ -682,7 +682,7 @@ retry:
 	inode = igrab(entry->inode);
 	spin_unlock(&sbi->dir_inode_lock);
 	if (inode) {
-		filemap_flush(inode->i_mapping);
+		filemap_fdatawrite(inode->i_mapping);
 		iput(inode);
 	} else {
 		/*
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 101b4cd..e3b7cfa 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -868,6 +868,10 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	if (!mapping->a_ops->writepage)
 		return 0;
 
+	if (S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_NONE &&
+			get_dirty_dents(inode) < nr_pages_to_skip(sbi, DATA))
+		return 0;
+
 	if (wbc->nr_to_write < MAX_DESIRED_PAGES_WP) {
 		desired_nrtw = MAX_DESIRED_PAGES_WP;
 		excess_nrtw = desired_nrtw - wbc->nr_to_write;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3e36240..cb514f1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1198,12 +1198,6 @@ redirty_out:
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-/*
- * It is very important to gather dirty pages and write at once, so that we can
- * submit a big bio without interfering other data writes.
- * Be default, 512 pages (2MB) * 3 node types, is more reasonable.
- */
-#define COLLECT_DIRTY_NODES	1536
 static int f2fs_write_node_pages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
@@ -1214,7 +1208,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	f2fs_balance_fs_bg(sbi);
 
 	/* collect a number of dirty node pages and write together */
-	if (get_pages(sbi, F2FS_DIRTY_NODES) < COLLECT_DIRTY_NODES)
+	if (get_pages(sbi, F2FS_DIRTY_NODES) < nr_pages_to_skip(sbi, NODE))
 		return 0;
 
 	/* if mounting is failed, skip writing node pages */
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index c3d5e36..bbd9761 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -664,3 +664,22 @@ static inline unsigned int max_hw_blocks(struct f2fs_sb_info *sbi)
 	struct request_queue *q = bdev_get_queue(bdev);
 	return SECTOR_TO_BLOCK(sbi, queue_max_sectors(q));
 }
+
+/*
+ * It is very important to gather dirty pages and write at once, so that we can
+ * submit a big bio without interfering other data writes.
+ * By default, 512 pages for directory data,
+ * 512 pages (2MB) * 3 for three types of nodes, and
+ * max_bio_blocks for meta are set.
+ */
+static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
+{
+	if (type == DATA)
+		return sbi->blocks_per_seg;
+	else if (type == NODE)
+		return 3 * sbi->blocks_per_seg;
+	else if (type == META)
+		return MAX_BIO_BLOCKS(max_hw_blocks(sbi));
+	else
+		return 0;
+}
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
