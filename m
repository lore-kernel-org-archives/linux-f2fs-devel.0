From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: support norecovery mount option
Date: Tue, 27 Jan 2015 15:31:40 -0800
Message-ID: <1422401503-4769-2-git-send-email-jaegeuk@kernel.org>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a mount option, norecovery, which is mostly same as
disable_roll_forward. The only difference is that norecovery should be activated
with read-only mount option.

This can be used when user wants to check whether f2fs is mountable or not
without any recovery process. (e.g., xfstests/200)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fbc7f5a..0ca1fb2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -42,6 +42,7 @@ static struct kset *f2fs_kset;
 enum {
 	Opt_gc_background,
 	Opt_disable_roll_forward,
+	Opt_norecovery,
 	Opt_discard,
 	Opt_noheap,
 	Opt_user_xattr,
@@ -62,6 +63,7 @@ enum {
 static match_table_t f2fs_tokens = {
 	{Opt_gc_background, "background_gc=%s"},
 	{Opt_disable_roll_forward, "disable_roll_forward"},
+	{Opt_norecovery, "norecovery"},
 	{Opt_discard, "discard"},
 	{Opt_noheap, "no_heap"},
 	{Opt_user_xattr, "user_xattr"},
@@ -287,6 +289,12 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_disable_roll_forward:
 			set_opt(sbi, DISABLE_ROLL_FORWARD);
 			break;
+		case Opt_norecovery:
+			/* this option mounts f2fs with ro */
+			set_opt(sbi, DISABLE_ROLL_FORWARD);
+			if (!f2fs_readonly(sb))
+				return -EINVAL;
+			break;
 		case Opt_discard:
 			set_opt(sbi, DISCARD);
 			break;
-- 
2.1.1
