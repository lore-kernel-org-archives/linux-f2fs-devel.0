From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: introduce f2fs_encrypted_file for
 clean-up
Date: Tue,  5 Sep 2017 17:15:49 -0700
Message-ID: <20170906001550.53917-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dpO0d-00058v-H5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Sep 2017 00:15:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dpO0b-0003kP-Bp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Sep 2017 00:15:59 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch replaces (f2fs_encrypted_inode() && S_ISREG()) with
f2fs_encrypted_file(), which gives no functional change.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c   | 10 +++++-----
 fs/f2fs/f2fs.h   |  5 +++++
 fs/f2fs/file.c   |  2 +-
 fs/f2fs/gc.c     |  5 ++---
 fs/f2fs/inline.c |  2 +-
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 67da4f6eeaa0..e6c683e7a10e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -581,7 +581,7 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index,
 		.encrypted_page = NULL,
 	};
 
-	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+	if (f2fs_encrypted_file(inode))
 		return read_mapping_page(mapping, index, NULL);
 
 	page = f2fs_grab_cache_page(mapping, index, for_write);
@@ -786,7 +786,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 
 static inline bool __force_buffered_io(struct inode *inode, int rw)
 {
-	return ((f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) ||
+	return (f2fs_encrypted_file(inode) ||
 			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
 			F2FS_I_SB(inode)->s_ndevs);
 }
@@ -1157,7 +1157,7 @@ static struct bio *f2fs_grab_bio(struct inode *inode, block_t blkaddr,
 	struct fscrypt_ctx *ctx = NULL;
 	struct bio *bio;
 
-	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
+	if (f2fs_encrypted_file(inode)) {
 		ctx = fscrypt_get_ctx(inode, GFP_NOFS);
 		if (IS_ERR(ctx))
 			return ERR_CAST(ctx);
@@ -1345,7 +1345,7 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 	struct inode *inode = fio->page->mapping->host;
 	gfp_t gfp_flags = GFP_NOFS;
 
-	if (!f2fs_encrypted_inode(inode) || !S_ISREG(inode->i_mode))
+	if (!f2fs_encrypted_file(inode))
 		return 0;
 
 	/* wait for GCed encrypted page writeback */
@@ -1974,7 +1974,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	f2fs_wait_on_page_writeback(page, DATA, false);
 
 	/* wait for GCed encrypted page writeback */
-	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+	if (f2fs_encrypted_file(inode))
 		f2fs_wait_on_encrypted_page_writeback(sbi, blkaddr);
 
 	if (len == PAGE_SIZE || PageUptodate(page))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4b993961d81d..417c28f01fd5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2939,6 +2939,11 @@ static inline bool f2fs_encrypted_inode(struct inode *inode)
 	return file_is_encrypt(inode);
 }
 
+static inline bool f2fs_encrypted_file(struct inode *inode)
+{
+	return f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode);
+}
+
 static inline void f2fs_set_encrypted_inode(struct inode *inode)
 {
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 63e394907808..f8cedaba7ce4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -106,7 +106,7 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_wait_on_page_writeback(page, DATA, false);
 
 	/* wait for GCed encrypted page writeback */
-	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+	if (f2fs_encrypted_file(inode))
 		f2fs_wait_on_encrypted_page_writeback(sbi, dn.data_blkaddr);
 
 out_sem:
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b226760afba8..6a12f33d0cdd 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -831,8 +831,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				continue;
 
 			/* if encrypted inode, let's go phase 3 */
-			if (f2fs_encrypted_inode(inode) &&
-						S_ISREG(inode->i_mode)) {
+			if (f2fs_encrypted_file(inode)) {
 				add_gc_inode(gc_list, inode);
 				continue;
 			}
@@ -873,7 +872,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 			start_bidx = start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
-			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+			if (f2fs_encrypted_file(inode))
 				move_encrypted_block(inode, start_bidx, segno, off);
 			else
 				move_data_page(inode, start_bidx, gc_type, segno, off);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e63ab0d1f614..c133a4fdecf6 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -25,7 +25,7 @@ bool f2fs_may_inline_data(struct inode *inode)
 	if (i_size_read(inode) > MAX_INLINE_DATA(inode))
 		return false;
 
-	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+	if (f2fs_encrypted_file(inode))
 		return false;
 
 	return true;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
