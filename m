From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: use blk_plug in all the possible paths
Date: Thu, 14 Jul 2016 17:46:29 -0700
Message-ID: <20160715004629.43143-5-jaegeuk@kernel.org>
References: <20160715004629.43143-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bNrHB-0004dw-PU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 00:46:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bNrHA-0005jj-Pn
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 00:46:45 +0000
In-Reply-To: <20160715004629.43143-1-jaegeuk@kernel.org>
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

This patch reverts 19a5f5e2ef37 (f2fs: drop any block plugging),
and adds blk_plug in write paths additionally.

The main reason is that blk_start_plug can be used to wake up from low-power
mode before submitting further bios.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 7 +++++++
 fs/f2fs/data.c       | 3 +++
 fs/f2fs/file.c       | 6 +++++-
 fs/f2fs/gc.c         | 5 +++++
 fs/f2fs/node.c       | 3 +++
 fs/f2fs/segment.c    | 7 ++++++-
 6 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8ea8953..be1c54b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -265,6 +265,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 				struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
+	struct blk_plug plug;
 	long diff, written;
 
 	/* collect a number of dirty meta pages and write together */
@@ -277,7 +278,9 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 	/* if mounting is failed, skip writing node pages */
 	mutex_lock(&sbi->cp_mutex);
 	diff = nr_pages_to_write(sbi, META, wbc);
+	blk_start_plug(&plug);
 	written = sync_meta_pages(sbi, META, wbc->nr_to_write);
+	blk_finish_plug(&plug);
 	mutex_unlock(&sbi->cp_mutex);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - written - diff);
 	return 0;
@@ -899,8 +902,11 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		.nr_to_write = LONG_MAX,
 		.for_reclaim = 0,
 	};
+	struct blk_plug plug;
 	int err = 0;
 
+	blk_start_plug(&plug);
+
 retry_flush_dents:
 	f2fs_lock_all(sbi);
 	/* write all the dirty dentry pages */
@@ -937,6 +943,7 @@ retry_flush_nodes:
 		goto retry_flush_nodes;
 	}
 out:
+	blk_finish_plug(&plug);
 	return err;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6500995..b7a530e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1438,6 +1438,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct blk_plug plug;
 	int ret;
 
 	/* deal with chardevs and other special file */
@@ -1463,7 +1464,9 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
 
+	blk_start_plug(&plug);
 	ret = f2fs_write_cache_pages(mapping, wbc);
+	blk_finish_plug(&plug);
 	/*
 	 * if some pages were truncated, we cannot guarantee its mapping->host
 	 * to detect pending bios.
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c529884..001f062 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2180,6 +2180,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	struct blk_plug plug;
 	ssize_t ret;
 
 	if (f2fs_encrypted_inode(inode) &&
@@ -2191,8 +2192,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
 		ret = f2fs_preallocate_blocks(iocb, from);
-		if (!ret)
+		if (!ret) {
+			blk_start_plug(&plug);
 			ret = __generic_file_write_iter(iocb, from);
+			blk_finish_plug(&plug);
+		}
 	}
 	inode_unlock(inode);
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c612137..90d5fda 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -788,6 +788,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
+	struct blk_plug plug;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + sbi->segs_per_sec;
 	int seg_freed = 0;
@@ -805,6 +806,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		unlock_page(sum_page);
 	}
 
+	blk_start_plug(&plug);
+
 	for (segno = start_segno; segno < end_segno; segno++) {
 
 		if (get_valid_blocks(sbi, segno, 1) == 0)
@@ -842,6 +845,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		f2fs_submit_merged_bio(sbi,
 				(type == SUM_TYPE_NODE) ? NODE : DATA, WRITE);
 
+	blk_finish_plug(&plug);
+
 	if (gc_type == FG_GC) {
 		while (start_segno < end_segno)
 			if (get_valid_blocks(sbi, start_segno++, 1) == 0)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d78f61d..79a93c6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1618,6 +1618,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
+	struct blk_plug plug;
 	long diff;
 
 	/* balancing f2fs's metadata in background */
@@ -1631,7 +1632,9 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 
 	diff = nr_pages_to_write(sbi, NODE, wbc);
 	wbc->sync_mode = WB_SYNC_NONE;
+	blk_start_plug(&plug);
 	sync_node_pages(sbi, wbc);
+	blk_finish_plug(&plug);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
 	return 0;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e87aa05..d45e6bb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -381,8 +381,13 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			excess_prefree_segs(sbi) ||
 			excess_dirty_nats(sbi) ||
 			(is_idle(sbi) && f2fs_time_over(sbi, CP_TIME))) {
-		if (test_opt(sbi, DATA_FLUSH))
+		if (test_opt(sbi, DATA_FLUSH)) {
+			struct blk_plug plug;
+
+			blk_start_plug(&plug);
 			sync_dirty_inodes(sbi, FILE_INODE);
+			blk_finish_plug(&plug);
+		}
 		f2fs_sync_fs(sbi->sb, true);
 		stat_inc_bg_cp_count(sbi->stat_info);
 	}
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
