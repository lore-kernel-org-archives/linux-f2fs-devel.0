From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to report error number of f2fs_find_entry
Date: Tue, 19 Jul 2016 08:27:47 +0800
Message-ID: <20160719002747.99943-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes to report the right error number of f2fs_find_entry to
its caller.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c      | 10 +++++-----
 fs/f2fs/f2fs.h     |  2 +-
 fs/f2fs/namei.c    | 46 +++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/recovery.c |  7 +++++--
 4 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index db4022f..a485f68 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -272,17 +272,17 @@ struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct page **p)
 	return f2fs_find_entry(dir, &dotdot, p);
 }
 
-ino_t f2fs_inode_by_name(struct inode *dir, struct qstr *qstr)
+ino_t f2fs_inode_by_name(struct inode *dir, struct qstr *qstr,
+							struct page **page)
 {
 	ino_t res = 0;
 	struct f2fs_dir_entry *de;
-	struct page *page;
 
-	de = f2fs_find_entry(dir, qstr, &page);
+	de = f2fs_find_entry(dir, qstr, page);
 	if (de) {
 		res = le32_to_cpu(de->ino);
-		f2fs_dentry_kunmap(dir, page);
-		f2fs_put_page(page, 0);
+		f2fs_dentry_kunmap(dir, *page);
+		f2fs_put_page(*page, 0);
 	}
 
 	return res;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 55f1a41..c355621 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1918,7 +1918,7 @@ void f2fs_drop_nlink(struct inode *, struct inode *);
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *, struct qstr *,
 							struct page **);
 struct f2fs_dir_entry *f2fs_parent_dir(struct inode *, struct page **);
-ino_t f2fs_inode_by_name(struct inode *, struct qstr *);
+ino_t f2fs_inode_by_name(struct inode *, struct qstr *, struct page **);
 void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
 				struct page *, struct inode *);
 int update_dent_inode(struct inode *, struct inode *, const struct qstr *);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c9ba6d7..73fa356 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -202,9 +202,13 @@ out:
 struct dentry *f2fs_get_parent(struct dentry *child)
 {
 	struct qstr dotdot = QSTR_INIT("..", 2);
-	unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot);
-	if (!ino)
+	struct page *page;
+	unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot, &page);
+	if (!ino) {
+		if (IS_ERR(page))
+			return ERR_CAST(page);
 		return ERR_PTR(-ENOENT);
+	}
 	return d_obtain_alias(f2fs_iget(child->d_sb, ino));
 }
 
@@ -338,8 +342,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	trace_f2fs_unlink_enter(dir, dentry);
 
 	de = f2fs_find_entry(dir, &dentry->d_name, &page);
-	if (!de)
+	if (!de) {
+		if (IS_ERR(page))
+			err = PTR_ERR(page);
 		goto fail;
+	}
 
 	f2fs_balance_fs(sbi, true);
 
@@ -658,13 +665,17 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
-	if (!old_entry)
+	if (!old_entry) {
+		if (IS_ERR(old_page))
+			err = PTR_ERR(old_page);
 		goto out;
+	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
 		if (!old_dir_entry) {
-			err = PTR_ERR(old_dir_page);
+			if (IS_ERR(old_dir_page))
+				err = PTR_ERR(old_dir_page);
 			goto out_old;
 		}
 	}
@@ -684,8 +695,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		err = -ENOENT;
 		new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name,
 						&new_page);
-		if (!new_entry)
+		if (!new_entry) {
+			if (IS_ERR(new_page))
+				err = PTR_ERR(new_page);
 			goto out_whiteout;
+		}
 
 		f2fs_balance_fs(sbi, true);
 
@@ -743,7 +757,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			old_entry = f2fs_find_entry(old_dir,
 						&old_dentry->d_name, &old_page);
 			if (!old_entry) {
-				err = -EIO;
+				err = -ENOENT;
+				if (IS_ERR(old_page))
+					err = PTR_ERR(old_page);
 				f2fs_unlock_op(sbi);
 				goto out_whiteout;
 			}
@@ -829,12 +845,18 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return -EPERM;
 
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
-	if (!old_entry)
+	if (!old_entry) {
+		if (IS_ERR(old_page))
+			err = PTR_ERR(old_page);
 		goto out;
+	}
 
 	new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name, &new_page);
-	if (!new_entry)
+	if (!new_entry) {
+		if (IS_ERR(new_page))
+			err = PTR_ERR(new_page);
 		goto out_old;
+	}
 
 	/* prepare for updating ".." directory entry info later */
 	if (old_dir != new_dir) {
@@ -842,7 +864,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 			old_dir_entry = f2fs_parent_dir(old_inode,
 							&old_dir_page);
 			if (!old_dir_entry) {
-				err = PTR_ERR(old_dir_page);
+				if (IS_ERR(old_dir_page))
+					err = PTR_ERR(old_dir_page);
 				goto out_new;
 			}
 		}
@@ -851,7 +874,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 			new_dir_entry = f2fs_parent_dir(new_inode,
 							&new_dir_page);
 			if (!new_dir_entry) {
-				err = PTR_ERR(new_dir_page);
+				if (IS_ERR(new_dir_page))
+					err = PTR_ERR(new_dir_page);
 				goto out_old_dir;
 			}
 		}
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index a39d84a..5d4461f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -153,9 +153,12 @@ retry:
 		f2fs_delete_entry(de, page, dir, einode);
 		iput(einode);
 		goto retry;
+	} else if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+	} else {
+		err = __f2fs_add_link(dir, &name, inode,
+					inode->i_ino, inode->i_mode);
 	}
-	err = __f2fs_add_link(dir, &name, inode, inode->i_ino, inode->i_mode);
-
 	goto out;
 
 out_unmap_put:
-- 
2.7.2
