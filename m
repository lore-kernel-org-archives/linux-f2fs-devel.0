From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 1/4] f2fs: reconstruct code to write a data page
Date: Tue, 25 Apr 2017 12:45:12 +0000
Message-ID: <20170425124515.160446-2-houpengyang@huawei.com>
References: <20170425124515.160446-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d2zqc-00053G-4x
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 12:45:38 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189]
	helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d2zqZ-0003Fr-J6
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 12:45:38 +0000
In-Reply-To: <20170425124515.160446-1-houpengyang@huawei.com>
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

This patch introduces encrypt_one_page which encrypts one data page before
submit_bio, and change the use of need_inplace_update.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 77 +++++++++++++++++++++++++++++++++----------------------
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/segment.h |  2 +-
 3 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b8dcd1e..02400b0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1302,6 +1302,45 @@ static int f2fs_read_data_pages(struct file *file,
 	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages);
 }
 
+static int encrypt_one_page(struct f2fs_io_info *fio)
+{
+	struct inode *inode = fio->page->mapping->host;
+	gfp_t gfp_flags = GFP_NOFS;
+
+	if (!f2fs_encrypted_inode(inode) || !S_ISREG(inode->i_mode))
+		return 0;
+
+	/* wait for GCed encrypted page writeback */
+	f2fs_wait_on_encrypted_page_writeback(fio->sbi, fio->old_blkaddr);
+
+retry_encrypt:
+	fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page,
+			PAGE_SIZE, 0, fio->page->index, gfp_flags);
+	if (!IS_ERR(fio->encrypted_page))
+		return 0;
+
+	/* flush pending IOs and wait for a while in the ENOMEM case */
+	if (PTR_ERR(fio->encrypted_page) == -ENOMEM) {
+		f2fs_flush_merged_bios(fio->sbi);
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
+		gfp_flags |= __GFP_NOFAIL;
+		goto retry_encrypt;
+	}
+	return PTR_ERR(fio->encrypted_page);
+}
+
+static inline bool need_inplace_update(struct f2fs_io_info *fio)
+{
+	if (fio->old_blkaddr == NEW_ADDR)
+		return false;
+	if (is_cold_data(fio->page))
+		return false;
+	if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
+		return false;
+
+	return need_inplace_update_policy(fio->page->mapping->host, fio);
+}
+
 int do_write_data_page(struct f2fs_io_info *fio)
 {
 	struct page *page = fio->page;
@@ -1322,30 +1361,9 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		goto out_writepage;
 	}
 
-	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
-		gfp_t gfp_flags = GFP_NOFS;
-
-		/* wait for GCed encrypted page writeback */
-		f2fs_wait_on_encrypted_page_writeback(F2FS_I_SB(inode),
-							fio->old_blkaddr);
-retry_encrypt:
-		fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page,
-							PAGE_SIZE, 0,
-							fio->page->index,
-							gfp_flags);
-		if (IS_ERR(fio->encrypted_page)) {
-			err = PTR_ERR(fio->encrypted_page);
-			if (err == -ENOMEM) {
-				/* flush pending ios and wait for a while */
-				f2fs_flush_merged_bios(F2FS_I_SB(inode));
-				congestion_wait(BLK_RW_ASYNC, HZ/50);
-				gfp_flags |= __GFP_NOFAIL;
-				err = 0;
-				goto retry_encrypt;
-			}
-			goto out_writepage;
-		}
-	}
+	err = encrypt_one_page(fio);
+	if (err)
+		goto out_writepage;
 
 	set_page_writeback(page);
 
@@ -1353,15 +1371,14 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (unlikely(fio->old_blkaddr != NEW_ADDR &&
-			!is_cold_data(page) &&
-			!IS_ATOMIC_WRITTEN_PAGE(page) &&
-			need_inplace_update(inode, fio))) {
-		f2fs_unlock_op(F2FS_I_SB(inode));
+	if (need_inplace_update(fio)) {
+		f2fs_bug_on(fio->sbi, !fio->cp_rwsem_locked);
+		f2fs_unlock_op(fio->sbi);
 		fio->cp_rwsem_locked = false;
+
 		err = rewrite_data_page(fio);
+		trace_f2fs_do_write_data_page(fio->page, IPU);
 		set_inode_flag(inode, FI_UPDATE_WRITE);
-		trace_f2fs_do_write_data_page(page, IPU);
 	} else {
 		write_data_page(&dn, fio);
 		trace_f2fs_do_write_data_page(page, OPU);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e7a2b54..a0d9588 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1898,7 +1898,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	int err;
 
 	/* if in-place-update policy is enabled, don't waste time here */
-	if (need_inplace_update(inode, NULL))
+	if (need_inplace_update_policy(inode, NULL))
 		return -EINVAL;
 
 	pg_start = range->start >> PAGE_SHIFT;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 4a85035..2a6b8c1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -561,7 +561,7 @@ enum {
 	F2FS_IPU_ASYNC,
 };
 
-static inline bool need_inplace_update(struct inode *inode,
+static inline bool need_inplace_update_policy(struct inode *inode,
 				struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
