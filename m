From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 1/3] f2fs: avoid unable to restart gc thread in
 remount
Date: Tue, 18 Nov 2014 11:16:01 +0800
Message-ID: <006601d002de$20ec59a0$62c50ce0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In f2fs_remount, we will stop gc thread and set need_restart_gc as true when new
option is set without BG_GC, then if any error occurred in the following
procedure, we can restore to start the gc thread.
But after that, We will fail to restore gc thread in start_gc_thread as BG_GC is
not set in new option, so we'd better move this condition judgment out of
start_gc_thread to fix this issue.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c    | 2 --
 fs/f2fs/super.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b197a2f..657683c9 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -96,8 +96,6 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	int err = 0;
 
-	if (!test_opt(sbi, BG_GC))
-		goto out;
 	gc_th = kmalloc(sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
 	if (!gc_th) {
 		err = -ENOMEM;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 512ffd8..536d414 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1138,7 +1138,7 @@ try_onemore:
 	 * If filesystem is not mounted as read-only then
 	 * do start the gc_thread.
 	 */
-	if (!f2fs_readonly(sb)) {
+	if (test_opt(sbi, BG_GC) && !f2fs_readonly(sb)) {
 		/* After POR, we can run background GC thread.*/
 		err = start_gc_thread(sbi);
 		if (err)
-- 
2.1.2
