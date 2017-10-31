From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] mkfs.f2fs: support quota option in mkfs
Date: Mon, 30 Oct 2017 20:42:05 -0700
Message-ID: <20171031034206.26890-3-jaegeuk@kernel.org>
References: <20171031034206.26890-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e9NRQ-00080y-GT
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:42:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e9NRO-0005m8-HZ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:42:16 +0000
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

This patch let mkfs to handle quota option and create quota files.

Signed-off-by: Hyojun Kim <hyojun@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 include/f2fs_fs.h       |  21 +++-
 include/quota.h         |  77 ++++++++++++++
 mkfs/f2fs_format.c      | 278 +++++++++++++++++++++++++++++++++++++++++++++---
 mkfs/f2fs_format_main.c |   2 +
 4 files changed, 363 insertions(+), 15 deletions(-)
 create mode 100644 include/quota.h

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 9f56388..d26b7cf 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -458,6 +458,13 @@ enum {
 #define F2FS_NODE_INO(sbi)	(sbi->node_ino_num)
 #define F2FS_META_INO(sbi)	(sbi->meta_ino_num)
 
+#define F2FS_QUOTA_INO		3
+#define F2FS_MAX_QUOTAS		3
+#define QUOTA_DATA(i)		(2)
+#define QUOTA_INO(sb,t)	(le32_to_cpu((sb)->qf_ino[t]))
+
+#define FS_IMMUTABLE_FL		0x00000010 /* Immutable file */
+
 /* This flag is used by node and meta inodes, and by recovery */
 #define GFP_F2FS_ZERO	(GFP_NOFS | __GFP_ZERO)
 
@@ -478,6 +485,7 @@ enum {
 #define F2FS_FEATURE_PRJQUOTA		0x0010
 #define F2FS_FEATURE_INODE_CHKSUM	0x0020
 #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
+#define F2FS_FEATURE_QUOTA_INO		0x0080
 
 #define MAX_VOLUME_NAME		512
 
@@ -528,7 +536,8 @@ struct f2fs_super_block {
 	__u8 encryption_level;		/* versioning level for encryption */
 	__u8 encrypt_pw_salt[16];	/* Salt used for string2key algorithm */
 	struct f2fs_device devs[MAX_DEVICES];	/* device list */
-	__u8 reserved[327];		/* valid reserved region */
+	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
+	__u8 reserved[315];		/* valid reserved region */
 } __attribute__((packed));
 
 /*
@@ -1171,4 +1180,14 @@ static inline __le64 get_cp_crc(struct f2fs_checkpoint *cp)
 	return cpu_to_le64(cp_ver);
 }
 
+static inline int is_qf_ino(struct f2fs_super_block *sb, nid_t ino)
+{
+	int i;
+
+	for (i = 0; i < F2FS_MAX_QUOTAS; i++)
+		if (sb->qf_ino[i] == ino)
+			return 1;
+	return 0;
+}
+
 #endif	/*__F2FS_FS_H */
diff --git a/include/quota.h b/include/quota.h
new file mode 100644
index 0000000..4c9f5f4
--- /dev/null
+++ b/include/quota.h
@@ -0,0 +1,77 @@
+/*
+ *
+ * Header file for disk format of new quotafile format
+ *
+ * Copied essential definitions and structures for mkfs.f2fs from quotaio.h
+ *
+ * Aditya Kali <adityakali@google.com>
+ * Jan Kara <jack@suse.cz>
+ * Hyojun Kim <hyojun@google.com> - Ported to f2fs-tools
+ *
+ */
+#ifndef F2FS_QUOTA_H
+#define F2FS_QUOTA_H
+
+enum quota_type {
+	USRQUOTA = 0,
+	GRPQUOTA = 1,
+	PRJQUOTA = 2,
+	MAXQUOTAS = 3,
+};
+
+#if MAXQUOTAS > 32
+#error "cannot have more than 32 quota types to fit in qtype_bits"
+#endif
+
+#define QUOTA_USR_BIT (1 << USRQUOTA)
+#define QUOTA_GRP_BIT (1 << GRPQUOTA)
+#define QUOTA_PRJ_BIT (1 << PRJQUOTA)
+#define QUOTA_ALL_BIT (QUOTA_USR_BIT | QUOTA_GRP_BIT | QUOTA_PRJ_BIT)
+
+/*
+ * Definitions of magics and versions of current quota files
+ */
+#define INITQMAGICS {\
+	0xd9c01f11,	/* USRQUOTA */\
+	0xd9c01927,	/* GRPQUOTA */\
+	0xd9c03f14      /* PRJQUOTA */\
+}
+
+#define V2_DQINFOOFF	sizeof(struct v2_disk_dqheader)	/* Offset of info header in file */
+
+#define MAX_IQ_TIME  604800	/* (7*24*60*60) 1 week */
+#define MAX_DQ_TIME  604800	/* (7*24*60*60) 1 week */
+
+#define QT_TREEOFF	1	/* Offset of tree in file in blocks */
+
+struct v2_disk_dqheader {
+	u_int32_t dqh_magic;	/* Magic number identifying file */
+	u_int32_t dqh_version;	/* File version */
+} __attribute__ ((packed));
+
+/* Header with type and version specific information */
+struct v2_disk_dqinfo {
+	u_int32_t dqi_bgrace;	/* Time before block soft limit becomes hard limit */
+	u_int32_t dqi_igrace;	/* Time before inode soft limit becomes hard limit */
+	u_int32_t dqi_flags;	/* Flags for quotafile (DQF_*) */
+	u_int32_t dqi_blocks;	/* Number of blocks in file */
+	u_int32_t dqi_free_blk;	/* Number of first free block in the list */
+	u_int32_t dqi_free_entry;	/* Number of block with at least one free entry */
+} __attribute__ ((packed));
+
+struct v2r1_disk_dqblk {
+	__le32 dqb_id;  	/* id this quota applies to */
+	__le32 dqb_pad;
+	__le64 dqb_ihardlimit;  /* absolute limit on allocated inodes */
+	__le64 dqb_isoftlimit;  /* preferred inode limit */
+	__le64 dqb_curinodes;   /* current # allocated inodes */
+	__le64 dqb_bhardlimit;  /* absolute limit on disk space
+				 * (in QUOTABLOCK_SIZE) */
+	__le64 dqb_bsoftlimit;  /* preferred limit on disk space
+				 * (in QUOTABLOCK_SIZE) */
+	__le64 dqb_curspace;    /* current space occupied (in bytes) */
+	__le64 dqb_btime;       /* time limit for excessive disk use */
+	__le64 dqb_itime;       /* time limit for excessive inode use */
+} __attribute__ ((packed));
+
+#endif
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 8a821d3..c809225 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -19,6 +19,7 @@
 #include <uuid/uuid.h>
 
 #include "f2fs_fs.h"
+#include "quota.h"
 #include "f2fs_format_utils.h"
 
 extern struct f2fs_configuration c;
@@ -32,6 +33,8 @@ struct f2fs_checkpoint *cp;
 #define last_zone(cur)		((cur - 1) * c.segs_per_zone)
 #define last_section(cur)	(cur + (c.secs_per_zone - 1) * c.segs_per_sec)
 
+static unsigned int quotatype_bits = 0;
+
 const char *media_ext_lists[] = {
 	"jpg",
 	"gif",
@@ -153,6 +156,8 @@ static int f2fs_prepare_super_block(void)
 	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
 	u_int32_t max_nat_bitmap_size, max_nat_segments;
 	u_int32_t total_zones;
+	u_int32_t next_ino;
+	enum quota_type qtype;
 	int i;
 
 	set_sb(magic, F2FS_SUPER_MAGIC);
@@ -382,6 +387,17 @@ static int f2fs_prepare_super_block(void)
 	set_sb(node_ino, 1);
 	set_sb(meta_ino, 2);
 	set_sb(root_ino, 3);
+	next_ino = 4;
+
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
+		quotatype_bits = QUOTA_USR_BIT | QUOTA_GRP_BIT;
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
+			quotatype_bits |= QUOTA_PRJ_BIT;
+	}
+
+	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++)
+		sb->qf_ino[qtype] =
+			((1 << qtype) & quotatype_bits) ? next_ino++ : 0;
 
 	if (total_zones <= 6) {
 		MSG(1, "\tError: %d zones: Need more zones "
@@ -513,6 +529,9 @@ static int f2fs_write_check_point_pack(void)
 	char *cp_payload = NULL;
 	char *sum_compact, *sum_compact_p;
 	struct f2fs_summary *sum_entry;
+	enum quota_type qtype;
+	u_int32_t quota_inum, quota_dnum;
+	int off;
 	int ret = -1;
 
 	cp = calloc(F2FS_BLKSIZE, 1);
@@ -562,9 +581,16 @@ static int f2fs_write_check_point_pack(void)
 		set_cp(cur_data_segno[i], 0xffffffff);
 	}
 
-	set_cp(cur_node_blkoff[0], 1);
-	set_cp(cur_data_blkoff[0], 1);
-	set_cp(valid_block_count, 2);
+	quota_inum = quota_dnum = 0;
+	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++)
+		if (sb->qf_ino[qtype]) {
+			quota_inum++;
+			quota_dnum += QUOTA_DATA(qtype);
+		}
+
+	set_cp(cur_node_blkoff[0], 1 + quota_inum);
+	set_cp(cur_data_blkoff[0], 1 + quota_dnum);
+	set_cp(valid_block_count, 2 + quota_inum + quota_dnum);
 	set_cp(rsvd_segment_count, c.reserved_segments);
 	set_cp(overprov_segment_count, (get_sb(segment_count_main) -
 			get_cp(rsvd_segment_count)) *
@@ -593,9 +619,9 @@ static int f2fs_write_check_point_pack(void)
 
 	set_cp(ckpt_flags, flags);
 	set_cp(cp_pack_start_sum, 1 + get_sb(cp_payload));
-	set_cp(valid_node_count, 1);
-	set_cp(valid_inode_count, 1);
-	set_cp(next_free_nid, get_sb(root_ino) + 1);
+	set_cp(valid_node_count, 1 + quota_inum);
+	set_cp(valid_inode_count, 1 + quota_inum);
+	set_cp(next_free_nid, get_sb(root_ino) + 1 + quota_inum);
 	set_cp(sit_ver_bitmap_bytesize, ((get_sb(segment_count_sit) / 2) <<
 			get_sb(log_blocks_per_seg)) / 8);
 
@@ -653,7 +679,7 @@ static int f2fs_write_check_point_pack(void)
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
 
 	journal = &sum->journal;
-	journal->n_nats = cpu_to_le16(1);
+	journal->n_nats = cpu_to_le16(1 + quota_inum);
 	journal->nat_j.entries[0].nid = sb->root_ino;
 	journal->nat_j.entries[0].ne.version = 0;
 	journal->nat_j.entries[0].ne.ino = sb->root_ino;
@@ -661,6 +687,19 @@ static int f2fs_write_check_point_pack(void)
 			get_sb(main_blkaddr) +
 			get_cp(cur_node_segno[0]) * c.blks_per_seg);
 
+	for (qtype = 0, i = 1; qtype < F2FS_MAX_QUOTAS; qtype++) {
+		if (sb->qf_ino[qtype] == 0)
+			continue;
+		journal->nat_j.entries[i].nid = sb->qf_ino[qtype];
+		journal->nat_j.entries[i].ne.version = 0;
+		journal->nat_j.entries[i].ne.ino = sb->qf_ino[qtype];
+		journal->nat_j.entries[i].ne.block_addr = cpu_to_le32(
+				get_sb(main_blkaddr) +
+				get_cp(cur_node_segno[0]) *
+				c.blks_per_seg + i);
+		i++;
+	}
+
 	memcpy(sum_compact_p, &journal->n_nats, SUM_JOURNAL_SIZE);
 	sum_compact_p += SUM_JOURNAL_SIZE;
 
@@ -669,8 +708,11 @@ static int f2fs_write_check_point_pack(void)
 	journal->n_sits = cpu_to_le16(6);
 	journal->sit_j.entries[0].segno = cp->cur_node_segno[0];
 	journal->sit_j.entries[0].se.vblocks =
-				cpu_to_le16((CURSEG_HOT_NODE << 10) | 1);
+				cpu_to_le16((CURSEG_HOT_NODE << 10) |
+						(1 + quota_inum));
 	f2fs_set_bit(0, (char *)journal->sit_j.entries[0].se.valid_map);
+	for (i = 1; i <= quota_inum; i++)
+		f2fs_set_bit(i, (char *)journal->sit_j.entries[0].se.valid_map);
 	journal->sit_j.entries[1].segno = cp->cur_node_segno[1];
 	journal->sit_j.entries[1].se.vblocks =
 				cpu_to_le16((CURSEG_WARM_NODE << 10));
@@ -681,8 +723,12 @@ static int f2fs_write_check_point_pack(void)
 	/* data sit for root */
 	journal->sit_j.entries[3].segno = cp->cur_data_segno[0];
 	journal->sit_j.entries[3].se.vblocks =
-				cpu_to_le16((CURSEG_HOT_DATA << 10) | 1);
+				cpu_to_le16((CURSEG_HOT_DATA << 10) |
+						(1 + quota_dnum));
 	f2fs_set_bit(0, (char *)journal->sit_j.entries[3].se.valid_map);
+	for (i = 1; i <= quota_dnum; i++)
+		f2fs_set_bit(i, (char *)journal->sit_j.entries[3].se.valid_map);
+
 	journal->sit_j.entries[4].segno = cp->cur_data_segno[1];
 	journal->sit_j.entries[4].se.vblocks =
 				cpu_to_le16((CURSEG_WARM_DATA << 10));
@@ -697,6 +743,20 @@ static int f2fs_write_check_point_pack(void)
 	sum_entry = (struct f2fs_summary *)sum_compact_p;
 	sum_entry->nid = sb->root_ino;
 	sum_entry->ofs_in_node = 0;
+
+	off = 1;
+	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++) {
+		if (sb->qf_ino[qtype] == 0)
+			continue;
+		int j;
+
+		for (j = 0; j < QUOTA_DATA(qtype); j++) {
+			(sum_entry + off + j)->nid = sb->qf_ino[qtype];
+			(sum_entry + off + j)->ofs_in_node = j;
+		}
+		off += QUOTA_DATA(qtype);
+	}
+
 	/* warm data summary, nothing to do */
 	/* cold data summary, nothing to do */
 
@@ -714,6 +774,13 @@ static int f2fs_write_check_point_pack(void)
 
 	sum->entries[0].nid = sb->root_ino;
 	sum->entries[0].ofs_in_node = 0;
+	for (qtype = i = 0; qtype < F2FS_MAX_QUOTAS; qtype++) {
+		if (sb->qf_ino[qtype] == 0)
+			continue;
+		sum->entries[1 + i].nid = sb->qf_ino[qtype];
+		sum->entries[1 + i].ofs_in_node = 0;
+		i++;
+	}
 
 	cp_seg_blk++;
 	DBG(1, "\tWriting Segment summary for HOT_NODE, at offset 0x%08"PRIx64"\n",
@@ -855,12 +922,19 @@ static int f2fs_write_super_block(void)
 static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 {
 	u_int64_t next_blkaddr = 0;
-	u_int64_t root_inode_pos = get_sb(main_blkaddr);
 	u64 end_blkaddr = (get_sb(segment_count_main) <<
 			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
+	u_int64_t start_inode_pos = get_sb(main_blkaddr);
+	u_int64_t last_inode_pos;
+	enum quota_type qtype;
+	u_int32_t quota_inum = 0;
+
+	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++)
+		if (sb->qf_ino[qtype]) quota_inum++;
 
 	/* only root inode was written before truncating dnodes */
-	root_inode_pos += c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg;
+	last_inode_pos = start_inode_pos +
+		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + quota_inum;
 
 	if (c.zoned_mode)
 		return 0;
@@ -883,7 +957,7 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 		}
 		offset = next_blkaddr;
 		/* should avoid recursive chain due to stale data */
-		if (offset == root_inode_pos)
+		if (offset >= start_inode_pos || offset <= last_inode_pos)
 			break;
 	} while (1);
 
@@ -963,7 +1037,6 @@ static int f2fs_write_root_inode(void)
 			c.blks_per_seg, main_area_node_seg_blk_offset);
 	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
 		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
-		free(raw_node);
 		return -1;
 	}
 
@@ -974,10 +1047,161 @@ static int f2fs_write_root_inode(void)
 
 #ifndef WITH_ANDROID
 	if (discard_obsolete_dnode(raw_node, main_area_node_seg_blk_offset)) {
-		free(raw_node);
 		return -1;
 	}
 #endif
+	return 0;
+}
+
+static int f2fs_write_default_quota(int qtype, unsigned int blkaddr)
+{
+	char *filebuf = calloc(F2FS_BLKSIZE, 2);
+	int file_magics[] = INITQMAGICS;
+	struct v2_disk_dqheader ddqheader;
+	struct v2_disk_dqinfo ddqinfo;
+	struct v2r1_disk_dqblk dqblk;
+
+	if (filebuf == NULL) {
+		MSG(1, "\tError: Calloc Failed for filebuf!!!\n");
+		return -1;
+	}
+
+	/* Write basic quota header */
+	ddqheader.dqh_magic = cpu_to_le32(file_magics[qtype]);
+	/* only support QF_VFSV1 */
+	ddqheader.dqh_version = cpu_to_le32(1);
+
+	memcpy(filebuf, &ddqheader, sizeof(ddqheader));
+
+	/* Fill Initial quota file content */
+	ddqinfo.dqi_bgrace = cpu_to_le32(MAX_DQ_TIME);
+	ddqinfo.dqi_igrace = cpu_to_le32(MAX_IQ_TIME);
+	ddqinfo.dqi_flags = cpu_to_le32(0);
+	ddqinfo.dqi_blocks = cpu_to_le32(QT_TREEOFF + 5);
+	ddqinfo.dqi_free_blk = cpu_to_le32(0);
+	ddqinfo.dqi_free_entry = cpu_to_le32(5);
+
+	memcpy(filebuf + V2_DQINFOOFF, &ddqinfo, sizeof(ddqinfo));
+
+	filebuf[1024] = 2;
+	filebuf[2048] = 3;
+	filebuf[3072] = 4;
+	filebuf[4096] = 5;
+
+	filebuf[5120 + 8] = 1;
+
+	dqblk.dqb_id = cpu_to_le32(0);
+	dqblk.dqb_pad = cpu_to_le32(0);
+	dqblk.dqb_ihardlimit = cpu_to_le64(0);
+	dqblk.dqb_isoftlimit = cpu_to_le64(0);
+	dqblk.dqb_curinodes = cpu_to_le64(1);
+	dqblk.dqb_bhardlimit = cpu_to_le64(0);
+	dqblk.dqb_bsoftlimit = cpu_to_le64(0);
+	dqblk.dqb_curspace = cpu_to_le64(4096);
+	dqblk.dqb_btime = cpu_to_le64(0);
+	dqblk.dqb_itime = cpu_to_le64(0);
+
+	memcpy(filebuf + 5136, &dqblk, sizeof(struct v2r1_disk_dqblk));
+
+	/* Write two blocks */
+	if (dev_write_block(filebuf, blkaddr) ||
+	    dev_write_block(filebuf + F2FS_BLKSIZE, blkaddr + 1)) {
+		MSG(1, "\tError: While writing the quota_blk to disk!!!\n");
+		free(filebuf);
+		return -1;
+	}
+
+	free(filebuf);
+	return 0;
+}
+
+static int f2fs_write_qf_inode(int qtype)
+{
+	struct f2fs_node *raw_node = NULL;
+	u_int64_t data_blk_nor;
+	u_int64_t main_area_node_seg_blk_offset = 0;
+	int i;
+
+	raw_node = calloc(F2FS_BLKSIZE, 1);
+	if (raw_node == NULL) {
+		MSG(1, "\tError: Calloc Failed for raw_node!!!\n");
+		return -1;
+	}
+
+	raw_node->footer.nid = sb->qf_ino[qtype];
+	raw_node->footer.ino = sb->qf_ino[qtype];
+	raw_node->footer.cp_ver = cpu_to_le64(1);
+	raw_node->footer.next_blkaddr = cpu_to_le32(
+			get_sb(main_blkaddr) +
+			c.cur_seg[CURSEG_HOT_NODE] *
+			c.blks_per_seg + 1 + qtype + 1);
+
+	raw_node->i.i_mode = cpu_to_le16(0x8180);
+	raw_node->i.i_links = cpu_to_le32(1);
+	raw_node->i.i_uid = cpu_to_le32(getuid());
+	raw_node->i.i_gid = cpu_to_le32(getgid());
+
+	raw_node->i.i_size = cpu_to_le64(1024 * 6); /* Hard coded */
+	raw_node->i.i_blocks = cpu_to_le64(1 + QUOTA_DATA(qtype));
+
+	raw_node->i.i_atime = cpu_to_le32(time(NULL));
+	raw_node->i.i_atime_nsec = 0;
+	raw_node->i.i_ctime = cpu_to_le32(time(NULL));
+	raw_node->i.i_ctime_nsec = 0;
+	raw_node->i.i_mtime = cpu_to_le32(time(NULL));
+	raw_node->i.i_mtime_nsec = 0;
+	raw_node->i.i_generation = 0;
+	raw_node->i.i_xattr_nid = 0;
+	raw_node->i.i_flags = FS_IMMUTABLE_FL;
+	raw_node->i.i_current_depth = cpu_to_le32(1);
+	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
+
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
+		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
+		raw_node->i.i_extra_isize =
+				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+	}
+
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
+		raw_node->i.i_projid = cpu_to_le32(F2FS_DEF_PROJID);
+
+	data_blk_nor = get_sb(main_blkaddr) +
+		c.cur_seg[CURSEG_HOT_DATA] * c.blks_per_seg + 1;
+
+	for (i = 0; i < qtype; i++)
+		if (sb->qf_ino[i])
+			data_blk_nor += QUOTA_DATA(i);
+
+	/* write two blocks */
+	if (f2fs_write_default_quota(qtype, data_blk_nor)) {
+		free(raw_node);
+		return -1;
+	}
+
+	for (i = 0; i < QUOTA_DATA(qtype); i++)
+		raw_node->i.i_addr[get_extra_isize(raw_node) + i] =
+					cpu_to_le32(data_blk_nor + i);
+	raw_node->i.i_ext.fofs = 0;
+	raw_node->i.i_ext.blk_addr = 0;
+	raw_node->i.i_ext.len = 0;
+
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
+		raw_node->i.i_inode_checksum =
+			cpu_to_le32(f2fs_inode_chksum(raw_node));
+
+	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
+	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_HOT_NODE] *
+					c.blks_per_seg + qtype + 1;
+
+	DBG(1, "\tWriting quota inode (hot node), %x %x %x at offset 0x%08"PRIu64"\n",
+			get_sb(main_blkaddr),
+			c.cur_seg[CURSEG_HOT_NODE],
+			c.blks_per_seg, main_area_node_seg_blk_offset);
+	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
+		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
+		free(raw_node);
+		return -1;
+	}
 
 	free(raw_node);
 	return 0;
@@ -987,6 +1211,8 @@ static int f2fs_update_nat_root(void)
 {
 	struct f2fs_nat_block *nat_blk = NULL;
 	u_int64_t nat_seg_blk_offset = 0;
+	enum quota_type qtype;
+	int i;
 
 	nat_blk = calloc(F2FS_BLKSIZE, 1);
 	if(nat_blk == NULL) {
@@ -994,6 +1220,18 @@ static int f2fs_update_nat_root(void)
 		return -1;
 	}
 
+	/* update quota */
+	for (qtype = i = 0; qtype < F2FS_MAX_QUOTAS; qtype++) {
+		if (sb->qf_ino[qtype] == 0)
+			continue;
+		nat_blk->entries[sb->qf_ino[qtype]].block_addr =
+				cpu_to_le32(get_sb(main_blkaddr) +
+				c.cur_seg[CURSEG_HOT_NODE] *
+				c.blks_per_seg + i + 1);
+		nat_blk->entries[sb->qf_ino[qtype]].ino = sb->qf_ino[qtype];
+		i++;
+	}
+
 	/* update root */
 	nat_blk->entries[get_sb(root_ino)].block_addr = cpu_to_le32(
 		get_sb(main_blkaddr) +
@@ -1048,6 +1286,7 @@ static int f2fs_add_default_dentry_root(void)
 	/* bitmap for . and .. */
 	test_and_set_bit_le(0, dent_blk->dentry_bitmap);
 	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
+
 	data_blk_offset = get_sb(main_blkaddr);
 	data_blk_offset += c.cur_seg[CURSEG_HOT_DATA] *
 				c.blks_per_seg;
@@ -1066,6 +1305,7 @@ static int f2fs_add_default_dentry_root(void)
 
 static int f2fs_create_root_dir(void)
 {
+	enum quota_type qtype;
 	int err = 0;
 
 	err = f2fs_write_root_inode();
@@ -1074,6 +1314,16 @@ static int f2fs_create_root_dir(void)
 		goto exit;
 	}
 
+	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++)  {
+		if (sb->qf_ino[qtype] == 0)
+			continue;
+		err = f2fs_write_qf_inode(qtype);
+		if (err < 0) {
+			MSG(1, "\tError: Failed to write quota inode!!!\n");
+			goto exit;
+		}
+	}
+
 	err = f2fs_update_nat_root();
 	if (err < 0) {
 		MSG(1, "\tError: Failed to update NAT for root!!!\n");
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index ef62777..50735d3 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -88,6 +88,8 @@ static void parse_feature(const char *features)
 		c.feature |= cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM);
 	} else if (!strcmp(features, "flexible_inline_xattr")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
+	} else if (!strcmp(features, "quota")) {
+		c.feature |= cpu_to_le32(F2FS_FEATURE_QUOTA_INO);
 	} else {
 		MSG(0, "Error: Wrong features\n");
 		mkfs_usage();
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
