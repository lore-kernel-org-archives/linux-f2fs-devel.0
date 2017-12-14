From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v3] f2fs: avoid dead loop in function
 find_fsync_dnodes
Date: Thu, 14 Dec 2017 11:54:52 +0800
Message-ID: <1513223692-20178-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1ePKox-0005Su-Od
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Dec 2017 04:08:31 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ePKow-0003Fk-9g
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Dec 2017 04:08:31 +0000
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

Came across a dead loop in recovery like this:

......
[   24.680480s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597696
[   24.698394s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597697
[   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724426s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
......

Mount process will block in dead loop and fsck can do nothing with this
error, This patch abandon recovery if node chain is cyclical.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/data.c     |  5 +++++
 fs/f2fs/recovery.c | 23 +++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7aca6cc..2ac992f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2146,6 +2146,9 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 		}
 	}
 
+	if (PageChecked(page))
+		ClearPageChecked(page);
+
 	/* This is atomic written page, keep Private */
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return drop_inmem_page(inode, page);
@@ -2292,6 +2295,8 @@ int f2fs_migrate_page(struct address_space *mapping,
 		SetPagePrivate(newpage);
 	set_page_private(newpage, page_private(page));
 
+	if (PageChecked(page))
+		SetPageChecked(page);
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
 	else
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 7d63faf..905be02 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -220,6 +220,14 @@ static void recover_inode(struct inode *inode, struct page *page)
 			ino_of_node(page), name);
 }
 
+static void destroy_fsync_dnodes(struct list_head *head)
+{
+	struct fsync_inode_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, head, list)
+		del_fsync_inode(entry);
+}
+
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 				bool check_only)
 {
@@ -239,7 +247,14 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			return 0;
 
 		page = get_tmp_page(sbi, blkaddr);
+		if (PageChecked(page)) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Abandon dead loop node block list");
+			destroy_fsync_dnodes(head);
+			break;
+		}
 
+		/* No need ClearPageChecked for page cache truncated */
+		SetPageChecked(page);
 		if (!is_recoverable_dnode(page))
 			break;
 
@@ -288,14 +303,6 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	return err;
 }
 
-static void destroy_fsync_dnodes(struct list_head *head)
-{
-	struct fsync_inode_entry *entry, *tmp;
-
-	list_for_each_entry_safe(entry, tmp, head, list)
-		del_fsync_inode(entry);
-}
-
 static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 			block_t blkaddr, struct dnode_of_data *dn)
 {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
