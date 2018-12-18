From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix missing unlock(sbi->gc_mutex)
Date: Mon, 17 Dec 2018 18:15:30 -0800
Message-ID: <20181218021530.78323-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This fixes missing unlock call.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b79677639108..2689a2cb56cc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1462,6 +1462,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
 		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
+
+		/* f2fs_gc guarantees unlock gc_mutex */
+		mutex_lock(&sbi->gc_mutex);
 		if (err == -ENODATA)
 			break;
 		if (err && err != -EAGAIN) {
-- 
2.19.0.605.g01d371f741-goog
