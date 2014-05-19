From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH 2/2] fsck.f2fs: large volume support
Date: Mon, 19 May 2014 13:11:16 +0900
Message-ID: <1400472676.14654.1.camel@lcm>
References: <1399877875-2561-1-git-send-email-cm224.lee@samsung.com>
	<1399877875-2561-2-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1WmEwc-0003fy-83
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 May 2014 04:12:58 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WmEwZ-0000yv-Rr
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 May 2014 04:12:58 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N5S007LSZPC06C0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 May 2014 13:12:48 +0900 (KST)
Received: from [12.36.79.189] by mmp2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTPA id <0N5S00DODZP6N830@mmp2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 May 2014 13:12:47 +0900 (KST)
In-reply-to: <1399877875-2561-2-git-send-email-cm224.lee@samsung.com>
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

Changes from V1
  o fix orphan_node_blkaddr


>From dcd2512e9563991350fa977beb32613e479bd995 Mon Sep 17 00:00:00 2001
From: root <root@f2fs-00.(none)>
Date: Mon, 12 May 2014 22:03:46 +0900
Subject: [PATCH] fsck.f2fs: large volume support

This patch support large volume over about 3TB.

Signed-off-by: root <root@f2fs-00.(none)>
---
 fsck/f2fs.h   |   14 +++++++++++---
 fsck/fsck.c   |   10 ++++++++--
 fsck/mount.c  |   30 +++++++++++++++++++++++++++++-
 lib/libf2fs.c |    4 ++--
 4 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index e1740fe..439ab8c 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -203,9 +203,17 @@ static inline unsigned long __bitmap_size(struct
f2fs_sb_info *sbi, int flag)
 static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	int offset = (flag == NAT_BITMAP) ?
-		le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
-	return &ckpt->sit_nat_version_bitmap + offset;
+	int offset;
+	if (ckpt->ckpt_flags & CP_LARGE_VOL_FLAG) {
+		if (flag == NAT_BITMAP)
+			return &ckpt->sit_nat_version_bitmap;
+		else
+			return ((char *)ckpt + F2FS_BLKSIZE);
+	} else {
+		offset = (flag == NAT_BITMAP) ?
+			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
+		return &ckpt->sit_nat_version_bitmap + offset;
+	}
 }
 
 static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp,
unsigned int f)
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 20582c9..6e9109e 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -653,11 +653,17 @@ int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 
 	block_t start_blk, orphan_blkaddr, i, j;
 	struct f2fs_orphan_block *orphan_blk;
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 
-	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
+	if (!is_set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG))
 		return 0;
 
-	start_blk = __start_cp_addr(sbi) + 1;
+	if (is_set_ckpt_flags(ckpt, CP_LARGE_VOL_FLAG))
+		start_blk = __start_cp_addr(sbi) +
+			F2FS_BLK_ALIGN(ckpt->sit_ver_bitmap_bytesize);
+	else
+		start_blk = __start_cp_addr(sbi) + 1;
+
 	orphan_blkaddr = __start_sum_addr(sbi) - 1;
 
 	orphan_blk = calloc(BLOCK_SZ, 1);
diff --git a/fsck/mount.c b/fsck/mount.c
index e2f3ace..a12a6cf 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -265,6 +265,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi,
block_t cp_addr, unsigned lo
 	unsigned long long cur_version = 0, pre_version = 0;
 	unsigned int crc = 0;
 	size_t crc_offset;
+	unsigned int sit_bitmap_blks = 0;
 
 	/* Read the 1st cp block in this CP pack */
 	cp_page_1 = malloc(PAGE_SIZE);
@@ -284,7 +285,10 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi,
block_t cp_addr, unsigned lo
 
 	/* Read the 2nd cp block in this CP pack */
 	cp_page_2 = malloc(PAGE_SIZE);
+	if (cp_block->ckpt_flags & CP_LARGE_VOL_FLAG)
+		sit_bitmap_blks = F2FS_BLK_ALIGN(cp_block->sit_ver_bitmap_bytesize);
 	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
+
 	if (dev_read_block(cp_page_2, cp_addr) < 0)
 		goto invalid_cp2;
 
@@ -295,7 +299,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi,
block_t cp_addr, unsigned lo
 
 	crc = *(unsigned int *)((unsigned char *)cp_block + crc_offset);
 	if (f2fs_crc_valid(crc, cp_block, crc_offset))
-		goto invalid_cp1;
+		goto invalid_cp2;
 
 	cur_version = le64_to_cpu(cp_block->checkpoint_ver);
 
@@ -351,6 +355,29 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 
 	memcpy(sbi->ckpt, cur_page, blk_size);
 
+	if (sbi->ckpt->ckpt_flags & CP_LARGE_VOL_FLAG) {
+		int i, cp_blks;
+		unsigned long long cp_blk_no;
+
+		free(sbi->ckpt);
+
+		cp_blk_no = le32_to_cpu(raw_sb->cp_blkaddr);
+		if (cur_page == cp2)
+			cp_blk_no += 1 << le32_to_cpu(raw_sb->log_blocks_per_seg);
+
+		cp_blks = 1 + F2FS_BLK_ALIGN(sbi->ckpt->sit_ver_bitmap_bytesize);
+
+		/* allocate cp size */
+		sbi->ckpt = malloc(cp_blks * blk_size);
+		/* copy first cp data including nat bitmap */
+		memcpy(sbi->ckpt, cur_page, blk_size);
+		/* copy sit bitmap */
+		for (i = 1; i < cp_blks; i++) {
+			unsigned char *ckpt = (unsigned char *)sbi->ckpt;
+			dev_read_block(cur_page, cp_blk_no + i);
+			memcpy(ckpt + i * blk_size, cur_page, blk_size);
+		}
+	}
 	free(cp1);
 	free(cp2);
 	return 0;
@@ -697,6 +724,7 @@ void check_block_count(struct f2fs_sb_info *sbi,
 	int valid_blocks = 0;
 	int i;
 
+
 	/* check segment usage */
 	ASSERT(GET_SIT_VBLOCKS(raw_sit) <= sbi->blocks_per_seg);
 
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index fb3f8c1..1a16dd2 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -342,8 +342,8 @@ int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int
len)
 	cal_crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, buf, len);
 
 	if (cal_crc != blk_crc)	{
-		DBG(0,"CRC validation failed: cal_crc = %u \
-			blk_crc = %u buff_size = 0x%x",
+		DBG(0,"CRC validation failed: cal_crc = %u, "
+			"blk_crc = %u buff_size = 0x%x\n",
 			cal_crc, blk_crc, len);
 		return -1;
 	}
-- 
1.7.10.4




------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
