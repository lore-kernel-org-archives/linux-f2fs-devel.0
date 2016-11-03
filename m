From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v3] f2fs:return directly if block has been
	removed from the victim
Date: Thu, 3 Nov 2016 10:06:20 +0800
Message-ID: <20161103020620.32215-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1c27KC-0005K9-Qv
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 02:00:16 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c27K7-0005jB-Kt
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 02:00:16 +0000
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
in move data process. This patch check it again with holding
page lock.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9c18917..b00bcf9 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -544,7 +544,8 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	return true;
 }
 
-static void move_encrypted_block(struct inode *inode, block_t bidx)
+static void move_encrypted_block(struct inode *inode, block_t bidx,
+							unsigned int segno, int off)
 {
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
@@ -579,6 +580,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	 * don't cache encrypted data into meta inode until previous dirty
 	 * data were writebacked to avoid racing between GC and flush.
 	 */
+	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
+		goto put_out;
+
 	f2fs_wait_on_page_writeback(page, DATA, true);
 
 	get_node_info(fio.sbi, dn.nid, &ni);
@@ -645,7 +649,8 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	f2fs_put_page(page, 1);
 }
 
-static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
+static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
+							unsigned int segno, int off)
 {
 	struct page *page;
 
@@ -653,6 +658,9 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 	if (IS_ERR(page))
 		return;
 
+	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
+		goto out;
+
 	if (gc_type == BG_GC) {
 		if (PageWriteback(page))
 			goto out;
@@ -796,9 +804,9 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
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
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
