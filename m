From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: return AOP_WRITEPAGE_ACTIVATE for writepage
Date: Thu,  1 Dec 2016 00:21:30 -0800
Message-ID: <20161201082130.23414-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

We should use AOP_WRITEPAGE_ACTIVATE when we bypass writing pages.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c5b63bda68b..b90fb010a991 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1384,6 +1384,8 @@ static int f2fs_write_data_page(struct page *page,
 
 redirty_out:
 	redirty_page_for_writepage(wbc, page);
+	if (!err)
+		return AOP_WRITEPAGE_ACTIVATE;
 	unlock_page(page);
 	return err;
 }
@@ -1479,6 +1481,15 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 
 			ret = mapping->a_ops->writepage(page, wbc);
 			if (unlikely(ret)) {
+				/*
+				 * keep nr_to_write, since vfs uses this to
+				 * get # of written pages.
+				 */
+				if (ret == AOP_WRITEPAGE_ACTIVATE) {
+					unlock_page(page);
+					ret = 0;
+					continue;
+				}
 				done_index = page->index + 1;
 				done = 1;
 				break;
-- 
2.11.0
