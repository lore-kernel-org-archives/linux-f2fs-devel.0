From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH v2] f2fs: fix to release inode page in
	get_new_data_page
Date: Mon, 03 Aug 2015 21:03:09 +0800
Message-ID: <001701d0cdec$d74ba820$85e2f860$@samsung.com>
References: <00f501d0be1d$e89f08d0$b9dd1a70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <00f501d0be1d$e89f08d0$b9dd1a70$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

>From c0f2abda489150d5d458aaae9026f1243daea604 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Tue, 14 Jul 2015 18:14:06 +0800
Subject: [PATCH v3] f2fs: fix to release inode page correctly

In following call path, we will pass a locked and referenced ipage
pointer to get_new_data_page:
 - init_inode_metadata
  - make_empty_dir
   - get_new_data_page

There are two exit paths in get_new_data_page when error occurs:
1) grab_cache_page fails, ipage will not be released;
2) f2fs_reserve_block fails, ipage will be released in callee.

So, it's not consistent for error handling in get_new_data_page.

For f2fs_reserve_block, it's not very easy to change the rule
of error handling, since it's already complicated.

Here we deside to choose an easy way to fix this issue:
If any error occur in get_new_data_page, we will ensure releasing
ipage in this function.

The same issue is in f2fs_convert_inline_dir, fix that too.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v3:
 * fix the same issue in f2fs_convert_inline_dir.

 fs/f2fs/data.c   | 11 +++++++++--
 fs/f2fs/inline.c | 13 ++++++++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e58562e..5da0529 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -387,7 +387,8 @@ repeat:
  *
  * Also, caller should grab and release a rwsem by calling f2fs_lock_op() and
  * f2fs_unlock_op().
- * Note that, ipage is set only by make_empty_dir.
+ * Note that, ipage is set only by make_empty_dir, and if any error occur,
+ * ipage should be released by this function.
  */
 struct page *get_new_data_page(struct inode *inode,
 		struct page *ipage, pgoff_t index, bool new_i_size)
@@ -398,8 +399,14 @@ struct page *get_new_data_page(struct inode *inode,
 	int err;
 repeat:
 	page = grab_cache_page(mapping, index);
-	if (!page)
+	if (!page) {
+		/*
+		 * before exiting, we should make sure ipage will be released
+		 * if any error occur.
+		 */
+		f2fs_put_page(ipage, 1);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	set_new_dnode(&dn, inode, ipage, NULL, 0);
 	err = f2fs_reserve_block(&dn, index);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index a13ffcc..79d18d5 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -360,6 +360,10 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 	return 0;
 }
 
+/*
+ * NOTE: ipage is grabbed by caller, but if any error occurs, we should
+ * release ipage in this function.
+ */
 static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 				struct f2fs_inline_dentry *inline_dentry)
 {
@@ -369,8 +373,10 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 	int err;
 
 	page = grab_cache_page(dir->i_mapping, 0);
-	if (!page)
+	if (!page) {
+		f2fs_put_page(ipage, 1);
 		return -ENOMEM;
+	}
 
 	set_new_dnode(&dn, dir, ipage, NULL, 0);
 	err = f2fs_reserve_block(&dn, 0);
@@ -434,8 +440,9 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 						slots, NR_INLINE_DENTRY);
 	if (bit_pos >= NR_INLINE_DENTRY) {
 		err = f2fs_convert_inline_dir(dir, ipage, dentry_blk);
-		if (!err)
-			err = -EAGAIN;
+		if (err)
+			return err;
+		err = -EAGAIN;
 		goto out;
 	}
 
-- 
2.4.2
