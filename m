From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: treat as a normal umount when remounting ro
Date: Thu, 24 Mar 2016 13:45:13 -0700
Message-ID: <20160324204513.GA36798@jaegeuk.gateway>
References: <1458849592-34163-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458849592-34163-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 - fix wrong roll-forward disable

>From b7950b49f94d865b184070fffa5bc1530e58ac1c Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 24 Mar 2016 10:29:39 -0700
Subject: [PATCH] f2fs: treat as a normal umount when remounting ro

When user remounts f2fs as read-only, we can mark the checkpoint as umount.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index abc0d75..254c7a5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -791,11 +791,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	org_mount_opt = sbi->mount_opt;
 	active_logs = sbi->active_logs;
 
-	if (*flags & MS_RDONLY) {
-		set_opt(sbi, FASTBOOT);
-		set_sbi_flag(sbi, SBI_IS_DIRTY);
-	}
-
 	/* recover superblocks we couldn't write due to previous RO mount */
 	if (!(*flags & MS_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
 		err = f2fs_commit_super(sbi, false);
@@ -805,8 +800,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 	}
 
-	sync_filesystem(sb);
-
 	sbi->mount_opt.opt = 0;
 	default_options(sbi);
 
@@ -838,7 +831,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if ((*flags & MS_RDONLY) || !test_opt(sbi, BG_GC)) {
 		if (sbi->gc_thread) {
 			stop_gc_thread(sbi);
-			f2fs_sync_fs(sb, 1);
 			need_restart_gc = true;
 		}
 	} else if (!sbi->gc_thread) {
@@ -848,6 +840,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
+	if (*flags & MS_RDONLY) {
+		sync_inodes_sb(sb);
+
+		set_sbi_flag(sbi, SBI_IS_DIRTY);
+		set_sbi_flag(sbi, SBI_IS_CLOSE);
+		f2fs_sync_fs(sb, 1);
+		clear_sbi_flag(sbi, SBI_IS_CLOSE);
+	}
+
 	/*
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
-- 
2.6.3

