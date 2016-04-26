From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] sload.f2fs: support loading files into
	partition directly
Date: Mon, 25 Apr 2016 17:28:37 -0700
Message-ID: <1461630518-16944-2-git-send-email-jaegeuk@kernel.org>
References: <1461630518-16944-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1auqs9-0005sV-9J
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:29:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auqs4-0001g8-IZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:29:01 +0000
In-Reply-To: <1461630518-16944-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch implements loading files into the existing partition.
For example,
 # sload.f2fs -f ./ /dev/sdb1

Then, all the directories and files will be loaded into /dev/sdb1.
By default, newly files should have inline_data and inline_xattr, if possible.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
Signed-off-by: Liu Shuoran <liushuoran@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 README            |   1 +
 configure.ac      |   1 +
 fsck/Makefile.am  |   6 +-
 fsck/defrag.c     |   2 +-
 fsck/dir.c        | 584 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/f2fs.h       |  77 ++++++-
 fsck/fsck.h       |  26 ++-
 fsck/main.c       |  56 ++++++
 fsck/mount.c      |  90 ++++++++-
 fsck/node.c       | 250 +++++++++++++++++++++++
 fsck/node.h       | 101 ++++++++++
 fsck/segment.c    | 220 ++++++++++++++++++++
 fsck/sload.c      | 247 +++++++++++++++++++++++
 fsck/xattr.c      | 241 ++++++++++++++++++++++
 fsck/xattr.h      |  66 ++++++
 include/f2fs_fs.h |  18 +-
 man/Makefile.am   |   2 +-
 man/defrag.f2fs.8 |   3 +-
 man/dump.f2fs.8   |   3 +-
 man/fsck.f2fs.8   |   3 +-
 man/mkfs.f2fs.8   |   3 +-
 man/resize.f2fs.8 |   3 +-
 man/sload.f2fs.8  |  56 ++++++
 23 files changed, 2042 insertions(+), 17 deletions(-)
 create mode 100644 fsck/dir.c
 create mode 100644 fsck/node.c
 create mode 100644 fsck/node.h
 create mode 100644 fsck/segment.c
 create mode 100644 fsck/sload.c
 create mode 100644 fsck/xattr.c
 create mode 100644 fsck/xattr.h
 create mode 100644 man/sload.f2fs.8

diff --git a/README b/README
index 222cbc3..77d9b49 100644
--- a/README
+++ b/README
@@ -12,6 +12,7 @@ Your should install the following packages.
  - pkg-config
  - autoconf
  - libtool
+ - libselinux1-dev
 
 Initial compilation
 -------------------
diff --git a/configure.ac b/configure.ac
index 1f6ff5a..42df775 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,6 +54,7 @@ AC_PATH_PROG([LDCONFIG], [ldconfig],
 
 # Checks for libraries.
 PKG_CHECK_MODULES([libuuid], [uuid])
+PKG_CHECK_MODULES([libselinux], [libselinux])
 
 # Checks for header files.
 AC_CHECK_HEADERS([linux/fs.h fcntl.h mntent.h stdlib.h string.h \
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 3586625..7abcd00 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -4,10 +4,12 @@ AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
 sbin_PROGRAMS = fsck.f2fs
 fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c f2fs.h fsck.h $(top_srcdir)/include/f2fs_fs.h	\
-		resize.c
-fsck_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
+		resize.c										\
+		node.c segment.c dir.c sload.c xattr.c
+fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
 
 install-data-hook:
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/defrag.f2fs
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/resize.f2fs
+	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/sload.f2fs
diff --git a/fsck/defrag.c b/fsck/defrag.c
index 7abc0bf..079e7a7 100644
--- a/fsck/defrag.c
+++ b/fsck/defrag.c
@@ -51,7 +51,7 @@ static int migrate_block(struct f2fs_sb_info *sbi, u64 from, u64 to)
 		update_data_blkaddr(sbi, le32_to_cpu(sum.nid),
 				le16_to_cpu(sum.ofs_in_node), to);
 	else
-		update_nat_blkaddr(sbi, le32_to_cpu(sum.nid), to);
+		update_nat_blkaddr(sbi, 0, le32_to_cpu(sum.nid), to);
 
 	DBG(0, "Migrate %s block %"PRIx64" -> %"PRIx64"\n",
 					IS_DATASEG(type) ? "data" : "node",
diff --git a/fsck/dir.c b/fsck/dir.c
new file mode 100644
index 0000000..18b79bd
--- /dev/null
+++ b/fsck/dir.c
@@ -0,0 +1,584 @@
+/**
+ * dir.c
+ *
+ * Many parts of codes are copied from Linux kernel/fs/f2fs.
+ *
+ * Copyright (C) 2015 Huawei Ltd.
+ * Witten by:
+ *   Hou Pengyang <houpengyang@huawei.com>
+ *   Liu Shuoran <liushuoran@huawei.com>
+ *   Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+#include "node.h"
+
+static unsigned int dir_buckets(unsigned int level)
+{
+	if (level < MAX_DIR_HASH_DEPTH / 2)
+		return 1 << level;
+	else
+		return MAX_DIR_BUCKETS;
+}
+
+static unsigned int bucket_blocks(unsigned int level)
+{
+	if (level < MAX_DIR_HASH_DEPTH / 2)
+		return 2;
+	else
+		return 4;
+}
+
+static unsigned long dir_block_index(unsigned int level,
+		int dir_level, unsigned int idx)
+{
+	unsigned long i;
+	unsigned long bidx = 0;
+
+	for (i = 0; i < level; i++)
+		bidx += dir_buckets(i + dir_level) * bucket_blocks(i);
+	bidx += idx * bucket_blocks(level);
+	return bidx;
+}
+
+static int room_for_filename(const u8 *bitmap, int slots, int max_slots)
+{
+	int bit_start = 0;
+	int zero_start, zero_end;
+next:
+	zero_start = find_next_zero_bit_le(bitmap, max_slots, bit_start);
+	if (zero_start >= max_slots)
+		return max_slots;
+
+	zero_end = find_next_bit_le(bitmap, max_slots, zero_start + 1);
+
+	if (zero_end - zero_start >= slots)
+		return zero_start;
+	bit_start = zero_end;
+	goto next;
+
+}
+
+static void make_dentry_ptr(struct f2fs_dentry_ptr *d, void *src, int type)
+{
+	if (type == 1) {
+		struct f2fs_dentry_block *t = (struct f2fs_dentry_block *)src;
+		d->max = NR_DENTRY_IN_BLOCK;
+		d->bitmap = t->dentry_bitmap;
+		d->dentry = t->dentry;
+		d->filename = t->filename;
+	} else {
+		struct f2fs_inline_dentry *t = (struct f2fs_inline_dentry *)src;
+		d->max = NR_INLINE_DENTRY;
+		d->bitmap = t->dentry_bitmap;
+		d->dentry = t->dentry;
+		d->filename = t->filename;
+	}
+}
+
+static struct f2fs_dir_entry *find_target_dentry(const u8 *name,
+		unsigned int len, f2fs_hash_t namehash, int *max_slots,
+		struct f2fs_dentry_ptr *d)
+{
+	struct f2fs_dir_entry *de;
+	unsigned long bit_pos = 0;
+	int max_len = 0;
+
+	if (max_slots)
+		*max_slots = 0;
+	while (bit_pos < d->max) {
+		if (!test_bit_le(bit_pos, d->bitmap)) {
+			bit_pos++;
+			max_len++;
+			continue;
+		}
+
+		de = &d->dentry[bit_pos];
+		if (le16_to_cpu(de->name_len) == len &&
+			de->hash_code == namehash &&
+			!memcmp(d->filename[bit_pos], name, len)) {
+			goto found;
+		}
+
+		if (max_slots && max_len > *max_slots)
+			*max_slots = max_len;
+		max_len = 0;
+		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
+	}
+	de = NULL;
+found:
+	if (max_slots && max_len > *max_slots)
+		*max_slots = max_len;
+	return de;
+}
+
+static struct f2fs_dir_entry *find_in_block(void *block,
+		const u8 *name, int len, f2fs_hash_t namehash,
+		int *max_slots)
+{
+	struct f2fs_dentry_ptr d;
+
+	make_dentry_ptr(&d, block, 1);
+	return find_target_dentry(name, len, namehash, max_slots, &d);
+}
+
+static int find_in_level(struct f2fs_sb_info *sbi,struct f2fs_node *dir,
+		unsigned int level, struct dentry *de)
+{
+	unsigned int nbucket, nblock;
+	unsigned int bidx, end_block;
+	struct f2fs_dir_entry *dentry = NULL;
+	struct dnode_of_data dn = {0};
+	void *dentry_blk;
+	int max_slots = 214;
+	nid_t ino = dir->footer.ino;
+	f2fs_hash_t namehash;
+	int ret = 0;
+
+	namehash = f2fs_dentry_hash(de->name, de->len);
+
+	nbucket = dir_buckets(level);
+	nblock = bucket_blocks(level);
+
+	bidx = dir_block_index(level, 0, le32_to_cpu(namehash) % nbucket);
+	end_block = bidx + nblock;
+
+	dentry_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(dentry_blk);
+
+	for (; bidx < end_block; bidx++) {
+
+		/* Firstly, we should know direct node of target data blk */
+		if (dn.node_blk && dn.node_blk != dn.inode_blk)
+			free(dn.node_blk);
+
+		set_new_dnode(&dn, dir, NULL, ino);
+		get_dnode_of_data(sbi, &dn, bidx, LOOKUP_NODE);
+		if (dn.data_blkaddr == NULL_ADDR)
+			continue;
+
+		ret = dev_read_block(dentry_blk, dn.data_blkaddr);
+		ASSERT(ret >= 0);
+
+		dentry = find_in_block(dentry_blk, de->name, de->len,
+						namehash, &max_slots);
+		if (dentry) {
+			ret = 1;
+			de->ino = le32_to_cpu(dentry->ino);
+			break;
+		}
+	}
+
+	if (dn.node_blk && dn.node_blk != dn.inode_blk)
+		free(dn.node_blk);
+	free(dentry_blk);
+
+	return ret;
+}
+
+static int f2fs_find_entry(struct f2fs_sb_info *sbi,
+				struct f2fs_node *dir, struct dentry *de)
+{
+	unsigned int max_depth;
+	unsigned int level;
+
+	max_depth = dir->i.i_current_depth;
+	for (level = 0; level < max_depth; level ++) {
+		if (find_in_level(sbi, dir, level, de))
+			return 1;
+	}
+	return 0;
+}
+
+static void f2fs_update_dentry(nid_t ino, umode_t mode,
+		struct f2fs_dentry_ptr *d,
+		const unsigned char *name, int len, f2fs_hash_t name_hash,
+		unsigned int bit_pos)
+{
+	struct f2fs_dir_entry *de;
+	int slots = GET_DENTRY_SLOTS(len);
+	int i;
+
+	de = &d->dentry[bit_pos];
+	de->name_len = len;
+	de->hash_code = name_hash;
+	memcpy(d->filename[bit_pos], name, len);
+	d->filename[bit_pos][len] = 0;
+	de->ino = cpu_to_le32(ino);
+	set_de_type(de, mode);
+	for (i = 0; i < slots; i++)
+		test_and_set_bit_le(bit_pos + i, d->bitmap);
+}
+
+/*
+ * f2fs_add_link - Add a new file(dir) to parent dir.
+ */
+static int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
+			struct f2fs_node *child, block_t p_blkaddr)
+{
+	int level = 0, current_depth, bit_pos;
+	int nbucket, nblock, bidx, block;
+	const unsigned char *name = child->i.i_name;
+	int name_len = le32_to_cpu(child->i.i_namelen);
+	int slots = GET_DENTRY_SLOTS(name_len);
+	f2fs_hash_t dentry_hash = f2fs_dentry_hash(name, name_len);
+	struct f2fs_dentry_block *dentry_blk;
+	struct f2fs_dentry_ptr d;
+	struct dnode_of_data dn = {0};
+	nid_t pino = le32_to_cpu(parent->footer.ino);
+	nid_t ino = le32_to_cpu(child->footer.ino);
+	umode_t mode = le16_to_cpu(child->i.i_mode);
+	int ret;
+
+	if (parent == NULL || child == NULL)
+		return -EINVAL;
+
+	if (!pino) {
+		ERR_MSG("Wrong parent ino:%d \n", pino);
+		return -EINVAL;
+	}
+
+	dentry_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(dentry_blk);
+
+	current_depth = le32_to_cpu(parent->i.i_current_depth);
+start:
+	if (current_depth == MAX_DIR_HASH_DEPTH) {
+		free(dentry_blk);
+		ERR_MSG("\tError: MAX_DIR_HASH\n");
+		return -ENOSPC;
+	}
+
+	/* Need a new dentry block */
+	if (level == current_depth)
+		++current_depth;
+
+	nbucket = dir_buckets(level);
+	nblock = bucket_blocks(level);
+	bidx = dir_block_index(level, 0, le32_to_cpu(dentry_hash) % nbucket);
+
+	for (block = bidx; block <= (bidx + nblock - 1); block++) {
+
+		/* Firstly, we should know the direct node of target data blk */
+		if (dn.node_blk && dn.node_blk != dn.inode_blk)
+			free(dn.node_blk);
+
+		set_new_dnode(&dn, parent, NULL, pino);
+		get_dnode_of_data(sbi, &dn, block, ALLOC_NODE);
+
+		if (dn.data_blkaddr == NULL_ADDR) {
+			new_data_block(sbi, dentry_blk, &dn, CURSEG_HOT_DATA);
+		} else {
+			ret = dev_read_block(dentry_blk, dn.data_blkaddr);
+			ASSERT(ret >= 0);
+		}
+		bit_pos = room_for_filename(dentry_blk->dentry_bitmap,
+				slots, NR_DENTRY_IN_BLOCK);
+
+		if (bit_pos < NR_DENTRY_IN_BLOCK)
+			goto add_dentry;
+	}
+	level ++;
+	goto start;
+
+add_dentry:
+	make_dentry_ptr(&d, (void *)dentry_blk, 1);
+	f2fs_update_dentry(ino, mode, &d, name, name_len, dentry_hash, bit_pos);
+
+	ret = dev_write_block(dentry_blk, dn.data_blkaddr);
+	ASSERT(ret >= 0);
+
+	/*
+	 * Parent inode needs updating, because its inode info may be changed.
+	 * such as i_current_depth and i_blocks.
+	 */
+	if (parent->i.i_current_depth != cpu_to_le32(current_depth)) {
+		parent->i.i_current_depth = cpu_to_le32(current_depth);
+		dn.idirty = 1;
+	}
+
+	/* Update parent's i_links info*/
+	if (S_ISDIR(mode)) {
+		u32 links = le32_to_cpu(parent->i.i_links);
+		parent->i.i_links = cpu_to_le32(links + 1);
+		dn.idirty = 1;
+	}
+
+	if ((block + 1) * F2FS_BLKSIZE > le64_to_cpu(parent->i.i_size)) {
+		parent->i.i_size = cpu_to_le64((block + 1) * F2FS_BLKSIZE);
+		dn.idirty = 1;
+	}
+
+	if (dn.ndirty) {
+		ret = dev_write_block(dn.node_blk, dn.node_blkaddr);
+		ASSERT(ret >= 0);
+	}
+
+	if (dn.idirty) {
+		ASSERT(parent == dn.inode_blk);
+		ret = dev_write_block(dn.inode_blk, p_blkaddr);
+		ASSERT(ret >= 0);
+	}
+
+	if (dn.node_blk != dn.inode_blk)
+		free(dn.node_blk);
+	free(dentry_blk);
+	return 0;
+}
+
+static void make_empty_dir(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
+{
+	struct f2fs_dentry_block *dent_blk;
+	nid_t ino = le32_to_cpu(inode->footer.ino);
+	nid_t pino = le32_to_cpu(inode->i.i_pino);
+	struct f2fs_summary sum;
+	struct node_info ni;
+	block_t blkaddr;
+	int ret;
+
+	get_node_info(sbi, ino, &ni);
+
+	dent_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(dent_blk);
+
+	dent_blk->dentry[0].hash_code = 0;
+	dent_blk->dentry[0].ino = cpu_to_le32(ino);
+	dent_blk->dentry[0].name_len = cpu_to_le16(1);
+	dent_blk->dentry[0].file_type = F2FS_FT_DIR;
+	memcpy(dent_blk->filename[0], ".", 1);
+
+	dent_blk->dentry[1].hash_code = 0;
+	dent_blk->dentry[1].ino = cpu_to_le32(pino);
+	dent_blk->dentry[1].name_len = cpu_to_le16(2);
+	dent_blk->dentry[1].file_type = F2FS_FT_DIR;
+	memcpy(dent_blk->filename[1], "..", 2);
+
+	test_and_set_bit_le(0, dent_blk->dentry_bitmap);
+	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
+
+	set_summary(&sum, ino, 0, ni.version);
+	reserve_new_block(sbi, &blkaddr, &sum, CURSEG_HOT_DATA);
+
+	ret = dev_write_block(dent_blk, blkaddr);
+	ASSERT(ret >= 0);
+
+	inode->i.i_addr[0] = cpu_to_le32(blkaddr);
+	free(dent_blk);
+}
+
+static void page_symlink(struct f2fs_sb_info *sbi, struct f2fs_node *inode,
+					const char *symname, int symlen)
+{
+	nid_t ino = le32_to_cpu(inode->footer.ino);
+	struct f2fs_summary sum;
+	struct node_info ni;
+	char *data_blk;
+	block_t blkaddr;
+	int ret;
+
+	get_node_info(sbi, ino, &ni);
+
+	/* store into inline_data */
+	if (symlen + 1 <= MAX_INLINE_DATA) {
+		inode->i.i_inline |= F2FS_INLINE_DATA;
+		inode->i.i_inline |= F2FS_DATA_EXIST;
+		memcpy(&inode->i.i_addr[1], symname, symlen);
+		return;
+	}
+
+	data_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(data_blk);
+
+	memcpy(data_blk, symname, symlen);
+
+	set_summary(&sum, ino, 0, ni.version);
+	reserve_new_block(sbi, &blkaddr, &sum, CURSEG_WARM_DATA);
+
+	ret = dev_write_block(data_blk, blkaddr);
+	ASSERT(ret >= 0);
+
+	inode->i.i_addr[0] = cpu_to_le32(blkaddr);
+	free(data_blk);
+}
+
+static void init_inode_block(struct f2fs_sb_info *sbi,
+		struct f2fs_node *node_blk, struct dentry *de)
+{
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	mode_t mode = de->mode;
+	int links = 1;
+	unsigned int size;
+	int blocks = 1;
+
+	if (de->file_type == F2FS_FT_DIR) {
+		mode |= S_IFDIR;
+		size = 4096;
+		links++;
+		blocks++;
+	} else if (de->file_type == F2FS_FT_REG_FILE) {
+		mode |= S_IFREG;
+		size = 0;
+	} else if (de->file_type == F2FS_FT_SYMLINK) {
+		ASSERT(de->link);
+		mode |= S_IFLNK;
+		size = strlen(de->link);
+		if (size + 1 > MAX_INLINE_DATA)
+			blocks++;
+	} else {
+		ASSERT(0);
+	}
+
+	node_blk->i.i_mode = cpu_to_le16(mode);
+	node_blk->i.i_advise = 0;
+	node_blk->i.i_uid = cpu_to_le32(de->uid);
+	node_blk->i.i_gid = cpu_to_le32(de->gid);
+	node_blk->i.i_links = cpu_to_le32(links);
+	node_blk->i.i_size = cpu_to_le32(size);
+	node_blk->i.i_blocks = cpu_to_le32(blocks);
+	node_blk->i.i_atime = cpu_to_le64(de->mtime);
+	node_blk->i.i_ctime = cpu_to_le64(de->mtime);
+	node_blk->i.i_mtime = cpu_to_le64(de->mtime);
+	node_blk->i.i_atime_nsec = 0;
+	node_blk->i.i_ctime_nsec = 0;
+	node_blk->i.i_mtime_nsec = 0;
+	node_blk->i.i_generation = 0;
+	node_blk->i.i_current_depth = cpu_to_le32(1);
+	node_blk->i.i_xattr_nid = 0;
+	node_blk->i.i_flags = 0;
+	node_blk->i.i_inline = F2FS_INLINE_XATTR;
+	node_blk->i.i_pino = cpu_to_le32(de->pino);
+	node_blk->i.i_namelen = cpu_to_le32(de->len);
+	memcpy(node_blk->i.i_name, de->name, de->len);
+	node_blk->i.i_name[de->len] = 0;
+
+	node_blk->footer.ino = cpu_to_le32(de->ino);
+	node_blk->footer.nid = cpu_to_le32(de->ino);
+	node_blk->footer.flag = 0;
+	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+
+	if (S_ISDIR(mode))
+		make_empty_dir(sbi, node_blk);
+	else if (S_ISLNK(mode))
+		page_symlink(sbi, node_blk, de->link, size);
+}
+
+int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
+{
+	struct f2fs_node *parent, *child;
+	struct node_info ni;
+	struct f2fs_summary sum;
+	block_t blkaddr;
+	int ret;
+
+	/* Find if there is a */
+	get_node_info(sbi, de->pino, &ni);
+	if (ni.blk_addr == NULL_ADDR) {
+		MSG(0, "No parent directory pino=%x\n", de->pino);
+		return -1;
+	}
+
+	parent = calloc(BLOCK_SZ, 1);
+	ASSERT(parent);
+
+	ret = dev_read_block(parent, ni.blk_addr);
+	ASSERT(ret >= 0);
+
+	ret = f2fs_find_entry(sbi, parent, de);
+	if (ret) {
+		MSG(0, "Skip the existing \"%s\" pino=%x ERR=%d\n",
+					de->name, de->pino, ret);
+		if (de->file_type == F2FS_FT_REG_FILE)
+			de->ino = 0;
+		goto free_parent_dir;
+	}
+
+	child = calloc(BLOCK_SZ, 1);
+	ASSERT(child);
+
+	f2fs_alloc_nid(sbi, &de->ino, 1);
+
+	init_inode_block(sbi, child, de);
+
+	ret = f2fs_add_link(sbi, parent, child, ni.blk_addr);
+	if (ret) {
+		MSG(0, "Skip the existing \"%s\" pino=%x ERR=%d\n",
+					de->name, de->pino, ret);
+		goto free_child_dir;
+	}
+
+	/* write child */
+	set_summary(&sum, de->ino, 0, ni.version);
+	reserve_new_block(sbi, &blkaddr, &sum, CURSEG_HOT_NODE);
+
+	/* update nat info */
+	update_nat_blkaddr(sbi, de->ino, de->ino, blkaddr);
+
+	ret = dev_write_block(child, blkaddr);
+	ASSERT(ret >= 0);
+
+	update_free_segments(sbi);
+	MSG(1, "Info: Create \"%s\" type=%x, ino=%x / %x into \"%s\"\n",
+			de->full_path, de->file_type,
+			de->ino, de->pino, de->path);
+free_child_dir:
+	free(child);
+free_parent_dir:
+	free(parent);
+	return 0;
+}
+
+int f2fs_mkdir(struct f2fs_sb_info *sbi, struct dentry *de)
+{
+	return f2fs_create(sbi, de);
+}
+
+int f2fs_symlink(struct f2fs_sb_info *sbi, struct dentry *de)
+{
+	return f2fs_create(sbi, de);
+}
+
+int f2fs_find_path(struct f2fs_sb_info *sbi, char *path, nid_t *ino)
+{
+	struct f2fs_node *parent;
+	struct node_info ni;
+	struct dentry de;
+	int err = 0;
+	int ret;
+	char *p;
+
+	if (path[0] != '/')
+		return -ENOENT;
+
+	*ino = F2FS_ROOT_INO(sbi);
+	parent = calloc(BLOCK_SZ, 1);
+	ASSERT(parent);
+
+	p = strtok(path, "/");
+	while (p) {
+		de.name = (const u8 *)p;
+		de.len = strlen(p);
+
+		get_node_info(sbi, *ino, &ni);
+		if (ni.blk_addr == NULL_ADDR) {
+			err = -ENOENT;
+			goto err;
+		}
+		ret = dev_read_block(parent, ni.blk_addr);
+		ASSERT(ret >= 0);
+
+		ret = f2fs_find_entry(sbi, parent, &de);
+		if (!ret) {
+			err = -ENOENT;
+			goto err;
+		}
+
+		*ino = de.ino;
+		p = strtok(NULL, "/");
+	}
+err:
+	free(parent);
+	return err;
+}
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 4b3c666..39ff161 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -60,6 +60,7 @@ struct f2fs_nm_info {
 
 	char *nat_bitmap;
 	int bitmap_size;
+	char *nid_bitmap;
 };
 
 struct seg_entry {
@@ -124,6 +125,44 @@ struct f2fs_sm_info {
 	unsigned int ovp_segments;
 };
 
+struct f2fs_dentry_ptr {
+	struct inode *inode;
+	u8 *bitmap;
+	struct f2fs_dir_entry *dentry;
+	__u8 (*filename)[F2FS_SLOT_LEN];
+	int max;
+};
+
+struct dentry {
+	char *path;
+	char *full_path;
+	const u8 *name;
+	int len;
+	char *link;
+	unsigned long size;
+	u8 file_type;
+	u16 mode;
+	u16 uid;
+	u16 gid;
+	u32 *inode;
+	u32 mtime;
+	char *secon;
+	uint64_t capabilities;
+	nid_t ino;
+	nid_t pino;
+};
+
+/* different from dnode_of_data in kernel */
+struct dnode_of_data {
+	struct f2fs_node *inode_blk;	/* inode page */
+	struct f2fs_node *node_blk;	/* cached direct node page */
+	nid_t nid;
+	unsigned int ofs_in_node;
+	block_t data_blkaddr;
+	block_t node_blkaddr;
+	int idirty, ndirty;
+};
+
 struct f2fs_sb_info {
 	struct f2fs_fsck *fsck;
 
@@ -160,6 +199,7 @@ struct f2fs_sb_info {
 	u32 s_next_generation;                  /* for NFS support */
 
 	unsigned int cur_victim_sec;            /* current victim section num */
+	u32 free_segments;
 };
 
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
@@ -313,7 +353,6 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 		- (base + 1) + type;
 }
 
-
 #define nats_in_cursum(jnl)             (le16_to_cpu(jnl->n_nats))
 #define sits_in_cursum(jnl)             (le16_to_cpu(jnl->n_sits))
 
@@ -397,6 +436,42 @@ static inline void node_info_from_raw_nat(struct node_info *ni,
 	ni->version = raw_nat->version;
 }
 
+static inline void set_summary(struct f2fs_summary *sum, nid_t nid,
+			unsigned int ofs_in_node, unsigned char version)
+{
+	sum->nid = cpu_to_le32(nid);
+	sum->ofs_in_node = cpu_to_le16(ofs_in_node);
+	sum->version = version;
+}
+
+#define S_SHIFT 12
+static unsigned char f2fs_type_by_mode[S_IFMT >> S_SHIFT] = {
+	[S_IFREG >> S_SHIFT]    = F2FS_FT_REG_FILE,
+	[S_IFDIR >> S_SHIFT]    = F2FS_FT_DIR,
+	[S_IFCHR >> S_SHIFT]    = F2FS_FT_CHRDEV,
+	[S_IFBLK >> S_SHIFT]    = F2FS_FT_BLKDEV,
+	[S_IFIFO >> S_SHIFT]    = F2FS_FT_FIFO,
+	[S_IFSOCK >> S_SHIFT]   = F2FS_FT_SOCK,
+	[S_IFLNK >> S_SHIFT]    = F2FS_FT_SYMLINK,
+};
+
+static inline void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
+{
+	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
+}
+
+static inline void *inline_xattr_addr(struct f2fs_inode *inode)
+{
+	return (void *)&(inode->i_addr[DEF_ADDRS_PER_INODE_INLINE_XATTR]);
+}
+
+static inline int inline_xattr_size(struct f2fs_inode *inode)
+{
+	if (inode->i_inline & F2FS_INLINE_XATTR)
+		return F2FS_INLINE_XATTR_ADDRS << 2;
+	return 0;
+}
+
 extern int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_nat_entry *ne);
 #define IS_SUM_NODE_SEG(footer)		(footer.entry_type == SUM_TYPE_NODE)
 #define IS_SUM_DATA_SEG(footer)		(footer.entry_type == SUM_TYPE_DATA)
diff --git a/fsck/fsck.h b/fsck/fsck.h
index db11b41..b0481d1 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -108,6 +108,8 @@ enum seg_type {
 	SEG_TYPE_MAX,
 };
 
+struct selabel_handle;
+
 extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
 		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *,
@@ -129,6 +131,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 		struct child_info *);
 int fsck_chk_meta(struct f2fs_sb_info *sbi);
 
+extern void update_free_segments(struct f2fs_sb_info *);
 void print_cp_state(u32);
 extern void print_node_info(struct f2fs_node *);
 extern void print_inode_info(struct f2fs_inode *, int);
@@ -157,7 +160,7 @@ extern void write_curseg_info(struct f2fs_sb_info *);
 extern int find_next_free_block(struct f2fs_sb_info *, u64 *, int, int);
 extern void write_checkpoint(struct f2fs_sb_info *);
 extern void update_data_blkaddr(struct f2fs_sb_info *, nid_t, u16, block_t);
-extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, block_t);
+extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, nid_t, block_t);
 
 extern void print_raw_sb_info(struct f2fs_super_block *);
 
@@ -181,4 +184,25 @@ int f2fs_defragment(struct f2fs_sb_info *, u64, u64, u64, int);
 
 /* resize.c */
 int f2fs_resize(struct f2fs_sb_info *);
+
+/* sload.c */
+int f2fs_sload(struct f2fs_sb_info *, const char *, const char *,
+		const char *, struct selabel_handle *);
+void reserve_new_block(struct f2fs_sb_info *, block_t *,
+					struct f2fs_summary *, int);
+void new_data_block(struct f2fs_sb_info *, void *,
+					struct dnode_of_data *, int);
+int f2fs_build_file(struct f2fs_sb_info *, struct dentry *);
+void f2fs_alloc_nid(struct f2fs_sb_info *, nid_t *, int);
+void set_data_blkaddr(struct dnode_of_data *);
+block_t new_node_block(struct f2fs_sb_info *,
+					struct dnode_of_data *, unsigned int);
+void get_dnode_of_data(struct f2fs_sb_info *, struct dnode_of_data *,
+					pgoff_t, int);
+int f2fs_create(struct f2fs_sb_info *, struct dentry *);
+int f2fs_mkdir(struct f2fs_sb_info *, struct dentry *);
+int f2fs_symlink(struct f2fs_sb_info *, struct dentry *);
+int inode_set_selinux(struct f2fs_sb_info *, u32, const char *);
+int f2fs_find_path(struct f2fs_sb_info *, char *, nid_t *);
+
 #endif /* _FSCK_H_ */
diff --git a/fsck/main.c b/fsck/main.c
index 885e2cf..cf670ed 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -5,6 +5,11 @@
  *             http://www.samsung.com/
  * Copyright (c) 2015 Jaegeuk Kim <jaegeuk@kernel.org>
  *  : implement defrag.f2fs
+ * Copyright (C) 2015 Huawei Ltd.
+ *   Hou Pengyang <houpengyang@huawei.com>
+ *   Liu Shuoran <liushuoran@huawei.com>
+ *   Jaegeuk Kim <jaegeuk@kernel.org>
+ *  : add sload.f2fs
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -61,6 +66,16 @@ void resize_usage()
 	exit(1);
 }
 
+void sload_usage()
+{
+	MSG(0, "\nUsage: sload.f2fs [options] device\n");
+	MSG(0, "[options]:\n");
+	MSG(0, "  -f source directory [path of the source directory]\n");
+	MSG(0, "  -t mount point [prefix of target fs path, default:/]\n");
+	MSG(0, "  -d debug level [default:0]\n");
+	exit(1);
+}
+
 void f2fs_parse_options(int argc, char *argv[])
 {
 	int option = 0;
@@ -240,6 +255,29 @@ void f2fs_parse_options(int argc, char *argv[])
 			}
 			ASSERT(ret >= 0);
 		}
+	} else if (!strcmp("sload.f2fs", prog)) {
+		const char *option_string = "d:f:t:";
+
+		config.func = SLOAD;
+		while ((option = getopt(argc, argv, option_string)) != EOF) {
+			switch (option) {
+			case 'd':
+				config.dbg_lv = atoi(optarg);
+				MSG(0, "Info: Debug level = %d\n",
+						config.dbg_lv);
+				break;
+			case 'f':
+				config.from_dir = (char *)optarg;
+				break;
+			case 't':
+				config.mount_point = (char *)optarg;
+				break;
+			default:
+				MSG(0, "\tError: Unknown option %c\n", option);
+				sload_usage();
+				break;
+			}
+		}
 	}
 
 	if ((optind + 1) != argc) {
@@ -252,6 +290,8 @@ void f2fs_parse_options(int argc, char *argv[])
 			defrag_usage();
 		else if (config.func == RESIZE)
 			resize_usage();
+		else if (config.func == SLOAD)
+			sload_usage();
 	}
 	config.device_name = argv[optind];
 }
@@ -405,6 +445,19 @@ static int do_resize(struct f2fs_sb_info *sbi)
 	return f2fs_resize(sbi);
 }
 
+static int do_sload(struct f2fs_sb_info *sbi)
+{
+	if (!config.from_dir) {
+		MSG(0, "\tError: Need source directory\n");
+		sload_usage();
+		return -1;
+	}
+	if (!config.mount_point)
+		config.mount_point = "/";
+
+	return f2fs_sload(sbi, config.from_dir, config.mount_point, NULL, NULL);
+}
+
 int main(int argc, char **argv)
 {
 	struct f2fs_sb_info *sbi;
@@ -459,6 +512,9 @@ fsck_again:
 		if (do_resize(sbi))
 			goto out_err;
 		break;
+	case SLOAD:
+		do_sload(sbi);
+		break;
 	}
 
 	f2fs_do_umount(sbi);
diff --git a/fsck/mount.c b/fsck/mount.c
index 67c681e..4bde179 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -25,6 +25,16 @@ static u32 get_free_segments(struct f2fs_sb_info *sbi)
 	return free_segs;
 }
 
+void update_free_segments(struct f2fs_sb_info *sbi)
+{
+	char *progress = "-*|*-";
+	static int i = 0;
+
+	MSG(0, "\r [ %c ] Free segments: 0x%x", progress[i % 5], get_free_segments(sbi));
+	fflush(stdout);
+	i++;
+}
+
 void print_inode_info(struct f2fs_inode *inode, int name)
 {
 	unsigned int i = 0;
@@ -624,6 +634,74 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+static pgoff_t current_nat_addr(struct f2fs_sb_info *sbi, nid_t start)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	pgoff_t block_off;
+	pgoff_t block_addr;
+	int seg_off;
+
+	block_off = NAT_BLOCK_OFFSET(start);
+	seg_off = block_off >> sbi->log_blocks_per_seg;
+
+	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
+			(seg_off << sbi->log_blocks_per_seg << 1) +
+			(block_off & ((1 << sbi->log_blocks_per_seg) -1)));
+
+	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
+		block_addr += sbi->blocks_per_seg;
+
+	return block_addr;
+}
+
+static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	int nid_bitmap_size = (nm_i->max_nid + BITS_PER_BYTE - 1) / BITS_PER_BYTE;
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
+	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &sum->journal;
+	struct f2fs_nat_block nat_block;
+	block_t start_blk;
+	nid_t nid;
+	int i;
+
+	if (!(config.func == SLOAD))
+		return 0;
+
+	nm_i->nid_bitmap = (char *)calloc(nid_bitmap_size, 1);
+	if (!nm_i->nid_bitmap)
+		return -ENOMEM;
+
+	/* arbitrarily set 0 bit */
+	f2fs_set_bit(0, nm_i->nid_bitmap);
+
+	memset((void *)&nat_block, 0, sizeof(struct f2fs_nat_block));
+
+	for (nid = 0; nid < nm_i->max_nid; nid++) {
+		if (!(nid % NAT_ENTRY_PER_BLOCK)) {
+			int ret;
+
+			start_blk = current_nat_addr(sbi, nid);
+			ret = dev_read_block((void *)&nat_block, start_blk);
+			ASSERT(ret >= 0);
+		}
+
+		if (nat_block.entries[nid % NAT_ENTRY_PER_BLOCK].block_addr)
+			f2fs_set_bit(nid, nm_i->nid_bitmap);
+	}
+
+	for (i = 0; i < nats_in_cursum(journal); i++) {
+		block_t addr;
+
+		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
+		nid = le32_to_cpu(nid_in_journal(journal, i));
+		if (addr != NULL_ADDR)
+			f2fs_set_bit(nid, nm_i->nid_bitmap);
+	}
+	return 0;
+}
+
 int init_node_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
@@ -654,7 +732,7 @@ int init_node_manager(struct f2fs_sb_info *sbi)
 
 	/* copy version bitmap */
 	memcpy(nm_i->nat_bitmap, version_bitmap, nm_i->bitmap_size);
-	return 0;
+	return f2fs_init_nid_bitmap(sbi);
 }
 
 int build_node_manager(struct f2fs_sb_info *sbi)
@@ -1171,7 +1249,8 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
 	free(node_blk);
 }
 
-void update_nat_blkaddr(struct f2fs_sb_info *sbi, nid_t nid, block_t newaddr)
+void update_nat_blkaddr(struct f2fs_sb_info *sbi, nid_t ino,
+					nid_t nid, block_t newaddr)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
@@ -1196,6 +1275,8 @@ void update_nat_blkaddr(struct f2fs_sb_info *sbi, nid_t nid, block_t newaddr)
 	ret = dev_read_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
 
+	if (ino)
+		nat_block->entries[entry_off].ino = cpu_to_le32(ino);
 	nat_block->entries[entry_off].block_addr = cpu_to_le32(newaddr);
 
 	ret = dev_write_block(nat_block, block_addr);
@@ -1567,7 +1648,7 @@ void move_curseg_info(struct f2fs_sb_info *sbi, u64 from)
 		/* update se->types */
 		reset_curseg(sbi, i);
 
-		DBG(0, "Move curseg[%d] %x -> %x after %"PRIx64"\n",
+		DBG(1, "Move curseg[%d] %x -> %x after %"PRIx64"\n",
 				i, old_segno, curseg->segno, from);
 	}
 }
@@ -1682,6 +1763,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	set_cp(ckpt_flags, flags);
 
 	set_cp(free_segment_count, get_free_segments(sbi));
+	set_cp(valid_block_count, sbi->total_valid_block_count);
 	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
 
 	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
@@ -1915,6 +1997,8 @@ void f2fs_do_umount(struct f2fs_sb_info *sbi)
 	unsigned int i;
 
 	/* free nm_info */
+	if (config.func == SLOAD)
+		free(nm_i->nid_bitmap);
 	free(nm_i->nat_bitmap);
 	free(sbi->nm_info);
 
diff --git a/fsck/node.c b/fsck/node.c
new file mode 100644
index 0000000..c2f83b8
--- /dev/null
+++ b/fsck/node.c
@@ -0,0 +1,250 @@
+/**
+ * node.c
+ *
+ * Many parts of codes are copied from Linux kernel/fs/f2fs.
+ *
+ * Copyright (C) 2015 Huawei Ltd.
+ * Witten by:
+ *   Hou Pengyang <houpengyang@huawei.com>
+ *   Liu Shuoran <liushuoran@huawei.com>
+ *   Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+#include "node.h"
+
+void f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid, int inode)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	nid_t i, inode_cnt, node_cnt;
+
+	for (i = 0; i < nm_i->max_nid; i++)
+		if(f2fs_test_bit(i, nm_i->nid_bitmap) == 0)
+			break;
+
+	ASSERT(i < nm_i->max_nid);
+	f2fs_set_bit(i, nm_i->nid_bitmap);
+	*nid = i;
+
+	inode_cnt = get_cp(valid_inode_count);
+	node_cnt = get_cp(valid_node_count);
+	if (inode)
+		set_cp(valid_inode_count, inode_cnt + 1);
+	set_cp(valid_node_count, node_cnt + 1);
+}
+
+void set_data_blkaddr(struct dnode_of_data *dn)
+{
+	__le32 *addr_array;
+	struct f2fs_node *node_blk = dn->node_blk;
+	unsigned int ofs_in_node = dn->ofs_in_node;
+
+	addr_array = blkaddr_in_node(node_blk);
+	addr_array[ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
+	if (dn->node_blk != dn->inode_blk)
+		dn->ndirty = 1;
+	else
+		dn->idirty = 1;
+}
+
+/*
+ * In this function, we get a new node blk, and write back
+ * node_blk would be sloadd in RAM, linked by dn->node_blk
+ */
+block_t new_node_block(struct f2fs_sb_info *sbi,
+				struct dnode_of_data *dn, unsigned int ofs)
+{
+	struct f2fs_node *f2fs_inode;
+	struct f2fs_node *node_blk;
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_summary sum;
+	struct node_info ni;
+	block_t blkaddr;
+	int type;
+
+	f2fs_inode = dn->inode_blk;
+
+	node_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk);
+
+	node_blk->footer.nid = cpu_to_le32(dn->nid);
+	node_blk->footer.ino = f2fs_inode->footer.ino;
+	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
+	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+
+	type = CURSEG_COLD_NODE;
+	if (IS_DNODE(node_blk)) {
+		if (S_ISDIR(f2fs_inode->i.i_mode))
+			type = CURSEG_HOT_NODE;
+		else
+			type = CURSEG_WARM_NODE;
+	}
+
+	get_node_info(sbi, dn->nid, &ni);
+	set_summary(&sum, dn->nid, 0, ni.version);
+	reserve_new_block(sbi, &blkaddr, &sum, type);
+
+	/* update nat info */
+	update_nat_blkaddr(sbi, le32_to_cpu(f2fs_inode->footer.ino),
+						dn->nid, blkaddr);
+
+	dn->node_blk = node_blk;
+	inc_inode_blocks(dn);
+	return blkaddr;
+}
+
+/*
+ * get_node_path - Get the index path of pgoff_t block
+ * @offset: offset in the current index node block.
+ * @noffset: NO. of the index block within a file.
+ * return: depth of the index path.
+ *
+ * By default, it sets inline_xattr and inline_data
+ */
+static int get_node_path(unsigned long block,
+				int offset[4], unsigned int noffset[4])
+{
+	const long direct_index = DEF_ADDRS_PER_INODE_INLINE_XATTR;
+	const long direct_blks = ADDRS_PER_BLOCK;
+	const long dptrs_per_blk = NIDS_PER_BLOCK;
+	const long indirect_blks = ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
+	const long dindirect_blks = indirect_blks * NIDS_PER_BLOCK;
+	int n = 0;
+	int level = 0;
+
+	noffset[0] = 0;
+	if (block < direct_index) {
+		offset[n] = block;
+		goto got;
+	}
+
+	block -= direct_index;
+	if (block < direct_blks) {
+		offset[n++] = NODE_DIR1_BLOCK;
+		noffset[n]= 1;
+		offset[n] = block;
+		level = 1;
+		goto got;
+	}
+	block -= direct_blks;
+	if (block < direct_blks) {
+		offset[n++] = NODE_DIR2_BLOCK;
+		noffset[n] = 2;
+		offset[n] = block;
+		level = 1;
+		goto got;
+	}
+	block -= direct_blks;
+	if (block < indirect_blks) {
+		offset[n++] = NODE_IND1_BLOCK;
+		noffset[n] = 3;
+		offset[n++] = block / direct_blks;
+		noffset[n] = 4 + offset[n - 1];
+		offset[n] = block % direct_blks;
+		level = 2;
+		goto got;
+	}
+	block -= indirect_blks;
+	if (block < indirect_blks) {
+		offset[n++] = NODE_IND2_BLOCK;
+		noffset[n] = 4 + dptrs_per_blk;
+		offset[n++] = block / direct_blks;
+		noffset[n] = 5 + dptrs_per_blk + offset[n - 1];
+		offset[n] = block % direct_blks;
+		level = 2;
+		goto got;
+	}
+	block -= indirect_blks;
+	if (block < dindirect_blks) {
+		offset[n++] = NODE_DIND_BLOCK;
+		noffset[n] = 5 + (dptrs_per_blk * 2);
+		offset[n++] = block / indirect_blks;
+		noffset[n] = 6 + (dptrs_per_blk * 2) +
+			offset[n - 1] * (dptrs_per_blk + 1);
+		offset[n++] = (block / direct_blks) % dptrs_per_blk;
+		noffset[n] = 7 + (dptrs_per_blk * 2) +
+			offset[n - 2] * (dptrs_per_blk + 1) +
+			offset[n - 1];
+		offset[n] = block % direct_blks;
+		level = 3;
+		goto got;
+	} else {
+		ASSERT(0);
+	}
+got:
+	return level;
+}
+
+void get_dnode_of_data(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
+						pgoff_t index, int mode)
+{
+	int offset[4];
+	unsigned int noffset[4];
+	struct f2fs_node *parent = NULL;
+	nid_t nids[4];
+	block_t nblk[4];
+	struct node_info ni;
+	int level, i;
+	int ret;
+
+	level = get_node_path(index, offset, noffset);
+
+	nids[0] = dn->nid;
+	parent = dn->inode_blk;
+	if (level != 0)
+		nids[1] = get_nid(parent, offset[0], 1);
+	else
+		dn->node_blk = dn->inode_blk;
+
+	get_node_info(sbi, nids[0], &ni);
+	nblk[0] = ni.blk_addr;
+
+	for (i = 1; i <= level; i++) {
+		if (!nids[i] && mode == ALLOC_NODE) {
+			f2fs_alloc_nid(sbi, &nids[i], 0);
+
+			dn->nid = nids[i];
+
+			/* Function new_node_blk get a new f2fs_node blk and update*/
+			/* We should make sure that dn->node_blk == NULL*/
+			nblk[i] = new_node_block(sbi, dn, noffset[i]);
+			ASSERT(nblk[i]);
+
+			set_nid(parent, offset[i - 1], nids[i], i == 1);
+		} else {
+			/* If Sparse file no read API, */
+			struct node_info ni;
+
+			get_node_info(sbi, nids[i], &ni);
+			dn->node_blk = calloc(BLOCK_SZ, 1);
+			ASSERT(dn->node_blk);
+
+			ret = dev_read_block(dn->node_blk, ni.blk_addr);
+			ASSERT(ret >= 0);
+
+			nblk[i] = ni.blk_addr;
+		}
+
+		if (mode == ALLOC_NODE){
+			/* Parent node may have changed */
+			ret = dev_write_block(parent, nblk[i - 1]);
+			ASSERT(ret >= 0);
+		}
+		if (i != 1)
+			free(parent);
+
+		if (i < level) {
+			parent = dn->node_blk;
+			nids[i + 1] = get_nid(parent, offset[i], 0);
+		}
+	}
+
+	dn->nid = nids[level];
+	dn->ofs_in_node = offset[level];
+	dn->data_blkaddr = datablock_addr(dn->node_blk, dn->ofs_in_node);
+	dn->node_blkaddr = nblk[level];
+}
diff --git a/fsck/node.h b/fsck/node.h
new file mode 100644
index 0000000..721e5b7
--- /dev/null
+++ b/fsck/node.h
@@ -0,0 +1,101 @@
+/**
+ * node.h
+ *
+ * Many parts of codes are copied from Linux kernel/fs/f2fs.
+ *
+ * Copyright (C) 2015 Huawei Ltd.
+ * Witten by:
+ *   Hou Pengyang <houpengyang@huawei.com>
+ *   Liu Shuoran <liushuoran@huawei.com>
+ *   Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _NODE_H_
+#define _NODE_H_
+
+#include "fsck.h"
+
+#define ADDRS_PER_PAGE(page) \
+	(IS_INODE(page) ? ADDRS_PER_INODE(&page->i) : ADDRS_PER_BLOCK)
+
+static inline int IS_INODE(struct f2fs_node *node)
+{
+	return ((node)->footer.nid == (node)->footer.ino);
+}
+
+static inline __le32 *blkaddr_in_node(struct f2fs_node *node)
+{
+	return IS_INODE(node) ? node->i.i_addr : node->dn.addr;
+}
+
+static inline block_t datablock_addr(struct f2fs_node *node_page,
+					unsigned int offset)
+{
+	__le32 *addr_array;
+
+	ASSERT(node_page);
+	addr_array = blkaddr_in_node(node_page);
+	return le32_to_cpu(addr_array[offset]);
+}
+
+static inline void set_nid(struct f2fs_node * rn, int off, nid_t nid, int i)
+{
+	if (i)
+		rn->i.i_nid[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
+	else
+		rn->in.nid[off] = cpu_to_le32(nid);
+}
+
+static inline nid_t get_nid(struct f2fs_node * rn, int off, int i)
+{
+	if (i)
+		return le32_to_cpu(rn->i.i_nid[off - NODE_DIR1_BLOCK]);
+	else
+		return le32_to_cpu(rn->in.nid[off]);
+}
+
+enum {
+	ALLOC_NODE,	/* allocate a new node page if needed */
+	LOOKUP_NODE,	/* lookup up a node without readahead */
+	LOOKUP_NODE_RA,
+};
+
+static inline void set_new_dnode(struct dnode_of_data *dn,
+		struct f2fs_node *iblk, struct f2fs_node *nblk, nid_t nid)
+{
+	memset(dn, 0, sizeof(*dn));
+	dn->inode_blk = iblk;
+	dn->node_blk = nblk;
+	dn->nid = nid;
+	dn->idirty = 0;
+	dn->ndirty = 0;
+}
+
+static inline void inc_inode_blocks(struct dnode_of_data *dn)
+{
+	u64 blocks = le64_to_cpu(dn->inode_blk->i.i_blocks);
+
+	dn->inode_blk->i.i_blocks = cpu_to_le64(blocks + 1);
+	dn->idirty = 1;
+}
+
+static inline int IS_DNODE(struct f2fs_node *node_page)
+{
+	unsigned int ofs = ofs_of_node(node_page);
+
+	if (ofs == 3 || ofs == 4 + NIDS_PER_BLOCK ||
+			ofs == 5 + 2 * NIDS_PER_BLOCK)
+		return 0;
+
+	if (ofs >= 6 + 2 * NIDS_PER_BLOCK) {
+		ofs -= 6 + 2 * NIDS_PER_BLOCK;
+		if (!((long int)ofs % (NIDS_PER_BLOCK + 1)))
+			return 0;
+	}
+	return 1;
+}
+
+#endif
diff --git a/fsck/segment.c b/fsck/segment.c
new file mode 100644
index 0000000..9ce8bf5
--- /dev/null
+++ b/fsck/segment.c
@@ -0,0 +1,220 @@
+/**
+ * segment.c
+ *
+ * Many parts of codes are copied from Linux kernel/fs/f2fs.
+ *
+ * Copyright (C) 2015 Huawei Ltd.
+ * Witten by:
+ *   Hou Pengyang <houpengyang@huawei.com>
+ *   Liu Shuoran <liushuoran@huawei.com>
+ *   Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+#include "node.h"
+
+void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
+			struct f2fs_summary *sum, int type)
+{
+	struct seg_entry *se;
+	u64 blkaddr;
+	u64 offset;
+
+	blkaddr = SM_I(sbi)->main_blkaddr;
+
+	if (find_next_free_block(sbi, &blkaddr, 0, type)) {
+		ERR_MSG("Not enough space to allocate blocks");
+		ASSERT(0);
+	}
+
+	se = get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr));
+	offset = OFFSET_IN_SEG(sbi, blkaddr);
+	se->type = type;
+	se->valid_blocks++;
+	f2fs_set_bit(offset, (char *)se->cur_valid_map);
+	sbi->total_valid_block_count++;
+	se->dirty = 1;
+
+	/* read/write SSA */
+	*to = (block_t)blkaddr;
+	update_sum_entry(sbi, *to, sum);
+}
+
+void new_data_block(struct f2fs_sb_info *sbi, void *block,
+				struct dnode_of_data *dn, int type)
+{
+	struct f2fs_summary sum;
+	struct node_info ni;
+
+	ASSERT(dn->node_blk);
+	memset(block, 0, BLOCK_SZ);
+
+	get_node_info(sbi, dn->nid, &ni);
+	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
+	reserve_new_block(sbi, &dn->data_blkaddr, &sum, type);
+
+	inc_inode_blocks(dn);
+	set_data_blkaddr(dn);
+}
+
+static void f2fs_write_block(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
+					u64 count, pgoff_t offset)
+{
+	u64 start = F2FS_BYTES_TO_BLK(offset);
+	u64 len = F2FS_BYTES_TO_BLK(count);
+	u64 end_offset;
+	u64 off_in_block, len_in_block, len_already;
+	struct dnode_of_data dn = {0};
+	void *data_blk;
+	struct node_info ni;
+	struct f2fs_node *inode;
+	int ret = -1;
+
+	get_node_info(sbi, ino, &ni);
+	inode = calloc(BLOCK_SZ, 1);
+	ASSERT(inode);
+
+	ret = dev_read_block(inode, ni.blk_addr);
+	ASSERT(ret >= 0);
+
+	if (S_ISDIR(inode->i.i_mode) || S_ISLNK(inode->i.i_mode))
+		ASSERT(0);
+
+	off_in_block = offset & ((1 << F2FS_BLKSIZE_BITS) - 1);
+	len_in_block = (1 << F2FS_BLKSIZE_BITS) - off_in_block;
+	len_already = 0;
+
+	/*
+	 * When calculate how many blocks this 'count' stride accross,
+	 * We should take offset in a block in account.
+	 */
+	len = F2FS_BYTES_TO_BLK(count + off_in_block
+			+ ((1 << F2FS_BLKSIZE_BITS) - 1));
+
+	data_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(data_blk);
+
+	set_new_dnode(&dn, inode, NULL, ino);
+
+	while (len) {
+		if (dn.node_blk != dn.inode_blk)
+			free(dn.node_blk);
+
+		set_new_dnode(&dn, inode, NULL, ino);
+		get_dnode_of_data(sbi, &dn, start, ALLOC_NODE);
+
+		end_offset = ADDRS_PER_PAGE(dn.node_blk);
+
+		while (dn.ofs_in_node < end_offset && len) {
+			block_t blkaddr;
+
+			blkaddr = datablock_addr(dn.node_blk, dn.ofs_in_node);
+
+			/* A new page from WARM_DATA */
+			if (blkaddr == NULL_ADDR)
+				new_data_block(sbi, data_blk, &dn,
+							CURSEG_WARM_DATA);
+
+			/* Copy data from buffer to file */
+			ret = dev_read_block(data_blk, dn.data_blkaddr);
+			ASSERT(ret >= 0);
+
+			memcpy(data_blk + off_in_block, buffer, len_in_block);
+
+			ret = dev_write_block(data_blk, dn.data_blkaddr);
+			ASSERT(ret >= 0);
+
+			off_in_block = 0;
+			len_already += len_in_block;
+			if ((count - len_already) > (1 << F2FS_BLKSIZE_BITS))
+				len_in_block = 1 << F2FS_BLKSIZE_BITS;
+			else
+				len_in_block = count - len_already;
+			len--;
+			start++;
+			dn.ofs_in_node++;
+		}
+		/* Update the direct node */
+		if (dn.ndirty) {
+			ret = dev_write_block(dn.node_blk, dn.node_blkaddr);
+			ASSERT(ret >= 0);
+		}
+	}
+
+	/* Update the inode info */
+	if (le64_to_cpu(inode->i.i_size) < offset + count) {
+		inode->i.i_size = cpu_to_le64(offset + count);
+		dn.idirty = 1;
+	}
+
+	if (dn.idirty) {
+		ASSERT(inode == dn.inode_blk);
+		ret = dev_write_block(inode, ni.blk_addr);
+		ASSERT(ret >= 0);
+	}
+
+	if (dn.node_blk && dn.node_blk != dn.inode_blk)
+		free(dn.node_blk);
+	free(data_blk);
+	free(inode);
+}
+
+int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
+{
+	int fd, n;
+	pgoff_t off = 0;
+	char buffer[BLOCK_SZ];
+
+	if (de->ino == 0)
+		return -1;
+
+	fd = open(de->full_path, O_RDONLY);
+	if (fd < 0) {
+		MSG(0, "Skip: Fail to open %s\n", de->full_path);
+		return -1;
+	}
+
+	/* inline_data support */
+	if (de->size <= MAX_INLINE_DATA) {
+		struct node_info ni;
+		struct f2fs_node *node_blk;
+		int ret;
+
+		get_node_info(sbi, de->ino, &ni);
+
+		node_blk = calloc(BLOCK_SZ, 1);
+		ASSERT(node_blk);
+
+		ret = dev_read_block(node_blk, ni.blk_addr);
+		ASSERT(ret >= 0);
+
+		node_blk->i.i_inline |= F2FS_INLINE_DATA;
+		node_blk->i.i_inline |= F2FS_DATA_EXIST;
+		n = read(fd, buffer, BLOCK_SZ);
+		ASSERT(n == de->size);
+		memcpy(&node_blk->i.i_addr[1], buffer, de->size);
+
+		node_blk->i.i_size = cpu_to_le64(de->size);
+
+		ret = dev_write_block(node_blk, ni.blk_addr);
+		ASSERT(ret >= 0);
+		free(node_blk);
+	} else {
+		while ((n = read(fd, buffer, BLOCK_SZ)) > 0) {
+			f2fs_write_block(sbi, de->ino, buffer, n, off);
+			off += n;
+		}
+	}
+
+	close(fd);
+	if (n < 0)
+		return -1;
+
+	update_free_segments(sbi);
+
+	MSG(1, "Info: built a file %s, size=%lu\n", de->full_path, de->size);
+	return 0;
+}
diff --git a/fsck/sload.c b/fsck/sload.c
new file mode 100644
index 0000000..424e642
--- /dev/null
+++ b/fsck/sload.c
@@ -0,0 +1,247 @@
+/**
+ * sload.c
+ *
+ * Copyright (C) 2015 Huawei Ltd.
+ * Witten by:
+ *   Hou Pengyang <houpengyang@huawei.com>
+ *   Liu Shuoran <liushuoran@huawei.com>
+ *   Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#define _GNU_SOURCE
+#include "fsck.h"
+#include <libgen.h>
+#include <dirent.h>
+#include <mntent.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+
+#ifdef WITH_ANDROID
+#include <selinux/label.h>
+#include <private/android_filesystem_config.h>
+
+static void handle_selabel(struct dentry *de, int dir, char *target_out)
+{
+	uint64_t capabilities;
+	unsigned int mode = 0;
+	unsigned int uid = 0;
+	unsigned int gid = 0;
+
+	fs_config(de[i].path, dir, target_out, &uid,
+			&gid, &mode, &capabilities);
+	de.mode = mode;
+	de.uid = uid;
+	de.gid = gid;
+	de.capabilities = capabilities;
+}
+#else
+#define handle_selabel(...)
+#endif
+
+static int filter_dot(const struct dirent *d)
+{
+	return (strcmp(d->d_name, "..") && strcmp(d->d_name, "."));
+}
+
+static void f2fs_make_directory(struct f2fs_sb_info *sbi,
+				int entries, struct dentry *de)
+{
+	int i = 0;
+
+	for (i = 0; i < entries; i++) {
+		if (de[i].file_type == F2FS_FT_DIR)
+			f2fs_mkdir(sbi, de + i);
+		else if (de[i].file_type == F2FS_FT_REG_FILE)
+			f2fs_create(sbi, de + i);
+		else if (de[i].file_type == F2FS_FT_SYMLINK)
+			f2fs_symlink(sbi, de + i);
+	}
+}
+
+static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
+			const char *dir_path, const char *target_out_dir,
+			nid_t dir_ino, struct selabel_handle *sehnd)
+{
+	int entries = 0;
+	struct dentry *dentries;
+	struct dirent **namelist = NULL;
+	struct stat stat;
+	int i, ret = 0;
+
+	entries = scandir(full_path, &namelist, filter_dot, (void *)alphasort);
+	if (entries < 0) {
+		ERR_MSG("No entries in %s\n", full_path);
+		return -ENOENT;
+	}
+
+	dentries = calloc(entries, sizeof(struct dentry));
+	if (dentries == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < entries; i++) {
+		dentries[i].name = (unsigned char *)strdup(namelist[i]->d_name);
+		if (dentries[i].name == NULL) {
+			ERR_MSG("Skip: ENOMEM\n");
+			continue;
+		}
+		dentries[i].len = strlen((char *)dentries[i].name);
+
+		ret = asprintf(&dentries[i].path, "%s/%s",
+					dir_path, namelist[i]->d_name);
+		ASSERT(ret > 0);
+		ret = asprintf(&dentries[i].full_path, "%s/%s",
+					full_path, namelist[i]->d_name);
+		ASSERT(ret > 0);
+		free(namelist[i]);
+
+		ret = lstat(dentries[i].full_path, &stat);
+		if (ret < 0) {
+			ERR_MSG("Skip: lstat failure\n");
+			continue;
+		}
+		dentries[i].size = stat.st_size;
+		dentries[i].mode = stat.st_mode &
+			(S_ISUID|S_ISGID|S_ISVTX|S_IRWXU|S_IRWXG|S_IRWXO);
+		dentries[i].mtime = stat.st_mtime;
+
+		handle_selabel(dentries + i, S_ISDIR(stat.st_mode),
+							target_out_dir);
+
+		if (sehnd && selabel_lookup(sehnd, &dentries[i].secon,
+					dentries[i].path, stat.st_mode) < 0)
+			ERR_MSG("Cannot lookup security context for %s\n",
+						dentries[i].path);
+
+		dentries[i].pino = dir_ino;
+
+		if (S_ISREG(stat.st_mode)) {
+			dentries[i].file_type = F2FS_FT_REG_FILE;
+		} else if (S_ISDIR(stat.st_mode)) {
+			dentries[i].file_type = F2FS_FT_DIR;
+		} else if (S_ISCHR(stat.st_mode)) {
+			dentries[i].file_type = F2FS_FT_CHRDEV;
+		} else if (S_ISBLK(stat.st_mode)) {
+			dentries[i].file_type = F2FS_FT_BLKDEV;
+		} else if (S_ISFIFO(stat.st_mode)) {
+			dentries[i].file_type = F2FS_FT_FIFO;
+		} else if (S_ISSOCK(stat.st_mode)) {
+			dentries[i].file_type = F2FS_FT_SOCK;
+		} else if (S_ISLNK(stat.st_mode)) {
+			dentries[i].file_type = F2FS_FT_SYMLINK;
+			dentries[i].link = calloc(F2FS_BLKSIZE, 1);
+			ASSERT(dentries[i].link);
+			ret = readlink(dentries[i].full_path,
+					dentries[i].link, F2FS_BLKSIZE - 1);
+			ASSERT(ret >= 0);
+		} else {
+			MSG(1, "unknown file type on %s", dentries[i].path);
+			i--;
+			entries--;
+		}
+	}
+
+	free(namelist);
+
+	f2fs_make_directory(sbi, entries, dentries);
+
+	for (i = 0; i < entries; i++) {
+		if (dentries[i].file_type == F2FS_FT_REG_FILE) {
+			f2fs_build_file(sbi, dentries + i);
+		} else if (dentries[i].file_type == F2FS_FT_DIR) {
+			char *subdir_full_path = NULL;
+			char *subdir_dir_path;
+
+			ret = asprintf(&subdir_full_path, "%s/",
+							dentries[i].full_path);
+			ASSERT(ret > 0);
+			ret = asprintf(&subdir_dir_path, "%s/",
+							dentries[i].path);
+			ASSERT(ret > 0);
+
+			build_directory(sbi, subdir_full_path, subdir_dir_path,
+					target_out_dir, dentries[i].ino, sehnd);
+			free(subdir_full_path);
+			free(subdir_dir_path);
+		} else if (dentries[i].file_type == F2FS_FT_SYMLINK) {
+			/*
+			 * It is already done in f2fs_make_directory
+			 * f2fs_make_symlink(sbi, dir_ino, &dentries[i]);
+			 */
+		} else {
+			MSG(1, "Error unknown file type\n");
+		}
+
+		if (dentries[i].secon) {
+			inode_set_selinux(sbi, dentries[i].ino, dentries[i].secon);
+			MSG(1, "File = %s \n----->SELinux context = %s\n",
+					dentries[i].path, dentries[i].secon);
+			MSG(1, "----->mode = 0x%x, uid = 0x%x, gid = 0x%x, "
+					"capabilities = 0x%lx \n",
+					dentries[i].mode, dentries[i].uid,
+					dentries[i].gid, dentries[i].capabilities);
+		}
+
+		free(dentries[i].path);
+		free(dentries[i].full_path);
+		free((void *)dentries[i].name);
+		free(dentries[i].secon);
+	}
+
+	free(dentries);
+	return 0;
+}
+
+int f2fs_sload(struct f2fs_sb_info *sbi, const char *from_dir,
+				const char *mount_point,
+				const char *target_out_dir,
+				struct selabel_handle *sehnd)
+{
+	int ret = 0;
+	nid_t mnt_ino = F2FS_ROOT_INO(sbi);
+
+	/* flush NAT/SIT journal entries */
+	flush_journal_entries(sbi);
+
+	ret = f2fs_find_path(sbi, (char *)mount_point, &mnt_ino);
+	if (ret) {
+		ERR_MSG("Failed to get mount point %s\n", mount_point);
+		return ret;
+	}
+
+	ret = build_directory(sbi, from_dir, mount_point, target_out_dir,
+						mnt_ino, sehnd);
+	if (ret) {
+		ERR_MSG("Failed to build due to %d\n", ret);
+		return ret;
+	}
+
+	if (sehnd) {
+		char *secontext = NULL;
+
+		/* set root inode selinux context */
+		if (selabel_lookup(sehnd, &secontext, mount_point, S_IFDIR) < 0)
+			ERR_MSG("cannot lookup security context for %s\n",
+								mount_point);
+		if (secontext) {
+			MSG(1, "Labeling %s as %s, root_ino = %d\n",
+					mount_point, secontext, F2FS_ROOT_INO(sbi));
+			/* xattr_add for root inode */
+			inode_set_selinux(sbi, F2FS_ROOT_INO(sbi), secontext);
+		}
+		free(secontext);
+	}
+
+	/* update curseg info; can update sit->types */
+	move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
+	zero_journal_entries(sbi);
+	write_curseg_info(sbi);
+
+	/* flush dirty sit entries */
+	flush_sit_entries(sbi);
+
+	write_checkpoint(sbi);
+	return 0;
+}
diff --git a/fsck/xattr.c b/fsck/xattr.c
new file mode 100644
index 0000000..3f5c7d3
--- /dev/null
+++ b/fsck/xattr.c
@@ -0,0 +1,241 @@
+/**
+ * xattr.c
+ *
+ * Many parts of codes are copied from Linux kernel/fs/f2fs.
+ *
+ * Copyright (C) 2015 Huawei Ltd.
+ * Witten by:
+ *   Hou Pengyang <houpengyang@huawei.com>
+ *   Liu Shuoran <liushuoran@huawei.com>
+ *   Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+#include "node.h"
+#include "xattr.h"
+
+#define XATTR_CREATE 0x1
+#define XATTR_REPLACE 0x2
+
+static void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
+{
+	struct f2fs_xattr_header *header;
+	void *txattr_addr;
+	u64 inline_size = inline_xattr_size(&inode->i);
+
+	txattr_addr = calloc(inline_size + BLOCK_SZ, 1);
+	ASSERT(txattr_addr);
+
+	if (inline_size)
+		memcpy(txattr_addr, inline_xattr_addr(&inode->i), inline_size);
+
+	/* Read from xattr node block. */
+	if (inode->i.i_xattr_nid) {
+		struct node_info ni;
+		int ret;
+
+		get_node_info(sbi, le32_to_cpu(inode->i.i_xattr_nid), &ni);
+		ret = dev_read_block(txattr_addr + inline_size, ni.blk_addr);
+		ASSERT(ret >= 0);
+	}
+
+	header = XATTR_HDR(txattr_addr);
+
+	/* Never been allocated xattrs */
+	if (le32_to_cpu(header->h_magic) != F2FS_XATTR_MAGIC) {
+		header->h_magic = cpu_to_le32(F2FS_XATTR_MAGIC);
+		header->h_refcount = cpu_to_le32(1);
+	}
+	return txattr_addr;
+}
+
+static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
+		size_t len, const char *name)
+{
+	struct f2fs_xattr_entry *entry;
+	list_for_each_xattr(entry, base_addr) {
+		if (entry->e_name_index != index)
+			continue;
+		if (entry->e_name_len != len)
+			continue;
+		if (!memcmp(entry->e_name, name, len))
+			break;
+	}
+	return entry;
+}
+
+static void write_all_xattrs(struct f2fs_sb_info *sbi,
+		struct f2fs_node *inode, __u32 hsize, void *txattr_addr)
+{
+	void *xattr_addr;
+	struct dnode_of_data dn;
+	struct node_info ni;
+	struct f2fs_node *xattr_node;
+	nid_t new_nid = 0;
+	block_t blkaddr;
+	nid_t xnid = le32_to_cpu(inode->i.i_xattr_nid);
+	u64 inline_size = inline_xattr_size(&inode->i);
+	int ret;
+
+	ASSERT(inode->i.i_inline & F2FS_INLINE_XATTR);
+	memcpy(inline_xattr_addr(&inode->i), txattr_addr, inline_size);
+
+	if (hsize <= inline_size)
+		return;
+
+	if (!xnid) {
+		f2fs_alloc_nid(sbi, &new_nid, 0);
+
+		set_new_dnode(&dn, inode, NULL, new_nid);
+		/* NAT entry would be updated by new_node_page. */
+		blkaddr = new_node_block(sbi, &dn, XATTR_NODE_OFFSET);
+		ASSERT(dn.node_blk);
+		xattr_node = dn.node_blk;
+		inode->i.i_xattr_nid = cpu_to_le32(new_nid);
+	} else {
+		set_new_dnode(&dn, inode, NULL, xnid);
+		get_node_info(sbi, xnid, &ni);
+		blkaddr = ni.blk_addr;
+		xattr_node = calloc(BLOCK_SZ, 1);
+		ASSERT(xattr_node);
+		ret = dev_read_block(xattr_node, ni.blk_addr);
+		ASSERT(ret >= 0);
+	}
+
+	/* write to xattr node block */
+	xattr_addr = (void *)xattr_node;
+	memcpy(xattr_addr, txattr_addr + inline_size,
+			PAGE_SIZE - sizeof(struct node_footer));
+
+	ret = dev_write_block(xattr_node, blkaddr);
+	ASSERT(ret >= 0);
+}
+
+int f2fs_setxattr(struct f2fs_sb_info *sbi, nid_t ino, int index, const char *name,
+		const void *value, size_t size, int flags)
+{
+	struct f2fs_node *inode;
+	void *base_addr;
+	struct f2fs_xattr_entry *here, *last;
+	struct node_info ni;
+	int error = 0;
+	int len;
+	int found, newsize;
+	__u32 new_hsize;
+	int ret;
+
+	if (name == NULL)
+		return -EINVAL;
+
+	if (value == NULL)
+		return -EINVAL;
+
+	len = strlen(name);
+
+	if (len > F2FS_NAME_LEN || size > MAX_VALUE_LEN)
+		return -ERANGE;
+
+	if (ino < 3)
+		return -EINVAL;
+
+	/* Now We just support selinux */
+	ASSERT(index == F2FS_XATTR_INDEX_SECURITY);
+
+	get_node_info(sbi, ino, &ni);
+	inode = calloc(BLOCK_SZ, 1);
+	ASSERT(inode);
+	ret = dev_read_block(inode, ni.blk_addr);
+	ASSERT(ret >= 0);
+
+	base_addr = read_all_xattrs(sbi, inode);
+	ASSERT(base_addr);
+
+	here = __find_xattr(base_addr, index, len, name);
+
+	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
+
+	if ((flags & XATTR_REPLACE) && !found) {
+		error = -ENODATA;
+		goto exit;
+	} else if ((flags & XATTR_CREATE) && found) {
+		error = -EEXIST;
+		goto exit;
+	}
+
+	last = here;
+	while (!IS_XATTR_LAST_ENTRY(last))
+		last = XATTR_NEXT_ENTRY(last);
+
+	newsize = XATTR_ALIGN(sizeof(struct f2fs_xattr_entry) + len + size);
+
+	/* 1. Check space */
+	if (value) {
+		int free;
+		/*
+		 * If value is NULL, it is remove operation.
+		 * In case of update operation, we calculate free.
+		 */
+		free = MIN_OFFSET - ((char *)last - (char *)base_addr);
+		if (found)
+			free = free + ENTRY_SIZE(here);
+		if (free < newsize) {
+			error = -ENOSPC;
+			goto exit;
+		}
+	}
+
+	/* 2. Remove old entry */
+	if (found) {
+		/*
+		 * If entry if sound, remove old entry.
+		 * If not found, remove operation is not needed
+		 */
+		struct f2fs_xattr_entry *next = XATTR_NEXT_ENTRY(here);
+		int oldsize = ENTRY_SIZE(here);
+
+		memmove(here, next, (char *)last - (char *)next);
+		last = (struct f2fs_xattr_entry *)((char *)last - oldsize);
+		memset(last, 0, oldsize);
+
+	}
+
+	new_hsize = (char *)last - (char *)base_addr;
+
+	/* 3. Write new entry */
+	if (value) {
+		char *pval;
+		/*
+		 * Before we come here, old entry is removed.
+		 * We just write new entry.
+		 */
+		memset(last, 0, newsize);
+		last->e_name_index = index;
+		last->e_name_len = len;
+		memcpy(last->e_name, name, len);
+		pval = last->e_name + len;
+		memcpy(pval, value, size);
+		last->e_value_size = cpu_to_le16(size);
+		new_hsize += newsize;
+	}
+
+	write_all_xattrs(sbi, inode, new_hsize, base_addr);
+
+	/* inode need update */
+	ret = dev_write_block(inode, ni.blk_addr);
+	ASSERT(ret >= 0);
+exit:
+	free(base_addr);
+	return error;
+}
+
+int inode_set_selinux(struct f2fs_sb_info *sbi, u32 ino, const char *secon)
+{
+	if (!secon)
+		return 0;
+
+	return f2fs_setxattr(sbi, ino, F2FS_XATTR_INDEX_SECURITY,
+			XATTR_SELINUX_SUFFIX, secon, strlen(secon), 1);
+}
diff --git a/fsck/xattr.h b/fsck/xattr.h
new file mode 100644
index 0000000..3ca9133
--- /dev/null
+++ b/fsck/xattr.h
@@ -0,0 +1,66 @@
+/**
+ * xattr.h
+ *
+ * Many parts of codes are copied from Linux kernel/fs/f2fs.
+ *
+ * Copyright (C) 2015 Huawei Ltd.
+ * Witten by:
+ *   Hou Pengyang <houpengyang@huawei.com>
+ *   Liu Shuoran <liushuoran@huawei.com>
+ *   Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _XATTR_H_
+#define _XATTR_H_
+
+#include <f2fs_fs.h>
+#include "f2fs.h"
+
+struct f2fs_xattr_header {
+	__le32 h_magic;		/* magic number for identification */
+	__le32 h_refcount;	/* reference count */
+	__u32 h_sloadd[4];	/* zero right now */
+};
+
+struct f2fs_xattr_entry {
+	__u8 e_name_index;
+	__u8 e_name_len;
+	__le16 e_value_size;	/* size of attribute value */
+	char e_name[0];		/* attribute name */
+};
+
+#define XATTR_ROUND	(3)
+
+#define XATTR_SELINUX_SUFFIX "selinux"
+#define F2FS_XATTR_INDEX_SECURITY	6
+#define IS_XATTR_LAST_ENTRY(entry) (*(__u32 *)(entry) == 0)
+
+#define XATTR_HDR(ptr)		((struct f2fs_xattr_header *)(ptr))
+#define XATTR_ENTRY(ptr) 	((struct f2fs_xattr_entry *)(ptr))
+#define F2FS_XATTR_MAGIC	0xF2F52011
+
+#define XATTR_NEXT_ENTRY(entry) ((struct f2fs_xattr_entry *) ((char *)(entry) +\
+					ENTRY_SIZE(entry)))
+#define XATTR_FIRST_ENTRY(ptr)	(XATTR_ENTRY(XATTR_HDR(ptr) + 1))
+
+#define XATTR_ALIGN(size)	((size + XATTR_ROUND) & ~XATTR_ROUND)
+
+#define ENTRY_SIZE(entry) (XATTR_ALIGN(sizeof(struct f2fs_xattr_entry) + \
+			entry->e_name_len + le16_to_cpu(entry->e_value_size)))
+
+#define list_for_each_xattr(entry, addr) \
+	for (entry = XATTR_FIRST_ENTRY(addr); \
+			!IS_XATTR_LAST_ENTRY(entry); \
+			entry = XATTR_NEXT_ENTRY(entry))
+
+#define MIN_OFFSET	XATTR_ALIGN(PAGE_SIZE -			\
+		sizeof(struct node_footer) - sizeof(__u32))
+
+#define MAX_VALUE_LEN	(MIN_OFFSET -				\
+		sizeof(struct f2fs_xattr_header) -		\
+		sizeof(struct f2fs_xattr_entry))
+
+#endif
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 99798d0..1cc08fd 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -28,6 +28,7 @@ typedef u32		block_t;
 typedef u32		nid_t;
 typedef u8		bool;
 typedef unsigned long	pgoff_t;
+typedef unsigned short	umode_t;
 
 #if HAVE_BYTESWAP_H
 #include <byteswap.h>
@@ -208,6 +209,9 @@ static inline uint64_t bswap_64(uint64_t val)
 #define F2FS_SUPER_MAGIC	0xF2F52010	/* F2FS Magic Number */
 #define CHECKSUM_OFFSET		4092
 
+#define F2FS_BYTES_TO_BLK(bytes)    ((bytes) >> F2FS_BLKSIZE_BITS)
+#define F2FS_BLKSIZE_BITS 12
+
 /* for mkfs */
 #define	F2FS_NUMBER_OF_CHECKPOINT_PACK	2
 #define	DEFAULT_SECTOR_SIZE		512
@@ -222,6 +226,7 @@ enum f2fs_config_func {
 	DUMP,
 	DEFRAG,
 	RESIZE,
+	SLOAD,
 };
 
 struct f2fs_configuration {
@@ -264,6 +269,10 @@ struct f2fs_configuration {
 	u_int64_t defrag_start;
 	u_int64_t defrag_len;
 	u_int64_t defrag_target;
+
+	/* sload parameters */
+	char *from_dir;
+	char *mount_point;
 } __attribute__((packed));
 
 #ifdef CONFIG_64BIT
@@ -529,7 +538,9 @@ struct f2fs_extent {
 #define F2FS_NAME_LEN		255
 #define F2FS_INLINE_XATTR_ADDRS	50	/* 200 bytes for inline xattrs */
 #define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
-#define ADDRS_PER_INODE(fi)	addrs_per_inode(fi)
+#define ADDRS_PER_INODE(i)	addrs_per_inode(i)
+#define DEF_ADDRS_PER_INODE_INLINE_XATTR				\
+		(DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS)
 #define ADDRS_PER_BLOCK         1018	/* Address Pointers in a Direct Block */
 #define NIDS_PER_BLOCK          1018	/* Node IDs in an Indirect Block */
 
@@ -545,8 +556,8 @@ struct f2fs_extent {
 #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
 #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
 
-#define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
-						F2FS_INLINE_XATTR_ADDRS - 1))
+#define MAX_INLINE_DATA (sizeof(__le32) *				\
+			(DEF_ADDRS_PER_INODE_INLINE_XATTR - 1))
 
 #define INLINE_DATA_OFFSET	(PAGE_CACHE_SIZE - sizeof(struct node_footer) \
 				- sizeof(__le32)*(DEF_ADDRS_PER_INODE + 5 - 1))
@@ -634,6 +645,7 @@ struct f2fs_node {
  * For NAT entries
  */
 #define NAT_ENTRY_PER_BLOCK (PAGE_CACHE_SIZE / sizeof(struct f2fs_nat_entry))
+#define NAT_BLOCK_OFFSET(start_nid) (start_nid / NAT_ENTRY_PER_BLOCK)
 
 struct f2fs_nat_entry {
 	__u8 version;		/* latest version of cached nat entry */
diff --git a/man/Makefile.am b/man/Makefile.am
index 6c04de7..7856586 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,3 +1,3 @@
 ## Makefile.am
 
-dist_man_MANS = mkfs.f2fs.8 fsck.f2fs.8 dump.f2fs.8 defrag.f2fs.8 resize.f2fs.8
+dist_man_MANS = mkfs.f2fs.8 fsck.f2fs.8 dump.f2fs.8 defrag.f2fs.8 resize.f2fs.8 sload.f2fs.8
diff --git a/man/defrag.f2fs.8 b/man/defrag.f2fs.8
index 8c709a7..b08399b 100644
--- a/man/defrag.f2fs.8
+++ b/man/defrag.f2fs.8
@@ -72,4 +72,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
 .BR mkfs.f2fs(8),
 .BR dump.f2fs(8),
 .BR fsck.f2fs(8),
-.BR resize.f2fs(8).
+.BR resize.f2fs(8),
+.BR sload.f2fs(8).
diff --git a/man/dump.f2fs.8 b/man/dump.f2fs.8
index dc1d806..35616e5 100644
--- a/man/dump.f2fs.8
+++ b/man/dump.f2fs.8
@@ -66,4 +66,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
 .BR mkfs.f2fs(8),
 .BR fsck.f2fs(8),
 .BR defrag.f2fs(8),
-.BR resize.f2fs(8).
+.BR resize.f2fs(8),
+.BR sload.f2fs(8).
diff --git a/man/fsck.f2fs.8 b/man/fsck.f2fs.8
index 22457c5..af1076c 100644
--- a/man/fsck.f2fs.8
+++ b/man/fsck.f2fs.8
@@ -65,4 +65,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
 .BR mkfs.f2fs(8),
 .BR dump.f2fs(8),
 .BR defrag.f2fs(8),
-.BR resize.f2fs(8).
+.BR resize.f2fs(8),
+.BR sload.f2fs(8).
diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index b767c0c..0e54fe8 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -95,4 +95,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
 .BR fsck.f2fs(8),
 .BR dump.f2fs(8),
 .BR defrag.f2fs(8),
-.BR resize.f2fs(8).
+.BR resize.f2fs(8),
+.BR sload.f2fs(8).
diff --git a/man/resize.f2fs.8 b/man/resize.f2fs.8
index 1920810..463eca5 100644
--- a/man/resize.f2fs.8
+++ b/man/resize.f2fs.8
@@ -46,4 +46,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
 .BR mkfs.f2fs(8),
 .BR fsck.f2fs(8),
 .BR dump.f2fs(8),
-.BR defrag.f2fs(8).
+.BR defrag.f2fs(8),
+.BR sload.f2fs(8).
diff --git a/man/sload.f2fs.8 b/man/sload.f2fs.8
new file mode 100644
index 0000000..d07330c
--- /dev/null
+++ b/man/sload.f2fs.8
@@ -0,0 +1,56 @@
+.\" Copyright (C) 2015 Huawei Ltd.
+.\"
+.TH SLOAD.F2FS 8
+.SH NAME
+sload.f2fs \- load directories and files into the device directly
+.SH SYNOPSIS
+.B sload.f2fs
+[
+.B \-f
+.I source directory path
+]
+[
+.B \-t
+.I mount point
+]
+[
+.B \-d
+.I debugging-level
+]
+.I device
+.SH DESCRIPTION
+.B sload.f2fs
+is used to load directories and files into a disk partition.
+\fIdevice\fP is the special file corresponding to the device (e.g.
+\fI/dev/sdXX\fP).
+
+.PP
+The exit code returned by
+.B sload.f2fs
+is 0 on success and -1 on failure.
+.SH OPTIONS
+.TP
+.BI \-f " source directory path"
+Specify the source directory path to be loaded.
+.TP
+.BI \-t " mount point path"
+Specify the mount point path in the partition to load.
+.TP
+.BI \-d " debug-level"
+Specify the level of debugging options.
+The default number is 0, which shows basic debugging messages.
+.TP
+.SH AUTHOR
+This version of
+.B sload.f2fs
+has been written by Hou Pengyang <houpengyang@huawei.com>,
+Liu Shuoran <liushuoran@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
+.SH AVAILABILITY
+.B sload.f2fs
+is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
+.SH SEE ALSO
+.BR mkfs.f2fs(8),
+.BR fsck.f2fs(8),
+.BR dump.f2fs(8),
+.BR defrag.f2fs(8),
+.BR resize.f2fs(8).
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
