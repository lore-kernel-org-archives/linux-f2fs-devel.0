From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] fsck.f2fs: allow roll-forward for small
 checkpoint fix
Date: Sat, 20 Jan 2018 14:06:56 -0800
Message-ID: <20180120220657.28292-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ed1I1-0000ps-6I
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:07:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ed1I0-00035o-Dv
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:07:05 +0000
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

This allows roll-forward when fsck.f2fs changes checkpoint crc.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 1 +
 include/f2fs_fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 1211729..6c1b9a7 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1936,6 +1936,7 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
 
 	flags = update_nat_bits_flags(sb, cp, flags);
+	flags |= CP_NOCRC_RECOVERY_FLAG;
 	set_cp(ckpt_flags, flags);
 
 	set_cp(free_segment_count, get_free_segments(sbi));
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 4739085..67f31d8 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -613,6 +613,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_NOCRC_RECOVERY_FLAG	0x00000200
 #define CP_TRIMMED_FLAG		0x00000100
 #define CP_NAT_BITS_FLAG	0x00000080
 #define CP_CRC_RECOVERY_FLAG	0x00000040
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
