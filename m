From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] dump.f2fs: support to dump dirent from blkaddr
Date: Mon, 29 Jan 2018 19:49:18 +0800
Message-ID: <20180129114918.87394-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eg7wi-00014H-Az
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 11:49:56 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eg7we-0000Wk-Vy
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 11:49:56 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch adds to support to dump dirent info based on block address
from dentry data block or inline dentry node.

[dump_dentry_block: 627] Inline Dentry block:
[dump_dentry_block: 650] bitmap pos[0x0] name[.] len[0x1] hash[0x0] ino[0x4] type[0x2]
[dump_dentry_block: 650] bitmap pos[0x1] name[..] len[0x2] hash[0x0] ino[0x3] type[0x2]

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dump.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/fsck/dump.c b/fsck/dump.c
index 32b68c932356..763ebd21191c 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -10,6 +10,7 @@
  */
 #include <inttypes.h>
 
+#include "node.h"
 #include "fsck.h"
 #include "xattr.h"
 #ifdef HAVE_ATTR_XATTR_H
@@ -581,6 +582,78 @@ static void dump_node_offset(u32 blk_addr)
 	free(node_blk);
 }
 
+static int has_dirent(u32 blk_addr, int is_inline)
+{
+	struct f2fs_node *node_blk;
+	int ret, is_dentry = 0;
+
+	node_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk);
+
+	ret = dev_read_block(node_blk, blk_addr);
+	ASSERT(ret >= 0);
+
+	if (IS_INODE(node_blk) && S_ISDIR(le16_to_cpu(node_blk->i.i_mode)))
+		is_dentry = 1;
+
+	if (is_inline && !(node_blk->i.i_inline & F2FS_INLINE_DENTRY))
+		is_dentry = 0;
+
+	free(node_blk);
+
+	return is_dentry;
+}
+
+static void dump_dirent(u32 blk_addr, int is_inline)
+{
+	struct f2fs_dentry_ptr d;
+	void *inline_dentry, *blk;
+	int ret, i = 0;
+
+	blk = calloc(BLOCK_SZ, 1);
+	ASSERT(blk);
+
+	ret = dev_read_block(blk, blk_addr);
+	ASSERT(ret >= 0);
+
+	if (is_inline) {
+		inline_dentry = inline_data_addr((struct f2fs_node *)blk);
+		make_dentry_ptr(&d, blk, inline_dentry, 2);
+	} else {
+		make_dentry_ptr(&d, NULL, blk, 1);
+	}
+
+	DBG(1, "%sDentry block:\n", is_inline ? "Inline " : "");
+
+	while (i < d.max) {
+		struct f2fs_dir_entry *de;
+
+		if (!test_bit_le(i, d.bitmap)) {
+			i++;
+			continue;
+		}
+
+		de = &d.dentry[i];
+
+		if (!de->name_len) {
+			i++;
+			continue;
+		}
+
+		DBG(1, "bitmap pos[0x%x] name[%s] len[0x%x] hash[0x%x] ino[0x%x] type[0x%x]\n",
+				i,
+				d.filename[i],
+				le16_to_cpu(de->name_len),
+				le32_to_cpu(de->hash_code),
+				le32_to_cpu(de->ino),
+				de->file_type);
+
+		i += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
+	}
+
+	free(blk);
+}
+
 int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 {
 	nid_t nid;
@@ -667,12 +740,18 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 		dump_node_from_blkaddr(sbi, ino_ni.blk_addr);
 		dump_data_offset(sbi, ni.blk_addr,
 			le16_to_cpu(sum_entry.ofs_in_node));
+
+		if (has_dirent(ino_ni.blk_addr, 0))
+			dump_dirent(blk_addr, 0);
 	} else {
 		MSG(0, "FS Userdata Area: Node block from 0x%x\n", blk_addr);
 		if (ni.ino == ni.nid) {
 			MSG(0, " - Inode block       : id = 0x%x from 0x%x\n",
 					ni.ino, ino_ni.blk_addr);
 			dump_node_from_blkaddr(sbi, ino_ni.blk_addr);
+
+			if (has_dirent(ino_ni.blk_addr, 1))
+				dump_dirent(blk_addr, 1);
 		} else {
 			MSG(0, " - Node block        : id = 0x%x from 0x%x\n",
 					nid, ni.blk_addr);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
