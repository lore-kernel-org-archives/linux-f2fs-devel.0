From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: return directly if block has been removed
	from the victim
Date: Mon, 24 Oct 2016 11:37:28 +0800
Message-ID: <20161024033728.10780-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1byVz9-0001Su-JV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Oct 2016 03:31:39 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1byVz4-0004Kv-14
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Oct 2016 03:31:39 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

If one block has been to written to a new place, just return
in move data process.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f35fca5..fc78f3e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -545,7 +545,8 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	return true;
 }
 
-static void move_encrypted_block(struct inode *inode, block_t bidx)
+static void move_encrypted_block(struct inode *inode, block_t bidx,
+						unsigned int segno, int off)
 {
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
@@ -580,6 +581,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	 * don't cache encrypted data into meta inode until previous dirty
 	 * data were writebacked to avoid racing between GC and flush.
 	 */
+	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
+		goto out;
+
 	f2fs_wait_on_page_writeback(page, DATA, true);
 
 	get_node_info(fio.sbi, dn.nid, &ni);
@@ -646,7 +650,8 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	f2fs_put_page(page, 1);
 }
 
-static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
+static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
+							unsigned int segno, int off)
 {
 	struct page *page;
 
@@ -655,8 +660,10 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 		return;
 
 	if (gc_type == BG_GC) {
-		if (PageWriteback(page))
+		if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 			goto out;
+
+		f2fs_wait_on_page_writeback(page, DATA, false);
 		set_page_dirty(page);
 		set_cold_data(page);
 	} else {
@@ -797,9 +804,9 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			start_bidx = start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
 			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
-				move_encrypted_block(inode, start_bidx);
+				move_encrypted_block(inode, start_bidx, segno, off);
 			else
-				move_data_page(inode, start_bidx, gc_type);
+				move_data_page(inode, start_bidx, gc_type, segno, off);
 
 			if (locked) {
 				up_write(&fi->dio_rwsem[WRITE]);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
