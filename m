From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] dump.f2fs: dump owner of data given block
	address
Date: Sun, 21 Dec 2014 08:37:13 -0800
Message-ID: <1419179834-3345-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y2jVT-00077p-Sg
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:37:23 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y2jVS-0003G4-KS for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:37:23 +0000
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

This patch introduces a feature to dump owner information of given block
address.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dump.c  | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 fsck/f2fs.h  |  12 +++++
 fsck/fsck.h  |   4 +-
 fsck/main.c  |   2 +-
 fsck/mount.c |  14 +++++-
 5 files changed, 169 insertions(+), 24 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 4bb906f..3c4a8d1 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -11,6 +11,7 @@
 #include <inttypes.h>
 
 #include "fsck.h"
+#include <locale.h>
 
 #define BUF_SZ	80
 
@@ -298,13 +299,114 @@ void dump_node(struct f2fs_sb_info *sbi, nid_t nid)
 	free(node_blk);
 }
 
-int dump_inode_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
+static void dump_node_from_blkaddr(u32 blk_addr)
 {
-	nid_t ino, nid;
-	int type, ret;
-	struct f2fs_summary sum_entry;
-	struct node_info ni;
 	struct f2fs_node *node_blk;
+	int ret;
+
+	node_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk);
+
+	ret = dev_read_block(node_blk, blk_addr);
+	ASSERT(ret >= 0);
+
+	if (config.dbg_lv > 0)
+		print_node_info(node_blk);
+	else
+		print_inode_info(&node_blk->i, 1);
+
+	free(node_blk);
+}
+
+static void dump_data_offset(u32 blk_addr, int ofs_in_node)
+{
+	struct f2fs_node *node_blk;
+	unsigned int indirect_blks = 2 * NIDS_PER_BLOCK + 4;
+	unsigned int bidx = 0;
+	unsigned int node_ofs;
+	int ret;
+
+	node_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk);
+
+	ret = dev_read_block(node_blk, blk_addr);
+	ASSERT(ret >= 0);
+
+	node_ofs = ofs_of_node(node_blk);
+
+	if (node_ofs == 0)
+		goto got_it;
+
+	if (node_ofs > 0 && node_ofs <= 2) {
+		bidx = node_ofs - 1;
+	} else if (node_ofs <= indirect_blks) {
+		int dec = (node_ofs - 4) / (NIDS_PER_BLOCK + 1);
+		bidx = node_ofs - 2 - dec;
+	} else {
+		int dec = (node_ofs - indirect_blks - 3) / (NIDS_PER_BLOCK + 1);
+		bidx = node_ofs - 5 - dec;
+	}
+	bidx = bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE(&node_blk->i);
+got_it:
+	bidx +=  ofs_in_node;
+
+	setlocale(LC_ALL, "");
+	MSG(0, " - Data offset       : 0x%x (4KB), %'u (bytes)\n",
+				bidx, bidx * 4096);
+	free(node_blk);
+}
+
+static void dump_node_offset(u32 blk_addr)
+{
+	struct f2fs_node *node_blk;
+	int ret;
+
+	node_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk);
+
+	ret = dev_read_block(node_blk, blk_addr);
+	ASSERT(ret >= 0);
+
+	MSG(0, " - Node offset       : 0x%x\n", ofs_of_node(node_blk));
+	free(node_blk);
+}
+
+int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
+{
+	nid_t nid;
+	int type;
+	struct f2fs_summary sum_entry;
+	struct node_info ni, ino_ni;
+	int ret = 0;
+
+	MSG(0, "\n== Dump data from block address ==\n\n");
+
+	if (blk_addr < SM_I(sbi)->seg0_blkaddr) {
+		MSG(0, "\nFS Reserved Area for SEG #0: ");
+		ret = -EINVAL;
+	} else if (blk_addr < SIT_I(sbi)->sit_base_addr) {
+		MSG(0, "\nFS Metadata Area: ");
+		ret = -EINVAL;
+	} else if (blk_addr < NM_I(sbi)->nat_blkaddr) {
+		MSG(0, "\nFS SIT Area: ");
+		ret = -EINVAL;
+	} else if (blk_addr < SM_I(sbi)->ssa_blkaddr) {
+		MSG(0, "\nFS NAT Area: ");
+		ret = -EINVAL;
+	} else if (blk_addr < SM_I(sbi)->main_blkaddr) {
+		MSG(0, "\nFS SSA Area: ");
+		ret = -EINVAL;
+	} else if (blk_addr > __end_block_addr(sbi)) {
+		MSG(0, "\nOut of address space: ");
+		ret = -EINVAL;
+	}
+
+	if (ret) {
+		MSG(0, "User data is from 0x%x to 0x%x\n\n",
+			SM_I(sbi)->main_blkaddr,
+			__end_block_addr(sbi));
+		return ret;
+	}
 
 	type = get_sum_entry(sbi, blk_addr, &sum_entry);
 	nid = le32_to_cpu(sum_entry.nid);
@@ -318,26 +420,47 @@ int dump_inode_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 	DBG(1, "SUM.nid               [0x%x]\n", nid);
 	DBG(1, "SUM.type              [%s]\n", seg_type_name[type]);
 	DBG(1, "SUM.version           [%d]\n", sum_entry.version);
-	DBG(1, "SUM.ofs_in_node       [%d]\n", sum_entry.ofs_in_node);
+	DBG(1, "SUM.ofs_in_node       [0x%x]\n", sum_entry.ofs_in_node);
 	DBG(1, "NAT.blkaddr           [0x%x]\n", ni.blk_addr);
 	DBG(1, "NAT.ino               [0x%x]\n", ni.ino);
 
-	node_blk = calloc(BLOCK_SZ, 1);
-
-read_node_blk:
-	ret = dev_read_block(node_blk, blk_addr);
-	ASSERT(ret >= 0);
+	get_node_info(sbi, ni.ino, &ino_ni);
 
-	ino = le32_to_cpu(node_blk->footer.ino);
-	nid = le32_to_cpu(node_blk->footer.nid);
+	/* inode block address */
+	if (ni.blk_addr == NULL_ADDR || ino_ni.blk_addr == NULL_ADDR) {
+		MSG(0, "FS Userdata Area: Obsolete block from 0x%x\n",
+			blk_addr);
+		return -EINVAL;
+	}
 
-	if (ino == nid) {
-		print_node_info(node_blk);
+	/* print inode */
+	if (config.dbg_lv > 0)
+		dump_node_from_blkaddr(ino_ni.blk_addr);
+
+	if (type == SEG_TYPE_CUR_DATA || type == SEG_TYPE_DATA) {
+		MSG(0, "FS Userdata Area: Data block from 0x%x\n", blk_addr);
+		MSG(0, " - Direct node block : id = 0x%x from 0x%x\n",
+					nid, ni.blk_addr);
+		MSG(0, " - Inode block       : id = 0x%x from 0x%x\n",
+					ni.ino, ino_ni.blk_addr);
+		dump_node_from_blkaddr(ino_ni.blk_addr);
+		dump_data_offset(ni.blk_addr,
+			le16_to_cpu(sum_entry.ofs_in_node));
 	} else {
-		get_node_info(sbi, ino, &ni);
-		goto read_node_blk;
+		MSG(0, "FS Userdata Area: Node block from 0x%x\n", blk_addr);
+		if (ni.ino == ni.nid) {
+			MSG(0, " - Inode block       : id = 0x%x from 0x%x\n",
+					ni.ino, ino_ni.blk_addr);
+			dump_node_from_blkaddr(ino_ni.blk_addr);
+		} else {
+			MSG(0, " - Node block        : id = 0x%x from 0x%x\n",
+					nid, ni.blk_addr);
+			MSG(0, " - Inode block       : id = 0x%x from 0x%x\n",
+					ni.ino, ino_ni.blk_addr);
+			dump_node_from_blkaddr(ino_ni.blk_addr);
+			dump_node_offset(ni.blk_addr);
+		}
 	}
 
-	free(node_blk);
-	return ino;
+	return 0;
 }
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 57bad9b..c268f15 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -197,6 +197,12 @@ static inline void *inline_data_addr(struct f2fs_node *node_blk)
 	return (void *)&(node_blk->i.i_addr[1]);
 }
 
+static inline unsigned int ofs_of_node(struct f2fs_node *node_blk)
+{
+	unsigned flag = le32_to_cpu(node_blk->footer.flag);
+	return flag >> OFFSET_BIT_SHIFT;
+}
+
 static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -255,6 +261,12 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
 }
 
+static inline block_t __end_block_addr(struct f2fs_sb_info *sbi)
+{
+	block_t end = SM_I(sbi)->main_blkaddr;
+	return end + le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count);
+}
+
 #define GET_ZONENO_FROM_SEGNO(sbi, segno)                               \
 	((segno / sbi->segs_per_sec) / sbi->secs_per_zone)
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 49d6d1d..9cad013 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -97,7 +97,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 		u32 *, u32 *);
 
 extern void print_node_info(struct f2fs_node *);
-extern void print_inode_info(struct f2fs_inode *);
+extern void print_inode_info(struct f2fs_inode *, int);
 extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *, unsigned int);
 extern int get_sum_block(struct f2fs_sb_info *, unsigned int,
 				struct f2fs_summary_block *);
@@ -126,6 +126,6 @@ struct dump_option {
 extern void sit_dump(struct f2fs_sb_info *, int, int);
 extern void ssa_dump(struct f2fs_sb_info *, int, int);
 extern void dump_node(struct f2fs_sb_info *, nid_t);
-extern int dump_inode_from_blkaddr(struct f2fs_sb_info *, u32);
+extern int dump_info_from_blkaddr(struct f2fs_sb_info *, u32);
 
 #endif /* _FSCK_H_ */
diff --git a/fsck/main.c b/fsck/main.c
index 2af3daf..e05e528 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -169,7 +169,7 @@ static void do_dump(struct f2fs_sb_info *sbi)
 	if (opt->start_ssa != -1)
 		ssa_dump(sbi, opt->start_ssa, opt->end_ssa);
 	if (opt->blk_addr != -1) {
-		dump_inode_from_blkaddr(sbi, opt->blk_addr);
+		dump_info_from_blkaddr(sbi, opt->blk_addr);
 		goto cleanup;
 	}
 	dump_node(sbi, opt->nid);
diff --git a/fsck/mount.c b/fsck/mount.c
index 0aca60b..73eba6b 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -9,12 +9,22 @@
  * published by the Free Software Foundation.
  */
 #include "fsck.h"
+#include <locale.h>
 
-void print_inode_info(struct f2fs_inode *inode)
+void print_inode_info(struct f2fs_inode *inode, int name)
 {
 	unsigned int i = 0;
 	int namelen = le32_to_cpu(inode->i_namelen);
 
+	if (name && namelen) {
+		inode->i_name[namelen] = '\0';
+		MSG(0, " - File name         : %s\n", inode->i_name);
+		setlocale(LC_ALL, "");
+		MSG(0, " - File size         : %'llu (bytes)\n",
+				le64_to_cpu(inode->i_size));
+		return;
+	}
+
 	DISP_u32(inode, i_mode);
 	DISP_u32(inode, i_uid);
 	DISP_u32(inode, i_gid);
@@ -76,7 +86,7 @@ void print_node_info(struct f2fs_node *node_block)
 	/* Is this inode? */
 	if (ino == nid) {
 		DBG(0, "Node ID [0x%x:%u] is inode\n", nid, nid);
-		print_inode_info(&node_block->i);
+		print_inode_info(&node_block->i, 0);
 	} else {
 		int i;
 		u32 *dump_blk = (u32 *)node_block;
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
