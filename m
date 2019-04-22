From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: allow unfixed
 f2fs_checkpoint.checksum_offset
Date: Mon, 22 Apr 2019 17:33:52 +0800
Message-ID: <20190422093353.61014-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hIVL2-00084l-U8
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 09:34:12 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hIVL1-005K8B-Ch
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 09:34:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, f2fs_checkpoint.checksum_offset points fixed position of
f2fs_checkpoint structure:

"#define CP_CHKSUM_OFFSET	4092"

It is unnecessary, and it breaks the consecutiveness of nat and sit
bitmap stored across checkpoint park block and payload blocks.

This patch allows f2fs to handle unfixed .checksum_offset.

In addition, for the case checksum value is stored in the middle of
checkpoint park, calculating checksum value with superposition method
like we did for inode_checksum.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c    | 27 +++++++++++++++++++++------
 include/linux/f2fs_fs.h |  4 ++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 441814607b13..a25556aef8cc 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -794,13 +794,27 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	}
 }
 
+static __u32 f2fs_checkpoint_chksum(struct f2fs_sb_info *sbi,
+						struct f2fs_checkpoint *ckpt)
+{
+	unsigned int chksum_ofs = le32_to_cpu(ckpt->checksum_offset);
+	__u32 chksum;
+
+	chksum = f2fs_crc32(sbi, ckpt, chksum_ofs);
+	if (chksum_ofs < CP_CHKSUM_OFFSET) {
+		chksum_ofs += sizeof(chksum);
+		chksum = f2fs_chksum(sbi, chksum, (__u8 *)ckpt + chksum_ofs,
+						F2FS_BLKSIZE - chksum_ofs);
+	}
+	return chksum;
+}
+
 static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 		struct f2fs_checkpoint **cp_block, struct page **cp_page,
 		unsigned long long *version)
 {
-	unsigned long blk_size = sbi->blocksize;
 	size_t crc_offset = 0;
-	__u32 crc = 0;
+	__u32 crc;
 
 	*cp_page = f2fs_get_meta_page(sbi, cp_addr);
 	if (IS_ERR(*cp_page))
@@ -809,15 +823,16 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
 
 	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
-	if (crc_offset > (blk_size - sizeof(__le32))) {
+	if (crc_offset < CP_MIN_CHKSUM_OFFSET ||
+			crc_offset > CP_CHKSUM_OFFSET) {
 		f2fs_put_page(*cp_page, 1);
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"invalid crc_offset: %zu", crc_offset);
 		return -EINVAL;
 	}
 
-	crc = cur_cp_crc(*cp_block);
-	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
+	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
+	if (crc != cur_cp_crc(*cp_block)) {
 		f2fs_put_page(*cp_page, 1);
 		f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");
 		return -EINVAL;
@@ -1425,7 +1440,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
 	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));
 
-	crc32 = f2fs_crc32(sbi, ckpt, le32_to_cpu(ckpt->checksum_offset));
+	crc32 = f2fs_checkpoint_chksum(sbi, ckpt);
 	*((__le32 *)((unsigned char *)ckpt +
 				le32_to_cpu(ckpt->checksum_offset)))
 				= cpu_to_le32(crc32);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 55da9abed023..65559900d4d7 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -164,6 +164,10 @@ struct f2fs_checkpoint {
 	unsigned char sit_nat_version_bitmap[1];
 } __packed;
 
+#define CP_CHKSUM_OFFSET	4092	/* default chksum offset in checkpoint */
+#define CP_MIN_CHKSUM_OFFSET						\
+	(offsetof(struct f2fs_checkpoint, sit_nat_version_bitmap))
+
 /*
  * For orphan inode management
  */
-- 
2.18.0.rc1
