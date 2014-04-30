From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/4] f2fs: avoid grab_cache_page_write_begin for data pages
Date: Wed, 30 Apr 2014 11:33:41 +0900
Message-ID: <1398825223-23062-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1398825223-23062-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1398825223-23062-1-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao2.yu@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We don't need to wait on page writeback for these cases.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c   | 4 ++--
 fs/f2fs/inline.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 273fe16..91ff104 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -417,7 +417,7 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 	if (unlikely(dn.data_blkaddr == NEW_ADDR))
 		return ERR_PTR(-EINVAL);
 
-	page = grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
+	page = grab_cache_page(mapping, index);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -455,7 +455,7 @@ struct page *get_lock_data_page(struct inode *inode, pgoff_t index)
 	int err;
 
 repeat:
-	page = grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
+	page = grab_cache_page(mapping, index);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8bf34f0..1bba522 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -95,6 +95,7 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 	if (err)
 		goto out;
 
+	f2fs_wait_on_page_writeback(page, DATA);
 	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
 
 	/* Copy the whole inline data block */
@@ -133,7 +134,7 @@ int f2fs_convert_inline_data(struct inode *inode, pgoff_t to_size)
 	else if (to_size <= MAX_INLINE_DATA)
 		return 0;
 
-	page = grab_cache_page_write_begin(inode->i_mapping, 0, AOP_FLAG_NOFS);
+	page = grab_cache_page(inode->i_mapping, 0);
 	if (!page)
 		return -ENOMEM;
 
-- 
1.8.4.474.g128a96c

