From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: introduce FI_ATOMIC_COMMIT
Date: Sat, 7 Jan 2017 18:50:26 +0800
Message-ID: <93594c54-a89b-d69b-d10b-8a44c781b665@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cPocr-0007CP-Ez
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:53:29 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cPocl-00083h-OA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:53:29 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces a new flag to indicate inode status of doing atomic
write committing, so that, we can keep atomic write status for inode
during atomic committing, then we can skip GCing pages of atomic write inode,
that avoids random GCed datas being mixed with current transaction, so
isolation of transaction can be kept.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    |  2 +-
 fs/f2fs/f2fs.h    |  6 ++++++
 fs/f2fs/file.c    | 11 ++++++-----
 fs/f2fs/gc.c      |  6 ++++++
 fs/f2fs/segment.c | 10 +++++++---
 5 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3732a1aae6f7..460d79905ad1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1979,7 +1979,7 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);

-	if (f2fs_is_atomic_file(inode)) {
+	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
 			register_inmem_page(inode, page);
 			return 1;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 841f1d4f6a00..72bff7d42ff5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1643,6 +1643,7 @@ enum {
 	FI_UPDATE_WRITE,	/* inode has in-place-update data */
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
+	FI_ATOMIC_COMMIT,	/* indicate the state of atomical committing */
 	FI_VOLATILE_FILE,	/* indicate volatile file */
 	FI_FIRST_BLOCK_WRITTEN,	/* indicate #0 data block was written */
 	FI_DROP_CACHE,		/* drop dirty page cache */
@@ -1832,6 +1833,11 @@ static inline bool f2fs_is_atomic_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_ATOMIC_FILE);
 }

+static inline bool f2fs_is_commit_atomic_write(struct inode *inode)
+{
+	return is_inode_flag_set(inode, FI_ATOMIC_COMMIT);
+}
+
 static inline bool f2fs_is_volatile_file(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_VOLATILE_FILE);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6c335180b9d8..e45522115b1c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1569,14 +1569,15 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		goto err_out;

 	if (f2fs_is_atomic_file(inode)) {
-		clear_inode_flag(inode, FI_ATOMIC_FILE);
 		ret = commit_inmem_pages(inode);
-		if (ret) {
-			set_inode_flag(inode, FI_ATOMIC_FILE);
+		if (ret)
 			goto err_out;
-		}
+
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
-		stat_dec_atomic_write(inode);
+		if (!ret) {
+			clear_inode_flag(inode, FI_ATOMIC_FILE);
+			stat_dec_atomic_write(inode);
+		}
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 	}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f911a52470bb..357a78e72c87 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -571,6 +571,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;

+	if (f2fs_is_atomic_file(inode))
+		goto out;
+
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
 	if (err)
@@ -663,6 +666,9 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;

+	if (f2fs_is_atomic_file(inode))
+		goto out;
+
 	if (gc_type == BG_GC) {
 		if (PageWriteback(page))
 			goto out;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fb7e591e62dc..fa8c0ae87d47 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -242,12 +242,12 @@ void drop_inmem_pages(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);

-	clear_inode_flag(inode, FI_ATOMIC_FILE);
-	stat_dec_atomic_write(inode);
-
 	mutex_lock(&fi->inmem_lock);
 	__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
 	mutex_unlock(&fi->inmem_lock);
+
+	clear_inode_flag(inode, FI_ATOMIC_FILE);
+	stat_dec_atomic_write(inode);
 }

 static int __commit_inmem_pages(struct inode *inode,
@@ -316,6 +316,8 @@ int commit_inmem_pages(struct inode *inode)
 	f2fs_balance_fs(sbi, true);
 	f2fs_lock_op(sbi);

+	set_inode_flag(inode, FI_ATOMIC_COMMIT);
+
 	mutex_lock(&fi->inmem_lock);
 	err = __commit_inmem_pages(inode, &revoke_list);
 	if (err) {
@@ -337,6 +339,8 @@ int commit_inmem_pages(struct inode *inode)
 	}
 	mutex_unlock(&fi->inmem_lock);

+	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
+
 	f2fs_unlock_op(sbi);
 	return err;
 }
-- 
2.8.2.295.g3f1c1d0



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
