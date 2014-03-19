From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 4/5] f2fs: introduce nr_pages_to_write for
	segment alignment
Date: Wed, 19 Mar 2014 09:24:24 +0900
Message-ID: <1395188665-4175-4-git-send-email-jaegeuk.kim@samsung.com>
References: <1395188665-4175-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WQ4Ky-0002bR-Sr
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:28 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WQ4Kx-0006IK-Da
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:28 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2N000JWQJRW310@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 09:26:15 +0900 (KST)
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

This patch introduces nr_pages_to_write to align page writes to the segment
or other operational unit size, which can be tuned according to the system
environment.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 11 ++++++-----
 fs/f2fs/data.c       | 12 +++---------
 fs/f2fs/node.c       |  8 +++-----
 fs/f2fs/segment.h    | 24 ++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index aef32f3..2a00c94 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -187,18 +187,19 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 				struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(mapping->host->i_sb);
-	int nrpages = nr_pages_to_skip(sbi, META);
-	long written;
+	long diff, written;
 
 	/* collect a number of dirty meta pages and write together */
-	if (wbc->for_kupdate || get_pages(sbi, F2FS_DIRTY_META) < nrpages)
+	if (wbc->for_kupdate ||
+		get_pages(sbi, F2FS_DIRTY_META) < nr_pages_to_skip(sbi, META))
 		goto skip_write;
 
 	/* if mounting is failed, skip writing node pages */
 	mutex_lock(&sbi->cp_mutex);
-	written = sync_meta_pages(sbi, META, nrpages);
+	diff = nr_pages_to_write(sbi, META, wbc);
+	written = sync_meta_pages(sbi, META, wbc->nr_to_write);
 	mutex_unlock(&sbi->cp_mutex);
-	wbc->nr_to_write -= written;
+	wbc->nr_to_write = max((long)0, wbc->nr_to_write - written - diff);
 	return 0;
 
 skip_write:
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3bc3809..b0c923a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -844,8 +844,6 @@ redirty_out:
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-#define MAX_DESIRED_PAGES_WP	4096
-
 static int __f2fs_writepage(struct page *page, struct writeback_control *wbc,
 			void *data)
 {
@@ -862,7 +860,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	bool locked = false;
 	int ret;
-	long excess_nrtw = 0, desired_nrtw;
+	long diff;
 
 	/* deal with chardevs and other special file */
 	if (!mapping->a_ops->writepage)
@@ -872,11 +870,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 			get_dirty_dents(inode) < nr_pages_to_skip(sbi, DATA))
 		goto skip_write;
 
-	if (wbc->nr_to_write < MAX_DESIRED_PAGES_WP) {
-		desired_nrtw = MAX_DESIRED_PAGES_WP;
-		excess_nrtw = desired_nrtw - wbc->nr_to_write;
-		wbc->nr_to_write = desired_nrtw;
-	}
+	diff = nr_pages_to_write(sbi, DATA, wbc);
 
 	if (!S_ISDIR(inode->i_mode)) {
 		mutex_lock(&sbi->writepages);
@@ -890,7 +884,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	remove_dirty_dir_inode(inode);
 
-	wbc->nr_to_write -= excess_nrtw;
+	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
 	return ret;
 
 skip_write:
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7cc146b..5e9c38e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1202,7 +1202,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(mapping->host->i_sb);
-	long nr_to_write = wbc->nr_to_write;
+	long diff;
 
 	/* balancing f2fs's metadata in background */
 	f2fs_balance_fs_bg(sbi);
@@ -1211,12 +1211,10 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	if (get_pages(sbi, F2FS_DIRTY_NODES) < nr_pages_to_skip(sbi, NODE))
 		goto skip_write;
 
-	/* if mounting is failed, skip writing node pages */
-	wbc->nr_to_write = 3 * max_hw_blocks(sbi);
+	diff = nr_pages_to_write(sbi, NODE, wbc);
 	wbc->sync_mode = WB_SYNC_NONE;
 	sync_node_pages(sbi, 0, wbc);
-	wbc->nr_to_write = nr_to_write - (3 * max_hw_blocks(sbi) -
-						wbc->nr_to_write);
+	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
 	return 0;
 
 skip_write:
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index bbd9761..9fc46ee 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -683,3 +683,27 @@ static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 	else
 		return 0;
 }
+
+/*
+ * When writing pages, it'd better align nr_to_write for segment size.
+ */
+static inline long nr_pages_to_write(struct f2fs_sb_info *sbi, int type,
+					struct writeback_control *wbc)
+{
+	long nr_to_write, desired;
+
+	if (wbc->sync_mode != WB_SYNC_NONE)
+		return 0;
+
+	nr_to_write = wbc->nr_to_write;
+
+	if (type == DATA)
+		desired = 4096;
+	else if (type == NODE)
+		desired = 3 * max_hw_blocks(sbi);
+	else
+		desired = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
+
+	wbc->nr_to_write = desired;
+	return desired - nr_to_write;
+}
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
