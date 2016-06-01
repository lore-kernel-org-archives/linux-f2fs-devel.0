From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: handle writepage correctly
Date: Wed,  1 Jun 2016 16:34:15 -0700
Message-ID: <1464824055-47514-2-git-send-email-jaegeuk@kernel.org>
References: <1464824055-47514-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b8Fec-0001je-Q0
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jun 2016 23:34:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b8Feb-0007bg-P5
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jun 2016 23:34:26 +0000
In-Reply-To: <1464824055-47514-1-git-send-email-jaegeuk@kernel.org>
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

Previously, f2fs_write_data_pages() calls __f2fs_writepage() which calls
f2fs_write_data_page().
If f2fs_write_data_page() returns AOP_WRITEPAGE_ACTIVATE, __f2fs_writepage()
calls mapping_set_error(). But, this should not happen at every time, since
sometimes f2fs_write_data_page() tries to skip writing pages without error.
For example, volatile_write() gives EIO all the time, as Shuoran Liu pointed
out.

Reported-by: Shuoran Liu <liushuoran@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5dcd8db..c9d6fe2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1241,20 +1241,18 @@ write:
 			available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;
 
-	/* Dentry blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode)) {
-		if (unlikely(f2fs_cp_error(sbi)))
-			goto redirty_out;
-		err = do_write_data_page(&fio);
-		goto done;
-	}
-
 	/* we should bypass data pages to proceed the kworkder jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		SetPageError(page);
 		goto out;
 	}
 
+	/* Dentry blocks are controlled by checkpoint */
+	if (S_ISDIR(inode->i_mode)) {
+		err = do_write_data_page(&fio);
+		goto done;
+	}
+
 	if (!wbc->for_reclaim)
 		need_balance_fs = true;
 	else if (has_not_enough_free_secs(sbi, 0))
@@ -1294,16 +1292,8 @@ out:
 
 redirty_out:
 	redirty_page_for_writepage(wbc, page);
-	return AOP_WRITEPAGE_ACTIVATE;
-}
-
-static int __f2fs_writepage(struct page *page, struct writeback_control *wbc,
-			void *data)
-{
-	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(page, wbc);
-	mapping_set_error(mapping, ret);
-	return ret;
+	unlock_page(page);
+	return err;
 }
 
 /*
@@ -1312,8 +1302,7 @@ static int __f2fs_writepage(struct page *page, struct writeback_control *wbc,
  * warm/hot data page.
  */
 static int f2fs_write_cache_pages(struct address_space *mapping,
-			struct writeback_control *wbc, writepage_t writepage,
-			void *data)
+					struct writeback_control *wbc)
 {
 	int ret = 0;
 	int done = 0;
@@ -1395,16 +1384,11 @@ continue_unlock:
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
-			ret = (*writepage)(page, wbc, data);
+			ret = mapping->a_ops->writepage(page, wbc);
 			if (unlikely(ret)) {
-				if (ret == AOP_WRITEPAGE_ACTIVATE) {
-					unlock_page(page);
-					ret = 0;
-				} else {
-					done_index = page->index + 1;
-					done = 1;
-					break;
-				}
+				done_index = page->index + 1;
+				done = 1;
+				break;
 			}
 
 			if (--wbc->nr_to_write <= 0 &&
@@ -1459,7 +1443,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
 
-	ret = f2fs_write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
+	ret = f2fs_write_cache_pages(mapping, wbc);
 	/*
 	 * if some pages were truncated, we cannot guarantee its mapping->host
 	 * to detect pending bios.
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
