From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 1/2] lib,
	mkfs: fix endian conversion for crc calculation
Date: Wed, 19 Jun 2013 21:45:14 +0900
Message-ID: <1371645914.2072.23.camel@kjgkr>
References: <51BDA6BE.1040800@advaoptical.com> <1371471068.10480.8.camel@kjgkr>
	<51BF1B84.8080802@advaoptical.com> <51C02BE6.4070007@advaoptical.com>
	<51C04E24.6090200@advaoptical.com> <1371645828.2072.22.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UpHlD-0001hp-Ik
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Jun 2013 12:45:15 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UpHlB-0004Ln-S6 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Jun 2013 12:45:15 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MON009IA4R32H70@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Jun 2013 21:45:07 +0900 (KST)
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

>From 860da681961e6891d625abffa02d6df7dea4f5b2 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Wed, 19 Jun 2013 20:49:47 +0900
Subject: [PATCH 1/2] lib, mkfs: fix endian conversion for crc calculation
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Let's store the crc value for the checkpoint blocks with __le32.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 include/f2fs_fs.h  |  1 +
 mkfs/f2fs_format.c | 19 ++++++++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index b4ac876..ad10815 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -124,6 +124,7 @@
 #define PAGE_CACHE_SIZE		4096
 #define BITS_PER_BYTE		8
 #define F2FS_SUPER_MAGIC	0xF2F52010	/* F2FS Magic Number */
+#define CHECKSUM_OFFSET		4092
 
 /* for mkfs */
 #define F2FS_MIN_VOLUME_SIZE	104857600
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 8e49ed4..9115520 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -525,7 +525,7 @@ static int f2fs_write_check_point_pack(void)
 	}
 
 	/* 1. cp page 1 of checkpoint pack 1 */
-	ckp->checkpoint_ver = 1;
+	ckp->checkpoint_ver = cpu_to_le64(1);
 	ckp->cur_node_segno[0] =
 		cpu_to_le32(config.cur_seg[CURSEG_HOT_NODE]);
 	ckp->cur_node_segno[1] =
@@ -578,12 +578,11 @@ static int f2fs_write_check_point_pack(void)
 			((le32_to_cpu(super_block.segment_count_nat) / 2) <<
 			 le32_to_cpu(super_block.log_blocks_per_seg)) / 8);
 
-	ckp->checksum_offset = cpu_to_le32(4092);
+	ckp->checksum_offset = cpu_to_le32(CHECKSUM_OFFSET);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, ckp,
-					le32_to_cpu(ckp->checksum_offset));
-	*((u_int32_t *)((unsigned char *)ckp +
-				le32_to_cpu(ckp->checksum_offset))) = crc;
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, ckp, CHECKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)ckp + CHECKSUM_OFFSET)) =
+							cpu_to_le32(crc);
 
 	blk_size_bytes = 1 << le32_to_cpu(super_block.log_blocksize);
 	cp_seg_blk_offset = le32_to_cpu(super_block.segment0_blkaddr);
@@ -690,11 +689,9 @@ static int f2fs_write_check_point_pack(void)
 	 */
 	ckp->checkpoint_ver = 0;
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, ckp,
-					le32_to_cpu(ckp->checksum_offset));
-	*((u_int32_t *)((unsigned char *)ckp +
-				le32_to_cpu(ckp->checksum_offset))) = crc;
-
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, ckp, CHECKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)ckp + CHECKSUM_OFFSET)) =
+							cpu_to_le32(crc);
 	cp_seg_blk_offset = (le32_to_cpu(super_block.segment0_blkaddr) +
 				config.blks_per_seg) *
 				blk_size_bytes;
-- 
1.8.3.1.437.g0dbd812



-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
