From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: drop page cache after fs shutdown
Date: Thu, 18 Jan 2018 17:29:10 +0800
Message-ID: <20180118092910.110016-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1ec6Vu-0001rj-UC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jan 2018 09:29:38 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ec6Vt-0002Nh-GV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jan 2018 09:29:38 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Don't remain dirtied page cache in f2fs after shutdown, it can mitigate
memory pressure of whole system, in order to keep other modules working
properly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  7 +++++--
 fs/f2fs/data.c       | 12 ++++++------
 fs/f2fs/node.c       | 19 ++++++++++---------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d1f160ae4959..dc8b08426bb4 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -237,12 +237,15 @@ static int __f2fs_write_meta_page(struct page *page,
 
 	trace_f2fs_writepage(page, META);
 
+	if (unlikely(f2fs_cp_error(sbi))) {
+		dec_page_count(sbi, F2FS_DIRTY_META);
+		unlock_page(page);
+		return 0;
+	}
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
 		goto redirty_out;
-	if (unlikely(f2fs_cp_error(sbi)))
-		goto redirty_out;
 
 	write_meta_page(sbi, page, io_type);
 	dec_page_count(sbi, F2FS_DIRTY_META);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ec4a3ca39c41..fcba1ef05f3c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1715,6 +1715,12 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 	trace_f2fs_writepage(page, DATA);
 
+	/* we should bypass data pages to proceed the kworkder jobs */
+	if (unlikely(f2fs_cp_error(sbi))) {
+		mapping_set_error(page->mapping, -EIO);
+		goto out;
+	}
+
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
@@ -1739,12 +1745,6 @@ static int __write_data_page(struct page *page, bool *submitted,
 			available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;
 
-	/* we should bypass data pages to proceed the kworkder jobs */
-	if (unlikely(f2fs_cp_error(sbi))) {
-		mapping_set_error(page->mapping, -EIO);
-		goto out;
-	}
-
 	/* Dentry blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode)) {
 		fio.need_lock = LOCK_DONE;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c6077ba816a0..9822c9a34823 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1344,10 +1344,14 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 
 	trace_f2fs_writepage(page, NODE);
 
+	if (unlikely(f2fs_cp_error(sbi))) {
+		dec_page_count(sbi, F2FS_DIRTY_NODES);
+		unlock_page(page);
+		return 0;
+	}
+
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
-	if (unlikely(f2fs_cp_error(sbi)))
-		goto redirty_out;
 
 	/* get old block addr of this node page */
 	nid = nid_of_node(page);
@@ -1592,12 +1596,6 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 			struct page *page = pvec.pages[i];
 			bool submitted = false;
 
-			if (unlikely(f2fs_cp_error(sbi))) {
-				pagevec_release(&pvec);
-				ret = -EIO;
-				goto out;
-			}
-
 			/*
 			 * flushing sequence with step:
 			 * 0. indirect nodes
@@ -1667,9 +1665,12 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 		step++;
 		goto next_step;
 	}
-out:
+
 	if (nwritten)
 		f2fs_submit_merged_write(sbi, NODE);
+
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
 	return ret;
 }
 
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
