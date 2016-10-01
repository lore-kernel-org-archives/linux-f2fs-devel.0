From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: introduce update_ckpt_flags to clean up
Date: Fri, 30 Sep 2016 17:55:08 -0700
Message-ID: <20161001005508.63684-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bq8aF-0001BO-22
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Oct 2016 00:55:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bq8aE-0004xa-8x
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Oct 2016 00:55:19 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch add update_ckpt_flags() to clean up the flow.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 56 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7e26328..7e9b504 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1006,6 +1006,37 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
 	finish_wait(&sbi->cp_wait, &wait);
 }
 
+static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+{
+	unsigned long orphan_num = sbi->im[ORPHAN_INO].ino_num;
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+
+	spin_lock(&sbi->cp_lock);
+
+	if (cpc->reason == CP_UMOUNT)
+		__set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
+
+	if (cpc->reason == CP_FASTBOOT)
+		__set_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
+
+	if (orphan_num)
+		__set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
+
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
+
+	/* set this flag to activate crc|cp_ver for recovery */
+	__set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
+
+	spin_unlock(&sbi->cp_lock);
+}
+
 static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -1080,29 +1111,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 				cp_payload_blks + data_sum_blocks +
 				orphan_blocks);
 
-	spin_lock(&sbi->cp_lock);
-	if (cpc->reason == CP_UMOUNT)
-		__set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
-	else
-		__clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
-
-	if (cpc->reason == CP_FASTBOOT)
-		__set_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
-	else
-		__clear_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
-
-	if (orphan_num)
-		__set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
-	else
-		__clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
-
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
-		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
-
-	/* set this flag to activate crc|cp_ver for recovery */
-	__set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
-
-	spin_unlock(&sbi->cp_lock);
+	/* update ckpt flag for checkpoint */
+	update_ckpt_flags(sbi, cpc);
 
 	/* update SIT/NAT bitmap */
 	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
