From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: show missing checkpoint flags
Date: Sat, 20 Jan 2018 14:06:57 -0800
Message-ID: <20180120220657.28292-2-jaegeuk@kernel.org>
References: <20180120220657.28292-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ed1I1-000517-UT
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:07:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ed1I1-0003jC-6a
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:07:05 +0000
In-Reply-To: <20180120220657.28292-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch shows some missing checkpoint flags.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 124593d..0a5b986 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -401,6 +401,16 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
 void print_cp_state(u32 flag)
 {
 	MSG(0, "Info: checkpoint state = %x : ", flag);
+	if (flag & CP_NOCRC_RECOVERY_FLAG)
+		MSG(0, "%s", " allow_nocrc");
+	if (flag & CP_TRIMMED_FLAG)
+		MSG(0, "%s", " trimmed");
+	if (flag & CP_NAT_BITS_FLAG)
+		MSG(0, "%s", " nat_bits");
+	if (flag & CP_CRC_RECOVERY_FLAG)
+		MSG(0, "%s", " crc");
+	if (flag & CP_FASTBOOT_FLAG)
+		MSG(0, "%s", " fastboot");
 	if (flag & CP_FSCK_FLAG)
 		MSG(0, "%s", " fsck");
 	if (flag & CP_ERROR_FLAG)
@@ -409,12 +419,6 @@ void print_cp_state(u32 flag)
 		MSG(0, "%s", " compacted_summary");
 	if (flag & CP_ORPHAN_PRESENT_FLAG)
 		MSG(0, "%s", " orphan_inodes");
-	if (flag & CP_FASTBOOT_FLAG)
-		MSG(0, "%s", " fastboot");
-	if (flag & CP_NAT_BITS_FLAG)
-		MSG(0, "%s", " nat_bits");
-	if (flag & CP_TRIMMED_FLAG)
-		MSG(0, "%s", " trimmed");
 	if (flag & CP_UMOUNT_FLAG)
 		MSG(0, "%s", " unmount");
 	else
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
