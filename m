From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: wait on page's writeback in writepages path
Date: Fri, 29 Jan 2016 16:52:36 -0800
Message-ID: <1454115158-81227-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Likewise f2fs_write_cache_pages, let's do for node and meta pages too.
Especially, for node blocks, we should do this before marking its fsync
and dentry flags.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 4 +++-
 fs/f2fs/node.c       | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 112e19f..96d606d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -232,7 +232,6 @@ static int f2fs_write_meta_page(struct page *page,
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto redirty_out;
 
-	f2fs_wait_on_page_writeback(page, META, true);
 	write_meta_page(sbi, page);
 	dec_page_count(sbi, F2FS_DIRTY_META);
 	unlock_page(page);
@@ -315,6 +314,9 @@ continue_unlock:
 				goto continue_unlock;
 			}
 
+			f2fs_wait_on_page_writeback(page, META, true);
+
+			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index eae8977..511c0e7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1297,6 +1297,9 @@ continue_unlock:
 				continue;
 			}
 
+			f2fs_wait_on_page_writeback(page, NODE, true);
+
+			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
@@ -1402,8 +1405,6 @@ static int f2fs_write_node_page(struct page *page,
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto redirty_out;
 
-	f2fs_wait_on_page_writeback(page, NODE, true);
-
 	/* get old block addr of this node page */
 	nid = nid_of_node(page);
 	f2fs_bug_on(sbi, page->index != nid);
-- 
2.6.3
