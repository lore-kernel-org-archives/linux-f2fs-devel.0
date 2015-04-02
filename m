From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/8] fsck.f2fs: fix summary block
Date: Thu,  2 Apr 2015 10:50:49 -0700
Message-ID: <1427997055-10715-2-git-send-email-jaegeuk@kernel.org>
References: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjGr-00046z-ON
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:13 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjGq-0004gW-JC for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:13 +0000
In-Reply-To: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
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

Previously, if data and node summary was corrupted, the block was deallocated.
But, this patch fixes their summary first, so that we can keep their blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 166 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 118 insertions(+), 48 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index a3029ba..ecb18f2 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -129,66 +129,137 @@ static int find_and_dec_hard_link_list(struct f2fs_sb_info *sbi, u32 nid)
 static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
 							u32 blk_addr)
 {
-	int ret = 0;
-	struct f2fs_summary sum_entry;
-
-	ret = get_sum_entry(sbi, blk_addr, &sum_entry);
+	struct f2fs_summary_block *sum_blk;
+	struct f2fs_summary *sum_entry;
+	u32 segno, offset;
+	int need_fix = 0, ret = 0;
+	int type;
+
+	segno = GET_SEGNO(sbi, blk_addr);
+	offset = OFFSET_IN_SEG(sbi, blk_addr);
+
+	sum_blk = get_sum_block(sbi, segno, &type);
+
+	if (type != SEG_TYPE_NODE && type != SEG_TYPE_CUR_NODE) {
+		/* can't fix current summary, then drop the block */
+		if (!config.fix_on || type < 0) {
+			ASSERT_MSG("Summary footer is not for node segment");
+			ret = -EINVAL;
+			goto out;
+		}
+		FIX_MSG("Summary footer indicates a node segment: 0x%x", segno);
+		sum_blk->footer.entry_type = SUM_TYPE_NODE;
+		need_fix = 1;
+	}
 
-	if (ret != SEG_TYPE_NODE && ret != SEG_TYPE_CUR_NODE) {
-		ASSERT_MSG("Summary footer is not for node segment");
-		return -EINVAL;
+	sum_entry = &(sum_blk->entries[offset]);
+
+	if (le32_to_cpu(sum_entry->nid) != nid) {
+		if (!config.fix_on || type < 0) {
+			DBG(0, "nid                       [0x%x]\n", nid);
+			DBG(0, "target blk_addr           [0x%x]\n", blk_addr);
+			DBG(0, "summary blk_addr          [0x%x]\n",
+						GET_SUM_BLKADDR(sbi,
+						GET_SEGNO(sbi, blk_addr)));
+			DBG(0, "seg no / offset           [0x%x / 0x%x]\n",
+						GET_SEGNO(sbi, blk_addr),
+						OFFSET_IN_SEG(sbi, blk_addr));
+			DBG(0, "summary_entry.nid         [0x%x]\n",
+						le32_to_cpu(sum_entry->nid));
+			DBG(0, "--> node block's nid      [0x%x]\n", nid);
+			ASSERT_MSG("Invalid node seg summary\n");
+			ret = -EINVAL;
+		} else {
+			FIX_MSG("Set node summary 0x%x -> [0x%x] [0x%x]",
+						segno, nid, blk_addr);
+			sum_entry->nid = cpu_to_le32(nid);
+			need_fix = 1;
+		}
 	}
+	if (need_fix) {
+		u64 ssa_blk;
+		int ret2;
 
-	if (le32_to_cpu(sum_entry.nid) != nid) {
-		DBG(0, "nid                       [0x%x]\n", nid);
-		DBG(0, "target blk_addr           [0x%x]\n", blk_addr);
-		DBG(0, "summary blk_addr          [0x%x]\n",
-					GET_SUM_BLKADDR(sbi,
-					GET_SEGNO(sbi, blk_addr)));
-		DBG(0, "seg no / offset           [0x%x / 0x%x]\n",
-					GET_SEGNO(sbi, blk_addr),
-					OFFSET_IN_SEG(sbi, blk_addr));
-		DBG(0, "summary_entry.nid         [0x%x]\n",
-					le32_to_cpu(sum_entry.nid));
-		DBG(0, "--> node block's nid      [0x%x]\n", nid);
-		ASSERT_MSG("Invalid node seg summary\n");
-		return -EINVAL;
+		ssa_blk = GET_SUM_BLKADDR(sbi, segno);
+		ret2 = dev_write_block(sum_blk, ssa_blk);
+		ASSERT(ret2 >= 0);
 	}
-	return 0;
+out:
+	if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
+					type == SEG_TYPE_MAX)
+		free(sum_blk);
+	return ret;
 }
 
 static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 		u32 parent_nid, u16 idx_in_node, u8 version)
 {
-	int ret = 0;
-	struct f2fs_summary sum_entry;
-
-	ret = get_sum_entry(sbi, blk_addr, &sum_entry);
-
-	if (ret != SEG_TYPE_DATA && ret != SEG_TYPE_CUR_DATA) {
-		ASSERT_MSG("Summary footer is not for data segment");
-		return -EINVAL;
+	struct f2fs_summary_block *sum_blk;
+	struct f2fs_summary *sum_entry;
+	u32 segno, offset;
+	int need_fix = 0, ret = 0;
+	int type;
+
+	segno = GET_SEGNO(sbi, blk_addr);
+	offset = OFFSET_IN_SEG(sbi, blk_addr);
+
+	sum_blk = get_sum_block(sbi, segno, &type);
+
+	if (type != SEG_TYPE_DATA && type != SEG_TYPE_CUR_DATA) {
+		/* can't fix current summary, then drop the block */
+		if (!config.fix_on || type < 0) {
+			ASSERT_MSG("Summary footer is not for data segment");
+			ret = -EINVAL;
+			goto out;
+		}
+		FIX_MSG("Summary footer indicates a data segment: 0x%x", segno);
+		sum_blk->footer.entry_type = SUM_TYPE_DATA;
+		need_fix = 1;
 	}
 
-	if (le32_to_cpu(sum_entry.nid) != parent_nid ||
-			sum_entry.version != version ||
-			le16_to_cpu(sum_entry.ofs_in_node) != idx_in_node) {
-
-		DBG(0, "summary_entry.nid         [0x%x]\n",
-					le32_to_cpu(sum_entry.nid));
-		DBG(0, "summary_entry.version     [0x%x]\n",
-					sum_entry.version);
-		DBG(0, "summary_entry.ofs_in_node [0x%x]\n",
-					le16_to_cpu(sum_entry.ofs_in_node));
-		DBG(0, "parent nid                [0x%x]\n", parent_nid);
-		DBG(0, "version from nat          [0x%x]\n", version);
-		DBG(0, "idx in parent node        [0x%x]\n", idx_in_node);
+	sum_entry = &(sum_blk->entries[offset]);
+
+	if (le32_to_cpu(sum_entry->nid) != parent_nid ||
+			sum_entry->version != version ||
+			le16_to_cpu(sum_entry->ofs_in_node) != idx_in_node) {
+		if (!config.fix_on || type < 0) {
+			DBG(0, "summary_entry.nid         [0x%x]\n",
+					le32_to_cpu(sum_entry->nid));
+			DBG(0, "summary_entry.version     [0x%x]\n",
+					sum_entry->version);
+			DBG(0, "summary_entry.ofs_in_node [0x%x]\n",
+					le16_to_cpu(sum_entry->ofs_in_node));
+			DBG(0, "parent nid                [0x%x]\n",
+					parent_nid);
+			DBG(0, "version from nat          [0x%x]\n", version);
+			DBG(0, "idx in parent node        [0x%x]\n",
+					idx_in_node);
+
+			DBG(0, "Target data block addr    [0x%x]\n", blk_addr);
+			ASSERT_MSG("Invalid data seg summary\n");
+			ret = -EINVAL;
+		} else {
+			FIX_MSG("Set data summary 0x%x -> [0x%x] [0x%x] [0x%x]",
+					segno, parent_nid, version, idx_in_node);
+			sum_entry->nid = cpu_to_le32(parent_nid);
+			sum_entry->version = version;
+			sum_entry->ofs_in_node = cpu_to_le16(idx_in_node);
+			need_fix = 1;
+		}
+	}
+	if (need_fix) {
+		u64 ssa_blk;
+		int ret2;
 
-		DBG(0, "Target data block addr    [0x%x]\n", blk_addr);
-		ASSERT_MSG("Invalid data seg summary\n");
-		return -EINVAL;
+		ssa_blk = GET_SUM_BLKADDR(sbi, segno);
+		ret2 = dev_write_block(sum_blk, ssa_blk);
+		ASSERT(ret2 >= 0);
 	}
-	return 0;
+out:
+	if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
+					type == SEG_TYPE_MAX)
+		free(sum_blk);
+	return ret;
 }
 
 static int __check_inode_mode(u32 nid, enum FILE_TYPE ftype, u32 mode)
@@ -929,7 +1000,6 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 		ASSERT_MSG("Duplicated data [0x%x]. pnid[0x%x] idx[0x%x]",
 				blk_addr, parent_nid, idx_in_node);
 
-
 	fsck->chk.valid_blk_cnt++;
 
 	if (ftype == F2FS_FT_DIR) {
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
