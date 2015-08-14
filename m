From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: handle failed bio allocation
Date: Fri, 14 Aug 2015 16:09:10 -0700
Message-ID: <1439593751-21879-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As the below comment of bio_alloc_bioset, f2fs can allocate multiple bios at the
same time. So, we can't guarantee that bio is allocated all the time.

"
 *   When @bs is not NULL, if %__GFP_WAIT is set then bio_alloc will always be
 *   able to allocate a bio. This is due to the mempool guarantees. To make this
 *   work, callers must never allocate more than 1 bio at a time from this pool.
 *   Callers that need to allocate more than 1 bio must always submit the
 *   previously allocated bio for IO before attempting to allocate a new one.
 *   Failure to do so can cause deadlocks under memory pressure.
"

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  3 +--
 fs/f2fs/f2fs.h    | 15 +++++++++++++++
 fs/f2fs/segment.c | 14 +++++++++++---
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cad9ebe..726e58b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -90,8 +90,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 {
 	struct bio *bio;
 
-	/* No failure on bio allocation */
-	bio = bio_alloc(GFP_NOIO, npages);
+	bio = f2fs_bio_alloc(npages);
 
 	bio->bi_bdev = sbi->sb->s_bdev;
 	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(blk_addr);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 23bfc0c..a55169a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -19,6 +19,7 @@
 #include <linux/magic.h>
 #include <linux/kobject.h>
 #include <linux/sched.h>
+#include <linux/bio.h>
 
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
@@ -1253,6 +1254,20 @@ retry:
 	return entry;
 }
 
+static inline struct bio *f2fs_bio_alloc(int npages)
+{
+	struct bio *bio;
+
+	/* No failure on bio allocation */
+retry:
+	bio = bio_alloc(GFP_NOIO, npages);
+	if (!bio) {
+		cond_resched();
+		goto retry;
+	}
+	return bio;
+}
+
 static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
 				unsigned long index, void *item)
 {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1b42656..6d919fe 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -330,10 +330,12 @@ repeat:
 		return 0;
 
 	if (!llist_empty(&fcc->issue_list)) {
-		struct bio *bio = bio_alloc(GFP_NOIO, 0);
+		struct bio *bio;
 		struct flush_cmd *cmd, *next;
 		int ret;
 
+		bio = f2fs_bio_alloc(0);
+
 		fcc->dispatch_list = llist_del_all(&fcc->issue_list);
 		fcc->dispatch_list = llist_reverse_order(fcc->dispatch_list);
 
@@ -365,8 +367,14 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	if (test_opt(sbi, NOBARRIER))
 		return 0;
 
-	if (!test_opt(sbi, FLUSH_MERGE))
-		return blkdev_issue_flush(sbi->sb->s_bdev, GFP_KERNEL, NULL);
+	if (!test_opt(sbi, FLUSH_MERGE)) {
+		struct bio *bio = f2fs_bio_alloc(0);
+		int ret;
+
+		ret = submit_bio_wait(WRITE_FLUSH, bio);
+		bio_put(bio);
+		return ret;
+	}
 
 	init_completion(&cmd.wait);
 
-- 
2.1.1

