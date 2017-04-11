From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: avoid frequent checkpoint during f2fs_gc
Date: Mon, 10 Apr 2017 17:13:08 -0700
Message-ID: <20170411001308.12881-4-jaegeuk@kernel.org>
References: <20170411001308.12881-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170411001308.12881-1-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Now we're doing SSR aggressively more than ever before, so once we reach to
the reserved_segment, f2fs_balance_fs will call f2fs_gc, which triggers
checkpoint everytime. We actually must avoid that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e2f9b2b12b74..4a720f3394d9 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -966,7 +966,11 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 		 * threshold, we can make them free by checkpoint. Then, we
 		 * secure free segments which doesn't need fggc any more.
 		 */
-		ret = write_checkpoint(sbi, &cpc);
+		if (prefree_segments(sbi)) {
+			ret = write_checkpoint(sbi, &cpc);
+			if (ret)
+				goto stop;
+		}
 		if (ret)
 			goto stop;
 		if (has_not_enough_free_secs(sbi, 0, 0))
-- 
2.11.0
