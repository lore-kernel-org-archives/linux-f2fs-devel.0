From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/5] f2fs: reserve the xattr space dynamically
Date: Mon, 26 Aug 2013 20:16:38 +0900
Message-ID: <1377515801-15243-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1377515801-15243-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VDun5-0005oC-C8
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Aug 2013 11:16:59 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VDun3-0007gd-Dk for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Aug 2013 11:16:59 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MS400EB5XZP79Z0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Aug 2013 20:16:48 +0900 (KST)
In-reply-to: <1377515801-15243-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch enables the number of direct pointers inside on-disk inode block to
be changed dynamically according to the size of inline xattr space.

The number of direct pointers, ADDRS_PER_INODE, can be changed only if the file
has inline xattr flag.

The number of direct pointers that will be used by inline xattrs is defined as
F2FS_INLINE_XATTR_ADDRS.
Current patch assigns F2FS_INLINE_XATTR_ADDRS to 0 temporarily.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c          |  5 +++--
 fs/f2fs/f2fs.h          | 18 ++++++++----------
 fs/f2fs/file.c          |  2 +-
 fs/f2fs/gc.c            |  9 ++++++---
 fs/f2fs/node.c          |  9 +++++----
 fs/f2fs/recovery.c      | 13 +++++++++----
 fs/f2fs/super.c         |  2 +-
 include/linux/f2fs_fs.h | 16 ++++++++++++----
 8 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6b328de..941f9b9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -117,7 +117,8 @@ void update_extent_cache(block_t blk_addr, struct dnode_of_data *dn)
 	block_t start_blkaddr, end_blkaddr;
 
 	BUG_ON(blk_addr == NEW_ADDR);
-	fofs = start_bidx_of_node(ofs_of_node(dn->node_page)) + dn->ofs_in_node;
+	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
+							dn->ofs_in_node;
 
 	/* Update the page address in the parent node */
 	__set_data_blkaddr(dn, blk_addr);
@@ -448,7 +449,7 @@ static int get_data_block_ro(struct inode *inode, sector_t iblock,
 		unsigned int end_offset;
 
 		end_offset = IS_INODE(dn.node_page) ?
-				ADDRS_PER_INODE :
+				ADDRS_PER_INODE(F2FS_I(inode)) :
 				ADDRS_PER_BLOCK;
 
 		clear_buffer_new(bh_result);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b82f141..0343759 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -301,15 +301,6 @@ struct f2fs_sm_info {
 };
 
 /*
- * For directory operation
- */
-#define	NODE_DIR1_BLOCK		(ADDRS_PER_INODE + 1)
-#define	NODE_DIR2_BLOCK		(ADDRS_PER_INODE + 2)
-#define	NODE_IND1_BLOCK		(ADDRS_PER_INODE + 3)
-#define	NODE_IND2_BLOCK		(ADDRS_PER_INODE + 4)
-#define	NODE_DIND_BLOCK		(ADDRS_PER_INODE + 5)
-
-/*
  * For superblock
  */
 /*
@@ -942,6 +933,13 @@ static inline void set_raw_inline(struct f2fs_inode_info *fi,
 		ri->i_inline |= F2FS_INLINE_XATTR;
 }
 
+static inline unsigned int addrs_per_inode(struct f2fs_inode_info *fi)
+{
+	if (is_inode_flag_set(fi, FI_INLINE_XATTR))
+		return DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS;
+	return DEF_ADDRS_PER_INODE;
+}
+
 static inline int f2fs_readonly(struct super_block *sb)
 {
 	return sb->s_flags & MS_RDONLY;
@@ -1108,7 +1106,7 @@ int do_write_data_page(struct page *);
  */
 int start_gc_thread(struct f2fs_sb_info *);
 void stop_gc_thread(struct f2fs_sb_info *);
-block_t start_bidx_of_node(unsigned int);
+block_t start_bidx_of_node(unsigned int, struct f2fs_inode_info *);
 int f2fs_gc(struct f2fs_sb_info *);
 void build_gc_manager(struct f2fs_sb_info *);
 int __init create_gc_caches(void);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bd4184e..02c9069 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -290,7 +290,7 @@ static int truncate_blocks(struct inode *inode, u64 from)
 	}
 
 	if (IS_INODE(dn.node_page))
-		count = ADDRS_PER_INODE;
+		count = ADDRS_PER_INODE(F2FS_I(inode));
 	else
 		count = ADDRS_PER_BLOCK;
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e6b3ffd..eb89037 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -461,7 +461,7 @@ next_step:
  * as indirect or double indirect node blocks, are given, it must be a caller's
  * bug.
  */
-block_t start_bidx_of_node(unsigned int node_ofs)
+block_t start_bidx_of_node(unsigned int node_ofs, struct f2fs_inode_info *fi)
 {
 	unsigned int indirect_blks = 2 * NIDS_PER_BLOCK + 4;
 	unsigned int bidx;
@@ -478,7 +478,7 @@ block_t start_bidx_of_node(unsigned int node_ofs)
 		int dec = (node_ofs - indirect_blks - 3) / (NIDS_PER_BLOCK + 1);
 		bidx = node_ofs - 5 - dec;
 	}
-	return bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE;
+	return bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE(fi);
 }
 
 static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
@@ -586,7 +586,6 @@ next_step:
 			continue;
 		}
 
-		start_bidx = start_bidx_of_node(nofs);
 		ofs_in_node = le16_to_cpu(entry->ofs_in_node);
 
 		if (phase == 2) {
@@ -594,6 +593,8 @@ next_step:
 			if (IS_ERR(inode))
 				continue;
 
+			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode));
+
 			data_page = find_data_page(inode,
 					start_bidx + ofs_in_node, false);
 			if (IS_ERR(data_page))
@@ -604,6 +605,8 @@ next_step:
 		} else {
 			inode = find_gc_inode(dni.ino, ilist);
 			if (inode) {
+				start_bidx = start_bidx_of_node(nofs,
+								F2FS_I(inode));
 				data_page = get_lock_data_page(inode,
 						start_bidx + ofs_in_node);
 				if (IS_ERR(data_page))
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 818ff36..f0e733b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -315,9 +315,10 @@ cache:
  * The maximum depth is four.
  * Offset[0] will have raw inode offset.
  */
-static int get_node_path(long block, int offset[4], unsigned int noffset[4])
+static int get_node_path(struct f2fs_inode_info *fi, long block,
+				int offset[4], unsigned int noffset[4])
 {
-	const long direct_index = ADDRS_PER_INODE;
+	const long direct_index = ADDRS_PER_INODE(fi);
 	const long direct_blks = ADDRS_PER_BLOCK;
 	const long dptrs_per_blk = NIDS_PER_BLOCK;
 	const long indirect_blks = ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
@@ -405,7 +406,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	int level, i;
 	int err = 0;
 
-	level = get_node_path(index, offset, noffset);
+	level = get_node_path(F2FS_I(dn->inode), index, offset, noffset);
 
 	nids[0] = dn->inode->i_ino;
 	npage[0] = dn->inode_page;
@@ -687,7 +688,7 @@ int truncate_inode_blocks(struct inode *inode, pgoff_t from)
 
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
-	level = get_node_path(from, offset, noffset);
+	level = get_node_path(F2FS_I(inode), from, offset, noffset);
 restart:
 	page = get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(page)) {
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index fa493bb..51ef5ee 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -213,6 +213,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	void *kaddr;
 	struct inode *inode;
 	struct page *node_page;
+	unsigned int offset;
 	block_t bidx;
 	int i;
 
@@ -257,8 +258,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	node_page = get_node_page(sbi, nid);
 	if (IS_ERR(node_page))
 		return PTR_ERR(node_page);
-	bidx = start_bidx_of_node(ofs_of_node(node_page)) +
-					le16_to_cpu(sum.ofs_in_node);
+
+	offset = ofs_of_node(node_page);
 	ino = ino_of_node(node_page);
 	f2fs_put_page(node_page, 1);
 
@@ -267,6 +268,9 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
+	bidx = start_bidx_of_node(offset, F2FS_I(inode)) +
+					le16_to_cpu(sum.ofs_in_node);
+
 	truncate_hole(inode, bidx, bidx + 1);
 	iput(inode);
 	return 0;
@@ -275,6 +279,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 					struct page *page, block_t blkaddr)
 {
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 	unsigned int start, end;
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
@@ -282,9 +287,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	int err = 0, recovered = 0;
 	int ilock;
 
-	start = start_bidx_of_node(ofs_of_node(page));
+	start = start_bidx_of_node(ofs_of_node(page), fi);
 	if (IS_INODE(page))
-		end = start + ADDRS_PER_INODE;
+		end = start + ADDRS_PER_INODE(fi);
 	else
 		end = start + ADDRS_PER_BLOCK;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 70ecf48..13d0a0f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -618,7 +618,7 @@ static const struct export_operations f2fs_export_ops = {
 
 static loff_t max_file_size(unsigned bits)
 {
-	loff_t result = ADDRS_PER_INODE;
+	loff_t result = (DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS);
 	loff_t leaf_count = ADDRS_PER_BLOCK;
 
 	/* two direct node blocks */
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 10ab11f..93e7020 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -140,9 +140,17 @@ struct f2fs_extent {
 } __packed;
 
 #define F2FS_NAME_LEN		255
-#define ADDRS_PER_INODE         923	/* Address Pointers in an Inode */
-#define ADDRS_PER_BLOCK         1018	/* Address Pointers in a Direct Block */
-#define NIDS_PER_BLOCK          1018	/* Node IDs in an Indirect Block */
+#define F2FS_INLINE_XATTR_ADDRS	0	/* 0 bytes for inline xattrs */
+#define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
+#define ADDRS_PER_INODE(fi)	addrs_per_inode(fi)
+#define ADDRS_PER_BLOCK		1018	/* Address Pointers in a Direct Block */
+#define NIDS_PER_BLOCK		1018	/* Node IDs in an Indirect Block */
+
+#define	NODE_DIR1_BLOCK		(DEF_ADDRS_PER_INODE + 1)
+#define	NODE_DIR2_BLOCK		(DEF_ADDRS_PER_INODE + 2)
+#define	NODE_IND1_BLOCK		(DEF_ADDRS_PER_INODE + 3)
+#define	NODE_IND2_BLOCK		(DEF_ADDRS_PER_INODE + 4)
+#define	NODE_DIND_BLOCK		(DEF_ADDRS_PER_INODE + 5)
 
 #define F2FS_INLINE_XATTR	0x01	/* file inline xattr flag */
 
@@ -172,7 +180,7 @@ struct f2fs_inode {
 
 	struct f2fs_extent i_ext;	/* caching a largest extent */
 
-	__le32 i_addr[ADDRS_PER_INODE];	/* Pointers to data blocks */
+	__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
 
 	__le32 i_nid[5];		/* direct(2), indirect(2),
 						double_indirect(1) node id */
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
