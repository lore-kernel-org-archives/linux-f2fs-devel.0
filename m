From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: fix crc endian conversion
Date: Wed, 19 Jun 2013 21:46:21 +0900
Message-ID: <1371645981.2072.25.camel@kjgkr>
References: <51BDA6BE.1040800@advaoptical.com> <1371471068.10480.8.camel@kjgkr>
	<51BF1B84.8080802@advaoptical.com> <51C02BE6.4070007@advaoptical.com>
	<51C04E24.6090200@advaoptical.com> <1371645828.2072.22.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UpHmH-0002UE-Qz
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Jun 2013 12:46:21 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UpHmG-000559-3t for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Jun 2013 12:46:21 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MON0032E4SY1DD0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Jun 2013 21:46:13 +0900 (KST)
In-reply-to: <1371645828.2072.22.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Oded Gabbay <ogabbay@advaoptical.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

>From ed1e92d596f5356ff2f8f8af2818d36ca31f5cf1 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Wed, 19 Jun 2013 20:47:19 +0900
Subject: [PATCH] f2fs: fix crc endian conversion
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

While calculating CRC for the checkpoint block, we use __u32, but when storing
the crc value to the disk, we use __le32.

Let's fix the inconsistency.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 12 ++++++------
 fs/f2fs/f2fs.h       | 19 +++++++++++++++----
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9a77509..66a6b85 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -357,8 +357,8 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	unsigned long blk_size = sbi->blocksize;
 	struct f2fs_checkpoint *cp_block;
 	unsigned long long cur_version = 0, pre_version = 0;
-	unsigned int crc = 0;
 	size_t crc_offset;
+	__u32 crc = 0;
 
 	/* Read the 1st cp block in this CP pack */
 	cp_page_1 = get_meta_page(sbi, cp_addr);
@@ -369,7 +369,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	if (crc_offset >= blk_size)
 		goto invalid_cp1;
 
-	crc = *(unsigned int *)((unsigned char *)cp_block + crc_offset);
+	crc = le32_to_cpu(*((__u32 *)((unsigned char *)cp_block + crc_offset)));
 	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
 		goto invalid_cp1;
 
@@ -384,7 +384,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	if (crc_offset >= blk_size)
 		goto invalid_cp2;
 
-	crc = *(unsigned int *)((unsigned char *)cp_block + crc_offset);
+	crc = le32_to_cpu(*((__u32 *)((unsigned char *)cp_block + crc_offset)));
 	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
 		goto invalid_cp2;
 
@@ -648,7 +648,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	block_t start_blk;
 	struct page *cp_page;
 	unsigned int data_sum_blocks, orphan_blocks;
-	unsigned int crc32 = 0;
+	__u32 crc32 = 0;
 	void *kaddr;
 	int i;
 
@@ -717,8 +717,8 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));
 
 	crc32 = f2fs_crc32(ckpt, le32_to_cpu(ckpt->checksum_offset));
-	*(__le32 *)((unsigned char *)ckpt +
-				le32_to_cpu(ckpt->checksum_offset))
+	*((__le32 *)((unsigned char *)ckpt +
+				le32_to_cpu(ckpt->checksum_offset)))
 				= cpu_to_le32(crc32);
 
 	start_blk = __start_cp_addr(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 863a5e91..467d42d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -47,14 +47,25 @@ struct f2fs_mount_info {
 	unsigned int	opt;
 };
 
-static inline __u32 f2fs_crc32(void *buff, size_t len)
+#define CRCPOLY_LE 0xedb88320
+
+static inline __u32 f2fs_crc32(void *buf, size_t len)
 {
-	return crc32_le(F2FS_SUPER_MAGIC, buff, len);
+	unsigned char *p = (unsigned char *)buf;
+	__u32 crc = F2FS_SUPER_MAGIC;
+	int i;
+
+	while (len--) {
+		crc ^= *p++;
+		for (i = 0; i < 8; i++)
+			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
+	}
+	return crc;
 }
 
-static inline bool f2fs_crc_valid(__u32 blk_crc, void *buff, size_t buff_size)
+static inline bool f2fs_crc_valid(__u32 blk_crc, void *buf, size_t buf_size)
 {
-	return f2fs_crc32(buff, buff_size) == blk_crc;
+	return f2fs_crc32(buf, buf_size) == blk_crc;
 }
 
 /*
-- 
1.8.3.1.437.g0dbd812



-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
