From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: avoid false alarm on SIT type fix
Date: Thu, 13 Nov 2014 16:56:35 -0800
Message-ID: <1415926595-49047-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xp5Bz-0003Y9-TD
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 00:56:52 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xp5Bx-0000Xn-KY for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 00:56:50 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch removed a false alarm when detecting any inconsistency in SIT types.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h  |  1 +
 fsck/fsck.c  | 35 ++++++++++++++++++++++++++++++-----
 fsck/mount.c |  1 +
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 47f785d..57bad9b 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -72,6 +72,7 @@ struct seg_entry {
 	unsigned short ckpt_valid_blocks;
 	unsigned char *ckpt_valid_map;
 	unsigned char type;             /* segment type like CURSEG_XXX_TYPE */
+	unsigned char orig_type;        /* segment type like CURSEG_XXX_TYPE */
 	unsigned long long mtime;       /* modification time of the segment */
 };
 
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 78737d5..994145e 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -23,17 +23,15 @@ static inline int f2fs_set_main_bitmap(struct f2fs_sb_info *sbi, u32 blk,
 	if (se->type != type) {
 		if (type == CURSEG_WARM_DATA) {
 			if (se->type != CURSEG_COLD_DATA) {
-				FIX_MSG("Wrong segment type [0x%x] %x -> %x",
+				DBG(1, "Wrong segment type [0x%x] %x -> %x",
 						GET_SEGNO(sbi, blk), se->type,
 						CURSEG_WARM_DATA);
 				se->type = CURSEG_WARM_DATA;
-				config.bug_on = 1;
 			}
 		} else {
-			FIX_MSG("Wrong segment type [0x%x] %x -> %x",
+			DBG(1, "Wrong segment type [0x%x] %x -> %x",
 				GET_SEGNO(sbi, blk), se->type, type);
 			se->type = type;
-			config.bug_on = 1;
 		}
 	}
 	return f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, blk), fsck->main_area_bitmap);
@@ -998,6 +996,25 @@ int check_curseg_offset(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+int check_sit_types(struct f2fs_sb_info *sbi)
+{
+	struct seg_entry *se;
+	unsigned int i;
+	int err = 0;
+
+	for (i = 0; i < TOTAL_SEGS(sbi); i++) {
+		struct seg_entry *se;
+
+		se = get_seg_entry(sbi, i);
+		if (se->orig_type != se->type) {
+			FIX_MSG("Wrong segment type [0x%x] %x -> %x",
+					i, se->orig_type, se->type);
+			err = -EINVAL;
+		}
+	}
+	return err;
+}
+
 int fsck_verify(struct f2fs_sb_info *sbi)
 {
 	unsigned int i = 0;
@@ -1108,13 +1125,21 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		config.bug_on = 1;
 	}
 
+	printf("[FSCK] SIT types                                     ");
+	if (check_sit_types(sbi) == 0) {
+		printf(" [Ok..]\n");
+	} else {
+		printf(" [Fail]\n");
+		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
+	}
+
 	printf("[FSCK] other corrupted bugs                          ");
 	if (config.bug_on == 0) {
 		printf(" [Ok..]\n");
 	} else {
 		printf(" [Fail]\n");
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
 	}
 
 	/* fix global metadata */
diff --git a/fsck/mount.c b/fsck/mount.c
index 8ff7ff7..0aca60b 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -795,6 +795,7 @@ void seg_info_from_raw_sit(struct seg_entry *se,
 	memcpy(se->cur_valid_map, raw_sit->valid_map, SIT_VBLOCK_MAP_SIZE);
 	memcpy(se->ckpt_valid_map, raw_sit->valid_map, SIT_VBLOCK_MAP_SIZE);
 	se->type = GET_SIT_TYPE(raw_sit);
+	se->orig_type = GET_SIT_TYPE(raw_sit);
 	se->mtime = le64_to_cpu(raw_sit->mtime);
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
