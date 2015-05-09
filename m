From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 13/18] f2fs crypto: add filename encryption for
	f2fs_readdir
Date: Fri,  8 May 2015 21:20:48 -0700
Message-ID: <1431145253-2019-13-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGn-0003x4-DK
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGm-0007in-57 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:45 +0000
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch implements filename encryption support for f2fs_readdir.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c    | 57 ++++++++++++++++++++++++++++++++++++++++++++------------
 fs/f2fs/f2fs.h   | 12 ++++++++----
 fs/f2fs/inline.c | 13 +++++++------
 3 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 750a688..ab6455d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -98,7 +98,7 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 
 	dentry_blk = (struct f2fs_dentry_block *)kmap(dentry_page);
 
-	make_dentry_ptr(&d, (void *)dentry_blk, 1);
+	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
 	de = find_target_dentry(name, max_slots, &d);
 
 	if (de)
@@ -356,7 +356,7 @@ static int make_empty_dir(struct inode *inode,
 
 	dentry_blk = kmap_atomic(dentry_page);
 
-	make_dentry_ptr(&d, (void *)dentry_blk, 1);
+	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
 	do_make_empty_dir(inode, parent, &d);
 
 	kunmap_atomic(dentry_blk);
@@ -588,7 +588,7 @@ add_dentry:
 		}
 	}
 
-	make_dentry_ptr(&d, (void *)dentry_blk, 1);
+	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
 	f2fs_update_dentry(ino, mode, &d, &new_name, dentry_hash, bit_pos);
 
 	set_page_dirty(dentry_page);
@@ -750,11 +750,12 @@ bool f2fs_empty_dir(struct inode *dir)
 }
 
 bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
-						unsigned int start_pos)
+				unsigned int start_pos, struct f2fs_str *fstr)
 {
 	unsigned char d_type = DT_UNKNOWN;
 	unsigned int bit_pos;
 	struct f2fs_dir_entry *de = NULL;
+	struct f2fs_str de_name = FSTR_INIT(NULL, 0);
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
 
@@ -768,8 +769,24 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			d_type = f2fs_filetype_table[de->file_type];
 		else
 			d_type = DT_UNKNOWN;
-		if (!dir_emit(ctx, d->filename[bit_pos],
-					le16_to_cpu(de->name_len),
+
+		/* encrypted case */
+		de_name.name = d->filename[bit_pos];
+		de_name.len = le16_to_cpu(de->name_len);
+
+		if (f2fs_encrypted_inode(d->inode)) {
+			int save_len = fstr->len;
+			int ret;
+
+			ret = f2fs_fname_disk_to_usr(d->inode, &de->hash_code,
+							&de_name, fstr);
+			de_name = *fstr;
+			fstr->len = save_len;
+			if (ret < 0)
+				return true;
+		}
+
+		if (!dir_emit(ctx, de_name.name, de_name.len,
 					le32_to_cpu(de->ino), d_type))
 			return true;
 
@@ -788,9 +805,24 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	struct file_ra_state *ra = &file->f_ra;
 	unsigned int n = ((unsigned long)ctx->pos / NR_DENTRY_IN_BLOCK);
 	struct f2fs_dentry_ptr d;
+	struct f2fs_str fstr = FSTR_INIT(NULL, 0);
+	int err = 0;
 
-	if (f2fs_has_inline_dentry(inode))
-		return f2fs_read_inline_dir(file, ctx);
+	err = f2fs_setup_fname_crypto(inode);
+	if (err)
+		return err;
+
+	if (f2fs_encrypted_inode(inode)) {
+		err = f2fs_fname_crypto_alloc_buffer(inode, F2FS_NAME_LEN,
+								&fstr);
+		if (err < 0)
+			return err;
+	}
+
+	if (f2fs_has_inline_dentry(inode)) {
+		err = f2fs_read_inline_dir(file, ctx, &fstr);
+		goto out;
+	}
 
 	/* readahead for multi pages of dir */
 	if (npages - n > 1 && !ra_has_index(ra, n))
@@ -804,9 +836,9 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 
 		dentry_blk = kmap(dentry_page);
 
-		make_dentry_ptr(&d, (void *)dentry_blk, 1);
+		make_dentry_ptr(inode, &d, (void *)dentry_blk, 1);
 
-		if (f2fs_fill_dentries(ctx, &d, n * NR_DENTRY_IN_BLOCK))
+		if (f2fs_fill_dentries(ctx, &d, n * NR_DENTRY_IN_BLOCK, &fstr))
 			goto stop;
 
 		ctx->pos = (n + 1) * NR_DENTRY_IN_BLOCK;
@@ -819,8 +851,9 @@ stop:
 		kunmap(dentry_page);
 		f2fs_put_page(dentry_page, 1);
 	}
-
-	return 0;
+out:
+	f2fs_fname_crypto_free_buffer(&fstr);
+	return err;
 }
 
 const struct file_operations f2fs_dir_operations = {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1632151..963616f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -277,15 +277,18 @@ struct f2fs_filename {
 #define fname_len(p)		((p)->disk_name.len)
 
 struct f2fs_dentry_ptr {
+	struct inode *inode;
 	const void *bitmap;
 	struct f2fs_dir_entry *dentry;
 	__u8 (*filename)[F2FS_SLOT_LEN];
 	int max;
 };
 
-static inline void make_dentry_ptr(struct f2fs_dentry_ptr *d,
-					void *src, int type)
+static inline void make_dentry_ptr(struct inode *inode,
+		struct f2fs_dentry_ptr *d, void *src, int type)
 {
+	d->inode = inode;
+
 	if (type == 1) {
 		struct f2fs_dentry_block *t = (struct f2fs_dentry_block *)src;
 		d->max = NR_DENTRY_IN_BLOCK;
@@ -1584,7 +1587,7 @@ void set_de_type(struct f2fs_dir_entry *, umode_t);
 struct f2fs_dir_entry *find_target_dentry(struct qstr *, int *,
 			struct f2fs_dentry_ptr *);
 bool f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
-			unsigned int);
+			unsigned int, struct f2fs_str *);
 void do_make_empty_dir(struct inode *, struct inode *,
 			struct f2fs_dentry_ptr *);
 struct page *init_inode_metadata(struct inode *, struct inode *,
@@ -1937,7 +1940,8 @@ int f2fs_add_inline_entry(struct inode *, const struct qstr *, struct inode *,
 void f2fs_delete_inline_entry(struct f2fs_dir_entry *, struct page *,
 						struct inode *, struct inode *);
 bool f2fs_empty_inline_dir(struct inode *);
-int f2fs_read_inline_dir(struct file *, struct dir_context *);
+int f2fs_read_inline_dir(struct file *, struct dir_context *,
+						struct f2fs_str *);
 
 /*
  * crypto support
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index b0b7805..dd51d3f 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -298,7 +298,7 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
 
 	inline_dentry = inline_data_addr(ipage);
 
-	make_dentry_ptr(&d, (void *)inline_dentry, 2);
+	make_dentry_ptr(NULL, &d, (void *)inline_dentry, 2);
 	de = find_target_dentry(name, NULL, &d);
 
 	unlock_page(ipage);
@@ -342,7 +342,7 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 
 	dentry_blk = inline_data_addr(ipage);
 
-	make_dentry_ptr(&d, (void *)dentry_blk, 2);
+	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 2);
 	do_make_empty_dir(inode, parent, &d);
 
 	set_page_dirty(ipage);
@@ -446,7 +446,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 	f2fs_wait_on_page_writeback(ipage, NODE);
 
 	name_hash = f2fs_dentry_hash(name);
-	make_dentry_ptr(&d, (void *)dentry_blk, 2);
+	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 2);
 	f2fs_update_dentry(ino, mode, &d, name, name_hash, bit_pos);
 
 	set_page_dirty(ipage);
@@ -523,7 +523,8 @@ bool f2fs_empty_inline_dir(struct inode *dir)
 	return true;
 }
 
-int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx)
+int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
+				struct f2fs_str *fstr)
 {
 	struct inode *inode = file_inode(file);
 	struct f2fs_inline_dentry *inline_dentry = NULL;
@@ -539,9 +540,9 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx)
 
 	inline_dentry = inline_data_addr(ipage);
 
-	make_dentry_ptr(&d, (void *)inline_dentry, 2);
+	make_dentry_ptr(inode, &d, (void *)inline_dentry, 2);
 
-	if (!f2fs_fill_dentries(ctx, &d, 0))
+	if (!f2fs_fill_dentries(ctx, &d, 0, fstr))
 		ctx->pos = NR_INLINE_DENTRY;
 
 	f2fs_put_page(ipage, 1);
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
