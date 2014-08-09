From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/5] f2fs: export dir operations for inline dir
Date: Sat, 09 Aug 2014 10:47:02 +0800
Message-ID: <00c001cfb37c$4ceb7650$e6c262f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XFwhM-00005N-2K
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:48:00 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XFwhK-0002tY-0Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:47:59 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NA0005CDQFQEX50@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 11:47:50 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch export and share some static functions and array in dir.c for inline
dir functions.

Additionally add a parameter in f2fs_delete_entry to pass dir inode from caller
instead of acquiring from page for inline dir op.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c      | 22 ++++++++++------------
 fs/f2fs/f2fs.h     |  9 ++++++++-
 fs/f2fs/namei.c    |  4 ++--
 fs/f2fs/recovery.c |  2 +-
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index bcf893c..154a5fa 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -37,7 +37,7 @@ static unsigned int bucket_blocks(unsigned int level)
 		return 4;
 }
 
-static unsigned char f2fs_filetype_table[F2FS_FT_MAX] = {
+unsigned char f2fs_filetype_table[F2FS_FT_MAX] = {
 	[F2FS_FT_UNKNOWN]	= DT_UNKNOWN,
 	[F2FS_FT_REG_FILE]	= DT_REG,
 	[F2FS_FT_DIR]		= DT_DIR,
@@ -59,7 +59,7 @@ static unsigned char f2fs_type_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFLNK >> S_SHIFT]	= F2FS_FT_SYMLINK,
 };
 
-static void set_de_type(struct f2fs_dir_entry *de, struct inode *inode)
+void set_de_type(struct f2fs_dir_entry *de, struct inode *inode)
 {
 	umode_t mode = inode->i_mode;
 	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
@@ -77,7 +77,7 @@ static unsigned long dir_block_index(unsigned int level,
 	return bidx;
 }
 
-static bool early_match_name(size_t namelen, f2fs_hash_t namehash,
+bool early_match_name(size_t namelen, f2fs_hash_t namehash,
 				struct f2fs_dir_entry *de)
 {
 	if (le16_to_cpu(de->name_len) != namelen)
@@ -308,7 +308,6 @@ static int make_empty_dir(struct inode *inode,
 	if (IS_ERR(dentry_page))
 		return PTR_ERR(dentry_page);
 
-
 	dentry_blk = kmap_atomic(dentry_page);
 
 	de = &dentry_blk->dentry[0];
@@ -334,7 +333,7 @@ static int make_empty_dir(struct inode *inode,
 	return 0;
 }
 
-static struct page *init_inode_metadata(struct inode *inode,
+struct page *init_inode_metadata(struct inode *inode,
 		struct inode *dir, const struct qstr *name)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
@@ -397,7 +396,7 @@ error:
 	return ERR_PTR(err);
 }
 
-static void update_parent_metadata(struct inode *dir, struct inode *inode,
+void update_parent_metadata(struct inode *dir, struct inode *inode,
 						unsigned int current_depth)
 {
 	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
@@ -567,12 +566,10 @@ fail:
  * entry in name page does not need to be touched during deletion.
  */
 void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
-						struct inode *inode)
+					struct inode *dir, struct inode *inode)
 {
 	struct	f2fs_dentry_block *dentry_blk;
-	unsigned int bit_pos;
-	struct address_space *mapping = page->mapping;
-	struct inode *dir = mapping->host;
+	unsigned int bit_pos = 0;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
 	int i;
 
@@ -631,7 +628,7 @@ bool f2fs_empty_dir(struct inode *dir)
 	unsigned long bidx;
 	struct page *dentry_page;
 	unsigned int bit_pos;
-	struct	f2fs_dentry_block *dentry_blk;
+	struct f2fs_dentry_block *dentry_blk;
 	unsigned long nblock = dir_blocks(dir);
 
 	for (bidx = 0; bidx < nblock; bidx++) {
@@ -643,7 +640,6 @@ bool f2fs_empty_dir(struct inode *dir)
 				return false;
 		}
 
-
 		dentry_blk = kmap_atomic(dentry_page);
 		if (bidx == 0)
 			bit_pos = 2;
@@ -705,6 +701,8 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 					le32_to_cpu(de->ino), d_type))
 				goto stop;
 
+			f2fs_bug_on(!de->name_len);
+
 			bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 			ctx->pos = n * NR_DENTRY_IN_BLOCK + bit_pos;
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4dab533..58c1a49 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1145,6 +1145,12 @@ struct dentry *f2fs_get_parent(struct dentry *child);
 /*
  * dir.c
  */
+extern unsigned char f2fs_filetype_table[F2FS_FT_MAX];
+bool early_match_name(size_t, f2fs_hash_t, struct f2fs_dir_entry *);
+void set_de_type(struct f2fs_dir_entry *, struct inode *);
+struct page *init_inode_metadata(struct inode *, struct inode *,
+							const struct qstr *);
+void update_parent_metadata(struct inode *, struct inode *, unsigned int);
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *, struct qstr *,
 							struct page **);
 struct f2fs_dir_entry *f2fs_parent_dir(struct inode *, struct page **);
@@ -1153,7 +1159,8 @@ void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
 				struct page *, struct inode *);
 int update_dent_inode(struct inode *, const struct qstr *);
 int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *);
-void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *);
+void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *,
+							struct inode *);
 int f2fs_do_tmpfile(struct inode *, struct inode *);
 int f2fs_make_empty(struct inode *, struct inode *);
 bool f2fs_empty_dir(struct inode *);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 27b0377..648b968 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -226,7 +226,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		f2fs_put_page(page, 0);
 		goto fail;
 	}
-	f2fs_delete_entry(de, page, inode);
+	f2fs_delete_entry(de, page, dir, inode);
 	f2fs_unlock_op(sbi);
 
 	/* In order to evict this inode,  we set it dirty */
@@ -450,7 +450,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	old_inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(old_inode);
 
-	f2fs_delete_entry(old_entry, old_page, NULL);
+	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
 
 	if (old_dir_entry) {
 		if (old_dir != new_dir) {
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index fe1c6d9..6f7d5a1 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -78,7 +78,7 @@ retry:
 			iput(einode);
 			goto out_unmap_put;
 		}
-		f2fs_delete_entry(de, page, einode);
+		f2fs_delete_entry(de, page, dir, einode);
 		iput(einode);
 		goto retry;
 	}
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
