From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2] f2fs: fix to release inode page in get_new_data_page
Date: Tue, 14 Jul 2015 18:14:06 +0800
Message-ID: <00f501d0be1d$e89f08d0$b9dd1a70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

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

Here we deside to choose a easy way to fix this issue:
If any error occur in get_new_data_page, we will ensure releasing
ipage in this function.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 * add comments in commit log and codes suggested by Jaegeuk.

 fs/f2fs/data.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 387d710..ddfc083 100644
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
-- 
2.4.2
