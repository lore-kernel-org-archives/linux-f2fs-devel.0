From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: propagate error given by f2fs_find_entry
Date: Thu, 26 May 2016 17:25:21 -0700
Message-ID: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we get ENOMEM or EIO in f2fs_find_entry, we should stop right away.
Otherwise, for example, we can get duplicate directory entry by ->chash and
->clevel.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c    | 23 ++++++++++++++++-------
 fs/f2fs/inline.c |  4 +++-
 fs/f2fs/namei.c  |  5 +++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 24d1308..ae37543 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -185,8 +185,13 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 		/* no need to allocate new dentry pages to all the indices */
 		dentry_page = find_data_page(dir, bidx);
 		if (IS_ERR(dentry_page)) {
-			room = true;
-			continue;
+			if (PTR_ERR(dentry_page) == -ENOENT) {
+				room = true;
+				continue;
+			} else {
+				*res_page = dentry_page;
+				break;
+			}
 		}
 
 		de = find_in_block(dentry_page, fname, namehash, &max_slots,
@@ -223,19 +228,22 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 	struct fscrypt_name fname;
 	int err;
 
-	*res_page = NULL;
-
 	err = fscrypt_setup_filename(dir, child, 1, &fname);
-	if (err)
+	if (err) {
+		*res_page = ERR_PTR(-ENOMEM);
 		return NULL;
+	}
 
 	if (f2fs_has_inline_dentry(dir)) {
+		*res_page = NULL;
 		de = find_in_inline_dir(dir, &fname, res_page);
 		goto out;
 	}
 
-	if (npages == 0)
+	if (npages == 0) {
+		*res_page = NULL;
 		goto out;
+	}
 
 	max_depth = F2FS_I(dir)->i_current_depth;
 	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
@@ -247,8 +255,9 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
+		*res_page = NULL;
 		de = find_in_level(dir, level, &fname, res_page);
-		if (de)
+		if (de || IS_ERR(*res_page))
 			break;
 	}
 out:
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 77c9c24..1eb3043 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -286,8 +286,10 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
 	f2fs_hash_t namehash;
 
 	ipage = get_node_page(sbi, dir->i_ino);
-	if (IS_ERR(ipage))
+	if (IS_ERR(ipage)) {
+		*res_page = ipage;
 		return NULL;
+	}
 
 	namehash = f2fs_dentry_hash(&name);
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 496f4e3..3f6119e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -232,6 +232,9 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 	if (de) {
 		f2fs_dentry_kunmap(dir, page);
 		f2fs_put_page(page, 0);
+	} else if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+		goto out;
 	} else {
 		err = __f2fs_add_link(dir, &dot, NULL, dir->i_ino, S_IFDIR);
 		if (err)
@@ -242,6 +245,8 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 	if (de) {
 		f2fs_dentry_kunmap(dir, page);
 		f2fs_put_page(page, 0);
+	} else if (IS_ERR(page)) {
+		err = PTR_ERR(page);
 	} else {
 		err = __f2fs_add_link(dir, &dotdot, NULL, pino, S_IFDIR);
 	}
-- 
2.6.3
