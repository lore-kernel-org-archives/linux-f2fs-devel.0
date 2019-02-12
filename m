From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Date: Mon, 11 Feb 2019 18:33:43 -0800
Message-ID: <20190212023343.52215-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we met this once, let fsck.f2fs clear this only.
Note that, this addresses all the subtle fault injection test.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 03fea4efd64b..10a3ada28715 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
-	else
-		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
 
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
-- 
2.19.0.605.g01d371f741-goog
