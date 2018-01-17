From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs: split need_inplace_update
Date: Wed, 17 Jan 2018 16:31:38 +0800
Message-ID: <20180117083138.27755-4-yuchao0@huawei.com>
References: <20180117083138.27755-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1ebj8n-00043k-Q4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jan 2018 08:32:13 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ebj8l-0000av-GE
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jan 2018 08:32:13 +0000
In-Reply-To: <20180117083138.27755-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch splits need_inplace_update to two functions:
a. should_update_inplace() includes all conditions that we must use IPU.
b. should_update_outplace() includes all conditions that we must use OPU.

So that, in f2fs_ioc_set_pin_file() and f2fs_defragment_range(), we can
use corresponding function to check whether we can trigger OPU/IPU or not.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    | 75 +++++++++++++++++++++++++++++++++++++++++++++++++------
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/file.c    |  7 +++++-
 fs/f2fs/segment.h | 41 ------------------------------
 4 files changed, 75 insertions(+), 50 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 28c03ea27954..f93ae2d883b9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1518,20 +1518,79 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 	return PTR_ERR(fio->encrypted_page);
 }
 
-static inline bool need_inplace_update(struct f2fs_io_info *fio)
+static inline bool check_inplace_update_policy(struct inode *inode,
+				struct f2fs_io_info *fio)
 {
-	struct inode *inode = fio->page->mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int policy = SM_I(sbi)->ipu_policy;
 
+	if (policy & (0x1 << F2FS_IPU_FORCE))
+		return true;
+	if (policy & (0x1 << F2FS_IPU_SSR) && need_SSR(sbi))
+		return true;
+	if (policy & (0x1 << F2FS_IPU_UTIL) &&
+			utilization(sbi) > SM_I(sbi)->min_ipu_util)
+		return true;
+	if (policy & (0x1 << F2FS_IPU_SSR_UTIL) && need_SSR(sbi) &&
+			utilization(sbi) > SM_I(sbi)->min_ipu_util)
+		return true;
+
+	/*
+	 * IPU for rewrite async pages
+	 */
+	if (policy & (0x1 << F2FS_IPU_ASYNC) &&
+			fio && fio->op == REQ_OP_WRITE &&
+			!(fio->op_flags & REQ_SYNC) &&
+			!f2fs_encrypted_inode(inode))
+		return true;
+
+	/* this is only set during fdatasync */
+	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
+			is_inode_flag_set(inode, FI_NEED_IPU))
+		return true;
+
+	return false;
+}
+
+bool should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
+{
 	if (f2fs_is_pinned_file(inode))
 		return true;
-	if (S_ISDIR(inode->i_mode) || f2fs_is_atomic_file(inode))
-		return false;
-	if (is_cold_data(fio->page))
-		return false;
-	if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
+
+	/* if this is cold file, we should overwrite to avoid fragmentation */
+	if (file_is_cold(inode))
+		return true;
+
+	return check_inplace_update_policy(inode, fio);
+}
+
+bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (test_opt(sbi, LFS))
+		return true;
+	if (S_ISDIR(inode->i_mode))
+		return true;
+	if (f2fs_is_atomic_file(inode))
+		return true;
+	if (fio) {
+		if (is_cold_data(fio->page))
+			return true;
+		if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
+			return true;
+	}
+	return false;
+}
+
+static inline bool need_inplace_update(struct f2fs_io_info *fio)
+{
+	struct inode *inode = fio->page->mapping->host;
+
+	if (should_update_outplace(inode, fio))
 		return false;
 
-	return need_inplace_update_policy(inode, fio);
+	return should_update_inplace(inode, fio);
 }
 
 static inline bool valid_ipu_blkaddr(struct f2fs_io_info *fio)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 75df68651607..5396583b7c85 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2840,6 +2840,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			int create, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
+bool should_update_inplace(struct inode *inode, struct f2fs_io_info *fio);
+bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio);
 void f2fs_set_page_dirty_nobuffers(struct page *page);
 int __f2fs_write_data_pages(struct address_space *mapping,
 						struct writeback_control *wbc,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f516dea01d0e..9876ad396a7b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2081,7 +2081,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	int err;
 
 	/* if in-place-update policy is enabled, don't waste time here */
-	if (need_inplace_update_policy(inode, NULL))
+	if (should_update_inplace(inode, NULL))
 		return -EINVAL;
 
 	pg_start = range->start >> PAGE_SHIFT;
@@ -2714,6 +2714,11 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
+	if (should_update_outplace(inode, NULL)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!pin) {
 		clear_inode_flag(inode, FI_PIN_FILE);
 		F2FS_I(inode)->i_gc_failures = 1;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 71a2aaa286df..1a807e6e7c97 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -580,47 +580,6 @@ enum {
 	F2FS_IPU_ASYNC,
 };
 
-static inline bool need_inplace_update_policy(struct inode *inode,
-				struct f2fs_io_info *fio)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	unsigned int policy = SM_I(sbi)->ipu_policy;
-
-	if (test_opt(sbi, LFS))
-		return false;
-
-	/* if this is cold file, we should overwrite to avoid fragmentation */
-	if (file_is_cold(inode))
-		return true;
-
-	if (policy & (0x1 << F2FS_IPU_FORCE))
-		return true;
-	if (policy & (0x1 << F2FS_IPU_SSR) && need_SSR(sbi))
-		return true;
-	if (policy & (0x1 << F2FS_IPU_UTIL) &&
-			utilization(sbi) > SM_I(sbi)->min_ipu_util)
-		return true;
-	if (policy & (0x1 << F2FS_IPU_SSR_UTIL) && need_SSR(sbi) &&
-			utilization(sbi) > SM_I(sbi)->min_ipu_util)
-		return true;
-
-	/*
-	 * IPU for rewrite async pages
-	 */
-	if (policy & (0x1 << F2FS_IPU_ASYNC) &&
-			fio && fio->op == REQ_OP_WRITE &&
-			!(fio->op_flags & REQ_SYNC) &&
-			!f2fs_encrypted_inode(inode))
-		return true;
-
-	/* this is only set during fdatasync */
-	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
-			is_inode_flag_set(inode, FI_NEED_IPU))
-		return true;
-
-	return false;
-}
-
 static inline unsigned int curseg_segno(struct f2fs_sb_info *sbi,
 		int type)
 {
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
