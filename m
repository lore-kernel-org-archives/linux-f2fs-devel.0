From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: add common iget in add_fsync_inode
Date: Fri,  9 Sep 2016 18:45:31 -0700
Message-ID: <20160910014532.33372-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

There is no functional change.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index ba0fc2e..12692777 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -68,14 +68,20 @@ static struct fsync_inode_entry *get_fsync_inode(struct list_head *head,
 	return NULL;
 }
 
-static struct fsync_inode_entry *add_fsync_inode(struct list_head *head,
-							struct inode *inode)
+static struct fsync_inode_entry *add_fsync_inode(struct f2fs_sb_info *sbi,
+					struct list_head *head, nid_t ino)
 {
+	struct inode *inode = f2fs_iget(sbi->sb, ino);
 	struct fsync_inode_entry *entry;
 
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
 	entry = kmem_cache_alloc(fsync_entry_slab, GFP_F2FS_ZERO);
-	if (!entry)
-		return NULL;
+	if (!entry) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	entry->inode = inode;
 	list_add_tail(&entry->list, head);
@@ -105,16 +111,10 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 
 	entry = get_fsync_inode(dir_list, pino);
 	if (!entry) {
-		dir = f2fs_iget(inode->i_sb, pino);
-		if (IS_ERR(dir)) {
-			err = PTR_ERR(dir);
-			goto out;
-		}
-
-		entry = add_fsync_inode(dir_list, dir);
-		if (!entry) {
-			err = -ENOMEM;
-			iput(dir);
+		entry = add_fsync_inode(F2FS_I_SB(inode), dir_list, pino);
+		if (IS_ERR(entry)) {
+			dir = ERR_CAST(entry);
+			err = PTR_ERR(entry);
 			goto out;
 		}
 	}
@@ -228,7 +228,6 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 {
 	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
-	struct inode *inode;
 	struct page *page = NULL;
 	block_t blkaddr;
 	int err = 0;
@@ -266,23 +265,15 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 			 * CP | dnode(F) | inode(DF)
 			 * For this case, we should not give up now.
 			 */
-			inode = f2fs_iget(sbi->sb, ino_of_node(page));
-			if (IS_ERR(inode)) {
-				err = PTR_ERR(inode);
+			entry = add_fsync_inode(sbi, head, ino_of_node(page));
+			if (IS_ERR(entry)) {
+				err = PTR_ERR(entry);
 				if (err == -ENOENT) {
 					err = 0;
 					goto next;
 				}
 				break;
 			}
-
-			/* add this fsync inode to the list */
-			entry = add_fsync_inode(head, inode);
-			if (!entry) {
-				err = -ENOMEM;
-				iput(inode);
-				break;
-			}
 		}
 		entry->blkaddr = blkaddr;
 
-- 
2.8.3
