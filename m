From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: set readdir_ra by default
Date: Mon, 26 Feb 2018 09:47:29 -0800
Message-ID: <20180226174731.26679-3-jaegeuk@kernel.org>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226174731.26679-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It gives general readdir improvement.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9515c10eebad..425eb4f6654a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1297,6 +1297,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	sbi->inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
 	sbi->whint_mode = WHINT_MODE_OFF;
 	sbi->alloc_mode = ALLOC_MODE_DEFAULT;
+	sbi->readdir_ra = 1;
 
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_XATTR);
-- 
2.15.0.531.g2ccb3012c9-goog
