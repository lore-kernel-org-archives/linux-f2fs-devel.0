From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to do security initialization of
	encrypted inode with original filename
Date: Sun, 28 Aug 2016 18:57:55 +0800
Message-ID: <1472381875-3429-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bdxox-0006ZN-Um
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 28 Aug 2016 11:00:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bdxov-00031m-S3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 28 Aug 2016 11:00:11 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

When creating new inode, security_inode_init_security will be called for
initializing security info related to the inode, and filename is passed to
security module, it helps security module such as SElinux to know which
rule or label could be applied for the inode with specified name.

Previously, if new inode is created as an encrypted one, f2fs will transfer
encrypted filename to security module which may fail the check of security
policy belong to the inode. So in order to this issue, alter to transfer
original unencrypted filename instead.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c    | 21 +++++++++++++--------
 fs/f2fs/f2fs.h   |  8 ++++----
 fs/f2fs/inline.c | 17 +++++++++--------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 2941759..fbc8ede 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -378,7 +378,8 @@ static int make_empty_dir(struct inode *inode,
 }
 
 struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
-			const struct qstr *name, struct page *dpage)
+			const struct qstr *new_name, const struct qstr *orig_name,
+			struct page *dpage)
 {
 	struct page *page;
 	int err;
@@ -403,7 +404,7 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 		if (err)
 			goto put_error;
 
-		err = f2fs_init_security(inode, dir, name, page);
+		err = f2fs_init_security(inode, dir, orig_name, page);
 		if (err)
 			goto put_error;
 
@@ -420,8 +421,8 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 		set_cold_node(inode, page);
 	}
 
-	if (name)
-		init_dent_inode(name, page);
+	if (new_name)
+		init_dent_inode(new_name, page);
 
 	/*
 	 * This file should be checkpointed during fsync.
@@ -507,6 +508,7 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 }
 
 int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
+				const struct qstr *orig_name,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	unsigned int bit_pos;
@@ -572,7 +574,8 @@ add_dentry:
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
-		page = init_inode_metadata(inode, dir, new_name, NULL);
+		page = init_inode_metadata(inode, dir, new_name,
+						orig_name, NULL);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			goto fail;
@@ -622,9 +625,11 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 
 	err = -EAGAIN;
 	if (f2fs_has_inline_dentry(dir))
-		err = f2fs_add_inline_entry(dir, &new_name, inode, ino, mode);
+		err = f2fs_add_inline_entry(dir, &new_name, fname.usr_fname,
+							inode, ino, mode);
 	if (err == -EAGAIN)
-		err = f2fs_add_regular_entry(dir, &new_name, inode, ino, mode);
+		err = f2fs_add_regular_entry(dir, &new_name, fname.usr_fname,
+							inode, ino, mode);
 
 	fscrypt_free_filename(&fname);
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
@@ -637,7 +642,7 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 	int err = 0;
 
 	down_write(&F2FS_I(inode)->i_sem);
-	page = init_inode_metadata(inode, dir, NULL, NULL);
+	page = init_inode_metadata(inode, dir, NULL, NULL, NULL);
 	if (IS_ERR(page)) {
 		err = PTR_ERR(page);
 		goto fail;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5d0c34a..dcdf87d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1946,7 +1946,7 @@ bool f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
 void do_make_empty_dir(struct inode *, struct inode *,
 			struct f2fs_dentry_ptr *);
 struct page *init_inode_metadata(struct inode *, struct inode *,
-			const struct qstr *, struct page *);
+		const struct qstr *, const struct qstr *, struct page *);
 void update_parent_metadata(struct inode *, struct inode *, unsigned int);
 int room_for_filename(const void *, int, int);
 void f2fs_drop_nlink(struct inode *, struct inode *);
@@ -1960,7 +1960,7 @@ int update_dent_inode(struct inode *, struct inode *, const struct qstr *);
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *,
 			const struct qstr *, f2fs_hash_t , unsigned int);
 int f2fs_add_regular_entry(struct inode *, const struct qstr *,
-						struct inode *, nid_t, umode_t);
+			const struct qstr *, struct inode *, nid_t, umode_t);
 int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *, nid_t,
 			umode_t);
 void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *,
@@ -2330,8 +2330,8 @@ bool recover_inline_data(struct inode *, struct page *);
 struct f2fs_dir_entry *find_in_inline_dir(struct inode *,
 				struct fscrypt_name *, struct page **);
 int make_empty_inline_dir(struct inode *inode, struct inode *, struct page *);
-int f2fs_add_inline_entry(struct inode *, const struct qstr *, struct inode *,
-						nid_t, umode_t);
+int f2fs_add_inline_entry(struct inode *, const struct qstr *,
+		const struct qstr *, struct inode *, nid_t, umode_t);
 void f2fs_delete_inline_entry(struct f2fs_dir_entry *, struct page *,
 						struct inode *, struct inode *);
 bool f2fs_empty_inline_dir(struct inode *);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ccea873..a96c825 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -424,7 +424,7 @@ static int f2fs_add_inline_entries(struct inode *dir,
 		ino = le32_to_cpu(de->ino);
 		fake_mode = get_de_type(de) << S_SHIFT;
 
-		err = f2fs_add_regular_entry(dir, &new_name, NULL,
+		err = f2fs_add_regular_entry(dir, &new_name, NULL, NULL,
 							ino, fake_mode);
 		if (err)
 			goto punch_dentry_pages;
@@ -488,17 +488,17 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 		return f2fs_move_rehashed_dirents(dir, ipage, inline_dentry);
 }
 
-int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
-			struct inode *inode, nid_t ino, umode_t mode)
+int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
+				const struct qstr *orig_name,
+				struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct page *ipage;
 	unsigned int bit_pos;
 	f2fs_hash_t name_hash;
-	size_t namelen = name->len;
 	struct f2fs_inline_dentry *dentry_blk = NULL;
 	struct f2fs_dentry_ptr d;
-	int slots = GET_DENTRY_SLOTS(namelen);
+	int slots = GET_DENTRY_SLOTS(new_name->len);
 	struct page *page = NULL;
 	int err = 0;
 
@@ -519,7 +519,8 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
-		page = init_inode_metadata(inode, dir, name, ipage);
+		page = init_inode_metadata(inode, dir, new_name,
+						orig_name, ipage);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			goto fail;
@@ -528,9 +529,9 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 
 	f2fs_wait_on_page_writeback(ipage, NODE, true);
 
-	name_hash = f2fs_dentry_hash(name);
+	name_hash = f2fs_dentry_hash(new_name);
 	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 2);
-	f2fs_update_dentry(ino, mode, &d, name, name_hash, bit_pos);
+	f2fs_update_dentry(ino, mode, &d, new_name, name_hash, bit_pos);
 
 	set_page_dirty(ipage);
 
-- 
2.7.2


------------------------------------------------------------------------------
