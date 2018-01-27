From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs-tools: support {d, id, did,
 x}node checksum
Date: Sat, 27 Jan 2018 17:44:30 +0800
Message-ID: <20180127094430.29483-2-yuchao0@huawei.com>
References: <20180127094430.29483-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1efN2X-0005QL-1o
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:44:49 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1efN2V-00067z-F1
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:44:48 +0000
In-Reply-To: <20180127094430.29483-1-yuchao0@huawei.com>
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

This patch adds a new feature 'node_checksum' which will be only enabled
with 'extended_node' feature, with it, we can do non-inode checksum
verification in both kernel and userspace side.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dir.c              |  2 +-
 fsck/f2fs.h             |  5 ++++
 fsck/fsck.c             | 74 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fsck/mount.c            |  3 ++
 fsck/segment.c          |  2 +-
 include/f2fs_fs.h       | 13 +++++++--
 lib/libf2fs.c           | 22 +++++++++------
 mkfs/f2fs_format.c      |  4 +--
 mkfs/f2fs_format_main.c |  4 +++
 9 files changed, 113 insertions(+), 16 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index b2ea18f083fb..c6bab894895e 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -455,7 +455,7 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
 		node_blk->i.i_inode_checksum =
-			cpu_to_le32(f2fs_inode_chksum(node_blk));
+			cpu_to_le32(f2fs_node_chksum(node_blk));
 }
 
 int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 8a5ce365282d..a1de45abb3a1 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -456,6 +456,11 @@ static inline int inline_xattr_size(struct f2fs_inode *inode)
 	return get_inline_xattr_addrs(inode) * sizeof(__le32);
 }
 
+#define F2FS_FITS_IN_NODE(extra_nsize, field)		\
+		((offsetof(struct f2fs_node, footer) -	\
+		offsetof(struct f2fs_node, field))	\
+		<= (extra_nsize))			\
+
 extern int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_nat_entry *ne);
 #define IS_SUM_NODE_SEG(footer)		(footer.entry_type == SUM_TYPE_NODE)
 #define IS_SUM_DATA_SEG(footer)		(footer.entry_type == SUM_TYPE_DATA)
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6c1b9a735754..98321186991b 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -933,7 +933,7 @@ skip_blkcnt_fix:
 		__u32 provided, calculated;
 
 		provided = le32_to_cpu(node_blk->i.i_inode_checksum);
-		calculated = f2fs_inode_chksum(node_blk);
+		calculated = f2fs_node_chksum(node_blk);
 
 		if (provided != calculated) {
 			ASSERT_MSG("ino: 0x%x chksum:0x%x, but calculated one is: 0x%x",
@@ -983,6 +983,31 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			FIX_MSG("[0x%x] dn.addr[%d] = 0", nid, idx);
 		}
 	}
+
+	if ((c.feature & cpu_to_le32(F2FS_FEATURE_EXTENDED_NODE)) &&
+			F2FS_FITS_IN_NODE(c.extra_nsize, node_checksum)) {
+		__u32 provided, calculated;
+
+		provided = le32_to_cpu(node_blk->node_checksum);
+		calculated = f2fs_node_chksum(node_blk);
+
+		if (provided != calculated) {
+			ASSERT_MSG("ino: 0x%x, nid: 0x%x, chksum:0x%x, but calculated one is: 0x%x",
+				le32_to_cpu(node_blk->footer.ino),
+				le32_to_cpu(node_blk->footer.nid),
+				provided, calculated);
+			if (c.fix_on) {
+				node_blk->node_checksum =
+							cpu_to_le32(calculated);
+				need_fix = 1;
+				FIX_MSG("ino: 0x%x, nid: 0x%x, recover node_checksum= 0x%x -> 0x%x",
+					le32_to_cpu(node_blk->footer.ino),
+					le32_to_cpu(node_blk->footer.nid),
+					provided, calculated);
+			}
+		}
+	}
+
 	if (need_fix && !c.ro) {
 		ret = dev_write_block(node_blk, ni->blk_addr);
 		ASSERT(ret >= 0);
@@ -1018,6 +1043,30 @@ skip:
 		}
 	}
 
+	if ((c.feature & cpu_to_le32(F2FS_FEATURE_EXTENDED_NODE)) &&
+			F2FS_FITS_IN_NODE(c.extra_nsize, node_checksum)) {
+		__u32 provided, calculated;
+
+		provided = le32_to_cpu(node_blk->node_checksum);
+		calculated = f2fs_node_chksum(node_blk);
+
+		if (provided != calculated) {
+			ASSERT_MSG("ino: 0x%x, nid: 0x%x, chksum:0x%x, but calculated one is: 0x%x",
+				le32_to_cpu(node_blk->footer.ino),
+				le32_to_cpu(node_blk->footer.nid),
+				provided, calculated);
+			if (c.fix_on) {
+				node_blk->node_checksum =
+							cpu_to_le32(calculated);
+				need_fix = 1;
+				FIX_MSG("ino: 0x%x, nid: 0x%x, recover node_checksum= 0x%x -> 0x%x",
+					le32_to_cpu(node_blk->footer.ino),
+					le32_to_cpu(node_blk->footer.nid),
+					provided, calculated);
+			}
+		}
+	}
+
 	if (need_fix && !c.ro) {
 		struct node_info ni;
 		nid_t nid = le32_to_cpu(node_blk->footer.nid);
@@ -1058,6 +1107,29 @@ skip:
 		}
 	}
 
+	if ((c.feature & cpu_to_le32(F2FS_FEATURE_EXTENDED_NODE)) &&
+			F2FS_FITS_IN_NODE(c.extra_nsize, node_checksum)) {
+		__u32 provided, calculated;
+
+		provided = le32_to_cpu(node_blk->node_checksum);
+		calculated = f2fs_node_chksum(node_blk);
+
+		if (provided != calculated) {
+			ASSERT_MSG("ino: 0x%x, nid: 0x%x, chksum:0x%x, but calculated one is: 0x%x",
+				le32_to_cpu(node_blk->footer.ino),
+				le32_to_cpu(node_blk->footer.nid),
+				provided, calculated);
+			if (c.fix_on) {
+				node_blk->node_checksum =
+							cpu_to_le32(calculated);
+				need_fix = 1;
+				FIX_MSG("ino: 0x%x, nid: 0x%x, recover node_checksum= 0x%x -> 0x%x",
+					le32_to_cpu(node_blk->footer.ino),
+					le32_to_cpu(node_blk->footer.nid),
+					provided, calculated);
+			}
+		}
+	}
 	if (need_fix && !c.ro) {
 		struct node_info ni;
 		nid_t nid = le32_to_cpu(node_blk->footer.nid);
diff --git a/fsck/mount.c b/fsck/mount.c
index 016e52471f11..0a99017b2aed 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -463,6 +463,9 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_EXTENDED_NODE)) {
 		MSG(0, "%s", " extended_node");
 	}
+	if (f & cpu_to_le32(F2FS_FEATURE_NODE_CHECKSUM)) {
+		MSG(0, "%s", " node_checksum");
+	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
 					sb->encryption_level);
diff --git a/fsck/segment.c b/fsck/segment.c
index 4f8bdb4cbedd..0c4b93fd4e27 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -20,7 +20,7 @@ static void write_inode(u64 blkaddr, struct f2fs_node *inode)
 {
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
 		inode->i.i_inode_checksum =
-			cpu_to_le32(f2fs_inode_chksum(inode));
+			cpu_to_le32(f2fs_node_chksum(inode));
 	ASSERT(dev_write_block(inode, blkaddr) >= 0);
 }
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1692cd5433ca..c92860d68c86 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -554,6 +554,7 @@ enum {
 #define F2FS_FEATURE_QUOTA_INO		0x0080
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
 #define F2FS_FEATURE_EXTENDED_NODE	0x0200
+#define F2FS_FEATURE_NODE_CHECKSUM	0x0400
 
 #define MAX_VOLUME_NAME		512
 
@@ -847,8 +848,14 @@ struct f2fs_node {
 	/* can be one of three types: inode, direct, and indirect types */
 	union {
 		struct f2fs_inode i;
-		struct direct_node dn;
-		struct indirect_node in;
+		union {
+			struct {
+				__le32 data[1017];
+				__le32 node_checksum;
+			};
+			struct direct_node dn;
+			struct indirect_node in;
+		};
 	};
 	struct node_footer footer;
 } __attribute__((packed));
@@ -1163,7 +1170,7 @@ extern int utf8_to_utf16(u_int16_t *, const char *, size_t, size_t);
 extern int utf16_to_utf8(char *, const u_int16_t *, size_t, size_t);
 extern int log_base_2(u_int32_t);
 extern unsigned int addrs_per_inode(struct f2fs_inode *);
-extern __u32 f2fs_inode_chksum(struct f2fs_node *);
+extern __u32 f2fs_node_chksum(struct f2fs_node *);
 
 extern int get_bits_in_byte(unsigned char n);
 extern int test_and_set_bit_le(u32, u8 *);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 61962cf7d461..5ca416e3ddb0 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -506,19 +506,25 @@ int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len)
 	return 0;
 }
 
-__u32 f2fs_inode_chksum(struct f2fs_node *node)
+__u32 f2fs_node_chksum(struct f2fs_node *node)
 {
 	struct f2fs_inode *ri = &node->i;
-	__le32 ino = node->footer.ino;
-	__le32 gen = ri->i_generation;
-	__u32 chksum, chksum_seed;
-	__u32 dummy_cs = 0;
-	unsigned int offset = offsetof(struct f2fs_inode, i_inode_checksum);
-	unsigned int cs_size = sizeof(dummy_cs);
+	__le32 append, ino = node->footer.ino;
+	__u32 chksum, chksum_seed, dummy_cs = 0;
+	unsigned int offset, cs_size = sizeof(dummy_cs);
+	bool is_inode = node->footer.nid == node->footer.ino;
+
+	if (is_inode) {
+		append = node->i.i_generation;
+		offset = offsetof(struct f2fs_inode, i_inode_checksum);
+	} else {
+		append = node->footer.nid;
+		offset = offsetof(struct f2fs_node, node_checksum);
+	}
 
 	chksum = f2fs_cal_crc32(c.chksum_seed, (__u8 *)&ino,
 							sizeof(ino));
-	chksum_seed = f2fs_cal_crc32(chksum, (__u8 *)&gen, sizeof(gen));
+	chksum_seed = f2fs_cal_crc32(chksum, (__u8 *)&append, sizeof(append));
 
 	chksum = f2fs_cal_crc32(chksum_seed, (__u8 *)ri, offset);
 	chksum = f2fs_cal_crc32(chksum, (__u8 *)&dummy_cs, cs_size);
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 51337b53a795..26a82ebe2768 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1063,7 +1063,7 @@ static int f2fs_write_root_inode(void)
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
 		raw_node->i.i_inode_checksum =
-			cpu_to_le32(f2fs_inode_chksum(raw_node));
+			cpu_to_le32(f2fs_node_chksum(raw_node));
 
 	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
 	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_HOT_NODE] *
@@ -1239,7 +1239,7 @@ static int f2fs_write_qf_inode(int qtype)
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
 		raw_node->i.i_inode_checksum =
-			cpu_to_le32(f2fs_inode_chksum(raw_node));
+			cpu_to_le32(f2fs_node_chksum(raw_node));
 
 	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
 	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_HOT_NODE] *
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 93922b0af068..46a6335e833e 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -97,6 +97,10 @@ static void parse_feature(const char *features)
 		c.feature |= cpu_to_le32(F2FS_FEATURE_INODE_CRTIME);
 	} else if (!strcmp(features, "extended_node")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_EXTENDED_NODE);
+	} else if (!strcmp(features, "node_checksum")) {
+		c.feature |= cpu_to_le32(F2FS_FEATURE_NODE_CHECKSUM);
+		c.extra_nsize = offsetof(struct f2fs_node, footer) -
+				offsetof(struct f2fs_node, node_checksum);
 	} else {
 		MSG(0, "Error: Wrong features\n");
 		mkfs_usage();
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
