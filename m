From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't need to call set_page_dirty for io error
Date: Mon, 25 Jan 2016 17:45:09 -0800
Message-ID: <1453772709-30411-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If end_io gets an error, we don't need to set the page as dirty, since we
already set f2fs_stop_checkpoint which will not flush any data.

This will resolve the following warning.

======================================================
[ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
4.4.0+ #9 Tainted: G           O
------------------------------------------------------
xfs_io/26773 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (&(&sbi->inode_lock[i])->rlock){+.+...}, at: [<ffffffffc025483f>] update_dirty_page+0x6f/0xd0 [f2fs]

and this task is already holding:
 (&(&q->__queue_lock)->rlock){-.-.-.}, at: [<ffffffff81396ea2>] blk_queue_bio+0x422/0x490
which would create a new lock dependency:
 (&(&q->__queue_lock)->rlock){-.-.-.} -> (&(&sbi->inode_lock[i])->rlock){+.+...}

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e992bf..c85acbc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -67,7 +67,6 @@ static void f2fs_write_end_io(struct bio *bio)
 		f2fs_restore_and_release_control_page(&page);
 
 		if (unlikely(bio->bi_error)) {
-			set_page_dirty(page);
 			set_bit(AS_EIO, &page->mapping->flags);
 			f2fs_stop_checkpoint(sbi);
 		}
-- 
2.6.3
