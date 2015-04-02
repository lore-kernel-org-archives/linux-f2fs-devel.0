From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/8] fsck.f2fs: return summary block pointer and
	types
Date: Thu,  2 Apr 2015 10:50:48 -0700
Message-ID: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjGp-00046c-Hn
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjGo-0004lA-8D for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:11 +0000
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

This patch adds to return summry_block pointer to callers, which will be used
when fixing them.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dump.c  | 16 +++++++++++-----
 fsck/f2fs.h  |  1 +
 fsck/fsck.h  |  4 ++--
 fsck/mount.c | 45 ++++++++++++++++++++++++++-------------------
 4 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 3c4a8d1..8698b28 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -15,11 +15,12 @@
 
 #define BUF_SZ	80
 
-const char *seg_type_name[SEG_TYPE_MAX] = {
+const char *seg_type_name[SEG_TYPE_MAX + 1] = {
 	"SEG_TYPE_DATA",
 	"SEG_TYPE_CUR_DATA",
 	"SEG_TYPE_NODE",
 	"SEG_TYPE_CUR_NODE",
+	"SEG_TYPE_NONE",
 };
 
 void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit)
@@ -65,7 +66,7 @@ void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit)
 
 void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
 {
-	struct f2fs_summary_block sum_blk;
+	struct f2fs_summary_block *sum_blk;
 	char buf[BUF_SZ];
 	int segno, i, ret;
 	int fd;
@@ -80,7 +81,7 @@ void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
 	ASSERT(ret >= 0);
 
 	for (segno = start_ssa; segno < end_ssa; segno++) {
-		ret = get_sum_block(sbi, segno, &sum_blk);
+		sum_blk = get_sum_block(sbi, segno, &ret);
 
 		memset(buf, 0, BUF_SZ);
 		switch (ret) {
@@ -108,10 +109,13 @@ void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
 				ASSERT(ret >= 0);
 			}
 			snprintf(buf, BUF_SZ, "[%3d: %6x]", i,
-					le32_to_cpu(sum_blk.entries[i].nid));
+					le32_to_cpu(sum_blk->entries[i].nid));
 			ret = write(fd, buf, strlen(buf));
 			ASSERT(ret >= 0);
 		}
+		if (ret == SEG_TYPE_NODE || ret == SEG_TYPE_DATA ||
+					ret == SEG_TYPE_MAX)
+			free(sum_blk);
 	}
 	close(fd);
 }
@@ -418,7 +422,9 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 	DBG(1, " - Segno              [0x%x]\n", GET_SEGNO(sbi, blk_addr));
 	DBG(1, " - Offset             [0x%x]\n", OFFSET_IN_SEG(sbi, blk_addr));
 	DBG(1, "SUM.nid               [0x%x]\n", nid);
-	DBG(1, "SUM.type              [%s]\n", seg_type_name[type]);
+	DBG(1, "SUM.type              [%s]\n", type >= 0 ?
+						seg_type_name[type] :
+						"Broken");
 	DBG(1, "SUM.version           [%d]\n", sum_entry.version);
 	DBG(1, "SUM.ofs_in_node       [0x%x]\n", sum_entry.ofs_in_node);
 	DBG(1, "NAT.blkaddr           [0x%x]\n", ni.blk_addr);
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index e59bb0b..100854e 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -382,5 +382,6 @@ static inline void node_info_from_raw_nat(struct node_info *ni,
 
 extern int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_nat_entry *ne);
 #define IS_SUM_NODE_SEG(footer)		(footer.entry_type == SUM_TYPE_NODE)
+#define IS_SUM_DATA_SEG(footer)		(footer.entry_type == SUM_TYPE_DATA)
 
 #endif /* _F2FS_H_ */
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 1c2ef94..ffb3ae2 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -101,8 +101,8 @@ void print_cp_state(u32);
 extern void print_node_info(struct f2fs_node *);
 extern void print_inode_info(struct f2fs_inode *, int);
 extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *, unsigned int);
-extern int get_sum_block(struct f2fs_sb_info *, unsigned int,
-				struct f2fs_summary_block *);
+extern struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *,
+				unsigned int, int *);
 extern int get_sum_entry(struct f2fs_sb_info *, u32, struct f2fs_summary *);
 extern void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
 extern void nullify_nat_entry(struct f2fs_sb_info *, u32);
diff --git a/fsck/mount.c b/fsck/mount.c
index dfaa596..f900dd7 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -845,14 +845,17 @@ struct seg_entry *get_seg_entry(struct f2fs_sb_info *sbi,
 	return &sit_i->sentries[segno];
 }
 
-int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno,
-				struct f2fs_summary_block *sum_blk)
+struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *sbi,
+				unsigned int segno, int *ret_type)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_summary_block *sum_blk;
 	struct curseg_info *curseg;
 	int type, ret;
 	u64 ssa_blk;
 
+	*ret_type= SEG_TYPE_MAX;
+
 	ssa_blk = GET_SUM_BLKADDR(sbi, segno);
 	for (type = 0; type < NR_CURSEG_NODE_TYPE; type++) {
 		if (segno == ckpt->cur_node_segno[type]) {
@@ -861,10 +864,11 @@ int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno,
 				ASSERT_MSG("segno [0x%x] indicates a data "
 						"segment, but should be node",
 						segno);
-				return -EINVAL;
+				*ret_type = -SEG_TYPE_CUR_NODE;
+			} else {
+				*ret_type = SEG_TYPE_CUR_NODE;
 			}
-			memcpy(sum_blk, curseg->sum_blk, BLOCK_SZ);
-			return SEG_TYPE_CUR_NODE;
+			return curseg->sum_blk;
 		}
 	}
 
@@ -875,23 +879,26 @@ int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno,
 				ASSERT_MSG("segno [0x%x] indicates a node "
 						"segment, but should be data",
 						segno);
-				return -EINVAL;
+				*ret_type = -SEG_TYPE_CUR_DATA;
+			} else {
+				*ret_type = SEG_TYPE_CUR_DATA;
 			}
-			DBG(2, "segno [0x%x] is current data seg[0x%x]\n",
-								segno, type);
-			memcpy(sum_blk, curseg->sum_blk, BLOCK_SZ);
-			return SEG_TYPE_CUR_DATA;
+			return curseg->sum_blk;
 		}
 	}
 
+	sum_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(sum_blk);
+
 	ret = dev_read_block(sum_blk, ssa_blk);
 	ASSERT(ret >= 0);
 
 	if (IS_SUM_NODE_SEG(sum_blk->footer))
-		return SEG_TYPE_NODE;
-	else
-		return SEG_TYPE_DATA;
+		*ret_type = SEG_TYPE_NODE;
+	else if (IS_SUM_DATA_SEG(sum_blk->footer))
+		*ret_type = SEG_TYPE_DATA;
 
+	return sum_blk;
 }
 
 int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr,
@@ -899,18 +906,18 @@ int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr,
 {
 	struct f2fs_summary_block *sum_blk;
 	u32 segno, offset;
-	int ret;
+	int type;
 
 	segno = GET_SEGNO(sbi, blk_addr);
 	offset = OFFSET_IN_SEG(sbi, blk_addr);
 
-	sum_blk = calloc(BLOCK_SZ, 1);
-
-	ret = get_sum_block(sbi, segno, sum_blk);
+	sum_blk = get_sum_block(sbi, segno, &type);
 	memcpy(sum_entry, &(sum_blk->entries[offset]),
 				sizeof(struct f2fs_summary));
-	free(sum_blk);
-	return ret;
+	if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
+					type == SEG_TYPE_MAX)
+		free(sum_blk);
+	return type;
 }
 
 static void get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
