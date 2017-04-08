From: kusumi.tomohiro@gmail.com
Subject: [PATCH] f2fs: Guard macro variables with braces
Date: Sun,  9 Apr 2017 02:11:36 +0300
Message-ID: <20170408231136.67650-1-tkusumi@tuxera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kusumi.tomohiro@gmail.com>) id 1cwzWO-0000W3-Cc
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Apr 2017 23:11:56 +0000
Received: from mail-lf0-f66.google.com ([209.85.215.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cwzWM-00038R-92
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Apr 2017 23:11:56 +0000
Received: by mail-lf0-f66.google.com with SMTP id 75so333305lfs.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 08 Apr 2017 16:11:54 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Add braces around variables used within macros for those make sense
to do it. Many of the macros in f2fs already do this. What this commit
doesn't do is anything that changes line# as a result of adding braces,
which usually affects the binary via __LINE__.

Confirmed no diff in fs/f2fs/f2fs.ko before/after this commit on x86_64,
to make sure this has no functional change as well as there's been no
unexpected side effect due to callers' arithmetics within the existing
code.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 fs/f2fs/f2fs.h    | 40 ++++++++++++++---------------
 fs/f2fs/node.c    |  2 +-
 fs/f2fs/node.h    | 22 ++++++++--------
 fs/f2fs/segment.h | 76 +++++++++++++++++++++++++++----------------------------
 fs/f2fs/xattr.h   |  4 +--
 5 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0d57fd3..afe047c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -62,7 +62,7 @@ struct f2fs_fault_info {
 };
 
 extern char *fault_name[FAULT_MAX];
-#define IS_FAULT_SET(fi, type) (fi->inject_type & (1 << (type)))
+#define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
 #endif
 
 /*
@@ -88,9 +88,9 @@ extern char *fault_name[FAULT_MAX];
 #define F2FS_MOUNT_ADAPTIVE		0x00020000
 #define F2FS_MOUNT_LFS			0x00040000
 
-#define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
-#define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
-#define test_opt(sbi, option)	(sbi->mount_opt.opt & F2FS_MOUNT_##option)
+#define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
+#define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
+#define test_opt(sbi, option)	((sbi)->mount_opt.opt & F2FS_MOUNT_##option)
 
 #define ver_after(a, b)	(typecheck(unsigned long long, a) &&		\
 		typecheck(unsigned long long, b) &&			\
@@ -222,13 +222,13 @@ struct fsync_inode_entry {
 	block_t last_dentry;	/* block address locating the last dentry */
 };
 
-#define nats_in_cursum(jnl)		(le16_to_cpu(jnl->n_nats))
-#define sits_in_cursum(jnl)		(le16_to_cpu(jnl->n_sits))
+#define nats_in_cursum(jnl)		(le16_to_cpu((jnl)->n_nats))
+#define sits_in_cursum(jnl)		(le16_to_cpu((jnl)->n_sits))
 
-#define nat_in_journal(jnl, i)		(jnl->nat_j.entries[i].ne)
-#define nid_in_journal(jnl, i)		(jnl->nat_j.entries[i].nid)
-#define sit_in_journal(jnl, i)		(jnl->sit_j.entries[i].se)
-#define segno_in_journal(jnl, i)	(jnl->sit_j.entries[i].segno)
+#define nat_in_journal(jnl, i)		((jnl)->nat_j.entries[i].ne)
+#define nid_in_journal(jnl, i)		((jnl)->nat_j.entries[i].nid)
+#define sit_in_journal(jnl, i)		((jnl)->sit_j.entries[i].se)
+#define segno_in_journal(jnl, i)	((jnl)->sit_j.entries[i].segno)
 
 #define MAX_NAT_JENTRIES(jnl)	(NAT_JOURNAL_ENTRIES - nats_in_cursum(jnl))
 #define MAX_SIT_JENTRIES(jnl)	(SIT_JOURNAL_ENTRIES - sits_in_cursum(jnl))
@@ -737,7 +737,7 @@ struct f2fs_io_info {
 	bool submitted;		/* indicate IO submission */
 };
 
-#define is_read_io(rw) (rw == READ)
+#define is_read_io(rw) ((rw) == READ)
 struct f2fs_bio_info {
 	struct f2fs_sb_info *sbi;	/* f2fs superblock */
 	struct bio *bio;		/* bios to merge */
@@ -969,8 +969,8 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
  * and the return value is in kbytes. s is of struct f2fs_sb_info.
  */
 #define BD_PART_WRITTEN(s)						 \
-(((u64)part_stat_read(s->sb->s_bdev->bd_part, sectors[1]) -		 \
-		s->sectors_written_start) >> 1)
+(((u64)part_stat_read((s)->sb->s_bdev->bd_part, sectors[1]) -		 \
+		(s)->sectors_written_start) >> 1)
 
 static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
 {
@@ -2029,8 +2029,8 @@ static inline void *f2fs_kvzalloc(size_t size, gfp_t flags)
 
 /* get offset of first page in next direct node */
 #define PGOFS_OF_NEXT_DNODE(pgofs, inode)				\
-	((pgofs < ADDRS_PER_INODE(inode)) ? ADDRS_PER_INODE(inode) :	\
-	(pgofs - ADDRS_PER_INODE(inode) + ADDRS_PER_BLOCK) /	\
+	(((pgofs) < ADDRS_PER_INODE(inode)) ? ADDRS_PER_INODE(inode) :	\
+	((pgofs) - ADDRS_PER_INODE(inode) + ADDRS_PER_BLOCK) /	\
 	ADDRS_PER_BLOCK * ADDRS_PER_BLOCK + ADDRS_PER_INODE(inode))
 
 /*
@@ -2422,8 +2422,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_seg_count(sbi, type, gc_type)				\
 	do {								\
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
-		(si)->tot_segs++;					\
-		if (type == SUM_TYPE_DATA) {				\
+		si->tot_segs++;						\
+		if ((type) == SUM_TYPE_DATA) {				\
 			si->data_segs++;				\
 			si->bg_data_segs += (gc_type == BG_GC) ? 1 : 0;	\
 		} else {						\
@@ -2433,14 +2433,14 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 	} while (0)
 
 #define stat_inc_tot_blk_count(si, blks)				\
-	(si->tot_blks += (blks))
+	((si)->tot_blks += (blks))
 
 #define stat_inc_data_blk_count(sbi, blks, gc_type)			\
 	do {								\
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
 		stat_inc_tot_blk_count(si, blks);			\
 		si->data_blks += (blks);				\
-		si->bg_data_blks += (gc_type == BG_GC) ? (blks) : 0;	\
+		si->bg_data_blks += ((gc_type) == BG_GC) ? (blks) : 0;	\
 	} while (0)
 
 #define stat_inc_node_blk_count(sbi, blks, gc_type)			\
@@ -2448,7 +2448,7 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
 		stat_inc_tot_blk_count(si, blks);			\
 		si->node_blks += (blks);				\
-		si->bg_node_blks += (gc_type == BG_GC) ? (blks) : 0;	\
+		si->bg_node_blks += ((gc_type) == BG_GC) ? (blks) : 0;	\
 	} while (0)
 
 int f2fs_build_stats(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 481aa8d..20bd624 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -22,7 +22,7 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
-#define on_build_free_nids(nmi) mutex_is_locked(&nm_i->build_lock)
+#define on_build_free_nids(nmi) mutex_is_locked(&(nm_i)->build_lock)
 
 static struct kmem_cache *nat_entry_slab;
 static struct kmem_cache *free_nid_slab;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 2f9603f..1e33cbb 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -9,10 +9,10 @@
  * published by the Free Software Foundation.
  */
 /* start node id of a node block dedicated to the given node id */
-#define	START_NID(nid) ((nid / NAT_ENTRY_PER_BLOCK) * NAT_ENTRY_PER_BLOCK)
+#define	START_NID(nid) (((nid) / NAT_ENTRY_PER_BLOCK) * NAT_ENTRY_PER_BLOCK)
 
 /* node block offset on the NAT area dedicated to the given start node id */
-#define	NAT_BLOCK_OFFSET(start_nid) (start_nid / NAT_ENTRY_PER_BLOCK)
+#define	NAT_BLOCK_OFFSET(start_nid) ((start_nid) / NAT_ENTRY_PER_BLOCK)
 
 /* # of pages to perform synchronous readahead before building free nids */
 #define FREE_NID_PAGES	8
@@ -62,16 +62,16 @@ struct nat_entry {
 	struct node_info ni;	/* in-memory node information */
 };
 
-#define nat_get_nid(nat)		(nat->ni.nid)
-#define nat_set_nid(nat, n)		(nat->ni.nid = n)
-#define nat_get_blkaddr(nat)		(nat->ni.blk_addr)
-#define nat_set_blkaddr(nat, b)		(nat->ni.blk_addr = b)
-#define nat_get_ino(nat)		(nat->ni.ino)
-#define nat_set_ino(nat, i)		(nat->ni.ino = i)
-#define nat_get_version(nat)		(nat->ni.version)
-#define nat_set_version(nat, v)		(nat->ni.version = v)
+#define nat_get_nid(nat)		((nat)->ni.nid)
+#define nat_set_nid(nat, n)		((nat)->ni.nid = (n))
+#define nat_get_blkaddr(nat)		((nat)->ni.blk_addr)
+#define nat_set_blkaddr(nat, b)		((nat)->ni.blk_addr = (b))
+#define nat_get_ino(nat)		((nat)->ni.ino)
+#define nat_set_ino(nat, i)		((nat)->ni.ino = (i))
+#define nat_get_version(nat)		((nat)->ni.version)
+#define nat_set_version(nat, v)		((nat)->ni.version = (v))
 
-#define inc_node_version(version)	(++version)
+#define inc_node_version(version)	(++(version))
 
 static inline void copy_node_info(struct node_info *dst,
 						struct node_info *src)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5e8ad42..1f77e46 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -21,78 +21,78 @@
 #define F2FS_MIN_SEGMENTS	9 /* SB + 2 (CP + SIT + NAT) + SSA + MAIN */
 
 /* L: Logical segment # in volume, R: Relative segment # in main area */
-#define GET_L2R_SEGNO(free_i, segno)	(segno - free_i->start_segno)
-#define GET_R2L_SEGNO(free_i, segno)	(segno + free_i->start_segno)
+#define GET_L2R_SEGNO(free_i, segno)	((segno) - (free_i)->start_segno)
+#define GET_R2L_SEGNO(free_i, segno)	((segno) + (free_i)->start_segno)
 
-#define IS_DATASEG(t)	(t <= CURSEG_COLD_DATA)
-#define IS_NODESEG(t)	(t >= CURSEG_HOT_NODE)
+#define IS_DATASEG(t)	((t) <= CURSEG_COLD_DATA)
+#define IS_NODESEG(t)	((t) >= CURSEG_HOT_NODE)
 
 #define IS_CURSEG(sbi, seg)						\
-	((seg == CURSEG_I(sbi, CURSEG_HOT_DATA)->segno) ||	\
-	 (seg == CURSEG_I(sbi, CURSEG_WARM_DATA)->segno) ||	\
-	 (seg == CURSEG_I(sbi, CURSEG_COLD_DATA)->segno) ||	\
-	 (seg == CURSEG_I(sbi, CURSEG_HOT_NODE)->segno) ||	\
-	 (seg == CURSEG_I(sbi, CURSEG_WARM_NODE)->segno) ||	\
-	 (seg == CURSEG_I(sbi, CURSEG_COLD_NODE)->segno))
+	(((seg) == CURSEG_I(sbi, CURSEG_HOT_DATA)->segno) ||	\
+	 ((seg) == CURSEG_I(sbi, CURSEG_WARM_DATA)->segno) ||	\
+	 ((seg) == CURSEG_I(sbi, CURSEG_COLD_DATA)->segno) ||	\
+	 ((seg) == CURSEG_I(sbi, CURSEG_HOT_NODE)->segno) ||	\
+	 ((seg) == CURSEG_I(sbi, CURSEG_WARM_NODE)->segno) ||	\
+	 ((seg) == CURSEG_I(sbi, CURSEG_COLD_NODE)->segno))
 
 #define IS_CURSEC(sbi, secno)						\
-	((secno == CURSEG_I(sbi, CURSEG_HOT_DATA)->segno /		\
-	  sbi->segs_per_sec) ||	\
-	 (secno == CURSEG_I(sbi, CURSEG_WARM_DATA)->segno /		\
-	  sbi->segs_per_sec) ||	\
-	 (secno == CURSEG_I(sbi, CURSEG_COLD_DATA)->segno /		\
-	  sbi->segs_per_sec) ||	\
-	 (secno == CURSEG_I(sbi, CURSEG_HOT_NODE)->segno /		\
-	  sbi->segs_per_sec) ||	\
-	 (secno == CURSEG_I(sbi, CURSEG_WARM_NODE)->segno /		\
-	  sbi->segs_per_sec) ||	\
-	 (secno == CURSEG_I(sbi, CURSEG_COLD_NODE)->segno /		\
-	  sbi->segs_per_sec))	\
+	(((secno) == CURSEG_I(sbi, CURSEG_HOT_DATA)->segno /		\
+	  (sbi)->segs_per_sec) ||	\
+	 ((secno) == CURSEG_I(sbi, CURSEG_WARM_DATA)->segno /		\
+	  (sbi)->segs_per_sec) ||	\
+	 ((secno) == CURSEG_I(sbi, CURSEG_COLD_DATA)->segno /		\
+	  (sbi)->segs_per_sec) ||	\
+	 ((secno) == CURSEG_I(sbi, CURSEG_HOT_NODE)->segno /		\
+	  (sbi)->segs_per_sec) ||	\
+	 ((secno) == CURSEG_I(sbi, CURSEG_WARM_NODE)->segno /		\
+	  (sbi)->segs_per_sec) ||	\
+	 ((secno) == CURSEG_I(sbi, CURSEG_COLD_NODE)->segno /		\
+	  (sbi)->segs_per_sec))	\
 
 #define MAIN_BLKADDR(sbi)	(SM_I(sbi)->main_blkaddr)
 #define SEG0_BLKADDR(sbi)	(SM_I(sbi)->seg0_blkaddr)
 
 #define MAIN_SEGS(sbi)	(SM_I(sbi)->main_segments)
-#define MAIN_SECS(sbi)	(sbi->total_sections)
+#define MAIN_SECS(sbi)	((sbi)->total_sections)
 
 #define TOTAL_SEGS(sbi)	(SM_I(sbi)->segment_count)
-#define TOTAL_BLKS(sbi)	(TOTAL_SEGS(sbi) << sbi->log_blocks_per_seg)
+#define TOTAL_BLKS(sbi)	(TOTAL_SEGS(sbi) << (sbi)->log_blocks_per_seg)
 
 #define MAX_BLKADDR(sbi)	(SEG0_BLKADDR(sbi) + TOTAL_BLKS(sbi))
-#define SEGMENT_SIZE(sbi)	(1ULL << (sbi->log_blocksize +		\
-					sbi->log_blocks_per_seg))
+#define SEGMENT_SIZE(sbi)	(1ULL << ((sbi)->log_blocksize +	\
+					(sbi)->log_blocks_per_seg))
 
 #define START_BLOCK(sbi, segno)	(SEG0_BLKADDR(sbi) +			\
-	 (GET_R2L_SEGNO(FREE_I(sbi), segno) << sbi->log_blocks_per_seg))
+	 (GET_R2L_SEGNO(FREE_I(sbi), segno) << (sbi)->log_blocks_per_seg))
 
 #define NEXT_FREE_BLKADDR(sbi, curseg)					\
-	(START_BLOCK(sbi, curseg->segno) + curseg->next_blkoff)
+	(START_BLOCK(sbi, (curseg)->segno) + (curseg)->next_blkoff)
 
 #define GET_SEGOFF_FROM_SEG0(sbi, blk_addr)	((blk_addr) - SEG0_BLKADDR(sbi))
 #define GET_SEGNO_FROM_SEG0(sbi, blk_addr)				\
-	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) >> sbi->log_blocks_per_seg)
+	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) >> (sbi)->log_blocks_per_seg)
 #define GET_BLKOFF_FROM_SEG0(sbi, blk_addr)				\
-	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (sbi->blocks_per_seg - 1))
+	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & ((sbi)->blocks_per_seg - 1))
 
 #define GET_SEGNO(sbi, blk_addr)					\
-	(((blk_addr == NULL_ADDR) || (blk_addr == NEW_ADDR)) ?		\
+	((((blk_addr) == NULL_ADDR) || ((blk_addr) == NEW_ADDR)) ?	\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define GET_SECNO(sbi, segno)					\
-	((segno) / sbi->segs_per_sec)
+	((segno) / (sbi)->segs_per_sec)
 #define GET_ZONENO_FROM_SEGNO(sbi, segno)				\
-	((segno / sbi->segs_per_sec) / sbi->secs_per_zone)
+	(((segno) / (sbi)->segs_per_sec) / (sbi)->secs_per_zone)
 
 #define GET_SUM_BLOCK(sbi, segno)				\
-	((sbi->sm_info->ssa_blkaddr) + segno)
+	((sbi)->sm_info->ssa_blkaddr + (segno))
 
 #define GET_SUM_TYPE(footer) ((footer)->entry_type)
-#define SET_SUM_TYPE(footer, type) ((footer)->entry_type = type)
+#define SET_SUM_TYPE(footer, type) ((footer)->entry_type = (type))
 
 #define SIT_ENTRY_OFFSET(sit_i, segno)					\
-	(segno % sit_i->sents_per_block)
+	((segno) % (sit_i)->sents_per_block)
 #define SIT_BLOCK_OFFSET(segno)					\
-	(segno / SIT_ENTRY_PER_BLOCK)
+	((segno) / SIT_ENTRY_PER_BLOCK)
 #define	START_SEGNO(segno)		\
 	(SIT_BLOCK_OFFSET(segno) * SIT_ENTRY_PER_BLOCK)
 #define SIT_BLK_CNT(sbi)			\
@@ -103,7 +103,7 @@
 #define SECTOR_FROM_BLOCK(blk_addr)					\
 	(((sector_t)blk_addr) << F2FS_LOG_SECTORS_PER_BLOCK)
 #define SECTOR_TO_BLOCK(sectors)					\
-	(sectors >> F2FS_LOG_SECTORS_PER_BLOCK)
+	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
 
 /*
  * indicate a block allocation direction: RIGHT and LEFT.
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index d5a9492..d4038d6 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -58,10 +58,10 @@ struct f2fs_xattr_entry {
 #define XATTR_FIRST_ENTRY(ptr)	(XATTR_ENTRY(XATTR_HDR(ptr) + 1))
 #define XATTR_ROUND		(3)
 
-#define XATTR_ALIGN(size)	((size + XATTR_ROUND) & ~XATTR_ROUND)
+#define XATTR_ALIGN(size)	(((size) + XATTR_ROUND) & ~XATTR_ROUND)
 
 #define ENTRY_SIZE(entry) (XATTR_ALIGN(sizeof(struct f2fs_xattr_entry) + \
-			entry->e_name_len + le16_to_cpu(entry->e_value_size)))
+			(entry)->e_name_len + le16_to_cpu((entry)->e_value_size)))
 
 #define XATTR_NEXT_ENTRY(entry)	((struct f2fs_xattr_entry *)((char *)(entry) +\
 			ENTRY_SIZE(entry)))
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
