From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v3] f2fs: modify for accurate fggc node io stat
Date: Fri, 27 Oct 2017 11:17:17 +0800
Message-ID: <1509074237-7693-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <heyunlei@huawei.com>) id 1e7vKz-0002EH-RK
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Oct 2017 03:29:37 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e7vKy-0008IH-AD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Oct 2017 03:29:37 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com

modify for accurate fggc node io stat

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 63 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f44d837..0701713 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1242,37 +1242,6 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	iput(inode);
 }
 
-void move_node_page(struct page *node_page, int gc_type)
-{
-	if (gc_type == FG_GC) {
-		struct f2fs_sb_info *sbi = F2FS_P_SB(node_page);
-		struct writeback_control wbc = {
-			.sync_mode = WB_SYNC_ALL,
-			.nr_to_write = 1,
-			.for_reclaim = 0,
-		};
-
-		set_page_dirty(node_page);
-		f2fs_wait_on_page_writeback(node_page, NODE, true);
-
-		f2fs_bug_on(sbi, PageWriteback(node_page));
-		if (!clear_page_dirty_for_io(node_page))
-			goto out_page;
-
-		if (NODE_MAPPING(sbi)->a_ops->writepage(node_page, &wbc))
-			unlock_page(node_page);
-		goto release_page;
-	} else {
-		/* set page dirty and write it */
-		if (!PageWriteback(node_page))
-			set_page_dirty(node_page);
-	}
-out_page:
-	unlock_page(node_page);
-release_page:
-	f2fs_put_page(node_page, 0);
-}
-
 static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	pgoff_t index, end;
@@ -1415,6 +1384,38 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
+void move_node_page(struct page *node_page, int gc_type)
+{
+	if (gc_type == FG_GC) {
+		struct f2fs_sb_info *sbi = F2FS_P_SB(node_page);
+		struct writeback_control wbc = {
+			.sync_mode = WB_SYNC_ALL,
+			.nr_to_write = 1,
+			.for_reclaim = 0,
+		};
+
+		set_page_dirty(node_page);
+		f2fs_wait_on_page_writeback(node_page, NODE, true);
+
+		f2fs_bug_on(sbi, PageWriteback(node_page));
+		if (!clear_page_dirty_for_io(node_page))
+			goto out_page;
+
+		if (__write_node_page(node_page, false, NULL,
+					&wbc, false, FS_GC_NODE_IO))
+			unlock_page(node_page);
+		goto release_page;
+	} else {
+		/* set page dirty and write it */
+		if (!PageWriteback(node_page))
+			set_page_dirty(node_page);
+	}
+out_page:
+	unlock_page(node_page);
+release_page:
+	f2fs_put_page(node_page, 0);
+}
+
 static int f2fs_write_node_page(struct page *page,
 				struct writeback_control *wbc)
 {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
