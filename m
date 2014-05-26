From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 2/2 V3] fsck.f2fs: large volume support
Date: Tue, 27 May 2014 08:43:06 +0900
Message-ID: <20140526234306.GB30978@cm224.lee>
References: <1399877875-2561-1-git-send-email-cm224.lee@samsung.com>
	<1399877875-2561-2-git-send-email-cm224.lee@samsung.com>
	<1400472676.14654.1.camel@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1Wp4ZO-0004Zt-NR
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 May 2014 23:44:42 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wp4ZM-0003dM-Mx
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 May 2014 23:44:42 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N6700IQOGM8GC60@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 May 2014 08:44:32 +0900 (KST)
Received: from localhost ([12.36.79.189])
	by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
	(7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTPA id <0N67009XMGM8HOA0@mmp1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 May 2014 08:44:32 +0900 (KST)
Content-disposition: inline
In-reply-to: <1400472676.14654.1.camel@lcm>
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

Changes from V2
 o remove CP_LARGE_VOL_FLAG instead, use cp_payload in superblock
  because disk size is determined at format

Changes from V1
 o fix orphan node blkaddr

-- >8 --

>From 405367374f868a8cf29bef62c06bf53271b58f52 Mon Sep 17 00:00:00 2001
From: Changman Lee <cm224.lee@samsung.com>
Date: Mon, 12 May 2014 22:03:46 +0900
Subject: [PATCH 2/2] fsck.f2fs: large volume support

This patch support large volume over about 3TB.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/f2fs.h   |   14 +++++++++++---
 fsck/fsck.c   |    7 +++++--
 fsck/mount.c  |   22 ++++++++++++++++++++--
 lib/libf2fs.c |    4 ++--
 4 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index e1740fe..427a733 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -203,9 +203,17 @@ static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
 static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	int offset = (flag == NAT_BITMAP) ?
-		le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
-	return &ckpt->sit_nat_version_bitmap + offset;
+	int offset;
+	if (le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload) > 0) {
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
 
 static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 20582c9..a1d5dd0 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -653,11 +653,14 @@ int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 
 	block_t start_blk, orphan_blkaddr, i, j;
 	struct f2fs_orphan_block *orphan_blk;
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 
-	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
+	if (!is_set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG))
 		return 0;
 
-	start_blk = __start_cp_addr(sbi) + 1;
+	start_blk = __start_cp_addr(sbi) + 1 +
+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
+
 	orphan_blkaddr = __start_sum_addr(sbi) - 1;
 
 	orphan_blk = calloc(BLOCK_SZ, 1);
diff --git a/fsck/mount.c b/fsck/mount.c
index e2f3ace..24ef3bf 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -129,6 +129,7 @@ void print_raw_sb_info(struct f2fs_sb_info *sbi)
 	DISP_u32(sb, root_ino);
 	DISP_u32(sb, node_ino);
 	DISP_u32(sb, meta_ino);
+	DISP_u32(sb, cp_payload);
 	printf("\n");
 }
 
@@ -285,6 +286,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr, unsigned lo
 	/* Read the 2nd cp block in this CP pack */
 	cp_page_2 = malloc(PAGE_SIZE);
 	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
+
 	if (dev_read_block(cp_page_2, cp_addr) < 0)
 		goto invalid_cp2;
 
@@ -295,7 +297,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr, unsigned lo
 
 	crc = *(unsigned int *)((unsigned char *)cp_block + crc_offset);
 	if (f2fs_crc_valid(crc, cp_block, crc_offset))
-		goto invalid_cp1;
+		goto invalid_cp2;
 
 	cur_version = le64_to_cpu(cp_block->checkpoint_ver);
 
@@ -319,8 +321,9 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	unsigned long blk_size = sbi->blocksize;
 	unsigned long long cp1_version = 0, cp2_version = 0;
 	unsigned long long cp_start_blk_no;
+	unsigned int cp_blks = 1 + le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
 
-	sbi->ckpt = malloc(blk_size);
+	sbi->ckpt = malloc(cp_blks * blk_size);
 	if (!sbi->ckpt)
 		return -ENOMEM;
 	/*
@@ -351,6 +354,20 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 
 	memcpy(sbi->ckpt, cur_page, blk_size);
 
+	if (cp_blks > 1) {
+		int i;
+		unsigned long long cp_blk_no;
+
+		cp_blk_no = le32_to_cpu(raw_sb->cp_blkaddr);
+		if (cur_page == cp2)
+			cp_blk_no += 1 << le32_to_cpu(raw_sb->log_blocks_per_seg);
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
@@ -697,6 +714,7 @@ void check_block_count(struct f2fs_sb_info *sbi,
 	int valid_blocks = 0;
 	int i;
 
+
 	/* check segment usage */
 	ASSERT(GET_SIT_VBLOCKS(raw_sit) <= sbi->blocks_per_seg);
 
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index fb3f8c1..1a16dd2 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -342,8 +342,8 @@ int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len)
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
The best possible search technologies are now affordable for all companies.
Download your FREE open source Enterprise Search Engine today!
Our experts will assist you in its installation for $59/mo, no commitment.
Test it for FREE on our Cloud platform anytime!
http://pubads.g.doubleclick.net/gampad/clk?id=145328191&iu=/4140/ostg.clktrk
