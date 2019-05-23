From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] fsck.f2fs: Fix up nat journal corruption with -a
 (auto-fix) option
Date: Thu, 23 May 2019 10:13:47 +0530
Message-ID: <1558586627-19784-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1hTfaL-0007Hk-F7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 May 2019 04:44:09 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hTfaF-0089xM-Kj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 May 2019 04:44:09 +0000
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
 fsck/mount.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index ec22783..46d62ee 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -943,6 +943,8 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 			"NAT_JOURNAL_ENTRIES(%lu)\n",
 			nats_in_cursum(journal), NAT_JOURNAL_ENTRIES);
 		journal->n_nats = cpu_to_le16(NAT_JOURNAL_ENTRIES);
+		c.auto_fix = 0;
+		c.fix_on = 1;
 	}
 
 	for (i = 0; i < nats_in_cursum(journal); i++) {
@@ -2363,19 +2365,6 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 
 	print_ckpt_info(sbi);
 
-	if (c.auto_fix || c.preen_mode) {
-		u32 flag = get_cp(ckpt_flags);
-
-		if (flag & CP_FSCK_FLAG ||
-			(exist_qf_ino(sb) && (!(flag & CP_UMOUNT_FLAG) ||
-						flag & CP_ERROR_FLAG))) {
-			c.fix_on = 1;
-		} else if (!c.preen_mode) {
-			print_cp_state(flag);
-			return 1;
-		}
-	}
-
 	c.bug_on = 0;
 	c.feature = sb->feature;
 
@@ -2400,6 +2389,19 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 		return -1;
 	}
 
+	if (c.auto_fix || c.preen_mode) {
+		u32 flag = get_cp(ckpt_flags);
+
+		if (flag & CP_FSCK_FLAG ||
+			(exist_qf_ino(sb) && (!(flag & CP_UMOUNT_FLAG) ||
+						flag & CP_ERROR_FLAG))) {
+			c.fix_on = 1;
+		} else if (!c.preen_mode) {
+			print_cp_state(flag);
+			return 1;
+		}
+	}
+
 	/* Check nat_bits */
 	if (c.func != DUMP && is_set_ckpt_flags(cp, CP_NAT_BITS_FLAG)) {
 		u_int32_t nat_bits_bytes, nat_bits_blocks;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
