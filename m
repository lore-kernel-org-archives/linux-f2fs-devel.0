From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: callers take care of the page from bio error
Date: Wed, 15 Jul 2015 15:38:10 -0700
Message-ID: <1436999892-86682-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch changes for a caller to handle the page after its bio gets an error.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 +++-
 fs/f2fs/data.c       | 27 +++++++++++++--------------
 fs/f2fs/node.c       | 21 ++++++++++-----------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6032702..6fb696d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -69,8 +69,10 @@ repeat:
 
 	fio.page = page;
 
-	if (f2fs_submit_page_bio(&fio))
+	if (f2fs_submit_page_bio(&fio)) {
+		f2fs_put_page(page, 1);
 		goto repeat;
+	}
 
 	lock_page(page);
 	if (unlikely(page->mapping != mapping)) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 57042bd..b621c08 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -156,7 +156,6 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 
 	if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
 		bio_put(bio);
-		f2fs_put_page(page, 1);
 		return -EFAULT;
 	}
 
@@ -292,15 +291,13 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index, int rw)
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
-	if (err) {
-		f2fs_put_page(page, 1);
-		return ERR_PTR(err);
-	}
+	if (err)
+		goto put_err;
 	f2fs_put_dnode(&dn);
 
 	if (unlikely(dn.data_blkaddr == NULL_ADDR)) {
-		f2fs_put_page(page, 1);
-		return ERR_PTR(-ENOENT);
+		err = -ENOENT;
+		goto put_err;
 	}
 got_it:
 	if (PageUptodate(page)) {
@@ -325,8 +322,12 @@ got_it:
 	fio.page = page;
 	err = f2fs_submit_page_bio(&fio);
 	if (err)
-		return ERR_PTR(err);
+		goto put_err;
 	return page;
+
+put_err:
+	f2fs_put_page(page, 1);
+	return ERR_PTR(err);
 }
 
 struct page *find_data_page(struct inode *inode, pgoff_t index)
@@ -1329,7 +1330,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct page *page, *ipage;
+	struct page *page = NULL;
+	struct page *ipage;
 	pgoff_t index = ((unsigned long long) pos) >> PAGE_CACHE_SHIFT;
 	struct dnode_of_data dn;
 	int err = 0;
@@ -1419,7 +1421,6 @@ put_next:
 
 		lock_page(page);
 		if (unlikely(!PageUptodate(page))) {
-			f2fs_put_page(page, 1);
 			err = -EIO;
 			goto fail;
 		}
@@ -1431,10 +1432,8 @@ put_next:
 		/* avoid symlink page */
 		if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
 			err = f2fs_decrypt_one(inode, page);
-			if (err) {
-				f2fs_put_page(page, 1);
+			if (err)
 				goto fail;
-			}
 		}
 	}
 out_update:
@@ -1447,8 +1446,8 @@ put_fail:
 	f2fs_put_dnode(&dn);
 unlock_fail:
 	f2fs_unlock_op(sbi);
-	f2fs_put_page(page, 1);
 fail:
+	f2fs_put_page(page, 1);
 	f2fs_write_failed(mapping, pos + len);
 	return err;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a05eb35..7dd2b9d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -991,8 +991,7 @@ fail:
 /*
  * Caller should do after getting the following values.
  * 0: f2fs_put_page(page, 0)
- * LOCKED_PAGE: f2fs_put_page(page, 1)
- * error: nothing
+ * LOCKED_PAGE or error: f2fs_put_page(page, 1)
  */
 static int read_node_page(struct page *page, int rw)
 {
@@ -1010,7 +1009,6 @@ static int read_node_page(struct page *page, int rw)
 
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
 		ClearPageUptodate(page);
-		f2fs_put_page(page, 1);
 		return -ENOENT;
 	}
 
@@ -1041,10 +1039,7 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 		return;
 
 	err = read_node_page(apage, READA);
-	if (err == 0)
-		f2fs_put_page(apage, 0);
-	else if (err == LOCKED_PAGE)
-		f2fs_put_page(apage, 1);
+	f2fs_put_page(apage, err ? 1 : 0);
 }
 
 struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
@@ -1057,10 +1052,12 @@ repeat:
 		return ERR_PTR(-ENOMEM);
 
 	err = read_node_page(page, READ_SYNC);
-	if (err < 0)
+	if (err < 0) {
+		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
-	else if (err != LOCKED_PAGE)
+	} else if (err != LOCKED_PAGE) {
 		lock_page(page);
+	}
 
 	if (unlikely(!PageUptodate(page) || nid != nid_of_node(page))) {
 		ClearPageUptodate(page);
@@ -1096,10 +1093,12 @@ repeat:
 		return ERR_PTR(-ENOMEM);
 
 	err = read_node_page(page, READ_SYNC);
-	if (err < 0)
+	if (err < 0) {
+		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
-	else if (err == LOCKED_PAGE)
+	} else if (err == LOCKED_PAGE) {
 		goto page_hit;
+	}
 
 	blk_start_plug(&plug);
 
-- 
2.1.1
