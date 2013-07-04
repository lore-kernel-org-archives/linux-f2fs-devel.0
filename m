From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs-tools: add fsck.f2fs and dump.f2fs
Date: Thu, 04 Jul 2013 17:11:32 +0900
Message-ID: <1372925492-5490-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>, Byoung Geun Kim <bgbg.kim@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

fsck.f2fs checks file system consistency, but does not repair a broken
file system yet.
dump.f2fs shows the information of a specific inode and makes dump file
of SSA and SIT.
f2fs checks file system consistency as follows:
 o When data about used area and its metadata are identical,
   f2fs is considered consistent. To verify such consistency, we use
   three bitmaps: nat_area_bitmap, sit_area_bitmap, and main_area_bitmap.
   First, each bit in nat_area_bitmap corresponds to a nid in NAT.
   Second, each bit in sit_area_bitmap corresponds to a valid block in a
   segment. This bitmap is same to the total valid_map of f2fs_sit_entries
   in SIT.
   Last, each bit in main_area_bitmap corresponds to a block in main area
   except meta area.
   After a consistency check of each block, we set or clear the
   corresponding bit of each bitmap.
   From the root node, we start consistency check. The verified
   information varies according to block type.
   1. NODE
     - Read information of node block from NAT
     - Check if block address is allocated using node info.
     - Check if the type of f2fs_summary related to nid in SSA is NODE.
     - Update the corresponding bit in nat_area_bitmap.
     - Update the corresponding bit in sit_area_bitmap.
     - Set the corresponding bit in main_area_bitmap to 1.
     - Then, read node block. According to its attribute, explore
       inode/direct node/indirect node/double indirect node
       recursively.
     - If it is an inode block, we also check its xattr and hard link.
   2. DATA
     - Check if the type of f2fs_summary related to nid in SSA is DATA.
     - Set the corresponding bits of sit_area_bitmap and
       main_area_bitmap to visited
     - If it is a dentry block, traverse each dentries that may be
       regular
       file or directory. At this time, it will check inode block again.
   Finally, we verify whether
     - every nat_area_bitmap is visited
     - any unreachable hard link exists
     - values of sit_area_bitmap and main_area_bitmap are identical
     - total_valid_block_count/node_count/inode_count are correct

Usage:
 o fsck.f2fs
   # fsck.f2fs /dev/sdx
   options:
     -d debug level [default:0]
 o dump.f2fs
   # dump.f2fs -i [ino] /dev/sdx
   # dump.f2fs -s 0~-1 /dev/sdx (SIT dump)
   # dump.f2fs -a 0~-1 /dev/sdx (SSA dump)
   options:
     -d debug level [default:0]
     -i inode no (hex)
     -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]
     -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]

Note: To use dump.f2fs, please run make install or ln -s fsck.f2fs
dump.f2fs

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Byoung Geun Kim <bgbg.kim@samsung.com>
---
 ChangeLog         |    2 +
 Makefile.am       |    2 +-
 configure.ac      |    1 +
 fsck/Makefile.am  |   11 +
 fsck/dump.c       |  143 +++++++
 fsck/f2fs.h       |  343 +++++++++++++++++
 fsck/fsck.c       |  806 ++++++++++++++++++++++++++++++++++++++
 fsck/fsck.h       |  163 ++++++++
 fsck/main.c       |  183 +++++++++
 fsck/mount.c      | 1111 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/f2fs_fs.h |   98 +++--
 include/list.h    |   86 +++++
 lib/libf2fs.c     |  159 +++++++-
 13 files changed, 3080 insertions(+), 28 deletions(-)
 create mode 100644 fsck/Makefile.am
 create mode 100644 fsck/dump.c
 create mode 100644 fsck/f2fs.h
 create mode 100644 fsck/fsck.c
 create mode 100644 fsck/fsck.h
 create mode 100644 fsck/main.c
 create mode 100644 fsck/mount.c
 create mode 100644 include/list.h

diff --git a/ChangeLog b/ChangeLog
index bcbd38d..9739e99 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,2 +1,4 @@
 f2fs-tools-1.0.0 Tue Aug 14, 2012 KST
     * The first release of f2fs-tools.
+f2fs-tools-1.0.1 Tue Jun 04, 2013 KST
+    * Added fsck and dump for f2fs-tools.
diff --git a/Makefile.am b/Makefile.am
index 55eb8ac..ca376b4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -2,4 +2,4 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
-SUBDIRS = man lib mkfs
+SUBDIRS = man lib mkfs fsck
diff --git a/configure.ac b/configure.ac
index dc9bfd1..c5ca858 100644
--- a/configure.ac
+++ b/configure.ac
@@ -82,6 +82,7 @@ AC_CONFIG_FILES([
 	man/Makefile
 	lib/Makefile
 	mkfs/Makefile
+	fsck/Makefile
 ])
 
 AC_OUTPUT
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
new file mode 100644
index 0000000..6099b5e
--- /dev/null
+++ b/fsck/Makefile.am
@@ -0,0 +1,11 @@
+## Makefile.am
+
+AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
+AM_CFLAGS = -Wall
+sbin_PROGRAMS = fsck.f2fs
+fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c
+fsck_f2fs_LDFLAGS = -all-static
+fsck_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
+
+install-data-hook:
+	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
diff --git a/fsck/dump.c b/fsck/dump.c
new file mode 100644
index 0000000..1ec794a
--- /dev/null
+++ b/fsck/dump.c
@@ -0,0 +1,143 @@
+/**
+ * dump.c
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *             http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+
+#define BUF_SZ	80
+
+void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit)
+{
+	struct seg_entry *se;
+	int segno;
+	char buf[BUF_SZ];
+	u32 free_segs = 0;;
+	u64 valid_blocks = 0;
+	int ret;
+	int fd;
+
+	fd = open("dump_sit", O_CREAT|O_WRONLY|O_TRUNC, 0666);
+	ASSERT(fd >= 0);
+
+	for (segno = start_sit; segno < end_sit; segno++) {
+		se = get_seg_entry(sbi, segno);
+
+		memset(buf, 0, BUF_SZ);
+		snprintf(buf, BUF_SZ, "%5d %8d\n", segno, se->valid_blocks);
+
+		ret = write(fd, buf, strlen(buf));
+		ASSERT(ret >= 0);
+
+		DBG(4, "SIT[0x%3x] : 0x%x\n", segno, se->valid_blocks);
+		if (se->valid_blocks == 0x0) {
+			free_segs++;
+		} else {
+			ASSERT(se->valid_blocks <= 512);
+			valid_blocks += se->valid_blocks;
+		}
+	}
+
+	memset(buf, 0, BUF_SZ);
+	snprintf(buf, BUF_SZ, "valid_segs:%d\t free_segs:%d\n",
+			SM_I(sbi)->main_segments - free_segs, free_segs);
+	ret = write(fd, buf, strlen(buf));
+	ASSERT(ret >= 0);
+
+	close(fd);
+	DBG(1, "Blocks [0x%lx] Free Segs [0x%x]\n", valid_blocks, free_segs);
+}
+
+void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
+{
+	struct f2fs_summary_block sum_blk;
+	char buf[BUF_SZ];
+	int segno, i, ret;
+	int fd;
+
+	fd = open("dump_ssa", O_CREAT|O_WRONLY|O_TRUNC, 0666);
+	ASSERT(fd >= 0);
+
+	for (segno = start_ssa; segno < end_ssa; segno++) {
+		ret = get_sum_block(sbi, segno, &sum_blk);
+
+		memset(buf, 0, BUF_SZ);
+		switch (ret) {
+		case SEG_TYPE_CUR_NODE:
+			snprintf(buf, BUF_SZ, "\n\nsegno: %d, Current Node\n", segno);
+			break;
+		case SEG_TYPE_CUR_DATA:
+			snprintf(buf, BUF_SZ, "\n\nsegno: %d, Current Data\n", segno);
+			break;
+		case SEG_TYPE_NODE:
+			snprintf(buf, BUF_SZ, "\n\nsegno: %d, Node\n", segno);
+			break;
+		case SEG_TYPE_DATA:
+			snprintf(buf, BUF_SZ, "\n\nsegno: %d, Data\n", segno);
+			break;
+		}
+		ret = write(fd, buf, strlen(buf));
+		ASSERT(ret >= 0);
+
+		for (i = 0; i < ENTRIES_IN_SUM; i++) {
+			memset(buf, 0, BUF_SZ);
+			if (i % 10 == 0) {
+				buf[0] = '\n';
+				ret = write(fd, buf, strlen(buf));
+				ASSERT(ret >= 0);
+			}
+			snprintf(buf, BUF_SZ, " [%8x, %3d, %3x]",
+					le32_to_cpu(sum_blk.entries[i].nid),
+					le16_to_cpu(sum_blk.entries[i].ofs_in_node),
+					sum_blk.entries[i].version);
+			ret = write(fd, buf, strlen(buf));
+			ASSERT(ret >= 0);
+		}
+	}
+	close(fd);
+}
+
+int dump_node(struct f2fs_sb_info *sbi, nid_t nid)
+{
+	struct node_info ni;
+	struct f2fs_node *node_blk;
+	int ret;
+
+	ret = get_node_info(sbi, nid, &ni);
+	ASSERT(ret >= 0);
+
+	node_blk = calloc(BLOCK_SZ, 1);
+	dev_read_block(node_blk, ni.blk_addr);
+
+	DBG(1, "Node ID               [0x%x]\n", nid);
+	DBG(1, "nat_entry.block_addr  [0x%x]\n", ni.blk_addr);
+	DBG(1, "nat_entry.version     [0x%x]\n", ni.version);
+	DBG(1, "nat_entry.ino         [0x%x]\n", ni.ino);
+
+	if (ni.blk_addr == 0x0) {
+		MSG(0, "Invalid nat entry\n\n");
+	}
+
+	DBG(1, "node_blk.footer.ino [0x%x]\n", le32_to_cpu(node_blk->footer.ino));
+	DBG(1, "node_blk.footer.nid [0x%x]\n", le32_to_cpu(node_blk->footer.nid));
+
+	if (le32_to_cpu(node_blk->footer.ino) == ni.ino &&
+			le32_to_cpu(node_blk->footer.nid) == ni.nid) {
+		print_node_info(node_blk);
+	} else {
+		MSG(0, "Invalid node block\n\n");
+	}
+
+	free(node_blk);
+	return 0;
+}
+
+void dump_cleanup(struct f2fs_sb_info *sbi)
+{
+	f2fs_do_umount(sbi);
+}
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
new file mode 100644
index 0000000..e1740fe
--- /dev/null
+++ b/fsck/f2fs.h
@@ -0,0 +1,343 @@
+/**
+ * f2fs.h
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *             http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _F2FS_H_
+#define _F2FS_H_
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
+#include <mntent.h>
+#include <linux/types.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <assert.h>
+
+#include <list.h>
+#include <f2fs_fs.h>
+
+#define EXIT_ERR_CODE		(-1)
+#define ver_after(a, b) (typecheck(unsigned long long, a) &&            \
+		typecheck(unsigned long long, b) &&                     \
+		((long long)((a) - (b)) > 0))
+
+enum {
+	NAT_BITMAP,
+	SIT_BITMAP
+};
+
+struct node_info {
+	nid_t nid;
+	nid_t ino;
+	u32 blk_addr;
+	unsigned char version;
+};
+
+struct f2fs_nm_info {
+	block_t nat_blkaddr;
+	nid_t max_nid;
+	nid_t init_scan_nid;
+	nid_t next_scan_nid;
+
+	unsigned int nat_cnt;
+	unsigned int fcnt;
+
+	char *nat_bitmap;
+	int bitmap_size;
+};
+
+struct seg_entry {
+	unsigned short valid_blocks;    /* # of valid blocks */
+	unsigned char *cur_valid_map;   /* validity bitmap of blocks */
+	/*
+	 * # of valid blocks and the validity bitmap stored in the the last
+	 * checkpoint pack. This information is used by the SSR mode.
+	 */
+	unsigned short ckpt_valid_blocks;
+	unsigned char *ckpt_valid_map;
+	unsigned char type;             /* segment type like CURSEG_XXX_TYPE */
+	unsigned long long mtime;       /* modification time of the segment */
+};
+
+struct sec_entry {
+	unsigned int valid_blocks;      /* # of valid blocks in a section */
+};
+
+struct sit_info {
+
+	block_t sit_base_addr;          /* start block address of SIT area */
+	block_t sit_blocks;             /* # of blocks used by SIT area */
+	block_t written_valid_blocks;   /* # of valid blocks in main area */
+	char *sit_bitmap;               /* SIT bitmap pointer */
+	unsigned int bitmap_size;       /* SIT bitmap size */
+
+	unsigned long *dirty_sentries_bitmap;   /* bitmap for dirty sentries */
+	unsigned int dirty_sentries;            /* # of dirty sentries */
+	unsigned int sents_per_block;           /* # of SIT entries per block */
+	struct seg_entry *sentries;             /* SIT segment-level cache */
+	struct sec_entry *sec_entries;          /* SIT section-level cache */
+
+	unsigned long long elapsed_time;        /* elapsed time after mount */
+	unsigned long long mounted_time;        /* mount time */
+	unsigned long long min_mtime;           /* min. modification time */
+	unsigned long long max_mtime;           /* max. modification time */
+};
+
+struct curseg_info {
+	struct f2fs_summary_block *sum_blk;     /* cached summary block */
+	unsigned char alloc_type;               /* current allocation type */
+	unsigned int segno;                     /* current segment number */
+	unsigned short next_blkoff;             /* next block offset to write */
+	unsigned int zone;                      /* current zone number */
+	unsigned int next_segno;                /* preallocated segment */
+};
+
+struct f2fs_sm_info {
+	struct sit_info *sit_info;
+	struct curseg_info *curseg_array;
+
+	block_t seg0_blkaddr;
+	block_t main_blkaddr;
+	block_t ssa_blkaddr;
+
+	unsigned int segment_count;
+	unsigned int main_segments;
+	unsigned int reserved_segments;
+	unsigned int ovp_segments;
+};
+
+struct f2fs_sb_info {
+	struct f2fs_fsck *fsck;
+
+	struct f2fs_super_block *raw_super;
+	struct f2fs_nm_info *nm_info;
+	struct f2fs_sm_info *sm_info;
+	struct f2fs_checkpoint *ckpt;
+
+	struct list_head orphan_inode_list;
+	unsigned int n_orphans;
+
+	/* basic file system units */
+	unsigned int log_sectors_per_block;     /* log2 sectors per block */
+	unsigned int log_blocksize;             /* log2 block size */
+	unsigned int blocksize;                 /* block size */
+	unsigned int root_ino_num;              /* root inode number*/
+	unsigned int node_ino_num;              /* node inode number*/
+	unsigned int meta_ino_num;              /* meta inode number*/
+	unsigned int log_blocks_per_seg;        /* log2 blocks per segment */
+	unsigned int blocks_per_seg;            /* blocks per segment */
+	unsigned int segs_per_sec;              /* segments per section */
+	unsigned int secs_per_zone;             /* sections per zone */
+	unsigned int total_sections;            /* total section count */
+	unsigned int total_node_count;          /* total node block count */
+	unsigned int total_valid_node_count;    /* valid node block count */
+	unsigned int total_valid_inode_count;   /* valid inode count */
+	int active_logs;                        /* # of active logs */
+
+	block_t user_block_count;               /* # of user blocks */
+	block_t total_valid_block_count;        /* # of valid blocks */
+	block_t alloc_valid_block_count;        /* # of allocated blocks */
+	block_t last_valid_block_count;         /* for recovery */
+	u32 s_next_generation;                  /* for NFS support */
+
+	unsigned int cur_victim_sec;            /* current victim section num */
+
+};
+
+static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
+{
+	return (struct f2fs_super_block *)(sbi->raw_super);
+}
+
+static inline struct f2fs_checkpoint *F2FS_CKPT(struct f2fs_sb_info *sbi)
+{
+	return (struct f2fs_checkpoint *)(sbi->ckpt);
+}
+
+static inline struct f2fs_fsck *F2FS_FSCK(struct f2fs_sb_info *sbi)
+{
+	return (struct f2fs_fsck *)(sbi->fsck);
+}
+
+static inline struct f2fs_nm_info *NM_I(struct f2fs_sb_info *sbi)
+{
+	return (struct f2fs_nm_info *)(sbi->nm_info);
+}
+
+static inline struct f2fs_sm_info *SM_I(struct f2fs_sb_info *sbi)
+{
+	return (struct f2fs_sm_info *)(sbi->sm_info);
+}
+
+static inline struct sit_info *SIT_I(struct f2fs_sb_info *sbi)
+{
+	return (struct sit_info *)(SM_I(sbi)->sit_info);
+}
+
+static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
+{
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+
+	/* return NAT or SIT bitmap */
+	if (flag == NAT_BITMAP)
+		return le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
+	else if (flag == SIT_BITMAP)
+		return le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
+
+	return 0;
+}
+
+static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
+{
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	int offset = (flag == NAT_BITMAP) ?
+		le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
+	return &ckpt->sit_nat_version_bitmap + offset;
+}
+
+static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
+{
+	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
+	return ckpt_flags & f;
+}
+
+static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
+{
+	block_t start_addr;
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	unsigned long long ckpt_version = le64_to_cpu(ckpt->checkpoint_ver);
+
+	start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
+
+	/*
+	 * odd numbered checkpoint should at cp segment 0
+	 * and even segent must be at cp segment 1
+	 */
+	if (!(ckpt_version & 1))
+		start_addr += sbi->blocks_per_seg;
+
+	return start_addr;
+}
+
+static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
+{
+	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
+}
+
+#define GET_ZONENO_FROM_SEGNO(sbi, segno)                               \
+	((segno / sbi->segs_per_sec) / sbi->secs_per_zone)
+
+#define IS_DATASEG(t)                                                   \
+	((t == CURSEG_HOT_DATA) || (t == CURSEG_COLD_DATA) ||           \
+	 (t == CURSEG_WARM_DATA))
+
+#define IS_NODESEG(t)                                                   \
+	((t == CURSEG_HOT_NODE) || (t == CURSEG_COLD_NODE) ||           \
+	 (t == CURSEG_WARM_NODE))
+
+#define GET_SUM_BLKADDR(sbi, segno)					\
+	((sbi->sm_info->ssa_blkaddr) + segno)
+
+#define GET_SEGOFF_FROM_SEG0(sbi, blk_addr)				\
+	((blk_addr) - SM_I(sbi)->seg0_blkaddr)
+
+#define GET_SEGNO_FROM_SEG0(sbi, blk_addr)				\
+	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) >> sbi->log_blocks_per_seg)
+
+#define FREE_I_START_SEGNO(sbi)		GET_SEGNO_FROM_SEG0(sbi, SM_I(sbi)->main_blkaddr)
+#define GET_R2L_SEGNO(sbi, segno)	(segno + FREE_I_START_SEGNO(sbi))
+
+#define START_BLOCK(sbi, segno)	(SM_I(sbi)->main_blkaddr + (segno << sbi->log_blocks_per_seg))
+
+static inline struct curseg_info *CURSEG_I(struct f2fs_sb_info *sbi, int type)
+{
+	return (struct curseg_info *)(SM_I(sbi)->curseg_array + type);
+}
+
+static inline block_t start_sum_block(struct f2fs_sb_info *sbi)
+{
+	return __start_cp_addr(sbi) + le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
+}
+
+static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
+{
+	return __start_cp_addr(sbi) + le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_total_block_count)
+		- (base + 1) + type;
+}
+
+
+#define nats_in_cursum(sum)             (le16_to_cpu(sum->n_nats))
+#define sits_in_cursum(sum)             (le16_to_cpu(sum->n_sits))
+
+#define nat_in_journal(sum, i)          (sum->nat_j.entries[i].ne)
+#define nid_in_journal(sum, i)          (sum->nat_j.entries[i].nid)
+#define sit_in_journal(sum, i)          (sum->sit_j.entries[i].se)
+#define segno_in_journal(sum, i)        (sum->sit_j.entries[i].segno)
+
+#define SIT_ENTRY_OFFSET(sit_i, segno)                                  \
+	(segno % sit_i->sents_per_block)
+#define SIT_BLOCK_OFFSET(sit_i, segno)                                  \
+	(segno / SIT_ENTRY_PER_BLOCK)
+#define TOTAL_SEGS(sbi) (SM_I(sbi)->main_segments)
+
+#define IS_VALID_NID(sbi, nid) 			\
+	do {						\
+		ASSERT(nid <= (NAT_ENTRY_PER_BLOCK *	\
+					F2FS_RAW_SUPER(sbi)->segment_count_nat	\
+					<< (sbi->log_blocks_per_seg - 1)));	\
+	} while (0);
+
+#define IS_VALID_BLK_ADDR(sbi, addr)				\
+	do {							\
+		if (addr >= F2FS_RAW_SUPER(sbi)->block_count ||	 	\
+				addr < SM_I(sbi)->main_blkaddr)	\
+		{						\
+			DBG(0, "block addr [0x%x]\n", addr);	\
+			ASSERT(addr <  F2FS_RAW_SUPER(sbi)->block_count);	\
+			ASSERT(addr >= SM_I(sbi)->main_blkaddr);	\
+		}						\
+	} while (0);
+
+static inline u64 BLKOFF_FROM_MAIN(struct f2fs_sb_info *sbi, u64 blk_addr)
+{
+	ASSERT(blk_addr >= SM_I(sbi)->main_blkaddr);
+	return blk_addr - SM_I(sbi)->main_blkaddr;
+}
+
+static inline u32 GET_SEGNO(struct f2fs_sb_info *sbi, u64 blk_addr)
+{
+	return (u32)(BLKOFF_FROM_MAIN(sbi, blk_addr)
+			>> sbi->log_blocks_per_seg);
+}
+
+static inline u32 OFFSET_IN_SEG(struct f2fs_sb_info *sbi, u64 blk_addr)
+{
+	return (u32)(BLKOFF_FROM_MAIN(sbi, blk_addr)
+			% (1 << sbi->log_blocks_per_seg));
+}
+
+static inline void node_info_from_raw_nat(struct node_info *ni,
+		struct f2fs_nat_entry *raw_nat)
+{
+	ni->ino = le32_to_cpu(raw_nat->ino);
+	ni->blk_addr = le32_to_cpu(raw_nat->block_addr);
+	ni->version = raw_nat->version;
+}
+
+extern int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_nat_entry *ne);
+#define IS_SUM_NODE_SEG(footer)		(footer.entry_type == SUM_TYPE_NODE)
+
+#endif /* _F2FS_H_ */
diff --git a/fsck/fsck.c b/fsck/fsck.c
new file mode 100644
index 0000000..1e4afd9
--- /dev/null
+++ b/fsck/fsck.c
@@ -0,0 +1,806 @@
+/**
+ * fsck.c
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *             http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+
+static int add_into_hard_link_list(struct f2fs_sb_info *sbi, u32 nid, u32 link_cnt)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct hard_link_node *node = NULL, *tmp = NULL, *prev = NULL;
+
+	node = calloc(sizeof(struct hard_link_node), 1);
+	ASSERT(node != NULL);
+
+	node->nid = nid;
+	node->links = link_cnt;
+	node->next = NULL;
+
+	if (fsck->hard_link_list_head == NULL) {
+		fsck->hard_link_list_head = node;
+		goto out;
+	}
+
+	tmp = fsck->hard_link_list_head;
+
+	/* Find insertion position */
+	while (tmp && (nid < tmp->nid)) {
+		ASSERT(tmp->nid != nid);
+		prev = tmp;
+		tmp = tmp->next;
+	}
+
+	if (tmp == fsck->hard_link_list_head) {
+		node->next = tmp;
+		fsck->hard_link_list_head = node;
+	} else {
+		prev->next = node;
+		node->next = tmp;
+	}
+
+out:
+	DBG(2, "ino[0x%x] has hard links [0x%x]\n", nid, link_cnt);
+	return 0;
+}
+
+static int find_and_dec_hard_link_list(struct f2fs_sb_info *sbi, u32 nid)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct hard_link_node *node = NULL, *prev = NULL;
+
+	if (fsck->hard_link_list_head == NULL) {
+		ASSERT(0);
+		return -1;
+	}
+
+	node = fsck->hard_link_list_head;
+
+	while (node && (nid < node->nid)) {
+		prev = node;
+		node = node->next;
+	}
+
+	if (node == NULL || (nid != node->nid)) {
+		ASSERT(0);
+		return -1;
+	}
+
+	/* Decrease link count */
+	node->links = node->links - 1;
+
+	/* if link count becomes one, remove the node */
+	if (node->links == 1) {
+		if (fsck->hard_link_list_head == node)
+			fsck->hard_link_list_head = node->next;
+		else
+			prev->next = node->next;
+		free(node);
+	}
+
+	return 0;
+
+}
+
+static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid, u32 blk_addr)
+{
+	int ret = 0;
+	struct f2fs_summary sum_entry;
+
+	ret = get_sum_entry(sbi, blk_addr, &sum_entry);
+	ASSERT(ret >= 0);
+
+	if (ret == SEG_TYPE_DATA || ret == SEG_TYPE_CUR_DATA) {
+		ASSERT_MSG(0, "Summary footer is not a node segment summary\n");;
+	} else if (ret == SEG_TYPE_NODE) {
+		if (le32_to_cpu(sum_entry.nid) != nid) {
+			DBG(0, "nid                       [0x%x]\n", nid);
+			DBG(0, "target blk_addr           [0x%x]\n", blk_addr);
+			DBG(0, "summary blk_addr          [0x%lx]\n",
+					GET_SUM_BLKADDR(sbi, GET_SEGNO(sbi, blk_addr)));
+			DBG(0, "seg no / offset           [0x%x / 0x%x]\n",
+					GET_SEGNO(sbi, blk_addr), OFFSET_IN_SEG(sbi, blk_addr));
+			DBG(0, "summary_entry.nid         [0x%x]\n", le32_to_cpu(sum_entry.nid));
+			DBG(0, "--> node block's nid      [0x%x]\n", nid);
+			ASSERT_MSG(0, "Invalid node seg summary\n");
+		}
+	} else if (ret == SEG_TYPE_CUR_NODE) {
+		/* current node segment has no ssa */
+	} else {
+		ASSERT_MSG(0, "Invalid return value of 'get_sum_entry'");
+	}
+
+	return 1;
+}
+
+static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
+		u32 parent_nid, u16 idx_in_node, u8 version)
+{
+	int ret = 0;
+	struct f2fs_summary sum_entry;
+
+	ret = get_sum_entry(sbi, blk_addr, &sum_entry);
+	ASSERT(ret == SEG_TYPE_DATA || ret == SEG_TYPE_CUR_DATA);
+
+	if (le32_to_cpu(sum_entry.nid) != parent_nid ||
+			sum_entry.version != version ||
+			le16_to_cpu(sum_entry.ofs_in_node) != idx_in_node) {
+
+		DBG(0, "summary_entry.nid         [0x%x]\n", le32_to_cpu(sum_entry.nid));
+		DBG(0, "summary_entry.version     [0x%x]\n", sum_entry.version);
+		DBG(0, "summary_entry.ofs_in_node [0x%x]\n", le16_to_cpu(sum_entry.ofs_in_node));
+
+		DBG(0, "parent nid                [0x%x]\n", parent_nid);
+		DBG(0, "version from nat          [0x%x]\n", version);
+		DBG(0, "idx in parent node        [0x%x]\n", idx_in_node);
+
+		DBG(0, "Target data block addr    [0x%x]\n", blk_addr);
+		ASSERT_MSG(0, "Invalid data seg summary\n");
+	}
+
+	return 1;
+}
+
+int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		enum NODE_TYPE ntype,
+		u32 *blk_cnt)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct node_info ni;
+	struct f2fs_node *node_blk = NULL;
+	int ret = 0;
+
+	IS_VALID_NID(sbi, nid);
+
+	if (ftype != F2FS_FT_ORPHAN)
+		f2fs_clear_bit(nid, fsck->nat_area_bitmap);
+
+	ret = get_node_info(sbi, nid, &ni);
+	ASSERT(ret >= 0);
+
+	/* Is it reserved block?
+	 * if block addresss was 0xffff,ffff,ffff,ffff
+	 * it means that block was already allocated, but not stored in disk
+	 */
+	if (ni.blk_addr == NEW_ADDR) {
+		fsck->chk.valid_blk_cnt++;
+		fsck->chk.valid_node_cnt++;
+		if (ntype == TYPE_INODE)
+			fsck->chk.valid_inode_cnt++;
+		return 0;
+	}
+
+	IS_VALID_BLK_ADDR(sbi, ni.blk_addr);
+
+	is_valid_ssa_node_blk(sbi, nid, ni.blk_addr);
+
+	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->sit_area_bitmap) == 0x0) {
+		DBG(0, "SIT bitmap is 0x0. blk_addr[0x%x]\n", ni.blk_addr);
+		ASSERT(0);
+	}
+
+	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap) == 0x0) {
+		fsck->chk.valid_blk_cnt++;
+		fsck->chk.valid_node_cnt++;
+	}
+
+	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk != NULL);
+
+	ret = dev_read_block(node_blk, ni.blk_addr);
+	ASSERT(ret >= 0);
+
+	ASSERT_MSG(nid == le32_to_cpu(node_blk->footer.nid),
+			"nid[0x%x] blk_addr[0x%x] footer.nid[0x%x]\n",
+			nid, ni.blk_addr, le32_to_cpu(node_blk->footer.nid));
+
+	if (ntype == TYPE_INODE) {
+		ret = fsck_chk_inode_blk(sbi,
+				nid,
+				ftype,
+				node_blk,
+				blk_cnt,
+				&ni);
+	} else {
+		/* it's not inode */
+		ASSERT(node_blk->footer.nid != node_blk->footer.ino);
+
+		if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap) != 0) {
+			DBG(0, "Duplicated node block. ino[0x%x][0x%x]\n", nid, ni.blk_addr);
+			ASSERT(0);
+		}
+		f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap);
+
+		switch (ntype) {
+		case TYPE_DIRECT_NODE:
+			ret = fsck_chk_dnode_blk(sbi,
+					inode,
+					nid,
+					ftype,
+					node_blk,
+					blk_cnt,
+					&ni);
+			break;
+		case TYPE_INDIRECT_NODE:
+			ret = fsck_chk_idnode_blk(sbi,
+					inode,
+					nid,
+					ftype,
+					node_blk,
+					blk_cnt);
+			break;
+		case TYPE_DOUBLE_INDIRECT_NODE:
+			ret = fsck_chk_didnode_blk(sbi,
+					inode,
+					nid,
+					ftype,
+					node_blk,
+					blk_cnt);
+			break;
+		default:
+			ASSERT(0);
+		}
+	}
+	ASSERT(ret >= 0);
+
+	free(node_blk);
+	return 0;
+}
+
+
+int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		struct f2fs_node *node_blk,
+		u32 *blk_cnt,
+		struct node_info *ni)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	u32 child_cnt = 0, child_files = 0;
+	enum NODE_TYPE ntype;
+	u32 i_links = le32_to_cpu(node_blk->i.i_links);
+	u64 i_blocks = le32_to_cpu(node_blk->i.i_blocks);
+	int idx = 0;
+	int ret = 0;
+
+	ASSERT(node_blk->footer.nid == node_blk->footer.ino);
+	ASSERT(le32_to_cpu(node_blk->footer.nid) == nid);
+
+	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap) == 0x0)
+		fsck->chk.valid_inode_cnt++;
+
+	/* Orphan node. i_links should be 0 */
+	if (ftype & F2FS_FT_ORPHAN) {
+		ASSERT(i_links == 0);
+
+		if (S_ISDIR(le16_to_cpu(node_blk->i.i_mode)))
+			ftype |= F2FS_FT_DIR;
+		else
+			ftype |= F2FS_FT_REG_FILE;
+	} else {
+		ASSERT(i_links > 0);
+	}
+
+	if (ftype & F2FS_FT_DIR) {
+
+		/* not included '.' & '..' */
+		if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap) != 0) {
+			DBG(0, "Duplicated inode blk. ino[0x%x][0x%x]\n", nid, ni->blk_addr);
+			ASSERT(0);
+		}
+		f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap);
+
+	} else if (ftype & F2FS_FT_REG_FILE) {
+
+		if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap) == 0x0) {
+			f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap);
+			if (i_links > 1) {
+				/* First time. Create new hard link node */
+				add_into_hard_link_list(sbi, nid, i_links);
+				fsck->chk.multi_hard_link_files++;
+			}
+		} else {
+			if (i_links <= 1) {
+				DBG(0, "Error. Node ID [0x%x]."
+						" There are one more hard links."
+						" But i_links is [0x%x]\n",
+						nid, i_links);
+				ASSERT(0);
+			}
+
+			DBG(3, "ino[0x%x] has hard links [0x%x]\n", nid, i_links);
+			ret = find_and_dec_hard_link_list(sbi, nid);
+			ASSERT(ret >= 0);
+
+			/* No need to go deep into the node */
+			goto out;
+
+		}
+	} else {
+		ASSERT(0);
+	}
+
+	fsck_chk_xattr_blk(sbi, le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt);
+
+	/* check data blocks in inode */
+	for (idx = 0; idx < ADDRS_PER_INODE; idx++) {
+		if (le32_to_cpu(node_blk->i.i_addr[idx]) != 0) {
+			*blk_cnt = *blk_cnt + 1;
+			ret = fsck_chk_data_blk(sbi,
+					&node_blk->i,
+					le32_to_cpu(node_blk->i.i_addr[idx]),
+					&child_cnt,
+					&child_files,
+					(i_blocks == *blk_cnt),
+					ftype,
+					nid,
+					idx,
+					ni->version);
+			ASSERT(ret >= 0);
+		}
+	}
+
+	/* check node blocks in inode */
+	for (idx = 0; idx < 5; idx++) {
+		if (idx == 0 || idx == 1)
+			ntype = TYPE_DIRECT_NODE;
+		else if (idx == 2 || idx == 3)
+			ntype = TYPE_INDIRECT_NODE;
+		else if (idx == 4)
+			ntype = TYPE_DOUBLE_INDIRECT_NODE;
+		else
+			ASSERT(0);
+
+		if (le32_to_cpu(node_blk->i.i_nid[idx]) != 0) {
+			*blk_cnt = *blk_cnt + 1;
+			ret = fsck_chk_node_blk(sbi,
+					&node_blk->i,
+					le32_to_cpu(node_blk->i.i_nid[idx]),
+					ftype,
+					ntype,
+					blk_cnt);
+			ASSERT(ret >= 0);
+		}
+	}
+
+	if (ftype & F2FS_FT_DIR)
+		DBG(1, "Directory Inode: ino: %x name: %s depth: %d child files: %d\n\n",
+				le32_to_cpu(node_blk->footer.ino), node_blk->i.i_name,
+				le32_to_cpu(node_blk->i.i_current_depth), child_files);
+	if ((ftype & F2FS_FT_DIR && i_links != child_cnt) ||
+			(i_blocks != *blk_cnt)) {
+		print_node_info(node_blk);
+		DBG(1, "blk   cnt [0x%x]\n", *blk_cnt);
+		DBG(1, "child cnt [0x%x]\n", child_cnt);
+	}
+
+	ASSERT(i_blocks == *blk_cnt);
+	if (ftype & F2FS_FT_DIR)
+		ASSERT(i_links == child_cnt);
+out:
+	return 0;
+}
+
+int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		struct f2fs_node *node_blk,
+		u32 *blk_cnt,
+		struct node_info *ni)
+{
+	int idx;
+	u32 child_cnt = 0, child_files = 0;
+
+	for (idx = 0; idx < ADDRS_PER_BLOCK; idx++) {
+		if (le32_to_cpu(node_blk->dn.addr[idx]) == 0x0)
+			continue;
+		*blk_cnt = *blk_cnt + 1;
+		fsck_chk_data_blk(sbi,
+				inode,
+				le32_to_cpu(node_blk->dn.addr[idx]),
+				&child_cnt,
+				&child_files,
+				le32_to_cpu(inode->i_blocks == *blk_cnt),
+				ftype,
+				nid,
+				idx,
+				ni->version);
+	}
+
+	return 0;
+}
+
+int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		struct f2fs_node *node_blk,
+		u32 *blk_cnt)
+{
+	int i = 0;
+
+	for (i = 0 ; i < NIDS_PER_BLOCK; i++) {
+		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
+			continue;
+		*blk_cnt = *blk_cnt + 1;
+		fsck_chk_node_blk(sbi,
+				inode,
+				le32_to_cpu(node_blk->in.nid[i]),
+				ftype,
+				TYPE_DIRECT_NODE,
+				blk_cnt);
+	}
+
+	return 0;
+}
+
+int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		struct f2fs_node *node_blk,
+		u32 *blk_cnt)
+{
+	int i = 0;
+
+	for (i = 0; i < NIDS_PER_BLOCK; i++) {
+		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
+			continue;
+		*blk_cnt = *blk_cnt + 1;
+		fsck_chk_node_blk(sbi,
+				inode,
+				le32_to_cpu(node_blk->in.nid[i]),
+				ftype,
+				TYPE_INDIRECT_NODE,
+				blk_cnt);
+	}
+
+	return 0;
+}
+
+int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 blk_addr,
+		u32 *child_cnt,
+		u32 *child_files,
+		int last_blk)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	int i;
+	int ret = 0;
+	int dentries = 0;
+	u8 *name;
+	u32 hash_code;
+	u32 blk_cnt;
+	u16 name_len;;
+
+	enum FILE_TYPE ftype;
+
+	struct f2fs_dentry_block *de_blk;
+
+	de_blk = (struct f2fs_dentry_block *)calloc(BLOCK_SZ, 1);
+	ASSERT(de_blk != NULL);
+
+	ret = dev_read_block(de_blk, blk_addr);
+	ASSERT(ret >= 0);
+
+	fsck->dentry_depth++;
+
+	for (i = 0; i < NR_DENTRY_IN_BLOCK;) {
+		if (test_bit(i, (unsigned long *)de_blk->dentry_bitmap) == 0x0) {
+			i++;
+			continue;
+		}
+
+		name_len = le32_to_cpu(de_blk->dentry[i].name_len);
+		name = calloc(name_len + 1, 1);
+		memcpy(name, de_blk->filename[i], name_len);
+
+		hash_code = f2fs_dentry_hash((const char *)name, name_len);
+		ASSERT(le32_to_cpu(de_blk->dentry[i].hash_code) == hash_code);
+
+		ftype = F2FS_FT_REG_FILE;
+
+		/* Becareful. 'dentry.file_type' is not imode. */
+		if (de_blk->dentry[i].file_type == F2FS_FT_DIR) {
+			*child_cnt = *child_cnt + 1;
+			ftype = F2FS_FT_DIR;
+			if ((name[0] == '.' && name[1] == '.' && name_len == 2) ||
+					(name[0] == '.' && name_len == 1)) {
+				i++;
+				free(name);
+				continue;
+			}
+		}
+
+		DBG(2, "[%3u] - no[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
+				fsck->dentry_depth, i, name, name_len,
+				le32_to_cpu(de_blk->dentry[i].ino),
+				de_blk->dentry[i].file_type);
+
+		blk_cnt = 1;
+		ret = fsck_chk_node_blk(sbi,
+				NULL,
+				le32_to_cpu(de_blk->dentry[i].ino),
+				ftype,
+				TYPE_INODE,
+				&blk_cnt);
+
+		ASSERT(ret >= 0);
+
+		i += (name_len + F2FS_NAME_LEN - 1) / F2FS_NAME_LEN;
+		dentries++;
+		*child_files = *child_files + 1;
+		free(name);
+	}
+
+	DBG(1, "[%3d] Dentry Block [0x%x] Done : dentries:%d in %d slots (len:%d)\n\n",
+			fsck->dentry_depth, blk_addr, dentries, NR_DENTRY_IN_BLOCK, F2FS_NAME_LEN);
+	fsck->dentry_depth--;
+
+	free(de_blk);
+	return 0;
+}
+
+int fsck_chk_data_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 blk_addr,
+		u32 *child_cnt,
+		u32 *child_files,
+		int last_blk,
+		enum FILE_TYPE ftype,
+		u32 parent_nid,
+		u16 idx_in_node,
+		u8 ver)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	/* Is it reserved block? */
+	if (blk_addr == NEW_ADDR) {
+		fsck->chk.valid_blk_cnt++;
+		return 0;
+	}
+
+	IS_VALID_BLK_ADDR(sbi, blk_addr);
+
+	is_valid_ssa_data_blk(sbi, blk_addr, parent_nid, idx_in_node, ver);
+
+	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, blk_addr), fsck->sit_area_bitmap) == 0x0) {
+		ASSERT_MSG(0, "SIT bitmap is 0x0. blk_addr[0x%x]\n", blk_addr);
+	}
+
+	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, blk_addr), fsck->main_area_bitmap) != 0) {
+		ASSERT_MSG(0, "Duplicated data block. pnid[0x%x] idx[0x%x] blk_addr[0x%x]\n",
+				parent_nid, idx_in_node, blk_addr);
+	}
+	f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, blk_addr), fsck->main_area_bitmap);
+
+	fsck->chk.valid_blk_cnt++;
+
+	if ((ftype & F2FS_FT_DIR) && !(ftype & F2FS_FT_ORPHAN)) {
+		fsck_chk_dentry_blk(sbi,
+				inode,
+				blk_addr,
+				child_cnt,
+				child_files,
+				last_blk);
+	}
+
+	return 0;
+}
+
+int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	int ret = 0;
+	u32 blk_cnt = 0;
+
+	block_t start_blk, orphan_blkaddr, i, j;
+	struct f2fs_orphan_block *orphan_blk;
+
+	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
+		return 0;
+
+	start_blk = __start_cp_addr(sbi) + 1;
+	orphan_blkaddr = __start_sum_addr(sbi) - 1;
+
+	orphan_blk = calloc(BLOCK_SZ, 1);
+
+	for (i = 0; i < orphan_blkaddr; i++) {
+		dev_read_block(orphan_blk, start_blk + i);
+
+		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
+			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
+			DBG(3, "[%3ld] ino [0x%x]\n", i, ino);
+
+			/* 1) 'fsck_init' build nat_bitmap
+			 * 2) 'fsck_chk_node_blk' clear nat_bitmap if exist in dentry
+			 * 3) if nat_bitmap is already cleared, it means that node exist in dentry,
+			 */
+			if (f2fs_test_bit(ino, fsck->nat_area_bitmap) != 0x0) {
+				f2fs_clear_bit(ino, fsck->nat_area_bitmap);
+			} else {
+				DBG(0, "orphan inode [0x%x] exist in dentry\n", ino);
+				ASSERT(0);
+			}
+
+			DBG(1, "Orphan inode ino[0x%x]\n", ino);
+
+			blk_cnt = 1;
+			ret = fsck_chk_node_blk(sbi,
+					NULL,
+					ino,
+					F2FS_FT_ORPHAN,
+					TYPE_INODE,
+					&blk_cnt);
+			ASSERT(ret >= 0);
+		}
+		memset(orphan_blk, 0, BLOCK_SZ);
+	}
+	free(orphan_blk);
+
+
+	return 0;
+}
+
+int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 x_nid, u32 *blk_cnt)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct node_info ni;
+
+	if (x_nid == 0x0)
+		return 0;
+
+	if (f2fs_test_bit(x_nid, fsck->nat_area_bitmap) != 0x0) {
+		f2fs_clear_bit(x_nid, fsck->nat_area_bitmap);
+	} else {
+		ASSERT_MSG(0, "xattr_nid duplicated [0x%x]\n", x_nid);
+	}
+
+	*blk_cnt = *blk_cnt + 1;
+	fsck->chk.valid_blk_cnt++;
+	fsck->chk.valid_node_cnt++;
+
+	ASSERT(get_node_info(sbi, x_nid, &ni) >= 0);
+
+	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap) != 0) {
+		ASSERT_MSG(0, "Duplicated node block for x_attr. "
+				"x_nid[0x%x] block addr[0x%x]\n",
+				x_nid, ni.blk_addr);
+	}
+	f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap);
+
+	return 0;
+}
+
+int fsck_init(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_sm_info *sm_i = SM_I(sbi);
+
+	/*
+	 * We build three bitmap for main/sit/nat so that may check consistency of filesystem.
+	 * 1. main_area_bitmap will be used to check whether all blocks of main area is used or not.
+	 * 2. nat_area_bitmap has bitmap information of used nid in NAT.
+	 * 3. sit_area_bitmap has bitmap information of used main block.
+	 * At Last sequence, we compare main_area_bitmap with sit_area_bitmap.
+	 */
+	fsck->nr_main_blks = sm_i->main_segments << sbi->log_blocks_per_seg;
+	fsck->main_area_bitmap_sz = (fsck->nr_main_blks + 7) / 8;
+	fsck->main_area_bitmap = calloc(fsck->main_area_bitmap_sz, 1);
+	ASSERT(fsck->main_area_bitmap != NULL);
+
+	build_nat_area_bitmap(sbi);
+
+	build_sit_area_bitmap(sbi);
+
+	return 0;
+}
+
+int fsck_verify(struct f2fs_sb_info *sbi)
+{
+	int i = 0;
+	int ret = 0;
+	u32 nr_unref_nid = 0;
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct hard_link_node *node = NULL;
+
+	printf("\n");
+
+	for (i = 0; i < fsck->nr_nat_entries; i++) {
+		if (f2fs_test_bit(i, fsck->nat_area_bitmap) != 0) {
+			printf("NID[0x%x] is unreachable\n", i);
+			nr_unref_nid++;
+		}
+	}
+
+	if (fsck->hard_link_list_head != NULL) {
+		node = fsck->hard_link_list_head;
+		while (node) {
+			printf("NID[0x%x] has [0x%x] more unreachable links\n",
+					node->nid, node->links);
+			node = node->next;
+		}
+	}
+
+	printf("[FSCK] Unreachable nat entries                       ");
+	if (nr_unref_nid == 0x0) {
+		printf(" [Ok..] [0x%x]\n", nr_unref_nid);
+	} else {
+		printf(" [Fail] [0x%x]\n", nr_unref_nid);
+		ret = EXIT_ERR_CODE;
+	}
+
+	printf("[FSCK] SIT valid block bitmap checking                ");
+	if (memcmp(fsck->sit_area_bitmap, fsck->main_area_bitmap, fsck->sit_area_bitmap_sz) == 0x0) {
+		printf("[Ok..]\n");
+	} else {
+		printf("[Fail]\n");
+		ret = EXIT_ERR_CODE;
+	}
+
+	printf("[FSCK] Hard link checking for regular file           ");
+	if (fsck->hard_link_list_head == NULL) {
+		printf(" [Ok..] [0x%x]\n", fsck->chk.multi_hard_link_files);
+	} else {
+		printf(" [Fail] [0x%x]\n", fsck->chk.multi_hard_link_files);
+		ret = EXIT_ERR_CODE;
+	}
+
+	printf("[FSCK] valid_block_count matching with CP            ");
+	if (sbi->total_valid_block_count == fsck->chk.valid_blk_cnt) {
+		printf(" [Ok..] [0x%lx]\n", fsck->chk.valid_blk_cnt);
+	} else {
+		printf(" [Fail] [0x%lx]\n", fsck->chk.valid_blk_cnt);
+		ret = EXIT_ERR_CODE;
+	}
+
+	printf("[FSCK] valid_node_count matcing with CP (de lookup)  ");
+	if (sbi->total_valid_node_count == fsck->chk.valid_node_cnt) {
+		printf(" [Ok..] [0x%x]\n", fsck->chk.valid_node_cnt);
+	} else {
+		printf(" [Fail] [0x%x]\n", fsck->chk.valid_node_cnt);
+		ret = EXIT_ERR_CODE;
+	}
+
+	printf("[FSCK] valid_node_count matcing with CP (nat lookup) ");
+	if (sbi->total_valid_node_count == fsck->chk.valid_nat_entry_cnt) {
+		printf(" [Ok..] [0x%x]\n", fsck->chk.valid_nat_entry_cnt);
+	} else {
+		printf(" [Fail] [0x%x]\n", fsck->chk.valid_nat_entry_cnt);
+		ret = EXIT_ERR_CODE;
+	}
+
+	printf("[FSCK] valid_inode_count matched with CP             ");
+	if (sbi->total_valid_inode_count == fsck->chk.valid_inode_cnt) {
+		printf(" [Ok..] [0x%x]\n", fsck->chk.valid_inode_cnt);
+	} else {
+		printf(" [Fail] [0x%x]\n", fsck->chk.valid_inode_cnt);
+		ret = EXIT_ERR_CODE;
+	}
+
+	return ret;
+}
+
+void fsck_free(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+		if (fsck->main_area_bitmap)
+		free(fsck->main_area_bitmap);
+
+	if (fsck->nat_area_bitmap)
+		free(fsck->nat_area_bitmap);
+
+	if (fsck->sit_area_bitmap)
+		free(fsck->sit_area_bitmap);
+
+	f2fs_do_umount(sbi);
+}
diff --git a/fsck/fsck.h b/fsck/fsck.h
new file mode 100644
index 0000000..b439222
--- /dev/null
+++ b/fsck/fsck.h
@@ -0,0 +1,163 @@
+/**
+ * fsck.h
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *             http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _FSCK_H_
+#define _FSCK_H_
+
+#include "f2fs.h"
+
+/* fsck.c */
+struct orphan_info {
+	u32 nr_inodes;
+	u32 *ino_list;
+};
+
+struct f2fs_fsck {
+	struct f2fs_sb_info sbi;
+
+	struct orphan_info orphani;
+	struct chk_result {
+		u64 valid_blk_cnt;
+		u32 valid_nat_entry_cnt;
+		u32 valid_node_cnt;
+		u32 valid_inode_cnt;
+		u32 multi_hard_link_files;
+		u64 sit_valid_blocks;
+		u32 sit_free_segs;
+	} chk;
+
+	struct hard_link_node *hard_link_list_head;
+
+	char *main_seg_usage;
+	char *main_area_bitmap;
+	char *nat_area_bitmap;
+	char *sit_area_bitmap;
+
+	u64 main_area_bitmap_sz;
+	u32 nat_area_bitmap_sz;
+	u32 sit_area_bitmap_sz;
+
+	u64 nr_main_blks;
+	u32 nr_nat_entries;
+
+	u32 dentry_depth;
+};
+
+#define BLOCK_SZ		4096
+struct block {
+	unsigned char buf[BLOCK_SZ];
+};
+
+enum NODE_TYPE {
+	TYPE_INODE = 37,
+	TYPE_DIRECT_NODE = 43,
+	TYPE_INDIRECT_NODE = 53,
+	TYPE_DOUBLE_INDIRECT_NODE = 67
+};
+
+struct hard_link_node {
+	u32 nid;
+	u32 links;
+	struct hard_link_node *next;
+};
+
+enum seg_type {
+	SEG_TYPE_DATA,
+	SEG_TYPE_CUR_DATA,
+	SEG_TYPE_NODE,
+	SEG_TYPE_CUR_NODE,
+};
+
+
+extern int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 x_nid, u32 *blk_cnt);
+extern int fsck_chk_orphan_node(struct f2fs_sb_info *sbi);
+
+extern int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		enum NODE_TYPE ntype,
+		u32 *blk_cnt);
+
+extern int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		struct f2fs_node *node_blk,
+		u32 *blk_cnt,
+		struct node_info *ni);
+
+extern int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		struct f2fs_node *node_blk,
+		u32 *blk_cnt,
+		struct node_info *ni);
+
+extern int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		struct f2fs_node *node_blk,
+		u32 *blk_cnt);
+
+extern int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 nid,
+		enum FILE_TYPE ftype,
+		struct f2fs_node *node_blk,
+		u32 *blk_cnt);
+
+extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 blk_addr,
+		u32 *child_cnt,
+		u32 *child_files,
+		int last_blk,
+		enum FILE_TYPE ftype,
+		u32 parent_nid,
+		u16 idx_in_node,
+		u8 ver);
+
+extern int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
+		struct f2fs_inode *inode,
+		u32 blk_addr,
+		u32 *child_cnt,
+		u32 *child_files,
+		int last_blk);
+
+extern void print_node_info(struct f2fs_node *node_block);
+extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *sbi, unsigned int segno);
+extern int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno, struct f2fs_summary_block *sum_blk);
+extern int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr, struct f2fs_summary *sum_entry);
+extern int get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni);
+extern void build_nat_area_bitmap(struct f2fs_sb_info *sbi);
+extern int build_sit_area_bitmap(struct f2fs_sb_info *sbi);
+extern int fsck_init(struct f2fs_sb_info *sbi);
+extern int fsck_verify(struct f2fs_sb_info *sbi);
+extern void fsck_free(struct f2fs_sb_info *sbi);
+extern int f2fs_do_mount(struct f2fs_sb_info *sbi);
+extern void f2fs_do_umount(struct f2fs_sb_info *sbi);
+
+/* dump.c */
+struct dump_option {
+	nid_t nid;
+	int start_sit;
+	int end_sit;
+	int start_ssa;
+	int end_ssa;
+};
+
+extern void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit);
+extern void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa);
+extern int dump_node(struct f2fs_sb_info *sbi, nid_t nid);
+extern void dump_cleanup(struct f2fs_sb_info *sbi);
+
+#endif /* _FSCK_H_ */
diff --git a/fsck/main.c b/fsck/main.c
new file mode 100644
index 0000000..3e12dd8
--- /dev/null
+++ b/fsck/main.c
@@ -0,0 +1,183 @@
+/**
+ * main.c
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *             http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+#include <libgen.h>
+
+struct f2fs_fsck gfsck = {
+	.sbi.fsck = &gfsck,
+};
+
+void fsck_usage()
+{
+	MSG(0, "\nUsage: fsck.f2fs [options] device\n");
+	MSG(0, "[options]:\n");
+	MSG(0, "  -d debug level [default:0]\n");
+	exit(1);
+}
+
+void dump_usage()
+{
+	MSG(0, "\nUsage: dump.f2fs [options] device\n");
+	MSG(0, "[options]:\n");
+	MSG(0, "  -d debug level [default:0]\n");
+	MSG(0, "  -i inode no (hex)\n");
+	MSG(0, "  -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]\n");
+	MSG(0, "  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]\n");
+
+	exit(1);
+}
+
+void f2fs_parse_options(int argc, char *argv[])
+{
+	int option = 0;
+	char *prog = basename(argv[0]);
+
+	if (!strcmp("fsck.f2fs", prog)) {
+		const char *option_string = "d:";
+
+		config.func = FSCK;
+		while ((option = getopt(argc, argv, option_string)) != EOF) {
+			switch (option) {
+				case 'd':
+					config.dbg_lv = atoi(optarg);
+					MSG(0, "Info: Debug level = %d\n", config.dbg_lv);
+					break;
+				default:
+					MSG(0, "\tError: Unknown option %c\n",option);
+					fsck_usage();
+					break;
+			}
+		}
+	} else if (!strcmp("dump.f2fs", prog)) {
+		const char *option_string = "d:i:s:a:";
+		static struct dump_option dump_opt = {
+			.nid = 3,	/* default root ino */
+			.start_sit = -1,
+			.end_sit = -1,
+			.start_ssa = -1,
+			.end_ssa = -1,
+		};
+
+		config.func = DUMP;
+		while ((option = getopt(argc, argv, option_string)) != EOF) {
+			switch (option) {
+				case 'd':
+					config.dbg_lv = atoi(optarg);
+					MSG(0, "Info: Debug level = %d\n", config.dbg_lv);
+					break;
+				case 'i':
+					sscanf(optarg, "%x", &dump_opt.nid);
+					break;
+				case 's':
+					sscanf(optarg, "%d~%d", &dump_opt.start_sit, &dump_opt.end_sit);
+					break;
+				case 'a':
+					sscanf(optarg, "%d~%d", &dump_opt.start_ssa, &dump_opt.end_ssa);
+					break;
+				default:
+					MSG(0, "\tError: Unknown option %c\n", option);
+					dump_usage();
+					break;
+			}
+		}
+
+		config.private = &dump_opt;
+	}
+
+	if ((optind + 1) != argc) {
+		MSG(0, "\tError: Device not specified\n");
+		if (config.func == FSCK)
+			fsck_usage();
+		else if (config.func == DUMP)
+			dump_usage();
+	}
+	config.device_name = argv[optind];
+}
+
+int do_fsck(struct f2fs_sb_info *sbi)
+{
+	u32 blk_cnt;
+	int ret;
+
+	ret = fsck_init(sbi);
+	if (ret < 0)
+		return ret;
+
+	fsck_chk_orphan_node(sbi);
+
+	/* Travses all block recursively from root inode  */
+	blk_cnt = 1;
+	ret = fsck_chk_node_blk(sbi,
+			NULL,
+			sbi->root_ino_num,
+			F2FS_FT_DIR,
+			TYPE_INODE,
+			&blk_cnt);
+	if (ret < 0)
+		goto out1;
+
+	ret = fsck_verify(sbi);
+
+out1:
+	fsck_free(sbi);
+	return ret;
+}
+
+int do_dump(struct f2fs_sb_info *sbi)
+{
+	struct dump_option *opt = (struct dump_option *)config.private;
+
+	if (opt->end_sit == -1)
+		opt->end_sit = SM_I(sbi)->main_segments;
+	if (opt->end_ssa == -1)
+		opt->end_ssa = SM_I(sbi)->main_segments;
+	if (opt->start_sit != -1)
+		sit_dump(sbi, opt->start_sit, opt->end_sit);
+	if (opt->start_ssa != -1)
+		ssa_dump(sbi, opt->start_ssa, opt->end_ssa);
+
+	dump_node(sbi, opt->nid);
+
+	dump_cleanup(sbi);
+	return 0;
+}
+
+int main (int argc, char **argv)
+{
+	struct f2fs_sb_info *sbi = &gfsck.sbi;
+	int ret = 0;
+
+	f2fs_init_configuration(&config);
+
+	f2fs_parse_options(argc, argv);
+
+	if (f2fs_dev_is_mounted(&config) < 0)
+		return -1;
+
+	/* Get device */
+	if (f2fs_get_device_info(&config) < 0)
+		return -1;
+
+	if (f2fs_do_mount(sbi) < 0)
+		return -1;
+
+	switch (config.func) {
+		case FSCK:
+			ret = do_fsck(sbi);
+			break;
+		case DUMP:
+			ret = do_dump(sbi);
+			break;
+	}
+
+	printf("\nDone.\n");
+	return ret;
+}
diff --git a/fsck/mount.c b/fsck/mount.c
new file mode 100644
index 0000000..1ed5050
--- /dev/null
+++ b/fsck/mount.c
@@ -0,0 +1,1111 @@
+/**
+ * mount.c
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *             http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+
+void print_inode_info(struct f2fs_inode *inode)
+{
+	int i = 0;
+	int namelen = le32_to_cpu(inode->i_namelen);
+
+	DISP_u32(inode, i_mode);
+	DISP_u32(inode, i_uid);
+	DISP_u32(inode, i_gid);
+	DISP_u32(inode, i_links);
+	DISP_u64(inode, i_size);
+	DISP_u64(inode, i_blocks);
+
+	DISP_u64(inode, i_atime);
+	DISP_u32(inode, i_atime_nsec);
+	DISP_u64(inode, i_ctime);
+	DISP_u32(inode, i_ctime_nsec);
+	DISP_u64(inode, i_mtime);
+	DISP_u32(inode, i_mtime_nsec);
+
+	DISP_u32(inode, i_generation);
+	DISP_u32(inode, i_current_depth);
+	DISP_u32(inode, i_xattr_nid);
+	DISP_u32(inode, i_flags);
+	DISP_u32(inode, i_pino);
+
+	if (namelen) {
+		DISP_u32(inode, i_namelen);
+		inode->i_name[namelen] = '\0';
+		DISP_utf(inode, i_name);
+	}
+
+	printf("i_ext: fofs:%x blkaddr:%x len:%x\n",
+			inode->i_ext.fofs,
+			inode->i_ext.blk_addr,
+			inode->i_ext.len);
+
+	DISP_u32(inode, i_addr[0]);	/* Pointers to data blocks */
+	DISP_u32(inode, i_addr[1]);	/* Pointers to data blocks */
+	DISP_u32(inode, i_addr[2]);	/* Pointers to data blocks */
+	DISP_u32(inode, i_addr[3]);	/* Pointers to data blocks */
+
+	for (i = 4; i < ADDRS_PER_INODE; i++) {
+		if (inode->i_addr[i] != 0x0) {
+			printf("i_addr[0x%x] points data block\r\t\t\t\t[0x%4x]\n",
+					i, inode->i_addr[i]);
+			break;
+		}
+	}
+
+	DISP_u32(inode, i_nid[0]);	/* direct */
+	DISP_u32(inode, i_nid[1]);	/* direct */
+	DISP_u32(inode, i_nid[2]);	/* indirect */
+	DISP_u32(inode, i_nid[3]);	/* indirect */
+	DISP_u32(inode, i_nid[4]);	/* double indirect */
+
+	printf("\n");
+}
+
+void print_node_info(struct f2fs_node *node_block)
+{
+	nid_t ino = le32_to_cpu(node_block->footer.ino);
+	nid_t nid = le32_to_cpu(node_block->footer.nid);
+	/* Is this inode? */
+	if (ino == nid) {
+		DBG(0, "Node ID [0x%x:%u] is inode\n", nid, nid);
+		print_inode_info(&node_block->i);
+	} else {
+		DBG(0, "Node ID [0x%x:%u] is direct node or indirect node.\n", nid, nid);
+	}
+}
+
+void print_raw_sb_info(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	printf("\n");
+	printf("+--------------------------------------------------------+\n");
+	printf("| Super block                                            |\n");
+	printf("+--------------------------------------------------------+\n");
+
+	DISP_u32(sb, magic);
+	DISP_u32(sb, major_ver);
+	DISP_u32(sb, minor_ver);
+	DISP_u32(sb, log_sectorsize);
+	DISP_u32(sb, log_sectors_per_block);
+
+	DISP_u32(sb, log_blocksize);
+	DISP_u32(sb, log_blocks_per_seg);
+	DISP_u32(sb, segs_per_sec);
+	DISP_u32(sb, secs_per_zone);
+	DISP_u32(sb, checksum_offset);
+	DISP_u64(sb, block_count);
+
+	DISP_u32(sb, section_count);
+	DISP_u32(sb, segment_count);
+	DISP_u32(sb, segment_count_ckpt);
+	DISP_u32(sb, segment_count_sit);
+	DISP_u32(sb, segment_count_nat);
+
+	DISP_u32(sb, segment_count_ssa);
+	DISP_u32(sb, segment_count_main);
+	DISP_u32(sb, segment0_blkaddr);
+
+	DISP_u32(sb, cp_blkaddr);
+	DISP_u32(sb, sit_blkaddr);
+	DISP_u32(sb, nat_blkaddr);
+	DISP_u32(sb, ssa_blkaddr);
+	DISP_u32(sb, main_blkaddr);
+
+	DISP_u32(sb, root_ino);
+	DISP_u32(sb, node_ino);
+	DISP_u32(sb, meta_ino);
+	printf("\n");
+}
+
+void print_ckpt_info(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+
+	printf("\n");
+	printf("+--------------------------------------------------------+\n");
+	printf("| Checkpoint                                             |\n");
+	printf("+--------------------------------------------------------+\n");
+
+	DISP_u64(cp, checkpoint_ver);
+	DISP_u64(cp, user_block_count);
+	DISP_u64(cp, valid_block_count);
+	DISP_u32(cp, rsvd_segment_count);
+	DISP_u32(cp, overprov_segment_count);
+	DISP_u32(cp, free_segment_count);
+
+	DISP_u32(cp, alloc_type[CURSEG_HOT_NODE]);
+	DISP_u32(cp, alloc_type[CURSEG_WARM_NODE]);
+	DISP_u32(cp, alloc_type[CURSEG_COLD_NODE]);
+	DISP_u32(cp, cur_node_segno[0]);
+	DISP_u32(cp, cur_node_segno[1]);
+	DISP_u32(cp, cur_node_segno[2]);
+
+	DISP_u32(cp, cur_node_blkoff[0]);
+	DISP_u32(cp, cur_node_blkoff[1]);
+	DISP_u32(cp, cur_node_blkoff[2]);
+
+
+	DISP_u32(cp, alloc_type[CURSEG_HOT_DATA]);
+	DISP_u32(cp, alloc_type[CURSEG_WARM_DATA]);
+	DISP_u32(cp, alloc_type[CURSEG_COLD_DATA]);
+	DISP_u32(cp, cur_data_segno[0]);
+	DISP_u32(cp, cur_data_segno[1]);
+	DISP_u32(cp, cur_data_segno[2]);
+
+	DISP_u32(cp, cur_data_blkoff[0]);
+	DISP_u32(cp, cur_data_blkoff[1]);
+	DISP_u32(cp, cur_data_blkoff[2]);
+
+	DISP_u32(cp, ckpt_flags);
+	DISP_u32(cp, cp_pack_total_block_count);
+	DISP_u32(cp, cp_pack_start_sum);
+	DISP_u32(cp, valid_node_count);
+	DISP_u32(cp, valid_inode_count);
+	DISP_u32(cp, next_free_nid);
+	DISP_u32(cp, sit_ver_bitmap_bytesize);
+	DISP_u32(cp, nat_ver_bitmap_bytesize);
+	DISP_u32(cp, checksum_offset);
+	DISP_u64(cp, elapsed_time);
+
+	DISP_u32(cp, sit_nat_version_bitmap[0]);
+	printf("\n\n");
+}
+
+int sanity_check_raw_super(struct f2fs_super_block *raw_super)
+{
+	unsigned int blocksize;
+
+	if (F2FS_SUPER_MAGIC != le32_to_cpu(raw_super->magic)) {
+		return -1;
+	}
+
+	if (F2FS_BLKSIZE != PAGE_CACHE_SIZE) {
+		return -1;
+	}
+
+	blocksize = 1 << le32_to_cpu(raw_super->log_blocksize);
+	if (F2FS_BLKSIZE != blocksize) {
+		return -1;
+	}
+
+	if (F2FS_LOG_SECTOR_SIZE != le32_to_cpu(raw_super->log_sectorsize)) {
+		return -1;
+	}
+
+	if (F2FS_LOG_SECTORS_PER_BLOCK != le32_to_cpu(raw_super->log_sectors_per_block)) {
+		return -1;
+	}
+
+	return 0;
+}
+
+int validate_super_block(struct f2fs_sb_info *sbi, int block)
+{
+	u64 offset = (block + 1) * F2FS_SUPER_OFFSET;
+	sbi->raw_super = malloc(sizeof(struct f2fs_super_block));
+
+	if (dev_read(sbi->raw_super, offset, sizeof(struct f2fs_super_block)))
+		return -1;
+
+	if (!sanity_check_raw_super(sbi->raw_super))
+		return 0;
+
+	free(sbi->raw_super);
+	MSG(0, "\tCan't find a valid F2FS filesystem in %d superblock\n", block);
+
+	return -EINVAL;
+}
+
+int init_sb_info(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *raw_super = sbi->raw_super;
+
+	sbi->log_sectors_per_block =
+		le32_to_cpu(raw_super->log_sectors_per_block);
+	sbi->log_blocksize = le32_to_cpu(raw_super->log_blocksize);
+	sbi->blocksize = 1 << sbi->log_blocksize;
+	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
+	sbi->blocks_per_seg = 1 << sbi->log_blocks_per_seg;
+	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
+	sbi->secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
+	sbi->total_sections = le32_to_cpu(raw_super->section_count);
+	sbi->total_node_count =
+		(le32_to_cpu(raw_super->segment_count_nat) / 2)
+		* sbi->blocks_per_seg * NAT_ENTRY_PER_BLOCK;
+	sbi->root_ino_num = le32_to_cpu(raw_super->root_ino);
+	sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
+	sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
+	sbi->cur_victim_sec = NULL_SEGNO;
+	return 0;
+}
+
+void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr, unsigned long long *version)
+{
+	void *cp_page_1, *cp_page_2;
+	struct f2fs_checkpoint *cp_block;
+	unsigned long blk_size = sbi->blocksize;
+	unsigned long long cur_version = 0, pre_version = 0;
+	unsigned int crc = 0;
+	size_t crc_offset;
+
+	/* Read the 1st cp block in this CP pack */
+	cp_page_1 = malloc(PAGE_SIZE);
+	if (dev_read_block(cp_page_1, cp_addr) < 0)
+		return NULL;
+
+	cp_block = (struct f2fs_checkpoint *)cp_page_1;
+	crc_offset = le32_to_cpu(cp_block->checksum_offset);
+	if (crc_offset >= blk_size)
+		goto invalid_cp1;
+
+	crc = *(unsigned int *)((unsigned char *)cp_block + crc_offset);
+	if (f2fs_crc_valid(crc, cp_block, crc_offset))
+		goto invalid_cp1;
+
+	pre_version = le64_to_cpu(cp_block->checkpoint_ver);
+
+	/* Read the 2nd cp block in this CP pack */
+	cp_page_2 = malloc(PAGE_SIZE);
+	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
+	if (dev_read_block(cp_page_2, cp_addr) < 0)
+		goto invalid_cp2;
+
+	cp_block = (struct f2fs_checkpoint *)cp_page_2;
+	crc_offset = le32_to_cpu(cp_block->checksum_offset);
+	if (crc_offset >= blk_size)
+		goto invalid_cp2;
+
+	crc = *(unsigned int *)((unsigned char *)cp_block + crc_offset);
+	if (f2fs_crc_valid(crc, cp_block, crc_offset))
+		goto invalid_cp1;
+
+	cur_version = le64_to_cpu(cp_block->checkpoint_ver);
+
+	if (cur_version == pre_version) {
+		*version = cur_version;
+		free(cp_page_2);
+		return cp_page_1;
+	}
+
+invalid_cp2:
+	free(cp_page_2);
+invalid_cp1:
+	free(cp_page_1);
+	return NULL;
+}
+
+int get_valid_checkpoint(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *raw_sb = sbi->raw_super;
+	void *cp1, *cp2, *cur_page;
+	unsigned long blk_size = sbi->blocksize;
+	unsigned long long cp1_version = 0, cp2_version = 0;
+	unsigned long long cp_start_blk_no;
+
+	sbi->ckpt = malloc(blk_size);
+	if (!sbi->ckpt)
+		return -ENOMEM;
+	/*
+	 * Finding out valid cp block involves read both
+	 * sets( cp pack1 and cp pack 2)
+	 */
+	cp_start_blk_no = le32_to_cpu(raw_sb->cp_blkaddr);
+	cp1 = validate_checkpoint(sbi, cp_start_blk_no, &cp1_version);
+
+	/* The second checkpoint pack should start at the next segment */
+	cp_start_blk_no += 1 << le32_to_cpu(raw_sb->log_blocks_per_seg);
+	cp2 = validate_checkpoint(sbi, cp_start_blk_no, &cp2_version);
+
+	if (cp1 && cp2) {
+		if (ver_after(cp2_version, cp1_version))
+			cur_page = cp2;
+		else
+			cur_page = cp1;
+	} else if (cp1) {
+		cur_page = cp1;
+	} else if (cp2) {
+		cur_page = cp2;
+	} else {
+		free(cp1);
+		free(cp2);
+		goto fail_no_cp;
+	}
+
+	memcpy(sbi->ckpt, cur_page, blk_size);
+
+	free(cp1);
+	free(cp2);
+	return 0;
+
+fail_no_cp:
+	free(sbi->ckpt);
+	return -EINVAL;
+}
+
+int sanity_check_ckpt(struct f2fs_sb_info *sbi)
+{
+	unsigned int total, fsmeta;
+	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+
+	total = le32_to_cpu(raw_super->segment_count);
+	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
+	fsmeta += le32_to_cpu(raw_super->segment_count_sit);
+	fsmeta += le32_to_cpu(raw_super->segment_count_nat);
+	fsmeta += le32_to_cpu(ckpt->rsvd_segment_count);
+	fsmeta += le32_to_cpu(raw_super->segment_count_ssa);
+
+	if (fsmeta >= total)
+		return 1;
+
+	return 0;
+}
+
+int init_node_manager(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *sb_raw = F2FS_RAW_SUPER(sbi);
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	unsigned char *version_bitmap;
+	unsigned int nat_segs, nat_blocks;
+
+	nm_i->nat_blkaddr = le32_to_cpu(sb_raw->nat_blkaddr);
+
+	/* segment_count_nat includes pair segment so divide to 2. */
+	nat_segs = le32_to_cpu(sb_raw->segment_count_nat) >> 1;
+	nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
+	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
+	nm_i->fcnt = 0;
+	nm_i->nat_cnt = 0;
+	nm_i->init_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
+	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
+
+	nm_i->bitmap_size = __bitmap_size(sbi, NAT_BITMAP);
+
+	nm_i->nat_bitmap = malloc(nm_i->bitmap_size);
+	if (!nm_i->nat_bitmap)
+		return -ENOMEM;
+	version_bitmap = __bitmap_ptr(sbi, NAT_BITMAP);
+	if (!version_bitmap)
+		return -EFAULT;
+
+	/* copy version bitmap */
+	memcpy(nm_i->nat_bitmap, version_bitmap, nm_i->bitmap_size);
+	return 0;
+}
+
+int build_node_manager(struct f2fs_sb_info *sbi)
+{
+	int err;
+	sbi->nm_info = malloc(sizeof(struct f2fs_nm_info));
+	if (!sbi->nm_info)
+		return -ENOMEM;
+
+	err = init_node_manager(sbi);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int build_sit_info(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *raw_sb = F2FS_RAW_SUPER(sbi);
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct sit_info *sit_i;
+	unsigned int sit_segs, start;
+	char *src_bitmap, *dst_bitmap;
+	unsigned int bitmap_size;
+
+	sit_i = malloc(sizeof(struct sit_info));
+	if (!sit_i)
+		return -ENOMEM;
+
+	SM_I(sbi)->sit_info = sit_i;
+
+	sit_i->sentries = calloc(TOTAL_SEGS(sbi) * sizeof(struct seg_entry), 1);
+
+	for (start = 0; start < TOTAL_SEGS(sbi); start++) {
+		sit_i->sentries[start].cur_valid_map
+			= calloc(SIT_VBLOCK_MAP_SIZE, 1);
+		sit_i->sentries[start].ckpt_valid_map
+			= calloc(SIT_VBLOCK_MAP_SIZE, 1);
+		if (!sit_i->sentries[start].cur_valid_map
+				|| !sit_i->sentries[start].ckpt_valid_map)
+			return -ENOMEM;
+	}
+
+	sit_segs = le32_to_cpu(raw_sb->segment_count_sit) >> 1;
+	bitmap_size = __bitmap_size(sbi, SIT_BITMAP);
+	src_bitmap = __bitmap_ptr(sbi, SIT_BITMAP);
+
+	dst_bitmap = malloc(bitmap_size);
+	memcpy(dst_bitmap, src_bitmap, bitmap_size);
+
+	sit_i->sit_base_addr = le32_to_cpu(raw_sb->sit_blkaddr);
+	sit_i->sit_blocks = sit_segs << sbi->log_blocks_per_seg;
+	sit_i->written_valid_blocks = le64_to_cpu(ckpt->valid_block_count);
+	sit_i->sit_bitmap = dst_bitmap;
+	sit_i->bitmap_size = bitmap_size;
+	sit_i->dirty_sentries = 0;
+	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
+	sit_i->elapsed_time = le64_to_cpu(ckpt->elapsed_time);
+	return 0;
+}
+
+void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
+
+	curseg->segno = curseg->next_segno;
+	curseg->zone = GET_ZONENO_FROM_SEGNO(sbi, curseg->segno);
+	curseg->next_blkoff = 0;
+	curseg->next_segno = NULL_SEGNO;
+
+}
+
+int read_compacted_summaries(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct curseg_info *curseg;
+	block_t start;
+	char *kaddr;
+	unsigned int i, j, offset;
+
+	start = start_sum_block(sbi);
+
+	kaddr = (char *)malloc(PAGE_SIZE);
+	dev_read_block(kaddr, start++);
+
+	curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
+	memcpy(&curseg->sum_blk->n_nats, kaddr, SUM_JOURNAL_SIZE);
+
+	curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
+	memcpy(&curseg->sum_blk->n_sits, kaddr + SUM_JOURNAL_SIZE, SUM_JOURNAL_SIZE);
+
+	offset = 2 * SUM_JOURNAL_SIZE;
+	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
+		unsigned short blk_off;
+		unsigned int segno;
+
+		curseg = CURSEG_I(sbi, i);
+		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
+		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
+		curseg->next_segno = segno;
+		reset_curseg(sbi, i, 0);
+		curseg->alloc_type = ckpt->alloc_type[i];
+		curseg->next_blkoff = blk_off;
+
+		if (curseg->alloc_type == SSR)
+			blk_off = sbi->blocks_per_seg;
+
+		for (j = 0; j < blk_off; j++) {
+			struct f2fs_summary *s;
+			s = (struct f2fs_summary *)(kaddr + offset);
+			curseg->sum_blk->entries[j] = *s;
+			offset += SUMMARY_SIZE;
+			if (offset + SUMMARY_SIZE <= PAGE_CACHE_SIZE - SUM_FOOTER_SIZE)
+				continue;
+			memset(kaddr, 0, PAGE_SIZE);
+			dev_read_block(kaddr, start++);
+			offset = 0;
+		}
+	}
+
+	free(kaddr);
+	return 0;
+}
+
+int restore_node_summary(struct f2fs_sb_info *sbi,
+		unsigned int segno, struct f2fs_summary_block *sum_blk)
+{
+	struct f2fs_node *node_blk;
+	struct f2fs_summary *sum_entry;
+	void *page;
+	block_t addr;
+	int i;
+
+	page = malloc(PAGE_SIZE);
+	if (!page)
+		return -ENOMEM;
+
+	/* scan the node segment */
+	addr = START_BLOCK(sbi, segno);
+	sum_entry = &sum_blk->entries[0];
+
+	for (i = 0; i < sbi->blocks_per_seg; i++, sum_entry++) {
+		if (dev_read_block(page, addr))
+			goto out;
+
+		node_blk = (struct f2fs_node *)page;
+		sum_entry->nid = node_blk->footer.nid;
+		/* do not change original value */
+#if 0
+		sum_entry->version = 0;
+		sum_entry->ofs_in_node = 0;
+#endif
+		addr++;
+
+	}
+out:
+	free(page);
+	return 0;
+}
+
+int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
+{
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_summary_block *sum_blk;
+	struct curseg_info *curseg;
+	unsigned short blk_off;
+	unsigned int segno = 0;
+	block_t blk_addr = 0;
+
+	if (IS_DATASEG(type)) {
+		segno = le32_to_cpu(ckpt->cur_data_segno[type]);
+		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[type - CURSEG_HOT_DATA]);
+
+		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
+			blk_addr = sum_blk_addr(sbi, NR_CURSEG_TYPE, type);
+		else
+			blk_addr = sum_blk_addr(sbi, NR_CURSEG_DATA_TYPE, type);
+	} else {
+		segno = le32_to_cpu(ckpt->cur_node_segno[type - CURSEG_HOT_NODE]);
+		blk_off = le16_to_cpu(ckpt->cur_node_blkoff[type - CURSEG_HOT_NODE]);
+
+		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
+			blk_addr = sum_blk_addr(sbi, NR_CURSEG_NODE_TYPE, type - CURSEG_HOT_NODE);
+		else
+			blk_addr = GET_SUM_BLKADDR(sbi, segno);
+	}
+
+	sum_blk = (struct f2fs_summary_block *)malloc(PAGE_SIZE);
+	dev_read_block(sum_blk, blk_addr);
+
+	if (IS_NODESEG(type)) {
+		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG)) {
+			struct f2fs_summary *sum_entry = &sum_blk->entries[0];
+			int i;
+			for (i = 0; i < sbi->blocks_per_seg; i++, sum_entry++) {
+				/* do not change original value */
+#if 0
+				sum_entry->version = 0;
+				sum_entry->ofs_in_node = 0;
+#endif
+			}
+		} else {
+			if (restore_node_summary(sbi, segno, sum_blk)) {
+				free(sum_blk);
+				return -EINVAL;
+			}
+		}
+	}
+
+	curseg = CURSEG_I(sbi, type);
+	memcpy(curseg->sum_blk, sum_blk, PAGE_CACHE_SIZE);
+	curseg->next_segno = segno;
+	reset_curseg(sbi, type, 0);
+	curseg->alloc_type = ckpt->alloc_type[type];
+	curseg->next_blkoff = blk_off;
+	free(sum_blk);
+
+	return 0;
+}
+
+int restore_curseg_summaries(struct f2fs_sb_info *sbi)
+{
+	int type = CURSEG_HOT_DATA;
+
+	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_COMPACT_SUM_FLAG)) {
+		if (read_compacted_summaries(sbi))
+			return -EINVAL;
+		type = CURSEG_HOT_NODE;
+	}
+
+	for (; type <= CURSEG_COLD_NODE; type++) {
+		if (read_normal_summaries(sbi, type))
+			return -EINVAL;
+	}
+	return 0;
+}
+
+int build_curseg(struct f2fs_sb_info *sbi)
+{
+	struct curseg_info *array;
+	int i;
+
+	array = malloc(sizeof(*array) * NR_CURSEG_TYPE);
+
+	SM_I(sbi)->curseg_array = array;
+
+	for (i = 0; i < NR_CURSEG_TYPE; i++) {
+		array[i].sum_blk = malloc(PAGE_CACHE_SIZE);
+		if (!array[i].sum_blk)
+			return -ENOMEM;
+		array[i].segno = NULL_SEGNO;
+		array[i].next_blkoff = 0;
+	}
+	return restore_curseg_summaries(sbi);
+}
+
+inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	unsigned int end_segno = SM_I(sbi)->segment_count - 1;
+	ASSERT(segno <= end_segno);
+}
+
+struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	unsigned int offset = SIT_BLOCK_OFFSET(sit_i, segno);
+	block_t blk_addr = sit_i->sit_base_addr + offset;
+	struct f2fs_sit_block *sit_blk = calloc(BLOCK_SZ, 1);
+
+	check_seg_range(sbi, segno);
+
+	/* calculate sit block address */
+	if (f2fs_test_bit(offset, sit_i->sit_bitmap))
+		blk_addr += sit_i->sit_blocks;
+
+	dev_read_block(sit_blk, blk_addr);
+
+	return sit_blk;
+}
+
+void check_block_count(struct f2fs_sb_info *sbi,
+		int segno, struct f2fs_sit_entry *raw_sit)
+{
+	struct f2fs_sm_info *sm_info = SM_I(sbi);
+	unsigned int end_segno = sm_info->segment_count - 1;
+	int valid_blocks = 0;
+	int i;
+
+	/* check segment usage */
+	ASSERT(GET_SIT_VBLOCKS(raw_sit) <= sbi->blocks_per_seg);
+
+	/* check boundary of a given segment number */
+	ASSERT(segno <= end_segno);
+
+	/* check bitmap with valid block count */
+	for (i = 0; i < sbi->blocks_per_seg; i++)
+		if (f2fs_test_bit(i, (char *)raw_sit->valid_map))
+			valid_blocks++;
+	ASSERT(GET_SIT_VBLOCKS(raw_sit) == valid_blocks);
+}
+
+void seg_info_from_raw_sit(struct seg_entry *se,
+		struct f2fs_sit_entry *raw_sit)
+{
+	se->valid_blocks = GET_SIT_VBLOCKS(raw_sit);
+	se->ckpt_valid_blocks = GET_SIT_VBLOCKS(raw_sit);
+	memcpy(se->cur_valid_map, raw_sit->valid_map, SIT_VBLOCK_MAP_SIZE);
+	memcpy(se->ckpt_valid_map, raw_sit->valid_map, SIT_VBLOCK_MAP_SIZE);
+	se->type = GET_SIT_TYPE(raw_sit);
+	se->mtime = le64_to_cpu(raw_sit->mtime);
+}
+
+struct seg_entry *get_seg_entry(struct f2fs_sb_info *sbi,
+		unsigned int segno)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	return &sit_i->sentries[segno];
+}
+
+int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno, struct f2fs_summary_block *sum_blk)
+{
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct curseg_info *curseg;
+	int type, ret;
+	u64 ssa_blk;
+
+	ssa_blk = GET_SUM_BLKADDR(sbi, segno);
+	for (type = 0; type < NR_CURSEG_NODE_TYPE; type++) {
+		if (segno == ckpt->cur_node_segno[type]) {
+			curseg = CURSEG_I(sbi, type);
+			memcpy(sum_blk, curseg->sum_blk, BLOCK_SZ);
+			return SEG_TYPE_CUR_NODE; /* current node seg was not stored */
+		}
+	}
+
+	for (type = 0; type < NR_CURSEG_DATA_TYPE; type++) {
+		if (segno == ckpt->cur_data_segno[type]) {
+			curseg = CURSEG_I(sbi, type);
+			memcpy(sum_blk, curseg->sum_blk, BLOCK_SZ);
+			ASSERT(!IS_SUM_NODE_SEG(sum_blk->footer));
+			DBG(2, "segno [0x%x] is current data seg[0x%x]\n", segno, type);
+			return SEG_TYPE_CUR_DATA; /* current data seg was not stored */
+		}
+	}
+
+	ret = dev_read_block(sum_blk, ssa_blk);
+	ASSERT(ret >= 0);
+
+	if (IS_SUM_NODE_SEG(sum_blk->footer))
+		return SEG_TYPE_NODE;
+	else
+		return SEG_TYPE_DATA;
+
+}
+
+int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr, struct f2fs_summary *sum_entry)
+{
+	struct f2fs_summary_block *sum_blk;
+	u32 segno, offset;
+	int ret;
+
+	segno = GET_SEGNO(sbi, blk_addr);
+	offset = OFFSET_IN_SEG(sbi, blk_addr);
+
+	sum_blk = calloc(BLOCK_SZ, 1);
+
+	ret = get_sum_block(sbi, segno, sum_blk);
+
+	memcpy(sum_entry, &(sum_blk->entries[offset]), sizeof(struct f2fs_summary));
+
+	free(sum_blk);
+	return ret;
+}
+
+int get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid, struct f2fs_nat_entry *raw_nat)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct f2fs_nat_block *nat_block;
+	pgoff_t block_off;
+	pgoff_t block_addr;
+	int seg_off, entry_off;
+	int ret;
+
+	if (nid / NAT_ENTRY_PER_BLOCK > (fsck->nat_area_bitmap_sz * 8)) {
+		DBG(0, "\n");
+		return -EINVAL;
+	}
+
+	if (lookup_nat_in_journal(sbi, nid, raw_nat) >= 0)
+		return 0;
+
+	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+
+	block_off = nid / NAT_ENTRY_PER_BLOCK;
+	entry_off = nid % NAT_ENTRY_PER_BLOCK;
+
+	seg_off = block_off >> sbi->log_blocks_per_seg;
+	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
+			(seg_off << sbi->log_blocks_per_seg << 1) +
+			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
+
+	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
+		block_addr += sbi->blocks_per_seg;
+
+	ret = dev_read_block(nat_block, block_addr);
+	ASSERT(ret >= 0);
+
+	memcpy(raw_nat, &nat_block->entries[entry_off], sizeof(struct f2fs_nat_entry));
+	free(nat_block);
+
+	return 0;
+}
+
+int get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
+{
+	struct f2fs_nat_entry raw_nat;
+	int ret;
+
+	ret = get_nat_entry(sbi, nid, &raw_nat);
+	ni->nid = nid;
+	node_info_from_raw_nat(ni, &raw_nat);
+	return ret;
+}
+
+void build_sit_entries(struct f2fs_sb_info *sbi)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
+	struct f2fs_summary_block *sum = curseg->sum_blk;
+	unsigned int segno;
+
+	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
+		struct seg_entry *se = &sit_i->sentries[segno];
+		struct f2fs_sit_block *sit_blk;
+		struct f2fs_sit_entry sit;
+		int i;
+
+		for (i = 0; i < sits_in_cursum(sum); i++) {
+			if (le32_to_cpu(segno_in_journal(sum, i)) == segno) {
+				sit = sit_in_journal(sum, i);
+				goto got_it;
+			}
+		}
+		sit_blk = get_current_sit_page(sbi, segno);
+		sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno)];
+		free(sit_blk);
+got_it:
+		check_block_count(sbi, segno, &sit);
+		seg_info_from_raw_sit(se, &sit);
+	}
+
+}
+
+int build_segment_manager(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_sm_info *sm_info;
+
+	sm_info = malloc(sizeof(struct f2fs_sm_info));
+	if (!sm_info)
+		return -ENOMEM;
+
+	/* init sm info */
+	sbi->sm_info = sm_info;
+	sm_info->seg0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
+	sm_info->main_blkaddr = le32_to_cpu(raw_super->main_blkaddr);
+	sm_info->segment_count = le32_to_cpu(raw_super->segment_count);
+	sm_info->reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
+	sm_info->ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
+	sm_info->main_segments = le32_to_cpu(raw_super->segment_count_main);
+	sm_info->ssa_blkaddr = le32_to_cpu(raw_super->ssa_blkaddr);
+
+	build_sit_info(sbi);
+
+	build_curseg(sbi);
+
+	build_sit_entries(sbi);
+
+	return 0;
+}
+
+int build_sit_area_bitmap(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_sm_info *sm_i = SM_I(sbi);
+	int segno = 0, j = 0;
+	char *ptr = NULL;
+
+	u32 sum_vblocks = 0;
+	u32 free_segs = 0;
+	u32 vblocks = 0;
+
+	struct seg_entry *se;
+
+	fsck->sit_area_bitmap_sz = sm_i->main_segments * SIT_VBLOCK_MAP_SIZE;
+	fsck->sit_area_bitmap = calloc(1, fsck->sit_area_bitmap_sz);
+	ptr = fsck->sit_area_bitmap;
+
+	ASSERT(fsck->sit_area_bitmap_sz == fsck->main_area_bitmap_sz);
+
+	for (segno = 0; segno < sm_i->main_segments; segno++) {
+		se = get_seg_entry(sbi, segno);
+
+		memcpy(ptr, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
+		ptr += SIT_VBLOCK_MAP_SIZE;
+
+		vblocks = 0;
+		for (j = 0; j < SIT_VBLOCK_MAP_SIZE; j++) {
+			vblocks += get_bits_in_byte(se->cur_valid_map[j]);
+		}
+		ASSERT(vblocks == se->valid_blocks);
+
+		if (se->valid_blocks == 0x0) {
+
+			if (sbi->ckpt->cur_node_segno[0] == segno ||
+					sbi->ckpt->cur_data_segno[0] == segno ||
+					sbi->ckpt->cur_node_segno[1] == segno ||
+					sbi->ckpt->cur_data_segno[1] == segno ||
+					sbi->ckpt->cur_node_segno[2] == segno ||
+					sbi->ckpt->cur_data_segno[2] == segno) {
+				continue;
+			} else {
+				free_segs++;
+			}
+
+		} else {
+			ASSERT(se->valid_blocks <= 512);
+			sum_vblocks += se->valid_blocks;
+		}
+	}
+
+	fsck->chk.sit_valid_blocks = sum_vblocks;
+	fsck->chk.sit_free_segs = free_segs;
+
+	DBG(0, "Blocks [0x%x] Free Segs [0x%x]\n", sum_vblocks, free_segs);
+	return 0;
+}
+
+int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_nat_entry *raw_nat)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
+	struct f2fs_summary_block *sum = curseg->sum_blk;
+	int i = 0;
+
+	for (i = 0; i < nats_in_cursum(sum); i++) {
+		if (le32_to_cpu(nid_in_journal(sum, i)) == nid) {
+			memcpy(raw_nat, &nat_in_journal(sum, i), sizeof(struct f2fs_nat_entry));
+			DBG(3, "==> Found nid [0x%x] in nat cache\n", nid);
+			return i;
+		}
+	}
+	return -1;
+}
+
+void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_super_block *raw_sb = F2FS_RAW_SUPER(sbi);
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct f2fs_nat_block *nat_block;
+	u32 nid, nr_nat_blks;
+
+	pgoff_t block_off;
+	pgoff_t block_addr;
+	int seg_off;
+	int ret, i;
+
+
+	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+
+	/* Alloc & build nat entry bitmap */
+	nr_nat_blks = (le32_to_cpu(raw_sb->segment_count_nat) / 2) << sbi->log_blocks_per_seg;
+
+	fsck->nr_nat_entries = nr_nat_blks * NAT_ENTRY_PER_BLOCK;
+	fsck->nat_area_bitmap_sz = (fsck->nr_nat_entries + 7) / 8;
+	fsck->nat_area_bitmap = calloc(fsck->nat_area_bitmap_sz, 1);
+	ASSERT(fsck->nat_area_bitmap != NULL);
+
+	for (block_off = 0; block_off < nr_nat_blks; block_off++) {
+
+		seg_off = block_off >> sbi->log_blocks_per_seg;
+		block_addr = (pgoff_t)(nm_i->nat_blkaddr +
+				(seg_off << sbi->log_blocks_per_seg << 1) +
+				(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
+
+		if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
+			block_addr += sbi->blocks_per_seg;
+
+		ret = dev_read_block(nat_block, block_addr);
+		ASSERT(ret >= 0);
+
+		nid = block_off * NAT_ENTRY_PER_BLOCK;
+		for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++) {
+			struct f2fs_nat_entry raw_nat;
+			struct node_info ni;
+			ni.nid = nid + i;
+
+			if ((nid + i) == F2FS_NODE_INO(sbi) || (nid + i) == F2FS_META_INO(sbi)) {
+				ASSERT(nat_block->entries[i].block_addr != 0x0);
+				continue;
+			}
+
+			if (lookup_nat_in_journal(sbi, nid + i, &raw_nat) >= 0) {
+				node_info_from_raw_nat(&ni, &raw_nat);
+				if (ni.blk_addr != 0x0) {
+					f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
+					fsck->chk.valid_nat_entry_cnt++;
+					DBG(3, "nid[0x%x] in nat cache\n", nid + i);
+				}
+			} else {
+				node_info_from_raw_nat(&ni, &nat_block->entries[i]);
+				if (ni.blk_addr != 0) {
+					ASSERT(nid + i != 0x0);
+
+					DBG(3, "nid[0x%8x] in nat entry [0x%16x] [0x%8x]\n",
+							nid + i,
+							ni.blk_addr,
+							ni.ino);
+
+					f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
+					fsck->chk.valid_nat_entry_cnt++;
+				}
+			}
+		}
+	}
+	free(nat_block);
+
+	DBG(0, "valid nat entries (block_addr != 0x0) [0x%8x : %u]\n",
+			fsck->chk.valid_nat_entry_cnt, fsck->chk.valid_nat_entry_cnt);
+
+}
+
+int f2fs_do_mount(struct f2fs_sb_info *sbi)
+{
+	int ret;
+	sbi->active_logs = NR_CURSEG_TYPE;
+	ret = validate_super_block(sbi, 0);
+	if (ret) {
+		ret = validate_super_block(sbi, 1);
+		if (ret)
+			return -1;
+	}
+
+	print_raw_sb_info(sbi);
+
+	init_sb_info(sbi);
+
+	ret = get_valid_checkpoint(sbi);
+	if (ret) {
+		ERR_MSG("Can't find valid checkpoint\n");
+		return -1;
+	}
+
+	if (sanity_check_ckpt(sbi)) {
+		ERR_MSG("Checkpoint is polluted\n");
+		return -1;
+	}
+
+	print_ckpt_info(sbi);
+
+	sbi->total_valid_node_count = le32_to_cpu(sbi->ckpt->valid_node_count);
+	sbi->total_valid_inode_count = le32_to_cpu(sbi->ckpt->valid_inode_count);
+	sbi->user_block_count = le64_to_cpu(sbi->ckpt->user_block_count);
+	sbi->total_valid_block_count = le64_to_cpu(sbi->ckpt->valid_block_count);
+	sbi->last_valid_block_count = sbi->total_valid_block_count;
+	sbi->alloc_valid_block_count = 0;
+
+	if (build_segment_manager(sbi)) {
+		ERR_MSG("build_segment_manager failed\n");
+		return -1;
+	}
+
+	if (build_node_manager(sbi)) {
+		ERR_MSG("build_segment_manager failed\n");
+		return -1;
+	}
+
+	return ret;
+}
+
+void f2fs_do_umount(struct f2fs_sb_info *sbi)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	struct f2fs_sm_info *sm_i = SM_I(sbi);
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	int i;
+
+	/* free nm_info */
+	free(nm_i->nat_bitmap);
+	free(sbi->nm_info);
+
+	/* free sit_info */
+	for (i = 0; i < TOTAL_SEGS(sbi); i++) {
+		free(sit_i->sentries[i].cur_valid_map);
+		free(sit_i->sentries[i].ckpt_valid_map);
+	}
+	free(sit_i->sit_bitmap);
+	free(sm_i->sit_info);
+
+	/* free sm_info */
+	for (i = 0; i < NR_CURSEG_TYPE; i++)
+		free(sm_i->curseg_array[i].sum_blk);
+
+	free(sm_i->curseg_array);
+	free(sbi->sm_info);
+
+	free(sbi->ckpt);
+	free(sbi->raw_super);
+}
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index b4ac876..9be43b3 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -21,6 +21,15 @@
 #include <config.h>
 #endif
 
+typedef u_int64_t	u64;
+typedef u_int32_t	u32;
+typedef u_int16_t	u16;
+typedef u_int8_t	u8;
+typedef u64		block_t;
+typedef u32		nid_t;
+typedef u8		bool;
+typedef unsigned long	pgoff_t;
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define le16_to_cpu(x)	((__u16)(x))
 #define le32_to_cpu(x)	((__u32)(x))
@@ -37,6 +46,15 @@
 #define cpu_to_le64(x)	bswap_64(x)
 #endif
 
+#define typecheck(type,x) \
+	({	type __dummy; \
+		typeof(x) __dummy2; \
+		(void)(&__dummy == &__dummy2); \
+		1; \
+	 })
+
+#define NULL_SEGNO	((unsigned int)~0)
+
 /*
  * Debugging interfaces
  */
@@ -59,6 +77,12 @@
 		}							\
 	} while (0);
 
+#define ERR_MSG(fmt, ...)						\
+	do {								\
+		printf("[%s:%d] " fmt, __func__, __LINE__, ##__VA_ARGS__);	\
+	} while (0);
+
+
 #define MSG(n, fmt, ...)						\
 	do {								\
 		if (config.dbg_lv >= n) {				\
@@ -96,7 +120,7 @@
 
 #define DISP_utf(ptr, member)						\
 	do {								\
-		printf(#member "\t\t\t\t[%s]\n", ((ptr)->member) );	\
+		printf("%-30s" "\t\t[%s]\n", #member, ((ptr)->member) );	\
 	} while (0);
 
 /* Display to buffer */
@@ -133,6 +157,11 @@
 #define	DEFAULT_BLOCKS_PER_SEGMENT	512
 #define DEFAULT_SEGMENTS_PER_SECTION	1
 
+enum f2fs_config_func {
+	FSCK,
+	DUMP,
+};
+
 struct f2fs_configuration {
 	u_int32_t sector_size;
 	u_int32_t reserved_segments;
@@ -151,6 +180,8 @@ struct f2fs_configuration {
 	char *extension_list;
 	int dbg_lv;
 	int trim;
+	int func;
+	void *private;
 } __attribute__((packed));
 
 #ifdef CONFIG_64BIT
@@ -449,7 +480,7 @@ struct f2fs_sit_block {
 #define ENTRIES_IN_SUM		512
 #define	SUMMARY_SIZE		(7)	/* sizeof(struct summary) */
 #define	SUM_FOOTER_SIZE		(5)	/* sizeof(struct summary_footer) */
-#define SUM_ENTRY_SIZE		(SUMMARY_SIZE * ENTRIES_IN_SUM)
+#define SUM_ENTRIES_SIZE	(SUMMARY_SIZE * ENTRIES_IN_SUM)
 
 /* a summary entry for a 4KB-sized block in a segment */
 struct f2fs_summary {
@@ -473,7 +504,7 @@ struct summary_footer {
 } __attribute__((packed));
 
 #define SUM_JOURNAL_SIZE	(F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
-				SUM_ENTRY_SIZE)
+				SUM_ENTRIES_SIZE)
 #define NAT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
 				sizeof(struct nat_journal_entry))
 #define NAT_JOURNAL_RESERVED	((SUM_JOURNAL_SIZE - 2) %\
@@ -573,35 +604,52 @@ struct f2fs_dentry_block {
 } __attribute__((packed));
 
 /* file types used in inode_info->flags */
-enum {
+enum FILE_TYPE {
 	F2FS_FT_UNKNOWN,
-	F2FS_FT_REG_FILE,
-	F2FS_FT_DIR,
-	F2FS_FT_CHRDEV,
-	F2FS_FT_BLKDEV,
-	F2FS_FT_FIFO,
-	F2FS_FT_SOCK,
-	F2FS_FT_SYMLINK,
-	F2FS_FT_MAX
+	F2FS_FT_REG_FILE = 0x1,
+	F2FS_FT_DIR = 0x2,
+	F2FS_FT_CHRDEV = 0x4,
+	F2FS_FT_BLKDEV = 0x8,
+	F2FS_FT_FIFO = 0x10,
+	F2FS_FT_SOCK = 0x20,
+	F2FS_FT_SYMLINK = 0x40,
+	F2FS_FT_MAX = 0x80,
+	/* added for fsck */
+	F2FS_FT_ORPHAN = 0x1000,
 };
 
-void ASCIIToUNICODE(u_int16_t *, u_int8_t *);
-int log_base_2(u_int32_t);
+/* from f2fs/segment.h */
+enum {
+	LFS = 0,
+	SSR
+};
+
+extern void ASCIIToUNICODE(u_int16_t *, u_int8_t *);
+extern int log_base_2(u_int32_t);
+
+extern int get_bits_in_byte(unsigned char n);
+extern int set_bit(unsigned int nr,void * addr);
+extern int clear_bit(unsigned int nr, void * addr);
+extern int test_bit(unsigned int nr, const void * addr);
+extern int f2fs_test_bit(unsigned int, const char *);
+extern int f2fs_set_bit(unsigned int, char *);
+extern int f2fs_clear_bit(unsigned int, char *);
+
+extern u_int32_t f2fs_cal_crc32(u_int32_t, void *, int);
+extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
 
-int f2fs_test_bit(unsigned int, const char *);
-int f2fs_set_bit(unsigned int, unsigned char *);
-int f2fs_clear_bit(unsigned int, char *);
+extern void f2fs_init_configuration(struct f2fs_configuration *);
+extern int f2fs_dev_is_mounted(struct f2fs_configuration *);
+extern int f2fs_get_device_info(struct f2fs_configuration *);
 
-u_int32_t f2fs_cal_crc32(u_int32_t, void *, int);
+extern int dev_read(void *, __u64, size_t);
+extern int dev_write(void *, __u64, size_t);
 
-void f2fs_init_configuration(struct f2fs_configuration *);
-int f2fs_dev_is_mounted(struct f2fs_configuration *);
-int f2fs_get_device_info(struct f2fs_configuration *);
+extern int dev_read_block(void *, __u64);
+extern int dev_read_blocks(void *, __u64, __u32 );
 
-int dev_read(void *, __u64, size_t);
-int dev_write(void *, __u64, size_t);
+f2fs_hash_t f2fs_dentry_hash(const char *, int);
 
-int dev_read_block(void *, __u64);
-int dev_read_blocks(void *, __u64, __u32 );
+extern struct f2fs_configuration config;
 
 #endif	/*__F2FS_FS_H */
diff --git a/include/list.h b/include/list.h
new file mode 100644
index 0000000..b1b1ca3
--- /dev/null
+++ b/include/list.h
@@ -0,0 +1,86 @@
+
+#define POISON_POINTER_DELTA 0
+#define LIST_POISON1  ((void *) 0x00100100 + POISON_POINTER_DELTA)
+#define LIST_POISON2  ((void *) 0x00200200 + POISON_POINTER_DELTA)
+
+#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
+#define container_of(ptr, type, member) ({                      \
+		const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
+		(type *)( (char *)__mptr - offsetof(type,member) );})
+
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+#define LIST_HEAD_INIT(name) { &(name), &(name) }
+
+#define LIST_HEAD(name) \
+	struct list_head name = LIST_HEAD_INIT(name)
+
+static inline void INIT_LIST_HEAD(struct list_head *list)
+{
+	list->next = list;
+	list->prev = list;
+}
+
+static inline void __list_add(struct list_head *new,
+		struct list_head *prev,
+		struct list_head *next)
+{
+	next->prev = new;
+	new->next = next;
+	new->prev = prev;
+	prev->next = new;
+}
+
+static inline void list_add(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head, head->next);
+}
+
+static inline void list_add_tail(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head->prev, head);
+}
+
+static inline void __list_del(struct list_head * prev, struct list_head * next)
+{
+	next->prev = prev;
+	prev->next = next;
+}
+
+static inline void __list_del_entry(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+}
+
+static inline void list_del(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	entry->next = LIST_POISON1;
+	entry->prev = LIST_POISON2;
+}
+
+static inline int list_empty(const struct list_head *head)
+{
+	return head->next == head;
+}
+
+#define list_entry(ptr, type, member) \
+	container_of(ptr, type, member)
+
+#define list_for_each(pos, head) \
+	for (pos = (head)->next; pos != (head); pos = pos->next)
+
+#define list_for_each_safe(pos, n, head) \
+	for (pos = (head)->next, n = pos->next; pos != (head); \
+			pos = n, n = pos->next)
+#define list_for_each_entry(pos, head, member)                          \
+	for (pos = list_entry((head)->next, typeof(*pos), member);      \
+			&pos->member != (head);    \
+			pos = list_entry(pos->member.next, typeof(*pos), member))
+#define list_for_each_entry_safe(pos, n, head, member)                  \
+	for (pos = list_entry((head)->next, typeof(*pos), member),      \
+			n = list_entry(pos->member.next, typeof(*pos), member); \
+			&pos->member != (head);                                    \
+			pos = n, n = list_entry(n->member.next, typeof(*n), member))
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index a562c91..898dbf1 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -23,7 +23,7 @@
 #include <linux/hdreg.h>
 #include <linux/fs.h>
 
-#include "f2fs_fs.h"
+#include <f2fs_fs.h>
 
 struct f2fs_configuration config;
 
@@ -55,6 +55,63 @@ int log_base_2(u_int32_t num)
 /*
  * f2fs bit operations
  */
+static const int bits_in_byte[256] = {
+	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,
+	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8,
+};
+
+int get_bits_in_byte(unsigned char n)
+{
+	return bits_in_byte[n];
+}
+
+int set_bit(unsigned int nr,void * addr)
+{
+	int             mask, retval;
+	unsigned char   *ADDR = (unsigned char *) addr;
+
+	ADDR += nr >> 3;
+	mask = 1 << ((nr & 0x07));
+	retval = mask & *ADDR;
+	*ADDR |= mask;
+	return retval;
+}
+
+int clear_bit(unsigned int nr, void * addr)
+{
+	int             mask, retval;
+	unsigned char   *ADDR = (unsigned char *) addr;
+
+	ADDR += nr >> 3;
+	mask = 1 << ((nr & 0x07));
+	retval = mask & *ADDR;
+	*ADDR &= ~mask;
+	return retval;
+}
+
+int test_bit(unsigned int nr, const void * addr)
+{
+	const __u32 *p = (const __u32 *)addr;
+
+	nr = nr ^ 0;
+
+	return ((1 << (nr & 31)) & (p[nr >> 5])) != 0;
+}
+
 int f2fs_test_bit(unsigned int nr, const char *p)
 {
 	int mask;
@@ -65,7 +122,7 @@ int f2fs_test_bit(unsigned int nr, const char *p)
 	return (mask & *addr) != 0;
 }
 
-int f2fs_set_bit(unsigned int nr, unsigned char *addr)
+int f2fs_set_bit(unsigned int nr, char *addr)
 {
 	int mask;
 	int ret;
@@ -90,6 +147,104 @@ int f2fs_clear_bit(unsigned int nr, char *addr)
 }
 
 /*
+ * Hashing code adapted from ext3
+ */
+#define DELTA 0x9E3779B9
+
+static void TEA_transform(unsigned int buf[4], unsigned int const in[])
+{
+	__u32 sum = 0;
+	__u32 b0 = buf[0], b1 = buf[1];
+	__u32 a = in[0], b = in[1], c = in[2], d = in[3];
+	int     n = 16;
+
+	do {
+		sum += DELTA;
+		b0 += ((b1 << 4)+a) ^ (b1+sum) ^ ((b1 >> 5)+b);
+		b1 += ((b0 << 4)+c) ^ (b0+sum) ^ ((b0 >> 5)+d);
+	} while (--n);
+
+	buf[0] += b0;
+	buf[1] += b1;
+
+}
+
+static void str2hashbuf(const char *msg, int len, unsigned int *buf, int num)
+{
+	unsigned pad, val;
+	int i;
+
+	pad = (__u32)len | ((__u32)len << 8);
+	pad |= pad << 16;
+
+	val = pad;
+	if (len > num * 4)
+		len = num * 4;
+	for (i = 0; i < len; i++) {
+		if ((i % 4) == 0)
+			val = pad;
+		val = msg[i] + (val << 8);
+		if ((i % 4) == 3) {
+			*buf++ = val;
+			val = pad;
+			num--;
+		}
+	}
+	if (--num >= 0)
+		*buf++ = val;
+	while (--num >= 0)
+		*buf++ = pad;
+
+}
+
+/**
+ * Return hash value of directory entry
+ * @param name          dentry name
+ * @param len           name lenth
+ * @return              return on success hash value, errno on failure
+ */
+f2fs_hash_t f2fs_dentry_hash(const char *name, int len)
+{
+	__u32 hash;
+	f2fs_hash_t	f2fs_hash;
+	const char	*p;
+	__u32 in[8], buf[4];
+
+	/* special hash codes for special dentries */
+	if (name[0] == '.') {
+		if (name[1] == '\0') {
+			f2fs_hash = F2FS_DOT_HASH;
+			goto exit;
+		}
+		if (name[1] == '.' && name[2] == '\0') {
+			f2fs_hash = F2FS_DDOT_HASH;
+			goto exit;
+		}
+	}
+
+	/* Initialize the default seed for the hash checksum functions */
+	buf[0] = 0x67452301;
+	buf[1] = 0xefcdab89;
+	buf[2] = 0x98badcfe;
+	buf[3] = 0x10325476;
+
+	p = name;
+	while (len > 0) {
+		str2hashbuf(p, len, in, 4);
+		TEA_transform(buf, in);
+		len -= 16;
+		p += 16;
+	}
+	hash = buf[0];
+
+	f2fs_hash = hash;
+exit:
+	f2fs_hash &= ~F2FS_HASH_COL_BIT;
+
+	return f2fs_hash;
+}
+
+/*
  * CRC32
  */
 #define CRCPOLY_LE 0xedb88320
-- 
1.7.10.4

