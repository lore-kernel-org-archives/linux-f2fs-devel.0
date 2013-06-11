From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: avoid freqeunt write_inode calls
Date: Tue, 11 Jun 2013 15:55:34 +0900
Message-ID: <1370933734-343-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

If update_inode is called, we don't need to do write_inode.
So, let's use a *dirty* flag for each inode.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  |  1 +
 fs/f2fs/inode.c |  4 ++++
 fs/f2fs/super.c | 12 ++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 27edf59..a05aa65 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -856,6 +856,7 @@ static inline int f2fs_clear_bit(unsigned int nr, char *addr)
 /* used for f2fs_inode_info->flags */
 enum {
 	FI_NEW_INODE,		/* indicate newly allocated inode */
+	FI_DIRTY_INODE,		/* indicate inode is dirty or not */
 	FI_INC_LINK,		/* need to increment i_nlink */
 	FI_ACL_MODE,		/* indicate acl mode */
 	FI_NO_ALLOC,		/* should not allocate any blocks */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2f649b8..fda226f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -147,6 +147,7 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	} else {
 		/* if there is no written node page, write its inode page */
 		while (!sync_node_pages(sbi, inode->i_ino, &wbc)) {
+			mark_inode_dirty_sync(inode);
 			ret = f2fs_write_inode(inode, NULL);
 			if (ret)
 				goto out;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b44a4c1..2b2d45d1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -192,6 +192,7 @@ void update_inode(struct inode *inode, struct page *node_page)
 
 	set_cold_node(inode, node_page);
 	set_page_dirty(node_page);
+	clear_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
 }
 
 int update_inode_page(struct inode *inode)
@@ -217,6 +218,9 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return 0;
 
+	if (!is_inode_flag_set(F2FS_I(inode), FI_DIRTY_INODE))
+		return 0;
+
 	if (wbc)
 		f2fs_balance_fs(sbi);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4fdcdff..49ce011 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -112,6 +112,17 @@ static int f2fs_drop_inode(struct inode *inode)
 	return generic_drop_inode(inode);
 }
 
+/*
+ * f2fs_dirty_inode() is called from __mark_inode_dirty()
+ *
+ * We should call set_dirty_inode to write the dirty inode through write_inode.
+ */
+void f2fs_dirty_inode(struct inode *inode, int flags)
+{
+	set_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
+	return;
+}
+
 static void f2fs_i_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
@@ -249,6 +260,7 @@ static struct super_operations f2fs_sops = {
 	.drop_inode	= f2fs_drop_inode,
 	.destroy_inode	= f2fs_destroy_inode,
 	.write_inode	= f2fs_write_inode,
+	.dirty_inode	= f2fs_dirty_inode,
 	.show_options	= f2fs_show_options,
 	.evict_inode	= f2fs_evict_inode,
 	.put_super	= f2fs_put_super,
-- 
1.8.1.3.566.gaa39828
