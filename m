From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: avoid dead loop in function
 find_fsync_dnodes
Date: Mon, 11 Dec 2017 12:23:32 +0800
Message-ID: <1512966212-12595-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eOFpw-0004p5-Kx
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Dec 2017 04:37:04 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eOFpv-0000bk-1x
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Dec 2017 04:37:04 +0000
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
 fs/f2fs/f2fs.h     |  6 +++++
 fs/f2fs/recovery.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 82f1dc3..4649663 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -289,6 +289,12 @@ struct fsync_inode_entry {
 	block_t last_dentry;	/* block address locating the last dentry */
 };
 
+/* for the block of node chain, used only during recovery */
+struct fsync_node_entry {
+	struct list_head list;	/* list head */
+	block_t blkaddr;	/* locating the node block in recovery chain */
+};
+
 #define nats_in_cursum(jnl)		(le16_to_cpu((jnl)->n_nats))
 #define sits_in_cursum(jnl)		(le16_to_cpu((jnl)->n_sits))
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 7d63faf..9958abb 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -46,6 +46,7 @@
  */
 
 static struct kmem_cache *fsync_entry_slab;
+static struct kmem_cache *fsync_node_chain_slab;
 
 bool space_for_roll_forward(struct f2fs_sb_info *sbi)
 {
@@ -220,14 +221,55 @@ static void recover_inode(struct inode *inode, struct page *page)
 			ino_of_node(page), name);
 }
 
+static void destroy_node_blocks(struct list_head *head)
+{
+	struct fsync_node_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, head, list) {
+		list_del(&entry->list);
+		kmem_cache_free(fsync_node_chain_slab, entry);
+	}
+}
+
+static bool blkaddr_already_in_list(struct list_head *head, block_t blkaddr)
+{
+	struct fsync_node_entry *entry;
+
+	list_for_each_entry(entry, head, list)
+		if (entry->blkaddr == blkaddr)
+			return true;
+
+	return false;
+}
+
+static void add_fsync_node(struct list_head *head, block_t blkaddr)
+{
+	struct fsync_node_entry *entry;
+
+	entry = f2fs_kmem_cache_alloc(fsync_node_chain_slab, GFP_F2FS_ZERO);
+	entry->blkaddr = blkaddr;
+	list_add_tail(&entry->list, head);
+}
+
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
 	struct curseg_info *curseg;
 	struct page *page = NULL;
+	struct list_head node_block_list;
 	block_t blkaddr;
 	int err = 0;
 
+	INIT_LIST_HEAD(&node_block_list);
+
 	/* get node pages in the current segment */
 	curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
@@ -239,7 +281,13 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			return 0;
 
 		page = get_tmp_page(sbi, blkaddr);
+		if (unlikely(blkaddr_already_in_list(&node_block_list, blkaddr))) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Abandon dead loop node block list");
+			destroy_fsync_dnodes(head);
+			break;
+		}
 
+		add_fsync_node(&node_block_list, blkaddr);
 		if (!is_recoverable_dnode(page))
 			break;
 
@@ -284,18 +332,12 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 
 		ra_meta_pages_cond(sbi, blkaddr);
 	}
+
+	destroy_node_blocks(&node_block_list);
 	f2fs_put_page(page, 1);
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
@@ -614,7 +656,14 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 			sizeof(struct fsync_inode_entry));
 	if (!fsync_entry_slab) {
 		err = -ENOMEM;
-		goto out;
+		goto free_inode_entry;
+	}
+
+	fsync_node_chain_slab = f2fs_kmem_cache_create("f2fs_fsync_node_entry",
+			sizeof(struct fsync_node_entry));
+	if (!fsync_node_chain_slab) {
+		err = -ENOMEM;
+		goto free_node_entry;
 	}
 
 	INIT_LIST_HEAD(&inode_list);
@@ -664,8 +713,10 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 		err = write_checkpoint(sbi, &cpc);
 	}
 
+	kmem_cache_destroy(fsync_node_chain_slab);
+free_node_entry:
 	kmem_cache_destroy(fsync_entry_slab);
-out:
+free_inode_entry:
 #ifdef CONFIG_QUOTA
 	/* Turn quotas off */
 	if (quota_enabled)
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
