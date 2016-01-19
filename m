From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: remove unneeded pointer conversion for
	cleanup
Date: Tue, 19 Jan 2016 18:55:27 +0800
Message-ID: <001901d152a7$ffe1a8d0$ffa4fa70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aLTxU-0007SO-LY
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Jan 2016 10:56:20 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aLTxT-0005rJ-1b
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Jan 2016 10:56:20 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1701AKZ516AKE0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Jan 2016 19:56:11 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

There are unneeded pointer conversion in following call stack:
 - at position a, inode was been converted to f2fs_file_info.
 - at position b, f2fs_file_info was been converted to inode again.

 - truncate_blocks(inode,..)
  - fi = F2FS_I(inode)		---a
  - ADDRS_PER_PAGE(node_page, fi)
   - addrs_per_inode(fi)
    - inode = &fi->vfs_inode	---b
    - f2fs_has_inline_xattr(inode)
     - fi = F2FS_I(inode)
     - is_inode_flag_set(fi,..)

This patch alters ADDRS_PER_PAGE and addrs_per_inode to accept
parameter with type of inode pointer, and uses them to clean up
codes.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c          |  5 ++---
 fs/f2fs/extent_cache.c  |  3 +--
 fs/f2fs/f2fs.h          | 14 +++++++-------
 fs/f2fs/file.c          | 11 +++++------
 fs/f2fs/gc.c            |  8 ++++----
 fs/f2fs/node.c          |  8 ++++----
 fs/f2fs/recovery.c      | 10 ++++------
 include/linux/f2fs_fs.h |  6 +++---
 8 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 284a123..ea72e8b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -461,7 +461,6 @@ got_it:
 static int __allocate_data_block(struct dnode_of_data *dn)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct f2fs_inode_info *fi = F2FS_I(dn->inode);
 	struct f2fs_summary sum;
 	struct node_info ni;
 	int seg = CURSEG_WARM_DATA;
@@ -489,7 +488,7 @@ alloc:
 	set_data_blkaddr(dn);
 
 	/* update i_size */
-	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
+	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
 							dn->ofs_in_node;
 	if (i_size_read(dn->inode) < ((loff_t)(fofs + 1) << PAGE_CACHE_SHIFT))
 		i_size_write(dn->inode,
@@ -556,7 +555,7 @@ next_dnode:
 		goto unlock_out;
 	}
 
-	end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 
 next_block:
 	blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index ccd5c63..b484b268 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -701,7 +701,6 @@ bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
 
 void f2fs_update_extent_cache(struct dnode_of_data *dn)
 {
-	struct f2fs_inode_info *fi = F2FS_I(dn->inode);
 	pgoff_t fofs;
 
 	if (!f2fs_may_extent_tree(dn->inode))
@@ -710,7 +709,7 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 	f2fs_bug_on(F2FS_I_SB(dn->inode), dn->data_blkaddr == NEW_ADDR);
 
 
-	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
+	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
 							dn->ofs_in_node;
 
 	if (f2fs_update_extent_tree_range(dn->inode, fofs, dn->data_blkaddr, 1))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2c0e478..2062f96 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1525,9 +1525,9 @@ static inline int f2fs_has_inline_xattr(struct inode *inode)
 	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_XATTR);
 }
 
-static inline unsigned int addrs_per_inode(struct f2fs_inode_info *fi)
+static inline unsigned int addrs_per_inode(struct inode *inode)
 {
-	if (f2fs_has_inline_xattr(&fi->vfs_inode))
+	if (f2fs_has_inline_xattr(inode))
 		return DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS;
 	return DEF_ADDRS_PER_INODE;
 }
@@ -1683,10 +1683,10 @@ static inline void *f2fs_kvzalloc(size_t size, gfp_t flags)
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
 
 /* get offset of first page in next direct node */
-#define PGOFS_OF_NEXT_DNODE(pgofs, fi)				\
-	((pgofs < ADDRS_PER_INODE(fi)) ? ADDRS_PER_INODE(fi) :	\
-	(pgofs - ADDRS_PER_INODE(fi) + ADDRS_PER_BLOCK) /	\
-	ADDRS_PER_BLOCK * ADDRS_PER_BLOCK + ADDRS_PER_INODE(fi))
+#define PGOFS_OF_NEXT_DNODE(pgofs, inode)				\
+	((pgofs < ADDRS_PER_INODE(inode)) ? ADDRS_PER_INODE(inode) :	\
+	(pgofs - ADDRS_PER_INODE(inode) + ADDRS_PER_BLOCK) /	\
+	ADDRS_PER_BLOCK * ADDRS_PER_BLOCK + ADDRS_PER_INODE(inode))
 
 /*
  * file.c
@@ -1904,7 +1904,7 @@ int f2fs_release_page(struct page *, gfp_t);
  */
 int start_gc_thread(struct f2fs_sb_info *);
 void stop_gc_thread(struct f2fs_sb_info *);
-block_t start_bidx_of_node(unsigned int, struct f2fs_inode_info *);
+block_t start_bidx_of_node(unsigned int, struct inode *);
 int f2fs_gc(struct f2fs_sb_info *, bool);
 void build_gc_manager(struct f2fs_sb_info *);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 18ddb1e..2a81748 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -358,15 +358,14 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 		} else if (err == -ENOENT) {
 			/* direct node does not exists */
 			if (whence == SEEK_DATA) {
-				pgofs = PGOFS_OF_NEXT_DNODE(pgofs,
-							F2FS_I(inode));
+				pgofs = PGOFS_OF_NEXT_DNODE(pgofs, inode);
 				continue;
 			} else {
 				goto found;
 			}
 		}
 
-		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 
 		/* find data/hole in dnode block */
 		for (; dn.ofs_in_node < end_offset;
@@ -480,7 +479,7 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		 * we will invalidate all blkaddr in the whole range.
 		 */
 		fofs = start_bidx_of_node(ofs_of_node(dn->node_page),
-						F2FS_I(dn->inode)) + ofs;
+							dn->inode) + ofs;
 		f2fs_update_extent_cache_range(dn, fofs, 0, len);
 		dec_valid_block_count(sbi, dn->inode, nr_free);
 		sync_inode_page(dn);
@@ -568,7 +567,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 		goto out;
 	}
 
-	count = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+	count = ADDRS_PER_PAGE(dn.node_page, inode);
 
 	count -= dn.ofs_in_node;
 	f2fs_bug_on(sbi, count < 0);
@@ -768,7 +767,7 @@ int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 			return err;
 		}
 
-		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 		count = min(end_offset - dn.ofs_in_node, pg_end - pg_start);
 
 		f2fs_bug_on(F2FS_I_SB(inode), count == 0 || count > end_offset);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f610c2a..b0346bb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -483,7 +483,7 @@ next_step:
  * as indirect or double indirect node blocks, are given, it must be a caller's
  * bug.
  */
-block_t start_bidx_of_node(unsigned int node_ofs, struct f2fs_inode_info *fi)
+block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode)
 {
 	unsigned int indirect_blks = 2 * NIDS_PER_BLOCK + 4;
 	unsigned int bidx;
@@ -500,7 +500,7 @@ block_t start_bidx_of_node(unsigned int node_ofs, struct f2fs_inode_info *fi)
 		int dec = (node_ofs - indirect_blks - 3) / (NIDS_PER_BLOCK + 1);
 		bidx = node_ofs - 5 - dec;
 	}
-	return bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE(fi);
+	return bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE(inode);
 }
 
 static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
@@ -719,7 +719,7 @@ next_step:
 				continue;
 			}
 
-			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode));
+			start_bidx = start_bidx_of_node(nofs, inode);
 			data_page = get_read_data_page(inode,
 					start_bidx + ofs_in_node, READA, true);
 			if (IS_ERR(data_page)) {
@@ -735,7 +735,7 @@ next_step:
 		/* phase 3 */
 		inode = find_gc_inode(gc_list, dni.ino);
 		if (inode) {
-			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode))
+			start_bidx = start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
 			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 				move_encrypted_block(inode, start_bidx);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 342597a..1954b6c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -407,10 +407,10 @@ cache:
  * The maximum depth is four.
  * Offset[0] will have raw inode offset.
  */
-static int get_node_path(struct f2fs_inode_info *fi, long block,
+static int get_node_path(struct inode *inode, long block,
 				int offset[4], unsigned int noffset[4])
 {
-	const long direct_index = ADDRS_PER_INODE(fi);
+	const long direct_index = ADDRS_PER_INODE(inode);
 	const long direct_blks = ADDRS_PER_BLOCK;
 	const long dptrs_per_blk = NIDS_PER_BLOCK;
 	const long indirect_blks = ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
@@ -498,7 +498,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	int level, i;
 	int err = 0;
 
-	level = get_node_path(F2FS_I(dn->inode), index, offset, noffset);
+	level = get_node_path(dn->inode, index, offset, noffset);
 
 	nids[0] = dn->inode->i_ino;
 	npage[0] = dn->inode_page;
@@ -792,7 +792,7 @@ int truncate_inode_blocks(struct inode *inode, pgoff_t from)
 
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
-	level = get_node_path(F2FS_I(inode), from, offset, noffset);
+	level = get_node_path(inode, from, offset, noffset);
 restart:
 	page = get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(page)) {
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 589b20b..d88531f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -350,8 +350,7 @@ got_it:
 		inode = dn->inode;
 	}
 
-	bidx = start_bidx_of_node(offset, F2FS_I(inode)) +
-			le16_to_cpu(sum.ofs_in_node);
+	bidx = start_bidx_of_node(offset, inode) + le16_to_cpu(sum.ofs_in_node);
 
 	/*
 	 * if inode page is locked, unlock temporarily, but its reference
@@ -386,10 +385,9 @@ truncate_out:
 static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 					struct page *page, block_t blkaddr)
 {
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	unsigned int start, end;
 	struct dnode_of_data dn;
 	struct node_info ni;
+	unsigned int start, end;
 	int err = 0, recovered = 0;
 
 	/* step 1: recover xattr */
@@ -409,8 +407,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		goto out;
 
 	/* step 3: recover data indices */
-	start = start_bidx_of_node(ofs_of_node(page), fi);
-	end = start + ADDRS_PER_PAGE(page, fi);
+	start = start_bidx_of_node(ofs_of_node(page), inode);
+	end = start + ADDRS_PER_PAGE(page, inode);
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index e59c3be..f4c266c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -170,12 +170,12 @@ struct f2fs_extent {
 #define F2FS_INLINE_XATTR_ADDRS	50	/* 200 bytes for inline xattrs */
 #define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
 #define DEF_NIDS_PER_INODE	5	/* Node IDs in an Inode */
-#define ADDRS_PER_INODE(fi)	addrs_per_inode(fi)
+#define ADDRS_PER_INODE(inode)	addrs_per_inode(inode)
 #define ADDRS_PER_BLOCK		1018	/* Address Pointers in a Direct Block */
 #define NIDS_PER_BLOCK		1018	/* Node IDs in an Indirect Block */
 
-#define ADDRS_PER_PAGE(page, fi)	\
-	(IS_INODE(page) ? ADDRS_PER_INODE(fi) : ADDRS_PER_BLOCK)
+#define ADDRS_PER_PAGE(page, inode)	\
+	(IS_INODE(page) ? ADDRS_PER_INODE(inode) : ADDRS_PER_BLOCK)
 
 #define	NODE_DIR1_BLOCK		(DEF_ADDRS_PER_INODE + 1)
 #define	NODE_DIR2_BLOCK		(DEF_ADDRS_PER_INODE + 2)
-- 
2.6.3



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
