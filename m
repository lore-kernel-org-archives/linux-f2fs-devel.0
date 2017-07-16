From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs-tools: spread struct f2fs_dentry_ptr
 for inline path
Date: Sun, 16 Jul 2017 15:12:49 +0800
Message-ID: <20170716071251.25793-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dWdlk-00019L-NN
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jul 2017 07:15:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dWdlj-0007xC-Ne
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jul 2017 07:15:08 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Use f2fs_dentry_ptr structure to indicate inline dentry structure as
much as possible, so we can wrap inline dentry with size-fixed fields
to the one with size-changeable fields. With this change, we can
handle size-changeable inline dentry more easily.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dir.c  | 25 +++++++++++++------------
 fsck/f2fs.h |  1 +
 fsck/fsck.c | 15 ++++++++-------
 fsck/fsck.h |  1 +
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 57b7f9b..62bc7b9 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -34,17 +34,19 @@ next:
 
 }
 
-static void make_dentry_ptr(struct f2fs_dentry_ptr *d, void *src, int type)
+void make_dentry_ptr(struct f2fs_dentry_ptr *d, void *src, int type)
 {
 	if (type == 1) {
 		struct f2fs_dentry_block *t = (struct f2fs_dentry_block *)src;
 		d->max = NR_DENTRY_IN_BLOCK;
+		d->nr_bitmap = SIZE_OF_DENTRY_BITMAP;
 		d->bitmap = t->dentry_bitmap;
 		d->dentry = t->dentry;
 		d->filename = t->filename;
 	} else {
 		struct f2fs_inline_dentry *t = (struct f2fs_inline_dentry *)src;
 		d->max = NR_INLINE_DENTRY;
+		d->nr_bitmap = INLINE_DENTRY_BITMAP_SIZE;
 		d->bitmap = t->dentry_bitmap;
 		d->dentry = t->dentry;
 		d->filename = t->filename;
@@ -459,8 +461,8 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
 	ASSERT(ret >= 0);
 
 	if (!dir_level) {
-		struct f2fs_inline_dentry *inline_dentry;
 		struct f2fs_dentry_block *dentry_blk;
+		struct f2fs_dentry_ptr src, dst;
 
 		dentry_blk = calloc(BLOCK_SZ, 1);
 		ASSERT(dentry_blk);
@@ -470,17 +472,16 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
 		if (dn.data_blkaddr == NULL_ADDR)
 			new_data_block(sbi, dentry_blk, &dn, CURSEG_HOT_DATA);
 
-		inline_dentry = (struct f2fs_inline_dentry *)inline_data;
+		make_dentry_ptr(&src, (void *)inline_data, 2);
+		make_dentry_ptr(&dst, (void *)dentry_blk, 1);
+
 		 /* copy data from inline dentry block to new dentry block */
-		memcpy(dentry_blk->dentry_bitmap, inline_dentry->dentry_bitmap,
-				INLINE_DENTRY_BITMAP_SIZE);
-		memset(dentry_blk->dentry_bitmap + INLINE_DENTRY_BITMAP_SIZE, 0,
-			SIZE_OF_DENTRY_BITMAP - INLINE_DENTRY_BITMAP_SIZE);
-
-		memcpy(dentry_blk->dentry, inline_dentry->dentry,
-			sizeof(struct f2fs_dir_entry) * NR_INLINE_DENTRY);
-		memcpy(dentry_blk->filename, inline_dentry->filename,
-				NR_INLINE_DENTRY * F2FS_SLOT_LEN);
+		memcpy(dst.bitmap, src.bitmap, src.nr_bitmap);
+		memset(dst.bitmap + src.nr_bitmap, 0,
+					dst.nr_bitmap - src.nr_bitmap);
+
+		memcpy(dst.dentry, src.dentry, SIZE_OF_DIR_ENTRY * src.max);
+		memcpy(dst.filename, src.filename, src.max * F2FS_SLOT_LEN);
 
 		ret = dev_write_block(dentry_blk, dn.data_blkaddr);
 		ASSERT(ret >= 0);
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index efc43f6..d1626e3 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -129,6 +129,7 @@ struct f2fs_dentry_ptr {
 	struct f2fs_dir_entry *dentry;
 	__u8 (*filename)[F2FS_SLOT_LEN];
 	int max;
+	int nr_bitmap;
 };
 
 struct dentry {
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 56336ad..84196cf 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1355,17 +1355,18 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 		struct f2fs_node *node_blk, struct child_info *child)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	struct f2fs_inline_dentry *de_blk;
+	struct f2fs_dentry_ptr d;
+	void *inline_dentry;
 	int dentries;
 
-	de_blk = inline_data_addr(node_blk);
-	ASSERT(de_blk != NULL);
+	inline_dentry = inline_data_addr(node_blk);
+	ASSERT(inline_dentry != NULL);
+
+	make_dentry_ptr(&d, inline_dentry, 2);
 
 	fsck->dentry_depth++;
 	dentries = __chk_dentries(sbi, child,
-			de_blk->dentry_bitmap,
-			de_blk->dentry, de_blk->filename,
-			NR_INLINE_DENTRY, 1,
+			d.bitmap, d.dentry, d.filename, d.max, 1,
 			file_enc_name(&node_blk->i));
 	if (dentries < 0) {
 		DBG(1, "[%3d] Inline Dentry Block Fixed hash_codes\n\n",
@@ -1374,7 +1375,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 		DBG(1, "[%3d] Inline Dentry Block Done : "
 				"dentries:%d in %d slots (len:%d)\n\n",
 			fsck->dentry_depth, dentries,
-			(int)NR_INLINE_DENTRY, F2FS_NAME_LEN);
+			d.max, F2FS_NAME_LEN);
 	}
 	fsck->dentry_depth--;
 	return dentries;
diff --git a/fsck/fsck.h b/fsck/fsck.h
index c54eccb..5d2cfd6 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -221,6 +221,7 @@ block_t new_node_block(struct f2fs_sb_info *,
 					struct dnode_of_data *, unsigned int);
 void get_dnode_of_data(struct f2fs_sb_info *, struct dnode_of_data *,
 					pgoff_t, int);
+void make_dentry_ptr(struct f2fs_dentry_ptr *, void *, int);
 int f2fs_create(struct f2fs_sb_info *, struct dentry *);
 int f2fs_mkdir(struct f2fs_sb_info *, struct dentry *);
 int f2fs_symlink(struct f2fs_sb_info *, struct dentry *);
-- 
2.13.0.90.g1eb437020


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
