From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: introduce a new flag to indicate trun off
 nat bits temporary
Date: Fri, 13 Apr 2018 11:07:49 +0800
Message-ID: <1523588869-9646-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f6pHy-0000K9-PT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 03:22:14 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6pHu-00CmmN-BL
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 03:22:14 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

SBI_NEED_FSCK is used for *real* data corruption on-line, then it can
be a condition to end up issuing discard from background/umount/fstrim
to prevent further data losing. This patch split in-memory SBI_NEED_FSCK
to SBI_LOSE_NAT_BIT and SBI_NEED_FSCK, in order to report data corruption
more accurately.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c | 3 ++-
 fs/f2fs/f2fs.h       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2e23b95..96785ff 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1162,7 +1162,8 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	else
 		__clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
 
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
+			is_sbi_flag_set(sbi, SBI_LOSE_NAT_BITS))
 		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
 
 	/* set this flag to activate crc|cp_ver for recovery */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c1c3a1d..90940350 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1055,6 +1055,7 @@ enum {
 	SBI_POR_DOING,				/* recovery is doing or not */
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
+	SBI_LOSE_NAT_BITS,			/* nat bits is lost */
 };
 
 enum {
@@ -1517,7 +1518,7 @@ static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
 {
 	unsigned long flags;
 
-	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	set_sbi_flag(sbi, SBI_LOSE_NAT_BITS);
 
 	if (lock)
 		spin_lock_irqsave(&sbi->cp_lock, flags);
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
