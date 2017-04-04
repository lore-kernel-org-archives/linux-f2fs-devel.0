From: kusumi.tomohiro@gmail.com
Subject: [PATCH] f2fs: split make_dentry_ptr() into block and
	inline versions
Date: Tue,  4 Apr 2017 13:01:22 +0300
Message-ID: <20170404100122.8890-1-tkusumi@tuxera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kusumi.tomohiro@gmail.com>) id 1cvLHe-0001Em-7n
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Apr 2017 10:01:54 +0000
Received: from mail-lf0-f68.google.com ([209.85.215.68])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cvLHc-0003Jl-By
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Apr 2017 10:01:54 +0000
Received: by mail-lf0-f68.google.com with SMTP id r36so15118710lfi.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 04 Apr 2017 03:01:52 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Since callers statically know which type to use, make_dentry_ptr()
can simply be splitted into two inline functions. This way, the code
has less inlined, fewer arguments, and no cast.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 fs/f2fs/dir.c    |  8 ++++----
 fs/f2fs/f2fs.h   | 32 +++++++++++++++-----------------
 fs/f2fs/inline.c | 10 +++++-----
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8d5c62b..33c858a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -94,7 +94,7 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 
 	dentry_blk = (struct f2fs_dentry_block *)kmap(dentry_page);
 
-	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
+	make_dentry_ptr_block(NULL, &d, dentry_blk);
 	de = find_target_dentry(fname, namehash, max_slots, &d);
 	if (de)
 		*res_page = dentry_page;
@@ -384,7 +384,7 @@ static int make_empty_dir(struct inode *inode,
 
 	dentry_blk = kmap_atomic(dentry_page);
 
-	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
+	make_dentry_ptr_block(NULL, &d, dentry_blk);
 	do_make_empty_dir(inode, parent, &d);
 
 	kunmap_atomic(dentry_blk);
@@ -603,7 +603,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 			file_set_enc_name(inode);
 	}
 
-	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
+	make_dentry_ptr_block(NULL, &d, dentry_blk);
 	f2fs_update_dentry(ino, mode, &d, new_name, dentry_hash, bit_pos);
 
 	set_page_dirty(dentry_page);
@@ -911,7 +911,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 
 		dentry_blk = kmap(dentry_page);
 
-		make_dentry_ptr(inode, &d, (void *)dentry_blk, 1);
+		make_dentry_ptr_block(inode, &d, dentry_blk);
 
 		err = f2fs_fill_dentries(ctx, &d,
 				n * NR_DENTRY_IN_BLOCK, &fstr);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0a6e115..0d57fd3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -323,26 +323,24 @@ struct f2fs_dentry_ptr {
 	int max;
 };
 
-static inline void make_dentry_ptr(struct inode *inode,
-		struct f2fs_dentry_ptr *d, void *src, int type)
+static inline void make_dentry_ptr_block(struct inode *inode,
+		struct f2fs_dentry_ptr *d, struct f2fs_dentry_block *t)
 {
 	d->inode = inode;
+	d->max = NR_DENTRY_IN_BLOCK;
+	d->bitmap = &t->dentry_bitmap;
+	d->dentry = t->dentry;
+	d->filename = t->filename;
+}
 
-	if (type == 1) {
-		struct f2fs_dentry_block *t = (struct f2fs_dentry_block *)src;
-
-		d->max = NR_DENTRY_IN_BLOCK;
-		d->bitmap = &t->dentry_bitmap;
-		d->dentry = t->dentry;
-		d->filename = t->filename;
-	} else {
-		struct f2fs_inline_dentry *t = (struct f2fs_inline_dentry *)src;
-
-		d->max = NR_INLINE_DENTRY;
-		d->bitmap = &t->dentry_bitmap;
-		d->dentry = t->dentry;
-		d->filename = t->filename;
-	}
+static inline void make_dentry_ptr_inline(struct inode *inode,
+		struct f2fs_dentry_ptr *d, struct f2fs_inline_dentry *t)
+{
+	d->inode = inode;
+	d->max = NR_INLINE_DENTRY;
+	d->bitmap = &t->dentry_bitmap;
+	d->dentry = t->dentry;
+	d->filename = t->filename;
 }
 
 /*
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e32a9e5..f77a21c 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -300,7 +300,7 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
 
 	inline_dentry = inline_data_addr(ipage);
 
-	make_dentry_ptr(NULL, &d, (void *)inline_dentry, 2);
+	make_dentry_ptr_inline(NULL, &d, inline_dentry);
 	de = find_target_dentry(fname, namehash, NULL, &d);
 	unlock_page(ipage);
 	if (de)
@@ -319,7 +319,7 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 
 	dentry_blk = inline_data_addr(ipage);
 
-	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 2);
+	make_dentry_ptr_inline(NULL, &d, dentry_blk);
 	do_make_empty_dir(inode, parent, &d);
 
 	set_page_dirty(ipage);
@@ -400,7 +400,7 @@ static int f2fs_add_inline_entries(struct inode *dir,
 	unsigned long bit_pos = 0;
 	int err = 0;
 
-	make_dentry_ptr(NULL, &d, (void *)inline_dentry, 2);
+	make_dentry_ptr_inline(NULL, &d, inline_dentry);
 
 	while (bit_pos < d.max) {
 		struct f2fs_dir_entry *de;
@@ -534,7 +534,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 	f2fs_wait_on_page_writeback(ipage, NODE, true);
 
 	name_hash = f2fs_dentry_hash(new_name);
-	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 2);
+	make_dentry_ptr_inline(NULL, &d, dentry_blk);
 	f2fs_update_dentry(ino, mode, &d, new_name, name_hash, bit_pos);
 
 	set_page_dirty(ipage);
@@ -623,7 +623,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 
 	inline_dentry = inline_data_addr(ipage);
 
-	make_dentry_ptr(inode, &d, (void *)inline_dentry, 2);
+	make_dentry_ptr_inline(inode, &d, inline_dentry);
 
 	err = f2fs_fill_dentries(ctx, &d, 0, fstr);
 	if (!err)
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
