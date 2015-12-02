From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] mkfs.f2fs: export get_{sb|cp} and set_{sb|cp}
Date: Wed,  2 Dec 2015 13:40:40 -0800
Message-ID: <1449092441-61376-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a4F8v-0005Ua-Qn
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Dec 2015 21:40:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a4F8u-0002QI-C7 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Dec 2015 21:40:53 +0000
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

This patch exports get_sb, set_sb, get_cp, and set_cp for other tools.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h  |  56 +++++++++++++++++++++++++++
 mkfs/f2fs_format.c | 108 +++++++++++++----------------------------------------
 2 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index c0bbfa4..a448d61 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -263,6 +263,62 @@ struct f2fs_configuration {
 #define BIT_MASK(nr)	(1 << (nr % BITS_PER_LONG))
 #define BIT_WORD(nr)	(nr / BITS_PER_LONG)
 
+#define set_sb_le64(member, val)		(sb->member = cpu_to_le64(val))
+#define set_sb_le32(member, val)		(sb->member = cpu_to_le32(val))
+#define set_sb_le16(member, val)		(sb->member = cpu_to_le16(val))
+#define get_sb_le64(member)			le64_to_cpu(sb->member)
+#define get_sb_le32(member)			le32_to_cpu(sb->member)
+#define get_sb_le16(member)			le16_to_cpu(sb->member)
+
+#define set_sb(member, val)	\
+			do {						\
+				typeof(sb->member) t;			\
+				switch (sizeof(t)) {			\
+				case 8: set_sb_le64(member, val); break; \
+				case 4: set_sb_le32(member, val); break; \
+				case 2: set_sb_le16(member, val); break; \
+				} \
+			} while(0)
+
+#define get_sb(member)		\
+			({						\
+				typeof(sb->member) t;			\
+				switch (sizeof(t)) {			\
+				case 8: t = get_sb_le64(member); break; \
+				case 4: t = get_sb_le32(member); break; \
+				case 2: t = get_sb_le16(member); break; \
+				} 					\
+				t; \
+			})
+
+#define set_cp_le64(member, val)		(cp->member = cpu_to_le64(val))
+#define set_cp_le32(member, val)		(cp->member = cpu_to_le32(val))
+#define set_cp_le16(member, val)		(cp->member = cpu_to_le16(val))
+#define get_cp_le64(member)			le64_to_cpu(cp->member)
+#define get_cp_le32(member)			le32_to_cpu(cp->member)
+#define get_cp_le16(member)			le16_to_cpu(cp->member)
+
+#define set_cp(member, val)	\
+			do {						\
+				typeof(cp->member) t;			\
+				switch (sizeof(t)) {			\
+				case 8: set_cp_le64(member, val); break; \
+				case 4: set_cp_le32(member, val); break; \
+				case 2: set_cp_le16(member, val); break; \
+				} \
+			} while(0)
+
+#define get_cp(member)		\
+			({						\
+				typeof(cp->member) t;			\
+				switch (sizeof(t)) {			\
+				case 8: t = get_cp_le64(member); break; \
+				case 4: t = get_cp_le32(member); break; \
+				case 2: t = get_cp_le16(member); break; \
+				} 					\
+				t; \
+			})
+
 /*
  * Copied from fs/f2fs/f2fs.h
  */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 212df60..7dc8d3a 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -22,7 +22,8 @@
 #include "f2fs_format_utils.h"
 
 extern struct f2fs_configuration config;
-struct f2fs_super_block sb;
+struct f2fs_super_block raw_sb;
+struct f2fs_super_block *sb = &raw_sb;
 struct f2fs_checkpoint *cp;
 
 /* Return first segment number of each area */
@@ -31,63 +32,6 @@ struct f2fs_checkpoint *cp;
 #define last_zone(cur)		((cur - 1) * config.segs_per_zone)
 #define last_section(cur)	(cur + (config.secs_per_zone - 1) * config.segs_per_sec)
 
-#define set_sb_le64(member, val)		(sb.member = cpu_to_le64(val))
-#define set_sb_le32(member, val)		(sb.member = cpu_to_le32(val))
-#define set_sb_le16(member, val)		(sb.member = cpu_to_le16(val))
-#define get_sb_le64(member)			le64_to_cpu(sb.member)
-#define get_sb_le32(member)			le32_to_cpu(sb.member)
-#define get_sb_le16(member)			le16_to_cpu(sb.member)
-
-#define set_sb(member, val)	\
-			do {						\
-				typeof(sb.member) t;			\
-				switch (sizeof(t)) {			\
-				case 8: set_sb_le64(member, val); break; \
-				case 4: set_sb_le32(member, val); break; \
-				case 2: set_sb_le16(member, val); break; \
-				} \
-			} while(0)
-
-#define get_sb(member)		\
-			({						\
-				typeof(sb.member) t;			\
-				switch (sizeof(t)) {			\
-				case 8: t = get_sb_le64(member); break; \
-				case 4: t = get_sb_le32(member); break; \
-				case 2: t = get_sb_le16(member); break; \
-				} 					\
-				t; \
-			})
-
-#define set_cp_le64(member, val)		(cp->member = cpu_to_le64(val))
-#define set_cp_le32(member, val)		(cp->member = cpu_to_le32(val))
-#define set_cp_le16(member, val)		(cp->member = cpu_to_le16(val))
-#define get_cp_le64(member)			le64_to_cpu(cp->member)
-#define get_cp_le32(member)			le32_to_cpu(cp->member)
-#define get_cp_le16(member)			le16_to_cpu(cp->member)
-
-#define set_cp(member, val)	\
-			do {						\
-				typeof(cp->member) t;			\
-				switch (sizeof(t)) {			\
-				case 8: set_cp_le64(member, val); break; \
-				case 4: set_cp_le32(member, val); break; \
-				case 2: set_cp_le16(member, val); break; \
-				} \
-			} while(0)
-
-#define get_cp(member)		\
-			({						\
-				typeof(cp->member) t;			\
-				switch (sizeof(t)) {			\
-				case 8: t = get_cp_le64(member); break; \
-				case 4: t = get_cp_le32(member); break; \
-				case 2: t = get_cp_le16(member); break; \
-				} 					\
-				t; \
-			})
-
-
 const char *media_ext_lists[] = {
 	"jpg",
 	"gif",
@@ -139,13 +83,12 @@ static void configure_extension_list(void)
 	int name_len;
 	int i = 0;
 
-	sb.extension_count = 0;
-	memset(sb.extension_list, 0,
-			sizeof(sb.extension_list));
+	set_sb(extension_count, 0);
+	memset(sb->extension_list, 0, sizeof(sb->extension_list));
 
 	while (*extlist) {
 		name_len = strlen(*extlist);
-		memcpy(sb.extension_list[i++], *extlist, name_len);
+		memcpy(sb->extension_list[i++], *extlist, name_len);
 		extlist++;
 	}
 	set_sb(extension_count, i);
@@ -240,7 +183,7 @@ static int f2fs_prepare_super_block(void)
 		blk_size_bytes * config.secs_per_zone *
 		config.segs_per_sec * config.blks_per_seg;
 
-	sb.checksum_offset = 0;
+	set_sb(checksum_offset, 0);
 
 	set_sb(block_count, config.total_sectors >> log_sectors_per_block);
 
@@ -262,7 +205,7 @@ static int f2fs_prepare_super_block(void)
 				zone_align_start_offset) / segment_size_bytes);
 
 	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
-	sb.cp_blkaddr = sb.segment0_blkaddr;
+	sb->cp_blkaddr = sb->segment0_blkaddr;
 
 	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n", get_sb(segment0_blkaddr));
 
@@ -311,7 +254,7 @@ static int f2fs_prepare_super_block(void)
 	} else {
 		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
 			- max_sit_bitmap_size;
-		sb.cp_payload = 0;
+		set_sb(cp_payload, 0);
 	}
 
 	max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
@@ -374,9 +317,9 @@ static int f2fs_prepare_super_block(void)
 		return -1;
 	}
 
-	uuid_generate(sb.uuid);
+	uuid_generate(sb->uuid);
 
-	ASCIIToUNICODE(sb.volume_name, (u_int8_t *)config.vol_label);
+	ASCIIToUNICODE(sb->volume_name, (u_int8_t *)config.vol_label);
 
 	set_sb(node_ino, 1);
 	set_sb(meta_ino, 2);
@@ -416,10 +359,10 @@ static int f2fs_prepare_super_block(void)
 		memset(config.version, 0, VERSION_LEN);
 	}
 
-	memcpy(sb.version, config.version, VERSION_LEN);
-	memcpy(sb.init_version, config.version, VERSION_LEN);
+	memcpy(sb->version, config.version, VERSION_LEN);
+	memcpy(sb->init_version, config.version, VERSION_LEN);
 
-	sb.feature = config.feature;
+	sb->feature = config.feature;
 
 	return 0;
 }
@@ -618,9 +561,9 @@ static int f2fs_write_check_point_pack(void)
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
 
 	sum->n_nats = cpu_to_le16(1);
-	sum->nat_j.entries[0].nid = sb.root_ino;
+	sum->nat_j.entries[0].nid = sb->root_ino;
 	sum->nat_j.entries[0].ne.version = 0;
-	sum->nat_j.entries[0].ne.ino = sb.root_ino;
+	sum->nat_j.entries[0].ne.ino = sb->root_ino;
 	sum->nat_j.entries[0].ne.block_addr = cpu_to_le32(
 			get_sb(main_blkaddr) +
 			get_cp(cur_node_segno[0]) * config.blks_per_seg);
@@ -653,7 +596,7 @@ static int f2fs_write_check_point_pack(void)
 
 	/* hot data summary */
 	sum_entry = (struct f2fs_summary *)sum_compact_p;
-	sum_entry->nid = sb.root_ino;
+	sum_entry->nid = sb->root_ino;
 	sum_entry->ofs_in_node = 0;
 	/* warm data summary, nothing to do */
 	/* cold data summary, nothing to do */
@@ -670,7 +613,7 @@ static int f2fs_write_check_point_pack(void)
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_NODE);
 
-	sum->entries[0].nid = sb.root_ino;
+	sum->entries[0].nid = sb->root_ino;
 	sum->entries[0].ofs_in_node = 0;
 
 	cp_seg_blk_offset += blk_size_bytes;
@@ -767,8 +710,7 @@ static int f2fs_write_super_block(void)
 
 	zero_buff = calloc(F2FS_BLKSIZE, 1);
 
-	memcpy(zero_buff + F2FS_SUPER_OFFSET, &sb,
-						sizeof(sb));
+	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
 	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
 	for (index = 0; index < 2; index++) {
 		if (dev_write(zero_buff, index * F2FS_BLKSIZE, F2FS_BLKSIZE)) {
@@ -795,8 +737,8 @@ static int f2fs_write_root_inode(void)
 		return -1;
 	}
 
-	raw_node->footer.nid = sb.root_ino;
-	raw_node->footer.ino = sb.root_ino;
+	raw_node->footer.nid = sb->root_ino;
+	raw_node->footer.ino = sb->root_ino;
 	raw_node->footer.cp_ver = cpu_to_le64(1);
 	raw_node->footer.next_blkaddr = cpu_to_le32(
 			get_sb(main_blkaddr) +
@@ -877,15 +819,15 @@ static int f2fs_update_nat_root(void)
 	nat_blk->entries[get_sb(root_ino)].block_addr = cpu_to_le32(
 		get_sb(main_blkaddr) +
 		config.cur_seg[CURSEG_HOT_NODE] * config.blks_per_seg);
-	nat_blk->entries[get_sb(root_ino)].ino = sb.root_ino;
+	nat_blk->entries[get_sb(root_ino)].ino = sb->root_ino;
 
 	/* update node nat */
 	nat_blk->entries[get_sb(node_ino)].block_addr = cpu_to_le32(1);
-	nat_blk->entries[get_sb(node_ino)].ino = sb.node_ino;
+	nat_blk->entries[get_sb(node_ino)].ino = sb->node_ino;
 
 	/* update meta nat */
 	nat_blk->entries[get_sb(meta_ino)].block_addr = cpu_to_le32(1);
-	nat_blk->entries[get_sb(meta_ino)].ino = sb.meta_ino;
+	nat_blk->entries[get_sb(meta_ino)].ino = sb->meta_ino;
 
 	blk_size_bytes = 1 << get_sb(log_blocksize);
 	nat_seg_blk_offset = get_sb(nat_blkaddr);
@@ -914,13 +856,13 @@ static int f2fs_add_default_dentry_root(void)
 	}
 
 	dent_blk->dentry[0].hash_code = 0;
-	dent_blk->dentry[0].ino = sb.root_ino;
+	dent_blk->dentry[0].ino = sb->root_ino;
 	dent_blk->dentry[0].name_len = cpu_to_le16(1);
 	dent_blk->dentry[0].file_type = F2FS_FT_DIR;
 	memcpy(dent_blk->filename[0], ".", 1);
 
 	dent_blk->dentry[1].hash_code = 0;
-	dent_blk->dentry[1].ino = sb.root_ino;
+	dent_blk->dentry[1].ino = sb->root_ino;
 	dent_blk->dentry[1].name_len = cpu_to_le16(2);
 	dent_blk->dentry[1].file_type = F2FS_FT_DIR;
 	memcpy(dent_blk->filename[1], "..", 2);
-- 
2.4.9 (Apple Git-60)


------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
