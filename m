From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: handle error cases in
	move_encrypted_block
Date: Tue, 14 Jul 2015 12:18:21 -0700
Message-ID: <1436901502-78825-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZF5iq-0004T1-HP
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jul 2015 19:18:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZF5ip-0004Xw-IY for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jul 2015 19:18:32 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch fixes some missing error handlers.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 11046db..db11861 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -556,27 +556,34 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	if (!fio.encrypted_page)
 		goto put_out;
 
-	f2fs_submit_page_bio(&fio);
-
-	/* allocate block address */
-	f2fs_wait_on_page_writeback(dn.node_page, NODE);
-
-	allocate_data_block(fio.sbi, NULL, fio.blk_addr,
-					&fio.blk_addr, &sum, CURSEG_COLD_DATA);
-	dn.data_blkaddr = fio.blk_addr;
+	err = f2fs_submit_page_bio(&fio);
+	if (err)
+		goto put_page_out;
 
 	/* write page */
 	lock_page(fio.encrypted_page);
+
+	if (unlikely(!PageUptodate(fio.encrypted_page)))
+		goto put_page_out;
+	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi)))
+		goto put_page_out;
+
 	set_page_writeback(fio.encrypted_page);
 	fio.rw = WRITE_SYNC;
 	f2fs_submit_page_mbio(&fio);
 
+	/* allocate block address */
+	f2fs_wait_on_page_writeback(dn.node_page, NODE);
+	allocate_data_block(fio.sbi, NULL, fio.blk_addr,
+					&fio.blk_addr, &sum, CURSEG_COLD_DATA);
+	dn.data_blkaddr = fio.blk_addr;
+
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


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
