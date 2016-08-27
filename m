From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: merge WRITE bio into previous WRITE_SYNC
Date: Fri, 26 Aug 2016 17:53:58 -0700
Message-ID: <20160827005358.91477-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This can avoid bio splits due to different op_flags.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7c8e219..c7c2022 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -267,6 +267,11 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 
 	down_write(&io->io_rwsem);
 
+	/* WRITE can be merged into previous WRITE_SYNC */
+	if (io->bio && io->last_block_in_bio == fio->new_blkaddr - 1 &&
+			io->fio.op == fio->op && io->fio.op_flags == WRITE_SYNC)
+		fio->op_flags = WRITE_SYNC;
+
 	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
 	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags)))
 		__submit_merged_bio(io);
-- 
2.8.3
