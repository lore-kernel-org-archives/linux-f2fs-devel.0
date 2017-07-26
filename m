From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: give a try to do atomic write in -ENOMEM case
Date: Wed, 26 Jul 2017 11:16:51 -0700
Message-ID: <20170726181651.68667-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It'd be better to retry writing atomic pages when we get -ENOMEM.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f964b68718c1..f5d139f897dc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -309,17 +309,21 @@ static int __commit_inmem_pages(struct inode *inode,
 				inode_dec_dirty_pages(inode);
 				remove_dirty_inode(inode);
 			}
-
+retry:
 			fio.page = page;
 			fio.old_blkaddr = NULL_ADDR;
 			fio.encrypted_page = NULL;
 			fio.need_lock = LOCK_DONE;
 			err = do_write_data_page(&fio);
 			if (err) {
+				if (err == -ENOMEM) {
+					congestion_wait(BLK_RW_ASYNC, HZ/50);
+					cond_resched();
+					goto retry;
+				}
 				unlock_page(page);
 				break;
 			}
-
 			/* record old blkaddr for revoking */
 			cur->old_addr = fio.old_blkaddr;
 			last_idx = page->index;
-- 
2.13.0.rc1.294.g07d810a77f-goog
