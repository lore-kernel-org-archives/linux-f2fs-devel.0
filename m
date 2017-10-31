From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs-tools: f2fs_read() and
 f2fs_filesize_update() are added
Date: Mon, 30 Oct 2017 20:42:04 -0700
Message-ID: <20171031034206.26890-2-jaegeuk@kernel.org>
References: <20171031034206.26890-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e9NRP-00006R-9B
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:42:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e9NRN-0005m6-Ue
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:42:15 +0000
In-Reply-To: <20171031034206.26890-1-jaegeuk@kernel.org>
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
Cc: Hyojun Kim <hyojun@google.com>, Jaegeuk Kim <jaegeuk@google.com>

From: Hyojun Kim <hyojun@google.com>

This patch adds f2fs_read() and f2fs_filesize_update(). It also refactors
f2fs_write_block() and renamed as f2fs_write().

Signed-off-by: Hyojun Kim <hyojun@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 fsck/fsck.h    |   6 ++
 fsck/segment.c | 248 ++++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 171 insertions(+), 83 deletions(-)

diff --git a/fsck/fsck.h b/fsck/fsck.h
index 1e8ed0b..5628906 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -219,6 +219,12 @@ void f2fs_alloc_nid(struct f2fs_sb_info *, nid_t *, int);
 void set_data_blkaddr(struct dnode_of_data *);
 block_t new_node_block(struct f2fs_sb_info *,
 					struct dnode_of_data *, unsigned int);
+
+/* segment.c */
+u64 f2fs_read(struct f2fs_sb_info *, nid_t, void *, u64, pgoff_t);
+u64 f2fs_write(struct f2fs_sb_info *, nid_t, void *, u64, pgoff_t);
+void f2fs_filesize_update(struct f2fs_sb_info *, nid_t, u64);
+
 void get_dnode_of_data(struct f2fs_sb_info *, struct dnode_of_data *,
 					pgoff_t, int);
 void make_dentry_ptr(struct f2fs_dentry_ptr *, struct f2fs_node *, void *, int);
diff --git a/fsck/segment.c b/fsck/segment.c
index 2ea5bf1..e13f147 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -68,111 +68,193 @@ void new_data_block(struct f2fs_sb_info *sbi, void *block,
 	set_data_blkaddr(dn);
 }
 
-static void f2fs_write_block(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
+u64 f2fs_read(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
 					u64 count, pgoff_t offset)
 {
-	u64 start = F2FS_BYTES_TO_BLK(offset);
-	u64 len = F2FS_BYTES_TO_BLK(count);
-	u64 end_offset;
-	u64 off_in_block, len_in_block, len_already;
-	struct dnode_of_data dn = {0};
-	void *data_blk;
+	struct dnode_of_data dn;
 	struct node_info ni;
 	struct f2fs_node *inode;
-	int idirty = 0;
-	int ret = -1;
-
+	char *blk_buffer;
+	u64 filesize;
+	u64 off_in_blk;
+	u64 len_in_blk;
+	u64 read_count;
+	u64 remained_blkentries;
+	block_t blkaddr;
+	void *index_node = NULL;
+
+	memset(&dn, 0, sizeof(dn));
+
+	/* Memory allocation for block buffer and inode. */
+	blk_buffer = calloc(BLOCK_SZ, 2);
+	ASSERT(blk_buffer);
+	inode = (struct f2fs_node*)(blk_buffer + BLOCK_SZ);
+
+	/* Read inode */
 	get_node_info(sbi, ino, &ni);
-	inode = calloc(BLOCK_SZ, 1);
-	ASSERT(inode);
-
-	ret = dev_read_block(inode, ni.blk_addr);
-	ASSERT(ret >= 0);
-
-	if (S_ISDIR(le16_to_cpu(inode->i.i_mode)) ||
-			S_ISLNK(le16_to_cpu(inode->i.i_mode)))
-		ASSERT(0);
-
-	off_in_block = offset & ((1 << F2FS_BLKSIZE_BITS) - 1);
-	len_in_block = (1 << F2FS_BLKSIZE_BITS) - off_in_block;
-	if (len_in_block > count)
-		len_in_block = count;
-	len_already = 0;
-
-	/*
-	 * When calculate how many blocks this 'count' stride accross,
-	 * We should take offset in a block in account.
-	 */
-	len = F2FS_BYTES_TO_BLK(count + off_in_block
-			+ ((1 << F2FS_BLKSIZE_BITS) - 1));
-
-	data_blk = calloc(BLOCK_SZ, 1);
-	ASSERT(data_blk);
-
-	set_new_dnode(&dn, inode, NULL, ino);
+	ASSERT(dev_read_block(inode, ni.blk_addr) >= 0);
+	ASSERT(!S_ISDIR(le16_to_cpu(inode->i.i_mode)));
+	ASSERT(!S_ISLNK(le16_to_cpu(inode->i.i_mode)));
+
+	/* Adjust count with file length. */
+	filesize = le64_to_cpu(inode->i.i_size);
+	if (offset > filesize)
+		count = 0;
+	else if (count + offset > filesize)
+		count = filesize - offset;
+
+	/* Main loop for file blocks */
+	read_count = remained_blkentries = 0;
+	while (count > 0) {
+		if (remained_blkentries == 0) {
+			set_new_dnode(&dn, inode, NULL, ino);
+			get_dnode_of_data(sbi, &dn, F2FS_BYTES_TO_BLK(offset),
+					LOOKUP_NODE);
+			if (index_node)
+				free(index_node);
+			index_node = (dn.node_blk == dn.inode_blk) ?
+							NULL : dn.node_blk;
+			remained_blkentries = ADDRS_PER_PAGE(dn.node_blk);
+		}
+		ASSERT(remained_blkentries > 0);
+
+		blkaddr = datablock_addr(dn.node_blk, dn.ofs_in_node);
+		if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR)
+			break;
+
+		off_in_blk = offset % BLOCK_SZ;
+		len_in_blk = BLOCK_SZ - off_in_blk;
+		if (len_in_blk > count)
+			len_in_blk = count;
+
+		/* Read data from single block. */
+		if (len_in_blk < BLOCK_SZ) {
+			ASSERT(dev_read_block(blk_buffer, blkaddr) >= 0);
+			memcpy(buffer, blk_buffer + off_in_blk, len_in_blk);
+		} else {
+			/* Direct read */
+			ASSERT(dev_read_block(buffer, blkaddr) >= 0);
+		}
 
-	while (len) {
-		if (dn.node_blk != dn.inode_blk)
-			free(dn.node_blk);
+		offset += len_in_blk;
+		count -= len_in_blk;
+		buffer += len_in_blk;
+		read_count += len_in_blk;
 
-		set_new_dnode(&dn, inode, NULL, ino);
-		get_dnode_of_data(sbi, &dn, start, ALLOC_NODE);
+		dn.ofs_in_node++;
+		remained_blkentries--;
+	}
+	if (index_node)
+		free(index_node);
+	free(blk_buffer);
 
-		end_offset = ADDRS_PER_PAGE(dn.node_blk);
+	return read_count;
+}
 
-		while (dn.ofs_in_node < end_offset && len) {
-			block_t blkaddr;
+u64 f2fs_write(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
+					u64 count, pgoff_t offset)
+{
+	struct dnode_of_data dn;
+	struct node_info ni;
+	struct f2fs_node *inode;
+	char *blk_buffer;
+	u64 off_in_blk;
+	u64 len_in_blk;
+	u64 written_count;
+	u64 remained_blkentries;
+	block_t blkaddr;
+	void* index_node = NULL;
+	int idirty = 0;
 
-			blkaddr = datablock_addr(dn.node_blk, dn.ofs_in_node);
+	/* Memory allocation for block buffer and inode. */
+	blk_buffer = calloc(BLOCK_SZ, 2);
+	ASSERT(blk_buffer);
+	inode = (struct f2fs_node*)(blk_buffer + BLOCK_SZ);
 
-			/* A new page from WARM_DATA */
-			if (blkaddr == NULL_ADDR) {
-				new_data_block(sbi, data_blk, &dn,
-							CURSEG_WARM_DATA);
-				blkaddr = dn.data_blkaddr;
-				idirty |= dn.idirty;
-			}
+	/* Read inode */
+	get_node_info(sbi, ino, &ni);
+	ASSERT(dev_read_block(inode, ni.blk_addr) >= 0);
+	ASSERT(!S_ISDIR(le16_to_cpu(inode->i.i_mode)));
+	ASSERT(!S_ISLNK(le16_to_cpu(inode->i.i_mode)));
+
+	/* Main loop for file blocks */
+	written_count = remained_blkentries = 0;
+	while (count > 0) {
+		if (remained_blkentries == 0) {
+			set_new_dnode(&dn, inode, NULL, ino);
+			get_dnode_of_data(sbi, &dn, F2FS_BYTES_TO_BLK(offset),
+					ALLOC_NODE);
+			idirty |= dn.idirty;
+			if (index_node)
+				free(index_node);
+			index_node = (dn.node_blk == dn.inode_blk) ?
+							NULL : dn.node_blk;
+			remained_blkentries = ADDRS_PER_PAGE(dn.node_blk);
+		}
+		ASSERT(remained_blkentries > 0);
 
-			/* Copy data from buffer to file */
-			ret = dev_read_block(data_blk, blkaddr);
-			ASSERT(ret >= 0);
+		blkaddr = datablock_addr(dn.node_blk, dn.ofs_in_node);
+		if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR) {
+			new_data_block(sbi, blk_buffer, &dn, CURSEG_WARM_DATA);
+			blkaddr = dn.data_blkaddr;
+		}
 
-			memcpy(data_blk + off_in_block, buffer, len_in_block);
+		off_in_blk = offset % BLOCK_SZ;
+		len_in_blk = BLOCK_SZ - off_in_blk;
+		if (len_in_blk > count)
+			len_in_blk = count;
+
+		/* Write data to single block. */
+		if (len_in_blk < BLOCK_SZ) {
+			ASSERT(dev_read_block(blk_buffer, blkaddr) >= 0);
+			memcpy(blk_buffer + off_in_blk, buffer, len_in_blk);
+			ASSERT(dev_write_block(blk_buffer, blkaddr) >= 0);
+		} else {
+			/* Direct write */
+			ASSERT(dev_write_block(buffer, blkaddr) >= 0);
+		}
 
-			ret = dev_write_block(data_blk, blkaddr);
-			ASSERT(ret >= 0);
+		offset += len_in_blk;
+		count -= len_in_blk;
+		buffer += len_in_blk;
+		written_count += len_in_blk;
 
-			off_in_block = 0;
-			len_already += len_in_block;
-			if ((count - len_already) > (1 << F2FS_BLKSIZE_BITS))
-				len_in_block = 1 << F2FS_BLKSIZE_BITS;
-			else
-				len_in_block = count - len_already;
-			len--;
-			start++;
-			dn.ofs_in_node++;
-		}
-		/* Update the direct node */
-		if (dn.ndirty) {
-			ret = dev_write_block(dn.node_blk, dn.node_blkaddr);
-			ASSERT(ret >= 0);
-		}
+		dn.ofs_in_node++;
+		if ((--remained_blkentries == 0 || count == 0) && (dn.ndirty))
+			ASSERT(dev_write_block(dn.node_blk, dn.node_blkaddr) >= 0);
 	}
-
-	/* Update the inode info */
-	if (le64_to_cpu(inode->i.i_size) < offset + count) {
-		inode->i.i_size = cpu_to_le64(offset + count);
+	if (offset > le64_to_cpu(inode->i.i_size)) {
+		inode->i.i_size = cpu_to_le64(offset);
 		idirty = 1;
 	}
-
 	if (idirty) {
 		ASSERT(inode == dn.inode_blk);
 		write_inode(ni.blk_addr, inode);
 	}
+	if (index_node)
+		free(index_node);
+	free(blk_buffer);
+
+	return written_count;
+}
+
+/* This function updates only inode->i.i_size */
+void f2fs_filesize_update(struct f2fs_sb_info *sbi, nid_t ino, u64 filesize)
+{
+	struct node_info ni;
+	struct f2fs_node *inode;
+
+	inode = calloc(BLOCK_SZ, 1);
+	ASSERT(inode);
+	get_node_info(sbi, ino, &ni);
+
+	ASSERT(dev_read_block(inode, ni.blk_addr) >= 0);
+	ASSERT(!S_ISDIR(le16_to_cpu(inode->i.i_mode)));
+	ASSERT(!S_ISLNK(le16_to_cpu(inode->i.i_mode)));
+
+	inode->i.i_size = cpu_to_le64(filesize);
 
-	if (dn.node_blk && dn.node_blk != dn.inode_blk)
-		free(dn.node_blk);
-	free(data_blk);
+	write_inode(ni.blk_addr, inode);
 	free(inode);
 }
 
@@ -221,7 +303,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
 		free(node_blk);
 	} else {
 		while ((n = read(fd, buffer, BLOCK_SZ)) > 0) {
-			f2fs_write_block(sbi, de->ino, buffer, n, off);
+			f2fs_write(sbi, de->ino, buffer, n, off);
 			off += n;
 		}
 	}
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
