From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: consider fallocated space for SEEK_DATA
Date: Mon, 28 Apr 2014 18:48:49 +0900
Message-ID: <1398678529-11067-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1398678529-11067-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1398678529-11067-1-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

If an amount of data are allocated though fallocate and user writes a couple of
data among the space, f2fs should return the data offset made by user when
SEEK_DATA is requested.

For example, (N: NEW_ADDR by fallocate, X: NEW_ADDR by user)
1) fallocate 0 ~ 10MB
f -> N N N N N N N N N N N N ... N

2) write 4KB at 5MB offset
f -> N N N N N X N N N N N N ... N

3) SEEK_DATA from 0 should return 5MB offset

So, this patch adds a routine to search the first dirty page to handle that.
Then, the SEEK_DATA flow skips NEW_ADDR offsets until any dirty page is found.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/file.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3112857..b9f4fbf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -19,6 +19,7 @@
 #include <linux/compat.h>
 #include <linux/uaccess.h>
 #include <linux/mount.h>
+#include <linux/pagevec.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -194,13 +195,48 @@ out:
 	return ret;
 }
 
+static pgoff_t __get_first_dirty_index(struct address_space *mapping,
+						pgoff_t pgofs, int whence)
+{
+	struct pagevec pvec;
+	int nr_pages;
+
+	if (whence != SEEK_DATA)
+		return 0;
+
+	/* find first dirty page index */
+	pagevec_init(&pvec, 0);
+	nr_pages = pagevec_lookup_tag(&pvec, mapping, &pgofs, PAGECACHE_TAG_DIRTY, 1);
+	pgofs = nr_pages ? pvec.pages[0]->index: LONG_MAX;
+	pagevec_release(&pvec);
+	return pgofs;
+}
+
+static bool __found_offset(block_t blkaddr, pgoff_t dirty, pgoff_t pgofs,
+							int whence)
+{
+	switch (whence) {
+	case SEEK_DATA:
+		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
+			(blkaddr != NEW_ADDR && blkaddr != NULL_ADDR))
+			return true;
+		break;
+	case SEEK_HOLE:
+		if (blkaddr == NULL_ADDR)
+			return true;
+		break;
+	}
+	return false;
+}
+
 static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
 	loff_t maxbytes = inode->i_sb->s_maxbytes;
 	struct dnode_of_data dn;
-	pgoff_t pgofs, end_offset;
-	loff_t data_ofs = offset, isize;
+	pgoff_t pgofs, end_offset, dirty;
+	loff_t data_ofs = offset;
+	loff_t isize;
 	int err = 0;
 
 	mutex_lock(&inode->i_mutex);
@@ -218,6 +254,8 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 
 	pgofs = (pgoff_t)(offset >> PAGE_CACHE_SHIFT);
 
+	dirty = __get_first_dirty_index(inode->i_mapping, pgofs, whence);
+
 	for (; data_ofs < isize; data_ofs = pgofs << PAGE_CACHE_SHIFT) {
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = get_dnode_of_data(&dn, pgofs, LOOKUP_NODE_RA);
@@ -244,8 +282,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 			block_t blkaddr;
 			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
 
-			if ((whence == SEEK_DATA && blkaddr != NULL_ADDR) ||
-				(whence == SEEK_HOLE && blkaddr == NULL_ADDR)) {
+			if (__found_offset(blkaddr, dirty, pgofs, whence)) {
 				f2fs_put_dnode(&dn);
 				goto found;
 			}
-- 
1.8.4.474.g128a96c

