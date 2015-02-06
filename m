From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] mkfs.f2fs: avoid memory leak in mkfs
Date: Fri, 06 Feb 2015 16:11:41 +0800
Message-ID: <004f01d041e4$abd5d150$038173f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YJe1y-0000Ce-TG
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Feb 2015 08:12:50 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YJe1v-00010n-JC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Feb 2015 08:12:50 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NJC00H7TC536KB0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Feb 2015 17:12:39 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch fixes memory leak in mkfs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 mkfs/f2fs_format.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 2cce7c3..094afa3 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -391,6 +391,7 @@ static int f2fs_init_sit_area(void)
 		if (dev_fill(zero_buf, sit_seg_addr, seg_size)) {
 			MSG(1, "\tError: While zeroing out the sit area \
 					on disk!!!\n");
+			free(zero_buf);
 			return -1;
 		}
 		sit_seg_addr += seg_size;
@@ -424,6 +425,7 @@ static int f2fs_init_nat_area(void)
 		if (dev_fill(nat_buf, nat_seg_addr, seg_size)) {
 			MSG(1, "\tError: While zeroing out the nat area \
 					on disk!!!\n");
+			free(nat_buf);
 			return -1;
 		}
 		nat_seg_addr = nat_seg_addr + (2 * seg_size);
@@ -443,30 +445,31 @@ static int f2fs_write_check_point_pack(void)
 	char *cp_payload = NULL;
 	char *sum_compact, *sum_compact_p;
 	struct f2fs_summary *sum_entry;
+	int ret = -1;
 
 	cp = calloc(F2FS_BLKSIZE, 1);
 	if (cp == NULL) {
 		MSG(1, "\tError: Calloc Failed for f2fs_checkpoint!!!\n");
-		return -1;
+		return ret;
 	}
 
 	sum = calloc(F2FS_BLKSIZE, 1);
 	if (sum == NULL) {
 		MSG(1, "\tError: Calloc Failed for summay_node!!!\n");
-		return -1;
+		goto free_cp;
 	}
 
 	sum_compact = calloc(F2FS_BLKSIZE, 1);
 	if (sum == NULL) {
 		MSG(1, "\tError: Calloc Failed for summay buffer!!!\n");
-		return -1;
+		goto free_sum;
 	}
 	sum_compact_p = sum_compact;
 
 	cp_payload = calloc(F2FS_BLKSIZE, 1);
 	if (cp_payload == NULL) {
 		MSG(1, "\tError: Calloc Failed for cp_payload!!!\n");
-		return -1;
+		goto free_sum_compact;
 	}
 
 	/* 1. cp page 1 of checkpoint pack 1 */
@@ -522,7 +525,7 @@ static int f2fs_write_check_point_pack(void)
 	DBG(1, "\tWriting main segments, cp at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
 	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the cp to disk!!!\n");
-		return -1;
+		goto free_cp_payload;
 	}
 
 	for (i = 0; i < get_sb(cp_payload); i++) {
@@ -530,7 +533,7 @@ static int f2fs_write_check_point_pack(void)
 		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
 			MSG(1, "\tError: While zeroing out the sit bitmap area \
 					on disk!!!\n");
-			return -1;
+			goto free_cp_payload;
 		}
 	}
 
@@ -598,7 +601,7 @@ static int f2fs_write_check_point_pack(void)
 			cp_seg_blk_offset);
 	if (dev_write(sum_compact, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
-		return -1;
+		goto free_cp_payload;
 	}
 
 	/* Prepare and write Segment summary for HOT_NODE */
@@ -613,7 +616,7 @@ static int f2fs_write_check_point_pack(void)
 			cp_seg_blk_offset);
 	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
-		return -1;
+		goto free_cp_payload;
 	}
 
 	/* Fill segment summary for WARM_NODE to zero. */
@@ -625,7 +628,7 @@ static int f2fs_write_check_point_pack(void)
 			cp_seg_blk_offset);
 	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
-		return -1;
+		goto free_cp_payload;
 	}
 
 	/* Fill segment summary for COLD_NODE to zero. */
@@ -636,7 +639,7 @@ static int f2fs_write_check_point_pack(void)
 			cp_seg_blk_offset);
 	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
-		return -1;
+		goto free_cp_payload;
 	}
 
 	/* cp page2 */
@@ -644,7 +647,7 @@ static int f2fs_write_check_point_pack(void)
 	DBG(1, "\tWriting cp page2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
 	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the cp to disk!!!\n");
-		return -1;
+		goto free_cp_payload;
 	}
 
 	/* cp page 1 of check point pack 2
@@ -661,7 +664,7 @@ static int f2fs_write_check_point_pack(void)
 	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
 	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the cp to disk!!!\n");
-		return -1;
+		goto free_cp_payload;
 	}
 
 	for (i = 0; i < get_sb(cp_payload); i++) {
@@ -669,7 +672,7 @@ static int f2fs_write_check_point_pack(void)
 		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
 			MSG(1, "\tError: While zeroing out the sit bitmap area \
 					on disk!!!\n");
-			return -1;
+			goto free_cp_payload;
 		}
 	}
 
@@ -679,14 +682,20 @@ static int f2fs_write_check_point_pack(void)
 	DBG(1, "\tWriting cp page 2 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
 	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the cp to disk!!!\n");
-		return -1;
+		goto free_cp_payload;
 	}
 
+	ret = 0;
+
+free_cp_payload:
+	free(cp_payload);
+free_sum_compact:
 	free(sum_compact);
+free_sum:
 	free(sum);
-	free(cp_payload);
+free_cp:
 	free(cp);
-	return	0;
+	return ret;
 }
 
 static int f2fs_write_super_block(void)
@@ -703,6 +712,7 @@ static int f2fs_write_super_block(void)
 		if (dev_write(zero_buff, index * F2FS_BLKSIZE, F2FS_BLKSIZE)) {
 			MSG(1, "\tError: While while writing supe_blk \
 					on disk!!! index : %d\n", index);
+			free(zero_buff);
 			return -1;
 		}
 	}
@@ -768,6 +778,7 @@ static int f2fs_write_root_inode(void)
 	DBG(1, "\tWriting root inode (hot node), at offset 0x%08"PRIx64"\n", main_area_node_seg_blk_offset);
 	if (dev_write(raw_node, main_area_node_seg_blk_offset, F2FS_BLKSIZE)) {
 		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
+		free(raw_node);
 		return -1;
 	}
 
@@ -782,6 +793,7 @@ static int f2fs_write_root_inode(void)
 	DBG(1, "\tWriting root inode (warm node), at offset 0x%08"PRIx64"\n", main_area_node_seg_blk_offset);
 	if (dev_write(raw_node, main_area_node_seg_blk_offset, F2FS_BLKSIZE)) {
 		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
+		free(raw_node);
 		return -1;
 	}
 	free(raw_node);
@@ -820,6 +832,7 @@ static int f2fs_update_nat_root(void)
 	DBG(1, "\tWriting nat root, at offset 0x%08"PRIx64"\n", nat_seg_blk_offset);
 	if (dev_write(nat_blk, nat_seg_blk_offset, F2FS_BLKSIZE)) {
 		MSG(1, "\tError: While writing the nat_blk set0 to disk!\n");
+		free(nat_blk);
 		return -1;
 	}
 
@@ -861,6 +874,7 @@ static int f2fs_add_default_dentry_root(void)
 	DBG(1, "\tWriting default dentry root, at offset 0x%08"PRIx64"\n", data_blk_offset);
 	if (dev_write(dent_blk, data_blk_offset, F2FS_BLKSIZE)) {
 		MSG(1, "\tError: While writing the dentry_blk to disk!!!\n");
+		free(dent_blk);
 		return -1;
 	}
 
-- 
2.2.1



------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
