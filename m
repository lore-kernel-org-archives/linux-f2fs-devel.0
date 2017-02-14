From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix multiple f2fs_add_link() calls having same name
Date: Tue, 14 Feb 2017 10:03:45 -0800
Message-ID: <20170214180345.2074-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

VFS uses f2fs_lookup() to decide f2fs_add_link() call during file creation.
But, if there is a race condition, f2fs_add_link() can be called multiple
times, resulting in multiple dentries with a same name. This patches fixes
it by adding __f2fs_find_entry() in f2fs_add_link() path.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 827c5daef4fc..bc7c48839bec 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -643,14 +643,24 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct fscrypt_name fname;
+	struct page *page;
+	struct f2fs_dir_entry *de;
 	int err;
 
 	err = fscrypt_setup_filename(dir, name, 0, &fname);
 	if (err)
 		return err;
 
-	err = __f2fs_do_add_link(dir, &fname, inode, ino, mode);
-
+	de = __f2fs_find_entry(dir, &fname, &page);
+	if (de) {
+		f2fs_dentry_kunmap(dir, page);
+		f2fs_put_page(page, 0);
+		err = -EEXIST;
+	} else if (!IS_ERR(page)) {
+		err = __f2fs_do_add_link(dir, &fname, inode, ino, mode);
+	} else {
+		err = PTR_ERR(page);
+	}
 	fscrypt_free_filename(&fname);
 	return err;
 }
-- 
2.11.0
