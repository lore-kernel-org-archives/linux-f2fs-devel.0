From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 1/3] f2fs: reconstruct code to write a data page
Date: Sat, 22 Apr 2017 09:22:21 +0000
Message-ID: <20170422092223.118496-2-houpengyang@huawei.com>
References: <20170422092223.118496-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d1rFe-0006mg-SQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Apr 2017 09:22:46 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189]
	helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d1rFc-0007rw-99
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Apr 2017 09:22:46 +0000
In-Reply-To: <20170422092223.118496-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch introduces two functions:

	1) f2fs_encrypt_page -- encrypt data page before submit_bio
	2) do_rewrite_data_page -- IPU rewrite

The two functions are extraced from do_write_data_page, logic in
do_write_data_page stays unchanged.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 83 ++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b8dcd1e..6b18750 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1302,26 +1302,11 @@ static int f2fs_read_data_pages(struct file *file,
 	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages);
 }
 
-int do_write_data_page(struct f2fs_io_info *fio)
+static int f2fs_encrypt_page(struct f2fs_io_info *fio, struct page *page)
 {
-	struct page *page = fio->page;
 	struct inode *inode = page->mapping->host;
-	struct dnode_of_data dn;
 	int err = 0;
 
-	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
-	if (err)
-		return err;
-
-	fio->old_blkaddr = dn.data_blkaddr;
-
-	/* This page is already truncated */
-	if (fio->old_blkaddr == NULL_ADDR) {
-		ClearPageUptodate(page);
-		goto out_writepage;
-	}
-
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
 		gfp_t gfp_flags = GFP_NOFS;
 
@@ -1343,9 +1328,63 @@ int do_write_data_page(struct f2fs_io_info *fio)
 				err = 0;
 				goto retry_encrypt;
 			}
-			goto out_writepage;
+			return err;
 		}
 	}
+	return err;
+}
+
+static int do_rewrite_data_page(struct f2fs_io_info *fio, struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	int err;
+
+	f2fs_bug_on(F2FS_P_SB(page), !fio->cp_rwsem_locked);
+
+	f2fs_unlock_op(F2FS_I_SB(inode));
+	fio->cp_rwsem_locked = false;
+	err = rewrite_data_page(fio);
+	set_inode_flag(inode, FI_UPDATE_WRITE);
+	trace_f2fs_do_write_data_page(page, IPU);
+	return err;
+
+}
+
+static inline bool need_inplace_update_block(struct f2fs_io_info *fio, struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+
+	if (!is_cold_data(page) &&
+			!IS_ATOMIC_WRITTEN_PAGE(page) &&
+			need_inplace_update(inode, fio))
+		return true;
+
+	return false;
+}
+
+int do_write_data_page(struct f2fs_io_info *fio)
+{
+	struct page *page = fio->page;
+	struct inode *inode = page->mapping->host;
+	struct dnode_of_data dn;
+	int err = 0;
+
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
+	if (err)
+		return err;
+
+	fio->old_blkaddr = dn.data_blkaddr;
+
+	/* This page is already truncated */
+	if (fio->old_blkaddr == NULL_ADDR) {
+		ClearPageUptodate(page);
+		goto out_writepage;
+	}
+
+	err = f2fs_encrypt_page(fio, page);
+	if (err)
+		goto out_writepage;
 
 	set_page_writeback(page);
 
@@ -1354,14 +1393,8 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	 * it had better in-place writes for updated data.
 	 */
 	if (unlikely(fio->old_blkaddr != NEW_ADDR &&
-			!is_cold_data(page) &&
-			!IS_ATOMIC_WRITTEN_PAGE(page) &&
-			need_inplace_update(inode, fio))) {
-		f2fs_unlock_op(F2FS_I_SB(inode));
-		fio->cp_rwsem_locked = false;
-		err = rewrite_data_page(fio);
-		set_inode_flag(inode, FI_UPDATE_WRITE);
-		trace_f2fs_do_write_data_page(page, IPU);
+			need_inplace_update_block(fio, page))) {
+		err = do_rewrite_data_page(fio, page);
 	} else {
 		write_data_page(&dn, fio);
 		trace_f2fs_do_write_data_page(page, OPU);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
