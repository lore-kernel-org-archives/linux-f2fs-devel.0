From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: introduce preen mode 2
Date: Tue, 27 Nov 2018 20:36:35 +0800
Message-ID: <20181127123635.123303-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As Michael reported:

after updating to f2fs-tools 1.12.0, a routine fsck of my file systems
took quite a while and output ten-thousands instances of the following
line:

> [FIX] (fsck_chk_inode_blk: 954)  --> Regular: 0xXYZ reset i_gc_failures from 0x1 to 0x00

The reason is that:

We start to support reseting .i_gc_failures's value to zero in fsck since
91bb7b21f740 ("f2fs-tools: fix to reset i_gc_failures offline"), this is
because if .i_gc_failures continues increasing and exceed threshold, it
can make f2fs break atomic_write semantics during GC, so I added that
patch to avoid such condition.

But the problem here is even .i_gc_failures's value is one which was
initialized duing inode creation by old kernel, and it never be increased
by GC flow, we will still trigger such fix in fsck. I think it's not
necessary.

As Jaegeuk suggested, we introduce a new preen mode 2 to handle such
condition:
  - 2: same as 0, but skip some checks for old kernel

Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reported-by: Michael Laß <bevan@bi-co.net>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c | 8 +++++++-
 fsck/fsck.h | 1 +
 fsck/main.c | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 970d150df5e8..bcda78142471 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -941,7 +941,13 @@ skip_blkcnt_fix:
 	}
 
 	i_gc_failures = le16_to_cpu(node_blk->i.i_gc_failures);
-	if (ftype == F2FS_FT_REG_FILE && i_gc_failures) {
+
+	/*
+	 * old kernel initialized i_gc_failures as 0x01, in preen mode 2,
+	 * let's skip repairing.
+	 */
+	if (ftype == F2FS_FT_REG_FILE && i_gc_failures &&
+		(c.preen_mode != PREEN_MODE_2 || i_gc_failures != 0x01)) {
 
 		DBG(1, "Regular Inode: 0x%x [%s] depth: %d\n\n",
 				le32_to_cpu(node_blk->footer.ino), en,
diff --git a/fsck/fsck.h b/fsck/fsck.h
index b2227d2746d1..cbd6e9332d7c 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -21,6 +21,7 @@ struct quota_ctx;
 enum {
 	PREEN_MODE_0,
 	PREEN_MODE_1,
+	PREEN_MODE_2,
 	PREEN_MODE_MAX
 };
 
diff --git a/fsck/main.c b/fsck/main.c
index bb79f6e9fc89..65bdb5d5a401 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -216,6 +216,8 @@ void f2fs_parse_options(int argc, char *argv[])
 				/* preen mode has different levels:
 				 *  0: default level, the same as -a
 				 *  1: check meta
+				 *  2: same as 0, but will skip some
+				 *     check for old kernel
 				 */
 				if (optarg[0] == '-' || !is_digits(optarg) ||
 							optind == argc) {
@@ -230,7 +232,8 @@ void f2fs_parse_options(int argc, char *argv[])
 					c.preen_mode = PREEN_MODE_0;
 				else if (c.preen_mode >= PREEN_MODE_MAX)
 					c.preen_mode = PREEN_MODE_MAX - 1;
-				if (c.preen_mode == PREEN_MODE_0)
+				if (c.preen_mode == PREEN_MODE_0 ||
+					c.preen_mode == PREEN_MODE_2)
 					c.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption in "
 					"preen mode %d\n", c.preen_mode);
-- 
2.18.0.rc1
