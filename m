From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix missing skip pages info
Date: Thu, 4 Feb 2016 16:14:00 +0800
Message-ID: <1454573640-12087-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aRF1n-0000Lc-2J
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Feb 2016 08:12:35 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aRF1e-0004yW-JT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Feb 2016 08:12:35 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao2.yu@samsung.com, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

fix missing skip pages info in f2fs_writepages trace event.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c | 5 +++--
 fs/f2fs/data.c       | 5 +++--
 fs/f2fs/node.c       | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9c0d721..536bec9 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -256,13 +256,13 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	long diff, written;
 
-	trace_f2fs_writepages(mapping->host, wbc, META);
-
 	/* collect a number of dirty meta pages and write together */
 	if (wbc->for_kupdate ||
 		get_pages(sbi, F2FS_DIRTY_META) < nr_pages_to_skip(sbi, META))
 		goto skip_write;
 
+	trace_f2fs_writepages(mapping->host, wbc, META);
+
 	/* if mounting is failed, skip writing node pages */
 	mutex_lock(&sbi->cp_mutex);
 	diff = nr_pages_to_write(sbi, META, wbc);
@@ -273,6 +273,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 
 skip_write:
 	wbc->pages_skipped += get_pages(sbi, F2FS_DIRTY_META);
+	trace_f2fs_writepages(mapping->host, wbc, META);
 	return 0;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 316eb5d..1c47490 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1341,8 +1341,6 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	int ret;
 	long diff;
 
-	trace_f2fs_writepages(mapping->host, wbc, DATA);
-
 	/* deal with chardevs and other special file */
 	if (!mapping->a_ops->writepage)
 		return 0;
@@ -1364,6 +1362,8 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto skip_write;
 
+	trace_f2fs_writepages(mapping->host, wbc, DATA);
+
 	diff = nr_pages_to_write(sbi, DATA, wbc);
 
 	if (!S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_ALL) {
@@ -1382,6 +1382,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 skip_write:
 	wbc->pages_skipped += get_dirty_pages(inode);
+	trace_f2fs_writepages(mapping->host, wbc, DATA);
 	return 0;
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e08b8d5..150907f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1460,8 +1460,6 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	long diff;
 
-	trace_f2fs_writepages(mapping->host, wbc, NODE);
-
 	/* balancing f2fs's metadata in background */
 	f2fs_balance_fs_bg(sbi);
 
@@ -1469,6 +1467,8 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	if (get_pages(sbi, F2FS_DIRTY_NODES) < nr_pages_to_skip(sbi, NODE))
 		goto skip_write;
 
+	trace_f2fs_writepages(mapping->host, wbc, NODE);
+
 	diff = nr_pages_to_write(sbi, NODE, wbc);
 	wbc->sync_mode = WB_SYNC_NONE;
 	sync_node_pages(sbi, 0, wbc);
@@ -1477,6 +1477,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 
 skip_write:
 	wbc->pages_skipped += get_pages(sbi, F2FS_DIRTY_NODES);
+	trace_f2fs_writepages(mapping->host, wbc, NODE);
 	return 0;
 }
 
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
