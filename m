From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/5 v2] f2fs: support norecovery mount option
Date: Thu, 29 Jan 2015 10:31:02 -0800
Message-ID: <20150129183102.GC15313@jaegeuk-mac02.mot.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-2-git-send-email-jaegeuk@kernel.org>
 <002b01d03bba$37f763a0$a7e62ae0$@samsung.com>
 <20150129182745.GB15313@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150129182745.GB15313@jaegeuk-mac02.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 o add description for the new mount option in Documentation/filesystems/f2fs.txt

>From 079dbb14c7d91d90863c9be4d9337b8ec086db7e Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 23 Jan 2015 18:33:46 -0800
Subject: [PATCH] f2fs: support norecovery mount option

This patch adds a mount option, norecovery, which is mostly same as
disable_roll_forward. The only difference is that norecovery should be activated
with read-only mount option.

This can be used when user wants to check whether f2fs is mountable or not
without any recovery process. (e.g., xfstests/200)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.txt | 2 ++
 fs/f2fs/super.c                    | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index e0950c4..6758aa3 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -106,6 +106,8 @@ background_gc=%s       Turn on/off cleaning operations, namely garbage
                        Default value for this option is on. So garbage
                        collection is on by default.
 disable_roll_forward   Disable the roll-forward recovery routine
+norecovery             Disable the roll-forward recovery routine, mounted read-
+                       only (i.e., -o ro,disable_roll_forward)
 discard                Issue discard/TRIM commands when a segment is cleaned.
 no_heap                Disable heap-style segment allocation which finds free
                        segments for data from the beginning of main area, while
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 47d9b04..a60fa1a 100644
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
