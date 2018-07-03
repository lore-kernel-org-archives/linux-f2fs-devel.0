From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to avoid broken of dnode block list
Date: Tue, 3 Jul 2018 20:12:52 +0800
Message-ID: <20180703121253.44560-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1faKBp-0004Jm-Pm
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Jul 2018 12:13:49 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1faKBn-00Fgsw-RP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Jul 2018 12:13:49 +0000
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

f2fs recovery flow is relying on dnode block link list, it means fsynced
file recovery depends on previous dnode's persistence in the list, so
during fsync() we should wait on all regular inode's dnode writebacked
before issuing flush.

By this way, we can avoid dnode block list being broken by out-of-order
IO submission due to IO scheduler or driver.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 17 ++++-------------
 fs/f2fs/node.c |  4 ++--
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 752ff678bfe0..ecca7b833268 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -292,19 +292,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		goto sync_nodes;
 	}
 
-	/*
-	 * If it's atomic_write, it's just fine to keep write ordering. So
-	 * here we don't need to wait for node write completion, since we use
-	 * node chain which serializes node blocks. If one of node writes are
-	 * reordered, we can see simply broken chain, resulting in stopping
-	 * roll-forward recovery. It means we'll recover all or none node blocks
-	 * given fsync mark.
-	 */
-	if (!atomic) {
-		ret = f2fs_wait_on_node_pages_writeback(sbi, ino);
-		if (ret)
-			goto out;
-	}
+
+	ret = f2fs_wait_on_node_pages_writeback(sbi);
+	if (ret)
+		goto out;
 
 	/* once recovery info is written, don't need to tack this */
 	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 849c2ed9c152..0810c8117d46 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1710,7 +1710,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 	return ret;
 }
 
-int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
+int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi)
 {
 	pgoff_t index = 0;
 	struct pagevec pvec;
@@ -1726,7 +1726,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			if (ino && ino_of_node(page) == ino) {
+			if (IS_DNODE(page) && is_cold_node(page)) {
 				f2fs_wait_on_page_writeback(page, NODE, true);
 				if (TestClearPageError(page))
 					ret = -EIO;
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
