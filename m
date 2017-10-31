From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] sload.f2fs: fix bugs in f2fs_write_block()
Date: Mon, 30 Oct 2017 20:42:03 -0700
Message-ID: <20171031034206.26890-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e9NRO-0004Gi-Fm
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:42:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e9NRN-0005m5-Hw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:42:14 +0000
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

Found and fixed following three bugs in f2fs_write_block() function.
 - Write (4096 - offset) bytes for the first block even for small count.
 - For overwriting, found blkaddr is not used for writing.
 - dn.idirty status can be lost by set_new_dnode().
 - missing inode_checksum

Signed-off-by: Hyojun Kim <hyojun@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 fsck/segment.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fsck/segment.c b/fsck/segment.c
index d568d61..2ea5bf1 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -16,6 +16,14 @@
 #include "fsck.h"
 #include "node.h"
 
+static void write_inode(u64 blkaddr, struct f2fs_node *inode)
+{
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
+		inode->i.i_inode_checksum =
+			cpu_to_le32(f2fs_inode_chksum(inode));
+	ASSERT(dev_write_block(inode, blkaddr) >= 0);
+}
+
 void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 			struct f2fs_summary *sum, int type)
 {
@@ -71,6 +79,7 @@ static void f2fs_write_block(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
 	void *data_blk;
 	struct node_info ni;
 	struct f2fs_node *inode;
+	int idirty = 0;
 	int ret = -1;
 
 	get_node_info(sbi, ino, &ni);
@@ -86,6 +95,8 @@ static void f2fs_write_block(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
 
 	off_in_block = offset & ((1 << F2FS_BLKSIZE_BITS) - 1);
 	len_in_block = (1 << F2FS_BLKSIZE_BITS) - off_in_block;
+	if (len_in_block > count)
+		len_in_block = count;
 	len_already = 0;
 
 	/*
@@ -115,17 +126,20 @@ static void f2fs_write_block(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
 			blkaddr = datablock_addr(dn.node_blk, dn.ofs_in_node);
 
 			/* A new page from WARM_DATA */
-			if (blkaddr == NULL_ADDR)
+			if (blkaddr == NULL_ADDR) {
 				new_data_block(sbi, data_blk, &dn,
 							CURSEG_WARM_DATA);
+				blkaddr = dn.data_blkaddr;
+				idirty |= dn.idirty;
+			}
 
 			/* Copy data from buffer to file */
-			ret = dev_read_block(data_blk, dn.data_blkaddr);
+			ret = dev_read_block(data_blk, blkaddr);
 			ASSERT(ret >= 0);
 
 			memcpy(data_blk + off_in_block, buffer, len_in_block);
 
-			ret = dev_write_block(data_blk, dn.data_blkaddr);
+			ret = dev_write_block(data_blk, blkaddr);
 			ASSERT(ret >= 0);
 
 			off_in_block = 0;
@@ -148,13 +162,12 @@ static void f2fs_write_block(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
 	/* Update the inode info */
 	if (le64_to_cpu(inode->i.i_size) < offset + count) {
 		inode->i.i_size = cpu_to_le64(offset + count);
-		dn.idirty = 1;
+		idirty = 1;
 	}
 
-	if (dn.idirty) {
+	if (idirty) {
 		ASSERT(inode == dn.inode_blk);
-		ret = dev_write_block(inode, ni.blk_addr);
-		ASSERT(ret >= 0);
+		write_inode(ni.blk_addr, inode);
 	}
 
 	if (dn.node_blk && dn.node_blk != dn.inode_blk)
@@ -203,15 +216,8 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
 		n = read(fd, buffer, BLOCK_SZ);
 		ASSERT(n == de->size);
 		memcpy(inline_data_addr(node_blk), buffer, de->size);
-
 		node_blk->i.i_size = cpu_to_le64(de->size);
-
-		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
-			node_blk->i.i_inode_checksum =
-				cpu_to_le32(f2fs_inode_chksum(node_blk));
-
-		ret = dev_write_block(node_blk, ni.blk_addr);
-		ASSERT(ret >= 0);
+		write_inode(ni.blk_addr, node_blk);
 		free(node_blk);
 	} else {
 		while ((n = read(fd, buffer, BLOCK_SZ)) > 0) {
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
