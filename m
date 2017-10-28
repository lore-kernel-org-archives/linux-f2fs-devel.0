From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/5] f2fs: support bio allocation error injection
Date: Sat, 28 Oct 2017 16:52:31 +0800
Message-ID: <20171028085233.34488-3-yuchao0@huawei.com>
References: <20171028085233.34488-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e8MrZ-0002QV-6O
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 08:53:05 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e8MrX-0006aI-Js
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 08:53:05 +0000
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

This patch adds to support bio allocation error injection to simulate
out-of-memory test scenario.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    |  4 ++--
 fs/f2fs/f2fs.h    | 23 +++++++++++++++++------
 fs/f2fs/segment.c |  2 +-
 fs/f2fs/super.c   |  1 +
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7099f1d51bab..c5c926246658 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -172,7 +172,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 {
 	struct bio *bio;
 
-	bio = f2fs_bio_alloc(npages);
+	bio = f2fs_bio_alloc(sbi, npages, true);
 
 	f2fs_target_device(sbi, blk_addr, bio);
 	bio->bi_end_io = is_read ? f2fs_read_end_io : f2fs_write_end_io;
@@ -472,7 +472,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		f2fs_wait_on_block_writeback(sbi, blkaddr);
 	}
 
-	bio = bio_alloc(GFP_KERNEL, min_t(int, nr_pages, BIO_MAX_PAGES));
+	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
 	if (!bio) {
 		if (ctx)
 			fscrypt_release_ctx(ctx);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d2984abc50f..ddcd8f876938 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -47,6 +47,7 @@ enum {
 	FAULT_KMALLOC,
 	FAULT_PAGE_ALLOC,
 	FAULT_PAGE_GET,
+	FAULT_ALLOC_BIO,
 	FAULT_ALLOC_NID,
 	FAULT_ORPHAN,
 	FAULT_BLOCK,
@@ -1906,15 +1907,25 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
 	return entry;
 }
 
-static inline struct bio *f2fs_bio_alloc(int npages)
+static inline struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi,
+						int npages, bool no_fail)
 {
 	struct bio *bio;
 
-	/* No failure on bio allocation */
-	bio = bio_alloc(GFP_NOIO, npages);
-	if (!bio)
-		bio = bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
-	return bio;
+	if (no_fail) {
+		/* No failure on bio allocation */
+		bio = bio_alloc(GFP_NOIO, npages);
+		if (!bio)
+			bio = bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
+		return bio;
+	}
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
+		f2fs_show_injection_info(FAULT_ALLOC_BIO);
+		return NULL;
+	}
+#endif
+	return bio_alloc(GFP_KERNEL, npages);
 }
 
 static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2fe3343d876c..f75685418d9f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -473,7 +473,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 				struct block_device *bdev)
 {
-	struct bio *bio = f2fs_bio_alloc(0);
+	struct bio *bio = f2fs_bio_alloc(sbi, 0, true);
 	int ret;
 
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 02d98401c52b..957e80602a7d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -45,6 +45,7 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
 	[FAULT_PAGE_ALLOC]	= "page alloc",
 	[FAULT_PAGE_GET]	= "page get",
+	[FAULT_ALLOC_BIO]	= "alloc bio",
 	[FAULT_ALLOC_NID]	= "alloc nid",
 	[FAULT_ORPHAN]		= "orphan",
 	[FAULT_BLOCK]		= "no more block",
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
