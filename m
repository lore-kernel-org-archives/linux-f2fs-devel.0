From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't need to wait for node writes for atomic write
Date: Fri, 28 Jul 2017 12:14:38 -0700
Message-ID: <20170728191438.34330-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We have a node chain to serialize node block writes, so if any IOs for
node block writes are reordered, we'll get broken node chain. IOWs,
roll-forward recovery will see all or none node blocks given fsync
mark.

E.g.,
Node chain consists of:
 N1 -> N2 -> N3 -> NFSYNC -> N1' -> N2' -> N'FSYNC

Reordered to:
1) N1 -> N2 -> N3 -> N2' -> NFSYNC -> N'FSYNC -> power-cut
2) N1 -> N2 -> N3 -> N1' -> NFSYNC -> power-cut
3) N1 -> N2 -> NFSYNC -> N1' -> N'FSYNC -> N3 -> power-cut
4) N1 -> NFSYNC -> N1' -> N2' -> N'FSYNC -> N3 -> power-cut

Roll-forward recovery can proceed to:
1) N1 -> N2 -> N3 -> NFSYNC -> X
2) N1 -> N2 -> N3 -> NFSYNC -> N1' -> X
3) N1 -> N2 -> N3 -> FSYNC -> N1' -> X
4) N1 -> X

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a0413c951458..0246d19d96c3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -274,9 +274,19 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		goto sync_nodes;
 	}
 
-	ret = wait_on_node_pages_writeback(sbi, ino);
-	if (ret)
-		goto out;
+	/*
+	 * If it's atomic_write, it's just fine to keep write ordering. So
+	 * here we don't need to wait for node write completion, since we use
+	 * node chain which serializes node blocks. If one of node writes are
+	 * reordered, we can see simply broken chain, resulting in stopping
+	 * roll-forward recovery. It means we'll recover all or none node blocks
+	 * given fsync mark.
+	 */
+	if (!atomic) {
+		ret = wait_on_node_pages_writeback(sbi, ino);
+		if (ret)
+			goto out;
+	}
 
 	/* once recovery info is written, don't need to tack this */
 	remove_ino_entry(sbi, ino, APPEND_INO);
-- 
2.13.0.rc1.294.g07d810a77f-goog
