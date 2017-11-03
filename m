From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: fix warnings when building in android
Date: Thu,  2 Nov 2017 20:16:39 -0700
Message-ID: <20171103031639.11136-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1eASTQ-0006XJ-52
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 03:16:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eASTO-0004VG-Ud
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 03:16:48 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@google.com>

From: Jaegeuk Kim <jaegeuk@google.com>

This patch tries to avoid all the warnings.

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 fsck/dir.c     | 28 +++++++++++++++++-----------
 fsck/fsck.h    |  4 ++--
 fsck/node.c    |  2 +-
 fsck/segment.c | 10 +++++-----
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index bbf28aa..27c3245 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -51,10 +51,12 @@ void make_dentry_ptr(struct f2fs_dentry_ptr *d, struct f2fs_node *node_blk,
 
 		d->max = entry_cnt;
 		d->nr_bitmap = bitmap_size;
-		d->bitmap = src;
-		d->dentry = src + bitmap_size + reserved_size;
-		d->filename = src + bitmap_size + reserved_size +
-						SIZE_OF_DIR_ENTRY * entry_cnt;
+		d->bitmap = (u8 *)src;
+		d->dentry = (struct f2fs_dir_entry *)
+				((char *)src + bitmap_size + reserved_size);
+		d->filename = (__u8 (*)[F2FS_SLOT_LEN])((char *)src +
+				bitmap_size + reserved_size +
+				SIZE_OF_DIR_ENTRY * entry_cnt);
 	}
 }
 
@@ -68,7 +70,7 @@ static struct f2fs_dir_entry *find_target_dentry(const u8 *name,
 
 	if (max_slots)
 		*max_slots = 0;
-	while (bit_pos < d->max) {
+	while (bit_pos < (unsigned long)d->max) {
 		if (!test_bit_le(bit_pos, d->bitmap)) {
 			bit_pos++;
 			max_len++;
@@ -110,7 +112,7 @@ static int find_in_level(struct f2fs_sb_info *sbi,struct f2fs_node *dir,
 	unsigned int nbucket, nblock;
 	unsigned int bidx, end_block;
 	struct f2fs_dir_entry *dentry = NULL;
-	struct dnode_of_data dn = {0};
+	struct dnode_of_data dn;
 	void *dentry_blk;
 	int max_slots = 214;
 	nid_t ino = le32_to_cpu(dir->footer.ino);
@@ -129,6 +131,7 @@ static int find_in_level(struct f2fs_sb_info *sbi,struct f2fs_node *dir,
 	dentry_blk = calloc(BLOCK_SZ, 1);
 	ASSERT(dentry_blk);
 
+	memset(&dn, 0, sizeof(dn));
 	for (; bidx < end_block; bidx++) {
 
 		/* Firstly, we should know direct node of target data blk */
@@ -206,7 +209,7 @@ static int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
 	f2fs_hash_t dentry_hash = f2fs_dentry_hash(name, name_len);
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr d;
-	struct dnode_of_data dn = {0};
+	struct dnode_of_data dn;
 	nid_t pino = le32_to_cpu(parent->footer.ino);
 	unsigned int dir_level = parent->i.i_dir_level;
 	int ret;
@@ -238,6 +241,7 @@ start:
 	nblock = bucket_blocks(level);
 	bidx = dir_block_index(level, dir_level, le32_to_cpu(dentry_hash) % nbucket);
 
+	memset(&dn, 0, sizeof(dn));
 	for (block = bidx; block <= (bidx + nblock - 1); block++) {
 
 		/* Firstly, we should know the direct node of target data blk */
@@ -285,7 +289,8 @@ add_dentry:
 		dn.idirty = 1;
 	}
 
-	if ((block + 1) * F2FS_BLKSIZE > le64_to_cpu(parent->i.i_size)) {
+	if ((__u64)((block + 1) * F2FS_BLKSIZE) >
+					le64_to_cpu(parent->i.i_size)) {
 		parent->i.i_size = cpu_to_le64((block + 1) * F2FS_BLKSIZE);
 		dn.idirty = 1;
 	}
@@ -360,7 +365,7 @@ static void page_symlink(struct f2fs_sb_info *sbi, struct f2fs_node *inode,
 	get_node_info(sbi, ino, &ni);
 
 	/* store into inline_data */
-	if (symlen + 1 <= MAX_INLINE_DATA(inode)) {
+	if ((unsigned long)(symlen + 1) <= MAX_INLINE_DATA(inode)) {
 		inode->i.i_inline |= F2FS_INLINE_DATA;
 		inode->i.i_inline |= F2FS_DATA_EXIST;
 		memcpy(inline_data_addr(inode), symname, symlen);
@@ -460,7 +465,7 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
 	unsigned int dir_level = node->i.i_dir_level;
 	nid_t ino = le32_to_cpu(node->footer.ino);
 	char inline_data[MAX_INLINE_DATA(node)];
-	struct dnode_of_data dn = {0};
+	struct dnode_of_data dn;
 	struct f2fs_dentry_ptr d;
 	unsigned long bit_pos = 0;
 	int ret = 0;
@@ -475,6 +480,7 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
 	ret = dev_write_block(node, p_blkaddr);
 	ASSERT(ret >= 0);
 
+	memset(&dn, 0, sizeof(dn));
 	if (!dir_level) {
 		struct f2fs_dentry_block *dentry_blk;
 		struct f2fs_dentry_ptr src, dst;
@@ -510,7 +516,7 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
 	make_empty_dir(sbi, node);
 	make_dentry_ptr(&d, node, (void *)inline_data, 2);
 
-	while (bit_pos < d.max) {
+	while (bit_pos < (unsigned long)d.max) {
 		struct f2fs_dir_entry *de;
 		const unsigned char *filename;
 		int namelen;
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 7b6ac2b..1db5437 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -231,8 +231,8 @@ block_t new_node_block(struct f2fs_sb_info *,
 					struct dnode_of_data *, unsigned int);
 
 /* segment.c */
-u64 f2fs_read(struct f2fs_sb_info *, nid_t, void *, u64, pgoff_t);
-u64 f2fs_write(struct f2fs_sb_info *, nid_t, void *, u64, pgoff_t);
+u64 f2fs_read(struct f2fs_sb_info *, nid_t, u8 *, u64, pgoff_t);
+u64 f2fs_write(struct f2fs_sb_info *, nid_t, u8 *, u64, pgoff_t);
 void f2fs_filesize_update(struct f2fs_sb_info *, nid_t, u64);
 
 void get_dnode_of_data(struct f2fs_sb_info *, struct dnode_of_data *,
diff --git a/fsck/node.c b/fsck/node.c
index e37b817..fd583f7 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -105,7 +105,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
  *
  * By default, it sets inline_xattr and inline_data
  */
-static int get_node_path(struct f2fs_node *node, unsigned long block,
+static int get_node_path(struct f2fs_node *node, long block,
 				int offset[4], unsigned int noffset[4])
 {
 	const long direct_index = ADDRS_PER_INODE(&node->i);
diff --git a/fsck/segment.c b/fsck/segment.c
index efbd667..695fc6a 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -66,7 +66,7 @@ void new_data_block(struct f2fs_sb_info *sbi, void *block,
 {
 	struct f2fs_summary sum;
 	struct node_info ni;
-	int blkaddr = datablock_addr(dn->node_blk, dn->ofs_in_node);
+	unsigned int blkaddr = datablock_addr(dn->node_blk, dn->ofs_in_node);
 
 	ASSERT(dn->node_blk);
 	memset(block, 0, BLOCK_SZ);
@@ -82,7 +82,7 @@ void new_data_block(struct f2fs_sb_info *sbi, void *block,
 	set_data_blkaddr(dn);
 }
 
-u64 f2fs_read(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
+u64 f2fs_read(struct f2fs_sb_info *sbi, nid_t ino, u8 *buffer,
 					u64 count, pgoff_t offset)
 {
 	struct dnode_of_data dn;
@@ -165,7 +165,7 @@ u64 f2fs_read(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
 	return read_count;
 }
 
-u64 f2fs_write(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
+u64 f2fs_write(struct f2fs_sb_info *sbi, nid_t ino, u8 *buffer,
 					u64 count, pgoff_t offset)
 {
 	struct dnode_of_data dn;
@@ -276,7 +276,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
 {
 	int fd, n;
 	pgoff_t off = 0;
-	char buffer[BLOCK_SZ];
+	u8 buffer[BLOCK_SZ];
 
 	if (de->ino == 0)
 		return -1;
@@ -310,7 +310,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
 				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
 		}
 		n = read(fd, buffer, BLOCK_SZ);
-		ASSERT(n == de->size);
+		ASSERT((unsigned long)n == de->size);
 		memcpy(inline_data_addr(node_blk), buffer, de->size);
 		node_blk->i.i_size = cpu_to_le64(de->size);
 		write_inode(ni.blk_addr, node_blk);
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
