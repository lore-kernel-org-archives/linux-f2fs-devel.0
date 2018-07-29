From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: return fake len for quota if cp is shutdown
Date: Sat, 28 Jul 2018 23:11:41 -0700
Message-ID: <20180729061141.4846-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If cp is shutdown, let's just return success to unmount the partition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e0a828188f65..d56bc6eb8760 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1625,6 +1625,10 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 	int tocopy;
 
 	while (towrite > 0) {
+
+		if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
+			return len;
+
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
 								towrite);
 retry:
-- 
2.17.0.441.gb46fe60e1d-goog
