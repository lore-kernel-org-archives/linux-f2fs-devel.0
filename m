From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix wrong #endif
Date: Tue, 12 Mar 2019 11:26:13 -0700
Message-ID: <20190312182613.47642-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We have to cover whole headerfile with last #endif.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1f0d2810852..19cbf17550c7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3626,8 +3626,6 @@ extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
 #define f2fs_build_fault_attr(sbi, rate, type)		do { } while (0)
 #endif
 
-#endif
-
 static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 {
 #ifdef CONFIG_QUOTA
@@ -3640,3 +3638,5 @@ static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 #endif
 	return false;
 }
+
+#endif
-- 
2.19.0.605.g01d371f741-goog
