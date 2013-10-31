From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: avoid to wait all the node blocks during fsync
Date: Thu, 31 Oct 2013 16:51:31 +0900
Message-ID: <1383205891-25065-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, f2fs_sync_file() waits for all the node blocks to be written.
But, we don't need to do that, but wait only the inode-related node blocks.

This patch adds wait_on_node_pages_writeback() in which waits inode-related
node blocks that are on writeback.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c |  5 +++--
 fs/f2fs/node.c | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6aaefdb..625eb4b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1026,6 +1026,7 @@ void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
 int get_dnode_of_data(struct dnode_of_data *, pgoff_t, int);
 int truncate_inode_blocks(struct inode *, pgoff_t);
 int truncate_xattr_node(struct inode *, struct page *);
+int wait_on_node_pages_writeback(struct f2fs_sb_info *, nid_t);
 int remove_inode_page(struct inode *);
 struct page *new_inode_page(struct inode *, const struct qstr *);
 struct page *new_node_page(struct dnode_of_data *, unsigned int, struct page *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 58ed19a..7d714f4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -189,8 +189,9 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 			if (ret)
 				goto out;
 		}
-		filemap_fdatawait_range(sbi->node_inode->i_mapping,
-							0, LONG_MAX);
+		ret = wait_on_node_pages_writeback(sbi, inode->i_ino);
+		if (ret)
+			goto out;
 		ret = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
 	}
 out:
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8e331d5..b527ed4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1148,6 +1148,46 @@ continue_unlock:
 	return nwritten;
 }
 
+int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	struct address_space *mapping = sbi->node_inode->i_mapping;
+	pgoff_t index = 0, end = LONG_MAX;
+	struct pagevec pvec;
+	int nr_pages;
+	int ret2 = 0, ret = 0;
+
+	pagevec_init(&pvec, 0);
+	while ((index <= end) &&
+			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+			PAGECACHE_TAG_WRITEBACK,
+			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1)) != 0) {
+		unsigned i;
+
+		for (i = 0; i < nr_pages; i++) {
+			struct page *page = pvec.pages[i];
+
+			/* until radix tree lookup accepts end_index */
+			if (page->index > end)
+				continue;
+
+			if (ino && ino_of_node(page) == ino)
+				wait_on_page_writeback(page);
+			if (TestClearPageError(page))
+				ret = -EIO;
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+
+	if (test_and_clear_bit(AS_ENOSPC, &mapping->flags))
+		ret2 = -ENOSPC;
+	if (test_and_clear_bit(AS_EIO, &mapping->flags))
+		ret2 = -EIO;
+	if (!ret)
+		ret = ret2;
+	return ret;
+}
+
 static int f2fs_write_node_page(struct page *page,
 				struct writeback_control *wbc)
 {
-- 
1.8.4.474.g128a96c
