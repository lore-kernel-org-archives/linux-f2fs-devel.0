From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: disable the extent cache ops on high fragmented files
Date: Tue, 19 Nov 2013 16:10:36 +0900
Message-ID: <1384845037-7872-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

The f2fs manages an extent cache to search a number of consecutive data blocks
very quickly.

However it conducts unnecessary cache operations if the file is highly
fragmented with no valid extent cache.

In such the case, we don't need to handle the extent cache, but just can disable
the cache facility.

Nevertheless, this patch gives one more chance to enable the extent cache.

For example,
1. create a file
2. write data sequentially which produces a large valid extent cache
3. update some data, resulting in a fragmented extent
4. if the fragmented extent is too small, then drop extent cache
5. close the file

6. open the file again
7. give another chance to make a new extent cache
8. write data sequentially again which creates another big extent cache.
...

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 22 ++++++++++++++++++----
 fs/f2fs/f2fs.h |  3 +++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5920639..2e54522 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -71,6 +71,9 @@ static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
 	pgoff_t start_fofs, end_fofs;
 	block_t start_blkaddr;
 
+	if (is_inode_flag_set(fi, FI_NO_EXTENT))
+		return 0;
+
 	read_lock(&fi->ext.ext_lock);
 	if (fi->ext.len == 0) {
 		read_unlock(&fi->ext.ext_lock);
@@ -109,6 +112,7 @@ void update_extent_cache(block_t blk_addr, struct dnode_of_data *dn)
 	struct f2fs_inode_info *fi = F2FS_I(dn->inode);
 	pgoff_t fofs, start_fofs, end_fofs;
 	block_t start_blkaddr, end_blkaddr;
+	int need_update = true;
 
 	f2fs_bug_on(blk_addr == NEW_ADDR);
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
@@ -117,6 +121,9 @@ void update_extent_cache(block_t blk_addr, struct dnode_of_data *dn)
 	/* Update the page address in the parent node */
 	__set_data_blkaddr(dn, blk_addr);
 
+	if (is_inode_flag_set(fi, FI_NO_EXTENT))
+		return;
+
 	write_lock(&fi->ext.ext_lock);
 
 	start_fofs = fi->ext.fofs;
@@ -163,14 +170,21 @@ void update_extent_cache(block_t blk_addr, struct dnode_of_data *dn)
 					fofs - start_fofs + 1;
 			fi->ext.len -= fofs - start_fofs + 1;
 		}
-		goto end_update;
+	} else {
+		need_update = false;
 	}
-	write_unlock(&fi->ext.ext_lock);
-	return;
 
+	/* Finally, if the extent is very fragmented, let's drop the cache. */
+	if (fi->ext.len < F2FS_MIN_EXTENT_LEN) {
+		fi->ext.len = 0;
+		set_inode_flag(fi, FI_NO_EXTENT);
+		need_update = true;
+	}
 end_update:
 	write_unlock(&fi->ext.ext_lock);
-	sync_inode_page(dn);
+	if (need_update)
+		sync_inode_page(dn);
+	return;
 }
 
 struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c2de549..e9038bb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -169,6 +169,8 @@ enum {
 #define F2FS_LINK_MAX		32000	/* maximum link count per file */
 
 /* for in-memory extent cache entry */
+#define F2FS_MIN_EXTENT_LEN	16	/* minimum extent length */
+
 struct extent_info {
 	rwlock_t ext_lock;	/* rwlock for consistency */
 	unsigned int fofs;	/* start offset in a file */
@@ -889,6 +891,7 @@ enum {
 	FI_NO_ALLOC,		/* should not allocate any blocks */
 	FI_UPDATE_DIR,		/* should update inode block for consistency */
 	FI_DELAY_IPUT,		/* used for the recovery */
+	FI_NO_EXTENT,		/* not to use the extent cache */
 	FI_INLINE_XATTR,	/* used for inline xattr */
 };
 
-- 
1.8.4.474.g128a96c
