From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 1/3] f2fs: reconstruct code to write a data page
Date: Fri, 21 Apr 2017 09:56:33 +0000
Message-ID: <20170421095635.101454-2-houpengyang@huawei.com>
References: <20170421095635.101454-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d1VKR-0000QA-AW
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 09:58:15 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d1VJX-0001o5-9x
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 09:58:15 +0000
In-Reply-To: <20170421095635.101454-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch introduces two functions:

	1) f2fs_encrypt_page -- encrypt data page before submit_bio
	2) do_rewrite_data_page -- IPU rewrite

The two functions are extraced from do_write_data_page, logic in
do_write_data_page stays unchanged.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/data.c | 66 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b8dcd1e..4ba11a6 100644
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
 
@@ -1343,9 +1328,50 @@ int do_write_data_page(struct f2fs_io_info *fio)
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
+	if (f2fs_encrypt_page(fio, page))
+		goto out_writepage;
 
 	set_page_writeback(page);
 
@@ -1357,11 +1383,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			!is_cold_data(page) &&
 			!IS_ATOMIC_WRITTEN_PAGE(page) &&
 			need_inplace_update(inode, fio))) {
-		f2fs_unlock_op(F2FS_I_SB(inode));
-		fio->cp_rwsem_locked = false;
-		err = rewrite_data_page(fio);
-		set_inode_flag(inode, FI_UPDATE_WRITE);
-		trace_f2fs_do_write_data_page(page, IPU);
+		err = do_rewrite_data_page(fio, page);
 	} else {
 		write_data_page(&dn, fio);
 		trace_f2fs_do_write_data_page(page, OPU);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
