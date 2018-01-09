From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: [PATCH RFC v2 1/2] mkfs.f2fs: max_nat_bitmap_size should
 be aligned up in segment
Date: Tue, 9 Jan 2018 08:55:44 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCC6289@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <gaoxiang25@huawei.com>) id 1eYphP-0007xk-JP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 08:55:59 +0000
Received: from [45.249.212.255] (helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYphN-0000vA-MY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 08:55:59 +0000
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>
Cc: heyunlei <heyunlei@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

max_nat_bitmap_size should be aligned up in segment, rather than
aligned down

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
Change log from v1:
 - fix sit/nat_ver_bitmap_bytesize calculation

 fsck/resize.c      | 16 +++++++++-------
 mkfs/f2fs_format.c | 15 ++++++++++-----
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 143ad5d..6dc4e3f 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -69,8 +69,7 @@ static int get_new_sb(struct f2fs_super_block *sb)
 		set_sb(cp_payload, 0);
 	}
 
-	max_nat_segments = (max_nat_bitmap_size * 8) >>
-					get_sb(log_blocks_per_seg);
+	max_nat_segments = SEG_ALIGN(max_nat_bitmap_size * 8);
 
 	if (get_sb(segment_count_nat) > max_nat_segments)
 		set_sb(segment_count_nat, max_nat_segments);
@@ -422,6 +421,7 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	block_t new_cp_blks = 1 + get_newsb(cp_payload);
 	block_t orphan_blks = 0;
 	block_t new_cp_blk_no, old_cp_blk_no;
+	u_int32_t sit_bitmap_size;
 	u_int32_t crc = 0;
 	u32 flags;
 	void *buf;
@@ -469,13 +469,15 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	}
 
 	/* sit / nat ver bitmap bytesize */
-	set_cp(sit_ver_bitmap_bytesize,
-			((get_newsb(segment_count_sit) / 2) <<
-			get_newsb(log_blocks_per_seg)) / 8);
-	set_cp(nat_ver_bitmap_bytesize,
-			((get_newsb(segment_count_nat) / 2) <<
+	sit_bitmap_size = min((u_int32_t)MAX_SIT_BITMAP_SIZE,
+		((get_newsb(segment_count_sit) / 2) <<
 			get_newsb(log_blocks_per_seg)) / 8);
 
+	set_cp(sit_ver_bitmap_bytesize, sit_bitmap_size);
+	set_cp(nat_ver_bitmap_bytesize, CHECKSUM_OFFSET -
+		sizeof(struct f2fs_checkpoint) + 1 -
+		(get_sb(cp_payload) ? 0 : sit_bitmap_size));
+
 	/* update nat_bits flag */
 	flags = update_nat_bits_flags(new_sb, cp, get_cp(ckpt_flags));
 	set_cp(ckpt_flags, flags);
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a130001..9da7eac 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -302,7 +302,7 @@ static int f2fs_prepare_super_block(void)
 		set_sb(cp_payload, 0);
 	}
 
-	max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
+	max_nat_segments = SEG_ALIGN(max_nat_bitmap_size * 8);
 
 	if (get_sb(segment_count_nat) > max_nat_segments)
 		set_sb(segment_count_nat, max_nat_segments);
@@ -528,6 +528,7 @@ static int f2fs_write_check_point_pack(void)
 	u_int32_t blk_size_bytes;
 	u_int32_t nat_bits_bytes, nat_bits_blocks;
 	unsigned char *nat_bits = NULL, *empty_nat_bits;
+	u_int32_t sit_bitmap_size;
 	u_int64_t cp_seg_blk = 0;
 	u_int32_t crc = 0, flags;
 	unsigned int i;
@@ -627,11 +628,15 @@ static int f2fs_write_check_point_pack(void)
 	set_cp(valid_node_count, 1 + quota_inum);
 	set_cp(valid_inode_count, 1 + quota_inum);
 	set_cp(next_free_nid, get_sb(root_ino) + 1 + quota_inum);
-	set_cp(sit_ver_bitmap_bytesize, ((get_sb(segment_count_sit) / 2) <<
-			get_sb(log_blocks_per_seg)) / 8);
 
-	set_cp(nat_ver_bitmap_bytesize, ((get_sb(segment_count_nat) / 2) <<
-			 get_sb(log_blocks_per_seg)) / 8);
+	sit_bitmap_size = min((u_int32_t)MAX_SIT_BITMAP_SIZE,
+		((get_sb(segment_count_sit) / 2) <<
+		get_sb(log_blocks_per_seg)) / 8);
+
+	set_cp(sit_ver_bitmap_bytesize, sit_bitmap_size);
+	set_cp(nat_ver_bitmap_bytesize, CHECKSUM_OFFSET -
+		sizeof(struct f2fs_checkpoint) + 1 -
+		(get_sb(cp_payload) ? 0 : sit_bitmap_size));
 
 	set_cp(checksum_offset, CHECKSUM_OFFSET);
 
-- 
2.1.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
