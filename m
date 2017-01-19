From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 1/2] f2fs-tools: correct endianness
Date: Thu, 19 Jan 2017 11:03:40 +0800
Message-ID: <20170119030341.12636-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1cU3C1-0007lE-2x
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jan 2017 03:15:17 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cU3By-0006fQ-62
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jan 2017 03:15:17 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: k@vodka.home.kg, piotr.karbowski@gmail.com, linux-f2fs-devel@lists.sourceforge.net

It is reported that fsck.f2fs behaves abnormally when running on MIPS32
rel 2 big endian cpu, since incorrect endianness. So let's correct all
endianess issues of f2fs-tools.

Reported-by: <k@vodka.home.kg>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/dir.c        |  6 +++---
 fsck/dump.c       | 10 +++++-----
 fsck/f2fs.h       |  4 ++--
 fsck/mount.c      | 12 ++++++------
 fsck/node.c       |  2 +-
 fsck/segment.c    |  3 ++-
 include/f2fs_fs.h |  8 +++++---
 7 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 2009855..d817d27 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -134,7 +134,7 @@ static int find_in_level(struct f2fs_sb_info *sbi,struct f2fs_node *dir,
 	struct dnode_of_data dn = {0};
 	void *dentry_blk;
 	int max_slots = 214;
-	nid_t ino = dir->footer.ino;
+	nid_t ino = le32_to_cpu(dir->footer.ino);
 	f2fs_hash_t namehash;
 	int ret = 0;
 
@@ -191,7 +191,7 @@ static int f2fs_find_entry(struct f2fs_sb_info *sbi,
 		return 0;
 	}
 
-	max_depth = dir->i.i_current_depth;
+	max_depth = le32_to_cpu(dir->i.i_current_depth);
 	for (level = 0; level < max_depth; level ++) {
 		if (find_in_level(sbi, dir, level, de))
 			return 1;
@@ -209,7 +209,7 @@ static void f2fs_update_dentry(nid_t ino, umode_t mode,
 	int i;
 
 	de = &d->dentry[bit_pos];
-	de->name_len = len;
+	de->name_len = cpu_to_le16(len);
 	de->hash_code = name_hash;
 	memcpy(d->filename[bit_pos], name, len);
 	d->filename[bit_pos][len] = 0;
diff --git a/fsck/dump.c b/fsck/dump.c
index 8e7c85c..e9d442f 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -81,7 +81,7 @@ void nat_dump(struct f2fs_sb_info *sbi)
 						"nid:%5u\tino:%5u\toffset:%5u"
 						"\tblkaddr:%10u\tpack:%d\n",
 						ni.nid, ni.ino,
-						node_block->footer.flag >>
+						le32_to_cpu(node_block->footer.flag) >>
 							OFFSET_BIT_SHIFT,
 						ni.blk_addr, pack);
 					ret = write(fd, buf, strlen(buf));
@@ -100,7 +100,7 @@ void nat_dump(struct f2fs_sb_info *sbi)
 					"nid:%5u\tino:%5u\toffset:%5u"
 					"\tblkaddr:%10u\tpack:%d\n",
 					ni.nid, ni.ino,
-					node_block->footer.flag >>
+					le32_to_cpu(node_block->footer.flag) >>
 						OFFSET_BIT_SHIFT,
 					ni.blk_addr, pack);
 				ret = write(fd, buf, strlen(buf));
@@ -335,13 +335,13 @@ static void dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	for (i = 0; i < 5; i++) {
 		if (i == 0 || i == 1)
 			dump_node_blk(sbi, TYPE_DIRECT_NODE,
-					node_blk->i.i_nid[i], &ofs);
+					le32_to_cpu(node_blk->i.i_nid[i]), &ofs);
 		else if (i == 2 || i == 3)
 			dump_node_blk(sbi, TYPE_INDIRECT_NODE,
-					node_blk->i.i_nid[i], &ofs);
+					le32_to_cpu(node_blk->i.i_nid[i]), &ofs);
 		else if (i == 4)
 			dump_node_blk(sbi, TYPE_DOUBLE_INDIRECT_NODE,
-					node_blk->i.i_nid[i], &ofs);
+					le32_to_cpu(node_blk->i.i_nid[i]), &ofs);
 		else
 			ASSERT(0);
 	}
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index fbb878a..1ac28eb 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -361,7 +361,7 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 static inline bool IS_VALID_NID(struct f2fs_sb_info *sbi, u32 nid)
 {
 	return (nid <= (NAT_ENTRY_PER_BLOCK *
-			F2FS_RAW_SUPER(sbi)->segment_count_nat
+			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_nat)
 			<< (sbi->log_blocks_per_seg - 1)));
 }
 
@@ -369,7 +369,7 @@ static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
 {
 	int i;
 
-	if (addr >= F2FS_RAW_SUPER(sbi)->block_count ||
+	if (addr >= le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count) ||
 				addr < SM_I(sbi)->main_blkaddr) {
 		DBG(1, "block addr [0x%x]\n", addr);
 		return 0;
diff --git a/fsck/mount.c b/fsck/mount.c
index 9fcb008..0144e97 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1375,12 +1375,12 @@ void build_sit_area_bitmap(struct f2fs_sb_info *sbi)
 		ptr += SIT_VBLOCK_MAP_SIZE;
 
 		if (se->valid_blocks == 0x0) {
-			if (sbi->ckpt->cur_node_segno[0] == segno ||
-					sbi->ckpt->cur_data_segno[0] == segno ||
-					sbi->ckpt->cur_node_segno[1] == segno ||
-					sbi->ckpt->cur_data_segno[1] == segno ||
-					sbi->ckpt->cur_node_segno[2] == segno ||
-					sbi->ckpt->cur_data_segno[2] == segno) {
+			if (le32_to_cpu(sbi->ckpt->cur_node_segno[0]) == segno ||
+				le32_to_cpu(sbi->ckpt->cur_data_segno[0]) == segno ||
+				le32_to_cpu(sbi->ckpt->cur_node_segno[1]) == segno ||
+				le32_to_cpu(sbi->ckpt->cur_data_segno[1]) == segno ||
+				le32_to_cpu(sbi->ckpt->cur_node_segno[2]) == segno ||
+				le32_to_cpu(sbi->ckpt->cur_data_segno[2]) == segno) {
 				continue;
 			} else {
 				free_segs++;
diff --git a/fsck/node.c b/fsck/node.c
index c2f83b8..fe923e5 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -78,7 +78,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
 
 	type = CURSEG_COLD_NODE;
 	if (IS_DNODE(node_blk)) {
-		if (S_ISDIR(f2fs_inode->i.i_mode))
+		if (S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)))
 			type = CURSEG_HOT_NODE;
 		else
 			type = CURSEG_WARM_NODE;
diff --git a/fsck/segment.c b/fsck/segment.c
index 9ce8bf5..6b2f6c1 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -80,7 +80,8 @@ static void f2fs_write_block(struct f2fs_sb_info *sbi, nid_t ino, void *buffer,
 	ret = dev_read_block(inode, ni.blk_addr);
 	ASSERT(ret >= 0);
 
-	if (S_ISDIR(inode->i.i_mode) || S_ISLNK(inode->i.i_mode))
+	if (S_ISDIR(le16_to_cpu(inode->i.i_mode)) ||
+			S_ISLNK(le16_to_cpu(inode->i.i_mode)))
 		ASSERT(0);
 
 	off_in_block = offset & ((1 << F2FS_BLKSIZE_BITS) - 1);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 78ea939..ef34ca2 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -170,15 +170,17 @@ static inline uint64_t bswap_64(uint64_t val)
 #define DISP_u32(ptr, member)						\
 	do {								\
 		assert(sizeof((ptr)->member) <= 4);			\
-		printf("%-30s" "\t\t[0x%8x : %u]\n",		\
-			#member, ((ptr)->member), ((ptr)->member));	\
+		printf("%-30s" "\t\t[0x%8x : %u]\n",			\
+			#member, le32_to_cpu(((ptr)->member)),		\
+			le32_to_cpu(((ptr)->member)));			\
 	} while (0)
 
 #define DISP_u64(ptr, member)						\
 	do {								\
 		assert(sizeof((ptr)->member) == 8);			\
 		printf("%-30s" "\t\t[0x%8llx : %llu]\n",		\
-			#member, ((ptr)->member), ((ptr)->member));	\
+			#member, le64_to_cpu(((ptr)->member)),		\
+			le64_to_cpu(((ptr)->member)));			\
 	} while (0)
 
 #define DISP_utf(ptr, member)						\
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
