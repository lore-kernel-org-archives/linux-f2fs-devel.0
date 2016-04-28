From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] f2fs: factor out fsync inode entry operations
Date: Thu, 28 Apr 2016 23:15:56 +0800
Message-ID: <5722292C.7090601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1avnfs-0008SK-AR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Apr 2016 15:16:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1avnfp-00010i-VI
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Apr 2016 15:16:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Factor out fsync inode entry operations into {add,del}_fsync_inode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 59 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index a646d3b..481f94e 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -67,6 +67,28 @@ static struct fsync_inode_entry *get_fsync_inode(struct
list_head *head,
 	return NULL;
 }

+static struct fsync_inode_entry * add_fsync_inode(struct list_head *head,
+							struct inode *inode)
+{
+	struct fsync_inode_entry *entry;
+
+	entry = kmem_cache_alloc(fsync_entry_slab, GFP_F2FS_ZERO);
+	if (!entry)
+		return NULL;
+
+	entry->inode = inode;
+	list_add_tail(&entry->list, head);
+
+	return entry;
+}
+
+static void del_fsync_inode(struct fsync_inode_entry *entry)
+{
+	iput(entry->inode);
+	list_del(&entry->list);
+	kmem_cache_free(fsync_entry_slab, entry);
+}
+
 static int recover_dentry(struct inode *inode, struct page *ipage)
 {
 	struct f2fs_inode *raw_inode = F2FS_INODE(ipage);
@@ -198,6 +220,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi,
struct list_head *head)
 {
 	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
+	struct inode *inode;
 	struct page *page = NULL;
 	block_t blkaddr;
 	int err = 0;
@@ -233,27 +256,27 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi,
struct list_head *head)
 					break;
 			}

-			/* add this fsync inode to the list */
-			entry = kmem_cache_alloc(fsync_entry_slab, GFP_F2FS_ZERO);
-			if (!entry) {
-				err = -ENOMEM;
-				break;
-			}
 			/*
 			 * CP | dnode(F) | inode(DF)
 			 * For this case, we should not give up now.
 			 */
-			entry->inode = f2fs_iget(sbi->sb, ino_of_node(page));
-			if (IS_ERR(entry->inode)) {
-				err = PTR_ERR(entry->inode);
-				kmem_cache_free(fsync_entry_slab, entry);
+			inode = f2fs_iget(sbi->sb, ino_of_node(page));
+			if (IS_ERR(inode)) {
+				err = PTR_ERR(inode);
 				if (err == -ENOENT) {
 					err = 0;
 					goto next;
 				}
 				break;
 			}
-			list_add_tail(&entry->list, head);
+
+			/* add this fsync inode to the list */
+			entry = add_fsync_inode(head, inode);
+			if (!entry) {
+				err = -ENOMEM;
+				iput(inode);
+				break;
+			}
 		}
 		entry->blkaddr = blkaddr;

@@ -274,11 +297,8 @@ static void destroy_fsync_dnodes(struct list_head *head)
 {
 	struct fsync_inode_entry *entry, *tmp;

-	list_for_each_entry_safe(entry, tmp, head, list) {
-		iput(entry->inode);
-		list_del(&entry->list);
-		kmem_cache_free(fsync_entry_slab, entry);
-	}
+	list_for_each_entry_safe(entry, tmp, head, list)
+		del_fsync_inode(entry);
 }

 static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
@@ -533,11 +553,8 @@ static int recover_data(struct f2fs_sb_info *sbi, struct
list_head *head)
 			break;
 		}

-		if (entry->blkaddr == blkaddr) {
-			iput(entry->inode);
-			list_del(&entry->list);
-			kmem_cache_free(fsync_entry_slab, entry);
-		}
+		if (entry->blkaddr == blkaddr)
+			del_fsync_inode(entry);
 next:
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
-- 
2.7.2


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
