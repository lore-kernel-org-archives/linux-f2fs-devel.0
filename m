From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid ENOMEM during roll-forward recovery
Date: Fri,  9 Sep 2016 18:45:32 -0700
Message-ID: <20160910014532.33372-2-jaegeuk@kernel.org>
References: <20160910014532.33372-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160910014532.33372-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch gives another chances during roll-forward recovery regarding to
-ENOMEM.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/inode.c    | 15 +++++++++++++++
 fs/f2fs/node.c     |  8 +++++---
 fs/f2fs/recovery.c | 35 +++++++++++++++++++++--------------
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c6ab173..af06303 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1930,6 +1930,7 @@ long f2fs_compat_ioctl(struct file *, unsigned int, unsigned long);
  */
 void f2fs_set_inode_flags(struct inode *);
 struct inode *f2fs_iget(struct super_block *, unsigned long);
+struct inode *f2fs_iget_retry(struct super_block *, unsigned long);
 int try_to_free_nats(struct f2fs_sb_info *, int);
 int update_inode(struct inode *, struct page *);
 int update_inode_page(struct inode *);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9ac5efc..ac4daa5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
 #include <linux/buffer_head.h>
+#include <linux/backing-dev.h>
 #include <linux/writeback.h>
 
 #include "f2fs.h"
@@ -234,6 +235,20 @@ bad_inode:
 	return ERR_PTR(ret);
 }
 
+struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
+{
+	struct inode *inode;
+retry:
+	inode = f2fs_iget(sb, ino);
+	if (IS_ERR(inode)) {
+		if (PTR_ERR(inode) == -ENOMEM) {
+			congestion_wait(BLK_RW_ASYNC, HZ/50);
+			goto retry;
+		}
+	}
+	return inode;
+}
+
 int update_inode(struct inode *inode, struct page *node_page)
 {
 	struct f2fs_inode *ri;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8a28800..2322a8e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2013,10 +2013,12 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 
 	if (unlikely(old_ni.blk_addr != NULL_ADDR))
 		return -EINVAL;
-
+retry:
 	ipage = f2fs_grab_cache_page(NODE_MAPPING(sbi), ino, false);
-	if (!ipage)
-		return -ENOMEM;
+	if (!ipage) {
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
+		goto retry;
+	}
 
 	/* Should not use this inode from free nid list */
 	remove_free_nid(NM_I(sbi), ino);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 12692777..d934154 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -71,18 +71,14 @@ static struct fsync_inode_entry *get_fsync_inode(struct list_head *head,
 static struct fsync_inode_entry *add_fsync_inode(struct f2fs_sb_info *sbi,
 					struct list_head *head, nid_t ino)
 {
-	struct inode *inode = f2fs_iget(sbi->sb, ino);
+	struct inode *inode;
 	struct fsync_inode_entry *entry;
 
+	inode = f2fs_iget_retry(sbi->sb, ino);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	entry = kmem_cache_alloc(fsync_entry_slab, GFP_F2FS_ZERO);
-	if (!entry) {
-		iput(inode);
-		return ERR_PTR(-ENOMEM);
-	}
-
+	entry = f2fs_kmem_cache_alloc(fsync_entry_slab, GFP_F2FS_ZERO);
 	entry->inode = inode;
 	list_add_tail(&entry->list, head);
 
@@ -136,7 +132,7 @@ retry:
 		goto out_unmap_put;
 
 	if (de) {
-		einode = f2fs_iget(inode->i_sb, le32_to_cpu(de->ino));
+		einode = f2fs_iget_retry(inode->i_sb, le32_to_cpu(de->ino));
 		if (IS_ERR(einode)) {
 			WARN_ON(1);
 			err = PTR_ERR(einode);
@@ -158,6 +154,8 @@ retry:
 		err = __f2fs_do_add_link(dir, &fname, inode,
 					inode->i_ino, inode->i_mode);
 	}
+	if (err == -ENOMEM)
+		goto retry;
 	goto out;
 
 out_unmap_put:
@@ -272,7 +270,6 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 					err = 0;
 					goto next;
 				}
-				break;
 			}
 		}
 		entry->blkaddr = blkaddr;
@@ -357,7 +354,7 @@ got_it:
 
 	if (ino != dn->inode->i_ino) {
 		/* Deallocate previous index in the node page */
-		inode = f2fs_iget(sbi->sb, ino);
+		inode = f2fs_iget_retry(sbi->sb, ino);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 	} else {
@@ -425,10 +422,15 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	end = start + ADDRS_PER_PAGE(page, inode);
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-
+retry_dn:
 	err = get_dnode_of_data(&dn, start, ALLOC_NODE);
-	if (err)
+	if (err) {
+		if (err == -ENOMEM) {
+			congestion_wait(BLK_RW_ASYNC, HZ/50);
+			goto retry_dn;
+		}
 		goto out;
+	}
 
 	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
 
@@ -479,11 +481,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 				if (err)
 					goto err;
 			}
-
+retry_prev:
 			/* Check the previous node page having this index */
 			err = check_index_in_prev_nodes(sbi, dest, &dn);
-			if (err)
+			if (err) {
+				if (err == -ENOMEM) {
+					congestion_wait(BLK_RW_ASYNC, HZ/50);
+					goto retry_prev;
+				}
 				goto err;
+			}
 
 			/* write dummy data page */
 			f2fs_replace_block(sbi, &dn, src, dest,
-- 
2.8.3
