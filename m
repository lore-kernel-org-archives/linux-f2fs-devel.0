From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: add F2FS_INLINE_DOTS to recover
	missing dot dentries
Date: Thu,  2 Apr 2015 10:49:22 -0700
Message-ID: <1427996965-10578-2-git-send-email-jaegeuk@kernel.org>
References: <1427996965-10578-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjFT-0002GW-Ky
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:49:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjFR-0002bO-UA for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:49:47 +0000
In-Reply-To: <1427996965-10578-1-git-send-email-jaegeuk@kernel.org>
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

If f2fs was corrupted with missing dot dentries, it needs to recover them after
fsck.f2fs detection.

The underlying precedure is:

1. The fsck.f2fs remains F2FS_INLINE_DOTS flag in directory inode, if it detects
missing dot dentries.

2. When f2fs looks up the corrupted directory, it triggers f2fs_add_link with
proper inode numbers and their dot and dotdot names.

3. Once f2fs recovers the directory without errors, it removes F2FS_INLINE_DOTS
finally.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c           | 50 ++++++++++++++++++++++++++-----------------------
 fs/f2fs/f2fs.h          | 22 +++++++++++++++++-----
 fs/f2fs/inline.c        | 27 +++++++++++++++-----------
 fs/f2fs/namei.c         | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/recovery.c      |  2 +-
 include/linux/f2fs_fs.h |  1 +
 6 files changed, 110 insertions(+), 40 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 4e59c82..b2970fb 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -59,9 +59,8 @@ static unsigned char f2fs_type_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFLNK >> S_SHIFT]	= F2FS_FT_SYMLINK,
 };
 
-void set_de_type(struct f2fs_dir_entry *de, struct inode *inode)
+void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
 {
-	umode_t mode = inode->i_mode;
 	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
 }
 
@@ -282,7 +281,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	lock_page(page);
 	f2fs_wait_on_page_writeback(page, type);
 	de->ino = cpu_to_le32(inode->i_ino);
-	set_de_type(de, inode);
+	set_de_type(de, inode->i_mode);
 	f2fs_dentry_kunmap(dir, page);
 	set_page_dirty(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
@@ -328,14 +327,14 @@ void do_make_empty_dir(struct inode *inode, struct inode *parent,
 	de->hash_code = 0;
 	de->ino = cpu_to_le32(inode->i_ino);
 	memcpy(d->filename[0], ".", 1);
-	set_de_type(de, inode);
+	set_de_type(de, inode->i_mode);
 
 	de = &d->dentry[1];
 	de->hash_code = 0;
 	de->name_len = cpu_to_le16(2);
 	de->ino = cpu_to_le32(parent->i_ino);
 	memcpy(d->filename[1], "..", 2);
-	set_de_type(de, inode);
+	set_de_type(de, inode->i_mode);
 
 	test_and_set_bit_le(0, (void *)d->bitmap);
 	test_and_set_bit_le(1, (void *)d->bitmap);
@@ -432,7 +431,7 @@ error:
 void update_parent_metadata(struct inode *dir, struct inode *inode,
 						unsigned int current_depth)
 {
-	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
+	if (inode && is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
 		if (S_ISDIR(inode->i_mode)) {
 			inc_nlink(dir);
 			set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
@@ -447,7 +446,7 @@ void update_parent_metadata(struct inode *dir, struct inode *inode,
 		set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
 	}
 
-	if (is_inode_flag_set(F2FS_I(inode), FI_INC_LINK))
+	if (inode && is_inode_flag_set(F2FS_I(inode), FI_INC_LINK))
 		clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
 }
 
@@ -471,7 +470,7 @@ next:
 	goto next;
 }
 
-void f2fs_update_dentry(struct inode *inode, struct f2fs_dentry_ptr *d,
+void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 				const struct qstr *name, f2fs_hash_t name_hash,
 				unsigned int bit_pos)
 {
@@ -483,8 +482,8 @@ void f2fs_update_dentry(struct inode *inode, struct f2fs_dentry_ptr *d,
 	de->hash_code = name_hash;
 	de->name_len = cpu_to_le16(name->len);
 	memcpy(d->filename[bit_pos], name->name, name->len);
-	de->ino = cpu_to_le32(inode->i_ino);
-	set_de_type(de, inode);
+	de->ino = cpu_to_le32(ino);
+	set_de_type(de, mode);
 	for (i = 0; i < slots; i++)
 		test_and_set_bit_le(bit_pos + i, (void *)d->bitmap);
 }
@@ -494,7 +493,7 @@ void f2fs_update_dentry(struct inode *inode, struct f2fs_dentry_ptr *d,
  * f2fs_unlock_op().
  */
 int __f2fs_add_link(struct inode *dir, const struct qstr *name,
-						struct inode *inode)
+				struct inode *inode, nid_t ino, umode_t mode)
 {
 	unsigned int bit_pos;
 	unsigned int level;
@@ -511,7 +510,7 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 	int err = 0;
 
 	if (f2fs_has_inline_dentry(dir)) {
-		err = f2fs_add_inline_entry(dir, name, inode);
+		err = f2fs_add_inline_entry(dir, name, inode, ino, mode);
 		if (!err || err != -EAGAIN)
 			return err;
 		else
@@ -561,26 +560,31 @@ start:
 add_dentry:
 	f2fs_wait_on_page_writeback(dentry_page, DATA);
 
-	down_write(&F2FS_I(inode)->i_sem);
-	page = init_inode_metadata(inode, dir, name, NULL);
-	if (IS_ERR(page)) {
-		err = PTR_ERR(page);
-		goto fail;
+	if (inode) {
+		down_write(&F2FS_I(inode)->i_sem);
+		page = init_inode_metadata(inode, dir, name, NULL);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
+			goto fail;
+		}
 	}
 
 	make_dentry_ptr(&d, (void *)dentry_blk, 1);
-	f2fs_update_dentry(inode, &d, name, dentry_hash, bit_pos);
+	f2fs_update_dentry(ino, mode, &d, name, dentry_hash, bit_pos);
 
 	set_page_dirty(dentry_page);
 
-	/* we don't need to mark_inode_dirty now */
-	F2FS_I(inode)->i_pino = dir->i_ino;
-	update_inode(inode, page);
-	f2fs_put_page(page, 1);
+	if (inode) {
+		/* we don't need to mark_inode_dirty now */
+		F2FS_I(inode)->i_pino = dir->i_ino;
+		update_inode(inode, page);
+		f2fs_put_page(page, 1);
+	}
 
 	update_parent_metadata(dir, inode, current_depth);
 fail:
-	up_write(&F2FS_I(inode)->i_sem);
+	if (inode)
+		up_write(&F2FS_I(inode)->i_sem);
 
 	if (is_inode_flag_set(F2FS_I(dir), FI_UPDATE_DIR)) {
 		update_inode_page(dir);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index edde64d..9a511f3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1237,6 +1237,7 @@ enum {
 	FI_FIRST_BLOCK_WRITTEN,	/* indicate #0 data block was written */
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
+	FI_INLINE_DOTS,		/* indicate inline dot dentries */
 };
 
 static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
@@ -1273,6 +1274,8 @@ static inline void get_inline_info(struct f2fs_inode_info *fi,
 		set_inode_flag(fi, FI_INLINE_DENTRY);
 	if (ri->i_inline & F2FS_DATA_EXIST)
 		set_inode_flag(fi, FI_DATA_EXIST);
+	if (ri->i_inline & F2FS_INLINE_DOTS)
+		set_inode_flag(fi, FI_INLINE_DOTS);
 }
 
 static inline void set_raw_inline(struct f2fs_inode_info *fi,
@@ -1288,6 +1291,8 @@ static inline void set_raw_inline(struct f2fs_inode_info *fi,
 		ri->i_inline |= F2FS_INLINE_DENTRY;
 	if (is_inode_flag_set(fi, FI_DATA_EXIST))
 		ri->i_inline |= F2FS_DATA_EXIST;
+	if (is_inode_flag_set(fi, FI_INLINE_DOTS))
+		ri->i_inline |= F2FS_INLINE_DOTS;
 }
 
 static inline int f2fs_has_inline_xattr(struct inode *inode)
@@ -1333,6 +1338,11 @@ static inline int f2fs_exist_data(struct inode *inode)
 	return is_inode_flag_set(F2FS_I(inode), FI_DATA_EXIST);
 }
 
+static inline int f2fs_has_inline_dots(struct inode *inode)
+{
+	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_DOTS);
+}
+
 static inline bool f2fs_is_atomic_file(struct inode *inode)
 {
 	return is_inode_flag_set(F2FS_I(inode), FI_ATOMIC_FILE);
@@ -1431,7 +1441,7 @@ struct dentry *f2fs_get_parent(struct dentry *child);
  * dir.c
  */
 extern unsigned char f2fs_filetype_table[F2FS_FT_MAX];
-void set_de_type(struct f2fs_dir_entry *, struct inode *);
+void set_de_type(struct f2fs_dir_entry *, umode_t);
 struct f2fs_dir_entry *find_target_dentry(struct qstr *, int *,
 			struct f2fs_dentry_ptr *);
 bool f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
@@ -1450,9 +1460,10 @@ ino_t f2fs_inode_by_name(struct inode *, struct qstr *);
 void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
 				struct page *, struct inode *);
 int update_dent_inode(struct inode *, const struct qstr *);
-void f2fs_update_dentry(struct inode *, struct f2fs_dentry_ptr *,
+void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *,
 			const struct qstr *, f2fs_hash_t , unsigned int);
-int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *);
+int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *, nid_t,
+			umode_t);
 void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *,
 							struct inode *);
 int f2fs_do_tmpfile(struct inode *, struct inode *);
@@ -1462,7 +1473,7 @@ bool f2fs_empty_dir(struct inode *);
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 {
 	return __f2fs_add_link(dentry->d_parent->d_inode, &dentry->d_name,
-				inode);
+				inode, inode->i_ino, inode->i_mode);
 }
 
 /*
@@ -1783,7 +1794,8 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *, struct qstr *,
 							struct page **);
 struct f2fs_dir_entry *f2fs_parent_inline_dir(struct inode *, struct page **);
 int make_empty_inline_dir(struct inode *inode, struct inode *, struct page *);
-int f2fs_add_inline_entry(struct inode *, const struct qstr *, struct inode *);
+int f2fs_add_inline_entry(struct inode *, const struct qstr *, struct inode *,
+						nid_t, umode_t);
 void f2fs_delete_inline_entry(struct f2fs_dir_entry *, struct page *,
 						struct inode *, struct inode *);
 bool f2fs_empty_inline_dir(struct inode *);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8241a87..d4a3107 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -390,7 +390,7 @@ out:
 }
 
 int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
-						struct inode *inode)
+			struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct page *ipage;
@@ -417,29 +417,34 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 		goto out;
 	}
 
-	down_write(&F2FS_I(inode)->i_sem);
-	page = init_inode_metadata(inode, dir, name, ipage);
-	if (IS_ERR(page)) {
-		err = PTR_ERR(page);
-		goto fail;
+	if (inode) {
+		down_write(&F2FS_I(inode)->i_sem);
+		page = init_inode_metadata(inode, dir, name, ipage);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
+			goto fail;
+		}
 	}
 
 	f2fs_wait_on_page_writeback(ipage, NODE);
 
 	name_hash = f2fs_dentry_hash(name);
 	make_dentry_ptr(&d, (void *)dentry_blk, 2);
-	f2fs_update_dentry(inode, &d, name, name_hash, bit_pos);
+	f2fs_update_dentry(ino, mode, &d, name, name_hash, bit_pos);
 
 	set_page_dirty(ipage);
 
 	/* we don't need to mark_inode_dirty now */
-	F2FS_I(inode)->i_pino = dir->i_ino;
-	update_inode(inode, page);
-	f2fs_put_page(page, 1);
+	if (inode) {
+		F2FS_I(inode)->i_pino = dir->i_ino;
+		update_inode(inode, page);
+		f2fs_put_page(page, 1);
+	}
 
 	update_parent_metadata(dir, inode, 0);
 fail:
-	up_write(&F2FS_I(inode)->i_sem);
+	if (inode)
+		up_write(&F2FS_I(inode)->i_sem);
 
 	if (is_inode_flag_set(F2FS_I(dir), FI_UPDATE_DIR)) {
 		update_inode(dir, ipage);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 1e2ae21..c8c8761 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -187,6 +187,44 @@ struct dentry *f2fs_get_parent(struct dentry *child)
 	return d_obtain_alias(f2fs_iget(child->d_inode->i_sb, ino));
 }
 
+static int __recover_dot_dentries(struct inode *dir, nid_t pino)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+	struct qstr dot = QSTR_INIT(".", 1);
+	struct qstr dotdot = QSTR_INIT("..", 2);
+	struct f2fs_dir_entry *de;
+	struct page *page;
+	int err = 0;
+
+	f2fs_lock_op(sbi);
+
+	de = f2fs_find_entry(dir, &dot, &page);
+	f2fs_dentry_kunmap(dir, page);
+	f2fs_put_page(page, 0);
+
+	if (de)
+		goto dotdot;
+
+	err = __f2fs_add_link(dir, &dot, NULL, dir->i_ino, S_IFDIR);
+	if (err)
+		goto out;
+dotdot:
+	de = f2fs_find_entry(dir, &dotdot, &page);
+	f2fs_dentry_kunmap(dir, page);
+	f2fs_put_page(page, 0);
+
+	if (!de)
+		err = __f2fs_add_link(dir, &dotdot, NULL, pino, S_IFDIR);
+out:
+	if (!err) {
+		clear_inode_flag(F2FS_I(dir), FI_INLINE_DOTS);
+		mark_inode_dirty(dir);
+	}
+
+	f2fs_unlock_op(sbi);
+	return err;
+}
+
 static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		unsigned int flags)
 {
@@ -206,6 +244,16 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = f2fs_iget(dir->i_sb, ino);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);
+
+		if (f2fs_has_inline_dots(inode)) {
+			int err;
+
+			err = __recover_dot_dentries(inode, dir->i_ino);
+			if (err) {
+				iget_failed(inode);
+				return ERR_PTR(err);
+			}
+		}
 	}
 
 	return d_splice_alias(inode, dentry);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index c69de88..679c465 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -115,7 +115,7 @@ retry:
 		iput(einode);
 		goto retry;
 	}
-	err = __f2fs_add_link(dir, &name, inode);
+	err = __f2fs_add_link(dir, &name, inode, inode->i_ino, inode->i_mode);
 	if (err)
 		goto out_err;
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 502f28c..591f8c3 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -178,6 +178,7 @@ struct f2fs_extent {
 #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
 #define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
 #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
+#define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
 
 #define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
 						F2FS_INLINE_XATTR_ADDRS - 1))
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
