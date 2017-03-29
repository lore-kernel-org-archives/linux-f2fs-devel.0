From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid IO split due to mixed
	WB_SYNC_ALL and WB_SYNC_NONE
Date: Wed, 29 Mar 2017 13:48:15 -0700
Message-ID: <20170329204815.9175-2-jaegeuk@kernel.org>
References: <20170329204815.9175-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ctKW6-0005dA-9F
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Mar 2017 20:48:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ctKW5-0003LC-GP
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Mar 2017 20:48:30 +0000
In-Reply-To: <20170329204815.9175-1-jaegeuk@kernel.org>
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

If two threads try to flush dirty pages in different inodes respectively,
f2fs_write_data_pages() will produce WRITE and WRITE_SYNC one at a time,
resulting in a lot of 4KB seperated IOs.

So, this patch gives higher priority to WB_SYNC_ALL IOs and gathers write
IOs with a big WRITE_SYNC'ed bio.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c  | 15 +++++++++++++--
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8f36080b47c4..b1cac6d85bcb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1605,8 +1605,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				last_idx = page->index;
 			}
 
-			if (--wbc->nr_to_write <= 0 &&
-			    wbc->sync_mode == WB_SYNC_NONE) {
+			/* give a priority to WB_SYNC threads */
+			if ((atomic_read(&F2FS_M_SB(mapping)->wb_sync_req) ||
+					--wbc->nr_to_write <= 0) &&
+					wbc->sync_mode == WB_SYNC_NONE) {
 				done = 1;
 				break;
 			}
@@ -1662,9 +1664,18 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
 
+	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		atomic_inc(&sbi->wb_sync_req);
+	else if (atomic_read(&sbi->wb_sync_req))
+		goto skip_write;
+
 	blk_start_plug(&plug);
 	ret = f2fs_write_cache_pages(mapping, wbc);
 	blk_finish_plug(&plug);
+
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		atomic_dec(&sbi->wb_sync_req);
 	/*
 	 * if some pages were truncated, we cannot guarantee its mapping->host
 	 * to detect pending bios.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 32d6f674c114..fd39db681226 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -888,6 +888,9 @@ struct f2fs_sb_info {
 	/* # of allocated blocks */
 	struct percpu_counter alloc_valid_block_count;
 
+	/* writeback control */
+	atomic_t wb_sync_req;			/* count # of WB_SYNC threads */
+
 	/* valid inode count */
 	struct percpu_counter total_valid_inode_count;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2d78f3c76d18..cb65e6d0d275 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1566,6 +1566,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NR_COUNT_TYPE; i++)
 		atomic_set(&sbi->nr_pages[i], 0);
 
+	atomic_set(&sbi->wb_sync_req, 0);
+
 	INIT_LIST_HEAD(&sbi->s_list);
 	mutex_init(&sbi->umount_mutex);
 	mutex_init(&sbi->wio_mutex[NODE]);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
