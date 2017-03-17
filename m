From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 2/2] sload.f2fs: support sload files into
 directory includes inline dentry
Date: Fri, 17 Mar 2017 22:01:12 +0800
Message-ID: <447e5f92-fef4-7b02-196b-707d7c18fef4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cosRZ-00075A-Ce
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 14:01:25 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cosRX-0007UU-EK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 14:01:25 +0000
Received: by mail-it0-f67.google.com with SMTP id g138so4126055itb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 07:01:23 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

It seems the new created directory always includes inline dentries,
let sload.f2fs supporting it. 

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fsck/dir.c  | 139 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 fsck/f2fs.h |   4 +-
 2 files changed, 117 insertions(+), 26 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index d684b5d..57b7f9b 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -158,12 +158,6 @@ static int f2fs_find_entry(struct f2fs_sb_info *sbi,
 	unsigned int max_depth;
 	unsigned int level;
 
-	if (dir->i.i_inline & F2FS_INLINE_DENTRY) {
-		ERR_MSG("Not support to find \"%s\" in inline_dir pino=%x\n",
-				de->name, de->pino);
-		return 0;
-	}
-
 	max_depth = le32_to_cpu(dir->i.i_current_depth);
 	for (level = 0; level < max_depth; level ++) {
 		if (find_in_level(sbi, dir, level, de))
@@ -172,7 +166,7 @@ static int f2fs_find_entry(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
-static void f2fs_update_dentry(nid_t ino, umode_t mode,
+static void f2fs_update_dentry(nid_t ino, int file_type,
 		struct f2fs_dentry_ptr *d,
 		const unsigned char *name, int len, f2fs_hash_t name_hash,
 		unsigned int bit_pos)
@@ -187,7 +181,7 @@ static void f2fs_update_dentry(nid_t ino, umode_t mode,
 	memcpy(d->filename[bit_pos], name, len);
 	d->filename[bit_pos][len] = 0;
 	de->ino = cpu_to_le32(ino);
-	set_de_type(de, mode);
+	de->file_type = file_type;
 	for (i = 0; i < slots; i++)
 		test_and_set_bit_le(bit_pos + i, d->bitmap);
 }
@@ -196,24 +190,21 @@ static void f2fs_update_dentry(nid_t ino, umode_t mode,
  * f2fs_add_link - Add a new file(dir) to parent dir.
  */
 static int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
-			struct f2fs_node *child, block_t p_blkaddr)
+			const unsigned char *name, int name_len, nid_t ino,
+			int file_type, block_t p_blkaddr, int inc_link)
 {
 	int level = 0, current_depth, bit_pos;
 	int nbucket, nblock, bidx, block;
-	const unsigned char *name = child->i.i_name;
-	int name_len = le32_to_cpu(child->i.i_namelen);
 	int slots = GET_DENTRY_SLOTS(name_len);
 	f2fs_hash_t dentry_hash = f2fs_dentry_hash(name, name_len);
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr d;
 	struct dnode_of_data dn = {0};
 	nid_t pino = le32_to_cpu(parent->footer.ino);
-	nid_t ino = le32_to_cpu(child->footer.ino);
-	umode_t mode = le16_to_cpu(child->i.i_mode);
 	unsigned int dir_level = parent->i.i_dir_level;
 	int ret;
 
-	if (parent == NULL || child == NULL)
+	if (parent == NULL)
 		return -EINVAL;
 
 	if (!pino) {
@@ -266,7 +257,7 @@ start:
 
 add_dentry:
 	make_dentry_ptr(&d, (void *)dentry_blk, 1);
-	f2fs_update_dentry(ino, mode, &d, name, name_len, dentry_hash, bit_pos);
+	f2fs_update_dentry(ino, file_type, &d, name, name_len, dentry_hash, bit_pos);
 
 	ret = dev_write_block(dentry_blk, dn.data_blkaddr);
 	ASSERT(ret >= 0);
@@ -281,7 +272,7 @@ add_dentry:
 	}
 
 	/* Update parent's i_links info*/
-	if (S_ISDIR(mode)) {
+	if (inc_link && (file_type == F2FS_FT_DIR)){
 		u32 links = le32_to_cpu(parent->i.i_links);
 		parent->i.i_links = cpu_to_le32(links + 1);
 		dn.idirty = 1;
@@ -445,6 +436,102 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 		page_symlink(sbi, node_blk, de->link, size);
 }
 
+int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
+							block_t p_blkaddr)
+{
+	struct f2fs_inode *inode = &(node->i);
+	unsigned int dir_level = node->i.i_dir_level;
+	nid_t ino = le32_to_cpu(node->footer.ino);
+	char inline_data[MAX_INLINE_DATA];
+	struct dnode_of_data dn = {0};
+	struct f2fs_dentry_ptr d;
+	unsigned long bit_pos = 0;
+	int ret = 0;
+
+	if (!(inode->i_inline & F2FS_INLINE_DENTRY))
+		return 0;
+
+	memcpy(inline_data, inline_data_addr(node), MAX_INLINE_DATA);
+	memset(inline_data_addr(node), 0, MAX_INLINE_DATA);
+	inode->i_inline &= ~F2FS_INLINE_DENTRY;
+
+	ret = dev_write_block(node, p_blkaddr);
+	ASSERT(ret >= 0);
+
+	if (!dir_level) {
+		struct f2fs_inline_dentry *inline_dentry;
+		struct f2fs_dentry_block *dentry_blk;
+
+		dentry_blk = calloc(BLOCK_SZ, 1);
+		ASSERT(dentry_blk);
+
+		set_new_dnode(&dn, node, NULL, ino);
+		get_dnode_of_data(sbi, &dn, 0, ALLOC_NODE);
+		if (dn.data_blkaddr == NULL_ADDR)
+			new_data_block(sbi, dentry_blk, &dn, CURSEG_HOT_DATA);
+
+		inline_dentry = (struct f2fs_inline_dentry *)inline_data;
+		 /* copy data from inline dentry block to new dentry block */
+		memcpy(dentry_blk->dentry_bitmap, inline_dentry->dentry_bitmap,
+				INLINE_DENTRY_BITMAP_SIZE);
+		memset(dentry_blk->dentry_bitmap + INLINE_DENTRY_BITMAP_SIZE, 0,
+			SIZE_OF_DENTRY_BITMAP - INLINE_DENTRY_BITMAP_SIZE);
+
+		memcpy(dentry_blk->dentry, inline_dentry->dentry,
+			sizeof(struct f2fs_dir_entry) * NR_INLINE_DENTRY);
+		memcpy(dentry_blk->filename, inline_dentry->filename,
+				NR_INLINE_DENTRY * F2FS_SLOT_LEN);
+
+		ret = dev_write_block(dentry_blk, dn.data_blkaddr);
+		ASSERT(ret >= 0);
+
+		MSG(1, "%s: copy inline entry to block\n", __func__);
+
+		free(dentry_blk);
+		return ret;
+	}
+
+	make_empty_dir(sbi, node);
+	make_dentry_ptr(&d, (void *)inline_data, 2);
+
+	while (bit_pos < d.max) {
+		struct f2fs_dir_entry *de;
+		const unsigned char *filename;
+		int namelen;
+
+		if (!test_bit_le(bit_pos, d.bitmap)) {
+			bit_pos++;
+			continue;
+		}
+
+		de = &d.dentry[bit_pos];
+		if (!de->name_len) {
+			bit_pos++;
+			continue;
+		}
+
+		filename = d.filename[bit_pos];
+		namelen = le32_to_cpu(de->name_len);
+
+		if (is_dot_dotdot(filename, namelen)) {
+			bit_pos += GET_DENTRY_SLOTS(namelen);
+			continue;
+		}
+
+		ret = f2fs_add_link(sbi, node, filename, namelen,
+				le32_to_cpu(de->ino),
+				de->file_type, p_blkaddr, 0);
+		if (ret)
+			MSG(0, "Convert file \"%s\" ERR=%d\n", filename, ret);
+		else
+			MSG(1, "%s: add inline entry to block\n", __func__);
+
+		bit_pos += GET_DENTRY_SLOTS(namelen);
+	}
+
+	return 0;
+}
+
 int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
 {
 	struct f2fs_node *parent, *child;
@@ -466,6 +553,13 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
 	ret = dev_read_block(parent, ni.blk_addr);
 	ASSERT(ret >= 0);
 
+	/* Must convert inline dentry before the following opertions */
+	ret = convert_inline_dentry(sbi, parent, ni.blk_addr);
+	if (ret) {
+		MSG(0, "Convert inline dentry for pino=%x failed.\n", de->pino);
+		return -1;
+	}
+
 	ret = f2fs_find_entry(sbi, parent, de);
 	if (ret) {
 		MSG(0, "Skip the existing \"%s\" pino=%x ERR=%d\n",
@@ -474,13 +568,6 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
 			de->ino = 0;
 		goto free_parent_dir;
 	}
-	if (parent->i.i_inline & F2FS_INLINE_DENTRY) {
-		ERR_MSG("Not support adding \"%s\" in inline_dir pino=%x\n",
-					de->name, de->pino);
-		if (de->file_type == F2FS_FT_REG_FILE)
-			de->ino = 0;
-		goto free_parent_dir;
-	}
 
 	child = calloc(BLOCK_SZ, 1);
 	ASSERT(child);
@@ -489,7 +576,11 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
 
 	init_inode_block(sbi, child, de);
 
-	ret = f2fs_add_link(sbi, parent, child, ni.blk_addr);
+	ret = f2fs_add_link(sbi, parent, child->i.i_name,
+				le32_to_cpu(child->i.i_namelen),
+				le32_to_cpu(child->footer.ino),
+				map_de_type(le16_to_cpu(child->i.i_mode)),
+				ni.blk_addr, 1);
 	if (ret) {
 		MSG(0, "Skip the existing \"%s\" pino=%x ERR=%d\n",
 					de->name, de->pino, ret);
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index b621912..efc43f6 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -444,9 +444,9 @@ static unsigned char f2fs_type_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFLNK >> S_SHIFT]    = F2FS_FT_SYMLINK,
 };
 
-static inline void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
+static inline int map_de_type(umode_t mode)
 {
-	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
+       return f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
 }
 
 static inline void *inline_xattr_addr(struct f2fs_inode *inode)
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
