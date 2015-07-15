From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: handle error cases in move_encrypted_block
Date: Wed, 15 Jul 2015 15:38:11 -0700
Message-ID: <1436999892-86682-2-git-send-email-jaegeuk@kernel.org>
References: <1436999892-86682-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436999892-86682-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes some missing error handlers.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 93aff5b..22007ad 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -559,27 +559,34 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	if (!fio.encrypted_page)
 		goto put_out;
 
-	f2fs_submit_page_bio(&fio);
+	err = f2fs_submit_page_bio(&fio);
+	if (err)
+		goto put_page_out;
+
+	/* write page */
+	lock_page(fio.encrypted_page);
+
+	if (unlikely(!PageUptodate(fio.encrypted_page)))
+		goto put_page_out;
+	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi)))
+		goto put_page_out;
+
+	set_page_writeback(fio.encrypted_page);
 
 	/* allocate block address */
 	f2fs_wait_on_page_writeback(dn.node_page, NODE);
-
 	allocate_data_block(fio.sbi, NULL, fio.blk_addr,
 					&fio.blk_addr, &sum, CURSEG_COLD_DATA);
-	dn.data_blkaddr = fio.blk_addr;
-
-	/* write page */
-	lock_page(fio.encrypted_page);
-	set_page_writeback(fio.encrypted_page);
 	fio.rw = WRITE_SYNC;
 	f2fs_submit_page_mbio(&fio);
 
+	dn.data_blkaddr = fio.blk_addr;
 	set_data_blkaddr(&dn);
 	f2fs_update_extent_cache(&dn);
 	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
 	if (page->index == 0)
 		set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
-
+put_page_out:
 	f2fs_put_page(fio.encrypted_page, 1);
 put_out:
 	f2fs_put_dnode(&dn);
-- 
2.1.1
