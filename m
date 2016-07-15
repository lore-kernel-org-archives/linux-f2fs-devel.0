From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH trivial 6/7] f2fs-tools: update the format of
	output message
Date: Fri, 15 Jul 2016 20:01:24 +0800
Message-ID: <1468584085-29090-6-git-send-email-shengyong1@huawei.com>
References: <1468584085-29090-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1bO1tM-0006FG-3V
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:52 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bO1tH-0005Gh-Nx
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:52 +0000
In-Reply-To: <1468584085-29090-1-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c            |  4 ++--
 fsck/resize.c           |  4 ++--
 mkfs/f2fs_format.c      | 28 ++++++++++++++--------------
 mkfs/f2fs_format_main.c |  4 ++--
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index f3b47fd..7af684f 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1948,8 +1948,8 @@ static int check_sector_size(struct f2fs_super_block *sb)
 	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
 	for (index = 0; index < 2; index++) {
 		if (dev_write(zero_buff, index * F2FS_BLKSIZE, F2FS_BLKSIZE)) {
-			MSG(1, "\tError: While while writing supe_blk \
-				on disk!!! index : %d\n", index);
+			MSG(1, "\tError: While while writing supe_blk "
+				"on disk!!! index : %d\n", index);
 			free(zero_buff);
 			return -1;
 		}
diff --git a/fsck/resize.c b/fsck/resize.c
index d2fd467..b53a6fa 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -123,8 +123,8 @@ static int get_new_sb(struct f2fs_sb_info *sbi, struct f2fs_super_block *sb)
 	if ((get_sb(segment_count_main) - 2) < config.new_reserved_segments ||
 		get_sb(segment_count_main) * blks_per_seg >
 						get_sb(block_count)) {
-		MSG(0, "\tError: Device size is not sufficient for F2FS volume,\
-			more segment needed =%u",
+		MSG(0, "\tError: Device size is not sufficient for F2FS volume, "
+			"more segment needed =%u",
 			config.new_reserved_segments -
 			(get_sb(segment_count_main) - 2));
 		return -1;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 3173c30..6b1318a 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -284,8 +284,8 @@ static int f2fs_prepare_super_block(void)
 
 	if ((get_sb(segment_count_main) - 2) <
 					config.reserved_segments) {
-		MSG(1, "\tError: Device size is not sufficient for F2FS volume,\
-			more segment needed =%u",
+		MSG(1, "\tError: Device size is not sufficient for F2FS volume, "
+			"more segment needed =%u",
 			config.reserved_segments -
 			(get_sb(segment_count_main) - 2));
 		return -1;
@@ -300,8 +300,8 @@ static int f2fs_prepare_super_block(void)
 	set_sb(root_ino, 3);
 
 	if (total_zones <= 6) {
-		MSG(1, "\tError: %d zones: Need more zones \
-			by shrinking zone size\n", total_zones);
+		MSG(1, "\tError: %d zones: Need more zones "
+			"by shrinking zone size\n", total_zones);
 		return -1;
 	}
 
@@ -362,8 +362,8 @@ static int f2fs_init_sit_area(void)
 	DBG(1, "\tFilling sit area at offset 0x%08"PRIx64"\n", sit_seg_addr);
 	for (index = 0; index < (get_sb(segment_count_sit) / 2); index++) {
 		if (dev_fill(zero_buf, sit_seg_addr, seg_size)) {
-			MSG(1, "\tError: While zeroing out the sit area \
-					on disk!!!\n");
+			MSG(1, "\tError: While zeroing out the sit area "
+					"on disk!!!\n");
 			free(zero_buf);
 			return -1;
 		}
@@ -396,8 +396,8 @@ static int f2fs_init_nat_area(void)
 	DBG(1, "\tFilling nat area at offset 0x%08"PRIx64"\n", nat_seg_addr);
 	for (index = 0; index < get_sb(segment_count_nat) / 2; index++) {
 		if (dev_fill(nat_buf, nat_seg_addr, seg_size)) {
-			MSG(1, "\tError: While zeroing out the nat area \
-					on disk!!!\n");
+			MSG(1, "\tError: While zeroing out the nat area "
+					"on disk!!!\n");
 			free(nat_buf);
 			return -1;
 		}
@@ -510,8 +510,8 @@ static int f2fs_write_check_point_pack(void)
 	for (i = 0; i < get_sb(cp_payload); i++) {
 		cp_seg_blk_offset += blk_size_bytes;
 		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
-			MSG(1, "\tError: While zeroing out the sit bitmap area \
-					on disk!!!\n");
+			MSG(1, "\tError: While zeroing out the sit bitmap area "
+					"on disk!!!\n");
 			goto free_cp_payload;
 		}
 	}
@@ -650,8 +650,8 @@ static int f2fs_write_check_point_pack(void)
 	for (i = 0; i < get_sb(cp_payload); i++) {
 		cp_seg_blk_offset += blk_size_bytes;
 		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
-			MSG(1, "\tError: While zeroing out the sit bitmap area \
-					on disk!!!\n");
+			MSG(1, "\tError: While zeroing out the sit bitmap area "
+					"on disk!!!\n");
 			goto free_cp_payload;
 		}
 	}
@@ -689,8 +689,8 @@ static int f2fs_write_super_block(void)
 	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
 	for (index = 0; index < 2; index++) {
 		if (dev_write(zero_buff, index * F2FS_BLKSIZE, F2FS_BLKSIZE)) {
-			MSG(1, "\tError: While while writing supe_blk \
-					on disk!!! index : %d\n", index);
+			MSG(1, "\tError: While while writing supe_blk "
+					"on disk!!! index : %d\n", index);
 			free(zero_buff);
 			return -1;
 		}
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index f69d03f..94a7286 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -93,8 +93,8 @@ static void f2fs_parse_options(int argc, char *argv[])
 			break;
 		case 'l':		/*v: volume label */
 			if (strlen(optarg) > 512) {
-				MSG(0, "Error: Volume Label should be less than\
-						512 characters\n");
+				MSG(0, "Error: Volume Label should be less than "
+						"512 characters\n");
 				mkfs_usage();
 			}
 			config.vol_label = optarg;
-- 
2.7.1


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
