From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: introduce background_gc=sync mount option
Date: Mon,  5 Oct 2015 15:43:58 -0700
Message-ID: <1444085040-12843-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduce background_gc=sync enabling synchronous cleaning in
background.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.txt |  3 ++-
 fs/f2fs/f2fs.h                     |  1 +
 fs/f2fs/gc.c                       |  2 +-
 fs/f2fs/segment.h                  |  4 +++-
 fs/f2fs/super.c                    | 21 +++++++++++++++------
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index e2d5105..b102b43 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -102,7 +102,8 @@ background_gc=%s       Turn on/off cleaning operations, namely garbage
                        collection, triggered in background when I/O subsystem is
                        idle. If background_gc=on, it will turn on the garbage
                        collection and if background_gc=off, garbage collection
-                       will be truned off.
+                       will be truned off. If background_gc=sync, it will turn
+                       on synchronous garbage collection running in background.
                        Default value for this option is on. So garbage
                        collection is on by default.
 disable_roll_forward   Disable the roll-forward recovery routine
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 18e5902..00bd470 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -53,6 +53,7 @@
 #define F2FS_MOUNT_NOBARRIER		0x00000800
 #define F2FS_MOUNT_FASTBOOT		0x00001000
 #define F2FS_MOUNT_EXTENT_CACHE		0x00002000
+#define F2FS_MOUNT_FORCE_FG_GC		0x00004000
 
 #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 830d277..e627c19 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -78,7 +78,7 @@ static int gc_thread_func(void *data)
 		stat_inc_bggc_count(sbi);
 
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi, false))
+		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC)))
 			wait_ms = gc_th->no_gc_sleep_time;
 
 		/* balancing f2fs's metadata periodically */
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index a294da7..e9afb58 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -137,10 +137,12 @@ enum {
 /*
  * BG_GC means the background cleaning job.
  * FG_GC means the on-demand cleaning job.
+ * FORCE_FG_GC means on-demand cleaning job in background.
  */
 enum {
 	BG_GC = 0,
-	FG_GC
+	FG_GC,
+	FORCE_FG_GC,
 };
 
 /* for a function parameter to select a victim segment */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 16442ec..ba058d0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -292,11 +292,16 @@ static int parse_options(struct super_block *sb, char *options)
 
 			if (!name)
 				return -ENOMEM;
-			if (strlen(name) == 2 && !strncmp(name, "on", 2))
+			if (strlen(name) == 2 && !strncmp(name, "on", 2)) {
 				set_opt(sbi, BG_GC);
-			else if (strlen(name) == 3 && !strncmp(name, "off", 3))
+				clear_opt(sbi, FORCE_FG_GC);
+			} else if (strlen(name) == 3 && !strncmp(name, "off", 3)) {
 				clear_opt(sbi, BG_GC);
-			else {
+				clear_opt(sbi, FORCE_FG_GC);
+			} else if (strlen(name) == 4 && !strncmp(name, "sync", 4)) {
+				set_opt(sbi, BG_GC);
+				set_opt(sbi, FORCE_FG_GC);
+			} else {
 				kfree(name);
 				return -EINVAL;
 			}
@@ -631,10 +636,14 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(root->d_sb);
 
-	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, BG_GC))
-		seq_printf(seq, ",background_gc=%s", "on");
-	else
+	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, BG_GC)) {
+		if (test_opt(sbi, FORCE_FG_GC))
+			seq_printf(seq, ",background_gc=%s", "sync");
+		else
+			seq_printf(seq, ",background_gc=%s", "on");
+	} else {
 		seq_printf(seq, ",background_gc=%s", "off");
+	}
 	if (test_opt(sbi, DISABLE_ROLL_FORWARD))
 		seq_puts(seq, ",disable_roll_forward");
 	if (test_opt(sbi, DISCARD))
-- 
2.1.1

