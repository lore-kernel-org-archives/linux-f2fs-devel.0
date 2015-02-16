From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/4] f2fs: introduce f2fs_update_dentry to clean up duplicated
 codes
Date: Mon, 16 Feb 2015 16:17:20 +0800
Message-ID: <006501d049c1$1f5ae230$5e10a690$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces f2fs_update_dentry to remove redundant code in
f2fs_add_inline_entry and __f2fs_add_link.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c    | 33 +++++++++++++++++++++++----------
 fs/f2fs/f2fs.h   |  2 ++
 fs/f2fs/inline.c | 18 ++++++------------
 3 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index b74097a..583896c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -474,6 +474,24 @@ next:
 	goto next;
 }
 
+void f2fs_update_dentry(struct inode *inode, struct f2fs_dentry_ptr *d,
+				const struct qstr *name, f2fs_hash_t name_hash,
+				unsigned int bit_pos)
+{
+	struct f2fs_dir_entry *de;
+	int slots = GET_DENTRY_SLOTS(name->len);
+	int i;
+
+	de = &d->dentry[bit_pos];
+	de->hash_code = name_hash;
+	de->name_len = cpu_to_le16(name->len);
+	memcpy(d->filename[bit_pos], name->name, name->len);
+	de->ino = cpu_to_le32(inode->i_ino);
+	set_de_type(de, inode);
+	for (i = 0; i < slots; i++)
+		test_and_set_bit_le(bit_pos + i, (void *)d->bitmap);
+}
+
 /*
  * Caller should grab and release a rwsem by calling f2fs_lock_op() and
  * f2fs_unlock_op().
@@ -486,15 +504,14 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 	unsigned int current_depth;
 	unsigned long bidx, block;
 	f2fs_hash_t dentry_hash;
-	struct f2fs_dir_entry *de;
 	unsigned int nbucket, nblock;
 	size_t namelen = name->len;
 	struct page *dentry_page = NULL;
 	struct f2fs_dentry_block *dentry_blk = NULL;
+	struct f2fs_dentry_ptr d;
 	int slots = GET_DENTRY_SLOTS(namelen);
 	struct page *page;
 	int err = 0;
-	int i;
 
 	if (f2fs_has_inline_dentry(dir)) {
 		err = f2fs_add_inline_entry(dir, name, inode);
@@ -553,14 +570,10 @@ add_dentry:
 		err = PTR_ERR(page);
 		goto fail;
 	}
-	de = &dentry_blk->dentry[bit_pos];
-	de->hash_code = dentry_hash;
-	de->name_len = cpu_to_le16(namelen);
-	memcpy(dentry_blk->filename[bit_pos], name->name, name->len);
-	de->ino = cpu_to_le32(inode->i_ino);
-	set_de_type(de, inode);
-	for (i = 0; i < slots; i++)
-		test_and_set_bit_le(bit_pos + i, &dentry_blk->dentry_bitmap);
+
+	make_dentry_ptr(&d, (void *)dentry_blk, 1);
+	f2fs_update_dentry(inode, &d, name, dentry_hash, bit_pos);
+
 	set_page_dirty(dentry_page);
 
 	/* we don't need to mark_inode_dirty now */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a978b65..f8da399 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1376,6 +1376,8 @@ ino_t f2fs_inode_by_name(struct inode *, struct qstr *);
 void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
 				struct page *, struct inode *);
 int update_dent_inode(struct inode *, const struct qstr *);
+void f2fs_update_dentry(struct inode *, struct f2fs_dentry_ptr *,
+			const struct qstr *, f2fs_hash_t , unsigned int);
 int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *);
 void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *,
 							struct inode *);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 1484c00..82b7441 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -386,15 +386,12 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 	struct page *ipage;
 	unsigned int bit_pos;
 	f2fs_hash_t name_hash;
-	struct f2fs_dir_entry *de;
 	size_t namelen = name->len;
 	struct f2fs_inline_dentry *dentry_blk = NULL;
+	struct f2fs_dentry_ptr d;
 	int slots = GET_DENTRY_SLOTS(namelen);
 	struct page *page;
 	int err = 0;
-	int i;
-
-	name_hash = f2fs_dentry_hash(name);
 
 	ipage = get_node_page(sbi, dir->i_ino);
 	if (IS_ERR(ipage))
@@ -418,14 +415,11 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 	}
 
 	f2fs_wait_on_page_writeback(ipage, NODE);
-	de = &dentry_blk->dentry[bit_pos];
-	de->hash_code = name_hash;
-	de->name_len = cpu_to_le16(namelen);
-	memcpy(dentry_blk->filename[bit_pos], name->name, name->len);
-	de->ino = cpu_to_le32(inode->i_ino);
-	set_de_type(de, inode);
-	for (i = 0; i < slots; i++)
-		test_and_set_bit_le(bit_pos + i, &dentry_blk->dentry_bitmap);
+
+	name_hash = f2fs_dentry_hash(name);
+	make_dentry_ptr(&d, (void *)dentry_blk, 2);
+	f2fs_update_dentry(inode, &d, name, name_hash, bit_pos);
+
 	set_page_dirty(ipage);
 
 	/* we don't need to mark_inode_dirty now */
-- 
2.2.1
