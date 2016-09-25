From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: introduce get_checkpoint_version for
	cleanup
Date: Sun, 25 Sep 2016 17:50:44 +0800 (CST)
Message-ID: <628ee378.2f42.15760c102b3.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1bo65M-0007uI-E3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 25 Sep 2016 09:51:00 +0000
Received: from m15-15.126.com ([220.181.15.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bo65K-0003Uk-CF for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 25 Sep 2016 09:51:00 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

There exists almost same codes when get the value of pre_version
and cur_version in function validate_checkpoint, this patch adds
get_checkpoint_version to clean up redundant codes.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/checkpoint.c | 52 ++++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a655d75..facede2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -666,45 +666,49 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	}
 }
 
-static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
-				block_t cp_addr, unsigned long long *version)
+static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
+			struct f2fs_checkpoint *cp_block, struct page *cp_page,
+			unsigned long long *version)
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
+	cp_page = get_meta_page(sbi, cp_addr);
+	cp_block = (struct f2fs_checkpoint *)page_address(cp_page);
 
-	/* get the version number */
-	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_1);
 	crc_offset = le32_to_cpu(cp_block->checksum_offset);
 	if (crc_offset >= blk_size)
-		goto invalid_cp1;
+		return -1;
 
 	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
 	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
-		goto invalid_cp1;
+		return -1;
 
-	pre_version = cur_cp_version(cp_block);
+	*version = cur_cp_version(cp_block);
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
+	int ret = 0;
 
-	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_2);
-	crc_offset = le32_to_cpu(cp_block->checksum_offset);
-	if (crc_offset >= blk_size)
-		goto invalid_cp2;
+	ret = get_checkpoint_version(sbi, cp_addr, cp_block,
+					cp_page_1, version);
+	if (ret == -1)
+		goto invalid_cp1;
+	pre_version = *version;
 
-	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
-	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
+	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
+	ret = get_checkpoint_version(sbi, cp_addr, cp_block,
+					cp_page_2, version);
+	if (ret == -1)
 		goto invalid_cp2;
-
-	cur_version = cur_cp_version(cp_block);
+	cur_version = *version;
 
 	if (cur_version == pre_version) {
 		*version = cur_version;
-- 
1.8.3.1
------------------------------------------------------------------------------
