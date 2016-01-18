From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 1/4] f2fs: relocate is_merged_page
Date: Mon, 18 Jan 2016 18:24:59 +0800
Message-ID: <01ab01d151da$9b9b1f50$d2d15df0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Operations in is_merged_page is related to inner bio cache, move it to
data.c.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c    | 38 ++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 38 --------------------------------------
 3 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac9e7c6..b118055 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -116,6 +116,44 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	io->bio = NULL;
 }
 
+bool is_merged_page(struct f2fs_sb_info *sbi, struct page *page,
+							enum page_type type)
+{
+	enum page_type btype = PAGE_TYPE_OF_BIO(type);
+	struct f2fs_bio_info *io = &sbi->write_io[btype];
+	struct bio_vec *bvec;
+	struct page *target;
+	int i;
+
+	down_read(&io->io_rwsem);
+	if (!io->bio) {
+		up_read(&io->io_rwsem);
+		return false;
+	}
+
+	bio_for_each_segment_all(bvec, io->bio, i) {
+
+		if (bvec->bv_page->mapping) {
+			target = bvec->bv_page;
+		} else {
+			struct f2fs_crypto_ctx *ctx;
+
+			/* encrypted page */
+			ctx = (struct f2fs_crypto_ctx *)page_private(
+								bvec->bv_page);
+			target = ctx->w.control_page;
+		}
+
+		if (page == target) {
+			up_read(&io->io_rwsem);
+			return true;
+		}
+	}
+
+	up_read(&io->io_rwsem);
+	return false;
+}
+
 void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 				enum page_type type, int rw)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2c0e478..79cadd3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1882,6 +1882,7 @@ void destroy_checkpoint_caches(void);
 /*
  * data.c
  */
+bool is_merged_page(struct f2fs_sb_info *, struct page *, enum page_type);
 void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, int);
 int f2fs_submit_page_bio(struct f2fs_io_info *);
 void f2fs_submit_page_mbio(struct f2fs_io_info *);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5904a41..e16235b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1415,44 +1415,6 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 	f2fs_update_extent_cache(dn);
 }
 
-static inline bool is_merged_page(struct f2fs_sb_info *sbi,
-					struct page *page, enum page_type type)
-{
-	enum page_type btype = PAGE_TYPE_OF_BIO(type);
-	struct f2fs_bio_info *io = &sbi->write_io[btype];
-	struct bio_vec *bvec;
-	struct page *target;
-	int i;
-
-	down_read(&io->io_rwsem);
-	if (!io->bio) {
-		up_read(&io->io_rwsem);
-		return false;
-	}
-
-	bio_for_each_segment_all(bvec, io->bio, i) {
-
-		if (bvec->bv_page->mapping) {
-			target = bvec->bv_page;
-		} else {
-			struct f2fs_crypto_ctx *ctx;
-
-			/* encrypted page */
-			ctx = (struct f2fs_crypto_ctx *)page_private(
-								bvec->bv_page);
-			target = ctx->w.control_page;
-		}
-
-		if (page == target) {
-			up_read(&io->io_rwsem);
-			return true;
-		}
-	}
-
-	up_read(&io->io_rwsem);
-	return false;
-}
-
 void f2fs_wait_on_page_writeback(struct page *page,
 				enum page_type type)
 {
-- 
2.6.3
