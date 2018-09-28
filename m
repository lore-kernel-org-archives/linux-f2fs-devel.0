From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: keep lazytime on remount
Date: Fri, 28 Sep 2018 10:48:54 -0700
Message-ID: <20180928174854.65978-2-jaegeuk@kernel.org>
References: <20180928174854.65978-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928174854.65978-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes losing lazytime when remounting f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 603386525336..74056fa064ff 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1655,6 +1655,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	limit_reserve_root(sbi);
 	clear_sbi_flag(sbi, SBI_IS_MOUNT);
+	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	return 0;
 restore_gc:
 	if (need_restart_gc) {
-- 
2.19.0.605.g01d371f741-goog
