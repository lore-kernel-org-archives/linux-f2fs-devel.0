From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix wrong BUG_ON condition
Date: Tue, 20 Aug 2013 19:46:04 +0900
Message-ID: <1376995564-8691-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch removes a false-alaramed BUG_ON.
The previous BUG_ON condition didn't cover the following true scenario.

In f2fs_add_link, 1) get_new_data_page gives an uptodate page successfully,
and then, 2) init_inode_metadata returns -ENOSPC.
At this moment, a new clean data page is remained in the page cache, but its
block address still indicates NEW_ADDR.
After then, even if sync is called, this clean data page cannot be written to
the disk due to the clean state.

So this means that get_lock_data_page should make a new empty page when its
block address is NEW_ADDR and its page is not uptodated.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ea3cb29..6b328de 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -259,8 +259,17 @@ repeat:
 	if (PageUptodate(page))
 		return page;
 
-	BUG_ON(dn.data_blkaddr == NEW_ADDR);
-	BUG_ON(dn.data_blkaddr == NULL_ADDR);
+	/*
+	 * A new dentry page is allocated but not able to be written, since its
+	 * new inode page couldn't be allocated due to -ENOSPC.
+	 * In such the case, its blkaddr can be remained as NEW_ADDR.
+	 * see, f2fs_add_link -> get_new_data_page -> init_inode_metadata.
+	 */
+	if (dn.data_blkaddr == NEW_ADDR) {
+		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
+		SetPageUptodate(page);
+		return page;
+	}
 
 	err = f2fs_readpage(sbi, page, dn.data_blkaddr, READ_SYNC);
 	if (err)
-- 
1.8.3.1.437.g0dbd812

