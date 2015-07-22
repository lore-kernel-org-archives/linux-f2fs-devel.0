From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: reorganize __f2fs_add_link
Date: Wed, 22 Jul 2015 18:21:52 +0800
Message-ID: <00f201d0c468$550aabf0$ff2003d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Firstly, spliting init_inode_metadata into two parts as below since they
are relatively independent.
1) init_inode_metadata: init datas belong to newly created inode;
2) update_inode_metadata: update inode info for linking inode to new
dentry.

Secondly, move init_inode_metadata to the front of __f2fs_add_link,
So the flow of __f2fs_add_link will be reorganized as:
1) init inode meta data for new creatation;
2) lookup dentry page and insert new directory entry in the page;
3) update meta data of inode and parent.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c    | 129 ++++++++++++++++++++++++++++++++-----------------------
 fs/f2fs/f2fs.h   |   4 +-
 fs/f2fs/inline.c |   2 +-
 3 files changed, 78 insertions(+), 57 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a34ebd8..0ad9a1c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -381,43 +381,68 @@ static int make_empty_dir(struct inode *inode,
 	return 0;
 }
 
-struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
+int init_inode_metadata(struct inode *inode, struct inode *dir,
 			const struct qstr *name, struct page *dpage)
 {
 	struct page *page;
 	int err;
 
-	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
-		page = new_inode_page(inode);
-		if (IS_ERR(page))
-			return page;
+	if (!is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE))
+		return 0;
 
-		if (S_ISDIR(inode->i_mode)) {
-			err = make_empty_dir(inode, dir, page);
-			if (err)
-				goto error;
-		}
+	page = new_inode_page(inode);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
 
-		err = f2fs_init_acl(inode, dir, page, dpage);
+	if (S_ISDIR(inode->i_mode)) {
+		err = make_empty_dir(inode, dir, page);
 		if (err)
-			goto put_error;
+			goto error;
+	}
 
-		err = f2fs_init_security(inode, dir, name, page);
+	err = f2fs_init_acl(inode, dir, page, dpage);
+	if (err)
+		goto put_error;
+
+	err = f2fs_init_security(inode, dir, name, page);
+	if (err)
+		goto put_error;
+
+	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode)) {
+		err = f2fs_inherit_context(dir, inode, page);
 		if (err)
 			goto put_error;
+	}
 
-		if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode)) {
-			err = f2fs_inherit_context(dir, inode, page);
-			if (err)
-				goto put_error;
-		}
-	} else {
-		page = get_node_page(F2FS_I_SB(dir), inode->i_ino);
-		if (IS_ERR(page))
-			return page;
+	if (f2fs_encrypted_inode(dir))
+		file_set_enc_name(inode);
+
+	update_inode(inode, page);
+	f2fs_put_page(page, 1);
+	return 0;
+
+put_error:
+	f2fs_put_page(page, 1);
+error:
+	/* once the failed inode becomes a bad inode, i_mode is S_IFREG */
+	truncate_inode_pages(&inode->i_data, 0);
+	truncate_blocks(inode, 0, false);
+	remove_dirty_dir_inode(inode);
+	remove_inode_page(inode);
+	return err;
+}
+
+struct page *update_inode_metadata(struct inode *dir, struct inode *inode,
+					const struct qstr *name)
+{
+	struct page *page;
+
+	page = get_node_page(F2FS_I_SB(inode), inode->i_ino);
+	if (IS_ERR(page))
+		return page;
 
+	if (!is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE))
 		set_cold_node(inode, page);
-	}
 
 	if (name)
 		init_dent_inode(name, page);
@@ -433,20 +458,10 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 		 * we should remove this inode from orphan list.
 		 */
 		if (inode->i_nlink == 0)
-			remove_orphan_inode(F2FS_I_SB(dir), inode->i_ino);
+			remove_orphan_inode(F2FS_I_SB(inode), inode->i_ino);
 		inc_nlink(inode);
 	}
 	return page;
-
-put_error:
-	f2fs_put_page(page, 1);
-error:
-	/* once the failed inode becomes a bad inode, i_mode is S_IFREG */
-	truncate_inode_pages(&inode->i_data, 0);
-	truncate_blocks(inode, 0, false);
-	remove_dirty_dir_inode(inode);
-	remove_inode_page(inode);
-	return ERR_PTR(err);
 }
 
 void update_parent_metadata(struct inode *dir, struct inode *inode,
@@ -537,10 +552,18 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 	new_name.name = fname_name(&fname);
 	new_name.len = fname_len(&fname);
 
+	if (inode) {
+		down_write(&F2FS_I(inode)->i_sem);
+		err = init_inode_metadata(inode, dir, &new_name, NULL);
+		up_write(&F2FS_I(inode)->i_sem);
+		if (err)
+			goto free_filename;
+	}
+
 	if (f2fs_has_inline_dentry(dir)) {
 		err = f2fs_add_inline_entry(dir, &new_name, inode, ino, mode);
 		if (!err || err != -EAGAIN)
-			goto out;
+			goto free_metadata;
 		else
 			err = 0;
 	}
@@ -558,7 +581,7 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 start:
 	if (unlikely(current_depth == MAX_DIR_HASH_DEPTH)) {
 		err = -ENOSPC;
-		goto out;
+		goto free_metadata;
 	}
 
 	/* Increase the depth, if required */
@@ -575,7 +598,7 @@ start:
 		dentry_page = get_new_data_page(dir, NULL, block, true);
 		if (IS_ERR(dentry_page)) {
 			err = PTR_ERR(dentry_page);
-			goto out;
+			goto free_metadata;
 		}
 
 		dentry_blk = kmap(dentry_page);
@@ -596,13 +619,11 @@ add_dentry:
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
-		page = init_inode_metadata(inode, dir, &new_name, NULL);
+		page = update_inode_metadata(dir, inode, &new_name);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			goto fail;
 		}
-		if (f2fs_encrypted_inode(dir))
-			file_set_enc_name(inode);
 	}
 
 	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
@@ -628,30 +649,30 @@ fail:
 	}
 	kunmap(dentry_page);
 	f2fs_put_page(dentry_page, 1);
-out:
+free_metadata:
+	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
+		truncate_inode_pages(&inode->i_data, 0);
+		truncate_blocks(inode, 0, false);
+		remove_dirty_dir_inode(inode);
+		remove_inode_page(inode);
+	}
+free_filename:
 	f2fs_fname_free_filename(&fname);
 	return err;
 }
 
 int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 {
-	struct page *page;
-	int err = 0;
+	int err;
 
 	down_write(&F2FS_I(inode)->i_sem);
-	page = init_inode_metadata(inode, dir, NULL, NULL);
-	if (IS_ERR(page)) {
-		err = PTR_ERR(page);
-		goto fail;
-	}
-	/* we don't need to mark_inode_dirty now */
-	update_inode(inode, page);
-	f2fs_put_page(page, 1);
+	err = init_inode_metadata(inode, dir, NULL, NULL);
+	up_write(&F2FS_I(inode)->i_sem);
+	if (err)
+		return err;
 
 	clear_inode_flag(F2FS_I(inode), FI_NEW_INODE);
-fail:
-	up_write(&F2FS_I(inode)->i_sem);
-	return err;
+	return 0;
 }
 
 void f2fs_drop_nlink(struct inode *dir, struct inode *inode, struct page *page)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cda9e36..0b5e178 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1622,8 +1622,8 @@ bool f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
 			unsigned int, struct f2fs_str *);
 void do_make_empty_dir(struct inode *, struct inode *,
 			struct f2fs_dentry_ptr *);
-struct page *init_inode_metadata(struct inode *, struct inode *,
-			const struct qstr *, struct page *);
+struct page *update_inode_metadata(struct inode *, struct inode *,
+							const struct qstr *);
 void update_parent_metadata(struct inode *, struct inode *, unsigned int);
 int room_for_filename(const void *, int, int);
 void f2fs_drop_nlink(struct inode *, struct inode *, struct page *);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 38e75fb..22d7038 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -439,7 +439,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
-		page = init_inode_metadata(inode, dir, name, ipage);
+		page = update_inode_metadata(dir, inode, name);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			goto fail;
-- 
2.4.2
