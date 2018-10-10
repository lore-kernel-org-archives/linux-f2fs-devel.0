From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: clear cold data flag if IO is not counted
Date: Wed, 10 Oct 2018 14:22:17 -0700
Message-ID: <20181010212217.52289-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we clear the cold data flag out of the writeback flow, we can miscount
-1 by end_io.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 29a9d3b8f709..4102799b5558 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2636,10 +2636,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 
-	/* don't remain PG_checked flag which was set during GC */
-	if (is_cold_data(page))
-		clear_cold_data(page);
-
 	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
 			f2fs_register_inmem_page(inode, page);
-- 
2.19.0.605.g01d371f741-goog
