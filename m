From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: introduce valid_ipu_blkaddr to clean up
Date: Tue, 25 Apr 2017 14:46:24 -0700
Message-ID: <20170425214624.5027-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d38I5-0006aC-Rn
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 21:46:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d38I5-0007yX-49
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 21:46:33 +0000
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

This patch introduces valid_ipu_blkaddr to clean up checking block address for
inplace-update.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b2992dbdd11e..c2b98e44c5f3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1331,8 +1331,6 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 
 static inline bool need_inplace_update(struct f2fs_io_info *fio)
 {
-	if (fio->old_blkaddr == NEW_ADDR)
-		return false;
 	if (is_cold_data(fio->page))
 		return false;
 	if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
@@ -1341,6 +1339,15 @@ static inline bool need_inplace_update(struct f2fs_io_info *fio)
 	return need_inplace_update_policy(fio->page->mapping->host, fio);
 }
 
+static inline bool valid_ipu_blkaddr(struct f2fs_io_info *fio)
+{
+	if (fio->old_blkaddr == NEW_ADDR)
+		return false;
+	if (fio->old_blkaddr == NULL_ADDR)
+		return false;
+	return true;
+}
+
 int do_write_data_page(struct f2fs_io_info *fio)
 {
 	struct page *page = fio->page;
@@ -1354,8 +1361,8 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	if (need_inplace_update(fio) &&
 			f2fs_lookup_extent_cache(inode, page->index, &ei)) {
 		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
-		if (fio->old_blkaddr != NULL_ADDR &&
-				fio->old_blkaddr != NEW_ADDR) {
+
+		if (valid_ipu_blkaddr(fio)) {
 			ipu_force = true;
 			goto got_it;
 		}
@@ -1382,7 +1389,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (ipu_force || need_inplace_update(fio)) {
+	if (ipu_force || (valid_ipu_blkaddr(fio) && need_inplace_update(fio))) {
 		f2fs_bug_on(fio->sbi, fio->cp_rwsem_locked);
 		f2fs_put_dnode(&dn);
 		err = rewrite_data_page(fio);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
