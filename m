From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] dump.f2fs: only dump nat inside the specified
 nid range
Date: Fri, 29 Jun 2018 18:11:11 +0800
Message-ID: <20180629101111.116032-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fYqOm-0006wz-Ob
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Jun 2018 10:13:04 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fYqOi-00COPa-L2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Jun 2018 10:13:02 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Only dump nat info of nids inside the specified range.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/dump.c | 79 ++++++++++++++++++++++++-----------------------------
 fsck/fsck.h |  2 +-
 fsck/main.c |  4 +--
 3 files changed, 38 insertions(+), 47 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 9236a43..89cff83 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -31,32 +31,34 @@ const char *seg_type_name[SEG_TYPE_MAX + 1] = {
 	"SEG_TYPE_NONE",
 };
 
-void nat_dump(struct f2fs_sb_info *sbi)
+void nat_dump(struct f2fs_sb_info *sbi, int start_nat, int end_nat)
 {
-	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
 	struct f2fs_node *node_block;
-	u32 nr_nat_blks, nid;
+	u32 nid;
 	pgoff_t block_off;
 	pgoff_t block_addr;
 	char buf[BUF_SZ];
 	int seg_off;
 	int fd, ret, pack;
-	unsigned int i;
 
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 	node_block = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
 	ASSERT(nat_block);
-
-	nr_nat_blks = get_sb(segment_count_nat) <<
-				(sbi->log_blocks_per_seg - 1);
+	ASSERT(node_block);
 
 	fd = open("dump_nat", O_CREAT|O_WRONLY|O_TRUNC, 0666);
 	ASSERT(fd >= 0);
 
-	for (block_off = 0; block_off < nr_nat_blks; pack = 1, block_off++) {
+	for (nid = start_nat; nid < end_nat; pack = 1, nid++) {
+		struct f2fs_nat_entry raw_nat;
+		struct node_info ni;
+		if(nid == 0 || nid == 1 || nid == 2 )
+			continue;
 
+		ni.nid = nid;
+		block_off = nid / NAT_ENTRY_PER_BLOCK;
 		seg_off = block_off >> sbi->log_blocks_per_seg;
 		block_addr = (pgoff_t)(nm_i->nat_blkaddr +
 			(seg_off << sbi->log_blocks_per_seg << 1) +
@@ -67,42 +69,11 @@ void nat_dump(struct f2fs_sb_info *sbi)
 			pack = 2;
 		}
 
-		ret = dev_read_block(nat_block, block_addr);
-		ASSERT(ret >= 0);
-
-		nid = block_off * NAT_ENTRY_PER_BLOCK;
-		for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++) {
-			struct f2fs_nat_entry raw_nat;
-			struct node_info ni;
-			ni.nid = nid + i;
-
-			if(nid + i  == 0 || nid + i  == 1 || nid + i == 2 )
-				continue;
-			if (lookup_nat_in_journal(sbi, nid + i,
-							&raw_nat) >= 0) {
-				node_info_from_raw_nat(&ni, &raw_nat);
-				ret = dev_read_block(node_block, ni.blk_addr);
-				ASSERT(ret >= 0);
-				if (ni.blk_addr != 0x0) {
-					memset(buf, 0, BUF_SZ);
-					snprintf(buf, BUF_SZ,
-						"nid:%5u\tino:%5u\toffset:%5u"
-						"\tblkaddr:%10u\tpack:%d\n",
-						ni.nid, ni.ino,
-						le32_to_cpu(node_block->footer.flag) >>
-							OFFSET_BIT_SHIFT,
-						ni.blk_addr, pack);
-					ret = write(fd, buf, strlen(buf));
-					ASSERT(ret >= 0);
-				}
-			} else {
-				node_info_from_raw_nat(&ni,
-						&nat_block->entries[i]);
-				if (ni.blk_addr == 0)
-					continue;
-
-				ret = dev_read_block(node_block, ni.blk_addr);
-				ASSERT(ret >= 0);
+		if (lookup_nat_in_journal(sbi, nid, &raw_nat) >= 0) {
+			node_info_from_raw_nat(&ni, &raw_nat);
+			ret = dev_read_block(node_block, ni.blk_addr);
+			ASSERT(ret >= 0);
+			if (ni.blk_addr != 0x0) {
 				memset(buf, 0, BUF_SZ);
 				snprintf(buf, BUF_SZ,
 					"nid:%5u\tino:%5u\toffset:%5u"
@@ -114,6 +85,26 @@ void nat_dump(struct f2fs_sb_info *sbi)
 				ret = write(fd, buf, strlen(buf));
 				ASSERT(ret >= 0);
 			}
+		} else {
+			ret = dev_read_block(nat_block, block_addr);
+			ASSERT(ret >= 0);
+			node_info_from_raw_nat(&ni,
+					&nat_block->entries[nid % NAT_ENTRY_PER_BLOCK]);
+			if (ni.blk_addr == 0)
+				continue;
+
+			ret = dev_read_block(node_block, ni.blk_addr);
+			ASSERT(ret >= 0);
+			memset(buf, 0, BUF_SZ);
+			snprintf(buf, BUF_SZ,
+				"nid:%5u\tino:%5u\toffset:%5u"
+				"\tblkaddr:%10u\tpack:%d\n",
+				ni.nid, ni.ino,
+				le32_to_cpu(node_block->footer.flag) >>
+					OFFSET_BIT_SHIFT,
+				ni.blk_addr, pack);
+			ret = write(fd, buf, strlen(buf));
+			ASSERT(ret >= 0);
 		}
 	}
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 5530aff..0916e30 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -206,7 +206,7 @@ struct dump_option {
 	int32_t blk_addr;
 };
 
-extern void nat_dump(struct f2fs_sb_info *);
+extern void nat_dump(struct f2fs_sb_info *, int, int);
 extern void sit_dump(struct f2fs_sb_info *, unsigned int, unsigned int);
 extern void ssa_dump(struct f2fs_sb_info *, int, int);
 extern void dump_node(struct f2fs_sb_info *, nid_t, int);
diff --git a/fsck/main.c b/fsck/main.c
index f6d12b0..714e28a 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -73,7 +73,7 @@ void dump_usage()
 	MSG(0, "[options]:\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -i inode no (hex)\n");
-	MSG(0, "  -n [NAT dump segno from #1~#2 (decimal), for all 0~-1]\n");
+	MSG(0, "  -n [NAT dump nid from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -S sparse_mode\n");
 	MSG(0, "  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]\n");
@@ -645,7 +645,7 @@ static void do_dump(struct f2fs_sb_info *sbi)
 	if (opt->end_ssa == -1)
 		opt->end_ssa = SM_I(sbi)->main_segments;
 	if (opt->start_nat != -1)
-		nat_dump(sbi);
+		nat_dump(sbi, opt->start_nat, opt->end_nat);
 	if (opt->start_sit != -1)
 		sit_dump(sbi, opt->start_sit, opt->end_sit);
 	if (opt->start_ssa != -1)
-- 
2.18.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
