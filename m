From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH v4 RESEND] f2fs: introduce get_checkpoint_version
 for cleanup
Date: Fri, 30 Sep 2016 08:24:53 +0800 (CST)
Message-ID: <d27497e.b0c.157787ac150.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1bpldQ-0000ls-MO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Sep 2016 00:25:04 +0000
Received: from m15-15.126.com ([220.181.15.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bpldP-0001ov-2S for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Sep 2016 00:25:04 +0000
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
 fs/f2fs/checkpoint.c | 66 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index de8693c..764ed0b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -663,45 +663,55 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
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
+			"invalid crc_offset: %zu", crc_offset);
+		return -EINVAL;
+	}
 
-	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
-	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
-		goto invalid_cp1;
+	crc = le32_to_cpu(*((__le32 *)((unsigned char *)*cp_block
+							+ crc_offset)));
+	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
+		f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");
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
