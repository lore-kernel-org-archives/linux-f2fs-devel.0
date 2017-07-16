From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/6] f2fs: spread struct f2fs_dentry_ptr for
 inline path
Date: Sun, 16 Jul 2017 15:08:54 +0800
Message-ID: <20170716070859.25246-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dWdhw-0000zF-Ij
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jul 2017 07:11:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dWdhv-0006ld-4C
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jul 2017 07:11:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Use f2fs_dentry_ptr structure to indicate inline dentry structure as
much as possible, so we can wrap inline dentry with size-fixed fields
to the one with size-changeable fields. With this change, we can
handle size-changeable inline dentry more easily.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h   |  5 ++++-
 fs/f2fs/inline.c | 47 ++++++++++++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 42c39f0bfd88..23f117e4aeb8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -361,10 +361,11 @@ struct f2fs_flush_device {
 /* for directory operations */
 struct f2fs_dentry_ptr {
 	struct inode *inode;
-	const void *bitmap;
+	void *bitmap;
 	struct f2fs_dir_entry *dentry;
 	__u8 (*filename)[F2FS_SLOT_LEN];
 	int max;
+	int nr_bitmap;
 };
 
 static inline void make_dentry_ptr_block(struct inode *inode,
@@ -372,6 +373,7 @@ static inline void make_dentry_ptr_block(struct inode *inode,
 {
 	d->inode = inode;
 	d->max = NR_DENTRY_IN_BLOCK;
+	d->nr_bitmap = SIZE_OF_DENTRY_BITMAP;
 	d->bitmap = &t->dentry_bitmap;
 	d->dentry = t->dentry;
 	d->filename = t->filename;
@@ -382,6 +384,7 @@ static inline void make_dentry_ptr_inline(struct inode *inode,
 {
 	d->inode = inode;
 	d->max = NR_INLINE_DENTRY;
+	d->nr_bitmap = INLINE_DENTRY_BITMAP_SIZE;
 	d->bitmap = &t->dentry_bitmap;
 	d->dentry = t->dentry;
 	d->filename = t->filename;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e0fd4376e6fb..2082816a504a 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -342,6 +342,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	struct page *page;
 	struct dnode_of_data dn;
 	struct f2fs_dentry_block *dentry_blk;
+	struct f2fs_dentry_ptr src, dst;
 	int err;
 
 	page = f2fs_grab_cache_page(dir->i_mapping, 0, false);
@@ -360,21 +361,20 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 
 	dentry_blk = kmap_atomic(page);
 
+	make_dentry_ptr_inline(NULL, &src, inline_dentry);
+	make_dentry_ptr_block(NULL, &dst, dentry_blk);
+
 	/* copy data from inline dentry block to new dentry block */
-	memcpy(dentry_blk->dentry_bitmap, inline_dentry->dentry_bitmap,
-					INLINE_DENTRY_BITMAP_SIZE);
-	memset(dentry_blk->dentry_bitmap + INLINE_DENTRY_BITMAP_SIZE, 0,
-			SIZE_OF_DENTRY_BITMAP - INLINE_DENTRY_BITMAP_SIZE);
+	memcpy(dst.bitmap, src.bitmap, src.nr_bitmap);
+	memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap - src.nr_bitmap);
 	/*
 	 * we do not need to zero out remainder part of dentry and filename
 	 * field, since we have used bitmap for marking the usage status of
 	 * them, besides, we can also ignore copying/zeroing reserved space
 	 * of dentry block, because them haven't been used so far.
 	 */
-	memcpy(dentry_blk->dentry, inline_dentry->dentry,
-			sizeof(struct f2fs_dir_entry) * NR_INLINE_DENTRY);
-	memcpy(dentry_blk->filename, inline_dentry->filename,
-					NR_INLINE_DENTRY * F2FS_SLOT_LEN);
+	memcpy(dst.dentry, src.dentry, SIZE_OF_DIR_ENTRY * src.max);
+	memcpy(dst.filename, src.filename, src.max * F2FS_SLOT_LEN);
 
 	kunmap_atomic(dentry_blk);
 	if (!PageUptodate(page))
@@ -511,9 +511,10 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 		return PTR_ERR(ipage);
 
 	inline_dentry = inline_data_addr(ipage);
-	bit_pos = room_for_filename(&inline_dentry->dentry_bitmap,
-						slots, NR_INLINE_DENTRY);
-	if (bit_pos >= NR_INLINE_DENTRY) {
+	make_dentry_ptr_inline(NULL, &d, inline_dentry);
+
+	bit_pos = room_for_filename(d.bitmap, slots, d.max);
+	if (bit_pos >= d.max) {
 		err = f2fs_convert_inline_dir(dir, ipage, inline_dentry);
 		if (err)
 			return err;
@@ -534,7 +535,6 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 	f2fs_wait_on_page_writeback(ipage, NODE, true);
 
 	name_hash = f2fs_dentry_hash(new_name, NULL);
-	make_dentry_ptr_inline(NULL, &d, inline_dentry);
 	f2fs_update_dentry(ino, mode, &d, new_name, name_hash, bit_pos);
 
 	set_page_dirty(ipage);
@@ -558,6 +558,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 					struct inode *dir, struct inode *inode)
 {
 	struct f2fs_inline_dentry *inline_dentry;
+	struct f2fs_dentry_ptr d;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
 	unsigned int bit_pos;
 	int i;
@@ -566,10 +567,11 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_wait_on_page_writeback(page, NODE, true);
 
 	inline_dentry = inline_data_addr(page);
-	bit_pos = dentry - inline_dentry->dentry;
+	make_dentry_ptr_inline(NULL, &d, inline_dentry);
+
+	bit_pos = dentry - d.dentry;
 	for (i = 0; i < slots; i++)
-		__clear_bit_le(bit_pos + i,
-				&inline_dentry->dentry_bitmap);
+		__clear_bit_le(bit_pos + i, d.bitmap);
 
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
@@ -587,19 +589,20 @@ bool f2fs_empty_inline_dir(struct inode *dir)
 	struct page *ipage;
 	unsigned int bit_pos = 2;
 	struct f2fs_inline_dentry *inline_dentry;
+	struct f2fs_dentry_ptr d;
 
 	ipage = get_node_page(sbi, dir->i_ino);
 	if (IS_ERR(ipage))
 		return false;
 
 	inline_dentry = inline_data_addr(ipage);
-	bit_pos = find_next_bit_le(&inline_dentry->dentry_bitmap,
-					NR_INLINE_DENTRY,
-					bit_pos);
+	make_dentry_ptr_inline(NULL, &d, inline_dentry);
+
+	bit_pos = find_next_bit_le(d.bitmap, d.max, bit_pos);
 
 	f2fs_put_page(ipage, 1);
 
-	if (bit_pos < NR_INLINE_DENTRY)
+	if (bit_pos < d.max)
 		return false;
 
 	return true;
@@ -614,7 +617,9 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	struct f2fs_dentry_ptr d;
 	int err;
 
-	if (ctx->pos == NR_INLINE_DENTRY)
+	make_dentry_ptr_inline(inode, &d, inline_dentry);
+
+	if (ctx->pos == d.max)
 		return 0;
 
 	ipage = get_node_page(F2FS_I_SB(inode), inode->i_ino);
@@ -627,7 +632,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 
 	err = f2fs_fill_dentries(ctx, &d, 0, fstr);
 	if (!err)
-		ctx->pos = NR_INLINE_DENTRY;
+		ctx->pos = d.max;
 
 	f2fs_put_page(ipage, 1);
 	return err < 0 ? err : 0;
-- 
2.13.0.90.g1eb437020


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
