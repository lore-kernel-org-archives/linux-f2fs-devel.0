From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix quota info to adjust recovered data
Date: Tue, 11 Sep 2018 13:15:46 -0700
Message-ID: <20180911201546.56566-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

fsck.f2fs is able to recover the quota structure, since roll-forward recovery
can recover it based on previous user information.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 95511ed11a22..1fde86a2107e 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -675,6 +675,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 
 	need_writecp = true;
 
+	/* quota is not fully updated due to the lack of user information. */
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+
 	/* step #2: recover data */
 	err = recover_data(sbi, &inode_list, &dir_list);
 	if (!err)
-- 
2.17.0.441.gb46fe60e1d-goog
