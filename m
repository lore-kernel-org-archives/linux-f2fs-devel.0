From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 2/3] f2fs: remove unneeded check code with option in
 f2fs_remount
Date: Tue, 18 Nov 2014 11:17:20 +0800
Message-ID: <006701d002de$45007ec0$cf017c40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Because we have checked the contrary condition in case of "if" judgment, we do
not need to check the condition again in case of "else" judgment. Let's remove
it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 536d414..f71421d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -669,7 +669,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			f2fs_sync_fs(sb, 1);
 			need_restart_gc = true;
 		}
-	} else if (test_opt(sbi, BG_GC) && !sbi->gc_thread) {
+	} else if (!sbi->gc_thread) {
 		err = start_gc_thread(sbi);
 		if (err)
 			goto restore_opts;
@@ -682,7 +682,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	if ((*flags & MS_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
 		destroy_flush_cmd_control(sbi);
-	} else if (test_opt(sbi, FLUSH_MERGE) && !SM_I(sbi)->cmd_control_info) {
+	} else if (!SM_I(sbi)->cmd_control_info) {
 		err = create_flush_cmd_control(sbi);
 		if (err)
 			goto restore_gc;
-- 
2.1.2
