From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: avoid dead loop in function
 find_fsync_dnodes
Date: Fri, 8 Dec 2017 11:16:28 +0800
Message-ID: <1512702988-22986-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eN9MD-0008ET-JS
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Dec 2017 03:29:49 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eN9MA-0004Wd-KH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Dec 2017 03:29:49 +0000
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
 fs/f2fs/node.h          |  8 +++++---
 fs/f2fs/recovery.c      | 22 ++++++++++++++--------
 include/linux/f2fs_fs.h |  3 ++-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 0ee3e5f..049ff5e 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -399,9 +399,10 @@ static inline int is_node(struct page *page, int type)
 	return le32_to_cpu(rn->footer.flag) & (1 << type);
 }
 
-#define is_cold_node(page)	is_node(page, COLD_BIT_SHIFT)
-#define is_fsync_dnode(page)	is_node(page, FSYNC_BIT_SHIFT)
-#define is_dent_dnode(page)	is_node(page, DENT_BIT_SHIFT)
+#define is_cold_node(page)		is_node(page, COLD_BIT_SHIFT)
+#define is_fsync_dnode(page)		is_node(page, FSYNC_BIT_SHIFT)
+#define is_dent_dnode(page)		is_node(page, DENT_BIT_SHIFT)
+#define is_recovered_dnode(page)	is_node(page, RECOVERED_BIT_SHIFT)
 
 static inline int is_inline_node(struct page *page)
 {
@@ -442,3 +443,4 @@ static inline void set_mark(struct page *page, int mark, int type)
 }
 #define set_dentry_mark(page, mark)	set_mark(page, mark, DENT_BIT_SHIFT)
 #define set_fsync_mark(page, mark)	set_mark(page, mark, FSYNC_BIT_SHIFT)
+#define set_recovered_mark(page, mark)	set_mark(page, mark, RECOVERED_BIT_SHIFT)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 7d63faf..bfbb3e4 100644
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
@@ -239,7 +247,13 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			return 0;
 
 		page = get_tmp_page(sbi, blkaddr);
+		if (unlikely(is_recovered_dnode(page))) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Abandon dead loop node block list");
+			destroy_fsync_dnodes(head);
+			break;
+		}
 
+		set_recovered_mark(page, RECOVERED_BIT_SHIFT);
 		if (!is_recoverable_dnode(page))
 			break;
 
@@ -288,14 +302,6 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
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
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 43e98d3..9aa85b1 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -265,7 +265,8 @@ enum {
 	COLD_BIT_SHIFT = 0,
 	FSYNC_BIT_SHIFT,
 	DENT_BIT_SHIFT,
-	OFFSET_BIT_SHIFT
+	OFFSET_BIT_SHIFT,
+	RECOVERED_BIT_SHIFT
 };
 
 #define OFFSET_BIT_MASK		(0x07)	/* (0x01 << OFFSET_BIT_SHIFT) - 1 */
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
