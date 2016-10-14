From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs-tools: clean up and avoid build warning
Date: Thu, 13 Oct 2016 17:02:27 -0700
Message-ID: <20161014000230.59232-2-jaegeuk@kernel.org>
References: <20161014000230.59232-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bupxf-00046N-Jd
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:02:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bupxe-0003NC-H9
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:02:55 +0000
In-Reply-To: <20161014000230.59232-1-jaegeuk@kernel.org>
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

This patch is to clean up and avoid warnings when compiling aosp.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dump.c  | 67 ++++++++++++++++++++++++++++++++++++------------------------
 fsck/fsck.c  | 11 ++++++----
 fsck/fsck.h  |  4 ++--
 fsck/main.c  |  2 +-
 fsck/sload.c | 10 ++++-----
 5 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 80b18d2..c048429 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -23,7 +23,7 @@ const char *seg_type_name[SEG_TYPE_MAX + 1] = {
 	"SEG_TYPE_NONE",
 };
 
-void nat_dump(struct f2fs_sb_info *sbi, int start_nat, int end_nat)
+void nat_dump(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
@@ -77,14 +77,16 @@ void nat_dump(struct f2fs_sb_info *sbi, int start_nat, int end_nat)
 				ASSERT(ret >= 0);
 				if (ni.blk_addr != 0x0) {
 					memset(buf, 0, BUF_SZ);
-					snprintf(buf, BUF_SZ, "nid:%5u\tino:%5u\toffset:%5u"
-							"\tblkaddr:%10u\tpack:%d\n",ni.nid, ni.ino,
-							node_block->footer.flag >> OFFSET_BIT_SHIFT,
-									ni.blk_addr, pack);
+					snprintf(buf, BUF_SZ,
+						"nid:%5u\tino:%5u\toffset:%5u"
+						"\tblkaddr:%10u\tpack:%d\n",
+						ni.nid, ni.ino,
+						node_block->footer.flag >>
+							OFFSET_BIT_SHIFT,
+						ni.blk_addr, pack);
 					ret = write(fd, buf, strlen(buf));
 					ASSERT(ret >= 0);
 				}
-
 			} else {
 				node_info_from_raw_nat(&ni,
 						&nat_block->entries[i]);
@@ -94,10 +96,13 @@ void nat_dump(struct f2fs_sb_info *sbi, int start_nat, int end_nat)
 				ret = dev_read_block(node_block, ni.blk_addr);
 				ASSERT(ret >= 0);
 				memset(buf, 0, BUF_SZ);
-				snprintf(buf, BUF_SZ, "nid:%5u\tino:%5u\toffset:%5u"
-						"\tblkaddr:%10u\tpack:%d\n",ni.nid,
-						ni.ino,node_block->footer.flag >>
-						OFFSET_BIT_SHIFT,ni.blk_addr, pack);
+				snprintf(buf, BUF_SZ,
+					"nid:%5u\tino:%5u\toffset:%5u"
+					"\tblkaddr:%10u\tpack:%d\n",
+					ni.nid, ni.ino,
+					node_block->footer.flag >>
+						OFFSET_BIT_SHIFT,
+					ni.blk_addr, pack);
 				ret = write(fd, buf, strlen(buf));
 				ASSERT(ret >= 0);
 			}
@@ -110,7 +115,8 @@ void nat_dump(struct f2fs_sb_info *sbi, int start_nat, int end_nat)
 	close(fd);
 }
 
-void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit)
+void sit_dump(struct f2fs_sb_info *sbi, unsigned int start_sit,
+					unsigned int end_sit)
 {
 	struct seg_entry *se;
 	struct sit_info *sit_i = SIT_I(sbi);
@@ -133,37 +139,44 @@ void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit)
 	for (segno = start_sit; segno < end_sit; segno++) {
 		se = get_seg_entry(sbi, segno);
 		offset = SIT_BLOCK_OFFSET(sit_i, segno);
-		i = f2fs_test_bit(offset, sit_i->sit_bitmap)?2:1;
 		memset(buf, 0, BUF_SZ);
-		snprintf(buf, BUF_SZ, "\nsegno:%8u\tvblocks:%3u\tseg_type:%d\tsit_pack:%d\n\n",
-							segno, se->valid_blocks, se->type, i);
+		snprintf(buf, BUF_SZ,
+		"\nsegno:%8u\tvblocks:%3u\tseg_type:%d\tsit_pack:%d\n\n",
+			segno, se->valid_blocks, se->type,
+			f2fs_test_bit(offset, sit_i->sit_bitmap) ? 2 : 1);
 
 		ret = write(fd, buf, strlen(buf));
 		ASSERT(ret >= 0);
 
 		if (se->valid_blocks == 0x0) {
 			free_segs++;
-		} else {
-			ASSERT(se->valid_blocks <= 512);
-			valid_blocks += se->valid_blocks;
+			continue;
+		}
 
-			for (i = 0; i < 64; i++) {
-				memset(buf, 0, BUF_SZ);
-				snprintf(buf, BUF_SZ, "  %02x", *(se->cur_valid_map + i));
+		ASSERT(se->valid_blocks <= 512);
+		valid_blocks += se->valid_blocks;
+
+		for (i = 0; i < 64; i++) {
+			memset(buf, 0, BUF_SZ);
+			snprintf(buf, BUF_SZ, "  %02x",
+					*(se->cur_valid_map + i));
+			ret = write(fd, buf, strlen(buf));
+			ASSERT(ret >= 0);
+
+			if ((i + 1) % 16 == 0) {
+				snprintf(buf, BUF_SZ, "\n");
 				ret = write(fd, buf, strlen(buf));
 				ASSERT(ret >= 0);
-				if((i+1) % 16 == 0) {
-					snprintf(buf, BUF_SZ, "\n");
-					ret = write(fd, buf, strlen(buf));
-					ASSERT(ret >= 0);
-				}
 			}
 		}
 	}
 
 	memset(buf, 0, BUF_SZ);
-	snprintf(buf, BUF_SZ, "valid_blocks:[0x%" PRIx64 "]\tvalid_segs:%d\t free_segs:%d\n",
-			valid_blocks, SM_I(sbi)->main_segments - free_segs, free_segs);
+	snprintf(buf, BUF_SZ,
+		"valid_blocks:[0x%" PRIx64 "]\tvalid_segs:%d\t free_segs:%d\n",
+			valid_blocks,
+			SM_I(sbi)->main_segments - free_segs,
+			free_segs);
 	ret = write(fd, buf, strlen(buf));
 	ASSERT(ret >= 0);
 
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 9df9118..4b6628e 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -602,18 +602,21 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		u32 *blk_cnt, struct node_info *ni)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	struct child_info child = {0, 2, 0, 0, 0, 0};
+	struct child_info child;
 	enum NODE_TYPE ntype;
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_size = le64_to_cpu(node_blk->i.i_size);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
-	child.p_ino = nid;
-	child.pp_ino = le32_to_cpu(node_blk->i.i_pino);
-	child.dir_level = node_blk->i.i_dir_level;
 	unsigned int idx = 0;
 	int need_fix = 0;
 	int ret;
 
+	memset(&child, 0, sizeof(child));
+	child.links = 2;
+	child.p_ino = nid;
+	child.pp_ino = le32_to_cpu(node_blk->i.i_pino);
+	child.dir_level = node_blk->i.i_dir_level;
+
 	if (f2fs_test_main_bitmap(sbi, ni->blk_addr) == 0)
 		fsck->chk.valid_inode_cnt++;
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 50dc440..a86a30f 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -176,8 +176,8 @@ struct dump_option {
 	int32_t blk_addr;
 };
 
-extern void nat_dump(struct f2fs_sb_info *, int, int);
-extern void sit_dump(struct f2fs_sb_info *, int, int);
+extern void nat_dump(struct f2fs_sb_info *);
+extern void sit_dump(struct f2fs_sb_info *, unsigned int, unsigned int);
 extern void ssa_dump(struct f2fs_sb_info *, int, int);
 extern void dump_node(struct f2fs_sb_info *, nid_t);
 extern int dump_info_from_blkaddr(struct f2fs_sb_info *, u32);
diff --git a/fsck/main.c b/fsck/main.c
index 75f8c1e..8acc970 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -368,7 +368,7 @@ static void do_dump(struct f2fs_sb_info *sbi)
 	if (opt->end_ssa == -1)
 		opt->end_ssa = SM_I(sbi)->main_segments;
 	if (opt->start_nat != -1)
-		nat_dump(sbi, opt->start_nat, opt->end_nat);
+		nat_dump(sbi);
 	if (opt->start_sit != -1)
 		sit_dump(sbi, opt->start_sit, opt->end_sit);
 	if (opt->start_ssa != -1)
diff --git a/fsck/sload.c b/fsck/sload.c
index 424e642..ea072d1 100644
--- a/fsck/sload.c
+++ b/fsck/sload.c
@@ -30,12 +30,12 @@ static void handle_selabel(struct dentry *de, int dir, char *target_out)
 	unsigned int uid = 0;
 	unsigned int gid = 0;
 
-	fs_config(de[i].path, dir, target_out, &uid,
+	fs_config(de->path, dir, target_out, &uid,
 			&gid, &mode, &capabilities);
-	de.mode = mode;
-	de.uid = uid;
-	de.gid = gid;
-	de.capabilities = capabilities;
+	de->mode = mode;
+	de->uid = uid;
+	de->gid = gid;
+	de->capabilities = capabilities;
 }
 #else
 #define handle_selabel(...)
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
