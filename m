From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 14/18] f2fs crypto: add filename encryption for
	f2fs_lookup
Date: Fri,  8 May 2015 21:20:49 -0700
Message-ID: <1431145253-2019-14-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGk-0002X6-FU
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGj-0003sY-Av for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:42 +0000
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

This patch implements filename encryption support for f2fs_lookup.

Note that, f2fs_find_entry should be outside of f2fs_(un)lock_op().

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c    | 79 ++++++++++++++++++++++++++++++++------------------------
 fs/f2fs/f2fs.h   |  9 ++++---
 fs/f2fs/inline.c |  9 ++++---
 3 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ab6455d..5e10d9d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -76,20 +76,10 @@ static unsigned long dir_block_index(unsigned int level,
 	return bidx;
 }
 
-static bool early_match_name(size_t namelen, f2fs_hash_t namehash,
-				struct f2fs_dir_entry *de)
-{
-	if (le16_to_cpu(de->name_len) != namelen)
-		return false;
-
-	if (de->hash_code != namehash)
-		return false;
-
-	return true;
-}
-
 static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
-				struct qstr *name, int *max_slots,
+				struct f2fs_filename *fname,
+				f2fs_hash_t namehash,
+				int *max_slots,
 				struct page **res_page)
 {
 	struct f2fs_dentry_block *dentry_blk;
@@ -99,8 +89,7 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 	dentry_blk = (struct f2fs_dentry_block *)kmap(dentry_page);
 
 	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
-	de = find_target_dentry(name, max_slots, &d);
-
+	de = find_target_dentry(fname, namehash, max_slots, &d);
 	if (de)
 		*res_page = dentry_page;
 	else
@@ -114,13 +103,15 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 	return de;
 }
 
-struct f2fs_dir_entry *find_target_dentry(struct qstr *name, int *max_slots,
-						struct f2fs_dentry_ptr *d)
+struct f2fs_dir_entry *find_target_dentry(struct f2fs_filename *fname,
+			f2fs_hash_t namehash, int *max_slots,
+			struct f2fs_dentry_ptr *d)
 {
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
-	f2fs_hash_t namehash = f2fs_dentry_hash(name);
 	int max_len = 0;
+	struct f2fs_str de_name = FSTR_INIT(NULL, 0);
+	struct f2fs_str *name = &fname->disk_name;
 
 	if (max_slots)
 		*max_slots = 0;
@@ -132,8 +123,18 @@ struct f2fs_dir_entry *find_target_dentry(struct qstr *name, int *max_slots,
 		}
 
 		de = &d->dentry[bit_pos];
-		if (early_match_name(name->len, namehash, de) &&
-			!memcmp(d->filename[bit_pos], name->name, name->len))
+
+		/* encrypted case */
+		de_name.name = d->filename[bit_pos];
+		de_name.len = le16_to_cpu(de->name_len);
+
+		/* show encrypted name */
+		if (fname->hash) {
+			if (de->hash_code == fname->hash)
+				goto found;
+		} else if (de_name.len == name->len &&
+			de->hash_code == namehash &&
+			!memcmp(de_name.name, name->name, name->len))
 			goto found;
 
 		if (max_slots && max_len > *max_slots)
@@ -155,16 +156,21 @@ found:
 }
 
 static struct f2fs_dir_entry *find_in_level(struct inode *dir,
-			unsigned int level, struct qstr *name,
-			f2fs_hash_t namehash, struct page **res_page)
+					unsigned int level,
+					struct f2fs_filename *fname,
+					struct page **res_page)
 {
-	int s = GET_DENTRY_SLOTS(name->len);
+	struct qstr name = FSTR_TO_QSTR(&fname->disk_name);
+	int s = GET_DENTRY_SLOTS(name.len);
 	unsigned int nbucket, nblock;
 	unsigned int bidx, end_block;
 	struct page *dentry_page;
 	struct f2fs_dir_entry *de = NULL;
 	bool room = false;
 	int max_slots;
+	f2fs_hash_t namehash;
+
+	namehash = f2fs_dentry_hash(&name);
 
 	f2fs_bug_on(F2FS_I_SB(dir), level > MAX_DIR_HASH_DEPTH);
 
@@ -183,7 +189,8 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 			continue;
 		}
 
-		de = find_in_block(dentry_page, name, &max_slots, res_page);
+		de = find_in_block(dentry_page, fname, namehash, &max_slots,
+								res_page);
 		if (de)
 			break;
 
@@ -211,30 +218,34 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 {
 	unsigned long npages = dir_blocks(dir);
 	struct f2fs_dir_entry *de = NULL;
-	f2fs_hash_t name_hash;
 	unsigned int max_depth;
 	unsigned int level;
+	struct f2fs_filename fname;
+	int err;
 
 	*res_page = NULL;
 
-	if (f2fs_has_inline_dentry(dir))
-		return find_in_inline_dir(dir, child, res_page);
+	err = f2fs_fname_setup_filename(dir, child, 1, &fname);
+	if (err)
+		return NULL;
+
+	if (f2fs_has_inline_dentry(dir)) {
+		de = find_in_inline_dir(dir, &fname, res_page);
+		goto out;
+	}
 
 	if (npages == 0)
-		return NULL;
+		goto out;
 
-	name_hash = f2fs_dentry_hash(child);
 	max_depth = F2FS_I(dir)->i_current_depth;
 
 	for (level = 0; level < max_depth; level++) {
-		de = find_in_level(dir, level, child, name_hash, res_page);
+		de = find_in_level(dir, level, &fname, res_page);
 		if (de)
 			break;
 	}
-	if (!de && F2FS_I(dir)->chash != name_hash) {
-		F2FS_I(dir)->chash = name_hash;
-		F2FS_I(dir)->clevel = level - 1;
-	}
+out:
+	f2fs_fname_free_filename(&fname);
 	return de;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 963616f..6898331 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1584,8 +1584,9 @@ struct dentry *f2fs_get_parent(struct dentry *child);
  */
 extern unsigned char f2fs_filetype_table[F2FS_FT_MAX];
 void set_de_type(struct f2fs_dir_entry *, umode_t);
-struct f2fs_dir_entry *find_target_dentry(struct qstr *, int *,
-			struct f2fs_dentry_ptr *);
+
+struct f2fs_dir_entry *find_target_dentry(struct f2fs_filename *,
+			f2fs_hash_t, int *, struct f2fs_dentry_ptr *);
 bool f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
 			unsigned int, struct f2fs_str *);
 void do_make_empty_dir(struct inode *, struct inode *,
@@ -1931,8 +1932,8 @@ int f2fs_convert_inline_page(struct dnode_of_data *, struct page *);
 int f2fs_convert_inline_inode(struct inode *);
 int f2fs_write_inline_data(struct inode *, struct page *);
 bool recover_inline_data(struct inode *, struct page *);
-struct f2fs_dir_entry *find_in_inline_dir(struct inode *, struct qstr *,
-							struct page **);
+struct f2fs_dir_entry *find_in_inline_dir(struct inode *,
+				struct f2fs_filename *, struct page **);
 struct f2fs_dir_entry *f2fs_parent_inline_dir(struct inode *, struct page **);
 int make_empty_inline_dir(struct inode *inode, struct inode *, struct page *);
 int f2fs_add_inline_entry(struct inode *, const struct qstr *, struct inode *,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index dd51d3f..38e75fb 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -284,23 +284,26 @@ process_inline:
 }
 
 struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
-				struct qstr *name, struct page **res_page)
+			struct f2fs_filename *fname, struct page **res_page)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct f2fs_inline_dentry *inline_dentry;
+	struct qstr name = FSTR_TO_QSTR(&fname->disk_name);
 	struct f2fs_dir_entry *de;
 	struct f2fs_dentry_ptr d;
 	struct page *ipage;
+	f2fs_hash_t namehash;
 
 	ipage = get_node_page(sbi, dir->i_ino);
 	if (IS_ERR(ipage))
 		return NULL;
 
+	namehash = f2fs_dentry_hash(&name);
+
 	inline_dentry = inline_data_addr(ipage);
 
 	make_dentry_ptr(NULL, &d, (void *)inline_dentry, 2);
-	de = find_target_dentry(name, NULL, &d);
-
+	de = find_target_dentry(fname, namehash, NULL, &d);
 	unlock_page(ipage);
 	if (de)
 		*res_page = ipage;
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
