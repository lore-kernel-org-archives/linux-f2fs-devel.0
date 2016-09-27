From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH v3] f2fs: introduce get_checkpoint_version for
	cleanup
Date: Wed, 28 Sep 2016 02:32:57 +0800 (CST)
Message-ID: <4d39a005.249.1576cebd52c.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1boxBn-0001Nv-3O
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Sep 2016 18:33:11 +0000
Received: from m15-14.126.com ([220.181.15.14])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1boxBl-0003VF-77 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Sep 2016 18:33:11 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

There exists almost same codes when get the value of pre_version
and cur_version in function validate_checkpoint, this patch adds
get_checkpoint_version to clean up redundant codes.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/checkpoint.c | 68 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index de8693c..06992a7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -663,45 +663,57 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	}
 }
 
-static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
-				block_t cp_addr, unsigned long long *version)
+static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
+		struct f2fs_checkpoint **cp_block, struct page **cp_page,
+		unsigned long long *version)
 {
-	struct page *cp_page_1, *cp_page_2 = NULL;
 	unsigned long blk_size = sbi->blocksize;
-	struct f2fs_checkpoint *cp_block;
-	unsigned long long cur_version = 0, pre_version = 0;
-	size_t crc_offset;
+	size_t crc_offset = 0;
 	__u32 crc = 0;
 
-	/* Read the 1st cp block in this CP pack */
-	cp_page_1 = get_meta_page(sbi, cp_addr);
+	*cp_page = get_meta_page(sbi, cp_addr);
+	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
 
-	/* get the version number */
-	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_1);
-	crc_offset = le32_to_cpu(cp_block->checksum_offset);
-	if (crc_offset >= blk_size)
-		goto invalid_cp1;
+	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
+	if (crc_offset >= blk_size) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"%s: crc_offset is greater than or equal to blk_size.",
+			__func__);
+		return -EINVAL;
+	}
 
-	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
-	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
-		goto invalid_cp1;
+	crc = le32_to_cpu(*((__le32 *)((unsigned char *)*cp_block
+							+ crc_offset)));
+	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"%s: f2fs_crc_valid returns false.", __func__);
+		return -EINVAL;
+	}
 
-	pre_version = cur_cp_version(cp_block);
+	*version = cur_cp_version(*cp_block);
+	return 0;
+}
 
-	/* Read the 2nd cp block in this CP pack */
-	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
-	cp_page_2 = get_meta_page(sbi, cp_addr);
+static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
+				block_t cp_addr, unsigned long long *version)
+{
+	struct page *cp_page_1 = NULL, *cp_page_2 = NULL;
+	struct f2fs_checkpoint *cp_block = NULL;
+	unsigned long long cur_version = 0, pre_version = 0;
+	int err;
 
-	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_2);
-	crc_offset = le32_to_cpu(cp_block->checksum_offset);
-	if (crc_offset >= blk_size)
-		goto invalid_cp2;
+	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
+					&cp_page_1, version);
+	if (err)
+		goto invalid_cp1;
+	pre_version = *version;
 
-	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
-	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
+	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
+	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
+					&cp_page_2, version);
+	if (err)
 		goto invalid_cp2;
-
-	cur_version = cur_cp_version(cp_block);
+	cur_version = *version;
 
 	if (cur_version == pre_version) {
 		*version = cur_version;
-- 
1.8.3.1
------------------------------------------------------------------------------
