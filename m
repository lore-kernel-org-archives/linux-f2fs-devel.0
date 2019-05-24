From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v2] fsck.f2fs: Fix up nat journal corruption with
 -a (auto-fix) option
Date: Fri, 24 May 2019 11:39:47 +0530
Message-ID: <1558678187-13145-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1hU3P9-0001Y1-BR
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 06:10:11 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hU3P6-00CLnC-T0
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 06:10:11 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

Build segment manager and node manager always to catch and auto-fix
invalid NAT entries found in the NAT journal.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
 - cover all error paths in f2fs_init_nid_bitmap()

 fsck/mount.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index aa64e93..784003c 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1071,6 +1071,7 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 			"NAT_JOURNAL_ENTRIES(%lu)\n",
 			nats_in_cursum(journal), NAT_JOURNAL_ENTRIES);
 		journal->n_nats = cpu_to_le16(NAT_JOURNAL_ENTRIES);
+		c.fix_on = 1;
 	}
 
 	for (i = 0; i < nats_in_cursum(journal); i++) {
@@ -1080,6 +1081,7 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 		if (!IS_VALID_BLK_ADDR(sbi, addr)) {
 			MSG(0, "\tError: f2fs_init_nid_bitmap: addr(%u) is invalid!!!\n", addr);
 			journal->n_nats = cpu_to_le16(i);
+			c.fix_on = 1;
 			continue;
 		}
 
@@ -1087,6 +1089,7 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 		if (!IS_VALID_NID(sbi, nid)) {
 			MSG(0, "\tError: f2fs_init_nid_bitmap: nid(%u) is invalid!!!\n", nid);
 			journal->n_nats = cpu_to_le16(i);
+			c.fix_on = 1;
 			continue;
 		}
 		if (addr != NULL_ADDR)
@@ -2632,19 +2635,6 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 			c.fix_on = 1;
 	}
 
-	if (c.auto_fix || c.preen_mode) {
-		u32 flag = get_cp(ckpt_flags);
-
-		if (flag & CP_FSCK_FLAG ||
-			flag & CP_QUOTA_NEED_FSCK_FLAG ||
-			(exist_qf_ino(sb) && (flag & CP_ERROR_FLAG))) {
-			c.fix_on = 1;
-		} else if (!c.preen_mode) {
-			print_cp_state(flag);
-			return 1;
-		}
-	}
-
 	c.bug_on = 0;
 
 	tune_sb_features(sbi);
@@ -2670,6 +2660,19 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 		return -1;
 	}
 
+	if (!c.fix_on && (c.auto_fix || c.preen_mode)) {
+		u32 flag = get_cp(ckpt_flags);
+
+		if (flag & CP_FSCK_FLAG ||
+			flag & CP_QUOTA_NEED_FSCK_FLAG ||
+			(exist_qf_ino(sb) && (flag & CP_ERROR_FLAG))) {
+			c.fix_on = 1;
+		} else if (!c.preen_mode) {
+			print_cp_state(flag);
+			return 1;
+		}
+	}
+
 	/* Check nat_bits */
 	if (c.func == FSCK && is_set_ckpt_flags(cp, CP_NAT_BITS_FLAG)) {
 		if (check_nat_bits(sbi, sb, cp) && c.fix_on)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
