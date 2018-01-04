From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v6] f2fs: avoid dead loop in function
 find_fsync_dnodes
Date: Thu, 4 Jan 2018 18:01:04 +0800
Message-ID: <1515060064-26600-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eX2YV-0002ok-4V
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 10:15:23 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eX2YT-0001T1-Ig
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 10:15:23 +0000
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
 fs/f2fs/recovery.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index cbeef73..318243c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -221,11 +221,11 @@ static void recover_inode(struct inode *inode, struct page *page)
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-				bool check_only)
+			bool check_only, block_t *looped_blkaddr)
 {
 	struct curseg_info *curseg;
 	struct page *page = NULL;
-	block_t blkaddr;
+	block_t blkaddr, last_blkaddr;
 	int err = 0;
 
 	/* get node pages in the current segment */
@@ -239,6 +239,17 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			return 0;
 
 		page = get_tmp_page(sbi, blkaddr);
+		if (PageChecked(page)) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Abandon looped node block list");
+			*looped_blkaddr = last_blkaddr;
+			break;
+		}
+
+		/*
+		 * it's not needed to clear PG_checked flag in temp page since we
+		 * will truncate all those pages in the end of recovery.
+		 */
+		SetPageChecked(page);
 
 		if (!is_recoverable_dnode(page))
 			break;
@@ -279,6 +290,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			entry->last_dentry = blkaddr;
 next:
 		/* check next segment */
+		last_blkaddr = blkaddr;
 		blkaddr = next_blkaddr_of_node(page);
 		f2fs_put_page(page, 1);
 
@@ -525,7 +537,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 }
 
 static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
-						struct list_head *dir_list)
+				struct list_head *dir_list, block_t looped_blkaddr)
 {
 	struct curseg_info *curseg;
 	struct page *page = NULL;
@@ -577,6 +589,10 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		if (entry->blkaddr == blkaddr)
 			del_fsync_inode(entry);
 next:
+		/* in case of looped node chain */
+		if (blkaddr == looped_blkaddr)
+			break;
+
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
 		f2fs_put_page(page, 1);
@@ -596,6 +612,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	bool need_writecp = false;
 #ifdef CONFIG_QUOTA
 	int quota_enabled;
+	block_t looped_blkaddr = 0;
 #endif
 
 	if (s_flags & SB_RDONLY) {
@@ -624,7 +641,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	mutex_lock(&sbi->cp_mutex);
 
 	/* step #1: find fsynced inode numbers */
-	err = find_fsync_dnodes(sbi, &inode_list, check_only);
+	err = find_fsync_dnodes(sbi, &inode_list, check_only, &looped_blkaddr);
 	if (err || list_empty(&inode_list))
 		goto skip;
 
@@ -636,7 +653,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	need_writecp = true;
 
 	/* step #2: recover data */
-	err = recover_data(sbi, &inode_list, &dir_list);
+	err = recover_data(sbi, &inode_list, &dir_list, looped_blkaddr);
 	if (!err)
 		f2fs_bug_on(sbi, !list_empty(&inode_list));
 skip:
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
