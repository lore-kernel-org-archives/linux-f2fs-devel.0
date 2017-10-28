From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: support get_page error injection
Date: Sat, 28 Oct 2017 16:52:30 +0800
Message-ID: <20171028085233.34488-2-yuchao0@huawei.com>
References: <20171028085233.34488-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e8MrZ-0002QO-1F
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 08:53:05 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e8MrX-0001pz-9u
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 08:53:04 +0000
In-Reply-To: <20171028085233.34488-1-yuchao0@huawei.com>
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

This patch adds to support get_page error injection to simulate
out-of-memory test scenario.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c  |  2 +-
 fs/f2fs/f2fs.h  | 14 ++++++++++++++
 fs/f2fs/gc.c    |  4 ++--
 fs/f2fs/node.c  |  3 ++-
 fs/f2fs/super.c |  1 +
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5259e81f288b..7099f1d51bab 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1958,7 +1958,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	 * Do not use grab_cache_page_write_begin() to avoid deadlock due to
 	 * wait_for_stable_page. Will wait that below with our IO control.
 	 */
-	page = pagecache_get_page(mapping, index,
+	page = f2fs_pagecache_get_page(mapping, index,
 				FGP_LOCK | FGP_WRITE | FGP_CREAT, GFP_NOFS);
 	if (!page) {
 		err = -ENOMEM;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e93e922ff66d..6d2984abc50f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -46,6 +46,7 @@
 enum {
 	FAULT_KMALLOC,
 	FAULT_PAGE_ALLOC,
+	FAULT_PAGE_GET,
 	FAULT_ALLOC_NID,
 	FAULT_ORPHAN,
 	FAULT_BLOCK,
@@ -1843,6 +1844,19 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 	return grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
 }
 
+static inline struct page *f2fs_pagecache_get_page(
+				struct address_space *mapping, pgoff_t index,
+				int fgp_flags, gfp_t gfp_mask)
+{
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET)) {
+		f2fs_show_injection_info(FAULT_PAGE_GET);
+		return NULL;
+	}
+#endif
+	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
+}
+
 static inline void f2fs_copy_page(struct page *src, struct page *dst)
 {
 	char *src_kaddr = kmap(src);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 197ebf45e4e4..c7b1d704846a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -650,8 +650,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
 					&sum, CURSEG_COLD_DATA, NULL, false);
 
-	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi), newaddr,
-					FGP_LOCK | FGP_CREAT, GFP_NOFS);
+	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
+				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
 	if (!fio.encrypted_page) {
 		err = -ENOMEM;
 		goto recover_block;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ba669f7ce0ae..e5f7a260737c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1216,7 +1216,8 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	if (!inode)
 		return;
 
-	page = pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);
+	page = f2fs_pagecache_get_page(inode->i_mapping, 0,
+					FGP_LOCK|FGP_NOWAIT, 0);
 	if (!page)
 		goto iput_out;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 03c115f3cd7a..02d98401c52b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -44,6 +44,7 @@ static struct kmem_cache *f2fs_inode_cachep;
 char *fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
 	[FAULT_PAGE_ALLOC]	= "page alloc",
+	[FAULT_PAGE_GET]	= "page get",
 	[FAULT_ALLOC_NID]	= "alloc nid",
 	[FAULT_ORPHAN]		= "orphan",
 	[FAULT_BLOCK]		= "no more block",
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
