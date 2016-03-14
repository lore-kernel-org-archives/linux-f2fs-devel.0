From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 1/2] fsck.f2fs: check dirent position
Date: Mon, 14 Mar 2016 16:20:08 +0800
Message-ID: <014e01d17dca$676827c0$36387740$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1afNkE-0007Ud-Bw
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Mar 2016 08:20:54 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1afNkC-00007A-8O
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Mar 2016 08:20:54 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O4001CYASID4740@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Mar 2016 17:20:44 +0900 (KST)
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
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch enables fsck.f2fs to detect incorrect position where dirent
locates in an hierarchical hash structure directory.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
- just do the check for non-inline directory.
- fix the wrong page offset skipped.

 fsck/fsck.c       | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 fsck/fsck.h       |  2 ++
 include/f2fs_fs.h |  3 ++
 3 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 0351228..d497ffe 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -565,12 +565,13 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		u32 *blk_cnt, struct node_info *ni)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	struct child_info child = {2, 0, 0};
+	struct child_info child = {2, 0, 0, 0};
 	enum NODE_TYPE ntype;
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
 	child.p_ino = nid;
 	child.pp_ino = le32_to_cpu(node_blk->i.i_pino);
+	child.dir_level = node_blk->i.i_dir_level;
 	struct extent_info i_extent;
 	unsigned int idx = 0;
 	int need_fix = 0;
@@ -679,7 +680,8 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	}
 
 	/* check data blocks in inode */
-	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i); idx++) {
+	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i);
+						idx++, child.pgofs++) {
 		block_t blkaddr = le32_to_cpu(node_blk->i.i_addr[idx]);
 
 		if (blkaddr != 0) {
@@ -808,7 +810,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 	child->p_ino = nid;
 	child->pp_ino = le32_to_cpu(inode->i_pino);
 
-	for (idx = 0; idx < ADDRS_PER_BLOCK; idx++) {
+	for (idx = 0; idx < ADDRS_PER_BLOCK; idx++, child->pgofs++) {
 		block_t blkaddr = le32_to_cpu(node_blk->dn.addr[idx]);
 
 		if (blkaddr == 0x0)
@@ -841,9 +843,9 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 	int need_fix = 0, ret;
 	int i = 0;
 
-	for (i = 0 ; i < NIDS_PER_BLOCK; i++) {
+	for (i = 0; i < NIDS_PER_BLOCK; i++) {
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
-			continue;
+			goto skip;
 		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]), NULL,
 				ftype, TYPE_DIRECT_NODE, blk_cnt, child,
@@ -858,6 +860,8 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 				need_fix = 1;
 				FIX_MSG("Set indirect node 0x%x -> 0\n", i);
 			}
+skip:
+			child->pgofs += ADDRS_PER_BLOCK;
 		}
 	}
 
@@ -1022,6 +1026,73 @@ static int f2fs_check_hash_code(struct f2fs_dir_entry *dentry,
 	return 0;
 }
 
+static unsigned int dir_buckets(unsigned int level, int dir_level)
+{
+	if (level + dir_level < MAX_DIR_HASH_DEPTH / 2)
+		return 1 << (level + dir_level);
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
+				int dir_level, unsigned int idx)
+{
+	unsigned long i;
+	unsigned long bidx = 0;
+
+	for (i = 0; i < level; i++)
+		bidx += dir_buckets(i, dir_level) * bucket_blocks(i);
+	bidx += idx * bucket_blocks(level);
+	return bidx;
+}
+
+static int __get_current_level(int dir_level, u32 pgofs)
+{
+	unsigned int bidx = 0;
+	int i;
+
+	for (i = 0; i < MAX_DIR_HASH_DEPTH; i++) {
+		bidx += dir_buckets(i, dir_level) * bucket_blocks(i);
+		if (bidx > pgofs)
+			break;
+	}
+	return i;
+}
+
+static int f2fs_check_dirent_position(u8 *name, u16 name_len, u32 pgofs,
+						u8 dir_level, u32 pino)
+{
+	f2fs_hash_t namehash = f2fs_dentry_hash(name, name_len);
+	unsigned int nbucket, nblock;
+	unsigned int bidx, end_block;
+	int level;
+
+	level = __get_current_level(dir_level, pgofs);
+
+	nbucket = dir_buckets(level, dir_level);
+	nblock = bucket_blocks(level);
+
+	bidx = dir_block_index(level, dir_level,
+					le32_to_cpu(namehash) % nbucket);
+	end_block = bidx + nblock;
+
+	if (pgofs >= bidx && pgofs < end_block)
+		return 0;
+
+	ASSERT_MSG("Wrong position of dirent pino:%u, name:%s, level:%d, "
+		"dir_level:%d, pgofs:%u, correct range:[%u, %u]\n",
+		pino, name, level, dir_level, pgofs, bidx, end_block - 1);
+	return 1;
+}
+
 static int __chk_dots_dentries(struct f2fs_sb_info *sbi,
 			       struct f2fs_dir_entry *dentry,
 			       struct child_info *child,
@@ -1195,6 +1266,10 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 		if (f2fs_check_hash_code(dentry + i, name, name_len, encrypted))
 			fixed = 1;
 
+		if (max == NR_DENTRY_IN_BLOCK)
+			f2fs_check_dirent_position(name, name_len, child->pgofs,
+						child->dir_level, child->p_ino);
+
 		DBG(1, "[%3u]-[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
 				fsck->dentry_depth, i, name, name_len,
 				le32_to_cpu(dentry[i].ino),
diff --git a/fsck/fsck.h b/fsck/fsck.h
index aa3e8cf..b92a1e0 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -22,7 +22,9 @@ struct orphan_info {
 struct child_info {
 	u32 links;
 	u32 files;
+	u32 pgofs;
 	u8 dots;
+	u8 dir_level;
 	u32 p_ino;		/*parent ino*/
 	u32 pp_ino;		/*parent parent ino*/
 };
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 3a1d2d1..aaf534a 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -786,6 +786,9 @@ typedef __le32	f2fs_hash_t;
 /* MAX level for dir lookup */
 #define MAX_DIR_HASH_DEPTH	63
 
+/* MAX buckets in one level of dir */
+#define MAX_DIR_BUCKETS		(1 << ((MAX_DIR_HASH_DEPTH / 2) - 1))
+
 #define SIZE_OF_DIR_ENTRY	11	/* by byte */
 #define SIZE_OF_DENTRY_BITMAP	((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \
 					BITS_PER_BYTE)
-- 
2.7.0



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
