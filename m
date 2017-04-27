From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: nullify fio->encrypted_page for each writes
Date: Wed, 26 Apr 2017 17:58:43 -0700
Message-ID: <20170427005843.6327-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This makes sure each write request has nullified encrypted_page pointer.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 38b97ad6bceb..b0babb73a076 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -291,7 +291,6 @@ static int __commit_inmem_pages(struct inode *inode,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
 		.op_flags = REQ_SYNC | REQ_PRIO,
-		.encrypted_page = NULL,
 	};
 	pgoff_t last_idx = ULONG_MAX;
 	int err = 0;
@@ -312,6 +311,7 @@ static int __commit_inmem_pages(struct inode *inode,
 
 			fio.page = page;
 			fio.old_blkaddr = NULL_ADDR;
+			fio.encrypted_page = NULL;
 			err = do_write_data_page(&fio);
 			if (err) {
 				unlock_page(page);
-- 
2.11.0
