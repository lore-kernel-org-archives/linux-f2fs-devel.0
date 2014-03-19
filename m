From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/5] f2fs: increase pages_skipped when skipping
	writepages
Date: Wed, 19 Mar 2014 09:24:23 +0900
Message-ID: <1395188665-4175-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1395188665-4175-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WQ4Ku-0002b6-MF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:24 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WQ4Kr-0006IK-N8
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:24 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2N00001QJPAD20@mailout1.samsung.com> for
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

This patch increases pages_skipped when skipping writepages.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 11 ++++++-----
 fs/f2fs/data.c       |  6 +++++-
 fs/f2fs/node.c       |  6 +++++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1f52b70..aef32f3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -190,12 +190,9 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 	int nrpages = nr_pages_to_skip(sbi, META);
 	long written;
 
-	if (wbc->for_kupdate)
-		return 0;
-
 	/* collect a number of dirty meta pages and write together */
-	if (get_pages(sbi, F2FS_DIRTY_META) < nrpages)
-		return 0;
+	if (wbc->for_kupdate || get_pages(sbi, F2FS_DIRTY_META) < nrpages)
+		goto skip_write;
 
 	/* if mounting is failed, skip writing node pages */
 	mutex_lock(&sbi->cp_mutex);
@@ -203,6 +200,10 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 	mutex_unlock(&sbi->cp_mutex);
 	wbc->nr_to_write -= written;
 	return 0;
+
+skip_write:
+	wbc->pages_skipped += get_pages(sbi, F2FS_DIRTY_META);
+	return 0;
 }
 
 long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e3b7cfa..3bc3809 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -870,7 +870,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	if (S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_NONE &&
 			get_dirty_dents(inode) < nr_pages_to_skip(sbi, DATA))
-		return 0;
+		goto skip_write;
 
 	if (wbc->nr_to_write < MAX_DESIRED_PAGES_WP) {
 		desired_nrtw = MAX_DESIRED_PAGES_WP;
@@ -892,6 +892,10 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	wbc->nr_to_write -= excess_nrtw;
 	return ret;
+
+skip_write:
+	wbc->pages_skipped += get_dirty_dents(inode);
+	return 0;
 }
 
 static int f2fs_write_begin(struct file *file, struct address_space *mapping,
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cb514f1..7cc146b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1209,7 +1209,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 
 	/* collect a number of dirty node pages and write together */
 	if (get_pages(sbi, F2FS_DIRTY_NODES) < nr_pages_to_skip(sbi, NODE))
-		return 0;
+		goto skip_write;
 
 	/* if mounting is failed, skip writing node pages */
 	wbc->nr_to_write = 3 * max_hw_blocks(sbi);
@@ -1218,6 +1218,10 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	wbc->nr_to_write = nr_to_write - (3 * max_hw_blocks(sbi) -
 						wbc->nr_to_write);
 	return 0;
+
+skip_write:
+	wbc->pages_skipped += get_pages(sbi, F2FS_DIRTY_NODES);
+	return 0;
 }
 
 static int f2fs_set_node_page_dirty(struct page *page)
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
